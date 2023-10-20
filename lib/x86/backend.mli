open Tigercommon

val compile_prog : Ll.prog -> X86.prog
val compile_prog_pre : Ll.prog -> X86.vprog

type 'a lsa

val lsa : Ll.prog -> ((Ll.uid * Ll.fdecl) * (int * int) lsa) list
val string_of_lsas : ((Ll.uid * Ll.fdecl) * (int * int) lsa) list -> string
val dot : ((Ll.uid * Ll.fdecl) * (int * int) lsa) list -> string
val prelsa : X86.vprog -> ((int * int) lsa * X86.velem) list
val string_of_prelsa : ((int * int) lsa * X86.velem) list -> string
