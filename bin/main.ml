open Llvm__2

let take parser input =
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

let take2 parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  List.iteri
    (fun i n ->
      let sos s = Ll.mapcat "," Symbol.name (Symbol.SS.elements s) in
      Printf.printf "{%s}\t{%s}\t%s\n"
        (sos in_.(i))
        (sos out.(i))
        (Cfg.string_of_insn n))
    insns;
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
    | "cfg" -> take
    | "lva" -> take2
    | _ ->
        Printf.eprintf "invalid operation: %s\n" !oper;
        exit 1
  in

  List.map (function "-" -> Stdlib.stdin | f -> open_in f) !input_files
  |> List.iter (oper parser);

  ()
