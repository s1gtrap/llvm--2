%{
  open Ll
%}

%token STAR COMMA COLON EQUALS EOF
%token LPAREN RPAREN LBRACE RBRACE LBRACKET RBRACKET
%token TYPE CROSS I1 I8 I32 I64 VOID PTR TRUE FALSE
%token ADD SUB MUL SDIV
%token EQ NE SLT SLE SGT SGE ULT ULE UGT UGE
%token AND OR XOR SHL LSHR ASHR SREM
%token RET BR TO NULL LABEL ENTRY GLOBAL EXTGLOBAL DEFINE UNREACHABLE
%token CALL ICMP LOAD STORE ALLOCA BITCAST GEP ZEXT SEXT PTRTOINT PHI TRUNC SELECT

%token <int64> INT        (* int64 values *)
%token <Symbol.symbol> LBL   (* labels *)
%token <Symbol.symbol> GID   (* global identifier *)
%token <Symbol.symbol> UID   (* local identifier *)
%token <string> STRING  (* string literals *)

%start <Ll.prog> prog
%start <Ll.cfg> cfgeof
%start <Symbol.symbol * Ll.fdecl> fdecleof
%%

%inline typed(X): t=ty x=X { (t,x) }

prog:
  | ds=decls EOF
    { ds }

decls:
  | ds = decls_rev
    { { tdecls = List.rev ds.tdecls
      ; gdecls = List.rev ds.gdecls
      ; fdecls = List.rev ds.fdecls
      ; extgdecls = List.rev ds.extgdecls
      ; extfuns = []
    } }

decls_rev:
  | (* empty *)
    { { tdecls = [] ; gdecls = [] ; fdecls = [] ; extgdecls = []; extfuns = []} }
  | ds=decls_rev f=fdecl
    { { ds with fdecls = f :: ds.fdecls }  }
  | ds=decls_rev g=gdecl
    { { ds with gdecls = g :: ds.gdecls }  }
  | ds=decls_rev g=extgdecl
    { { ds with extgdecls = g :: ds.extgdecls }  }
  | ds=decls_rev t=tdecl
    { { ds with tdecls = t :: ds.tdecls }  }

cfg: eb=entry_block bs=list(labeled_block) { (eb, bs) }

cfgeof: c=cfg EOF { c }

fdecl:
  | DEFINE t=ty l=GID
    LPAREN params=separated_list(COMMA,typed(UID)) RPAREN
    LBRACE cfg=cfg RBRACE
    { (l, { fty = (List.map fst params, t)
          ; param = List.map snd params
          ; cfg = cfg
          }
    ) }

fdecleof:
  fdecl=fdecl EOF { fdecl }

gdecl:
  | g=GID EQUALS GLOBAL tgi=typed(ginit)
    { (g, tgi) }

extgdecl:
  | g=GID EQUALS EXTGLOBAL t=ty
    { (g, t) }

tdecl:
  | tid=UID EQUALS TYPE t=ty
    { (tid, t) }

entry_block:
  | ENTRY COLON b=block     { b }
  | b=block                 { b }

block:
  | is=list(named_insn) t=terminator
    { { insns = is; terminator=t }  }

labeled_block:
  | l=INT COLON b=block
    { (S.symbol (Int64.to_string l),b) }
  | l=LBL COLON b=block
    { (l,b) }

terminator:
  | RET t=ty o=operand?
    { Ret (t, o) }
  | BR LABEL l=UID
    { Br l }
  | BR I1 o=operand COMMA LABEL l1=UID COMMA LABEL l2=UID
    { Cbr (o, l1, l2) }
  | UNREACHABLE { Unreachable }

operand:
  | NULL            { Null }
  | TRUE            { IConst64 1L }
  | FALSE           { IConst64 0L }
  | i=INT           { IConst64 i }
  | g=GID           { Gid g }
  | u=UID           { Id u }

ty:
  | t=ty STAR       { Ptr t }
  | PTR             { Ptr Void }
  | VOID            { Void }
  | I1              { I1 }
  | I8              { I8 }
  | I32             { I32 }
  | I64             { I64 }
  | LBRACE ts=ty_list RBRACE
    { Struct ts }
  | LBRACKET i=INT CROSS t=ty RBRACKET
    { Array (Int64.to_int i,t) }
  | rt=ty LPAREN ts=ty_list RPAREN
    { Fun (ts, rt) }
  | t=UID           { Namedt t }

ty_list:
  | ts=separated_list(COMMA,ty)
    { ts }

gep_path:
  | path=separated_nonempty_list(COMMA,typed(operand))
    { List.map snd path }

bop:
  | OR { Or }
  | ADD { Add }
  | SUB { Sub }
  | MUL { Mul }
  | SDIV { SDiv }
  | SHL { Shl }
  | XOR { Xor }
  | AND { And }
  | LSHR { Lshr }
  | ASHR { Ashr }
  | SREM { SRem }

cnd:
  | EQ { Eq }
  | NE { Ne }
  | SLT { Slt }
  | SLE { Sle }
  | SGT { Sgt }
  | SGE { Sge }
  | ULT { Ult }
  | ULE { Ule }
  | UGT { Ugt }
  | UGE { Uge }

named_insn:
| u_opt=terminated(UID,EQUALS)? i=insn
  { u_opt, i }

bracket:
  | LBRACKET op=operand COMMA lbl=UID RBRACKET { (op, lbl) }

insn:
  | b=bop t=ty o1=operand COMMA o2=operand
    { Binop (b,t,o1,o2) }
  | ALLOCA t=ty
    { Alloca t }
  | LOAD t=ty COMMA ty o=operand
    { Load (t,o) }
  | STORE t1=ty o1=operand COMMA ty o2=operand
    { Store (t1,o1,o2) }
  | ICMP c=cnd t=ty o1=operand COMMA o2=operand
    { Icmp (c,t,o1,o2) }
  | CALL t=ty o=operand LPAREN args=separated_list(COMMA,typed(operand)) RPAREN
    { Call (t, o, args) }
  | BITCAST t1=ty o=operand TO t2=ty
    { Bitcast (t1,o,t2) }
  | GEP t=ty COMMA path=gep_path
    { Gep (t, List.hd path, List.tl path) }
  | ZEXT t1=ty o=operand TO t2=ty
     { Zext (t1,o,t2) }
  | SEXT t1=ty o=operand TO t2=ty
     { Sext (t1,o,t2) }
  | TRUNC t1=ty o=operand TO t2=ty
     { Trunc (t1,o,t2) }
  | PTRTOINT t1=ty STAR o=operand TO t2=ty
    { Ptrtoint (t1,o,t2) }
  | PHI t=ty ops=separated_list(COMMA,bracket)
    { PhiNode (t,ops) }
  | SELECT I1 o=operand COMMA o1=typed(operand) COMMA o2=typed(operand)
    { Select (o,o1,o2) }

ty_ginit_list:
  | gs=separated_list(COMMA,typed(ginit))
    { gs }

ginit:
  | NULL          { GNull }
  | g=GID         { GGid g }
  | i=INT         { GInt i }
  | s=STRING      { GString s }
  | LBRACKET gs=ty_ginit_list RBRACKET
    { GArray gs }
  | LBRACE gs=ty_ginit_list RBRACE
    { GStruct gs }
