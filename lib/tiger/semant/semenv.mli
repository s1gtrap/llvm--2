(**************************************************************************)
(* AU Compilation. Assignment submissions can modify this file            *)
(**************************************************************************)

open Tigercommon

type enventry =
  | VarEntry of Types.ty * bool
  | FunEntry of {formals: Types.ty list; result: Types.ty}

val baseVenv : enventry Tigercommon.Symbol.table

val baseTenv : Types.ty Tigercommon.Symbol.table
