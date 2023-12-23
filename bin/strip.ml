open Llvm__2

let open_ = function "-" -> Stdlib.stdin | f -> open_in f

let initLexer (lexbuf : Lexing.lexbuf) =
  (* obs that we need to initialize the pos_fname field ourselves *)
  lexbuf.lex_curr_p <- lexbuf.lex_curr_p;
  (input, lexbuf)

let from_channel input =
  let lexbuf = Lexing.from_channel input in
  let _, filebuf = initLexer lexbuf in
  let parseRes =
    try Llparserstrip.prog Lllexerstrip.token filebuf with
    | Lllexerstrip.Error msg ->
        Printf.eprintf "%s%!" msg;
        failwith "lex"
    | Llparserstrip.Error ->
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
  (* XXX: might still leak on exception: *)
  close_in input;
  parseRes

let strip t = open_ t |> from_channel |> Ll.string_of_prog
let () = strip Sys.argv.(1) |> Printf.printf "%s"
