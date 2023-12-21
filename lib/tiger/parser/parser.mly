(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(* Do not distribute                                                      *)
(**************************************************************************)

%{
  open Tigercommon.Absyn   
  open Tigercommon.Symbol   
  open ParserAux 
%}

%token EOF
%token <string> ID
%token <int64> INT 
%token <string> STRING 
%token COMMA COLON SEMICOLON 
%token LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE 
%token DOT PLUS MINUS TIMES DIVIDE EQ NEQ LT LE GT GE 
%token AND OR ASSIGN ARRAY IF THEN ELSE WHILE FOR TO DO
%token LET IN END OF BREAK NIL FUNCTION VAR TYPE CARET 
%token UMINUS

%nonassoc ASSIGN THEN DO
%nonassoc ELSE
%left OR
%left AND
%nonassoc EQ NEQ LT LE GT GE
%left PLUS MINUS 
%left DIVIDE TIMES
%right CARET
%left UMINUS

%start <Tigercommon.Absyn.exp> program  
(* Observe that we need to use fully qualified types for the start symbol *)

%%
(* Expressions *)
exp_base:
| NIL       { NilExp}
| i=INT     { IntExp i }
| s=STRING  { StringExp s }

%inline oper:
| EQ      { EqOp }
| NEQ     { NeqOp }
| LT      { LtOp }
| LE      { LeOp }
| GT      { GtOp }
| GE      { GeOp }
| PLUS    { PlusOp }
| MINUS   { MinusOp }
| TIMES   { TimesOp }
| DIVIDE  { DivideOp }
| CARET   { ExponentOp }

(* Top-level *)
program: e = exp EOF { e }

rec_exp:
| ty=ID; LBRACE; f=separated_list(COMMA, exp_field); RBRACE { RecordExp{ fields=f; typ=symbol ty }}
exp_field:
| name=ID; EQ; e=exp { (symbol name, e) }
 
typ:
| n=ID  { NameTy ((symbol n, $startpos)) }
| LBRACE; f=separated_list(COMMA, typ_field); RBRACE { RecordTy f }
| ARRAY; OF; typ=ID { ArrayTy (symbol typ, $startpos) }
typ_field:
| name=ID; COLON; typ=ID { Field{ name=symbol name; escape=ref true; typ=(symbol typ, $startpos); pos=$startpos} }

field:
| i = ID; COLON; t = ID { Field {name = symbol i; escape = ref true; typ = (symbol t, $startpos); pos = $startpos} }

var_decl:
| VAR; v=ID; ASSIGN; e=exp  { VarDec {name=symbol v; escape=ref true; typ=None; init=e; pos=$startpos} }
| VAR; v=ID; COLON; t=ID; ASSIGN; e=exp  { VarDec {name=symbol v; escape=ref true; typ=Some (symbol t, $startpos); init=e; pos=$startpos} }
typ_decl:
| TYPE; v=ID; EQ; t=typ     { Tdecl {name=symbol v; ty=t; pos=$startpos} }
fun_decl:
| FUNCTION; i = ID; LPAREN; p=separated_list(COMMA, field); RPAREN; EQ; e=exp   { Fdecl{name=symbol i;params=p;result=None;body=e;pos=$startpos} }
| FUNCTION; i = ID; LPAREN; p=separated_list(COMMA, field); RPAREN; COLON; t = ID; EQ; e = exp {Fdecl {name = symbol i; params = p; result = Some (symbol t, $startpos); body = e; pos=$startpos} }
decls:
| v=var_decl; ds=decls   { [v]@ds }
| t=typ_decl; ds=decls   { match ds with
                           | TypeDec(h)::l -> TypeDec(t::h)::l
                           | l -> TypeDec([t])::l }
| f=fun_decl; ds=decls   { match ds with
                           | FunctionDec(h)::l -> FunctionDec(f::h)::l
                           | l -> FunctionDec([f])::l }
| {[]}

let_exp:
| LET; d=decls; IN; b=separated_list(SEMICOLON, exp); END  { LetExp {decls=d; body=SeqExp(b) ^! $startpos} }

seq_exp:
| LPAREN; e=separated_list(SEMICOLON, exp); RPAREN  { SeqExp e }

bin_exp:
| l=exp; o=oper; r=exp  { OpExp {left=l;oper=o;right=r} }


neg_exp:
| MINUS e=exp %prec UMINUS  { OpExp {left=(IntExp(0L) ^! $startpos);oper=MinusOp;right=e} }

if_exp:
| IF; e1=exp; THEN; e2=exp; ELSE; e3=exp { IfExp{ test=e1; thn=e2; els=Some(e3)} }
| IF; e1=exp; THEN; e2=exp { IfExp{ test=e1; thn=e2; els=None} }


and_exp:
| e1=exp; AND; e2=exp { IfExp{ test=e1; thn=e2; els=Some(IntExp(0L) ^! $startpos)} ^! $startpos }

or_exp:
| e1=exp; OR; e2=exp { IfExp{ test=e1; thn=IntExp(1L) ^! $startpos; els=Some(e2) } ^! $startpos }


ass_exp:
| l=lvalue; ASSIGN; e=exp { AssignExp{ var=l; exp=e} }

while_exp:
| WHILE; c=exp; DO; b=exp  { WhileExp {test=c;body=b} }

for_exp:
| FOR; i=ID; ASSIGN; j=exp; TO; k=exp; DO; b=exp  { ForExp{var=symbol i;escape=ref true;lo=j;hi=k;body=b} }

lvaluepart:
| DOT; f=ID              { FieldPart (symbol f) }
| LBRACK; e=exp; RBRACK  { SubscriptPart e }
lvalue:
| id=ID; p=lvaluepart*  { makeLvaluePartSpec ((SimpleVar (symbol id)) ^@ $startpos) $startpos p }

call_exp:
| f=ID; LPAREN; p=separated_list(COMMA, exp); RPAREN  { CallExp{func=symbol f;args=p} }

arr_exp:
| name=ID; LBRACK; e1=exp; RBRACK; OF; e2=exp %prec OR { ArrayExp{ typ=symbol name; size=e1; init=e2 } }

break_exp:
| BREAK {BreakExp}


aix_exp:
| id=ID; p=lvaluepart*  { VarExp (makeLvaluePartSpec ((SimpleVar (symbol id)) ^@ $startpos) $startpos p) }

exp:
| e=aix_exp   { e ^! $startpos }
| e=call_exp  { e ^! $startpos }
| e=seq_exp   { e ^! $startpos }
| e=if_exp    { e ^! $startpos }
| e=let_exp   { e ^! $startpos }
| e=bin_exp   { e ^! $startpos }
| e=neg_exp   { e ^! $startpos }
| e=exp_base  { e ^! $startpos }
| e=rec_exp   { e ^! $startpos }
| e=ass_exp   { e ^! $startpos }
| e=while_exp { e ^! $startpos }
| e=for_exp   { e ^! $startpos }
| e=arr_exp   { e ^! $startpos }
| e=and_exp   { e }
| e=or_exp    { e }
| e=break_exp { e ^! $startpos }
