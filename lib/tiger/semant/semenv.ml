(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(**************************************************************************)

open Tigercommon
module S = Symbol
module Ty = Types

type enventry =
  | VarEntry of Types.ty * bool
  | FunEntry of {formals: Types.ty list; result: Types.ty}

let baseVenv =
  List.fold_left
    (fun f (n, fs, r) ->
      S.enter (f, S.symbol n, FunEntry {formals= fs; result= r}) )
    S.empty
    [ ("print", [Ty.STRING], Ty.VOID)
    ; ("flush", [], Ty.VOID)
    ; ("getchar", [], Ty.STRING)
    ; ("ord", [Ty.STRING], Ty.INT)
    ; ("chr", [Ty.INT], Ty.STRING)
    ; ("size", [Ty.STRING], Ty.INT)
    ; ("substring", [Ty.STRING; Ty.INT; Ty.INT], Ty.STRING)
    ; ("concat", [Ty.STRING; Ty.STRING], Ty.STRING)
    ; ("not", [Ty.INT], Ty.INT)
    ; ("exit", [Ty.INT], Ty.VOID)
    ; ( "dummy"
      , [ Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING
        ; Ty.STRING ]
      , Ty.VOID ) ]

let baseTenv =
  List.fold_left
    (fun f (n, t) -> S.enter (f, S.symbol n, t))
    S.empty
    [("int", Ty.INT); ("string", Ty.STRING)]
