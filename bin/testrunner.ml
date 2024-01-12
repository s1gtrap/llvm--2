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
  let stderr_ic, stderr_oc = Unix.pipe () in
  let stderr_ic = Unix.in_channel_of_descr stderr_ic in
  let exit = exec_with_timeout process args timeout input stdout_oc stderr_oc in
  Unix.close stdout_oc;
  let stdout = In_channel.input_all stdout_ic in
  close_in stdout_ic;
  Unix.close stderr_oc;
  let stderr = In_channel.input_all stderr_ic in
  close_in stderr_ic;
  (exit, stdout, stderr)

let clang t args =
  let outfile = Filename.temp_file "" "" in
  let args =
    match Llvm__2.Regalloc.os with
    | Linux ->
        [
          "-Wno-override-module";
          "-target";
          "x86_64-unknown-linux-gnu";
          t;
          "-o";
          outfile;
        ]
        @ args
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

type asserts = int

let assert_exitcode : asserts = 0b1
and assert_stdout : asserts = 0b10
and assert_stderr : asserts = 0b100

let t matches compilers ?(stdin = "") ?(cargs = []) ?(timeout = 5)
    ?(asserts = assert_exitcode lor assert_stdout lor assert_stderr) t args
    counts =
  if matches t then (
    let exe = clang t cargs in
    let expexit, expout, experr =
      exec_with_timeout_and_capture exe args timeout stdin
    in
    flush stdout;
    (*let strip t =
        let initLexer (lexbuf : Lexing.lexbuf) =
          (* obs that we need to initialize the pos_fname field ourselves *)
          lexbuf.lex_curr_p <- lexbuf.lex_curr_p;
          (input, lexbuf)
        in

        let from_channel input =
          let lexbuf = Lexing.from_channel input in
          let _, filebuf = initLexer lexbuf in
          let parseRes =
            try Llparserstrip.prog Lllexerstrip.token filebuf with
            | Lllexerstrip.Error msg ->
                Printf.eprintf "%s%!" msg;
                failwith "lex"
            | Llparserstrip.Error ->
                let pos1 = Lexing.lexeme_start_p filebuf in
                let pos2 = Lexing.lexeme_end_p filebuf in
                let lexeme = Lexing.lexeme filebuf in
                Printf.fprintf stderr "%s:%d:%d - %d:%d: syntax error '%s'\n"
                  pos1.pos_fname pos1.pos_lnum
                  (pos1.pos_cnum - pos1.pos_bol)
                  pos2.pos_lnum
                  (pos2.pos_cnum - pos2.pos_bol + 1)
                  lexeme;
                failwith "par"
          in
          (* XXX: might still leak on exception: *)
          close_in input;
          parseRes
        in
        open_in t |> from_channel |> Ll.string_of_prog
      in
      let stripped = strip t in
        let st = "s" ^ t in
        Printf.printf "%s ... " st;
        let oc = open_out st in
        output_string oc stripped;
        close_out oc;
        let exe = clang t cargs in
        let gotexit, gotout, goterr =
          exec_with_timeout_and_capture exe args timeout stdin
        in
        flush stdout;
        let total, passes = counts in
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
          (total + 1, passes + 1))*)
    let test (total, passes) c =
      Printf.printf "%s[%s]%s %s ... " muted (Common.string_of_compiler c) nc t;
      flush stdout;
      try
        let exe = Common.compile_test c t (Array.of_list cargs) in
        let gotexit, gotout, goterr =
          exec_with_timeout_and_capture exe args timeout stdin
        in
        if
          (asserts land assert_exitcode > 0 && expexit <> gotexit)
          || (asserts land assert_stdout > 0 && expout <> gotout)
          || (asserts land assert_stderr > 0 && experr <> goterr)
        then (
          Printf.printf "%sfailed!%s\n" red nc;
          Printf.printf "    %s\n" exe;
          if asserts land assert_exitcode > 0 && expexit <> gotexit then
            Printf.printf "  exit:\n    got %s, expected %s\n"
              (string_of_status gotexit) (string_of_status expexit);
          if asserts land assert_stdout > 0 && expout <> gotout then (
            Printf.printf "  stdout:\n";
            Common.print_diff expout gotout);
          if asserts land assert_stderr > 0 && experr <> goterr then (
            Printf.printf "  stderr:\n";
            Common.print_diff experr goterr);
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
    List.fold_left test counts compilers)
  else counts

(* https://discuss.ocaml.org/t/more-natural-preferred-way-to-shuffle-an-array/217/5 *)
let rec shuffle = function
  | [] -> []
  | [ single ] -> [ single ]
  | list ->
      let before, after = List.partition (fun _ -> Random.bool ()) list in
      List.rev_append (shuffle before) (shuffle after)

let () =
  let compilers =
    [
      (*Common.Tiger;*)
      Common.Llvm__2 (Greedy 12);
      Common.Llvm__2 (Simple 12);
      Common.Llvm__2 (Briggs 12);
      Common.Llvm__2 (Linearscan 12);
    ]
  in
  let filter = if Array.length Sys.argv >= 2 then Sys.argv.(1) else "" in
  let t = t (matches filter) compilers in
  let print (t, p) =
    let pct = Float.floor (float_of_int p /. float_of_int t *. 100.0) in
    Printf.printf "Passed: %d / %d [%.0f%%]\n" p t pct
  in
  t "tests/void.ll" [] ~asserts:(assert_stdout lor assert_stderr) (0, 0)
  |> t "tests/zero.ll" [] |> t "tests/one.ll" [] |> t "tests/simplest.ll" []
  |> t "tests/live1.ll" [] (* ./tests/live.py 1 *)
  |> t "tests/live1.ll" [ "2" ] (* ./tests/live.py 1 *)
  |> t "tests/live1.ll" [ "2"; "3" ] (* ./tests/live.py 1 *)
  |> t "tests/live1.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 1 *)
  |> t "tests/live2.ll" [] (* ./tests/live.py 2 *)
  |> t "tests/live2.ll" [ "2" ] (* ./tests/live.py 2 *)
  |> t "tests/live2.ll" [ "2"; "3" ] (* ./tests/live.py 2 *)
  |> t "tests/live2.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 2 *)
  |> t "tests/live4.ll" [] (* ./tests/live.py 4 *)
  |> t "tests/live4.ll" [ "2" ] (* ./tests/live.py 4 *)
  |> t "tests/live4.ll" [ "2"; "3" ] (* ./tests/live.py 4 *)
  |> t "tests/live4.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 4 *)
  |> t "tests/live8.ll" [] (* ./tests/live.py 8 *)
  |> t "tests/live8.ll" [ "2" ] (* ./tests/live.py 8 *)
  |> t "tests/live8.ll" [ "2"; "3" ] (* ./tests/live.py 8 *)
  |> t "tests/live8.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 8 *)
  |> t "tests/live16.ll" [] (* ./tests/live.py 16 *)
  |> t "tests/live16.ll" [ "2" ] (* ./tests/live.py 16 *)
  |> t "tests/live16.ll" [ "2"; "3" ] (* ./tests/live.py 16 *)
  |> t "tests/live16.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 16 *)
  |> t "tests/live32.ll" [] (* ./tests/live.py 32 *)
  |> t "tests/live32.ll" [ "2" ] (* ./tests/live.py 32 *)
  |> t "tests/live32.ll" [ "2"; "3" ] (* ./tests/live.py 32 *)
  |> t "tests/live32.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 32 *)
  |> t "tests/live64.ll" [] (* ./tests/live.py 64 *)
  |> t "tests/live64.ll" [ "2" ] (* ./tests/live.py 64 *)
  |> t "tests/live64.ll" [ "2"; "3" ] (* ./tests/live.py 64 *)
  |> t "tests/live64.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 64 *)
  |> t "tests/live128.ll" [] (* ./tests/live.py 128 *)
  |> t "tests/live128.ll" [ "2" ] (* ./tests/live.py 128 *)
  |> t "tests/live128.ll" [ "2"; "3" ] (* ./tests/live.py 128 *)
  |> t "tests/live128.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 128 *)
  |> t "tests/live256.ll" [] (* ./tests/live.py 256 *)
  |> t "tests/live256.ll" [ "2" ] (* ./tests/live.py 256 *)
  |> t "tests/live256.ll" [ "2"; "3" ] (* ./tests/live.py 256 *)
  |> t "tests/live256.ll" [ "2"; "3"; "4" ] (* ./tests/live.py 256 *)
  |> t "tests/series1.ll" [] (* ./tests/series.py 1 *)
  |> t "tests/series1.ll" [ "2" ] (* ./tests/series.py 1 *)
  |> t "tests/series1.ll" [ "2"; "3" ] (* ./tests/series.py 1 *)
  |> t "tests/series1.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 1 *)
  |> t "tests/series2.ll" [] (* ./tests/series.py 2 *)
  |> t "tests/series2.ll" [ "2" ] (* ./tests/series.py 2 *)
  |> t "tests/series2.ll" [ "2"; "3" ] (* ./tests/series.py 2 *)
  |> t "tests/series2.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 2 *)
  |> t "tests/series4.ll" [] (* ./tests/series.py 4 *)
  |> t "tests/series4.ll" [ "2" ] (* ./tests/series.py 4 *)
  |> t "tests/series4.ll" [ "2"; "3" ] (* ./tests/series.py 4 *)
  |> t "tests/series4.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 4 *)
  |> t "tests/series8.ll" [] (* ./tests/series.py 8 *)
  |> t "tests/series8.ll" [ "2" ] (* ./tests/series.py 8 *)
  |> t "tests/series8.ll" [ "2"; "3" ] (* ./tests/series.py 8 *)
  |> t "tests/series8.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 8 *)
  |> t "tests/series16.ll" [] (* ./tests/series.py 16 *)
  |> t "tests/series16.ll" [ "2" ] (* ./tests/series.py 16 *)
  |> t "tests/series16.ll" [ "2"; "3" ] (* ./tests/series.py 16 *)
  |> t "tests/series16.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 16 *)
  |> t "tests/series32.ll" [] (* ./tests/series.py 32 *)
  |> t "tests/series32.ll" [ "2" ] (* ./tests/series.py 32 *)
  |> t "tests/series32.ll" [ "2"; "3" ] (* ./tests/series.py 32 *)
  |> t "tests/series32.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 32 *)
  |> t "tests/series64.ll" [] (* ./tests/series.py 64 *)
  |> t "tests/series64.ll" [ "2" ] (* ./tests/series.py 64 *)
  |> t "tests/series64.ll" [ "2"; "3" ] (* ./tests/series.py 64 *)
  |> t "tests/series64.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 64 *)
  |> t "tests/series128.ll" [] (* ./tests/series.py 128 *)
  |> t "tests/series128.ll" [ "2" ] (* ./tests/series.py 128 *)
  |> t "tests/series128.ll" [ "2"; "3" ] (* ./tests/series.py 128 *)
  |> t "tests/series128.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 128 *)
  |> t "tests/series256.ll" [] (* ./tests/series.py 256 *)
  |> t "tests/series256.ll" [ "2" ] (* ./tests/series.py 256 *)
  |> t "tests/series256.ll" [ "2"; "3" ] (* ./tests/series.py 256 *)
  |> t "tests/series256.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 256 *)
  (*|> t "tests/series512.ll" [] (* ./tests/series.py 512 *)
    |> t "tests/series512.ll" [ "2" ] (* ./tests/series.py 512 *)
    |> t "tests/series512.ll" [ "2"; "3" ] (* ./tests/series.py 512 *)
    |> t "tests/series512.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 512 *)
    |> t "tests/series1024.ll" [] (* ./tests/series.py 1024 *)
    |> t "tests/series1024.ll" [ "2" ] (* ./tests/series.py 1024 *)
    |> t "tests/series1024.ll" [ "2"; "3" ] (* ./tests/series.py 1024 *)
    |> t "tests/series1024.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 1024 *)
    |> t "tests/series2048.ll" [] (* ./tests/series.py 2048 *)
    |> t "tests/series2048.ll" [ "2" ] (* ./tests/series.py 2048 *)
    |> t "tests/series2048.ll" [ "2"; "3" ] (* ./tests/series.py 2048 *)
    |> t "tests/series2048.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 2048 *)
    |> t "tests/series4096.ll" [] (* ./tests/series.py 4096 *)
    |> t "tests/series4096.ll" [ "2" ] (* ./tests/series.py 4096 *)
    |> t "tests/series4096.ll" [ "2"; "3" ] (* ./tests/series.py 4096 *)
    |> t "tests/series4096.ll" [ "2"; "3"; "4" ] (* ./tests/series.py 4096 *)*)
  |> t "tests/addi8.ll" [] (* ./tests/binop-select.py add i8 *)
  |> t "tests/addi16.ll" [] (* ./tests/binop-select.py add i16 *)
  |> t "tests/addi32.ll" [] (* ./tests/binop-select.py add i32 *)
  |> t "tests/addi64.ll" [] (* ./tests/binop-select.py add i64 *)
  |> t "tests/subi8.ll" [] (* ./tests/binop-select.py sub i8 *)
  |> t "tests/subi16.ll" [] (* ./tests/binop-select.py sub i16 *)
  |> t "tests/subi32.ll" [] (* ./tests/binop-select.py sub i32 *)
  |> t "tests/subi64.ll" [] (* ./tests/binop-select.py sub i64 *)
  |> t "tests/muli8.ll" [] (* ./tests/binop-select.py mul i8 *)
  |> t "tests/muli16.ll" [] (* ./tests/binop-select.py mul i16 *)
  |> t "tests/muli32.ll" [] (* ./tests/binop-select.py mul i32 *)
  |> t "tests/muli64.ll" [] (* ./tests/binop-select.py mul i64 *)
  |> t "tests/andi8.ll" [] (* ./tests/binop-select.py and i8 *)
  |> t "tests/andi16.ll" [] (* ./tests/binop-select.py and i16 *)
  |> t "tests/andi32.ll" [] (* ./tests/binop-select.py and i32 *)
  |> t "tests/andi64.ll" [] (* ./tests/binop-select.py and i64 *)
  |> t "tests/ori8.ll" [] (* ./tests/binop-select.py or i8 *)
  |> t "tests/ori16.ll" [] (* ./tests/binop-select.py or i16 *)
  |> t "tests/ori32.ll" [] (* ./tests/binop-select.py or i32 *)
  |> t "tests/ori64.ll" [] (* ./tests/binop-select.py or i64 *)
  |> t "tests/xori8.ll" [] (* ./tests/binop-select.py xor i8 *)
  |> t "tests/xori16.ll" [] (* ./tests/binop-select.py xor i16 *)
  |> t "tests/xori32.ll" [] (* ./tests/binop-select.py xor i32 *)
  |> t "tests/xori64.ll" [] (* ./tests/binop-select.py xor i64 *)
  |> t "tests/sdivi8.ll" [] (* ./tests/binop-select.py sdiv i8 *)
  |> t "tests/sdivi16.ll" [] (* ./tests/binop-select.py sdiv i16 *)
  |> t "tests/sdivi32.ll" [] (* ./tests/binop-select.py sdiv i32 *)
  |> t "tests/sdivi64.ll" [] (* ./tests/binop-select.py sdiv i64 *)
  |> t "tests/udivi8.ll" [] (* ./tests/binop-select.py udiv i8 *)
  |> t "tests/udivi16.ll" [] (* ./tests/binop-select.py udiv i16 *)
  |> t "tests/udivi32.ll" [] (* ./tests/binop-select.py udiv i32 *)
  |> t "tests/udivi64.ll" [] (* ./tests/binop-select.py udiv i64 *)
  |> t "tests/sremi8.ll" [] (* ./tests/binop-select.py srem i8 *)
  |> t "tests/sremi16.ll" [] (* ./tests/binop-select.py srem i16 *)
  |> t "tests/sremi32.ll" [] (* ./tests/binop-select.py srem i32 *)
  |> t "tests/sremi64.ll" [] (* ./tests/binop-select.py srem i64 *)
  |> t "tests/uremi8.ll" [] (* ./tests/binop-select.py urem i8 *)
  |> t "tests/uremi16.ll" [] (* ./tests/binop-select.py urem i16 *)
  |> t "tests/uremi32.ll" [] (* ./tests/binop-select.py urem i32 *)
  |> t "tests/uremi64.ll" [] (* ./tests/binop-select.py urem i64 *)
  |> t "tests/add.ll" [ "1"; "2" ]
  |> t "tests/add.ll" [ "-13"; "12" ]
  |> t "tests/argc.ll" []
  |> t "tests/argc.ll" [ "two" ]
  |> t "tests/argc.ll" [ "two"; "three" ]
  |> t "tests/argc.ll" [ "2"; "3"; "4" ]
  |> t "tests/arith0.ll" [] |> t "tests/arith1.ll" [] |> t "tests/arith2.ll" []
  |> t "tests/count0.ll" (List.init 0 string_of_int)
  |> t "tests/count0.ll" (List.init 1 string_of_int)
  |> t "tests/count0.ll" (List.init 2 string_of_int)
  |> t "tests/count0.ll" (List.init 3 string_of_int)
  |> t "tests/count0.ll" (List.init 4 string_of_int)
  |> t "tests/count0.ll" (List.init 5 string_of_int)
  |> t "tests/count1.ll" (List.init 0 string_of_int)
  |> t "tests/count1.ll" (List.init 1 string_of_int)
  |> t "tests/count1.ll" (List.init 2 string_of_int)
  |> t "tests/count1.ll" (List.init 3 string_of_int)
  |> t "tests/count1.ll" (List.init 4 string_of_int)
  |> t "tests/count1.ll" (List.init 5 string_of_int)
  |> t "tests/printints0.ll" []
  |> t "tests/printints0.ll" [] ~stdin:"1\n"
  |> t "tests/printints0.ll" [] ~stdin:"0\n1\n2\n"
  |> t "tests/printints0.ll" [] ~stdin:"1\n2\n3\n4\n5\n6\n7\n8\n9\n10"
  |> t "tests/printints1.ll" []
  |> t "tests/printints1.ll" [] ~stdin:"1\n"
  |> t "tests/printints1.ll" [] ~stdin:"0\n1\n2\n"
  |> t "tests/printints1.ll" [] ~stdin:"1\n2\n3\n4\n5\n6\n7\n8\n9\n10"
  (*|> t "tests/printints-debug0.ll" []
    |> t "tests/printints-debug0.ll" [] ~stdin:"1\n"
    |> t "tests/printints-debug0.ll" [] ~stdin:"0\n1\n2\n"
    |> t "tests/printints-debug0.ll" [] ~stdin:"1\n2\n3\n4\n5\n6\n7\n8\n9\n10"
    |> t "tests/printints-debug1.ll" []
    |> t "tests/printints-debug1.ll" [] ~stdin:"1\n"
    |> t "tests/printints-debug1.ll" [] ~stdin:"0\n1\n2\n"
    |> t "tests/printints-debug1.ll" [] ~stdin:"1\n2\n3\n4\n5\n6\n7\n8\n9\n10"*)
  |> t "tests/dumb-mul0.ll" [ "0"; "0" ]
  |> t "tests/dumb-mul0.ll" [ "0"; "1" ]
  |> t "tests/dumb-mul0.ll" [ "1"; "0" ]
  |> t "tests/dumb-mul0.ll" [ "1"; "1" ]
  |> t "tests/dumb-mul0.ll" [ "1"; "2" ]
  |> t "tests/dumb-mul0.ll" [ "3"; "4" ]
  |> t "tests/dumb-mul0.ll" [ "5"; "6" ]
  |> t "tests/dumb-mul1.ll" [ "0"; "0" ]
  |> t "tests/dumb-mul1.ll" [ "0"; "1" ]
  |> t "tests/dumb-mul1.ll" [ "1"; "0" ]
  |> t "tests/dumb-mul1.ll" [ "1"; "1" ]
  |> t "tests/dumb-mul1.ll" [ "1"; "2" ]
  |> t "tests/dumb-mul1.ll" [ "3"; "4" ]
  |> t "tests/dumb-mul1.ll" [ "5"; "6" ]
  |> t "tests/sqrt0.ll" [ "0" ] |> t "tests/sqrt0.ll" [ "1" ]
  |> t "tests/sqrt0.ll" [ "2" ] |> t "tests/sqrt0.ll" [ "3" ]
  |> t "tests/sqrt0.ll" [ "4" ] |> t "tests/sqrt0.ll" [ "5" ]
  |> t "tests/sqrt0.ll" [ "6" ] |> t "tests/sqrt0.ll" [ "7" ]
  |> t "tests/sqrt0.ll" [ "8" ] |> t "tests/sqrt0.ll" [ "9" ]
  |> t "tests/sqrt0.ll" [ "10" ]
  |> t "tests/sqrt0.ll" [ "11" ]
  |> t "tests/sqrt0.ll" [ "12" ]
  |> t "tests/sqrt0.ll" [ "13" ]
  |> t "tests/sqrt0.ll" [ "14" ]
  |> t "tests/sqrt0.ll" [ "15" ]
  |> t "tests/sqrt0.ll" [ "16" ]
  |> t "tests/sqrt0.ll" [ "17" ]
  |> t "tests/sqrt0.ll" [ "18" ]
  |> t "tests/sqrt0.ll" [ "19" ]
  |> t "tests/sqrt0.ll" [ "20" ]
  |> t "tests/sqrt0.ll" [ "21" ]
  |> t "tests/sqrt0.ll" [ "22" ]
  |> t "tests/sqrt0.ll" [ "23" ]
  |> t "tests/sqrt0.ll" [ "24" ]
  |> t "tests/sqrt0.ll" [ "25" ]
  |> t "tests/sqrt1.ll" [ "0" ] |> t "tests/sqrt1.ll" [ "1" ]
  |> t "tests/sqrt1.ll" [ "2" ] |> t "tests/sqrt1.ll" [ "3" ]
  |> t "tests/sqrt1.ll" [ "4" ] |> t "tests/sqrt1.ll" [ "5" ]
  |> t "tests/sqrt1.ll" [ "6" ] |> t "tests/sqrt1.ll" [ "7" ]
  |> t "tests/sqrt1.ll" [ "8" ] |> t "tests/sqrt1.ll" [ "9" ]
  |> t "tests/sqrt1.ll" [ "10" ]
  |> t "tests/sqrt1.ll" [ "11" ]
  |> t "tests/sqrt1.ll" [ "12" ]
  |> t "tests/sqrt1.ll" [ "13" ]
  |> t "tests/sqrt1.ll" [ "14" ]
  |> t "tests/sqrt1.ll" [ "15" ]
  |> t "tests/sqrt1.ll" [ "16" ]
  |> t "tests/sqrt1.ll" [ "17" ]
  |> t "tests/sqrt1.ll" [ "18" ]
  |> t "tests/sqrt1.ll" [ "19" ]
  |> t "tests/sqrt1.ll" [ "20" ]
  |> t "tests/sqrt1.ll" [ "21" ]
  |> t "tests/sqrt1.ll" [ "22" ]
  |> t "tests/sqrt1.ll" [ "23" ]
  |> t "tests/sqrt1.ll" [ "24" ]
  |> t "tests/sqrt1.ll" [ "25" ]
  |> t "tests/icmpi8eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpi8eq.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtol *)
  |> t "tests/icmpu8eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpu8eq.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py eq i8 @strtoul *)
  |> t "tests/icmpi16eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpi16eq.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtol *)
  |> t "tests/icmpu16eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpu16eq.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py eq i16 @strtoul *)
  |> t "tests/icmpi32eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpi32eq.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtol *)
  |> t "tests/icmpu32eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpu32eq.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py eq i32 @strtoul *)
  |> t "tests/icmpi64eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpi64eq.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoll *)
  |> t "tests/icmpu64eq.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpu64eq.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py eq i64 @strtoull *)
  |> t "tests/icmpi8ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpi8ne.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtol *)
  |> t "tests/icmpu8ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpu8ne.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ne i8 @strtoul *)
  |> t "tests/icmpi16ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpi16ne.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtol *)
  |> t "tests/icmpu16ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpu16ne.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ne i16 @strtoul *)
  |> t "tests/icmpi32ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpi32ne.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtol *)
  |> t "tests/icmpu32ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpu32ne.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ne i32 @strtoul *)
  |> t "tests/icmpi64ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpi64ne.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoll *)
  |> t "tests/icmpu64ne.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpu64ne.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ne i64 @strtoull *)
  |> t "tests/icmpi8slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpi8slt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtol *)
  |> t "tests/icmpu8slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpu8slt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py slt i8 @strtoul *)
  |> t "tests/icmpi16slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpi16slt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtol *)
  |> t "tests/icmpu16slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpu16slt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py slt i16 @strtoul *)
  |> t "tests/icmpi32slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpi32slt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtol *)
  |> t "tests/icmpu32slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpu32slt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py slt i32 @strtoul *)
  |> t "tests/icmpi64slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpi64slt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoll *)
  |> t "tests/icmpu64slt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpu64slt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py slt i64 @strtoull *)
  |> t "tests/icmpi8sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpi8sle.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtol *)
  |> t "tests/icmpu8sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpu8sle.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sle i8 @strtoul *)
  |> t "tests/icmpi16sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpi16sle.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtol *)
  |> t "tests/icmpu16sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpu16sle.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sle i16 @strtoul *)
  |> t "tests/icmpi32sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpi32sle.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtol *)
  |> t "tests/icmpu32sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpu32sle.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sle i32 @strtoul *)
  |> t "tests/icmpi64sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpi64sle.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoll *)
  |> t "tests/icmpu64sle.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpu64sle.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sle i64 @strtoull *)
  |> t "tests/icmpi8sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpi8sgt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtol *)
  |> t "tests/icmpu8sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpu8sgt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sgt i8 @strtoul *)
  |> t "tests/icmpi16sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpi16sgt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtol *)
  |> t "tests/icmpu16sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpu16sgt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sgt i16 @strtoul *)
  |> t "tests/icmpi32sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpi32sgt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtol *)
  |> t "tests/icmpu32sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpu32sgt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sgt i32 @strtoul *)
  |> t "tests/icmpi64sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpi64sgt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoll *)
  |> t "tests/icmpu64sgt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpu64sgt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sgt i64 @strtoull *)
  |> t "tests/icmpi8sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpi8sge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtol *)
  |> t "tests/icmpu8sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpu8sge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py sge i8 @strtoul *)
  |> t "tests/icmpi16sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpi16sge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtol *)
  |> t "tests/icmpu16sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpu16sge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py sge i16 @strtoul *)
  |> t "tests/icmpi32sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpi32sge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtol *)
  |> t "tests/icmpu32sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpu32sge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py sge i32 @strtoul *)
  |> t "tests/icmpi64sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpi64sge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoll *)
  |> t "tests/icmpu64sge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpu64sge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py sge i64 @strtoull *)
  |> t "tests/icmpi8ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpi8ult.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtol *)
  |> t "tests/icmpu8ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpu8ult.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ult i8 @strtoul *)
  |> t "tests/icmpi16ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpi16ult.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtol *)
  |> t "tests/icmpu16ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpu16ult.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ult i16 @strtoul *)
  |> t "tests/icmpi32ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpi32ult.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtol *)
  |> t "tests/icmpu32ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpu32ult.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ult i32 @strtoul *)
  |> t "tests/icmpi64ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpi64ult.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoll *)
  |> t "tests/icmpu64ult.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpu64ult.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ult i64 @strtoull *)
  |> t "tests/icmpi8ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpi8ule.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtol *)
  |> t "tests/icmpu8ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpu8ule.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ule i8 @strtoul *)
  |> t "tests/icmpi16ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpi16ule.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtol *)
  |> t "tests/icmpu16ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpu16ule.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ule i16 @strtoul *)
  |> t "tests/icmpi32ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpi32ule.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtol *)
  |> t "tests/icmpu32ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpu32ule.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ule i32 @strtoul *)
  |> t "tests/icmpi64ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpi64ule.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoll *)
  |> t "tests/icmpu64ule.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpu64ule.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ule i64 @strtoull *)
  |> t "tests/icmpi8ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpi8ugt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtol *)
  |> t "tests/icmpu8ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpu8ugt.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py ugt i8 @strtoul *)
  |> t "tests/icmpi16ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpi16ugt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtol *)
  |> t "tests/icmpu16ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpu16ugt.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py ugt i16 @strtoul *)
  |> t "tests/icmpi32ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpi32ugt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtol *)
  |> t "tests/icmpu32ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpu32ugt.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py ugt i32 @strtoul *)
  |> t "tests/icmpi64ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpi64ugt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoll *)
  |> t "tests/icmpu64ugt.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpu64ugt.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py ugt i64 @strtoull *)
  |> t "tests/icmpi8uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpi8uge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtol *)
  |> t "tests/icmpu8uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "255"; "255" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "127"; "255" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "255"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "-256"; "-256" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "127"; "-256" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "-256"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpu8uge.ll" [ "127"; "127" ]
     (* ./tests/select-icmp.py uge i8 @strtoul *)
  |> t "tests/icmpi16uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpi16uge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtol *)
  |> t "tests/icmpu16uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "65535"; "65535" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "32767"; "65535" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "65535"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "-65536"; "-65536" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "32767"; "-65536" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "-65536"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpu16uge.ll" [ "32767"; "32767" ]
     (* ./tests/select-icmp.py uge i16 @strtoul *)
  |> t "tests/icmpi32uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpi32uge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtol *)
  |> t "tests/icmpu32uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "4294967295"; "4294967295" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "2147483647"; "4294967295" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "4294967295"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "-4294967296"; "-4294967296" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "2147483647"; "-4294967296" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "-4294967296"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpu32uge.ll" [ "2147483647"; "2147483647" ]
     (* ./tests/select-icmp.py uge i32 @strtoul *)
  |> t "tests/icmpi64uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpi64uge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoll *)
  |> t "tests/icmpu64uge.ll" [ "0"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "1"; "0" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "0"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "1"; "1" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "18446744073709551615"; "18446744073709551615" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "9223372036854775807"; "18446744073709551615" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "18446744073709551615"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll"
       [ "-18446744073709551616"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "9223372036854775807"; "-18446744073709551616" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "-18446744073709551616"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/icmpu64uge.ll" [ "9223372036854775807"; "9223372036854775807" ]
     (* ./tests/select-icmp.py uge i64 @strtoull *)
  |> t "tests/bubblesort0.ll" [] ~stdin:"1\n"
  |> t "tests/bubblesort0.ll" []
       ~stdin:(List.init 1024 string_of_int |> shuffle |> String.concat "\n")
  |> t "tests/bubblesort1.ll" [] ~stdin:"1\n"
  |> t "tests/bubblesort1.ll" []
       ~stdin:(List.init 1024 string_of_int |> shuffle |> String.concat "\n")
  |> t "tests/quicksort0.ll" [] ~stdin:"1\n"
  |> t "tests/quicksort0.ll" []
       ~stdin:(List.init 1024 string_of_int |> shuffle |> String.concat "\n")
  |> t "tests/quicksort1.ll" [] ~stdin:"1\n"
  |> t "tests/quicksort1.ll" []
       ~stdin:(List.init 1024 string_of_int |> shuffle |> String.concat "\n")
  |> t "tests/factorial0.ll" (List.init 0 string_of_int)
  |> t "tests/factorial0.ll" (List.init 1 string_of_int)
  |> t "tests/factorial0.ll" (List.init 2 string_of_int)
  |> t "tests/factorial0.ll" (List.init 3 string_of_int)
  |> t "tests/factorial0.ll" (List.init 4 string_of_int)
  |> t "tests/factorial0.ll" (List.init 5 string_of_int)
  |> t "tests/factorial1.ll" (List.init 0 string_of_int)
  |> t "tests/factorial1.ll" (List.init 1 string_of_int)
  |> t "tests/factorial1.ll" (List.init 2 string_of_int)
  |> t "tests/factorial1.ll" (List.init 3 string_of_int)
  |> t "tests/factorial1.ll" (List.init 4 string_of_int)
  |> t "tests/factorial1.ll" (List.init 5 string_of_int)
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
  |> t "tests/loop3.ll" []
  |> t "tests/loop4.ll" [] ~timeout:30
  |> t "tests/loop5.ll" []
  |> t "tests/loopn0.ll" [ "0" ]
  |> t "tests/loopn0.ll" [ "1" ]
  (*|> t "tests/loopn0.ll" [ "2147483647" ] ~timeout:30*)
  |> t "tests/loopn1.ll" [ "0" ]
  |> t "tests/loopn1.ll" [ "1" ]
  |> t "tests/argv0.ll" [] ~asserts:(assert_exitcode lor assert_stderr)
  |> t "tests/argv1.ll" [ "hello," ]
  |> t "tests/argv2.ll" [ "Hello,"; "world!" ]
  |> t "tests/countdown.ll" (List.init 0 string_of_int)
  |> t "tests/countdown.ll" (List.init 1 string_of_int)
  |> t "tests/countdown.ll" (List.init 2 string_of_int)
  |> t "tests/countdown.ll" (List.init 1024 string_of_int)
  |> t "tests/atoi.ll" []
  |> t "tests/atoi.ll" [ "hello," ]
  |> t "tests/atoi.ll" [ "0" ] |> t "tests/atoi.ll" [ "1" ]
  |> t "tests/atoi.ll" [ "-2" ]
  |> t "tests/atoi.ll" [ "127" ]
  |> t "tests/atoi.ll" [ "255" ]
  |> t "tests/helloworld0.ll" [] ~asserts:(assert_stdout lor assert_stderr)
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
  |> t "tests/zext.ll" [] |> t "tests/square0.ll" [] |> t "tests/switch0.ll" []
  |> t "tests/switch0.ll" [ "2" ]
  |> t "tests/switch0.ll" [ "2"; "3" ]
  |> t "tests/switch0.ll" [ "2"; "3"; "4" ]
  |> t "tests/switch1.ll" []
  |> t "tests/switch1.ll" [ "2" ]
  |> t "tests/switch1.ll" [ "2"; "3" ]
  |> t "tests/switch1.ll" [ "2"; "3"; "4" ]
  |> t "tests/switch2.ll" []
  |> t "tests/switch2.ll" [ "2" ]
  |> t "tests/switch2.ll" [ "2"; "3" ]
  |> t "tests/switch2.ll" [ "2"; "3"; "4" ]
  |> t "tests/square0.ll" [ "2" ]
  |> t "tests/square0.ll" [ "2"; "3" ]
  |> t "tests/square0.ll" [ "2"; "3"; "4" ]
  |> t "tests/square0-debug.ll" []
  |> t "tests/square0-debug.ll" [ "2" ]
  |> t "tests/square0-debug.ll" [ "2"; "3" ]
  |> t "tests/square0-debug.ll" [ "2"; "3"; "4" ]
  |> t "tests/consttrunc.ll" [] |> t "tests/lorem.ll" []
  |> t "tests/fib.ll" [ "0" ] |> t "tests/fib.ll" [ "1" ]
  |> t "tests/fib.ll" [ "2" ] |> t "tests/fib.ll" [ "3" ]
  |> t "tests/fib.ll" [ "4" ] |> t "tests/fib.ll" [ "5" ]
  |> t "tests/fib.ll" [ "6" ] |> t "tests/fib.ll" [ "7" ]
  |> t "tests/fib.ll" [ "8" ] |> t "tests/fib.ll" [ "9" ]
  |> t "tests/fib0.ll" [] |> t "tests/fib1.ll" [] |> t "tests/printable.ll" []
  |> t "tests/live20.ll" [] |> t "tests/live25.ll" []
  |> t "tests/livechain.ll" []
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
  |> t "tests/factori32.ll" [ "2" ] ~timeout:60
  |> t "tests/factori32.ll" [ "3" ] ~timeout:60
  |> t "tests/factori32.ll" [ "4" ] ~timeout:60
  |> t "tests/factori32.ll" [ "5" ] ~timeout:60
  |> t "tests/factori32.ll" [ "5040" ] ~timeout:60
  |> t "tests/factori32.ll" [ "268435399" ] ~timeout:60
  |> t "tests/factori32.ll" [ "536870909" ] ~timeout:60
  |> t "tests/factori32.ll" [ "1073741789" ] ~timeout:60
  |> t "tests/factori32.ll" [ "2147483647" ] ~timeout:60
  |> t "tests/factori64.ll" [ "2" ] ~timeout:60
  |> t "tests/factori64.ll" [ "3" ] ~timeout:60
  |> t "tests/factori64.ll" [ "4" ] ~timeout:60
  |> t "tests/factori64.ll" [ "5" ] ~timeout:60
  |> t "tests/factori64.ll" [ "5040" ] ~timeout:60
  |> t "tests/factori64.ll" [ "268435399" ] ~timeout:60
  |> t "tests/factori64.ll" [ "536870909" ] ~timeout:60
  |> t "tests/factori64.ll" [ "1073741789" ] ~timeout:60
  |> t "tests/factori64.ll" [ "2147483647" ] ~timeout:60
  |> t "tests/factori64.ll" [ "2305843009213693951" ] ~timeout:60
  |> t "tests/factori64.ll" [ "4611686018427387847" ] ~timeout:60
  |> t "tests/factori64.ll" [ "9223372036854775783" ] ~timeout:60
  (*|> t "tests/factori64.ll" [ "18446744073709551615" ] ~timeout:60*)
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
  |> t "tests/ackermann.ll" [ "0"; "0"; "0" ]
  |> t "tests/ackermann.ll" [ "1"; "0"; "1" ]
  |> t "tests/ackermann.ll" [ "2"; "0"; "1" ]
  |> t "tests/ackermann.ll" [ "1"; "1"; "1" ]
  |> t "tests/ackermann.ll" [ "2"; "1"; "1" ]
  |> t "tests/ackermann.ll" [ "3"; "0"; "2" ]
  |> t "tests/ackermann.ll" [ "42"; "0"; "2" ]
  |> t "tests/ackermann.ll" [ "3"; "1"; "2" ]
  |> t "tests/ackermann.ll" [ "42"; "1"; "2" ]
  (*|> t "tests/ackermann.ll" [ "420"; "0"; "3" ]
    |> t "tests/ackermann.ll" [ "1312"; "0"; "3" ]
    |> t "tests/ackermann.ll" [ "31337"; "1"; "3" ]
    |> t "tests/ackermann.ll" [ "2147483647"; "1"; "3" ]*)
  |> t "tests/sha256.ll" [ "" ]
  |> t "tests/sha256.ll" [ "a" ]
  |> t "tests/sha256.ll" [ "Hello, world!" ]
  |> t "tests/sha256-stdin.ll" [] ~stdin:""
  |> t "tests/sha256-stdin.ll" [] ~stdin:"a"
  |> t "tests/sha256-stdin.ll" [] ~stdin:"Hello, world!"
  |> t "tests/sha256-debug.ll" [ "" ]
  |> t "tests/sha256-debug.ll" [ "a" ]
  |> t "tests/sha256-debug.ll" [ "Hello, world!" ]
  |> t "tests/fannkuch-redux.ll" [ "0" ]
  |> t "tests/fannkuch-redux.ll" [ "1" ]
  |> t "tests/fannkuch-redux.ll" [ "2" ]
  |> t "tests/fannkuch-redux.ll" [ "3" ]
  |> t "tests/fannkuch-redux.ll" [ "4" ]
  |> t "tests/fannkuch-redux.ll" [ "5" ]
  |> t "tests/fannkuch-redux.ll" [ "6" ]
  |> t "tests/fannkuch-redux.ll" [ "7" ]
  |> t "tests/fannkuch-redux.ll" [ "8" ]
  |> t "tests/fannkuch-redux.ll" [ "9" ]
  |> t "tests/fannkuch-redux.ll" [ "10" ]
  |> t "tests/dolphin/_prog_01.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_02.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_03.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_04.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"0"
  |> t "tests/dolphin/_prog_04.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"1"
  |> t "tests/dolphin/_prog_04.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"42"
  |> t "tests/dolphin/_prog_05.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"69"
  |> t "tests/dolphin/_prog_05.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"100"
  |> t "tests/dolphin/_prog_05.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"101"
  |> t "tests/dolphin/_prog_06.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"100"
  |> t "tests/dolphin/_prog_06.ll" []
       ~cargs:[ "tests/dolphin/runtime.c" ]
       ~stdin:"1337"
  |> t "tests/dolphin/_prog_09.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_15.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_16.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_17.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_18.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_19.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_20.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_22.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_23.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_24.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_25.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_26.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_27.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_28.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_31.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_32.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_33.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/dolphin/_prog_36.ll" [] ~cargs:[ "tests/dolphin/runtime.c" ]
  |> t "tests/tiger/arith.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/binary_tree.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/brainfuck.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/color.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/ddd.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/div213.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/divbyzero.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/divorder.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/doors.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/dynarray.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/emoji_comment.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/fixedpoints.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/forfor.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/goodarith.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/if_readonly.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/lexer_ascii.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/lexer_ascii_alt.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/lexer_formfeed.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/lisp.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/lots_of_locals.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/nil_seq_last_ok.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/queens.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/readonly_overwrite.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/recFieldError.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/seq_nested_empty.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/seqorder.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/simplevar.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/split.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test1.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test12.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test2.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test27.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test3.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test30.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test37.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test4.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test41.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test42.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test44.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test46.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test47.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test48.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test5.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test51.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test52.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test53.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test54.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test55.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test56.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test57.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test58.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test59.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test60.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test61.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test62.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test63.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test64.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test65.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test66.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test67.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test68.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test69.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test72.tig.ll" []
       ~cargs:[ "tests/tiger/runtime.c" ]
       ~asserts:(assert_stdout lor assert_stderr)
  |> t "tests/tiger/test73.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test74.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test75.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test76.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/test8.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> t "tests/tiger/zero.tig.ll" [] ~cargs:[ "tests/tiger/runtime.c" ]
  |> print
