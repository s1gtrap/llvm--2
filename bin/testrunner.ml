open Common

type status =
  | Exit of int * string * string
  | Error of Unix.process_status * string * string
  | Timeout

type asserts = Exit of int | Stdout of string | Stderr of string | Timeout

module S = Map.Make (String)

let n = ref 12

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
  (!cases, !passes)

let () =
  let speclist = [ ("-n", Arg.Set_int n, "Output debug information") ] in
  let filter = ref "" in
  Arg.parse speclist (fun f -> filter := f) "tests [-n <n-regs>]";
  let tests =
    [
      ("tests/livechain.ll", "", [], [], [ Exit 20; Stdout ""; Stderr "" ]);
      ("tests/live20.ll", "", [], [], [ Exit 65; Stdout ""; Stderr "" ]);
      ("tests/live25.ll", "", [], [], [ Exit 91; Stdout ""; Stderr "" ]);
      ("tests/lshri32.ll", "", [], [], [ Exit 255; Stdout ""; Stderr "" ]);
      ("tests/literal-labels0.ll", "", [], [], [ Exit 42; Stdout ""; Stderr "" ]);
      ("tests/literal-labels1.ll", "", [], [], [ Exit 0; Stdout ""; Stderr "" ]);
      ( "tests/lshri32.ll",
        "",
        [],
        List.init 1 string_of_int,
        [ Exit 255; Stdout ""; Stderr "" ] );
      ( "tests/lshri32.ll",
        "",
        [],
        List.init 27 string_of_int,
        [ Exit 15; Stdout ""; Stderr "" ] );
      ( "tests/lshri32.ll",
        "",
        [],
        List.init 30 string_of_int,
        [ Exit 1; Stdout ""; Stderr "" ] );
      ( "tests/lshri32.ll",
        "",
        [],
        List.init 31 string_of_int,
        [ Exit 255; Stdout ""; Stderr "" ] );
      ( "tests/lshri32.ll",
        "",
        [],
        List.init 32 string_of_int,
        [ Exit 255; Stdout ""; Stderr "" ] );
      ("tests/lshri8.ll", "", [], [], [ Exit 127; Stdout ""; Stderr "" ]);
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 1 string_of_int,
        [ Exit 63; Stdout ""; Stderr "" ] );
      ("tests/lshri8.ll", "", [], [], [ Exit 127; Stdout ""; Stderr "" ]);
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 6 string_of_int,
        [ Exit 1; Stdout ""; Stderr "" ] );
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 7 (fun _ -> ""),
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 8 (fun _ -> ""),
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 30 (fun _ -> ""),
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tests/lshri8.ll",
        "",
        [],
        List.init 31 (fun _ -> ""),
        [ Exit 255; Stdout ""; Stderr "" ] );
      ( "tests/printle.ll",
        "",
        [],
        [],
        [ Exit 0; Stdout "Hello, world!\nHello, world!\nHello, world!\n" ] );
      ("tests/void.ll", "", [], [], [ Stdout "" ]);
      ("tests/zero.ll", "", [], [], [ Exit 0; Stdout "" ]);
      ("tests/one.ll", "", [], [], [ Exit 1; Stdout "" ]);
      ("tests/simplest.ll", "", [], [], [ Exit 42; Stdout "" ]);
      ("tests/helloworld0.ll", "", [], [], [ Stdout "Hello world!\n" ]);
      ("tests/helloworld1.ll", "", [], [], [ Exit 0; Stdout "Hello world!\n" ]);
      ( "tests/lorem.ll",
        "",
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
      ("tests/argc.ll", "", [], [], [ Exit 1; Stdout "" ]);
      ("tests/argc.ll", "", [], [ "two" ], [ Exit 2; Stdout "" ]);
      ("tests/argc.ll", "", [], [ "two"; "three" ], [ Exit 3; Stdout "" ]);
      ("tests/argv0.ll", "", [], [], [ Exit 1 ]);
      ("tests/argv1.ll", "", [], [ "hello" ], [ Exit 2; Stdout "hello\n" ]);
      ("tests/add.ll", "", [], [ "1"; "2" ], [ Exit 3; Stdout "" ]);
      ("tests/add.ll", "", [], [ "-13"; "12" ], [ Exit 255; Stdout "" ]);
      ( "tests/zext.ll",
        "",
        [],
        [],
        [ Exit 255; Stdout "FFFFFFFF\n000000FF\n000000FF\n" ] );
      ("tests/icmp0.ll", "", [], [], [ Exit 1 ]);
      ("tests/icmp1.ll", "", [], [], [ Exit 0 ]);
      ("tests/atoi.ll", "", [], [ "1" ], [ Exit 1; Stdout "" ]);
      ("tests/atoi.ll", "", [], [ "255" ], [ Exit 255; Stdout "" ]);
      ("tests/atoi.ll", "", [], [ "0" ], [ Exit 0; Stdout "" ]);
      ("tests/atoi.ll", "", [], [ "1" ], [ Exit 1; Stdout "" ]);
      ("tests/atoi.ll", "", [], [ "255" ], [ Exit 255; Stdout "" ]);
      ( "tests/argv2.ll",
        "",
        [],
        [ "hello"; "world" ],
        [ Exit 3; Stdout "hello\nworld\n" ] );
      ("tests/arith0.ll", "", [], [], [ Exit 6; Stdout "" ]);
      ("tests/arith1.ll", "", [], [], [ Exit 69; Stdout "" ]);
      ("tests/arith2.ll", "", [], [], [ Exit 18; Stdout "" ]);
      ("tests/loop0.ll", "", [], [], [ Exit 0; Stdout "" ]);
      ( "tests/loop1.ll",
        "",
        [],
        [],
        [ Exit 0; Stdout "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" ] );
      ("tests/loop2.ll", "", [], [], [ Timeout ]);
      ("tests/alloca.ll", "", [], [], [ Exit 42; Stdout ""; Stderr "" ]);
      ( "tests/printable.ll",
        "",
        [],
        [],
        [
          Exit 127;
          Stdout
            " \n\
             !\n\
             \"\n\
             #\n\
             $\n\
             %\n\
             &\n\
             '\n\
             (\n\
             )\n\
             *\n\
             +\n\
             ,\n\
             -\n\
             .\n\
             /\n\
             0\n\
             1\n\
             2\n\
             3\n\
             4\n\
             5\n\
             6\n\
             7\n\
             8\n\
             9\n\
             :\n\
             ;\n\
             <\n\
             =\n\
             >\n\
             ?\n\
             @\n\
             A\n\
             B\n\
             C\n\
             D\n\
             E\n\
             F\n\
             G\n\
             H\n\
             I\n\
             J\n\
             K\n\
             L\n\
             M\n\
             N\n\
             O\n\
             P\n\
             Q\n\
             R\n\
             S\n\
             T\n\
             U\n\
             V\n\
             W\n\
             X\n\
             Y\n\
             Z\n\
             [\n\
             \\\n\
             ]\n\
             ^\n\
             _\n\
             `\n\
             a\n\
             b\n\
             c\n\
             d\n\
             e\n\
             f\n\
             g\n\
             h\n\
             i\n\
             j\n\
             k\n\
             l\n\
             m\n\
             n\n\
             o\n\
             p\n\
             q\n\
             r\n\
             s\n\
             t\n\
             u\n\
             v\n\
             w\n\
             x\n\
             y\n\
             z\n\
             {\n\
             |\n\
             }\n\
             ~\n";
        ] );
      ( "tests/pipe0.ll",
        " \
         !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        [],
        [],
        [
          Exit 64;
          Stdout
            " !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_";
          Stderr "";
        ] );
      ( "tests/pipe1.ll",
        " \
         !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        [],
        [],
        [
          Exit 31;
          Stdout
            " \
             !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
          Stderr "";
        ] );
      ( "tests/pipe2.ll",
        " \
         !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~",
        [],
        [],
        [
          Exit 95;
          Stdout
            " \
             !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~";
          Stderr "";
        ] );
      ("tests/select0.ll", "", [], [], [ Exit 1; Stdout "odd"; Stderr "" ]);
      ("tests/select0.ll", "", [], [ "2" ], [ Exit 0; Stdout "even"; Stderr "" ]);
      ( "tests/select0.ll",
        "",
        [],
        [ "2"; "3" ],
        [ Exit 1; Stdout "odd"; Stderr "" ] );
      ( "tests/select0.ll",
        "",
        [],
        [ "2"; "3"; "4" ],
        [ Exit 0; Stdout "even"; Stderr "" ] );
      ( "tests/select0.ll",
        "",
        [],
        [ "2"; "3"; "4"; "5" ],
        [ Exit 1; Stdout "odd"; Stderr "" ] );
      ( "tests/collatz-phi.ll",
        "",
        [],
        [],
        [ Exit 1; Stdout "invalid arguments\n" ] );
      ("tests/select1.ll", "", [], [], [ Exit 1; Stdout "odd"; Stderr "" ]);
      ("tests/select1.ll", "", [], [ "2" ], [ Exit 0; Stdout "even"; Stderr "" ]);
      ( "tests/select1.ll",
        "",
        [],
        [ "2"; "3" ],
        [ Exit 1; Stdout "odd"; Stderr "" ] );
      ( "tests/select1.ll",
        "",
        [],
        [ "2"; "3"; "4" ],
        [ Exit 0; Stdout "even"; Stderr "" ] );
      ( "tests/select1.ll",
        "",
        [],
        [ "2"; "3"; "4"; "5" ],
        [ Exit 1; Stdout "odd"; Stderr "" ] );
      ("tests/subset.ll", "", [], [], [ Exit 1; Stdout "{ }\n" ]);
      ("tests/subset.ll", "", [], [ "1" ], [ Exit 2; Stdout "{ }\n{ 1 }\n" ]);
      ( "tests/subset.ll",
        "",
        [],
        [ "1"; "2" ],
        [ Exit 4; Stdout "{ }\n{ 1 }\n{ 2 }\n{ 1 2 }\n" ] );
      ( "tests/subset.ll",
        "",
        [],
        [ "1"; "2"; "3" ],
        [
          Exit 8;
          Stdout
            "{ }\n{ 1 }\n{ 2 }\n{ 1 2 }\n{ 3 }\n{ 1 3 }\n{ 2 3 }\n{ 1 2 3 }\n";
        ] );
      ("tests/sieven.ll", "", [], [ "1" ], [ Exit 0; Stdout "0" ]);
      ("tests/sieven.ll", "", [], [ "10" ], [ Exit 0; Stdout "4" ]);
      ("tests/sieven.ll", "", [], [ "100" ], [ Exit 0; Stdout "25" ]);
      ("tests/sieven.ll", "", [], [ "1000" ], [ Exit 0; Stdout "168" ]);
      ("tests/sieven.ll", "", [], [ "10000" ], [ Exit 0; Stdout "1229" ]);
      ("tests/sieven.ll", "", [], [ "100000" ], [ Exit 0; Stdout "9592" ]);
      ("tests/sieven.ll", "", [], [ "1000000" ], [ Exit 0; Stdout "78498" ]);
      ("tests/sieven.ll", "", [], [ "10000000" ], [ Exit 0; Stdout "664579" ]);
      ("tests/sieve-stack.ll", "", [], [ "1" ], [ Exit 0; Stdout "" ]);
      ("tests/sieve-stack.ll", "", [], [ "10" ], [ Exit 0; Stdout "2 3 5 7 " ]);
      ( "tests/sieve-stack.ll",
        "",
        [],
        [ "100" ],
        [
          Exit 0;
          Stdout
            "2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 \
             89 97 ";
        ] );
      ("tests/sieve-heap.ll", "", [], [ "1" ], [ Exit 0; Stdout "" ]);
      ("tests/sieve-heap.ll", "", [], [ "10" ], [ Exit 0; Stdout "2 3 5 7 " ]);
      ( "tests/sieve-heap.ll",
        "",
        [],
        [ "100" ],
        [
          Exit 0;
          Stdout
            "2 3 5 7 11 13 17 19 23 29 31 37 41 43 47 53 59 61 67 71 73 79 83 \
             89 97 ";
        ] );
      ("tests/square0.ll", "", [], [], [ Exit 1; Stdout ""; Stderr "" ]);
      ("tests/square0.ll", "", [], [ "2" ], [ Exit 4; Stdout ""; Stderr "" ]);
      ( "tests/square0.ll",
        "",
        [],
        [ "2"; "3" ],
        [ Exit 9; Stdout ""; Stderr "" ] );
      ( "tests/square0.ll",
        "",
        [],
        [ "2"; "3"; "4" ],
        [ Exit 16; Stdout ""; Stderr "" ] );
      ("tests/factori32.ll", "", [], [ "2" ], [ Exit 1; Stdout "2 " ]);
      ("tests/factori32.ll", "", [], [ "3" ], [ Exit 1; Stdout "3 " ]);
      ("tests/factori32.ll", "", [], [ "4" ], [ Exit 2; Stdout "2 2 " ]);
      ("tests/factori32.ll", "", [], [ "5" ], [ Exit 1; Stdout "5 " ]);
      ( "tests/factori32.ll",
        "",
        [],
        [ "5040" ],
        [ Exit 8; Stdout "2 2 2 2 3 3 5 7 " ] );
      ( "tests/factori32.ll",
        "",
        [],
        [ "5040" ],
        [ Exit 8; Stdout "2 2 2 2 3 3 5 7 " ] );
      ( "tests/factori32.ll",
        "",
        [],
        [ "268435399" ],
        [ Exit 1; Stdout "268435399 " ] );
      ( "tests/factori32.ll",
        "",
        [],
        [ "536870909" ],
        [ Exit 1; Stdout "536870909 " ] );
      ( "tests/factori32.ll",
        "",
        [],
        [ "1073741789" ],
        [ Exit 1; Stdout "1073741789 " ] );
      ( "tests/factori32.ll",
        "",
        [],
        [ "2147483647" ],
        [ Exit 1; Stdout "2147483647 " ] );
      ("tests/factori64.ll", "", [], [ "2" ], [ Exit 1; Stdout "2 " ]);
      ("tests/factori64.ll", "", [], [ "3" ], [ Exit 1; Stdout "3 " ]);
      ("tests/factori64.ll", "", [], [ "4" ], [ Exit 2; Stdout "2 2 " ]);
      ("tests/factori64.ll", "", [], [ "5" ], [ Exit 1; Stdout "5 " ]);
      ( "tests/factori64.ll",
        "",
        [],
        [ "5040" ],
        [ Exit 8; Stdout "2 2 2 2 3 3 5 7 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "5040" ],
        [ Exit 8; Stdout "2 2 2 2 3 3 5 7 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "268435399" ],
        [ Exit 1; Stdout "268435399 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "536870909" ],
        [ Exit 1; Stdout "536870909 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "1073741789" ],
        [ Exit 1; Stdout "1073741789 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "2147483647" ],
        [ Exit 1; Stdout "2147483647 " ] );
      ( "tests/factori64.ll",
        "",
        [],
        [ "18446744073709551615" ],
        [ Exit 7; Stdout "3 5 17 257 641 65537 6700417 " ] );
      ( "tests/collatz-phi.ll",
        "",
        [],
        [],
        [ Exit 1; Stdout "invalid arguments\n" ] );
      ("tests/collatz-phi.ll", "", [], [ "1" ], [ Exit 0; Stdout "1\n" ]);
      ("tests/collatz-phi.ll", "", [], [ "2" ], [ Exit 0; Stdout "2\n1\n" ]);
      ( "tests/collatz-phi.ll",
        "",
        [],
        [ "3" ],
        [ Exit 0; Stdout "3\n10\n5\n16\n8\n4\n2\n1\n" ] );
      ( "tests/collatz-phi.ll",
        "",
        [],
        [ "1312" ],
        [
          Exit 0;
          Stdout
            "1312\n\
             656\n\
             328\n\
             164\n\
             82\n\
             41\n\
             124\n\
             62\n\
             31\n\
             94\n\
             47\n\
             142\n\
             71\n\
             214\n\
             107\n\
             322\n\
             161\n\
             484\n\
             242\n\
             121\n\
             364\n\
             182\n\
             91\n\
             274\n\
             137\n\
             412\n\
             206\n\
             103\n\
             310\n\
             155\n\
             466\n\
             233\n\
             700\n\
             350\n\
             175\n\
             526\n\
             263\n\
             790\n\
             395\n\
             1186\n\
             593\n\
             1780\n\
             890\n\
             445\n\
             1336\n\
             668\n\
             334\n\
             167\n\
             502\n\
             251\n\
             754\n\
             377\n\
             1132\n\
             566\n\
             283\n\
             850\n\
             425\n\
             1276\n\
             638\n\
             319\n\
             958\n\
             479\n\
             1438\n\
             719\n\
             2158\n\
             1079\n\
             3238\n\
             1619\n\
             4858\n\
             2429\n\
             7288\n\
             3644\n\
             1822\n\
             911\n\
             2734\n\
             1367\n\
             4102\n\
             2051\n\
             6154\n\
             3077\n\
             9232\n\
             4616\n\
             2308\n\
             1154\n\
             577\n\
             1732\n\
             866\n\
             433\n\
             1300\n\
             650\n\
             325\n\
             976\n\
             488\n\
             244\n\
             122\n\
             61\n\
             184\n\
             92\n\
             46\n\
             23\n\
             70\n\
             35\n\
             106\n\
             53\n\
             160\n\
             80\n\
             40\n\
             20\n\
             10\n\
             5\n\
             16\n\
             8\n\
             4\n\
             2\n\
             1\n";
        ] );
      ( "tests/collatz-mut.ll",
        "",
        [],
        [],
        [ Exit 1; Stdout "invalid arguments\n" ] );
      ("tests/collatz-mut.ll", "", [], [ "1" ], [ Exit 0; Stdout "1\n" ]);
      ("tests/collatz-mut.ll", "", [], [ "2" ], [ Exit 0; Stdout "2\n1\n" ]);
      ( "tests/collatz-mut.ll",
        "",
        [],
        [ "3" ],
        [ Exit 0; Stdout "3\n10\n5\n16\n8\n4\n2\n1\n" ] );
      ( "tests/collatz-mut.ll",
        "",
        [],
        [ "1312" ],
        [
          Exit 0;
          Stdout
            "1312\n\
             656\n\
             328\n\
             164\n\
             82\n\
             41\n\
             124\n\
             62\n\
             31\n\
             94\n\
             47\n\
             142\n\
             71\n\
             214\n\
             107\n\
             322\n\
             161\n\
             484\n\
             242\n\
             121\n\
             364\n\
             182\n\
             91\n\
             274\n\
             137\n\
             412\n\
             206\n\
             103\n\
             310\n\
             155\n\
             466\n\
             233\n\
             700\n\
             350\n\
             175\n\
             526\n\
             263\n\
             790\n\
             395\n\
             1186\n\
             593\n\
             1780\n\
             890\n\
             445\n\
             1336\n\
             668\n\
             334\n\
             167\n\
             502\n\
             251\n\
             754\n\
             377\n\
             1132\n\
             566\n\
             283\n\
             850\n\
             425\n\
             1276\n\
             638\n\
             319\n\
             958\n\
             479\n\
             1438\n\
             719\n\
             2158\n\
             1079\n\
             3238\n\
             1619\n\
             4858\n\
             2429\n\
             7288\n\
             3644\n\
             1822\n\
             911\n\
             2734\n\
             1367\n\
             4102\n\
             2051\n\
             6154\n\
             3077\n\
             9232\n\
             4616\n\
             2308\n\
             1154\n\
             577\n\
             1732\n\
             866\n\
             433\n\
             1300\n\
             650\n\
             325\n\
             976\n\
             488\n\
             244\n\
             122\n\
             61\n\
             184\n\
             92\n\
             46\n\
             23\n\
             70\n\
             35\n\
             106\n\
             53\n\
             160\n\
             80\n\
             40\n\
             20\n\
             10\n\
             5\n\
             16\n\
             8\n\
             4\n\
             2\n\
             1\n";
        ] );
      ( "tests/crc32b-debug.ll",
        "",
        [],
        [],
        [
          Stdout
            "crc32b \n\
             var10 = 00000000\n\
             crc32b \n\
             var11 = 00000000\n\
             var13 = 00000000\n\
             var14 = 00000000\n\
             var46 = 00000000\n\
             result of crc32b = 00000000\n\
             crc32b a\n\
             var10 = 00000000\n\
             crc32b a\n\
             var11 = 00000000\n\
             var13 = 00000061\n\
             var14 = 00000061\n\
             var19 = 00000000\n\
             var22 = 00000061\n\
             var25 = FFFFFF9E\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7FFFFFCF\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D2477CC7\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 849B3D43\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = AFF51D81\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = BA420DE0\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 5D2106F0\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 2E908378\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 174841BC\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000001\n\
             var10 = 00000001\n\
             crc32b a\n\
             var11 = 00000001\n\
             var13 = 00000000\n\
             var14 = 00000000\n\
             var46 = E8B7BE43\n\
             result of crc32b = E8B7BE43\n\
             crc32b 123456789\n\
             var10 = 00000000\n\
             crc32b 123456789\n\
             var11 = 00000000\n\
             var13 = 00000031\n\
             var14 = 00000031\n\
             var19 = 00000000\n\
             var22 = 00000031\n\
             var25 = FFFFFFCE\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7FFFFFE7\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D2477CD3\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 849B3D49\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = AFF51D84\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 57FA8EC2\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 2BFD4761\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F8462090\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7C231048\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000001\n\
             var10 = 00000001\n\
             crc32b 123456789\n\
             var11 = 00000001\n\
             var13 = 00000032\n\
             var14 = 00000032\n\
             var19 = 00000001\n\
             var22 = 00000032\n\
             var25 = 7C23107A\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 3E11883D\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F2B0473E\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7958239F\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D11492EF\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 8532CA57\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = AF21E60B\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = BA287025\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = B0ACBB32\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000002\n\
             var10 = 00000002\n\
             crc32b 123456789\n\
             var11 = 00000002\n\
             var13 = 00000033\n\
             var14 = 00000033\n\
             var19 = 00000002\n\
             var22 = 00000033\n\
             var25 = B0ACBB01\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = B5EEDEA0\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 5AF76F50\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 2D7BB7A8\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 16BDDBD4\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 0B5EEDEA\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 05AF76F5\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = EF6F385A\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 77B79C2D\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000003\n\
             var10 = 00000003\n\
             crc32b 123456789\n\
             var11 = 00000003\n\
             var13 = 00000034\n\
             var14 = 00000034\n\
             var19 = 00000003\n\
             var22 = 00000034\n\
             var25 = 77B79C19\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D6634D2C\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 6B31A696\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 3598D34B\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F774EA85\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 9602F662\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 4B017B31\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = C8383EB8\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 641C1F5C\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000004\n\
             var10 = 00000004\n\
             crc32b 123456789\n\
             var11 = 00000004\n\
             var13 = 00000035\n\
             var14 = 00000035\n\
             var19 = 00000004\n\
             var22 = 00000035\n\
             var25 = 641C1F69\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = DFB68C94\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 6FDB464A\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 37EDA325\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F64E52B2\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7B272959\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D02B178C\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 68158BC6\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 340AC5E3\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000005\n\
             var10 = 00000005\n\
             crc32b 123456789\n\
             var11 = 00000005\n\
             var13 = 00000036\n\
             var14 = 00000036\n\
             var19 = 00000005\n\
             var22 = 00000036\n\
             var25 = 340AC5D5\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F7BDE1CA\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7BDEF0E5\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D057FB52\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 682BFDA9\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D9AD7DF4\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 6CD6BEFA\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 366B5F7D\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F68D2C9E\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000006\n\
             var10 = 00000006\n\
             crc32b 123456789\n\
             var11 = 00000006\n\
             var13 = 00000037\n\
             var14 = 00000037\n\
             var19 = 00000006\n\
             var22 = 00000037\n\
             var25 = F68D2CA9\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 96FE1574\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 4B7F0ABA\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 25BF855D\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = FF67418E\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7FB3A0C7\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D2615343\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 84882A81\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = AFFC9660\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000007\n\
             var10 = 00000007\n\
             crc32b 123456789\n\
             var11 = 00000007\n\
             var13 = 00000038\n\
             var14 = 00000038\n\
             var19 = 00000007\n\
             var22 = 00000038\n\
             var25 = AFFC9658\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 57FE4B2C\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 2BFF2596\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 15FF92CB\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = E7474A45\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = 9E1B2602\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 4F0D9301\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = CA3E4AA0\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 651F2550\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000008\n\
             var10 = 00000008\n\
             crc32b 123456789\n\
             var11 = 00000008\n\
             var13 = 00000039\n\
             var14 = 00000039\n\
             var19 = 00000008\n\
             var22 = 00000039\n\
             var25 = 651F2569\n\
             var27 = 00000007\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = DF371194\n\
             var40 = 00000006\n\
             var27 = 00000006\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 6F9B88CA\n\
             var40 = 00000005\n\
             var27 = 00000005\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 37CDC465\n\
             var40 = 00000004\n\
             var27 = 00000004\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = F65E6112\n\
             var40 = 00000003\n\
             var27 = 00000003\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 7B2F3089\n\
             var40 = 00000002\n\
             var27 = 00000002\n\
             var28 = 00000001\n\
             var31 = 00000001\n\
             var32 = FFFFFFFF\n\
             var36 = EDB88320\n\
             var37 = D02F1B64\n\
             var40 = 00000001\n\
             var27 = 00000001\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 68178DB2\n\
             var40 = 00000000\n\
             var27 = 00000000\n\
             var28 = 00000001\n\
             var31 = 00000000\n\
             var32 = 00000000\n\
             var36 = 00000000\n\
             var37 = 340BC6D9\n\
             var40 = FFFFFFFF\n\
             var27 = FFFFFFFF\n\
             var28 = 00000000\n\
             var43 = 00000009\n\
             var10 = 00000009\n\
             crc32b 123456789\n\
             var11 = 00000009\n\
             var13 = 00000000\n\
             var14 = 00000000\n\
             var46 = CBF43926\n";
        ] );
      ("tests/crc32b.ll", "", [], [ "" ], [ Exit 0; Stdout "00000000" ]);
      ( "tests/crc32b.ll",
        "",
        [],
        [ "Hello, world!" ],
        [ Exit 0; Stdout "Hello, world!EBE6C6E6" ] );
      ( "tests/crc32b.ll",
        "",
        [],
        [ "Hello, world!\n" ],
        [ Exit 0; Stdout "Hello, world!\n7B55A718" ] );
      ("tests/fib.ll", "", [], [ "0" ], [ Exit 0; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "1" ], [ Exit 1; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "2" ], [ Exit 1; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "3" ], [ Exit 2; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "4" ], [ Exit 3; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "5" ], [ Exit 5; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "6" ], [ Exit 8; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "7" ], [ Exit 13; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "8" ], [ Exit 21; Stdout ""; Stderr "" ]);
      ("tests/fib.ll", "", [], [ "9" ], [ Exit 34; Stdout ""; Stderr "" ]);
      ("tests/fib0.ll", "", [], [], [ Stdout ""; Stderr "" ]);
      ("tests/fib1.ll", "", [], [ "34" ], [ Stdout ""; Stderr "" ]);
      ( "tests/sha256.ll",
        "",
        [],
        [ "" ],
        [
          Exit 0;
          Stdout
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
          Stderr "";
        ] );
      ( "tests/sha256.ll",
        "",
        [],
        [ "a" ],
        [
          Exit 0;
          Stdout
            "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb";
          Stderr "";
        ] );
      ( "tests/sha256.ll",
        "",
        [],
        [ "Hello, world!" ],
        [
          Exit 0;
          Stdout
            "315f5bdb76d078c43b8ac0064e4a0164612b1fce77c869345bfc94c75894edd3";
          Stderr "";
        ] );
      ( "tests/sha256-stdin.ll",
        "",
        [],
        [],
        [
          Exit 0;
          Stdout
            "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855";
          Stderr "";
        ] );
      ( "tests/sha256-stdin.ll",
        "a",
        [],
        [],
        [
          Exit 0;
          Stdout
            "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb";
          Stderr "";
        ] );
      ( "tests/sha256-stdin.ll",
        "Hello, world!",
        [],
        [],
        [
          Exit 0;
          Stdout
            "315f5bdb76d078c43b8ac0064e4a0164612b1fce77c869345bfc94c75894edd3";
          Stderr "";
        ] );
      ("tests/sudoku-stack.ll", "4 2  1         3", [], [ "2" ], [ Exit 0 ]);
      ( "tests/sudoku-stack.ll",
        "745 9     3215  46   28 5 32      6 98 6  351   54 2 73 8     2 2 76  \
         1  6 9 8 34",
        [],
        [ "3" ],
        [ Exit 0 ] );
      (*( "tests/sudoku-stack.ll",
        "  c  b3        73ed46 g c 9f2 15fa 897 2   5 c g 5b      28 3e 9  8b \
         9f 2ca 67g   a e2 8  f  3  e 4f7 6g   98   21  c3bd 6g  a9 a2  f15b \
         94  g8 5 fcg 23   ad     9 8c 7  1  2    71 e9 d85 c4f  fe      42 96 \
         847 526 1   b d ec61a3 7 g d8b 42  2  fe        c                    ",
        [],
        [ "4" ],
        [ Exit 0; Stdout "" ] );*)
      ( "dolphintests/_prog_01.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "5\n"; Stderr "" ] );
      ( "dolphintests/_prog_02.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "6\n"; Stderr "" ] );
      ( "dolphintests/_prog_03.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "11\n"; Stderr "" ] );
      ( "dolphintests/_prog_04.ll",
        "0",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 1\n"; Stderr "" ] );
      ( "dolphintests/_prog_04.ll",
        "1",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 2\n"; Stderr "" ] );
      ( "dolphintests/_prog_04.ll",
        "42",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 43\n"; Stderr "" ] );
      ( "dolphintests/_prog_05.ll",
        "69",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 70\n"; Stderr "" ] );
      ( "dolphintests/_prog_05.ll",
        "100",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 101\n"; Stderr "" ] );
      ( "dolphintests/_prog_05.ll",
        "101",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: "; Stderr "" ] );
      ( "dolphintests/_prog_06.ll",
        "100",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: 101\n"; Stderr "" ] );
      ( "dolphintests/_prog_06.ll",
        "1337",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "Please enter an integer: -1\n"; Stderr "" ] );
      ( "dolphintests/_prog_09.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_15.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_16.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_17.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_18.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_19.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_20.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "10\n10\n10\n10\n10\n"; Stderr "" ] );
      ( "dolphintests/_prog_22.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_23.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_24.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_25.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_26.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_27.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_28.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_31.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_32.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "dolphintests/_prog_33.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout "10\n"; Stderr "" ] );
      ( "dolphintests/_prog_36.ll",
        "",
        [ "dolphin.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ("tigertests/zero.tig.ll", "", [ "tiger.c" ], [], [ Exit 0; Stdout "" ]);
      ( "tigertests/test12.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/arith.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 2; Stdout ""; Stderr "" ] );
      ( "tigertests/nil_seq_last_ok.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test63.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test55.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 9; Stdout ""; Stderr "" ] );
      ( "tigertests/test59.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test47.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tigertests/lexer_ascii.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/readonly_overwrite.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test5.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/seqorder.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "12345"; Stderr "" ] );
      ( "tigertests/emoji_comment.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 42; Stdout ""; Stderr "" ] );
      ( "tigertests/recFieldError.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [
          Exit 1;
          Stdout "";
          Stderr "Error: record field lookup applied to nil\n";
        ] );
      ( "tigertests/test61.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test73.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "OK."; Stderr "" ] );
      ( "tigertests/forfor.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "............"; Stderr "" ] );
      ("tigertests/ddd.tig.ll", "", [ "tiger.c" ], [], [ Stdout ""; Stderr "" ]);
      ( "tigertests/test57.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test3.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test53.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test30.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test41.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tigertests/test69.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 48; Stdout ""; Stderr "" ] );
      ( "tigertests/test65.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/goodarith.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 5; Stdout ""; Stderr "" ] );
      ( "tigertests/lots_of_locals.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/dynarray.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test51.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test67.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 1; Stdout ""; Stderr "" ] );
      ("tigertests/test75.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/test1.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/divorder.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/lexer_ascii_alt.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/zero.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 0; Stdout ""; Stderr "" ] );
      ( "tigertests/test4.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test8.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test54.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 4; Stdout ""; Stderr "" ] );
      (*("tigertests/binary_tree.tig.ll","", [ "tiger.c" ], [], []);*)
      ( "tigertests/test37.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test46.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/test58.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/test62.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/queens.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/seq_nested_empty.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test27.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      (*("tigertests/fixedpoints.tig.ll","", [ "tiger.c" ], [], []);*)
      ( "tigertests/test44.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test48.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ("tigertests/doors.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/test56.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 9; Stdout ""; Stderr "" ] );
      ("tigertests/split.tig.ll", "", [ "tiger.c" ], [], []);
      ( "tigertests/test60.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      (*("tigertests/test72.tig.ll","", [ "tiger.c" ], [], []);*)
      ( "tigertests/divbyzero.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "Error: division by zero\n" ] );
      ( "tigertests/lexer_formfeed.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/if_readonly.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test68.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test76.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "abcdefghijklmnopqrstuvwxyz0123456789"; Stderr "" ] );
      ( "tigertests/brainfuck.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "Hello World!\n\n"; Stderr "" ] );
      ( "tigertests/test64.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test52.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/lisp.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [
          Stdout
            "The dummy input is:\n\
             (letrec ((collatz (lambda (v) (progn (print v) (ifb (= v 1) \
             (progn (newline) 1) (progn (print \" -> \") (ifb (= v (* (/ v 2) \
             2)) (collatz (/ v 2)) (collatz (+ (* v 3) 1))))))))) (collatz \
             117))\n\
            \ (progn (print \"bye bye\") (newline))\n\
            \ (progn (print \"exiting...\") (newline) (exit))\n\
             Let's spin the REPL... use (exit) if you get too dizzy\n\
             >>> Standard library loaded\n\
             ()\n\
             >>> 117 -> 352 -> 176 -> 88 -> 44 -> 22 -> 11 -> 34 -> 17 -> 52 \
             -> 26 -> 13 -> 40 -> 20 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2 -> 1\n\
             1\n\
             >>> bye bye\n\
             ()\n\
             >>> exiting...\n";
          Stderr "";
        ] );
      ( "tigertests/color.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout "[44mHello[0m\nBye\n[34mHello[0m"; Stderr "" ] );
      ( "tigertests/test2.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/div213.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/simplevar.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test66.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
      ( "tigertests/test74.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Exit 24; Stdout ""; Stderr "" ] );
      ( "tigertests/test42.tig.ll",
        "",
        [ "tiger.c" ],
        [],
        [ Stdout ""; Stderr "" ] );
    ]
  in
  let cases, passes = run tests !filter in
  Printf.printf "passed [%d/%d]\n" passes cases
