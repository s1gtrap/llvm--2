open Llvm__2

let task parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  List.iteri
    (fun i n ->
      Printf.printf "%d {%s}\t%s\n" i
        (Ll.mapcat ","
           (fun v -> string_of_int (Cfg.G.V.label v))
           (Cfg.G.succ g ids.(i)))
        (Cfg.string_of_insn n))
    insns;
  ()

let task2 parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  Lva.print insns ids g in_ out;
  ()

let task3 parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let itf = Lva.interf insns in_ out in
  Printf.printf "%s\n" (Lva.dot itf);
  ()

let task4 parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let itf = Lva.interf insns in_ out in
  let _asn = Regalloc.alloc itf in
  ()

let () =
  let usage_msg = "llvm__2 [-v] -p <parser> <file1> [<file2>] ..." in
  let verbose = ref false in
  let input_files = ref [] in
  let parser = ref "" in
  let oper = ref "" in
  let anon_fun filename = input_files := filename :: !input_files in

  let speclist =
    [
      ("-v", Arg.Set verbose, "Output debug information");
      ("-p", Arg.Set_string parser, "Set input parser type");
      ("-o", Arg.Set_string oper, "Set operation to apply");
    ]
  in

  Arg.parse speclist anon_fun usage_msg;

  let parser =
    match !parser with
    | "cfg" -> Llparser.cfgeof
    | _ ->
        Printf.eprintf "invalid parser type: %s\n" !parser;
        exit 1
  in

  let oper =
    match !oper with
    | "cfg" -> task
    | "lva" -> task2
    | "itf" -> task3
    | "x86" -> task4
    | _ ->
        Printf.eprintf "invalid operation: %s\n" !oper;
        exit 1
  in

  List.map (function "-" -> Stdlib.stdin | f -> open_in f) !input_files
  |> List.iter (oper parser);

  ()
