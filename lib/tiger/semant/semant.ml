(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(**************************************************************************)
open Tigercommon
module S = Symbol
module A = Absyn
module E = Semenv
module Err = Errenv
module EFmt = ErrorFormatter
module Ty = Types
module PT = Prtypes
module TA = Tabsyn

(** Context record contains the environments we use in our translation *)

type context =
  { venv: E.enventry S.table (* Γ from our formal typing rules *)
  ; tenv: Ty.ty S.table (* Δ from our formal typing rules *)
  ; err: Err.errenv (* error environment *)
  ; breakable: bool }

exception NotImplemented
(* the final code should work without this exception *)

module SymbolSet = Set.Make (String)
open Ty

let rec typeOf e = match e with TA.Exp {ty; _} -> ty

and coerce ty =
  match ty with
  | Ty.NAME (_, {contents= Some ty}) -> coerce ty
  | Ty.NAME (_, {contents= None}) -> Ty.ERROR
  | ty -> ty

and lookType ({err; tenv; _} : context) (k : Symbol.symbol * Lexing.position)
    =
  match S.look (tenv, fst k) with
  | Some ty -> ty
  | None ->
      Err.error err (snd k) (EFmt.errorTypeDoesNotExist (fst k)) ;
      Ty.ERROR

let subtype (t1, t2) : bool =
  let a, b = (coerce t1, coerce t2) in
  match (a, b) with Ty.NIL, Ty.RECORD (_, _) -> true | a, b -> a = b

let isSubtype (t1, t2) : bool =
  match (coerce t1, coerce t2) with
  | Ty.RECORD (_, u1), Ty.RECORD (_, u2) -> u1 = u2
  | _ ->
      let res =
        (coerce t1 != VOID && coerce t2 != VOID && subtype (t1, t2))
        || subtype (t2, t1)
      in
      res

let rec transExp ({err; venv; tenv; breakable} : context) e =
  let rec trexp (A.Exp {exp_base; pos}) =
    match exp_base with
    | A.SeqExp [l] -> trexp l
    | exp_base ->
        let exp_base, ty =
          match exp_base with
          | A.LetExp {decls; body} ->
              let {err; venv; tenv; breakable}, decls =
                List.fold_left_map transDecl
                  {err; venv; tenv; breakable}
                  decls
              in
              let body = transExp {err; venv; tenv; breakable} body in
              (TA.LetExp {decls; body}, typeOf body)
          | A.NilExp -> (TA.NilExp, Ty.NIL)
          | A.IntExp i -> (TA.IntExp i, Ty.INT)
          | A.StringExp s -> (TA.StringExp s, Ty.STRING)
          | A.VarExp v ->
              let var, ty, _ = trvar v in
              (TA.VarExp var, ty)
          | A.ArrayExp {typ; size; init} -> (
              let typ = lookType {err; venv; tenv; breakable} (typ, pos) in
              let size = trexp size in
              match typ with
              | Ty.NAME (_, {contents= Some arrType}) -> (
                match coerce arrType with
                | Ty.ARRAY (t1, _) -> (
                  match typeOf size with
                  | Ty.INT ->
                      let init = trexp init in
                      let t2 = typeOf init in
                      if isSubtype (t1, t2) then
                        (TA.ArrayExp {size; init}, typ)
                      else (
                        Err.error err pos (EFmt.errorArrayInitType t2 t1) ;
                        (TA.ErrorExp, Ty.ERROR) )
                  | t ->
                      Err.error err pos (EFmt.errorIntRequired t) ;
                      (TA.ErrorExp, Ty.ERROR) )
                | _ ->
                    Err.error err pos (EFmt.errorArrayType typ) ;
                    (TA.ErrorExp, Ty.ERROR) )
              | _ ->
                  Err.error err pos (EFmt.errorArrayType typ) ;
                  (TA.ErrorExp, Ty.ERROR) )
          | A.SeqExp [] -> (TA.SeqExp [], Ty.VOID)
          | A.SeqExp b ->
              let rec lastExp acc seq =
                match seq with
                | [l] ->
                    let exp = trexp l in
                    (TA.SeqExp (acc @ [exp]), typeOf exp)
                | h :: t ->
                    let exp = trexp h in
                    if typeOf exp = Ty.NIL then
                      Err.error err pos EFmt.errorInferNilType ;
                    lastExp (acc @ [exp]) t
                | [] -> failwith "unreachable"
              in
              lastExp [] b
          | A.AssignExp {var; exp} ->
              let var, ty, mut = trvar var and exp = trexp exp in
              let t1 = typeOf exp in
              if t1 == Ty.VOID then (
                Err.error err pos EFmt.errorVoid ;
                (TA.ErrorExp, Ty.ERROR) )
              else if isSubtype (t1, ty) then
                if mut then (TA.AssignExp {var; exp}, Ty.VOID)
                else (
                  ( match var with
                  | TA.Var {var_base= TA.SimpleVar var; pos; _} ->
                      Err.error err pos (EFmt.errorVariableUnassignable var)
                  | _ -> failwith "immutable non-for-variable!?" ) ;
                  (TA.ErrorExp, Ty.ERROR) )
              else (
                Err.error err pos (EFmt.errorCoercible t1 ty) ;
                (TA.AssignExp {var; exp}, Ty.ERROR) )
          | A.OpExp {left; oper; right} -> (
            match (trexp left, trexp right) with
            | ( TA.Exp {exp_base= l; pos= lp; ty= lty}
              , TA.Exp {exp_base= r; pos= rp; ty= rty} )
              when coerce lty = Ty.INT && coerce rty = Ty.INT ->
                ( TA.OpExp
                    { left= TA.Exp {exp_base= l; pos= lp; ty= lty}
                    ; oper
                    ; right= TA.Exp {exp_base= r; pos= rp; ty= rty} }
                , Ty.INT )
            | ( TA.Exp {exp_base= l; pos= lp; ty= Ty.STRING}
              , TA.Exp {exp_base= r; pos= rp; ty= Ty.STRING} ) -> (
              match oper with
              | EqOp | NeqOp | LtOp | LeOp | GtOp | GeOp ->
                  ( TA.OpExp
                      { left= TA.Exp {exp_base= l; pos= lp; ty= Ty.STRING}
                      ; oper
                      ; right= TA.Exp {exp_base= r; pos= rp; ty= Ty.STRING}
                      }
                  , Ty.INT )
              | _ ->
                  Err.error err pos EFmt.errorArith ;
                  (TA.ErrorExp, Ty.ERROR) )
            | ( TA.Exp {exp_base= l; pos= lp; ty= ty1}
              , TA.Exp {exp_base= r; pos= rp; ty= ty2} ) -> (
              match oper with
              | EqOp | NeqOp ->
                  if (ty1 != Ty.NIL || ty2 != Ty.NIL) && isSubtype (ty1, ty2)
                  then
                    ( TA.OpExp
                        { left= TA.Exp {exp_base= l; pos= lp; ty= ty1}
                        ; oper
                        ; right= TA.Exp {exp_base= r; pos= rp; ty= ty2} }
                    , Ty.INT )
                  else (
                    Err.error err pos (EFmt.errorEqNeqComparison ty1 ty2) ;
                    (TA.ErrorExp, Ty.ERROR) )
              | _ ->
                  Err.error err pos (EFmt.errorOtherComparison ty1 ty2) ;
                  (TA.ErrorExp, Ty.ERROR) ) )
          | A.IfExp {test; thn; els= Some els} -> (
            match (assertInt test, trexp thn, trexp els) with
            | ( test
              , TA.Exp {exp_base= e1; pos= p1; ty= t1; _}
              , TA.Exp {exp_base= e2; pos= p2; ty= t2; _} ) ->
                if isSubtype (t1, t2) then
                  ( TA.IfExp
                      { test
                      ; thn= TA.Exp {exp_base= e1; pos= p1; ty= t1}
                      ; els= Some (TA.Exp {exp_base= e2; pos= p2; ty= t2}) }
                  , qualType {err; venv; tenv; breakable} pos (t1, t2) )
                else (
                  Err.error err p1 (EFmt.errorIfBranchesNotSameType t1 t2) ;
                  (TA.ErrorExp, Ty.ERROR) ) )
          | A.IfExp {test; thn; els= None} -> (
              let test = assertInt test and thn = trexp thn in
              match thn with
              | TA.Exp {ty= Ty.VOID; _} ->
                  (TA.IfExp {test; thn; els= None}, Ty.VOID)
              | TA.Exp {pos; ty; _} ->
                  Err.error err pos (EFmt.errorIfThenShouldBeVoid ty) ;
                  (TA.ErrorExp, Ty.ERROR) )
          | A.BreakExp ->
              if breakable = false then Err.error err pos EFmt.errorBreak ;
              (TA.BreakExp, Ty.VOID)
          | A.CallExp {func; args} -> (
              let args = List.map trexp args in
              ( TA.CallExp {func; args}
              , match S.look (venv, func) with
                | Some (VarEntry _) ->
                    Err.error err pos
                      (EFmt.errorUsingVariableAsFunction func) ;
                    Ty.ERROR
                | Some (FunEntry {formals; result}) ->
                    let rec chkty a b =
                      match (a, b) with
                      | TA.Exp {ty; _} :: at, b :: bt ->
                          if isSubtype (ty, b) then chkty at bt
                          else (
                            Err.error err pos (EFmt.errorCoercible ty b) ;
                            false )
                      | [], [] -> true
                      | _ ->
                          Err.error err pos
                            (EFmt.errorFunctionArguments func) ;
                          false
                    in
                    if chkty args formals then result else Ty.ERROR
                | None ->
                    Err.error err pos (EFmt.errorFunctionUndefined func) ;
                    Ty.ERROR ) )
          | A.ForExp {var; escape; lo; hi; body} -> (
              let lo, hi = (assertInt lo, assertInt hi) in
              let body =
                transExp
                  { err
                  ; venv= S.enter (venv, var, VarEntry (Ty.INT, false))
                  ; tenv
                  ; breakable= true }
                  body
              in
              match body with
              | TA.Exp {ty= Ty.VOID; _} ->
                  (TA.ForExp {var; escape; lo; hi; body}, Ty.VOID)
              | TA.Exp {pos; ty; _} ->
                  Err.error err pos (EFmt.errorForShouldBeVoid ty) ;
                  (TA.ErrorExp, Ty.ERROR) )
          | A.WhileExp {test; body} -> (
            match
              ( assertInt test
              , transExp {err; venv; tenv; breakable= true} body )
            with
            | test, TA.Exp {exp_base= e1; pos= p1; ty; _} ->
                if ty = Ty.VOID then
                  ( TA.WhileExp
                      {test; body= TA.Exp {exp_base= e1; pos= p1; ty}}
                  , ty )
                else (
                  Err.error err p1 (EFmt.errorWhileShouldBeVoid ty) ;
                  (TA.ErrorExp, Ty.ERROR) ) )
          | A.RecordExp {fields; typ} -> (
              let t =
                lookType ({err; venv; tenv; breakable} : context) (typ, pos)
              in
              match coerce t with
              | RECORD (fs, _) ->
                  let types =
                    List.fold_left
                      (fun acc ((fd, ty) : S.symbol * ty) ->
                        S.enter (acc, fd, ty) )
                      S.empty fs
                  in
                  let fields =
                    List.fold_left
                      (fun acc ((fld, exp) : S.symbol * A.exp) ->
                        let texp = trexp exp in
                        S.enter
                          ( acc
                          , fld
                          , match S.look (types, fld) with
                            | Some ty when isSubtype (ty, typeOf texp) ->
                                texp
                            | Some _ ->
                                Err.error err pos EFmt.errorRecordFields ;
                                TA.Exp
                                  {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
                            | None ->
                                Err.error err pos EFmt.errorRecordFields ;
                                TA.Exp
                                  {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
                          ) )
                      S.empty fields
                  in
                  if S.numItems fields != S.numItems types then (
                    Err.error err pos EFmt.errorRecordFields ;
                    (TA.ErrorExp, Ty.ERROR) )
                  else
                    let fields =
                      List.map
                        (fun (fld, _) ->
                          match S.look (fields, fld) with
                          | Some texp -> (fld, texp)
                          | None ->
                              Err.error err pos EFmt.errorRecordFields ;
                              ( fld
                              , TA.Exp
                                  {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
                              ) )
                        fs
                    in
                    (TA.RecordExp {fields}, t)
              | _ ->
                  Err.error err pos (EFmt.errorRecordType t) ;
                  (TA.ErrorExp, Ty.ERROR) )
        in
        TA.Exp {exp_base; pos; ty}
  and lookVar (k : Symbol.symbol * Lexing.position) =
    match S.look (venv, fst k) with
    | Some (VarEntry (ty, mut)) -> (ty, mut)
    | Some (FunEntry _) ->
        Err.error err (snd k) (EFmt.errorUsingFunctionAsVariable (fst k)) ;
        (Ty.ERROR, false)
    | None ->
        Err.error err (snd k) (EFmt.errorVariableUndefined (fst k)) ;
        (Ty.ERROR, false)
  and assertInt e =
    match trexp e with
    | TA.Exp {pos; ty; _} when coerce ty != Ty.INT ->
        Err.error err pos EFmt.errorArith ;
        TA.Exp {exp_base= TA.IntExp 0L; pos; ty= Ty.INT}
    | e' -> e'
  and trvar (A.Var {var_base; pos}) : TA.var * Ty.ty * bool =
    match var_base with
    | A.SimpleVar v ->
        let ty, mut = lookVar (v, pos) in
        (TA.Var {var_base= TA.SimpleVar v; pos; ty}, ty, mut)
    | A.FieldVar (lval, fieldName) -> (
        let n, t, _ = trvar lval in
        let t' = coerce t in
        match t' with
        | Ty.RECORD (fs, _) ->
            let rec fieldIter l =
              match l with
              | [] ->
                  Err.error err pos
                    (EFmt.errorRecordNonExistingField fieldName t') ;
                  ( TA.Var
                      { var_base= TA.SimpleVar (S.symbol "err")
                      ; pos
                      ; ty= Ty.ERROR }
                  , Ty.ERROR
                  , false )
              | (fName, ty) :: next ->
                  if fName = fieldName then
                    ( TA.Var {var_base= TA.FieldVar (n, fieldName); pos; ty}
                    , ty
                    , true )
                  else fieldIter next
            in
            fieldIter fs
        | ty ->
            Err.error err pos (EFmt.errorRecordType ty) ;
            ( TA.Var
                {var_base= TA.SimpleVar (S.symbol "err"); pos; ty= Ty.ERROR}
            , Ty.ERROR
            , false ) )
    | A.SubscriptVar (v, i) -> (
        let v, ty, _ = trvar v in
        match coerce ty with
        | Ty.ARRAY (ty, _) ->
            let i = trexp i in
            (TA.Var {var_base= TA.SubscriptVar (v, i); pos; ty}, ty, true)
        | t ->
            Err.error err pos (EFmt.errorArrayType t) ;
            ( TA.Var {var_base= SimpleVar (S.symbol "err"); pos; ty= Ty.ERROR}
            , Ty.ERROR
            , false ) )
  in
  trexp e

and transTy ({err; tenv; _} : context) (ty : A.ty) : Types.ty =
  match ty with
  | NameTy (s, pos) -> (
    match S.look (tenv, s) with
    | Some ty -> ty
    | None ->
        Err.error err pos (EFmt.errorTypeDoesNotExist s) ;
        Ty.ERROR )
  | _ -> raise NotImplemented

and transField ({err; venv; tenv; breakable} : context) visited
    (A.Field {name; escape; typ; pos}) =
  if SymbolSet.mem (S.name name) visited then (
    Err.error err pos (EFmt.errorDuplicate name) ;
    ( SymbolSet.add (S.name name) visited
    , TA.Arg {name; escape; ty= Ty.ERROR; pos} ) )
  else
    ( SymbolSet.add (S.name name) visited
    , TA.Arg
        {name; escape; ty= lookType {err; venv; tenv; breakable} typ; pos} )

and funHeader ({err; tenv; breakable; _} : context) (venv, ss) f =
  match f with
  | A.Fdecl {name; params; result; pos; _} ->
      if SymbolSet.mem (S.name name) ss then
        Err.error err pos (EFmt.errorDuplicate name) ;
      let _, args =
        List.fold_left_map
          (transField {err; venv; tenv; breakable})
          SymbolSet.empty params
      in
      let formals =
        List.map (fun a -> match a with TA.Arg {ty; _} -> ty) args
      and result =
        match result with
        | Some result -> lookType {err; venv; tenv; breakable} result
        | None -> Ty.VOID
      in
      ( S.enter (venv, name, FunEntry {formals; result})
      , SymbolSet.add (S.name name) ss )

and transFun ({err; tenv; breakable; _} : context) venv f =
  match f with
  | A.Fdecl {name; params; result; body; pos} ->
      let _, args =
        List.fold_left_map
          (transField {err; venv; tenv; breakable})
          SymbolSet.empty params
      in
      let venv =
        S.enter
          ( venv
          , name
          , FunEntry
              { formals=
                  List.map
                    (fun a -> match a with TA.Arg {ty; _} -> ty)
                    args
              ; result=
                  ( match result with
                  | Some result ->
                      lookType {err; venv; tenv; breakable} result
                  | None -> Ty.VOID ) } )
      in
      ( venv
      , let venv' : E.enventry S.table =
          List.fold_left
            (fun (venv : E.enventry S.table) (a : TA.argdata) ->
              match a with
              | TA.Arg {name; ty; _} ->
                  S.enter (venv, name, VarEntry (ty, true)) )
            venv args
        in
        let body = transExp {err; venv= venv'; tenv; breakable} body
        and result =
          match result with
          | Some result -> lookType {err; venv; tenv; breakable} result
          | None -> Ty.VOID
        in
        if isSubtype (typeOf body, result) = false then
          Err.error err pos (EFmt.errorFunctionReturn (typeOf body) result) ;
        let result =
          match (typeOf body, result) with
          | NIL, NIL -> failwith "Uncaught NIL Record."
          | NIL, res -> res
          | res, NIL -> res
          | _ when isSubtype (typeOf body, result) = false -> Ty.ERROR
          | _ when isSubtype (typeOf body, result) -> result
          | _ -> failwith "Uncreachable"
        in
        TA.Fdecl {name; args; result; body; pos} )

and qualType ({err; _} : context) pos = function
  | NIL, NIL -> NIL
  | NIL, res -> res
  | res, NIL -> res
  | t1, t2 when isSubtype (t1, t2) = false ->
      Err.error err pos (EFmt.errorCoercible t1 t2) ;
      Ty.ERROR
  | t1, t2 when isSubtype (t1, t2) -> t1
  | _ -> failwith "Uncreachable"

and transTdecl1 ({err; tenv; _} : context) (tdecs : A.tydecldata list) :
    Ty.ty S.table * (A.ty * TA.tydecldata) list =
  let transTdeclInner (tenv, visited) (A.Tdecl {name; ty; pos} : A.tydecldata)
      : (Ty.ty S.table * SymbolSet.t) * (A.ty * TA.tydecldata) =
    if SymbolSet.mem (S.name name) visited then
      Err.error err pos (EFmt.errorDuplicate name) ;
    let ty' =
      match ty with
      | A.NameTy (sym, _) when S.name sym = "int" ->
          Ty.NAME (name, ref (Some Ty.INT))
      | A.NameTy (sym, _) when S.name sym = "string" ->
          Ty.NAME (name, ref (Some Ty.STRING))
      | A.NameTy (_, _) -> Ty.NAME (name, ref None)
      | A.ArrayTy (_, _) -> Ty.NAME (name, ref None)
      | A.RecordTy _ -> Ty.NAME (name, ref None)
    in
    ( (S.enter (tenv, name, ty'), SymbolSet.add (S.name name) visited)
    , (ty, TA.Tdecl {name; pos; ty= ty'}) )
  in
  let (tenv, _), tdecs =
    List.fold_left_map transTdeclInner (tenv, SymbolSet.empty) tdecs
  in
  (tenv, tdecs)

and transTdecl2 ({err; tenv; _} : context)
    (tdecs : (A.ty * TA.tydecldata) list) :
    Ty.ty S.table * TA.tydecldata list =
  let transTdeclInner ((lty, tdecl) : A.ty * TA.tydecldata) : TA.tydecldata =
    let (TA.Tdecl {ty= rty; _}) = tdecl in
    match (lty, rty) with
    | A.NameTy (rty, _), Ty.NAME (_, tyref) -> (
      match S.look (tenv, rty) with
      | Some ty ->
          tyref := Some ty ;
          tdecl
      | None -> failwith "unreachable" )
    | A.ArrayTy (rty, _), Ty.NAME (_, tyref) -> (
      match S.look (tenv, rty) with
      | Some ty ->
          tyref := Some (Ty.ARRAY (ty, Ty.mkUnique ())) ;
          tdecl
      | None -> failwith "unreachable" )
    | A.RecordTy fs, Ty.NAME (_, tyref) ->
        let _, fs =
          List.fold_left_map
            (fun visited (A.Field {name; typ; pos; _}) ->
              if SymbolSet.mem (S.name name) visited then
                Err.error err pos (EFmt.errorDuplicate name) ;
              ( SymbolSet.add (S.name name) visited
              , ( name
                , match S.look (tenv, fst typ) with
                  | Some ty -> ty
                  | None ->
                      Err.error err pos
                        (EFmt.errorTypeDoesNotExist (fst typ)) ;
                      Ty.ERROR ) ) )
            SymbolSet.empty fs
        in
        tyref := Some (Ty.RECORD (fs, Ty.mkUnique ())) ;
        tdecl
    | _ -> raise NotImplemented
  in
  let tdecs = List.map transTdeclInner tdecs in
  (tenv, tdecs)

and checkCyclesFor ({err; venv; tenv; breakable} : context)
    (TA.Tdecl {ty; pos; _} : TA.tydecldata) =
  let rec checkCyclesInner {err; venv; tenv; breakable} (ty : Ty.ty)
      (visited : SymbolSet.t) : bool =
    match ty with
    | Ty.NAME (name, {contents= Some rty}) ->
        if SymbolSet.mem (S.name name) visited then (
          Err.error err pos (EFmt.errorTypeDeclLoop []) ;
          false )
        else
          checkCyclesInner
            {err; venv; tenv; breakable}
            rty
            (SymbolSet.add (S.name name) visited)
    | _ -> true
  in
  checkCyclesInner {err; venv; tenv; breakable} ty SymbolSet.empty

and checkCycles ({err; venv; tenv; breakable} : context)
    (tdecs : TA.tydecldata list) =
  List.for_all (checkCyclesFor {err; venv; tenv; breakable}) tdecs

and transDecl ({err; venv; tenv; breakable} : context) dec =
  match dec with
  | A.VarDec {name; escape; typ= None; init; _} -> (
      let exp = transExp {err; venv; tenv; breakable} init in
      match exp with
      | TA.Exp {pos; ty= Ty.VOID; _} ->
          Err.error err pos (EFmt.errorCoercible Ty.VOID Ty.NIL) ;
          ( {err; venv; tenv; breakable}
          , TA.VarDec
              { name
              ; escape
              ; typ= Ty.ERROR
              ; init= TA.Exp {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
              ; pos } )
      | TA.Exp {pos; ty= Ty.NIL; _} ->
          Err.error err pos (EFmt.errorNil name) ;
          ( {err; venv; tenv; breakable}
          , TA.VarDec
              { name
              ; escape
              ; typ= Ty.ERROR
              ; init= TA.Exp {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
              ; pos } )
      | TA.Exp {pos; ty; _} ->
          ( { err
            ; venv= S.enter (venv, name, VarEntry (typeOf exp, true))
            ; tenv
            ; breakable }
          , TA.VarDec {name; escape; typ= ty; init= exp; pos} ) )
  | A.VarDec {name; escape; typ= Some typ; init; pos} -> (
      let ty' =
        transTy {err; venv; tenv; breakable} (A.NameTy (fst typ, snd typ))
      in
      let exp = transExp {err; venv; tenv; breakable} init in
      let ty = typeOf exp in
      match (coerce ty', coerce ty) with
      | Ty.NIL, Ty.NIL ->
          Err.error err pos EFmt.errorInferNilType ;
          ( {err; venv; tenv; breakable}
          , TA.VarDec {name; escape; typ= Ty.ERROR; init= exp; pos} )
      | Ty.STRING, Ty.NIL | Ty.INT, Ty.NIL | Ty.ARRAY _, Ty.NIL ->
          Err.error err pos (EFmt.errorCoercible ty ty') ;
          ( { err
            ; venv= S.enter (venv, name, VarEntry (ty', true))
            ; tenv
            ; breakable }
          , TA.VarDec
              { name
              ; escape
              ; typ= Ty.ERROR
              ; init= TA.Exp {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
              ; pos } )
      | _, Ty.NIL ->
          ( { err
            ; venv= S.enter (venv, name, VarEntry (ty', true))
            ; tenv
            ; breakable }
          , TA.VarDec {name; escape; typ= ty'; init= exp; pos} )
      | Ty.NIL, _ ->
          ( { err
            ; venv= S.enter (venv, name, VarEntry (ty, true))
            ; tenv
            ; breakable }
          , TA.VarDec {name; escape; typ= ty; init= exp; pos} )
      | lty, rty when coerce lty == coerce rty ->
          ( { err
            ; venv= S.enter (venv, name, VarEntry (ty', true))
            ; tenv
            ; breakable }
          , TA.VarDec {name; escape; typ= ty'; init= exp; pos} )
      | _ ->
          Err.error err pos (EFmt.errorCoercible ty' ty) ;
          ( {err; venv; tenv; breakable}
          , TA.VarDec {name; escape; typ= Ty.ERROR; init= exp; pos} ) )
  | A.FunctionDec funs ->
      let venv, _ =
        List.fold_left
          (funHeader {err; venv; tenv; breakable= false})
          (venv, SymbolSet.empty) funs
      in
      let venv, decs =
        List.fold_left_map
          (transFun {err; venv; tenv; breakable= false})
          venv funs
      in
      ({err; venv; tenv; breakable}, TA.FunctionDec decs)
  | A.TypeDec tdecs ->
      let tenv', tdecs' = transTdecl1 {err; venv; tenv; breakable} tdecs in
      let tenv', tdecs' =
        transTdecl2 {err; venv; tenv= tenv'; breakable} tdecs'
      in
      if checkCycles {err; venv; tenv; breakable} tdecs' then
        ({err; venv; tenv= tenv'; breakable}, TA.TypeDec tdecs')
      else ({err; venv; tenv; breakable}, TA.TypeDec [])

(* no need to change the implementation of the top level function *)

let transProg (e : A.exp) : TA.exp * Err.errenv =
  let err = Err.initial_env in
  ( ( match
        transExp
          {venv= E.baseVenv; tenv= E.baseTenv; err; breakable= false}
          e
      with
    | TA.Exp {ty; pos; _} when ty = Ty.NIL ->
        Err.error err pos EFmt.errorInferNilType ;
        TA.Exp {exp_base= TA.ErrorExp; pos; ty= Ty.ERROR}
    | e -> e )
  , err )
