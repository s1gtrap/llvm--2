open Llvm__2

let initLexer filename =
  let input = open_in filename in
  let filebuf = Lexing.from_channel input in
  (* obs that we need to initialize the pos_fname field ourselves *)
  filebuf.lex_curr_p <- { filebuf.lex_curr_p with pos_fname = filename };
  (input, filebuf)

let llvmparse file =
  let input, filebuf = initLexer file in
  let parseRes =
    try Llparser.prog Lllexer.token filebuf with
    | Lllexer.Error msg ->
        Printf.eprintf "%s%!" msg;
        failwith "lex"
    | Llparser.Error ->
        let pos1 = Lexing.lexeme_start_p filebuf in
        let pos2 = Lexing.lexeme_end_p filebuf in
        let lexeme = Lexing.lexeme filebuf in
        Printf.fprintf stderr "%s:%d:%d - %d:%d: syntax error '%s'\n"
          pos1.pos_fname pos1.pos_lnum
          (pos1.pos_cnum - pos1.pos_bol)
          pos2.pos_lnum
          (pos2.pos_cnum - pos2.pos_bol + 1)
          lexeme;
        failwith "par"
  in
  close_in input;
  parseRes

let () =
  let { fdecls; _ } : Ll.prog = llvmparse Sys.argv.(1) in
  List.iter
    (fun (gid, fdecl) ->
      Printf.printf "%s" (Ll.string_of_named_fdecl (gid, fdecl));
      let lva = Lva.lva_of_fdecl fdecl in
      Printf.printf "%s\n\n" (Symbol.string_of_table Symbol.print_pair lva);
      let graph = Lva.graph_of_lva lva in
      Printf.printf "%s\n" (Graph.to_string graph))
    fdecls
