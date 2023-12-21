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
  let stdout_read, stdout_write = Unix.pipe () in
  let ic = Unix.in_channel_of_descr stdout_read in
  let exit =
    exec_with_timeout process args timeout input stdout_write Unix.stderr
  in
  Unix.close stdout_write;
  let stdout = In_channel.input_all ic in
  close_in ic;
  (exit, stdout, "")

let clang t args =
  let outfile = Filename.temp_file "" "" in

  let args =
    match Llvm__2.Regalloc.os with
    | Linux -> [ t; "-o"; outfile ] @ args
    | Darwin ->
        [
          "-Wno-override-module";
          "-target";
          "x86_64-unknown-darwin";
          t;
          "-o";
          outfile;
        ]
        @ args
  in
  exec "clang" args "" Unix.stdout Unix.stderr |> ignore;
  outfile

let _compilers = [ Common.Tiger; Common.Llvm__2 (Briggs 2) ]
let compilers = [ Common.Llvm__2 (Greedy 12) ]

let t ?(stdin = "") ?(cargs = []) ?(timeout = 5) t args counts =
  let exe = clang t cargs in
  let expexit, expout, experr =
    exec_with_timeout_and_capture exe args timeout stdin
  in
  let test (total, passes) c =
    Printf.printf "[%s] testing %s ... " (Common.string_of_compiler c) t;
    flush stdout;
    let exe = Common.compile_test c t (Array.of_list cargs) in
    let gotexit, gotout, goterr =
      exec_with_timeout_and_capture exe args timeout stdin
    in
    if expexit <> gotexit || expout <> gotout || experr <> goterr then (
      Printf.printf "failed!\n";
      if expexit <> gotexit then
        Printf.printf " got %s, expected %s\n" (string_of_status gotexit)
          (string_of_status expexit);
      (total + 1, passes))
    else (
      Printf.printf "ok!\n";
      flush stdout;
      (total + 1, passes + 1))
  in
  List.fold_left test counts compilers

let () =
  let print (t, p) = Printf.printf "[ %d / %d ]\n" p t in
  (0, 0) |> t "tests/void.ll" [] |> t "tests/zero.ll" [] |> t "tests/one.ll" []
  |> t "tests/simplest.ll" []
  |> t "tests/add.ll" [ "1"; "2" ]
  |> t "tests/add.ll" [ "-13"; "12" ]
  |> t "tests/argc.ll" []
  |> t "tests/argc.ll" [ "two" ]
  |> t "tests/argc.ll" [ "two"; "three" ]
  |> t "tests/argc.ll" [ "2"; "3"; "4" ]
  |> t "tests/arith0.ll" [] |> t "tests/arith1.ll" [] |> t "tests/arith2.ll" []
  |> t "tests/literal-labels0.ll" []
  |> t "tests/literal-labels1.ll" []
  |> t "tests/lshri8.ll" []
  |> t "tests/lshri8.ll" (List.init 1 string_of_int)
  |> t "tests/lshri8.ll" (List.init 6 string_of_int)
  |> t "tests/lshri8.ll" (List.init 7 string_of_int)
  |> t "tests/lshri8.ll" (List.init 8 string_of_int)
  |> t "tests/lshri8.ll" (List.init 30 string_of_int)
  |> t "tests/lshri32.ll" []
  |> t "tests/lshri32.ll" (List.init 1 string_of_int)
  |> t "tests/lshri32.ll" (List.init 7 string_of_int)
  |> t "tests/lshri32.ll" (List.init 27 string_of_int)
  |> t "tests/lshri32.ll" (List.init 30 string_of_int)
  |> t "tests/lshri32.ll" (List.init 31 string_of_int)
  |> t "tests/lshri32.ll" (List.init 31 string_of_int)
  |> t "tests/alloca.ll" [] (* FIXME: allocan *)
  |> t "tests/loop0.ll" [] |> t "tests/loop1.ll" [] |> t "tests/loop2.ll" []
  |> t "tests/argv0.ll" []
  |> t "tests/argv1.ll" [ "hello," ]
  |> t "tests/argv2.ll" [ "Hello,"; "world!" ]
  |> t "tests/atoi.ll" []
  |> t "tests/atoi.ll" [ "hello," ]
  |> t "tests/atoi.ll" [ "0" ] |> t "tests/atoi.ll" [ "1" ]
  |> t "tests/atoi.ll" [ "-2" ]
  |> t "tests/atoi.ll" [ "127" ]
  |> t "tests/atoi.ll" [ "255" ]
  |> t "tests/helloworld0.ll" []
  |> t "tests/icmp0.ll" [] |> t "tests/icmp1.ll" []
  |> t "tests/helloworld1.ll" []
  |> t "tests/pipe0.ll" []
       ~stdin:
         " \
          !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  |> t "tests/pipe1.ll" []
       ~stdin:
         " \
          !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  |> t "tests/pipe2.ll" []
       ~stdin:
         " \
          !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  |> t "tests/select0.ll" []
  |> t "tests/select0.ll" [ "2" ]
  |> t "tests/select0.ll" [ "2"; "3" ]
  |> t "tests/select0.ll" [ "2"; "3"; "4" ]
  |> t "tests/select0.ll" [ "2"; "3"; "4"; "5" ]
  |> t "tests/select1.ll" []
  |> t "tests/select1.ll" [ "2" ]
  |> t "tests/select1.ll" [ "2"; "3" ]
  |> t "tests/select1.ll" [ "2"; "3"; "4" ]
  |> t "tests/select1.ll" [ "2"; "3"; "4"; "5" ]
  |> t "tests/zext.ll" [] |> t "tests/square0.ll" []
  |> t "tests/square0.ll" [ "2" ]
  |> t "tests/square0.ll" [ "2"; "3" ]
  |> t "tests/square0.ll" [ "2"; "3"; "4" ]
  |> t "tests/square0-debug.ll" []
  |> t "tests/square0-debug.ll" [ "2" ]
  |> t "tests/square0-debug.ll" [ "2"; "3" ]
  |> t "tests/square0-debug.ll" [ "2"; "3"; "4" ]
  |> t "tests/lorem.ll" [] |> t "tests/fib.ll" [ "0" ]
  |> t "tests/fib.ll" [ "1" ] |> t "tests/fib.ll" [ "2" ]
  |> t "tests/fib.ll" [ "3" ] |> t "tests/fib.ll" [ "4" ]
  |> t "tests/fib.ll" [ "5" ] |> t "tests/fib.ll" [ "6" ]
  |> t "tests/fib.ll" [ "7" ] |> t "tests/fib.ll" [ "8" ]
  |> t "tests/fib.ll" [ "9" ] |> t "tests/fib0.ll" [] |> t "tests/fib1.ll" []
  |> t "tests/printable.ll" [] |> t "tests/live20.ll" []
  |> t "tests/live25.ll" []
  |> t "tests/collatz-phi.ll" [ "1" ]
  |> t "tests/collatz-phi.ll" [ "2" ]
  |> t "tests/collatz-phi.ll" [ "3" ]
  |> t "tests/collatz-phi.ll" [ "1312" ]
  |> t "tests/collatz-mut.ll" [ "1" ]
  |> t "tests/collatz-mut.ll" [ "2" ]
  |> t "tests/collatz-mut.ll" [ "3" ]
  |> t "tests/collatz-mut.ll" [ "1312" ]
  |> t "tests/printle.ll" [] |> t "tests/crc32b.ll" [ "" ]
  |> t "tests/crc32b.ll" [ "Hello, world!" ]
  |> t "tests/crc32b.ll" [ "Hello, world!\n" ]
  |> t "tests/crc32b-debug.ll" [ "" ]
  (*|> t "tests/crc32b-debug.ll" [ "Hello, world!" ]
    |> t "tests/crc32b-debug.ll" [ "Hello, world!\n" ]*)
  |> t "tests/subset.ll" []
  |> t "tests/subset.ll" [ "1" ]
  |> t "tests/subset.ll" [ "1"; "2" ]
  |> t "tests/subset.ll" [ "1"; "2"; "3" ]
  |> t "tests/factori32.ll" [ "2" ]
  |> t "tests/factori32.ll" [ "3" ]
  |> t "tests/factori32.ll" [ "4" ]
  |> t "tests/factori32.ll" [ "5" ]
  |> t "tests/factori32.ll" [ "5040" ]
  |> t "tests/factori32.ll" [ "5040" ]
  |> t "tests/factori32.ll" [ "268435399" ]
  |> t "tests/factori32.ll" [ "536870909" ]
  |> t "tests/factori32.ll" [ "1073741789" ]
  |> t "tests/factori32.ll" [ "2147483647" ]
  |> t "tests/factori64.ll" [ "2" ]
  |> t "tests/factori64.ll" [ "3" ]
  |> t "tests/factori64.ll" [ "4" ]
  |> t "tests/factori64.ll" [ "5" ]
  |> t "tests/factori64.ll" [ "5040" ]
  |> t "tests/factori64.ll" [ "5040" ]
  |> t "tests/factori64.ll" [ "268435399" ]
  |> t "tests/factori64.ll" [ "536870909" ]
  |> t "tests/factori64.ll" [ "1073741789" ]
  |> t "tests/factori64.ll" [ "2147483647" ]
  |> t "tests/factori64.ll" [ "18446744073709551615" ]
  |> t "tests/sieven.ll" [ "1" ]
  |> t "tests/sieven.ll" [ "10" ]
  |> t "tests/sieven.ll" [ "100" ]
  |> t "tests/sieven.ll" [ "1000" ]
  |> t "tests/sieven.ll" [ "10000" ]
  |> t "tests/sieven.ll" [ "100000" ]
  |> t "tests/sieven.ll" [ "1000000" ]
  |> t "tests/sieven.ll" [ "10000000" ]
  |> t "tests/sieve-stack.ll" [ "1" ]
  |> t "tests/sieve-stack.ll" [ "10" ]
  |> t "tests/sieve-stack.ll" [ "100" ]
  |> t "tests/sieve-heap.ll" [ "1" ]
  |> t "tests/sieve-heap.ll" [ "10" ]
  |> t "tests/sieve-heap.ll" [ "100" ]
  |> t "tests/sudoku-stack.ll" [ "2" ] ~stdin:"4 2  1         3"
  |> t "tests/sudoku-stack.ll" [ "3" ]
       ~stdin:
         "745 9     3215  46   28 5 32      6 98 6  351   54 2 73 8     2 2 \
          76  1  6 9 8 34"
  |> t "tests/sha256.ll" [ "" ]
  |> t "tests/sha256.ll" [ "a" ]
  |> t "tests/sha256.ll" [ "Hello, world!" ]
  |> t "tests/sha256-stdin.ll" [] ~stdin:""
  |> t "tests/sha256-stdin.ll" [] ~stdin:"a"
  |> t "tests/sha256-stdin.ll" [] ~stdin:"Hello, world!"
  |> t "dolphintests/_prog_01.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_02.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_03.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_04.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_05.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_06.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_09.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_15.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_16.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_17.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_18.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_19.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_20.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_22.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_23.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_24.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_25.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_26.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_27.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_28.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_31.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_32.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_33.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_36.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "tigertests/arith.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/binary_tree.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/brainfuck.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/color.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/ddd.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/div213.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/divbyzero.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/divorder.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/doors.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/dynarray.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/emoji_comment.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/fixedpoints.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/forfor.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/goodarith.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/if_readonly.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/lexer_ascii.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/lexer_ascii_alt.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/lexer_formfeed.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/lisp.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/lots_of_locals.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/nil_seq_last_ok.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/queens.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/readonly_overwrite.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/recFieldError.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/seq_nested_empty.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/seqorder.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/simplevar.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/split.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test1.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test12.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test2.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test27.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test3.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test30.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test37.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test4.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test41.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test42.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test44.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test46.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test47.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test48.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test5.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test51.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test52.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test53.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test54.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test55.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test56.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test57.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test58.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test59.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test60.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test61.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test62.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test63.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test64.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test65.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test66.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test67.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test68.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test69.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test72.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test73.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test74.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test75.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test76.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/test8.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> t "tigertests/zero.tig.ll" [] ~cargs:[ "tiger.c" ]
  |> print
(*t "tests/add.ll" [ "1"; "2" ] Exit;
  t "tests/loop2.ll" [] Timeout;
  t "tests/dolphin/_f.ll" [] ~cargs:[ "-c"; "tests/dolphin/runtime.c" ] Exit*)
