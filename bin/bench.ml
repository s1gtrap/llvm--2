open Common
open Unix

let read_all chan =
  let buf_size = 4096 in
  let buf = Buffer.create buf_size in
  let tmp_buf = Bytes.create buf_size in
  let rec loop () =
    let bytes_read = input chan tmp_buf 0 buf_size in
    if bytes_read > 0 then (
      Buffer.add_subbytes buf tmp_buf 0 bytes_read;
      loop ())
  in
  loop ();
  Buffer.contents buf

  let create_process_and_read_stdout command args =
  let (in_fd, out_fd) = pipe () in
  let pid = create_process command args  in_fd out_fd out_fd in
  close out_fd;
  let out_channel = in_channel_of_descr in_fd in
  let output = read_all out_channel in
  close in_fd;
  ignore (waitpid [] pid);
  output

  let bench f a c =
  let e = compile_test c f [||] in
  let command = "perf" in
  let arguments = Array.concat [ [| command; "stat"; "-e"; "cycles"; "-x"; ",";  e |]; a] in
  let output = create_process_and_read_stdout command arguments in
  Printf.printf "out: %s" output;
  flush Stdlib.stdout

let bench_all f a =
  List.iter (bench f a) [ Clang; (Llvm__2 Llvm__2.Regalloc.Greedy); Llvm__2 Llvm__2.Regalloc.Briggs ]


let () =
  let command = "echo" in
  let arguments = [| command; "Hello, OCaml!" |] in
  let output = create_process_and_read_stdout command arguments in
  print_endline output;
  let command = "echo" in
  let arguments = [| command; "Hello, ahgt!" |] in
  let output = create_process_and_read_stdout command arguments in
  print_endline output;
  let command = compile_test Clang "benches/sha256.ll" [||] in
  let arguments = [| command; "Hello, ahgt!" |] in
  let output = create_process_and_read_stdout command arguments in
  print_endline output;
  print_endline output;
  bench_all "benches/sha256.ll" [| "100000" |] ;
  bench_all "benches/sha256.ll" [| "1000000" |] ;
  bench_all "benches/sha256.ll" [| "10000000" |] ;
  bench_all "benches/sha256.ll" [| "100000000" |] ;
  ()

