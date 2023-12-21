(**************************************************************************)
(* AU Compilation. Assignment submissions must not modify this file       *)
(**************************************************************************)

(** Tigerc compiler main interface. We do not expose any modules *)

(* Obs: if you want to test your phases by calling them from OCaml utop
   then you need to uncomment the corresponding functions here *)

(*val semant: Absyn.exp -> Tabsyn.exp*)

val llvm : string -> Format.formatter -> unit
