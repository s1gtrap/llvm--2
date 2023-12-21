(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(**************************************************************************)

open Tigercommon
open Tigerhoist
module H = Habsyn
module Ty = Types
module S = Symbol
module B = Cfgbuilder

module SymbolMap = Map.Make (struct
  type t = S.symbol

  let compare = compare
end)

module UniqueMap = Map.Make (struct
  type t = Ty.unique

  let compare = compare
end)

type unique_env = Ll.tid UniqueMap.t

type fdecl_summary = {
  parent_opt : Ll.gid option;
  locals_uid : Ll.uid;
  locals_tid : Ll.tid;
  offset_of_symbol : S.symbol -> int;
}

type summary_env = fdecl_summary SymbolMap.t

exception NotImplemented
exception CodeGenerationBug

let ptr_i8 = Ll.Ptr Ll.I8

let rec ty_to_llty = function
  | Ty.INT -> Ll.I64
  | Ty.NAME (_, ref) -> ty_to_llty (Option.get !ref)
  | Ty.VOID -> Ll.Void
  | Ty.STRING | Ty.RECORD _ | Ty.ARRAY _ | Ty.NIL -> ptr_i8
  | ty -> failwith (Prtypes.string_of_type ty)

let rec actualType ty =
  match ty with
  | Types.NAME (_, ref) -> (
      match !ref with
      | Some ty -> actualType ty
      | None -> raise CodeGenerationBug)
  | _ -> ty

type context = {
  break_lbl : Ll.lbl option;
  summary : fdecl_summary;
  uenv : unique_env;
  senv : summary_env;
  gdecls : (Ll.gid * Ll.gdecl) list ref;
}

(* Obs: this is a rather tricky piece of code; 2019-10-12 *)
let cg_tydecl (uenv : unique_env ref) (H.Tdecl { name; ty; _ }) =
  match actualType ty with
  | Ty.RECORD (fs, uniq) -> (
      match UniqueMap.find_opt uniq !uenv with
      | None ->
          let ty (_, ty) = ty_to_llty ty in
          let tys = List.map ty fs in
          uenv := UniqueMap.add uniq name !uenv;
          Some (name, Ll.Struct tys)
      | Some _ -> None)
  | ty -> Some (name, ty_to_llty ty)

let fresh =
  let open Freshsymbols in
  let env = empty in
  gensym env

let ( <$> ) f g x = f (g x)
let id = Fun.id
let ( $> ) b1 b2 = b2 <$> b1 (* buildlet composition *)

(*let ( @> ) (b, op) k = b $> k op*)
let ty_of_exp (H.Exp { ty; _ }) = ty
let _ty_of_var (H.Var { ty; _ }) = ty
let ty_of_arg (H.Arg { ty; _ }) = ty
let name_of_arg (H.Arg { name; _ }) = name
let default_sl_name = S.symbol "$sl"
let locals_type_name name = S.symbol @@ "$locals_" ^ S.name name
let _ty_dec_name name = S.symbol @@ "t_$" ^ S.name name

(* add instruction with fresh symbol *)
let aiwf s i =
  let t = fresh s in
  (B.add_insn (Some t, i), Ll.Id t)

(* --- monadic interface;) ----------------------------- *)

(* Notes on the monadic interface:

   1) Monadic interface is not necessary at all, and one could just
      program with buildlets as before; it's just a little bit more
      concise, but one _really_ needs to know what they are doing.

   2) Some useful info on the OCmal let* notation here
      http://jobjo.github.io/2019/04/24/ocaml-has-some-new-shiny-syntax.html

   3) Observe that the new OCaml notation conflicts with JaneStreet
      pre-processors, so we don't have any pre-processing in this library.
*)

type 'a m = B.buildlet * 'a

let bind ((builder, op) : 'a m) (f : 'a -> 'b m) : 'b m =
  let builder', op' = f op in
  (builder $> builder', op')

let return x = (B.id_buildlet, x)
let ( let* ) = bind
(* --- end of monadic interface ------------------------ *)

let unit b = (b, ())
let build_store t o1 o2 = B.add_insn (None, Ll.Store (t, o1, o2))
let gep_0 ty op i = Ll.Gep (ty, op, [ Const 0L; Const i ])

let rec cgExp ctxt (exp : H.exp) :
    B.buildlet * Ll.operand (* Alternatively: Ll.operand m *) =
  let (H.Exp { ty; _ }) = exp in
  (* ..
     let out = Format.std_formatter in
     Pp_habsyn.pp_exp (H.Exp {exp_base= NilExp; ty= Types.NIL; pos}) out () ;
     Format.pp_print_newline out () ;
     (* .. *)
     (* .. *)
     let out = Format.std_formatter in
     Pp_habsyn.pp_exp exp out () ;
     Format.pp_print_newline out () ;
      .. *)
  let (Exp { exp_base; _ }) = exp in
  let cgE_ = cgExp ctxt in
  match exp_base with
  | IntExp i -> (id, Const (Int64.of_int i))
  | StringExp s ->
      let gid : Ll.gid = fresh "str" in
      let arrty = Ll.Array (Int64.of_int (String.length s), Ll.I8) in
      let strty = Ll.Struct [ Ll.I64; arrty ] in
      let gstr =
        Ll.GStruct
          [
            (Ll.I64, Ll.GInt (Int64.of_int (String.length s)));
            (arrty, Ll.GString s);
          ]
      in
      ctxt.gdecls := (gid, (strty, gstr)) :: !(ctxt.gdecls);
      aiwf "temp" (Ll.Bitcast (Ll.Ptr strty, Ll.Gid gid, Ll.Ptr Ll.I8))
  | AssignExp { var; exp = H.Exp { ty; _ } as exp } ->
      let llty = ty_to_llty (actualType ty) in
      let* op_exp = cgE_ exp in
      let* op_var = cgVar ctxt var in
      let* _ = unit (build_store llty op_exp op_var) in
      return Ll.Null
  | VarExp var ->
      let llty = ty_to_llty ty in
      let* op_var_ptr = cgVar ctxt var in
      let* res = aiwf "res" (Ll.Load (llty, op_var_ptr)) in
      return res
  | LetExp { vardecl = VarDec { name; typ; init; _ }; body } ->
      (* codegen vardec init *)
      let* op_init = cgE_ init in
      (* codegen get ptr of target local *)
      let idx = ctxt.summary.offset_of_symbol name in
      let* op_gep =
        aiwf "temp"
          (gep_0 (Namedt ctxt.summary.locals_tid) (Id ctxt.summary.locals_uid)
             (Int64.of_int idx))
      in
      (* store at target ptr *)
      let* _ = unit (build_store (ty_to_llty typ) op_init op_gep) in
      (* build let body *)
      let* op_body = cgE_ body in
      return op_body
  | H.OpExp { left; right; oper = DivideOp; _ } ->
      let thn_label = fresh "thn" in
      let mrg_label = fresh "mrg" in
      let* op_left = cgE_ left in
      let* op_right = cgE_ right in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Eq, Ll.I64, op_right, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, mrg_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* _ =
        unit
          (B.add_insn
             (None, Ll.Call (Ll.I64, Gid (S.symbol "divisionByZero"), [])))
      in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      let* op_binop =
        aiwf "temp" (Ll.Binop (Ll.SDiv, Ll.I64, op_left, op_right))
      in
      return op_binop
  | H.OpExp { left; right; oper = ExponentOp; _ } ->
      let* op_left = cgE_ left in
      let* op_right = cgE_ right in
      let* op_binop =
        aiwf "temp"
          (Ll.Call
             ( Ll.I64,
               Gid (S.symbol "exponent"),
               [ (Ll.I64, op_left); (Ll.I64, op_right) ] ))
      in
      return op_binop
  | H.OpExp
      {
        left = H.Exp { exp_base = _; ty; _ } as left;
        right = H.Exp { exp_base = _; _ } as right;
        oper = (EqOp | NeqOp) as oper;
        _;
      }
    when match actualType ty with Ty.RECORD _ -> true | _ -> false ->
      let oper =
        match oper with EqOp -> Ll.Eq | NeqOp -> Ll.Ne | _ -> failwith "FIXME"
      in
      let* op_left_ptr = cgE_ left in
      let* op_left_int = aiwf "left_int" (Ll.Ptrtoint (I8, op_left_ptr, I64)) in
      let* op_right_ptr = cgE_ right in
      let* op_right_int =
        aiwf "right_int" (Ll.Ptrtoint (I8, op_right_ptr, I64))
      in
      let* op_cnd = aiwf "cnd" (Icmp (oper, I64, op_left_int, op_right_int)) in
      let* op_zext = aiwf "zext" (Zext (I1, op_cnd, I64)) in
      return op_zext
  | H.OpExp
      {
        left = H.Exp { ty; _ } as left;
        right;
        oper = (EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp) as oper;
        _;
      }
    when ty_to_llty ty = Ll.Ptr Ll.I8 ->
      let* op_left = cgE_ left in
      let* op_right = cgE_ right in
      let args = [ (Ll.Ptr Ll.I8, op_left); (Ll.Ptr Ll.I8, op_right) ] in
      let gid =
        Ll.Gid
          (S.symbol
             (match oper with
             | EqOp -> "stringEqual"
             | NeqOp -> "stringNotEq"
             | LtOp -> "stringLess"
             | LeOp -> "stringLessEq"
             | GtOp -> "stringGreater"
             | GeOp -> "stringGreaterEq"
             | _ -> raise NotImplemented))
      in
      let* op_call = aiwf "temp" (Ll.Call (Ll.I64, gid, args)) in
      return op_call
  | H.OpExp
      {
        left;
        right;
        oper = (EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp) as oper;
        _;
      } ->
      let* op_left = cgE_ left in
      let* op_right = cgE_ right in
      let cnd =
        match oper with
        | EqOp -> Ll.Eq
        | NeqOp -> Ne
        | LtOp -> Slt
        | LeOp -> Sle
        | GtOp -> Sgt
        | GeOp -> Sge
        | _ -> raise NotImplemented
      in
      let* op_binop = aiwf "temp" (Ll.Icmp (cnd, Ll.I64, op_left, op_right)) in
      let* op_zext = aiwf "temp" (Ll.Zext (Ll.I1, op_binop, Ll.I64)) in
      return op_zext
  | H.OpExp { left; right; oper; _ } ->
      let* op_left = cgE_ left in
      let* op_right = cgE_ right in
      let bop =
        match oper with
        | PlusOp -> Ll.Add
        | MinusOp -> Ll.Sub
        | TimesOp -> Ll.Mul
        | DivideOp -> Ll.SDiv
        | ModuloOp -> Ll.SRem
        | _ -> raise NotImplemented
      in
      let* op_binop = aiwf "temp" (Ll.Binop (bop, Ll.I64, op_left, op_right)) in
      return op_binop
  | H.SeqExp exps -> (
      match List.rev exps with
      | last :: head ->
          let build_head = List.map fst (List.map cgE_ head) in
          let build_last, op_last = cgE_ last in
          let build = build_last :: build_head in
          let* _ = unit (Cfgbuilder.seq_buildlets (List.rev build)) in
          return op_last
      | [] -> return Ll.Null)
  | H.IfExp { test; thn; els = Some els } when ty_of_exp thn = Ty.VOID ->
      let thn_label = fresh "thn" in
      let els_label = fresh "els" in
      let mrg_label = fresh "mrg" in
      let* op_test = cgE_ test in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Ne, Ll.I64, op_test, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, els_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* _ = cgE_ thn in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block els_label) in
      let* _ = cgE_ els in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      return Ll.Null
  | H.IfExp { test; thn; els = Some els } ->
      let tmp = fresh "temp" in
      let thn_label = fresh "thn" in
      let els_label = fresh "els" in
      let mrg_label = fresh "mrg" in
      let* _ = unit (B.add_alloca (tmp, ty_to_llty (ty_of_exp thn))) in
      let* op_test = cgE_ test in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Ne, Ll.I64, op_test, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, els_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* op_thn = cgE_ thn in
      let* _ =
        unit
          (B.add_insn
             (None, Ll.Store (ty_to_llty (ty_of_exp thn), op_thn, Ll.Id tmp)))
      in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block els_label) in
      let* op_els = cgE_ els in
      let* _ =
        unit
          (B.add_insn
             (None, Ll.Store (ty_to_llty (ty_of_exp thn), op_els, Ll.Id tmp)))
      in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      let* op = aiwf "res" (Ll.Load (ty_to_llty (ty_of_exp thn), Ll.Id tmp)) in
      return op
  | H.IfExp { test; thn; els = None } when ty_of_exp thn = Ty.VOID ->
      let thn_label = fresh "thn" in
      let mrg_label = fresh "mrg" in
      let* op_test = cgE_ test in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Ne, Ll.I64, op_test, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, mrg_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* _ = cgE_ thn in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      return Ll.Null
  | H.IfExp { test; thn; els = None } ->
      let tmp = fresh "temp" in
      let thn_label = fresh "thn" in
      let mrg_label = fresh "mrg" in
      let* _ = unit (B.add_alloca (tmp, ty_to_llty (ty_of_exp thn))) in
      let* op_test = cgE_ test in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Ne, Ll.I64, op_test, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, mrg_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* op_thn = cgE_ thn in
      let* _ =
        unit
          (B.add_insn
             (None, Ll.Store (ty_to_llty (ty_of_exp thn), op_thn, Ll.Id tmp)))
      in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      let* _ = aiwf "res" (Ll.Load (ty_to_llty (ty_of_exp thn), Ll.Id tmp)) in
      return Ll.Null
  | CallExp { func; lvl_diff; args } ->
      let parent (summary : fdecl_summary) (lvl_diff : int) :
          B.buildlet * (Ll.ty * Ll.operand) =
        let rec parent (builder : B.buildlet) (summary : fdecl_summary)
            (op : Ll.operand) (lvl_diff : int) :
            B.buildlet * (Ll.ty * Ll.operand) =
          match lvl_diff with
          | 0 -> (builder, (Ll.Ptr (Ll.Namedt summary.locals_tid), op))
          | _ -> (
              let build_gep, op_gep =
                aiwf "lnk" (gep_0 (Ll.Namedt summary.locals_tid) op 0L)
              in
              match summary.parent_opt with
              | Some sym ->
                  let parent_summary = SymbolMap.find sym ctxt.senv in
                  let build_load, op_load =
                    aiwf "load"
                      (Ll.Load
                         (Ll.Ptr (Ll.Namedt parent_summary.locals_tid), op_gep))
                  in
                  parent
                    (builder $> build_gep $> build_load)
                    parent_summary op_load (lvl_diff - 1)
              | None ->
                  (* built-in *)
                  (builder, (Ll.Ptr Ll.I8, Ll.Null)))
        in
        parent id summary (Ll.Id ctxt.summary.locals_uid) lvl_diff
      in
      let lid = Ll.Id ctxt.summary.locals_uid
      and lty = Ll.Ptr (Ll.Namedt ctxt.summary.locals_tid) in
      let _link = (lty, lid) in
      let builder, link = parent ctxt.summary lvl_diff in
      let builder, ops =
        List.fold_left_map
          (fun acc exp ->
            let (H.Exp { ty; _ }) = exp in
            let builder, op = cgE_ exp in
            (acc $> builder, (ty_to_llty ty, op)))
          builder args
      in
      let builder', ret =
        match ty with
        | Ty.VOID ->
            let builder, _ =
              unit
                (B.add_insn
                   (None, Ll.Call (ty_to_llty ty, Ll.Gid func, link :: ops)))
            in
            (builder, Ll.Null)
        | ty -> aiwf "ret" (Ll.Call (ty_to_llty ty, Ll.Gid func, link :: ops))
      in
      (builder $> builder', ret)
  | RecordExp { fields } ->
      let recty =
        Ll.Namedt
          (match actualType ty with
          | Types.RECORD (_, uniq) -> UniqueMap.find uniq ctxt.uenv
          | _ -> raise CodeGenerationBug)
      in
      let* op_size_ptr =
        aiwf "size_ptr" (Ll.Gep (recty, Ll.Null, [ Const 1L ]))
      in
      let* op_size = aiwf "size" (Ll.Ptrtoint (recty, op_size_ptr, Ll.I64)) in
      let* op_record_ptr =
        aiwf "record_ptr"
          (Ll.Call
             (ptr_i8, Ll.Gid (S.symbol "allocRecord"), [ (Ll.I64, op_size) ]))
      in
      let* record =
        aiwf "rec" (Ll.Bitcast (ptr_i8, op_record_ptr, Ll.Ptr recty))
      in
      let exps =
        List.mapi (fun idx (_, exp) -> (idx, exp)) fields
        |> List.map (fun (i, e) -> (Int64.of_int i, e))
      in
      let cg_field (builder : B.buildlet) (idx, exp) =
        let build_exp, op_exp = cgE_ exp in
        let build_field_ptr, gep_field =
          aiwf "field_ptr" (gep_0 recty record idx)
        in
        let build_store, _ =
          unit (build_store (ty_to_llty (ty_of_exp exp)) op_exp gep_field)
        in
        builder $> build_exp $> build_field_ptr $> build_store
      in
      let* _ = (List.fold_left cg_field B.id_buildlet exps, Ll.Null) in
      return op_record_ptr
  | ArrayExp { size; init } ->
      let llty = ty_to_llty (actualType (ty_of_exp init)) in
      let* op_init = cgE_ init in
      let* op_init_ptr = aiwf "init_ptr" (Ll.Alloca llty) in
      let* _ = unit (build_store llty op_init op_init_ptr) in
      let* op_init_ptr =
        aiwf "init_ptr" (Ll.Bitcast (Ll.Ptr llty, op_init_ptr, ptr_i8))
      in
      let* op_size = cgE_ size in
      let* op_init_size =
        aiwf "init_size_ptr" (Ll.Gep (llty, Ll.Null, [ Const 1L ]))
      in
      let* op_init_size =
        aiwf "init_size" (Ll.Ptrtoint (llty, op_init_size, Ll.I64))
      in
      aiwf "array_ptr"
        (Ll.Call
           ( ptr_i8,
             Ll.Gid (S.symbol "initArray"),
             [
               (Ll.I64, op_size); (Ll.I64, op_init_size); (ptr_i8, op_init_ptr);
             ] ))
  | NilExp -> return Ll.Null
  | BreakExp ->
      let break_lbl = Option.get ctxt.break_lbl in
      let next_lbl = fresh "tail" in
      let* _ = unit (B.term_block (Ll.Br break_lbl)) in
      let* _ = unit (B.start_block next_lbl) in
      return Ll.Null
  | WhileExp { test; body } ->
      let test_label = fresh "test" in
      let body_label = fresh "body" in
      let mrg_label = fresh "mrg" in
      let* _ = unit (B.term_block (Ll.Br test_label)) in
      let* _ = unit (B.start_block test_label) in
      let* op_test = cgE_ test in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Ne, Ll.I64, op_test, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, body_label, mrg_label))) in
      let* _ = unit (B.start_block body_label) in
      let break_lbl = Some mrg_label in
      let* _ = cgExp { ctxt with break_lbl } body in
      let* _ = unit (B.term_block (Ll.Br test_label)) in
      let* _ = unit (B.start_block mrg_label) in
      return Ll.Null

and cgVar ({ summary; _ } as ctxt : context) (H.Var { var_base; _ }) =
  match var_base with
  | AccessVar (lvl, sym) ->
      let parent (summary : fdecl_summary) (lvl_diff : int) :
          B.buildlet * (fdecl_summary * Ll.operand) =
        let rec parent (builder : B.buildlet) (summary : fdecl_summary)
            (op : Ll.operand) (lvl_diff : int) :
            B.buildlet * (fdecl_summary * Ll.operand) =
          match lvl_diff with
          | 0 -> (builder, (summary, op))
          | _ ->
              let build_gep, op_gep =
                aiwf "lnk" (gep_0 (Ll.Namedt summary.locals_tid) op 0L)
              in
              let parent_summary =
                SymbolMap.find (Option.get summary.parent_opt) ctxt.senv
              in
              let _parent_uid = Ll.Id parent_summary.locals_uid
              and _parent_tid = Ll.Ptr (Ll.Namedt parent_summary.locals_tid) in
              let build_load, op_load =
                aiwf "load"
                  (Ll.Load (Ll.Ptr (Ll.Namedt parent_summary.locals_tid), op_gep))
              in
              parent
                (builder $> build_gep $> build_load)
                parent_summary op_load (lvl_diff - 1)
        in
        parent id summary (Ll.Id ctxt.summary.locals_uid) lvl_diff
      in
      let* summary, op = parent summary lvl in
      let idx = summary.offset_of_symbol sym in
      aiwf "var_ptr" (gep_0 (Namedt summary.locals_tid) op (Int64.of_int idx))
  | FieldVar ((H.Var { ty; _ } as lval), field) ->
      let fields, recty =
        match actualType ty with
        | Ty.RECORD (fields, uniq) ->
            (fields, Ll.Namedt (UniqueMap.find uniq ctxt.uenv))
        | _ -> raise CodeGenerationBug
      in
      let* op_lval_ptr = cgVar ctxt lval in
      let* op_load = aiwf "load" (Ll.Load (ptr_i8, op_lval_ptr)) in
      let* op_record_ptr =
        aiwf "record_ptr" (Ll.Bitcast (ptr_i8, op_load, Ll.Ptr recty))
      in
      let _llty = ty_to_llty ty in
      let thn_label = fresh "thn" in
      let mrg_label = fresh "mrg" in
      let* op_var_int =
        aiwf "int_of_ptr" (Ll.Ptrtoint (Ll.I8, op_load, Ll.I64))
      in
      let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Eq, Ll.I64, op_var_int, Const 0L)) in
      let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, mrg_label))) in
      let* _ = unit (B.start_block thn_label) in
      let* _ =
        unit
          (B.add_insn
             (None, Ll.Call (Ll.I64, Gid (S.symbol "recFieldError"), [])))
      in
      let* _ = unit (B.term_block (Ll.Br mrg_label)) in
      let* _ = unit (B.start_block mrg_label) in
      let field_indices = List.mapi (fun idx field -> (idx, field)) fields in
      let field_offset, _fieldty =
        Option.get
          (List.find_map
             (fun (off, (fld, ty)) ->
               if fld = field then Some (off, ty) else None)
             field_indices)
      in
      aiwf "field_ptr" (gep_0 recty op_record_ptr (Int64.of_int field_offset))
  | SubscriptVar ((H.Var { ty; _ } as var), exp) -> (
      let* op_lval_ptr = cgVar ctxt var in
      let* op_idx = cgExp ctxt exp in
      let* op_load = aiwf "load" (Ll.Load (ptr_i8, op_lval_ptr)) in
      match actualType ty with
      | Ty.ARRAY (ty, _) ->
          let llty = ty_to_llty (actualType ty) in
          let thn_label = fresh "thn" in
          let mrg_label = fresh "mrg" in
          let* op_len_ptr =
            aiwf "len_ptr" (Ll.Bitcast (ptr_i8, op_load, Ptr I64))
          in
          let* op_len_ptr =
            aiwf "len_ptr" (Ll.Gep (Ll.I64, op_len_ptr, [ Const (-1L) ]))
          in
          let* op_len = aiwf "len" (Load (I64, op_len_ptr)) in
          let* cnd = aiwf "cnd" (Ll.Icmp (Ll.Sle, Ll.I64, op_len, op_idx)) in
          let* _ = unit (B.term_block (Ll.Cbr (cnd, thn_label, mrg_label))) in
          let* _ = unit (B.start_block thn_label) in
          let* _ =
            unit
              (B.add_insn
                 ( None,
                   Ll.Call
                     (Ll.I64, Gid (S.symbol "arrInxError"), [ (I64, op_idx) ])
                 ))
          in
          let* _ = unit (B.term_block (Ll.Br mrg_label)) in
          let* _ = unit (B.start_block mrg_label) in
          let* op_array_ptr =
            aiwf "array_ptr" (Bitcast (ptr_i8, op_load, Ptr llty))
          in
          let* op_entry_ptr =
            aiwf "entry_ptr" (Ll.Gep (llty, op_array_ptr, [ op_idx ]))
          in
          return op_entry_ptr
      | _ -> raise CodeGenerationBug)

(* --- From this point on the code requires no changes --- *)

(* Creates summary of a function declaration; relies on the alpha conversion *)
let cg_fdecl_summary senv_ref (H.Fdecl { name; parent_opt; locals; _ }) =
  let locals_uid = fresh "locals" in
  let locals_tid = locals_type_name name in
  let offset_of_symbol =
    let locals_map =
      default_sl_name :: List.map fst locals
      |> List.mapi (fun i x -> (x, i))
      |> List.to_seq |> SymbolMap.of_seq
    in
    fun sym -> SymbolMap.find sym locals_map
  in
  senv_ref :=
    SymbolMap.add name
      { parent_opt; locals_uid; locals_tid; offset_of_symbol }
      !senv_ref;
  let sl_type =
    match parent_opt with
    | Some p -> Ll.Ptr (Ll.Namedt (p |> locals_type_name))
    | None -> Ll.Ptr I8
  in
  let locals_ty =
    Ll.Struct (sl_type :: List.map (fun (_, t) -> ty_to_llty t) locals)
  in
  (locals_tid, locals_ty)

(* --- Code genartion of function bodies --- *)
let cg_fdecl senv uenv gdecls (H.Fdecl { name; args; result; body; _ }) =
  (* Function bodies are generated in 5 steps
     1. Creating the translation context
     2. Allocating the locals structure with all the variables
     3. Copying the arguments to the locals
     4. Generating the code for the function body
     5. Terminate the function

     Because we use buildlets, the order in which we take steps 2-4 does not
     matter as long as we compose the resulting buildlets correctly in the
     end.
  *)
  let open Ll in
  (* locally open the Ll module; for convenience *)

  (* Extract the necessary information from the function summary environment *)
  let ({ parent_opt; locals_uid; locals_tid; offset_of_symbol; _ } as summary) =
    SymbolMap.find name senv
  in
  (* Get the name of the static link
     - either from the lookup in the summary, if the function is not main
     - a dummy i8*, for the main function
  *)
  let sl_type =
    match parent_opt with
    | Some p -> Ll.Ptr (Ll.Namedt (SymbolMap.find p senv).locals_tid)
    | None -> Ll.Ptr I8
  in
  (* A tuple that contains all sl-related information  *)
  let sl_info = (default_sl_name, sl_type) in
  (* Step 1 -- this is our context *)
  let ctxt = { summary; break_lbl = None; uenv; senv; gdecls } in
  (* A buildlet for allocating the locals structure *)
  let build_alloca = B.add_alloca (locals_uid, Namedt locals_tid) in
  (* Aux list of arguments with SL added in the beginning *)
  let args' =
    sl_info
    :: List.map (fun (H.Arg { name; ty; _ }) -> (name, ty_to_llty ty)) args
  in
  let copy_one_arg (name, ty) =
    (* A buildlet for copying one argument *)
    let build_gep, op_gep =
      aiwf "arg"
        (gep_0 (* Use GEP to find where to store the argument *)
           (Namedt locals_tid) (Id locals_uid)
           (Int64.of_int (offset_of_symbol name)))
    in
    (* Observe how we return the composition of two buildlets *)
    build_gep $> build_store ty (Id name) op_gep
  in
  let copy_args =
    (* A buildlet that copies all of the arguments *)
    List.rev args' |> List.map copy_one_arg |> B.seq_buildlets
  in
  let ret_ty, tr =
    match result with
    | Ty.VOID -> (Void, fun _ -> Ret (Void, None))
    | t ->
        let llty = ty_to_llty t in
        (llty, fun op -> Ret (llty, Some op))
  in
  let build_body, op =
    (* Get the builder for the body and the operand with
       the result; observe that we pass the context. *)
    cgExp ctxt body
  in
  let build_function (* Putting it all together *) =
    build_alloca (* Step 2 *) $> copy_args (* Step 3 *)
    $> build_body (* Step 4 *)
    $> B.term_block (tr op)
  in
  (* Step 5 *)
  let cfg_builder =
    (* Apply the buildlet; we get a cfg_builder *)
    build_function B.empty_cfg_builder
  in
  ( name,
    {
      fty = (sl_type :: List.map (ty_to_llty <$> ty_of_arg) args, ret_ty);
      param = default_sl_name :: List.map name_of_arg args;
      cfg = B.get_cfg cfg_builder;
    } )

let codegen_prog (H.Program { tdecls; fdecls }) : Ll.prog =
  let tenv = ref UniqueMap.empty in
  let senv = ref SymbolMap.empty in
  let gdecls = ref [] in
  let tdecls1 = List.filter_map (cg_tydecl tenv) tdecls in
  let tdecls2 = List.map (cg_fdecl_summary senv) fdecls in
  let fdecls = List.map (cg_fdecl !senv !tenv gdecls) fdecls in
  let tdecls = tdecls1 @ tdecls2 in
  let gdecls = !gdecls in
  let open Ll in
  { tdecls; gdecls; fdecls }

let _runtime_fns =
  let fns =
    [
      "i8* @allocRecord(i64)" (* runtime functions *);
      "i8* @initArray (i64, i64, i8*)";
      "i64 @arrInxError (i64)";
      "i64 @recFieldError()";
      "i64 @divisionByZero()";
      "i64 @stringEqual (i8*, i8*)";
      "i64 @stringNotEq (i8*, i8*)";
      "i64 @stringLess (i8*, i8*)";
      "i64 @stringLessEq (i8*, i8*)";
      "i64 @stringGreater (i8*, i8*)";
      "i64 @stringGreaterEq (i8*, i8*)";
      "i64 @exponent(i64, i64)" (* user visible functions; note SL argument *);
      "void @print      (i8*, i8*)";
      "void @flush      (i8*)";
      "i8*  @getChar    (i8*)";
      "i64  @ord        (i8*, i8*)";
      "i8*  @chr        (i8*, i64)";
      "i64  @size       (i8*, i8*)";
      "i8*  @substring  (i8*, i8*, i64, i64)";
      "i8*  @concat     (i8*, i8*, i8*)";
      "i64  @not        (i8*, i64)";
      "void @tigerexit  (i8*, i64)";
    ]
  in
  let mkDeclare s = "declare " ^ s ^ "\n" in
  String.concat "" (List.map mkDeclare fns)

let _ll_target_triple : string =
  let ic = Unix.open_process_in "uname" in
  let uname = input_line ic in
  let () = close_in ic in
  match uname with
  | "Darwin" -> "target triple = \"x86_64-apple-macosx10.15.0\""
  | "Linux" -> "target triple = \"x86_64-pc-linux-gnu\""
  | _ -> ""
