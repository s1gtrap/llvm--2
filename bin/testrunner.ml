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
  Printf.printf "compiling %s\n" test;
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
    let red = "\027[0;31m" in
    let green = "\027[1;32m" in
    (*let muted = "\033[1;30m" in*)
    let nc = "\027[0m" in
    Printf.printf "%s ... " file;
    let exc = compile_test file in
    let exit, stdout, _stderr = exec exc args in
    let rec assert_ = function
      | Exit code :: tail -> exit = Unix.WEXITED code && assert_ tail
      | Stdout s :: tail -> s = stdout && assert_ tail
      | [] -> true
    in
    if assert_ asserts then Printf.printf " %sok!\n%s" green nc
    else
      let rec assert_ = function
        | Exit code :: tail ->
            if exit <> Unix.WEXITED code then
              Printf.printf "  exit failed: %s != WEXITED %d\n"
                (match exit with
                | WEXITED c -> Printf.sprintf "WEXITED %d" c
                | WSIGNALED c -> Printf.sprintf "WSIGNALED %d" c
                | WSTOPPED c -> Printf.sprintf "WSTOPPED %d" c)
                code;
            assert_ tail
        | Stdout s :: tail ->
            let print_diff s1 s2 =
              let s1 = String.split_on_char '\n' s1 in
              let s2 = String.split_on_char '\n' s2 in
              let rec diff s1 s2 =
                match (s1, s2) with
                | l1 :: t1, l2 :: t2 when l1 = l2 ->
                    Printf.printf "    %s\n" l1;
                    diff t1 t2
                | l1 :: t1, l2 :: t2 ->
                    Printf.printf "%s   +%s\n%s   -%s%s\n" green l1 red l2 nc;
                    diff t1 t2
                | l1 :: t1, [] ->
                    Printf.printf "%s   +%s%s\n" green l1 nc;
                    diff t1 []
                | [], l2 :: t2 ->
                    Printf.printf "%s   -%s%s\n" red l2 nc;
                    diff [] t2
                | [], [] -> ()
              in
              diff s1 s2
            in
            if s <> stdout then (
              Printf.printf "  stdout failed:\n";
              print_diff s stdout);
            assert_ tail
        | [] -> ()
      in
      Printf.printf " %sfailed!\n%s" red nc;
      assert_ asserts
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
      ("tests/zero.ll", [||], [ Exit 0; Stdout "" ]);
      ("tests/helloworld0.ll", [||], [ Stdout "Hello world!\n" ]);
      ("tests/helloworld1.ll", [||], [ Exit 0; Stdout "Hello world!\n" ]);
      ( "tests/lorem.ll",
        [||],
        [
          Exit 0;
          Stdout
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut \
             tempus viverra est, in posuere justo porttitor sit amet. Duis \
             vitae nulla eget neque cursus vulputate id vel leo. Nulla et \
             pellentesque nulla. Etiam sed vulputate risus. Sed tempus varius \
             est, quis sollicitudin lectus semper tempus. Fusce a ante \
             egestas, fringilla purus mollis, volutpat neque. Ut eget nisi ut \
             turpis ullamcorper lacinia. Pellentesque volutpat ultrices massa \
             in sagittis. Integer aliquam vel ligula vitae pellentesque. Sed \
             ut neque aliquet, rhoncus ex sit amet, tristique erat. Nullam \
             porta, mauris vel tincidunt porta, eros ex sagittis lectus, \
             gravida ultricies lorem ipsum eget nisl. Vivamus commodo velit \
             convallis velit luctus, eu luctus leo suscipit. Pellentesque \
             tellus leo, feugiat vel feugiat id, viverra a tellus. Fusce vitae \
             malesuada nibh, a aliquam magna. Curabitur tortor ligula, \
             sollicitudin vel sodales sed, gravida eu turpis.\n\n\
             Duis malesuada erat et leo ultrices vestibulum. Pellentesque nec \
             viverra nisi, eu viverra tortor. Curabitur facilisis blandit leo \
             in aliquam. Proin mattis ultricies euismod. Proin vehicula nulla \
             velit, a viverra leo aliquet at. Mauris ornare sit amet odio id \
             vestibulum. Nulla blandit pretium ipsum, accumsan pharetra augue \
             scelerisque at. Morbi lobortis leo at cursus fermentum. Cras eget \
             ultrices orci. Integer convallis ante erat, et bibendum dui \
             luctus ac. Duis convallis a lectus feugiat ullamcorper. Etiam \
             blandit, leo at gravida viverra, urna diam hendrerit massa, at \
             vestibulum magna nunc sed ex. Aenean interdum dolor sit amet \
             rhoncus commodo. Maecenas bibendum placerat risus, quis \
             ullamcorper quam rutrum non.\n\n\
             Pellentesque non libero pretium, efficitur tortor sit amet, \
             sollicitudin mauris. Duis tincidunt eros et nulla volutpat \
             vestibulum. Nullam augue purus, pulvinar non accumsan ut, \
             condimentum quis arcu. Maecenas faucibus, erat sit amet lacinia \
             gravida, nisl lorem sagittis ipsum, vel ultricies neque purus ac \
             risus. Curabitur vitae dapibus erat, eu ornare sapien. Phasellus \
             ultricies magna ut lectus tincidunt, id elementum enim commodo. \
             Curabitur consectetur nisl a mollis aliquam. Nunc imperdiet \
             tellus ut sagittis dictum. Morbi placerat, diam et auctor dictum, \
             odio risus dapibus massa, eu bibendum elit nibh sed elit. Integer \
             quis tempor odio, nec posuere ex. Suspendisse condimentum odio at \
             erat luctus rutrum id tincidunt erat. Sed dictum est eu metus \
             commodo, sed rhoncus enim pulvinar. Nam sit amet dapibus odio, \
             vel vehicula arcu. Vestibulum non urna vehicula, sollicitudin \
             nisl id, efficitur tellus.\n\n\
             Nulla ac dolor ligula. Sed a purus imperdiet, mollis est in, \
             porttitor neque. Praesent pulvinar nisi turpis, nec fringilla \
             tortor varius in. Vivamus ultricies dictum rhoncus. Praesent sed \
             lacus tortor. Proin fermentum a libero vitae cursus. Cras egestas \
             diam nec accumsan varius. Sed ut sodales nulla. Aliquam molestie \
             ac turpis non gravida. Sed scelerisque, erat a feugiat vulputate, \
             dolor felis placerat urna, ac efficitur eros tortor tristique \
             mauris. Donec pulvinar nisl quis lacus suscipit, in feugiat nisl \
             ullamcorper. Phasellus non cursus eros. Nunc scelerisque lobortis \
             justo at feugiat. Proin augue enim, convallis vel dui aliquet, \
             accumsan pellentesque justo. Praesent ex sapien, viverra quis leo \
             id, euismod pulvinar sem.\n\n\
             Duis aliquet, elit eu porta aliquam, lectus mauris finibus arcu, \
             at molestie justo enim sed diam. Integer sed risus eget enim \
             sodales facilisis. Nulla facilisi. Aliquam in nisi sit amet lorem \
             elementum mattis. In hac habitasse platea dictumst. Morbi \
             ultricies risus non luctus convallis. Cras luctus sem ut tortor \
             eleifend semper. Vivamus varius sit amet arcu non placerat. Morbi \
             sed tellus semper, porta est vel, imperdiet felis. Sed tempus \
             facilisis faucibus. Sed sed massa ante. Duis eu eleifend neque. \
             Mauris eleifend enim lorem, eu laoreet lectus dignissim at.\n";
        ] );
      ("tests/argc.ll", [||], [ Exit 1; Stdout "" ]);
      ("tests/argc.ll", [| "two" |], [ Exit 2; Stdout "" ]);
      ("tests/argc.ll", [| "two"; "three" |], [ Exit 3; Stdout "" ]);
      (*("tests/fprintf.ll", [], [ Exit 0; Stdout ""; Stderr "Hello stderr!" ]);*)
    ]
