open Common

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

let bench f a c =
  let e = compile_test c f [||] in
  Printf.printf "%s" f;
  Array.iter (Printf.printf " %s") a;
  Printf.printf "\n";
  flush stdout;
  let read, write = Unix.pipe () in
  let pid =
    Unix.create_process "perf"
      (Array.concat [ [| "perf"; "stat"; "-e"; "cycles"; e |]; a ])
      Unix.stdin Unix.stdout write
  in
  Unix.close write;
  let oc = Unix.in_channel_of_descr read in
  let s = read_all oc in
  Unix.close read;
  Printf.printf "'%s'" s;
  let _, _status = Unix.waitpid [] pid in
  ()

let bench_all f a =
  List.iter (bench f a) [ Clang; Llvm__2 Llvm__2.Regalloc.Briggs ]

let () = bench_all "benches/sha256.ll" [| "100000" |]
