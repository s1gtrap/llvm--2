(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(* Do not distribute                                                      *)
(**************************************************************************)

{
  open Tigerparser.Parser  
  exception Error of string
  let error lexbuf msg =
    let position = Lexing.lexeme_start_p lexbuf in
    let err_str = Printf.sprintf "Lexing error in file %s at position %d:%d\n"
                  position.pos_fname position.pos_lnum (position.pos_cnum - position.pos_bol + 1)
                  ^ msg ^ "\n" in
    raise (Error err_str)
}

let digit     = ['0'-'9']
let digits    = digit+
let alpha     = ['a'-'z' 'A'-'Z']
let ident     = alpha (digit | alpha | '_')*
let string    = (alpha | digit | ' ' | '.')*
let printable = [' '-'~']
let controls  = ['@' 'A'-'Z' 'a'-'z' '[' '\\' ']' '^' '_' '?']
let formchars = ['\t' '\b' ' ' '\013' '\r' '\015']

(* add more named regexps here *)

(* an entrypoint with a few starting regexps *)
rule token = parse
  [' ' '\t' ]     { token lexbuf }     (* skip blanks *)
| '\n'                { Lexing.new_line lexbuf ; token lexbuf }
| (digits alpha) as i { error lexbuf ("Invalid integer '" ^ i ^ "'") }
| eof                 { EOF }
| ','                 { COMMA }
| ':'                 { COLON }
| ';'                 { SEMICOLON }
| '('                 { LPAREN }
| ')'                 { RPAREN }
| '['                 { LBRACK }
| ']'                 { RBRACK }
| '{'                 { LBRACE }
| '}'                 { RBRACE }
| '.'                 { DOT }
| '+'                 { PLUS }
| '-'                 { MINUS }
| '*'                 { TIMES }
| '/'                 { DIVIDE }
| '='                 { EQ }
| "<>"                { NEQ }
| '<'                 { LT }
| "<="                { LE }
| '>'                 { GT }
| ">="                { GE }
| '&'                 { AND }
| '|'                 { OR }
| ":="                { ASSIGN }
| "array"             { ARRAY }
| "if"                { IF }
| "then"              { THEN }
| "else"              { ELSE }
| "while"             { WHILE }
| "for"               { FOR }
| "to"                { TO }
| "do"                { DO }
| "let"               { LET }
| "in"                { IN }
| "end"               { END }
| "of"                { OF }
| "break"             { BREAK }
| "nil"               { NIL }
| "function"          { FUNCTION }
| "var"               { VAR }
| "type"              { TYPE }
| '^'                 { CARET }
| digits as i         { INT (try Int64.of_string i with Failure _ -> error lexbuf (Printf.sprintf "Invalid integer '%s'" i)) }
| ident  as i         { ID i }
| "/*" { comment 0 lexbuf } (* call into another entrypoint *)
| '"'                 { let p = lexbuf.lex_start_p in
                        let ret : token = string "" lexbuf in lexbuf.lex_start_p <- p; ret }
(* default error handling *)
| _ as t              { error lexbuf ("Invalid character '" ^ (String.make 1 t) ^ "'") }

and formfeed str = parse 
  | '\n' { Lexing.new_line lexbuf ; formfeed str lexbuf }
  | '\\' { string str lexbuf }
  | formchars  { formfeed str lexbuf }
  | eof    { error lexbuf "Unexpected EOF" }
  | _ as c { error lexbuf (Printf.sprintf "Invalid form feed character %c" c) }

and control str = parse
  | '@'    { string (str ^ (String.make 1 (char_of_int 0))) lexbuf }
  | '['    { string (str ^ (String.make 1 (char_of_int 0x1b))) lexbuf }
  | '\\'    { string (str ^ (String.make 1 (char_of_int 0x1c))) lexbuf }
  | ']'    { string (str ^ (String.make 1 (char_of_int 0x1d))) lexbuf }
  | '^'    { string (str ^ (String.make 1 (char_of_int 0x1e))) lexbuf }
  | '_'    { string (str ^ (String.make 1 (char_of_int 0x1f))) lexbuf }
  | '?'    { string (str ^ (String.make 1 (char_of_int 0x7f))) lexbuf }
  | ['A'-'Z'] as c    { string (str ^ (String.make 1 (char_of_int ((int_of_char c)-64) ))) lexbuf }
  | ['a'-'z'] as c    { string (str ^ (String.make 1 (char_of_int ((int_of_char c)-96) ))) lexbuf }
  | controls { string str lexbuf }
  | eof    { error lexbuf "Unexpected EOF" }
  | _ as c { error lexbuf (Printf.sprintf "Illegal control character: %c" c)}

and escape str = parse
  | '^'  { control str lexbuf }
  | '"'  { string (str ^ String.make 1 '"') lexbuf }
  | 't'  { string (str ^ String.make 1 '\t') lexbuf }
  | 'n'  { string (str ^ String.make 1 '\n') lexbuf }
  | '\n' { Lexing.new_line lexbuf; formfeed str lexbuf }
  | formchars { formfeed str lexbuf }
  | '\\' { string (str ^ String.make 1 '\\') lexbuf }
  | (['0'-'9'] ['0'-'9'] ['0'-'9']) as i { string (str ^ (String.make 1 (try char_of_int (int_of_string i) with Invalid_argument _ -> error lexbuf "Invalid escape number"))) lexbuf }
  | '1' { string (str ^ String.make 1 '0') lexbuf }
  | eof    { error lexbuf "Unexpected EOF" }
  | _ as c { error lexbuf (Printf.sprintf "Illegal escape character: %c" c)}

and string str =
  parse
  | '\\'   { escape str lexbuf }
  | '"'    { STRING str }
  | '\n'   { error lexbuf "Unexpected newline" }
  | eof    { error lexbuf "Unexpected EOF" }
  | printable as c { string (str ^ String.make 1 c) lexbuf }
  | _ as c { error lexbuf (Printf.sprintf "Illegal character: %c" c)}

and comment commentLevel = parse
| '\n' { Lexing.new_line lexbuf; comment commentLevel lexbuf }
| "/*" { comment (commentLevel+1 ) lexbuf } (* recursively tail-call oneself *)
| "*/" { (if commentLevel = 0 then token else comment (commentLevel-1) ) lexbuf }
| eof  { error lexbuf "Unexpected EOF" }
| _    { comment commentLevel lexbuf } (* contiune *)
