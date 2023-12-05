open Llvm__2

let open_ = function "-" -> Stdlib.stdin | f -> open_in f

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
    let prefs = Lva.prefer insns in
    let l, itf = Lva.interf fdecl.param insns in_ out in
    let _, itf = Lva.coalesce_briggs prefs (l, itf) in
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
    let df = Lva.dataflow insns ids g in
    let asn = Regalloc.alloc alloc_ [] insns df in
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
  let oper = ref "" in
  let out = ref "" in
  let clang = ref "" in
  let alloc = ref "" in
  let anon_fun filename = input_files := filename :: !input_files in

  let speclist =
    [
      ("-v", Arg.Set verbose, "Output debug information");
      ("-t", Arg.Set_string oper, "Set operation to apply");
      ("-o", Arg.Set_string out, "Set output file");
      ("-c", Arg.Set_string clang, "Set clang parameters");
      ("-a", Arg.Set_string alloc, "Set register allocator");
    ]
  in

  Arg.parse speclist anon_fun usage_msg;

  let alc = Regalloc.allocator_of_string !alloc in

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
