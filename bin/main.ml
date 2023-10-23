open Llvm__2

let cfgcfg parser input =
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

let cfglva parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  Lva.print insns ids g in_ out;
  ()

let cfgitf parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let _, itf = Lva.interf insns in_ out in
  Printf.printf "%s\n" (Lva.dot itf);
  ()

let cfgx86 parser input =
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let lbls, itf = Lva.interf insns in_ out in
  let _asn = Regalloc.alloc lbls itf in
  ()

let fdeclcfg input =
  let _name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  List.iteri
    (fun i n ->
      Printf.printf "%d {%s}\t%s\n" i
        (Ll.mapcat ","
           (fun v -> string_of_int (Cfg.G.V.label v))
           (Cfg.G.succ g ids.(i)))
        (Cfg.string_of_insn n))
    insns;
  ()

let fdecllva input =
  let _name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  let in_, out = Lva.dataflow insns ids g in
  Lva.print insns ids g in_ out;
  ()

let fdeclitf input =
  let _name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  let in_, out = Lva.dataflow insns ids g in
  let _, itf = Lva.interf insns in_ out in
  Printf.printf "%s\n" (Lva.dot itf);
  ()

let fdeclx86 input =
  let name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  let in_, out = Lva.dataflow insns ids g in
  let lbls, itf = Lva.interf insns in_ out in
  let _asn = Regalloc.alloc lbls itf in
  let tys, _ = fdecl.fty in
  let args = List.combine fdecl.param tys in
  let x86 = Regalloc.compile_fdecl args name fdecl in
  Printf.printf "%s" (Regalloc.string_of_prog x86);
  ()

let progcfg input =
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    List.iteri
      (fun i n ->
        Printf.printf "%d {%s}\t%s\n" i
          (Ll.mapcat ","
             (fun v -> string_of_int (Cfg.G.V.label v))
             (Cfg.G.succ g ids.(i)))
          (Cfg.string_of_insn n))
      insns;
    ()
  in
  List.iter fdecl prog.fdecls

let proglva input =
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    Lva.print insns ids g in_ out;
    ()
  in
  List.iter fdecl prog.fdecls

let progitf input =
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let _, itf = Lva.interf insns in_ out in
    Printf.printf "%s\n" (Lva.dot itf);
    ()
  in
  List.iter fdecl prog.fdecls

let progasn input =
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let lbl, itf = Lva.interf insns in_ out in
    let asn = Regalloc.alloc lbl itf in
    Symbol.ST.iter (fun k v -> Printf.printf "%s: %d\n" (Symbol.name k) v) asn
  in
  List.iter fdecl prog.fdecls

let progx86 input =
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog prog in
  Printf.printf "%s\n" (Regalloc.string_of_prog prog)

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

  match !parser with
  | "cfg" ->
      let oper =
        match !oper with
        | "cfg" -> cfgcfg
        | "lva" -> cfglva
        | "itf" -> cfgitf
        | "x86" -> cfgx86
        | _ ->
            Printf.eprintf "invalid operation: %s\n" !oper;
            exit 1
      in
      List.map (function "-" -> Stdlib.stdin | f -> open_in f) !input_files
      |> List.iter (oper Llparser.cfgeof)
  | "fdecl" ->
      let oper =
        match !oper with
        | "cfg" -> fdeclcfg
        | "lva" -> fdecllva
        | "itf" -> fdeclitf
        | "x86" -> fdeclx86
        | _ ->
            Printf.eprintf "invalid operation: %s\n" !oper;
            exit 1
      in
      List.map (function "-" -> Stdlib.stdin | f -> open_in f) !input_files
      |> List.iter oper
  | "prog" ->
      let oper =
        match !oper with
        | "cfg" -> progcfg
        | "lva" -> proglva
        | "itf" -> progitf
        | "asn" -> progasn
        | "x86" -> progx86
        | _ ->
            Printf.eprintf "invalid operation: %s\n" !oper;
            exit 1
      in
      List.map (function "-" -> Stdlib.stdin | f -> open_in f) !input_files
      |> List.iter oper
  | _ ->
      Printf.eprintf "invalid parser type: %s\n" !parser;
      exit 1
