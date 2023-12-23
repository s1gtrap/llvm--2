open Common

let string_of_process_status (s : Unix.process_status) =
  match s with
  | WEXITED code -> Printf.sprintf "WEXITED %d" code
  | WSIGNALED code -> Printf.sprintf "WSIGNALED %d" code
  | WSTOPPED code -> Printf.sprintf "WSTOPPED %d" code

type status = Exit of Unix.process_status | Timeout

let string_of_status = function
  | Timeout -> "timeout"
  | Exit c -> string_of_process_status c

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
  let stdout_ic, stdout_oc = Unix.pipe () in
  let stdout_ic = Unix.in_channel_of_descr stdout_ic in
  (*let stderr_ic, stderr_oc = Unix.pipe () in
    let stderr_ic = Unix.in_channel_of_descr stderr_ic in*)
  let exit =
    exec_with_timeout process args timeout input stdout_oc Unix.stderr
  in
  Unix.close stdout_oc;
  let stdout = In_channel.input_all stdout_ic in
  (*Unix.close stderr_oc;
    let stderr = In_channel.input_all stderr_ic in*)
  close_in stdout_ic;
  (exit, stdout, "")

let compilers =
  [
    Common.Tiger;
    Common.Llvm__2 (Greedy 12);
    Common.Llvm__2 (Simple 12);
    Common.Llvm__2 (Briggs 12);
    Common.Llvm__2 Linearscan;
  ]

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

let t ?(stdin = "") ?(cargs = []) ?(timeout = 5) t args counts =
  let exe = clang t cargs in
  let expexit, expout, experr =
    exec_with_timeout_and_capture exe args timeout stdin
  in
  flush stdout;
  let test (total, passes) c =
    Printf.printf "%s[%s]%s %s ... " muted (Common.string_of_compiler c) nc t;
    flush stdout;
    try
      let exe = Common.compile_test c t (Array.of_list cargs) in
      let gotexit, gotout, goterr =
        exec_with_timeout_and_capture exe args timeout stdin
      in
      if expexit <> gotexit || expout <> gotout || experr <> goterr then (
        Printf.printf "%sfailed!%s\n" red nc;
        if expexit <> gotexit then
          Printf.printf "  exit:\n    got %s, expected %s\n"
            (string_of_status gotexit) (string_of_status expexit);
        if expout <> gotout then (
          Printf.printf "  stdout:\n";
          Common.print_diff expout gotout);
        (total + 1, passes))
      else (
        Printf.printf "%sok!%s\n" green nc;
        flush stdout;
        (total + 1, passes + 1))
    with e ->
      Printf.printf "%sfailed compilation!%s\n" red nc;
      Printf.printf "%s\n" (Printexc.to_string e);
      (total + 1, passes)
  in
  List.fold_left test counts compilers

let () =
  let print (t, p) = Printf.printf "[ %d / %d ]\n" p t in
  t "tests/void.ll" [] (0, 0)
  |> t "tests/zero.ll" [] |> t "tests/one.ll" [] |> t "tests/simplest.ll" []
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
  |> t "tests/lshri8.ll" (List.init 31 string_of_int)
  |> t "tests/lshri32.ll" []
  |> t "tests/lshri32.ll" (List.init 1 string_of_int)
  |> t "tests/lshri32.ll" (List.init 7 string_of_int)
  |> t "tests/lshri32.ll" (List.init 27 string_of_int)
  |> t "tests/lshri32.ll" (List.init 30 string_of_int)
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
  |> t "tests/live25.ll" [] |> t "tests/livechain.ll" []
  |> t "tests/collatz-phi.ll" []
  |> t "tests/collatz-phi.ll" [ "1" ]
  |> t "tests/collatz-phi.ll" [ "2" ]
  |> t "tests/collatz-phi.ll" [ "3" ]
  |> t "tests/collatz-phi.ll" [ "1312" ]
  |> t "tests/collatz-mut.ll" []
  |> t "tests/collatz-mut.ll" [ "1" ]
  |> t "tests/collatz-mut.ll" [ "2" ]
  |> t "tests/collatz-mut.ll" [ "3" ]
  |> t "tests/collatz-mut.ll" [ "1312" ]
  |> t "tests/printle.ll" [] |> t "tests/crc32b.ll" [ "" ]
  |> t "tests/crc32b.ll" [ "Hello, world!" ]
  |> t "tests/crc32b.ll" [ "Hello, world!\n" ]
  |> t "tests/crc32b-debug.ll" [ "" ]
  |> t "tests/crc32b-debug.ll" [ "Hello, world!" ]
  |> t "tests/crc32b-debug.ll" [ "Hello, world!\n" ]
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
  |> t "tests/sha256-debug.ll" [ "" ]
  |> t "tests/sha256-debug.ll" [ "a" ]
  |> t "tests/sha256-debug.ll" [ "Hello, world!" ]
  |> t "dolphintests/_prog_01.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_02.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_03.ll" [] ~cargs:[ "dolphin.c" ]
  |> t "dolphintests/_prog_04.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"0"
  |> t "dolphintests/_prog_04.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"1"
  |> t "dolphintests/_prog_04.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"42"
  |> t "dolphintests/_prog_05.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"69"
  |> t "dolphintests/_prog_05.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"100"
  |> t "dolphintests/_prog_05.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"101"
  |> t "dolphintests/_prog_06.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"100"
  |> t "dolphintests/_prog_06.ll" [] ~cargs:[ "dolphin.c" ] ~stdin:"1337"
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
