type asserts = Exit of int | Stdout of string | Stderr of string

exception CompileError

let _capture_stdout command args =
  flush stdout;
  let in_read, _in_write = Unix.pipe () in
  let stdout_read, stdout_write = Unix.pipe () in
  let _stderr, stderr_write = Unix.pipe () in

  let pid =
    Unix.create_process_env command
      (Array.concat [ [| command |]; args ])
      (Unix.environment ()) in_read stdout_write stderr_write
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

let execute_with_timeout command args timeout :
    (Unix.process_status * string * string) option =
  let read_pipe, write_pipe = Unix.pipe () in
  let in_read, _in_write = Unix.pipe () in
  let stdout_read, stdout_write = Unix.pipe () in
  let stderr_read, stderr_write = Unix.pipe () in
  let out_stderr_write = Unix.out_channel_of_descr stderr_write in

  flush stdout;
  let pid = Unix.fork () in
  match pid with
  | 0 -> (
      Unix.close read_pipe;
      Unix.dup2 write_pipe Unix.stdout;

      (* This is the child process *)
      (*let _ = capture_stdout command args in*)
      let pid =
        Unix.create_process_env command
          (Array.concat [ [| command |]; args ])
          (Unix.environment ()) in_read stdout_write stderr_write
      in
      let _, status = Unix.waitpid [] pid in
      match status with
      | WEXITED code -> exit code
      | WSIGNALED code ->
          Printf.fprintf out_stderr_write "exited with WSIGNALED %d" code;
          exit 255
      | WSTOPPED code ->
          Printf.fprintf out_stderr_write "exited with WSTOPPED %d" code;
          exit 255)
  | pid -> (
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

      Unix.close stderr_write;
      let output2 = ref "" in
      let buffer = Bytes.create 1024 in
      let rec read_output2 () =
        let len = Unix.read stderr_read buffer 0 1024 in
        if len > 0 then (
          output2 := !output2 ^ Bytes.sub_string buffer 0 len;
          read_output2 ())
      in
      read_output2 ();
      Unix.close stderr_read;

      (* This is the parent process *)
      try
        let () = ignore (Unix.alarm timeout) in
        let _, status = Unix.waitpid [] pid in
        match status with
        | WEXITED _code ->
            (*Printf.eprintf "exited with WEXITED %d" code;*)
            Some (status, !output, !output2)
        | WSIGNALED _code ->
            (*Printf.eprintf "exited with WSIGNALED %d" code;*)
            Some (status, !output, !output2)
        | WSTOPPED _code ->
            (*Printf.eprintf "exited with WSTOPPED %d" code;*)
            Some (status, !output, !output2)
      with _ ->
        Unix.kill pid Sys.sigkill;
        None)

module S = Map.Make (String)

let execs = ref S.empty

let compile_test test cargs =
  match S.find_opt test !execs with
  | Some fn -> fn
  | None ->
      let fn : string = Filename.temp_file "" "" in
      let prog : string =
        try
          In_channel.open_text test
          |> Llvm__2.Parse.from_channel Llvm__2.Llparser.prog
          |> Llvm__2.Regalloc.compile_prog |> Llvm__2.Regalloc.string_of_prog
        with _ -> raise CompileError
      in
      let _ =
        (match Llvm__2.Regalloc.os with
        | Darwin ->
            Llvm__2.Build.create_process_with_input "arch"
              (Array.concat
                 [
                   [| "arch"; "-x86_64"; "clang" |];
                   cargs;
                   [| "-x"; "assembler"; "-"; "-o"; fn |];
                 ])
        | Linux ->
            Llvm__2.Build.create_process_with_input "clang"
              (Array.concat
                 [
                   [| "clang" |]; cargs; [| "-x"; "assembler"; "-"; "-o"; fn |];
                 ]))
          prog fn
      in
      execs := S.add test fn !execs;
      fn

let exec exc args = execute_with_timeout exc args 10000
(*execute_with_timeout "xxd" 5*)

let run tests =
  let r (file, cargs, args, asserts) =
    let cargs = Array.of_list cargs in
    let args = Array.of_list args in
    let red = "\027[0;31m" in
    let green = "\027[1;32m" in
    (*let muted = "\033[1;30m" in*)
    let nc = "\027[0m" in
    Printf.printf "%s ... " file;
    flush stdout;
    try
      let exc = compile_test file cargs in
      match exec exc args with
      | Some (exit, stdout, stderr) ->
          let rec assert_ = function
            | Exit code :: tail -> exit = Unix.WEXITED code && assert_ tail
            | Stdout s :: tail -> s = stdout && assert_ tail
            | Stderr s :: tail -> s = stderr && assert_ tail
            | [] -> true
          in
          if assert_ asserts then Printf.printf " %sok!\n%s" green nc
          else
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
            let rec assert_ = function
              | Exit code :: tail ->
                  if exit <> Unix.WEXITED code then
                    Printf.printf "  exit failed: %s != %d\n"
                      (match exit with
                      | WEXITED c -> string_of_int c
                      | WSIGNALED c -> Printf.sprintf "WSIGNALED %d" c
                      | WSTOPPED c -> Printf.sprintf "WSTOPPED %d" c)
                      code;
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
              | [] -> ()
            in
            Printf.printf " %sfailed!%s %s\n" red nc exc;
            assert_ asserts
      | None -> Printf.printf "%stimeout!%s\n" red nc
    with CompileError -> Printf.printf "%scompile error!%s\n" red nc
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
  List.iter r tests

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
      ("tests/void.ll", [], [], [ Stdout "" ]);
      ("tests/zero.ll", [], [], [ Exit 0; Stdout "" ]);
      ("tests/one.ll", [], [], [ Exit 1; Stdout "" ]);
      ("tests/simplest.ll", [], [], [ Exit 42; Stdout "" ]);
      ("tests/helloworld0.ll", [], [], [ Stdout "Hello world!\n" ]);
      ("tests/helloworld1.ll", [], [], [ Exit 0; Stdout "Hello world!\n" ]);
      ( "tests/lorem.ll",
        [],
        [],
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
      ("tests/argc.ll", [], [], [ Exit 1; Stdout "" ]);
      ("tests/argc.ll", [], [ "two" ], [ Exit 2; Stdout "" ]);
      ("tests/argc.ll", [], [ "two"; "three" ], [ Exit 3; Stdout "" ]);
      ("tests/arith0.ll", [], [], [ Exit 6; Stdout "" ]);
      ("tests/arith1.ll", [], [], [ Exit 69; Stdout "" ]);
      ("tests/loop0.ll", [], [], [ Exit 0; Stdout "" ]);
      ( "tests/loop1.ll",
        [],
        [],
        [ Exit 0; Stdout "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" ] );
      ("tigertests/zero.tig.ll", [ "tiger.c" ], [], [ Exit 0; Stdout "" ]);
      ("tigertests/test12.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/arith.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 2; Stdout ""; Stderr "" ] );
      ( "tigertests/nil_seq_last_ok.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/test63.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test55.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 9; Stdout ""; Stderr "" ] );
      ("tigertests/test59.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test47.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tigertests/lexer_ascii.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 255; Stdout ""; Stderr "" ] );
      ( "tigertests/readonly_overwrite.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/test5.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/seqorder.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout "12345"; Stderr "" ] );
      ( "tigertests/emoji_comment.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 42; Stdout ""; Stderr "" ] );
      ( "tigertests/recFieldError.tig.ll",
        [ "tiger.c" ],
        [],
        [
          Exit 1;
          Stdout "";
          Stderr "Error: record field lookup applied to nil\n";
        ] );
      ("tigertests/test61.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test73.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout "OKNot OK"; Stderr "" ] );
      ( "tigertests/forfor.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout "............"; Stderr "" ] );
      ("tigertests/ddd.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test57.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test3.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test53.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test30.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test41.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      (*( "tigertests/test69.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 48; Stdout ""; Stderr "" ] );*)
      (*("tigertests/test65.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*( "tigertests/goodarith.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 5; Stdout ""; Stderr "" ] );*)
      (*( "tigertests/lots_of_locals.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );*)
      (*("tigertests/dynarray.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*("tigertests/test51.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*( "tigertests/test67.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 1; Stdout ""; Stderr "" ] );*)
      (*("tigertests/test75.tig.ll", [ "tiger.c" ], [], []);*)
      (*("tigertests/test1.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*("tigertests/divorder.tig.ll", [ "tiger.c" ], [], []);*)
      (*( "tigertests/lexer_ascii_alt.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );*)
      (*( "tigertests/zero.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );*)
      (*("tigertests/test4.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*("tigertests/test8.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
      (*("tigertests/binary_tree.tig.ll", [ "tiger.c" ], [], []);*)
      (*( "tigertests/test54.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 4; Stdout ""; Stderr "" ] );*)
      (*("tigertests/test37.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/test46.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/test58.tig.ll", [ "tiger.c" ], [], []);
        ("tigertests/test62.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/queens.tig.ll", [ "tiger.c" ], [], []);
        ( "tigertests/seq_nested_empty.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "" ] );
        ("tigertests/test27.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        (*("tigertests/fixedpoints.tig.ll", [ "tiger.c" ], [], []);*)
        ("tigertests/test44.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/test48.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/doors.tig.ll", [ "tiger.c" ], [], []);
        ( "tigertests/test56.tig.ll",
          [ "tiger.c" ],
          [],
          [ Exit 9; Stdout ""; Stderr "" ] );
        ("tigertests/split.tig.ll", [ "tiger.c" ], [], []);
        ("tigertests/test60.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        (*("tigertests/test72.tig.ll", [ "tiger.c" ], [], []);*)
        ( "tigertests/divbyzero.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "Error: division by zero\n" ] );
        ( "tigertests/lexer_formfeed.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "" ] );
        ( "tigertests/if_readonly.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "" ] );
        ("tigertests/test68.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        (*("tigertests/test76.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
        (*( "tigertests/brainfuck.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "" ] );*)
        ("tigertests/test64.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/test52.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        (*("tigertests/lisp.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
        ("tigertests/color.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/test2.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ("tigertests/div213.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ( "tigertests/simplevar.tig.ll",
          [ "tiger.c" ],
          [],
          [ Stdout ""; Stderr "" ] );
        ("tigertests/test66.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
        ( "tigertests/test74.tig.ll",
          [ "tiger.c" ],
          [],
          [ Exit 24; Stdout ""; Stderr "" ] );
        ("tigertests/test42.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);*)
    ]
