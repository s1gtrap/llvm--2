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
  let in_fd, out_fd = pipe () in
  let pid = create_process command args in_fd out_fd out_fd in
  close out_fd;
  let out_channel = in_channel_of_descr in_fd in
  let output = read_all out_channel in
  close in_fd;
  ignore (waitpid [] pid);
  output

let bench f a c =
  flush Stdlib.stdout;
  let e = compile_test c f [||] in
  let command = "perf" in
  let arguments =
    Array.concat [ [| command; "stat"; "-e"; "cycles"; "-x"; ","; e |]; a ]
  in
  let output = create_process_and_read_stdout command arguments in
  let cycles =
    match String.split_on_char ',' output with
    | cycles :: _ -> Int64.of_string cycles
    | _ -> failwith ("illegal perf output: " ^ output)
  in
  flush Stdlib.stdout;
  cycles

let bench_n f a n c =
  let rec iter mi sum ma = function
    | n when n <= 0 ->
        (*let cycles = bench f a c in
          Printf.printf "returning %Ld\n" (Int64.add cycles sum);
          (Int64.min cycles mi, Int64.add cycles sum, Int64.max cycles ma)*)
        (mi, sum, ma)
    | n ->
        let cycles = bench f a c in
        let newmin = Int64.min cycles mi in
        let newsum = Int64.add cycles sum in
        let newmax = Int64.max cycles ma in
        iter newmin newsum newmax (n - 1)
  in
  let min, avg, max = iter Int64.max_int 0L Int64.min_int n in
  (f, a, min, Int64.div avg (Int64.of_int n), max)

let _bench_all f a =
  List.map (bench f a)
    [ Clang; Llvm__2 Llvm__2.Regalloc.Greedy; Llvm__2 Llvm__2.Regalloc.Briggs ]

let bench_all_n f a n =
  let cf, ca, cmin, cavg, cmax = bench_n f a n Clang in
  (cf, ca, Clang, cmin, cavg, cmax, 1.0, 1.0)
  :: List.map
       (fun c ->
         let f, a, min, avg, max = bench_n f a n c in
         ( f,
           a,
           c,
           min,
           avg,
           max,
           Int64.to_float min /. Int64.to_float cmin,
           Int64.to_float avg /. Int64.to_float cavg ))
       [ Llvm__2 Llvm__2.Regalloc.Greedy; Llvm__2 Llvm__2.Regalloc.Briggs ]

let _print (f, a, min, avg, max) =
  Printf.printf "bench %s " f;
  Array.iter (fun a -> Printf.printf "%s " a) a;
  Printf.printf "min=%Ld " min;
  Printf.printf "avg=%Ld " avg;
  Printf.printf "max=%Ld\n" max

let print2 (f, a, c, min, avg, max, minr, avgr) =
  Printf.printf "bench %s\t%s " (string_of_compiler c) f;
  Array.iter (fun a -> Printf.printf "%s " a) a;
  Printf.printf "\tmin=%Ld (%f)\t" min minr;
  Printf.printf "avg=%Ld (%f)\t" avg avgr;
  Printf.printf "max=%Ld\n" max

let () =
  let n = 10 in
  bench_all_n "benches/fib.ll" [| "40" |] n |> List.iter print2;
  bench_all_n "benches/fib.ll" [| "41" |] n |> List.iter print2;
  bench_all_n "benches/fib.ll" [| "42" |] n |> List.iter print2;
  print_newline ();
  bench_all_n "benches/sha256.ll" [| "100" |] n |> List.iter print2;
  bench_all_n "benches/sha256.ll" [| "1000" |] n |> List.iter print2;
  bench_all_n "benches/sha256.ll" [| "10000" |] n |> List.iter print2;
  ()
