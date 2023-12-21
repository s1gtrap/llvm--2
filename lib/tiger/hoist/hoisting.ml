(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(**************************************************************************)

open Tigercommon
module S = Symbol
module E = Hoistenv
module H = Habsyn
module A = Alphaabsyn

(***************************************************************************
  Much of the boilerplate in this file is already implemented. What's left to
  do is marked by the NotImplemented exception. We also include default
  implementations that cover parts for the LL0 feature set; these are guarded
  using the _ONLY_LL0_FEATURESET flag declared below. If aiming for feature
  sets beyond LL0, the code should work with this flag set to false.
  ***************************************************************************)

(* The code should eventually compile without this exception *)
exception NotImplemented

exception HoistingFatal (* for impossible cases *)

type writer =
  { mutable fdecls_rev: H.fundecldata list
  ; mutable tdecls_rev: H.tydecldata list }

type context =
  { venv: int S.table
  ; writer: writer
  ; name: S.symbol
  ; level: int
  ; locals_ref: (S.symbol * Types.ty) list ref }

let emit_tdecl writer tdecl = writer.tdecls_rev <- tdecl :: writer.tdecls_rev

let emit_fdecl writer fdecl = writer.fdecls_rev <- fdecl :: writer.fdecls_rev

(* Because the ASTs that we work with at this point have all passed the
   semantic analysis we expect all environment lookups to succeed, and
   therefore use a simplified version of the lookup function.*)
let look (e, k) =
  match S.look (e, k) with Some r -> r | None -> raise HoistingFatal

let rec hoist_exp (ctxt : context) (Exp {exp_base; pos; ty} : A.exp) : H.exp
    =
  let hoistE_ = hoist_exp ctxt and hoistV_ = hoist_var ctxt in
  let hoist_2_b (a, b) = (a, hoistE_ b) in
  let exp_base' : H.exp_base =
    match exp_base with
    | VarExp var -> VarExp (hoistV_ var)
    | NilExp -> NilExp
    | IntExp i -> IntExp i
    | StringExp s -> StringExp s
    | CallExp {func; args} ->
        let func_level = Option.get (S.look (ctxt.venv, func)) in
        let lvl_diff = ctxt.level - func_level in
        CallExp {func; lvl_diff; args= List.map hoistE_ args}
    | OpExp {left; oper; right} ->
        OpExp {left= hoistE_ left; oper; right= hoistE_ right}
    | RecordExp {fields} -> RecordExp {fields= List.map hoist_2_b fields}
    | SeqExp exps -> SeqExp (List.map hoistE_ exps)
    | AssignExp {var; exp} -> AssignExp {var= hoistV_ var; exp= hoistE_ exp}
    | IfExp {test; thn; els} ->
        IfExp
          {test= hoistE_ test; thn= hoistE_ thn; els= Option.map hoistE_ els}
    | WhileExp {test; body} ->
        WhileExp {test= hoistE_ test; body= hoistE_ body}
    | ForExp {var; lo; hi; body; escape} ->
        let ivar = A.Var {var_base= SimpleVar var; pos; ty= INT} in
        let iexp = A.Exp {exp_base= VarExp ivar; pos; ty= INT} in
        let inc = A.Exp {exp_base= IntExp 1; pos; ty= INT} in
        let iop =
          A.Exp
            { exp_base= OpExp {left= iexp; oper= PlusOp; right= inc}
            ; pos
            ; ty= INT }
        in
        let ass =
          A.Exp {exp_base= AssignExp {var= ivar; exp= iop}; pos; ty= VOID}
        in
        let body = A.Exp {exp_base= SeqExp [body; ass]; pos; ty= VOID} in
        let decls =
          [A.VarDec {name= var; escape; typ= INT; init= lo; pos}]
        in
        let test =
          A.Exp
            { exp_base= OpExp {left= iexp; oper= LeOp; right= hi}
            ; pos
            ; ty= INT }
        in
        let body =
          A.Exp {exp_base= A.WhileExp {test; body}; pos; ty= VOID}
        in
        let (H.Exp {exp_base; _}) =
          hoistE_ (A.Exp {exp_base= LetExp {decls; body}; pos; ty= INT})
        in
        exp_base
    | BreakExp -> BreakExp
    | LetExp {decls; body} ->
        let enter (ctxt, ds) d =
          match hoist_decl ctxt d with
          | ctxt', Some d' -> (ctxt', d' :: ds)
          | ctxt', None -> (ctxt', ds)
        in
        let ctxt', vardecls_rev = List.fold_left enter (ctxt, []) decls in
        let (Exp {ty; _} as body') = hoist_exp ctxt' body in
        let (Exp {exp_base; _}) =
          List.fold_left
            (fun body vardecl ->
              H.Exp {exp_base= LetExp {vardecl; body}; pos; ty} )
            body' vardecls_rev
        in
        exp_base
    | ArrayExp {size; init} ->
        ArrayExp {size= hoistE_ size; init= hoistE_ init}
  in
  Exp {exp_base= exp_base'; pos; ty}

and hoist_var ctxt (Var {var_base; pos; ty} : A.var) : H.var =
  let var_base' : H.var_base =
    match var_base with
    | SimpleVar x ->
        let n = Option.get (S.look (ctxt.venv, x)) in
        AccessVar (ctxt.level - n, x)
    | FieldVar (v, x) -> FieldVar (hoist_var ctxt v, x)
    | SubscriptVar (v, e) -> SubscriptVar (hoist_var ctxt v, hoist_exp ctxt e)
  in
  Var {var_base= var_base'; pos; ty}

(* Observe the return type in hoisting of the declarations includes
   the updated context. *)
and hoist_decl (ctxt : context) (d : A.decl) : context * H.vardecl option =
  (* Explain the return type *)
  match d with
  (* The VarDec case is fully included in the skeleton;
     no modification here are expected *)
  | VarDec {name; escape; typ; init; pos} ->
      (* This whole case should be in the skeleton *)
      let init = hoist_exp ctxt init in
      let d = H.VarDec {name; escape; typ; init; pos} in
      (* we use the current level that we have set in the context *)
      let venv = S.enter (ctxt.venv, name, ctxt.level) in
      (* need to account for the local variables; obs the mutable update *)
      ctxt.locals_ref := (name, typ) :: !(ctxt.locals_ref) ;
      ({ctxt with venv}, Some d)
  | TypeDec tdecls ->
      let venv =
        List.fold_left
          (fun venv (A.Tdecl {name; ty; pos}) ->
            emit_tdecl ctxt.writer (H.Tdecl {name; ty; pos}) ;
            S.enter (venv, name, ctxt.level) )
          ctxt.venv tdecls
      in
      ({ctxt with venv}, None)
  | FunctionDec fdecs ->
      let venv =
        List.fold_left
          (fun venv (A.Fdecl {name; _}) -> S.enter (venv, name, ctxt.level))
          ctxt.venv fdecs
      in
      let ctxt = {ctxt with venv} in
      let rec fdec ctxt = function
        | A.Fdecl {name; args; result; body; pos} :: tail ->
            let venv, args =
              List.fold_left_map
                (fun venv (A.Arg {name; escape; ty; pos}) ->
                  ctxt.locals_ref := (name, ty) :: !(ctxt.locals_ref) ;
                  ( S.enter (venv, name, ctxt.level + 1)
                  , H.Arg {name; escape; ty; pos} ) )
                ctxt.venv args
            in
            let locals_list : (S.symbol * Types.ty) list =
              List.map (fun (H.Arg {name; ty; _}) -> (name, ty)) args
            in
            let parent_ctxt = ctxt in
            let ctxt =
              { venv
              ; writer= ctxt.writer
              ; name
              ; level= ctxt.level + 1
              ; locals_ref= ref locals_list }
            in
            let body = hoist_exp ctxt body in
            let f =
              H.Fdecl
                { name
                ; args
                ; result
                ; body
                ; pos
                ; parent_opt= Some parent_ctxt.name
                ; locals= !(ctxt.locals_ref) }
            in
            (* We are using the writer module to emit declaration for the main function *)
            emit_fdecl ctxt.writer f ;
            (*let venv = S.enter (ctxt.venv, name, ctxt.level) in*)
            fdec {parent_ctxt with venv} tail
        | [] -> (ctxt, None)
      in
      fdec ctxt fdecs

(* Hoist function / completed *)
let hoist (Exp {pos; ty; _} as aexp : A.exp) : H.program =
  let writer = {fdecls_rev= []; tdecls_rev= []} in
  let init_context =
    { venv= E.baseVenv
    ; writer
    ; name= S.symbol "tigermain"
    ; level= 1
    ; locals_ref= ref [] }
  in
  let main_exp = hoist_exp init_context aexp in
  let main =
    H.Fdecl
      { name= S.symbol "tigermain"
      ; args= []
      ; result= ty
      ; body= main_exp
      ; pos
      ; parent_opt= None
      ; locals= !(init_context.locals_ref) }
  in
  (* We are using the writer module to emit declaration for the main function *)
  emit_fdecl writer main ;
  Program
    {tdecls= List.rev writer.tdecls_rev; fdecls= List.rev writer.fdecls_rev}
