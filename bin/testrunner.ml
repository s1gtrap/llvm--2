(*open Unix

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
    Printf.printf "done!\n"*)

let create_process_with_input command args input_string _f =
  let ic, oc = Unix.pipe () in
  let oc = Unix.out_channel_of_descr oc in
  output_string oc input_string;
  close_out oc;
  let input = ic in
  let pid =
    Unix.create_process_env command args [||] input Unix.stdout Unix.stderr
  in
  Printf.printf "fin!\n";
  let _ = Unix.waitpid [] pid in
  Printf.printf "fin!\n";
  ()

let compile_test test =
  let fn : string = Filename.temp_file "" "" in
  Printf.printf "%s\n" fn;
  let prog : string =
    In_channel.open_text test
    |> Llvm__2.Parse.from_channel Llvm__2.Llparser.prog
    |> Llvm__2.Regalloc.compile_prog |> Llvm__2.Regalloc.string_of_prog
  in

  let _ =
    create_process_with_input "arch"
      [| "arch"; "-x86_64"; "clang"; "-x"; "assembler"; "-"; "-o"; fn |]
      prog fn
  in
  fn

let () =
  let fn : string = compile_test "tests/helloworld0.ll" in
  Printf.printf "%s\n" fn;
  Printf.printf "ok!\n";
  let _ = create_process_with_input "sleep" [| "sleep"; "2" |] "" fn in
  Printf.printf "ok!\n"

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

(*let () =
  let _ = create_process_with_input "cat" (Array.of_list [ "cat" ]) "sdf" in
  run
    [
      ("tests/helloworld0.ll", [], [ Stdout "Hello world!" ]);
      ("tests/helloworld1.ll", [], [ Exit 0; Stdout "Hello world!" ]);
      (*("tests/fprintf.ll", [], [ Exit 0; Stdout ""; Stderr "Hello stderr!" ]);*)
    ]*)
