open Unix

type asserts = Exit of int | Stdout of string

let run tests =
  let r (file, _args, _asserts) =
    let ic = open_in file in
    let _exc = Llvm__2.Build.executable ic Unix.stdout in
    ()
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

let create_process_with_input command args input_string =
  let stdin_pipe_out, stdin_pipe_in = pipe () in
  let pid = create_process command args stdin_pipe_in stdout stderr in

  (* Write the input string to the child process's stdin *)
  let output_channel = out_channel_of_descr stdin_pipe_out in
  output_string output_channel input_string;
  close_out output_channel;

  close stdin_pipe_in;

  (* Close the input end of the pipe in the parent process *)

  (* Wait for the child process to complete *)
  let _, status = waitpid [] pid in

  status

let () =
  let _ = create_process_with_input "cat" (Array.of_list [ "cat" ]) "sdf" in
  run
    [
      ("tests/helloworld0.ll", [], [ Stdout "Hello world!" ]);
      ("tests/helloworld1.ll", [], [ Exit 0; Stdout "Hello world!" ]);
      (*("tests/fprintf.ll", [], [ Exit 0; Stdout ""; Stderr "Hello stderr!" ]);*)
    ]
