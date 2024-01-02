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
        match n with
        | Cfg.Label _ -> Printf.printf "\t%s\n" (Cfg.string_of_insn n)
        | _ ->
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

let progitf (alc : Regalloc.allocator) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let prefs = Lva.prefer insns in
    let l, itf = Lva.interf fdecl.param insns in_ out in
    (* FIXME: harcoded k *)
    let _, itf = Regalloc.coalesce alc prefs (l, itf) in
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

let progx86 (alloc_ : Regalloc.allocator) debug input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog alloc_ debug prog in
  Printf.printf "%s\n" (Regalloc.string_of_prog prog)

let progexe output cargs (alloc_ : Regalloc.allocator) debug input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog alloc_ debug prog in
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

let progprefs input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let insns = Cfg.flatten fdecl.cfg in
    let prefs = Lva.prefer insns in
    Symbol.ST.iter
      (fun k v ->
        Printf.printf "%s: " (Symbol.name k);
        Symbol.SS.iter (fun v -> Printf.printf "%s " (Symbol.name v)) v;
        Printf.printf "\n")
      prefs
  in
  List.iter fdecl prog.fdecls

let () =
  let usage_msg = "llvm__2 [-v] -p <parser> <file1> [<file2>] ..." in
  let verbose = ref false in
  let input_files = ref [] in
  let oper = ref "" in
  let out = ref "" in
  let clang = ref "" in
  let alloc = ref "" in
  let n = ref 12 in
  let debug = ref false in
  let anon_fun filename = input_files := filename :: !input_files in

  let speclist =
    [
      ("-v", Arg.Set verbose, "Output debug information");
      ("-t", Arg.Set_string oper, "Set operation to apply");
      ("-o", Arg.Set_string out, "Set output file");
      ("-c", Arg.Set_string clang, "Set clang parameters");
      ("-a", Arg.Set_string alloc, "Set register allocator");
      ("-n", Arg.Set_int n, "Set number of working registers");
      ("-d", Arg.Set debug, "Debug symbols for LLVM-- instructions");
    ]
  in

  Arg.parse speclist anon_fun usage_msg;

  let alc = Regalloc.allocator_of_string !n !alloc in

  let oper =
    match !oper with
    | "cfg" -> progcfg
    | "lva" | "dataflow" -> proglva
    | "itf" | "interf" | "dot" -> progitf alc
    | "asn" -> progasn alc
    | "x86" -> progx86 alc !debug
    | "prefs" -> progprefs
    | _ ->
        fun input ->
          let out =
            match !out with
            | "" -> Filename.basename (Filename.remove_extension input)
            | out -> out
          in
          progexe out [| !clang |] alc !debug input
  in
  List.iter oper !input_files
