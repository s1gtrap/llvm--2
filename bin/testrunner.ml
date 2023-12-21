(*open Common

  type status =
      | Exit of int * string * string
      | Error of Unix.process_status * string * string
      | Timeout

    type asserts = Exit of int | Stdout of string | Stderr of string | Timeout

    module S = Map.Make (String)

    let n = ref 12


    let _string_of_status (s : status) =
      match s with
      | Exit (code, stdout, stderr) ->
          Printf.sprintf "Exit (%d, \"%s\", \"%s\")" code (String.escaped stdout)
            (String.escaped stderr)
      | Error (code, stdout, stderr) ->
          Printf.sprintf "Error (%s, \"%s\", \"%s\")"
            (string_of_process_status code)
            (String.escaped stdout) (String.escaped stderr)
      | Timeout -> "Timeout"

    let execute command args (input : string) : status =
      let stdin_read, stdin_write = Unix.pipe () in
      let stdout_read, stdout_write = Unix.pipe () in
      let stderr_read, stderr_write = Unix.pipe () in

      let oc = Unix.out_channel_of_descr stdin_write in
      output_string oc input;
      close_out oc;
      let pid =
        Unix.create_process_env "timeout"
          (Array.concat [ [| "timeout"; "5" |]; [| command |]; args ])
          (Unix.environment ()) stdin_read stdout_write stderr_write
      in
      Unix.close stdin_read;

      let status = Unix.waitpid [] pid in

      Unix.close stdout_write;
      let stdout = ref "" in
      let buffer = Bytes.create 1024 in
      let rec read_output () =
        let len = Unix.read stdout_read buffer 0 1024 in
        if len > 0 then (
          stdout := !stdout ^ Bytes.sub_string buffer 0 len;
          read_output ())
      in
      (try read_output () with _ -> ());
      Unix.close stdout_read;

      Unix.close stderr_write;
      let stderr = ref "" in
      let buffer = Bytes.create 1024 in
      let rec read_output () =
        let len = Unix.read stderr_read buffer 0 1024 in
        if len > 0 then (
          stderr := !stderr ^ Bytes.sub_string buffer 0 len;
          read_output ())
      in
      (try read_output () with _ -> ());
      Unix.close stderr_read;

      match status with
      | _, WEXITED 124 ->
          (* timeout *)
          Timeout
      | _, WEXITED code -> Exit (code, !stdout, !stderr)
      | _, WSIGNALED code -> Error (WSIGNALED code, !stdout, !stderr)
      | _, WSTOPPED code -> Error (WSTOPPED code, !stdout, !stderr)

    let run tests filter =
      let cases = ref 0 in
      let passes = ref 0 in
      let r (file, stdin, cargs, args, asserts) =
        let cargs = Array.of_list cargs in
        let args = Array.of_list args in
        let red = "\027[0;31m" in
        let green = "\027[1;32m" in
        let muted = "\027[1;39m" in
        let nc = "\027[0m" in
        let filter = Str.regexp_string filter in
        let matches s =
          try
            let _ = Str.search_forward filter s 0 in
            true
          with _ -> false
        in
        let run_ c =
          let alc = string_of_compiler c in
          if matches alc || matches file then (
            Printf.printf "%s[%s]%s %s ... " muted alc nc file;
            flush stdout;
            cases := !cases + 1;
            try
              let exc = compile_test c file cargs in
              match execute exc args stdin with
              | Exit (exit, stdout, stderr) ->
                  let rec assert_ = function
                    | Exit code :: tail -> exit = code && assert_ tail
                    | Stdout s :: tail -> s = stdout && assert_ tail
                    | Stderr s :: tail -> s = stderr && assert_ tail
                    | Timeout :: tail -> false && assert_ tail
                    | [] -> true
                  in
                  if assert_ asserts then (
                    passes := !passes + 1;
                    Printf.printf "%sok!\n%s" green nc)
                  else
                    let print_diff s1 s2 =
                      let s1 = String.split_on_char '\n' s1 in
                      let s2 = String.split_on_char '\n' s2 in
                      let rec diff s1 s2 =
                        match (s1, s2) with
                        | l1 :: t1, l2 :: t2 when l1 = l2 ->
                            Printf.printf "    %s\n" (String.escaped l1);
                            diff t1 t2
                        | l1 :: t1, l2 :: t2 ->
                            Printf.printf "%s   +%s\n%s   -%s%s\n" green
                              (String.escaped l1) red (String.escaped l2) nc;
                            diff t1 t2
                        | l1 :: t1, [] ->
                            Printf.printf "%s   +%s%s\n" green (String.escaped l1)
                              nc;
                            diff t1 []
                        | [], l2 :: t2 ->
                            Printf.printf "%s   -%s%s\n" red (String.escaped l2) nc;
                            diff [] t2
                        | [], [] -> ()
                      in
                      diff s1 s2
                    in
                    let rec assert_ = function
                      | Exit code :: tail ->
                          if exit <> code then
                            Printf.printf "  exit failed: %d != %d\n" exit code;
                          assert_ tail
                      | Stdout s :: tail ->
                          if s <> stdout then (
                            Printf.printf "  stdout failed:\n";
                            print_diff stdout s);
                          assert_ tail
                      | Stderr s :: tail ->
                          if s <> stderr then (
                            Printf.printf "  stderr failed:\n";
                            print_diff stderr s);
                          assert_ tail
                      | Timeout :: tail ->
                          Printf.printf "  finished before timeout!\n";
                          assert_ tail
                      | [] -> ()
                    in
                    Printf.printf " %sfailed!%s %s\n" red nc exc;
                    assert_ asserts
              | Error (s, _, "") ->
                  Printf.printf "%sruntime error!%s %s\n  exit code: %s\n" red nc
                    exc
                    (string_of_process_status s)
              | Error (s, _, stderr) ->
                  Printf.printf
                    "%sruntime error!%s %s\n  exit code: %s\n  stdout: %s\n" red nc
                    exc
                    (string_of_process_status s)
                    stderr
              | Timeout ->
                  Printf.printf "%stimeout!%s %s\n"
                    (match
                       List.find_opt
                         (function Timeout -> true | _ -> false)
                         asserts
                     with
                    | Some _ ->
                        passes := !passes + 1;
                        green
                    | None -> red)
                    nc exc
            with CompileError -> Printf.printf "%scompile error!%s\n" red nc)
        in
        run_ Clang;
        run_ Tiger;
        run_ (Llvm__2 (Llvm__2.Regalloc.Greedy !n));
        run_ (Llvm__2 (Llvm__2.Regalloc.Simple !n));
        run_ (Llvm__2 (Llvm__2.Regalloc.Briggs !n));
        run_ (Llvm__2 Llvm__2.Regalloc.Linearscan)
      in
      List.iter r tests;
      (!cases, !passes)*)

let _exec process args stdin stdout stderr =
  (*
      let stdin_read, stdin_write = Unix.pipe () in
      let stdout_read, stdout_write = Unix.pipe () in
      let stderr_read, stderr_write = Unix.pipe () in

      let oc = Unix.out_channel_of_descr stdin_write in
      output_string oc input;
      close_out oc;
      let pid =
        Unix.create_process_env "timeout"
          (Array.concat [ [| "timeout"; "5" |]; [| command |]; args ])
          (Unix.environment ()) stdin_read stdout_write stderr_write
      in
      Unix.close stdin_read;
      *)
  let stdin_in, stdin_out = Unix.pipe () in
  let stdin_out_chan = Unix.out_channel_of_descr stdin_out in
  Out_channel.output_string stdin_out_chan stdin;
  let pid =
    Unix.create_process_env process (Array.of_list args) (Unix.environment ())
      stdin_in stdout stderr
  in
  Unix.close stdin_in;
  let exit = Unix.waitpid [] pid in
  Unix.close stdin_out;
  exit

let string_of_process_status (s : Unix.process_status) =
  match s with
  | WEXITED code -> Printf.sprintf "WEXITED %d" code
  | WSIGNALED code -> Printf.sprintf "WSIGNALED %d" code
  | WSTOPPED code -> Printf.sprintf "WSTOPPED %d" code

type status = Exit of Unix.process_status | Timeout

let string_of_status = function
  | Timeout -> "timeout"
  | Exit c -> "exit" ^ string_of_process_status c

let exec process args input stdout stderr =
  let args = Array.of_list args |> Array.append [| process |] in
  let env = Unix.environment () in
  let stdin_read, stdin_write = Unix.pipe () in
  let oc = Unix.out_channel_of_descr stdin_write in
  output_string oc input;
  close_out oc;
  let pid = Unix.create_process_env process args env stdin_read stdout stderr in
  Unix.close stdin_read;
  let _, stat = Unix.waitpid [] pid in
  stat

let exec_with_timeout process args timeout input stdout stderr =
  let args = [ string_of_int timeout; process ] @ args in
  match exec "timeout" args input stdout stderr with
  | WEXITED 124 -> Timeout
  | stat -> Exit stat

let exec_with_timeout_and_capture process args timeout input =
  (exec_with_timeout process args timeout input Unix.stdout Unix.stderr, "", "")

let clang t args =
  let outfile = Filename.temp_file "" "" in
  exec "clang" ((t :: [ "-o"; outfile ]) @ args) "" Unix.stdout Unix.stderr
  |> ignore;
  outfile

let t ?(stdin = "") ?(cargs = []) ?(timeout = 5) t args =
  let exe = clang t cargs in
  let expexit, expout, experr =
    exec_with_timeout_and_capture exe args timeout stdin
  in
  List.iter
    (fun c ->
      let exe = Common.compile_test c t (Array.of_list cargs) in
      let gotexit, gotout, goterr =
        exec_with_timeout_and_capture exe args timeout stdin
      in
      if expexit <> gotexit || expout <> gotout || experr <> goterr then (
        Printf.printf "failed:\n";
        if expexit <> gotexit then
          Printf.printf " got %s, expected %s\n" (string_of_status gotexit)
            (string_of_status expexit))
      else Printf.printf "ok!\n";
      flush stdout)
    [ Common.Tiger; Common.Llvm__2 (Briggs 2) ]

let () =
  let _ = exec "xxd" [] "sdf" Unix.stdout Unix.stderr in
  let f = clang "tests/add.ll" [] in
  Printf.printf "%s\n" f;
  t "tests/add.ll" [ "1"; "2" ];
  t "tests/loop2.ll" [];
  ()
(*t "tests/add.ll" [ "1"; "2" ] Exit;
  t "tests/loop2.ll" [] Timeout;
  t "tests/dolphin/_f.ll" [] ~cargs:[ "-c"; "tests/dolphin/runtime.c" ] Exit*)
