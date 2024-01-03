{
  open Llparserstrip
  module S = Symbol
  exception Error of string
  let error lexbuf msg =
    let position = Lexing.lexeme_start_p lexbuf in
    let err_str = Printf.sprintf "Lexing error in file %s at position %d:%d\n"
                  position.pos_fname position.pos_lnum (position.pos_cnum - position.pos_bol + 1)
                  ^ msg ^ "\n" in
    raise (Error err_str)
  let hex2str hex =
    "0x" ^ hex |> int_of_string
               |> Char.chr
               |> Printf.sprintf "%c"
}

let letter = ['a'-'z' 'A'-'Z']
let digit = ['0'-'9']
let hex = letter | digit
let idchar = letter | digit | ['.' '_' '-' '$']

rule token = parse
  | eof                { EOF }
  | ['\t' ' ']+
  | "nsw"
  | "nuw"
  | "noundef"
  | "nonnull"
  | "readnone"
  | "inbounds"
  | "signext"
  | "zeroext"
  | "nocapture"
  | "writeonly"
  | "noalias"
  | "readonly"
  | "immarg"
  | "exact"
  | "internal"
  | "local_unnamed_addr"
  | "dso_local"
  | "tail"
  | '#' digit+         { token lexbuf } (* ignored *)
  | ','? ['\t' ' ']+ "align" ['\t' ' ']+ digit+ { token lexbuf }
  | "dereferenceable(" digit+ ')' { token lexbuf }
  | '\n'               { Lexing.new_line lexbuf; token lexbuf }
  | '*'                { STAR }
  | ','                { COMMA }
  | ':'                { COLON }
  | '='                { EQUALS }
  | '('                { LPAREN }
  | ')'                { RPAREN }
  | '{'                { LBRACE }
  | '}'                { RBRACE }
  | '['                { LBRACKET }
  | ']'                { RBRACKET }
  | "..."              { ELLIPSIS }
  | "true"             { TRUE }
  | "false"            { FALSE }
  | "i1"               { I1 }
  | "i8"               { I8 }
  | "i16"              { I16 }
  | "i32"              { I32 }
  | "i64"              { I64 }
  | "to"               { TO }
  | "br"               { BR }
  | "eq"               { EQ }
  | "ne"               { NE }
  | "or"               { OR }
  | "and"              { AND }
  | "add"              { ADD }
  | "sub"              { SUB }
  | "mul"              { MUL }
  | "sdiv"             { SDIV }
  | "srem"             { SREM }
  | "udiv"             { UDIV }
  | "urem"             { UREM }
  | "xor"              { XOR }
  | "slt"              { SLT }
  | "sle"              { SLE }
  | "sgt"              { SGT }
  | "sge"              { SGE }
  | "ult"              { ULT }
  | "ule"              { ULE }
  | "ugt"              { UGT }
  | "uge"              { UGE }
  | "shl"              { SHL }
  | "ptr"              { PTR }
  | "ret"              { RET }
  | "unreachable"      { UNREACHABLE }
  | "getelementptr"    { GEP }
  | "zext"             { ZEXT }
  | "sext"             { SEXT }
  | "ptrtoint"         { PTRTOINT }
  | "trunc"            { TRUNC }
  | "select"           { SELECT }
  | "type"             { TYPE }
  | "null"             { NULL }
  | "lshr"             { LSHR }
  | "ashr"             { ASHR }
  | "call"             { CALL }
  | "icmp"             { ICMP }
  | "void"             { VOID }
  | "load"             { LOAD }
  | "store"            { STORE }
  | "label"            { LABEL }
  | "switch"           { SWITCH }
  | "external global"  { EXTGLOBAL }
  | "private unnamed_addr constant"
  | "internal global"
  | "internal constant"
  | "constant"
  | "global"           { GLOBAL }
  | "define"           { DEFINE }
  | "alloca"           { ALLOCA }
  | "bitcast"          { BITCAST }
  | "phi"              { PHI }
  | "declare"          { DECLARE }
  | '%' (idchar+ as i) { UID (S.symbol i) }
  | '@' (idchar+ as i) { GID (S.symbol i) }
  | "x"                           { CROSS } (* for Array types *)
  | '-'? digit+ as d              { INT (Int64.of_string d) }
  | idchar+ as i                  { LBL (S.symbol i) }
  | ";" ([^'\n']*) '\n'
  | ("target" | "attributes" | "source_filename") [^'\n']* '\n'
  | ',' ['\t' ' ']+ '!' [^'\n']* '\n'
  |  '!' [^'\n']* '\n'            { Lexing.new_line lexbuf; token lexbuf } (* ignored *)
  | "c\""                         { string "" lexbuf }
  | _ as c                        { error lexbuf @@ "Unexpected character: " ^ Char.escaped c }

and string current = parse
  | '\"'                { STRING current }
  | '\n'                { error lexbuf "Illegal newline in string" }
  | '\\' ['\\' '\"'] as e
                        { string (current^(Scanf.unescaped e)) lexbuf }
  | '\\' (hex hex as h)
                        { string (current^(hex2str h)) lexbuf }
  | [' '-'~']           { string (current^(Lexing.lexeme lexbuf)) lexbuf }
  | eof                 { error lexbuf "Unclosed string at end of file" }
  | _ as c              { error lexbuf @@ "Illegal character '" ^ (String.make 1 c) ^ "'" }
