type status =
  | Exit of int * string * string
  | Error of Unix.process_status * string * string
  | Timeout

type asserts = Exit of int | Stdout of string | Stderr of string | Timeout

exception CompileError

module S = Map.Make (String)

let execs = ref S.empty

let string_of_process_status (s : Unix.process_status) =
  match s with
  | WEXITED code -> Printf.sprintf "WEXITED %d" code
  | WSIGNALED code -> Printf.sprintf "WSIGNALED %d" code
  | WSTOPPED code -> Printf.sprintf "WSTOPPED %d" code

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

  flush stdout;
  let oc = Unix.out_channel_of_descr stdin_write in
  output_string oc input;
  close_out oc;
  let pid =
    Unix.create_process_env "timeout"
      (Array.concat [ [| "timeout"; "5" |]; [| command |]; args ])
      (Unix.environment ()) stdin_read stdout_write stderr_write
  in
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

let run tests =
  let passes = ref 0 in
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
      match execute exc args "" with
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
            Printf.printf " %sok!\n%s" green nc)
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
                    Printf.printf "%s   +%s%s\n" green (String.escaped l1) nc;
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
          Printf.printf "%sruntime error!%s %s\n  exit code: %s\n" red nc exc
            (string_of_process_status s)
      | Error (s, _, stderr) ->
          Printf.printf "%sruntime error!%s %s\n  exit code: %s\n  stdout: %s\n"
            red nc exc
            (string_of_process_status s)
            stderr
      | Timeout -> Printf.printf "%stimeout!%s %s\n" red nc exc
    with CompileError -> Printf.printf "%scompile error!%s\n" red nc
  in
  List.iter r tests;
  !passes

let () =
  let tests =
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
      ("tests/loop2.ll", [], [], [ Timeout ]);
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
      ( "tigertests/test69.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 48; Stdout ""; Stderr "" ] );
      ("tigertests/test65.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/goodarith.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 5; Stdout ""; Stderr "" ] );
      ( "tigertests/lots_of_locals.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/dynarray.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test51.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test67.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 1; Stdout ""; Stderr "" ] );
      ("tigertests/test75.tig.ll", [ "tiger.c" ], [], []);
      ("tigertests/test1.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/divorder.tig.ll", [ "tiger.c" ], [], []);
      ( "tigertests/lexer_ascii_alt.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/zero.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ("tigertests/test4.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test8.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test54.tig.ll",
        [ "tiger.c" ],
        [],
        [ Exit 4; Stdout ""; Stderr "" ] );
      (*("tigertests/binary_tree.tig.ll", [ "tiger.c" ], [], []);*)
      ("tigertests/test37.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
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
      ("tigertests/test76.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      (*( "tigertests/brainfuck.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );*)
      ("tigertests/test64.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/test52.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ("tigertests/lisp.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/color.tig.ll",
        [ "tiger.c" ],
        [],
        [ Stdout "[44mHello[0m\nBye\n[34mHello[0m"; Stderr "" ] );
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
      ("tigertests/test42.tig.ll", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
    ]
  in
  let passes = run tests in
  Printf.printf "[%d/%d]" passes (List.length tests)
