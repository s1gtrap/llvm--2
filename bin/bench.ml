open Common
open Unix
open Llvm__2

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

let null = open_out "/dev/null" |> Unix.descr_of_out_channel

let create_process_and_read_stdout command args =
  let in_fd, out_fd = pipe () in
  let pid = create_process command args in_fd null out_fd in
  close out_fd;
  let out_channel = in_channel_of_descr in_fd in
  let output = read_all out_channel in
  close in_fd;
  ignore (waitpid [] pid);
  output

let bench f a c =
  let e = compile_test c f [||] in
  match Llvm__2.Regalloc.os with
  | Darwin ->
      let command = "/usr/bin/time" in
      let arguments = Array.concat [ [| command; "-al"; e |]; a ] in
      let output = create_process_and_read_stdout command arguments in
      let regex = Str.regexp "\\([0-9]+\\)  cycles elapsed" in
      if Str.search_forward regex output 0 >= 0 then
        Str.matched_group 1 output |> Int64.of_string
      else failwith ("illegal time output: " ^ output)
  | Linux -> (
      let command = "perf" in
      let arguments =
        Array.concat [ [| command; "stat"; "-e"; "cycles"; "-x"; ","; e |]; a ]
      in
      let output = create_process_and_read_stdout command arguments in
      match String.split_on_char ',' output with
      | cycles :: _ -> Int64.of_string cycles
      | _ -> failwith ("illegal perf output: " ^ output))

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

let bench_all_n f a n c =
  flush Stdlib.stdout;
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
       c

let reset = "\x1b[0m"
let clamp v min max = Float.min (Float.max v min) max

let grad r =
  let color r g b =
    "\x1b[38;2;" ^ string_of_int r ^ ";" ^ string_of_int g ^ ";"
    ^ string_of_int b ^ "m"
  in
  let redlimit = 2.0 in
  let greenlimit = 10.0 in
  let red =
    (clamp r 1.0 redlimit -. 1.0) *. (255.0 /. (redlimit -. 1.0))
    |> int_of_float
  in
  let green =
    (greenlimit -. clamp r redlimit greenlimit)
    *. (255.0 /. (greenlimit -. redlimit))
    |> int_of_float
  in
  color red green 0

let cellcolor r =
  let color r g b =
    "\\cellcolor[rgb]{"
    ^ string_of_float ((float_of_int r /. 1024.0) +. 0.75)
    ^ ","
    ^ string_of_float ((float_of_int g /. 1024.0) +. 0.75)
    ^ ","
    ^ string_of_float ((float_of_int b /. 1024.0) +. 0.75)
    ^ "}"
  in
  let redlimit = 2.0 in
  let greenlimit = 10.0 in
  let red =
    (clamp r 1.0 redlimit -. 1.0) *. (255.0 /. (redlimit -. 1.0))
    |> int_of_float
  in
  let green =
    (greenlimit -. clamp r redlimit greenlimit)
    *. (255.0 /. (greenlimit -. redlimit))
    |> int_of_float
  in
  color red green 0

let default_compilers =
  [
    Llvm__2 (Llvm__2.Regalloc.Simple 12);
    Llvm__2 (Llvm__2.Regalloc.Simple 2);
    Llvm__2 (Llvm__2.Regalloc.Briggs 12);
    Llvm__2 (Llvm__2.Regalloc.Briggs 2);
    Llvm__2 Llvm__2.Regalloc.Linearscan;
    Llvm__2 (Llvm__2.Regalloc.Greedy 12);
    Llvm__2 (Llvm__2.Regalloc.Greedy 0);
  ]

let () =
  let newline () =
    print_newline ();
    flush Stdlib.stdout
  in
  let filter = ref "" in
  let n = ref 10 in
  let table = ref false in
  let speclist =
    [
      ("-n", Arg.Set_int n, "Number of samples");
      ("-f", Arg.Set_string filter, "Filter benches");
      ("-t", Arg.Set table, "Output in latex format");
    ]
  in
  let print i (f, a, c, min, avg, max, minr, avgr) =
    if !table then 
    if i = 0 then 
      Printf.printf "& %s %s" (cellcolor minr) (Int64.to_string min)
      else
      Printf.printf "& %s %.5fx" (cellcolor minr) minr
    else (
      Printf.printf "bench %s\t%s " (string_of_compiler c) f;
      Array.iter (fun a -> Printf.printf "%s " a) a;
      Printf.printf "\tmin=%Ld (%s%f%s)\t" min (grad minr) minr reset;
      Printf.printf "avg=%Ld (%s%f%s)\t" avg (grad avgr) avgr reset;
      Printf.printf "max=%Ld\n" max)
  in
  let matches s =
    let re = Str.regexp_string !filter in
    try
      ignore (Str.search_forward re s 0);
      true
    with Not_found -> false
  in
  let b f c args =
    if matches f then (
      if !table then (
        Printf.printf "\\begin{NiceTabular}{|c|%s|}\n\\hline\n"
          (String.make (List.length c + 1) 'c');
        Printf.printf "arg(s) ";
        List.iter
          (fun alc -> Printf.printf "& %s " (string_of_compiler alc))
          ([ Clang ] @ c);
        Printf.printf "\\\\\n\\hline\n");
      let f args =
        Printf.printf "%s "
          (Ll.mapcat "\\\\\\" (fun s -> s) (Array.to_list args));
        bench_all_n f args !n c |> List.iteri print;
        if !table then Printf.printf "\\\\\n";
        flush Stdlib.stdout
      in
      List.iter f args;
      if !table then Printf.printf "\\hline\n\\end{NiceTabular}";
      newline ())
  in
  Arg.parse speclist (fun _ -> ()) "append [-r n]";
  flush Stdlib.stdout;

  b "benches/factori32.ll" default_compilers
    [
      [| "16777213" |];
      [| "33554393" |];
      [| "67108859" |];
      [| "134217689" |];
      [| "268435399" |];
      [| "536870909" |];
      [| "1073741789" |];
      [| "2147483647" |];
    ];

  b "benches/factori64.ll" default_compilers
    [
      [| "268435399" |];
      [| "536870909" |];
      [| "1073741789" |];
      [| "2147483647" |];
      [| "4294967291" |];
      [| "8589934583" |];
      [| "17179869143" |];
      [| "34359738337" |];
    ];

  b "benches/sieven.ll" default_compilers
    [
      [| "128" |];
      [| "256" |];
      [| "512" |];
      [| "1024" |];
      [| "2048" |];
      [| "4096" |];
      [| "8192" |];
      [| "16384" |];
    ];

  b "benches/subset.ll" default_compilers
    [
      Array.init 15 string_of_int;
      Array.init 16 string_of_int;
      Array.init 17 string_of_int;
      Array.init 18 string_of_int;
      (* (Array.init 19 string_of_int) n
         (Array.init 20 string_of_int) n*)
    ];

  b "benches/fib.ll" default_compilers
    [
      [| "8" |];
      [| "10" |];
      [| "12" |];
      [| "14" |];
      [| "16" |];
      [| "18" |];
      [| "20" |];
      [| "22" |];
      [| "24" |];
      [| "26" |];
      [| "28" |];
      [| "30" |];
      [| "32" |];
    ];

  b "benches/fib.ll"
    [
      Llvm__2 (Llvm__2.Regalloc.Greedy 12);
      Llvm__2 (Llvm__2.Regalloc.Greedy 8);
      Llvm__2 (Llvm__2.Regalloc.Greedy 6);
      Llvm__2 (Llvm__2.Regalloc.Greedy 4);
      Llvm__2 (Llvm__2.Regalloc.Greedy 2);
      Llvm__2 (Llvm__2.Regalloc.Greedy 1);
      Llvm__2 (Llvm__2.Regalloc.Greedy 0);
      Tiger;
    ]
    [
      [| "8" |];
      [| "10" |];
      [| "12" |];
      [| "14" |];
      [| "16" |];
      [| "18" |];
      [| "20" |];
      [| "22" |];
      [| "24" |];
      [| "26" |];
      [| "28" |];
      [| "30" |];
      [| "32" |];
    ];

  b "benches/sha256.ll" default_compilers
    [ [| "100" |]; [| "1000" |]; [| "10000" |] ];

  b "benches/fannkuch-redux.ll" default_compilers
    [
      [| "4" |];
      [| "5" |];
      [| "6" |];
      [| "7" |];
      [| "8" |];
      [| "9" |];
      [| "10" |];
      [| "11" |];
      [| "12" |];
      [| "13" |];
    ]
