open Llvm__2

let open_ = function "-" -> Stdlib.stdin | f -> open_in f

let cfgcfg parser input =
  let input = open_ input in
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
  let input = open_ input in
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  Lva.print insns ids g in_ out;
  ()

let cfgitf parser input =
  let input = open_ input in
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let _, itf = Lva.interf [] insns in_ out in
  Printf.printf "%s\n" (Lva.dot itf);
  ()

let cfgx86 parser input =
  let input = open_ input in
  let cfg = Parse.from_channel parser input in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let lbls, itf = Lva.interf [] insns in_ out in
  let _asn = Regalloc.alloc Regalloc.Ocamlgraph lbls itf in
  ()

let fdeclcfg input =
  let input = open_ input in
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
  let input = open_ input in
  let _name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  let in_, out = Lva.dataflow insns ids g in
  Lva.print insns ids g in_ out;
  ()

let fdeclitf input =
  let input = open_ input in
  let _name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let ids, g = Cfg.graph fdecl.cfg in
  let insns = Cfg.flatten fdecl.cfg in
  let in_, out = Lva.dataflow insns ids g in
  let _, itf = Lva.interf fdecl.param insns in_ out in
  Printf.printf "%s\n" (Lva.dot itf);
  ()

let fdeclx86 alc input =
  let input = open_ input in
  let name, fdecl = Parse.from_channel Llparser.fdecleof input in
  let tys, _ = fdecl.fty in
  let args = List.combine fdecl.param tys in
  let x86 = Regalloc.compile_fdecl alc args name fdecl in
  Printf.printf "%s" (Regalloc.string_of_prog x86);
  ()

let progcfg input =
  let input = open_ input in
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
  let input = open_ input in
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
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let _, itf = Lva.interf fdecl.param insns in_ out in
    Printf.printf "%s\n" (Lva.dot itf);
    ()
  in
  List.iter fdecl prog.fdecls

let progasn (alloc_ : Regalloc.allocator) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let lbl, itf = Lva.interf fdecl.param insns in_ out in
    let asn = Regalloc.alloc alloc_ lbl itf in
    Symbol.ST.iter
      (fun k v ->
        Printf.printf "%s: %s\n" (Symbol.name k) (Regalloc.string_of_operand v))
      asn
  in
  List.iter fdecl prog.fdecls

let progx86 (alloc_ : Regalloc.allocator) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog alloc_ prog in
  Printf.printf "%s\n" (Regalloc.string_of_prog prog)

let progexe output cargs (alloc_ : Regalloc.allocator) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog alloc_ prog in
  let prog = Regalloc.string_of_prog prog in
  let _ =
    (match Llvm__2.Regalloc.os with
    | Darwin ->
        Build.create_process_with_input "clang"
          (Array.concat
             [
               [| "clang"; "-target"; "x86_64-unknown-darwin" |];
               cargs;
               [| "-x"; "assembler"; "-o"; output |];
             ])
    | Linux ->
        Build.create_process_with_input "clang"
          (Array.concat
             [ [| "clang" |]; cargs; [| "-x"; "assembler"; "-o"; output |] ]))
      prog output
  in
  ()

let () =
  let usage_msg = "llvm__2 [-v] -p <parser> <file1> [<file2>] ..." in
  let verbose = ref false in
  let input_files = ref [] in
  let parser = ref "" in
  let oper = ref "" in
  let out = ref "" in
  let clang = ref "" in
  let alloc = ref "" in
  let anon_fun filename = input_files := filename :: !input_files in

  let speclist =
    [
      ("-v", Arg.Set verbose, "Output debug information");
      ("-p", Arg.Set_string parser, "Set input parser type");
      ("-t", Arg.Set_string oper, "Set operation to apply");
      ("-o", Arg.Set_string out, "Set output file");
      ("-c", Arg.Set_string clang, "Set clang parameters");
      ("-a", Arg.Set_string alloc, "Set register allocator");
    ]
  in

  Arg.parse speclist anon_fun usage_msg;

  let alc =
    match !alloc with
    | "ocamlgraph" -> Regalloc.Ocamlgraph
    | "greedy" -> Regalloc.Greedy
    | "briggs" | _ -> Regalloc.Briggs
    | "liscan" | _ -> Regalloc.Linearscan
  in

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
      List.iter (oper Llparser.cfgeof) !input_files
  | "fdecl" ->
      let oper =
        match !oper with
        | "cfg" -> fdeclcfg
        | "lva" -> fdecllva
        | "itf" -> fdeclitf
        | "x86" -> fdeclx86 alc
        | _ ->
            Printf.eprintf "invalid operation: %s\n" !oper;
            exit 1
      in
      List.iter oper !input_files
  | _ ->
      let oper =
        match !oper with
        | "cfg" -> progcfg
        | "lva" -> proglva
        | "itf" -> progitf
        | "asn" -> progasn alc
        | "x86" -> progx86 alc
        | _ ->
            fun input ->
              let out =
                match !out with
                | "" -> Filename.basename (Filename.remove_extension input)
                | out -> out
              in
              progexe out [| !clang |] alc input
      in
      List.iter oper !input_files
