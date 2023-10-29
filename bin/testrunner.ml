type asserts = Exit of int | Stdout of string

let create_process_with_input command args input_string _f =
  let ic, oc = Unix.pipe () in
  let oc = Unix.out_channel_of_descr oc in
  output_string oc input_string;
  close_out oc;
  let input = ic in
  let pid =
    Unix.create_process_env command args [||] input Unix.stdout Unix.stderr
  in
  let _ = Unix.waitpid [] pid in
  ()

let capture_stdout command args =
  flush stdout;
  let in_read, _in_write = Unix.pipe () in
  let stdout_read, stdout_write = Unix.pipe () in
  let _stderr, stderr_write = Unix.pipe () in

  let pid =
    Unix.create_process_env command
      (Array.concat [ [| command |]; args ])
      [||] in_read stdout_write stderr_write
  in

  Unix.close in_read;
  Unix.close stdout_write;

  let output = ref "" in
  let buffer = Bytes.create 1024 in

  let rec read_output () =
    flush stdout;
    let len = Unix.read stdout_read buffer 0 1024 in
    flush stdout;
    if len > 0 then (
      output := !output ^ Bytes.sub_string buffer 0 len;
      read_output ())
  in

  read_output ();

  Unix.close stdout_read;

  let _, status = Unix.waitpid [] pid in
  (status, !output, "")

let compile_test test =
  let fn : string = Filename.temp_file "" "" in
  let prog : string =
    In_channel.open_text test
    |> Llvm__2.Parse.from_channel Llvm__2.Llparser.prog
    |> Llvm__2.Regalloc.compile_prog |> Llvm__2.Regalloc.string_of_prog
  in
  let _ =
    (match Llvm__2.Regalloc.os with
    | Darwin ->
        create_process_with_input "arch"
          [| "arch"; "-x86_64"; "clang"; "-x"; "assembler"; "-"; "-o"; fn |]
    | Linux -> create_process_with_input "printenv" [| "printenv" |])
      prog fn
  in
  fn

let _execute_with_timeout command timeout =
  let pid = Unix.fork () in
  if pid = 0 then
    (* This is the child process *)
    let _ = create_process_with_input command [| "xxd" |] "sdasd" "" in
    exit 0
  else
    (* This is the parent process *)
    try
      let () = ignore (Unix.alarm timeout) in
      let _, status = Unix.waitpid [] pid in
      match status with
      | WEXITED 0 -> Printf.printf "Command succeeded\n"
      | WEXITED code -> Printf.printf "Command failed with exit code %d\n" code
      | _ -> Printf.printf "Command terminated abnormally\n"
    with Unix.Unix_error (EINTR, _, _) ->
      Printf.printf "Command timed out after %d seconds\n" timeout;
      Unix.kill pid Sys.sigkill

let exec exc args = capture_stdout exc args
(*execute_with_timeout "xxd" 5*)

let run tests =
  let r (file, args, asserts) =
    Printf.printf "%s ... " file;
    let exc = compile_test file in
    let exit, stdout, _stderr = exec exc args in
    List.iter
      (function
        | Exit code ->
            if exit <> Unix.WEXITED code then Printf.printf "exit failed! "
        | Stdout s -> if s <> stdout then Printf.printf "stdout failed! ")
      asserts;
    Printf.printf " done!\n"
  in
  (*let r (file, _args, _asserts) =
      let s =
        let ic = open_in file in
        try
          let s = really_input_string ic (in_channel_length ic) in
          close_in ic;
          s
        with e -> raise e
      in
      Printf.printf "%s\n" s
    in*)
  List.iter r tests;
  Printf.printf "done!\n"

(*let () =
  let fn : string = compile_test "tests/helloworld0.ll" in
  Printf.printf "%s\n" fn;
  Printf.printf "ok!\n"*)

(* Handle the process status as needed *)

(*let create_process_with_input command args input_string =
  let stdin_pipe_out, stdin_pipe_in = pipe () in
  let pid = create_process command args stdin_pipe_in stdout stderr in

  (* Replace the child process's stdin with the write-end of the pipe *)
  dup2 stdin_pipe_out stdin;

  (* Close the write-end of the pipe in the parent process *)
  close stdin_pipe_out;

  (* Write the input string to the child process's stdin *)
  let output_channel = out_channel_of_descr stdin in
  output_string output_channel input_string;
  close_out output_channel;

  (* Wait for the child process to complete *)
  let _, status = waitpid [] pid in

  status*)

let () =
  run
    [
      ("tests/helloworld0.ll", [||], [ Stdout "Hello world!\n" ]);
      ("tests/helloworld1.ll", [||], [ Exit 0; Stdout "Hello world!\n" ]);
      ("tests/argc.ll", [||], [ Exit 1 ]);
      ("tests/argc.ll", [| "two" |], [ Exit 2 ]);
      ("tests/argc.ll", [| "two"; "three" |], [ Exit 3 ]);
      (*("tests/fprintf.ll", [], [ Exit 0; Stdout ""; Stderr "Hello stderr!" ]);*)
    ]
