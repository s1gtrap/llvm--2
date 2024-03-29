(* LLVM--: a simplified subset of the LLVM IR, based on  S. Zdancewic's
   LLVMlite at UPenn *)

module S = Symbol

type uid = S.symbol (* Local identifiers  *)
type gid = S.symbol (* Global identifiers *)
type tid = S.symbol (* Named types        *)
type lbl = S.symbol (* Labels             *)

(* LLVM IR types *)
type ty =
  | Void (* void                *)
  | I1
  | I8
  | I16
  | I32
  | I64 (* integer types       *)
  | Ptr of ty (* t*                  *)
  | Struct of ty list (* {t1, t2, ... , tn } *)
  | Array of int * ty (* [NNN x t]           *)
  | Fun of fty (* t1, ...., tn -> tr  *)
  | Namedt of tid (* named type aliases  *)

and fty = ty list * bool * ty

type operand =
  | Null (* null pointer        *)
  | IConst64 of int64 (* integer constant    *)
  | IConst32 of int32 (* integer constant    *)
  | IConst8 of char (* integer constant    *)
  | BConst of bool (* boolean constant    *)
  | Gid of gid (* A global identifier *)
  | Id of uid (* A local identifier  *)

(* Binary operations *)
type bop =
  | Add
  | Sub
  | Mul
  | SDiv
  | SRem
  | UDiv
  | URem
  | Shl
  | Lshr
  | Ashr
  | And
  | Or
  | Xor

(* Comparison operators *)
type cnd = Eq | Ne | Slt | Sle | Sgt | Sge | Ult | Ule | Ugt | Uge

(* Instructions *)
type insn =
  | Binop of
      bop * ty * operand * operand (* bop ty %o1, o2                     *)
  | Alloca of ty (* alloca ty                          *)
  | AllocaN of (ty * (ty * operand)) (* alloca ty, oty %o                *)
  | Load of ty * operand (* load ty %u                         *)
  | Store of ty * operand * operand (* store ty %t, ty* %u                *)
  | Icmp of
      cnd * ty * operand * operand (* icmp %s ty %s, %s                  *)
  | Call of
      ty
      * operand
      * (ty * operand) list (* fn (%1, %2, ...)                   *)
  | Bitcast of ty * operand * ty (* bitcast ty1 %u to ty2              *)
  | Gep of
      ty
      * (ty * operand)
      * (ty * operand) list (* getelementptr ty* %u, i64 %vi, ... *)
  | Zext of ty * operand * ty (* zext ty1 %o to ty2                 *)
  | Sext of ty * operand * ty
  (* sext ty1 %o to ty2                 *)
  (* FIXME: test this *)
  | Ptrtoint of ty * operand * ty (* ptrtoint ty1 %o to ty2             *)
  | Trunc of ty * operand * ty (* trunc ty1 %o to ty2                 *)
  | PhiNode of
      ty * (operand * lbl) list (* phi ty [op1, br1], ... [opn, brn]  *)
  | Select of operand * (ty * operand) * (ty * operand)
  | Comment of string (* ; %s                               *)

(* Block terminators *)
type terminator =
  | Ret of ty * operand option (* ret i64 %s                     *)
  | Br of lbl (* br label %lbl                  *)
  | Cbr of operand * lbl * lbl (* br i1 %s, label %l1, label %l2 *)
  | Unreachable
  | Switch of ty * operand * lbl * (operand * lbl) list
(* unreachable -- this terminator should only be used in parts where the code should never reach, e.g., after calling a function that reports a runtime error and exits.*)

(* Basic blocks *)

type block = { insns : (uid option * insn) list; terminator : terminator }

(* Control Flow Graph: a pair of an entry block and a set of labeled blocks *)
type cfg = (lbl option * block) * (lbl * block) list

(* Function declarations *)
type fdecl = { fty : fty; param : uid list; cfg : cfg }

(* Initializers for global data *)
type ginit =
  | GNull (* null literAL *)
  | GGid of gid (* reference to another global *)
  | GInt of int64 (* global integer value        *)
  | GString of string (* constant global string      *)
  | GArray of gdecl list (* global array                *)
  | GStruct of gdecl list (* global struct               *)

(* Global declaration *)
and gdecl = ty * ginit

(* LLVM-- programs *)
type prog = {
  tdecls : (tid * ty) list (* named types        *);
  extgdecls : (gid * ty) list (* external globals   *);
  gdecls : (gid * gdecl) list (* global data        *);
  extfuns : (gid * fty) list (* external functions *);
  fdecls : (gid * fdecl) list (* code               *);
}

(* --- Serialization ------------------------------------------------------ *)
let mapcat s f l = (String.concat s) (Stdlib.List.map f l)
let ( ^^ ) s t = if s = "" || t = "" then "" else s ^ t
let prefix p f a = p ^ f a
let concwsp = String.concat " "
let parens s = "(" ^ s ^ ")"
let brackets s = "[" ^ s ^ "]"
let braces s = "{" ^ s ^ "}"

let rec string_of_ty (t : ty) : string =
  match t with
  | Void -> "void"
  | I1 -> "i1"
  | I8 -> "i8"
  | I16 -> "i16"
  | I32 -> "i32"
  | I64 -> "i64"
  | Ptr t' -> string_of_ty t' ^ "*"
  | Struct ts -> "{ " ^ mapcat ", " string_of_ty ts ^ " }"
  | Array (n, t) -> "[" ^ string_of_int n ^ " x " ^ string_of_ty t ^ "]"
  | Fun (ts, var, t) ->
      string_of_ty t ^ " ("
      ^ mapcat ", " string_of_ty ts
      ^ if var then ", ...)" else ")"
  | Namedt s -> "%" ^ S.name s

let sot = string_of_ty

let string_of_operand (opr : operand) : string =
  match opr with
  | Null -> "null"
  | IConst64 i -> Int64.to_string i
  | IConst32 i -> Int32.to_string i
  | IConst8 i -> string_of_int (Char.code i)
  | BConst b -> if b then "1" else "0"
  | Gid g -> "@" ^ S.name g
  | Id u -> "%" ^ S.name u

let soo = string_of_operand
let soop ((t, v) : ty * operand) : string = sot t ^ " " ^ soo v

let string_of_bop (b : bop) : string =
  match b with
  | Add -> "add"
  | Sub -> "sub"
  | Mul -> "mul"
  | Shl -> "shl"
  | Lshr -> "lshr"
  | Ashr -> "ashr"
  | And -> "and"
  | Or -> "or"
  | Xor -> "xor"
  | SDiv -> "sdiv"
  | SRem -> "srem"
  | UDiv -> "udiv"
  | URem -> "urem"

let string_of_cnd (c : cnd) : string =
  match c with
  | Eq -> "eq"
  | Ne -> "ne"
  | Slt -> "slt"
  | Sle -> "sle"
  | Sgt -> "sgt"
  | Sge -> "sge"
  | Ult -> "ult" (* FIXME: test signedness of comparison operators *)
  | Ule -> "ule"
  | Ugt -> "ugt"
  | Uge -> "uge"

let string_of_gep_index ((ty, opr) : ty * operand) : string =
  sot ty ^ " " ^ soo opr

let string_of_insn (ins : insn) : string =
  match ins with
  | Binop (b, t, o1, o2) ->
      concwsp [ string_of_bop b; sot t; soo o1 ^ ","; soo o2 ]
  | Alloca t -> "alloca " ^ sot t
  | AllocaN (t, (nt, n)) -> "alloca " ^ sot t ^ ", " ^ sot nt ^ " " ^ soo n
  | Load (t, opr) -> concwsp [ "load"; sot t ^ ","; sot (Ptr t); soo opr ]
  | Store (t, os, od) ->
      concwsp [ "store"; sot t; soo os ^ ","; sot (Ptr t); soo od ]
  | Icmp (c, t, o1, o2) ->
      concwsp [ "icmp"; string_of_cnd c; sot t; soo o1 ^ ","; soo o2 ]
  | Call (t, opr, oa) ->
      concwsp [ "call"; sot t; soo opr; parens (mapcat ", " soop oa) ]
  | Bitcast (t1, opr, t2) ->
      concwsp [ "bitcast"; sot t1; soo opr; "to"; sot t2 ]
  | Gep (t, opr, oi) ->
      concwsp
        [
          "getelementptr";
          sot t ^ ",";
          sot (fst opr);
          soo (snd opr) ^ ",";
          mapcat ", " string_of_gep_index oi;
        ]
  | Zext (t, o1, t2) -> concwsp [ "zext"; sot t; soo o1; "to"; sot t2 ]
  | Sext (t, o1, t2) -> concwsp [ "sext"; sot t; soo o1; "to"; sot t2 ]
  | Ptrtoint (t, o1, t2) ->
      concwsp [ "ptrtoint"; sot (Ptr t); soo o1; "to"; sot t2 ]
  | Trunc (t, o1, t2) -> concwsp [ "trunc"; sot t; soo o1; "to"; sot t2 ]
  | Select (o, o1, o2) ->
      concwsp
        [
          "select";
          "i1";
          soo o ^ ",";
          mapcat ", " (fun (t, o) -> sot t ^ " " ^ soo o) [ o1; o2 ];
        ]
  | PhiNode (t, opbrs) ->
      concwsp
        [
          "phi";
          sot t;
          mapcat ", "
            (fun (op, br) -> brackets (soo op ^ ", %" ^ S.name br))
            opbrs;
        ]
  | Comment s -> "; " ^ String.escaped s

let string_of_named_insn ((u, i) : uid option * insn) : string =
  match u with
  | None -> string_of_insn i
  | Some u' -> "%" ^ S.name u' ^ " = " ^ string_of_insn i

let string_of_terminator (tr : terminator) : string =
  match tr with
  | Ret (_, None) -> "ret void"
  | Ret (t, Some opr) -> concwsp [ "ret"; sot t; soo opr ]
  | Br l -> concwsp [ "br"; "label"; "%" ^ S.name l ]
  | Cbr (opr, l, m) ->
      concwsp
        [
          "br";
          "i1";
          soo opr ^ ",";
          "label";
          "%" ^ S.name l ^ ",";
          "label";
          "%" ^ S.name m;
        ]
  | Unreachable -> "unreachable"
  | Switch (t, o, e, cases) ->
      "switch " ^ sot t ^ " " ^ soo o ^ ", label %" ^ S.name e ^ " [\n"
      ^ mapcat "\n"
          (fun (o, l) -> "    " ^ sot t ^ " " ^ soo o ^ ", label %" ^ S.name l)
          cases
      ^ "\n  ]"

let string_of_block ((l, b) : S.symbol option * block) : string =
  match l with
  | Some l ->
      S.name l ^ ":\n"
      ^ (mapcat "\n" (prefix " " string_of_named_insn) b.insns ^^ "\n")
      ^ (prefix " " string_of_terminator) b.terminator
  | None ->
      (mapcat "\n" (prefix " " string_of_named_insn) b.insns ^^ "\n")
      ^ (prefix " " string_of_terminator) b.terminator

let string_of_cfg ((e, bs) : cfg) : string =
  let string_of_named_block (l, b) = string_of_block (Some l, b) in
  string_of_block e ^ "\n" ^ mapcat "\n" string_of_named_block bs ^^ "\n"

let string_of_named_fdecl ((g, f) : gid * fdecl) : string =
  let string_of_arg (t, u) = sot t ^ " %" ^ S.name u in
  let ts, _var, t = f.fty in
  concwsp
    [
      "define";
      sot t;
      "@" ^ S.name g;
      parens (mapcat ", " string_of_arg (Stdlib.List.combine ts f.param));
      "{\n" ^ string_of_cfg f.cfg ^ "}\n";
    ]

let ll_encode s =
  let explode s = String.to_seq s |> Stdlib.List.of_seq in
  let implode s = Stdlib.List.to_seq s |> String.of_seq in
  let rec ase ls =
    match ls with
    | [] -> []
    | '\\' :: cs -> '\\' :: '\\' :: ase cs
    | '\"' :: cs ->
        let charsc = Format.asprintf "%02X" (Char.code '\"') in
        ('\\' :: explode charsc) @ ase cs
    | c :: cs ->
        let ordc = Char.code c in
        let charsc = Format.asprintf "%02X" ordc in
        if 32 <= ordc && ordc < 128 then c :: ase cs
        else ('\\' :: explode charsc) @ ase cs
  in
  s |> explode |> ase |> implode

let rec string_of_ginit (gi : ginit) : string =
  match gi with
  | GNull -> "null"
  | GGid g -> "@" ^ S.name g
  | GInt i -> Int64.to_string i
  | GString s -> "c\"" ^ ll_encode s ^ "\""
  | GArray gis -> brackets (mapcat ", " string_of_gdecl gis)
  | GStruct gis -> braces (mapcat ", " string_of_gdecl gis)

and string_of_gdecl ((t, gi) : gdecl) : string =
  concwsp [ sot t; string_of_ginit gi ]

let string_of_named_gdecl ((g, gd) : gid * gdecl) : string =
  "@" ^ S.name g ^ " = global " ^ string_of_gdecl gd

let string_of_named_ext_gdecl ((g, tp) : gid * ty) : string =
  "@" ^ S.name g ^ " = external global " ^ sot tp

let string_of_ext_fun (g, (paramstyp, var, rettyp)) : string =
  "declare " ^ string_of_ty rettyp ^ " @" ^ S.name g ^ "("
  ^ (String.concat ", ") (Stdlib.List.map string_of_ty paramstyp)
  ^ if var then ", ...)" else ")"

let string_of_named_tdecl (tid, ty) = "%" ^ S.name tid ^ " = type " ^ sot ty

let string_of_prog (p : prog) : string =
  (mapcat "\n" string_of_named_tdecl p.tdecls ^^ "\n\n")
  ^ (mapcat "\n" string_of_named_ext_gdecl p.extgdecls ^^ "\n\n")
  ^ (mapcat "\n" string_of_named_gdecl p.gdecls ^^ "\n\n")
  ^ (mapcat "\n" string_of_ext_fun p.extfuns ^^ "\n\n")
  ^ mapcat "\n" string_of_named_fdecl p.fdecls
