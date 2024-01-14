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
        | Cfg.Label _ -> Printf.printf "%d\t%s\n" i (Cfg.string_of_insn n)
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

let proglva ?(v = 0) ?(r = false) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g ~v ~r in
    Lva.print insns ids g in_ out;
    ()
  in
  List.iter fdecl prog.fdecls

let progitf (alc : Common.allocator) input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let in_, out = Lva.dataflow insns ids g in
    let prefs = Coalesce.prefer insns in
    let l, itf = Lva.interf fdecl.param insns in_ out in
    (* FIXME: harcoded k *)
    let _, itf = Coalesce.coalesce alc prefs (l, itf) in
    Printf.printf "%s\n" (Lva.dot itf);
    ()
  in
  List.iter fdecl prog.fdecls

let proglra input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let fdecl ((name, fdecl) : _ * Ll.fdecl) =
    Printf.printf "%s:\n" (Symbol.name name);
    let ids, g = Cfg.graph fdecl.cfg in
    let insns = Cfg.flatten fdecl.cfg in
    let df = Lva.dataflow insns ids g in
    Linear.print (List.mapi (fun i n -> (i, n)) insns) df
  in
  List.iter fdecl prog.fdecls

let progasn (alloc_ : Common.allocator) input =
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
        Printf.printf "%s: %s\n" (Symbol.name k) (X86.string_of_operand v))
      asn
  in
  List.iter fdecl prog.fdecls

let progx86 (alloc_ : Common.allocator) debug input =
  let input = open_ input in
  let prog = Parse.from_channel Llparser.prog input in
  let prog = Regalloc.compile_prog alloc_ debug prog in
  Printf.printf "%s\n" (Regalloc.string_of_prog prog)

let progexe output cargs (alloc_ : Common.allocator) debug input =
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
    let prefs = Coalesce.prefer insns in
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
  let reverse = ref false in
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
      ("-r", Arg.Set reverse, "Reverse instructions before dataflow analysis");
      ("-t", Arg.Set_string oper, "Set operation to apply");
      ("-o", Arg.Set_string out, "Set output file");
      ("-c", Arg.Set_string clang, "Set clang parameters");
      ("-a", Arg.Set_string alloc, "Set register allocator");
      ("-n", Arg.Set_int n, "Set number of working registers");
      ("-d", Arg.Set debug, "Debug symbols for LLVM-- instructions");
    ]
  in
  let rec countflags flag = function
    | arg :: args when String.starts_with ~prefix:"-" arg ->
        let rec countchars = function
          | c :: tail when c = flag -> 1 + countchars tail
          | _ :: tail -> countchars tail
          | _ -> 0
        in
        countchars (List.init (String.length arg) (String.get arg))
        + countflags flag args
    | _ :: args -> countflags flag args
    | _ -> 0
  in
  let verbose = countflags 'v' (Array.to_list Sys.argv) in

  Arg.parse speclist anon_fun usage_msg;

  let alc = Common.allocator_of_string !n !alloc in

  let oper =
    match !oper with
    | "cfg" -> progcfg
    | "lva" | "dataflow" -> proglva ~v:verbose ~r:(Bool.not !reverse)
    | "itf" | "interf" | "dot" -> progitf alc
    | "lra" -> proglra
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
