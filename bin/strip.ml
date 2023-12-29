open Llvm__2
module S = Symbol

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

let strip_intrins_of_operand = function
  | Ll.Gid s when S.name s = "llvm.memset.p0.i64" -> Ll.Gid (S.symbol "memset")
  | Ll.Gid s when S.name s = "llvm.memcpy.p0.p0.i64" ->
      Ll.Gid (S.symbol "memcpy")
  | op -> op

let strip_intrins_of_typed_operand (t, o) = (t, strip_intrins_of_operand o)

let strip_intrins_of_insn (d, i) =
  ( d,
    match i with
    | Ll.Binop (b, t, o1, o2) ->
        Ll.Binop (b, t, strip_intrins_of_operand o1, strip_intrins_of_operand o2)
    | AllocaN (t, (tn, on)) -> AllocaN (t, (tn, strip_intrins_of_operand on))
    | Load (t, o) -> Load (t, strip_intrins_of_operand o)
    | Store (t, o1, o2) ->
        Store (t, strip_intrins_of_operand o1, strip_intrins_of_operand o2)
    | Icmp (c, t, o1, o2) ->
        Icmp (c, t, strip_intrins_of_operand o1, strip_intrins_of_operand o2)
    | Call (t, o, ol) ->
        Call
          ( t,
            strip_intrins_of_operand o,
            List.map strip_intrins_of_typed_operand ol )
    | Bitcast (t1, o, t2) -> Bitcast (t1, strip_intrins_of_operand o, t2)
    | Gep (t, (t1, o1), ol) ->
        Gep
          ( t,
            (t1, strip_intrins_of_operand o1),
            List.map strip_intrins_of_typed_operand ol )
    | Zext (t1, o, t2) -> Zext (t1, strip_intrins_of_operand o, t2)
    | Sext (t1, o, t2) -> Sext (t1, strip_intrins_of_operand o, t2)
    | Ptrtoint (t1, o, t2) -> Ptrtoint (t1, strip_intrins_of_operand o, t2)
    | Trunc (t1, o, t2) -> Trunc (t1, strip_intrins_of_operand o, t2)
    | PhiNode (t, ol) ->
        PhiNode (t, List.map (fun (o, l) -> (strip_intrins_of_operand o, l)) ol)
    | Select (o, to1, to2) ->
        Select
          ( strip_intrins_of_operand o,
            strip_intrins_of_typed_operand to1,
            strip_intrins_of_typed_operand to2 )
    | i -> i )

let strip_intrins_of_terminator = function
  | Ll.Ret (t, o) -> Ll.Ret (t, Option.map strip_intrins_of_operand o)
  | Br l -> Br l
  | Cbr (o, l1, l2) -> Cbr (strip_intrins_of_operand o, l1, l2)
  | Unreachable -> Unreachable
  | Switch (t, o, e, l) -> Switch (t, strip_intrins_of_operand o, e, l)

let strip_intrins_of_block ((name, block) : 'a * Ll.block) : 'a * Ll.block =
  ( name,
    {
      insns = List.map strip_intrins_of_insn block.insns;
      terminator = strip_intrins_of_terminator block.terminator;
    } )

let strip_intrins_of_cfg (hd, tl) =
  (strip_intrins_of_block hd, List.map strip_intrins_of_block tl)

let strip_intrins_of_fdecl ((name, fdecl) : _ * Ll.fdecl) =
  (name, { fdecl with cfg = strip_intrins_of_cfg fdecl.cfg })

let strip_intrins_of_prog (prog : Ll.prog) =
  { prog with fdecls = List.map strip_intrins_of_fdecl prog.fdecls }

let () =
  open_ Sys.argv.(1)
  |> from_channel |> strip_intrins_of_prog |> Ll.string_of_prog
  |> Printf.printf "%s"
