open Graph
module S = Symbol

exception BackendFatal (* use this for impossible cases *)

type os = Linux | Darwin

let os =
  let ic = Unix.open_process_in "uname" in
  let uname = input_line ic in
  let () = close_in ic in
  match uname with
  | "Linux" -> Linux
  | "Darwin" -> Darwin
  | _ -> raise BackendFatal

let mangle s =
  match os with Linux -> Symbol.name s | Darwin -> "_" ^ Symbol.name s

type lbl = string
type quad = int64

(* Immediate operands *)
type imm = Lit of quad | Lbl of lbl

(* Registers:
    instruction pointer: rip
    arguments: rdi, rsi, rdx, rcx, r08, r09
    callee-save: rbx, rbp, r12-r15
*)

type reg =
  | Rip
  | Rax
  | Rbx
  | Rcx
  | Rdx
  | Rsi
  | Rdi
  | Rbp
  | Rsp
  | R08
  | R09
  | R10
  | R11
  | R12
  | R13
  | R14
  | R15
  | Eax
  | Ebx
  | Ecx
  | Edx
  | Esi
  | Edi
  | Ebp
  | Esp
  | R08d
  | R09d
  | R10d
  | R11d
  | R12d
  | R13d
  | R14d
  | R15d
  | Al
  | Cl
  | Dl
  | Bl
  | Sil
  | Dil
  | R08b
  | R09b
  | R10b
  | R11b
  | R12b
  | R13b
  | R14b
  | R15b

type operand =
  | Imm of imm (* immediate *)
  | Reg of reg (* register *)
  | Ind1 of imm (* indirect: displacement *)
  | Ind2 of reg (* indirect: (%reg) *)
  | Ind3 of (imm * reg)
(* indirect: displacement(%reg) *)

let byteofquad = function
  | Reg Rax -> Reg Al
  | Reg Rcx -> Reg Cl
  | Reg Rdx -> Reg Dl
  | Reg Rbx -> Reg Bl
  | Reg Rsi -> Reg Sil
  | Reg Rdi -> Reg Dil
  | Reg R08 -> Reg R08b
  | Reg R09 -> Reg R09b
  | Reg R10 -> Reg R10b
  | Reg R11 -> Reg R11b
  | Reg R12 -> Reg R12b
  | Reg R13 -> Reg R13b
  | Reg R14 -> Reg R14b
  | Reg R15 -> Reg R15b
  | op -> op

let longofquad = function
  | Reg Rax -> Reg Eax
  | Reg Rcx -> Reg Ecx
  | Reg Rdx -> Reg Edx
  | Reg Rbx -> Reg Ebx
  | Reg Rsi -> Reg Esi
  | Reg Rdi -> Reg Edi
  | Reg R08 -> Reg R08d
  | Reg R09 -> Reg R09d
  | Reg R10 -> Reg R10d
  | Reg R11 -> Reg R11d
  | Reg R12 -> Reg R12d
  | Reg R13 -> Reg R13d
  | Reg R14 -> Reg R14d
  | Reg R15 -> Reg R15d
  | op -> op

(* Condition Codes *)
type cnd = Eq | Neq | Gt | Ge | Lt | Le | Ult | Ule | Ugt | Uge

type opcode =
  | Movq
  | Movl
  | Movb
  | Cmoveq
  | Pushq
  | Popq
  | Leaq (* Load Effective Address *)
  | Incq
  | Decq
  | Negq
  | Notq
  | Addq
  | Subq
  | Imulq
  | Xorq
  | Orq
  | Andq
  | Shlq
  | Sarq
  | Shrb
  | Shrl
  | Shrq
  | Srem
  | Urem
  | Jmp
  | J of cnd
  | Cmpq
  | Cmpl
  | Set of cnd
  | Callq
  | Retq
  | Cqto
  | Idivq
  | Idivl
  | Divq
  | Divl
  | Comment of string

(* An instruction is an opcode plus its operands.
   Note that arity and other constraints about the operands
   are not checked. *)
type ins = opcode * operand list
type data = Asciz of string | Quad of imm

type asm =
  | Text of ins list
  (* code *)
  | Data of data list (* data *)

(* labeled blocks with data or code *)
type elem = { lbl : lbl; global : bool; asm : asm }
type prog = elem list

(* Provide some syntactic sugar for writing x86 code in SML files. *)

(* pretty printing ----------------------------------------------------------- *)

let string_of_reg (r : reg) : string =
  match r with
  | Rip -> "%rip"
  | Rax -> "%rax"
  | Rbx -> "%rbx"
  | Rcx -> "%rcx"
  | Rdx -> "%rdx"
  | Rsi -> "%rsi"
  | Rdi -> "%rdi"
  | Rbp -> "%rbp"
  | Rsp -> "%rsp"
  | R08 -> "%r8"
  | R09 -> "%r9"
  | R10 -> "%r10"
  | R11 -> "%r11"
  | R12 -> "%r12"
  | R13 -> "%r13"
  | R14 -> "%r14"
  | R15 -> "%r15"
  | Eax -> "%eax"
  | Ebx -> "%ebx"
  | Ecx -> "%ecx"
  | Edx -> "%edx"
  | Esi -> "%esi"
  | Edi -> "%edi"
  | Ebp -> "%ebp"
  | Esp -> "%esp"
  | R08d -> "%r8d"
  | R09d -> "%r9d"
  | R10d -> "%r10d"
  | R11d -> "%r11d"
  | R12d -> "%r12d"
  | R13d -> "%r13d"
  | R14d -> "%r14d"
  | R15d -> "%r15d"
  | Al -> "%al"
  | Cl -> "%cl"
  | Dl -> "%dl"
  | Bl -> "%bl"
  | Sil -> "%sil"
  | Dil -> "%dil"
  | R08b -> "%r8b"
  | R09b -> "%r9b"
  | R10b -> "%r10b"
  | R11b -> "%r11b"
  | R12b -> "%r12b"
  | R13b -> "%r13b"
  | R14b -> "%r14b"
  | R15b -> "%r15b"

let string_of_lbl (l : lbl) : string = l

let string_of_imm = function
  | Lit i -> Int64.to_string i
  | Lbl l -> string_of_lbl l

let string_of_operand (oper : operand) : string =
  match oper with
  | Imm i -> "$" ^ string_of_imm i
  | Reg r -> string_of_reg r
  | Ind1 i -> string_of_imm i
  | Ind2 r -> "(" ^ string_of_reg r ^ ")"
  | Ind3 (i, r) -> string_of_imm i ^ "(" ^ string_of_reg r ^ ")"

let string_of_jmp_operand (oper : operand) : string =
  match oper with
  | Imm i -> string_of_imm i
  | Reg r -> "*" ^ string_of_reg r
  | Ind1 i -> "*" ^ string_of_imm i
  | Ind2 r -> "*" ^ "(" ^ string_of_reg r ^ ")"
  | Ind3 (i, r) -> "*" ^ string_of_imm i ^ "(" ^ string_of_reg r ^ ")"

let string_of_cnd (c : cnd) : string =
  match c with
  | Eq -> "e"
  | Neq -> "ne"
  | Gt -> "g"
  | Ge -> "ge"
  | Lt -> "l"
  | Le -> "le"
  | Ugt -> "a" (* FIXME: test *)
  | Uge -> "nb" (* FIXME: test *)
  | Ult -> "b" (* FIXME: test *)
  | Ule -> "be" (* FIXME: test *)

let string_of_opcode (opc : opcode) : string =
  match opc with
  | Movq -> "movq"
  | Movl -> "movl"
  | Movb -> "movb"
  | Cmoveq -> "cmoveq"
  | Pushq -> "pushq"
  | Popq -> "popq"
  | Leaq -> "leaq"
  | Incq -> "incq"
  | Decq -> "decq"
  | Negq -> "negq"
  | Notq -> "notq"
  | Addq -> "addq"
  | Subq -> "subq"
  | Imulq -> "imulq"
  | Xorq -> "xorq"
  | Orq -> "orq"
  | Andq -> "andq"
  | Shlq -> "shlq"
  | Sarq -> "sarq"
  | Shrb -> "shrb"
  | Shrl -> "shrl"
  | Shrq -> "shrq"
  | Srem -> "srem"
  | Urem -> "urem"
  | Jmp -> "jmp"
  | J c -> "j" ^ string_of_cnd c
  | Cmpq -> "cmpq"
  | Cmpl -> "cmpl"
  | Set c -> "set" ^ string_of_cnd c
  | Callq -> "callq"
  | Retq -> "retq"
  | Cqto -> "cqto"
  | Idivq -> "idivq"
  | Idivl -> "idivl"
  | Divq -> "divq"
  | Divl -> "divl"
  | Comment s -> "# " ^ String.escaped s

let map_concat s f l = String.concat s (List.map f l)

let string_of_shift oper args =
  match args with
  | [ Imm _; _ ] as args ->
      "\t" ^ string_of_opcode oper ^ "\t"
      ^ map_concat ", " string_of_operand args
  | [ Reg (Rcx | Cl); dst ] ->
      "\t" ^ string_of_opcode oper ^ "\t%cl," ^ string_of_operand dst
  | args ->
      failwith
        ("shift instruction has invalid operands: "
        ^ map_concat ", " string_of_operand args)

let string_of_ins (oper, args) : string =
  match oper with
  | Shlq | Sarq | Shrq -> string_of_shift oper args
  | Comment _ -> "\t" ^ string_of_opcode oper
  | _ ->
      let f =
        match oper with
        | J _ | Jmp | Callq -> string_of_jmp_operand
        | _ -> string_of_operand
      in
      "\t" ^ string_of_opcode oper ^ "\t" ^ map_concat ", " f args

let as_encode s =
  let explode s = String.to_seq s |> List.of_seq in
  let implode s = List.to_seq s |> String.of_seq in
  let rec ase ls =
    match ls with
    | [] -> []
    | '\\' :: cs -> '\\' :: '\\' :: ase cs
    | '\"' :: cs ->
        let charsc = Format.asprintf "%03o" (Char.code '\"') in
        ('\\' :: explode charsc) @ ase cs
    | c :: cs ->
        let ordc = Char.code c in
        let charsc = Format.asprintf "%03o" ordc in
        if 32 <= ordc && ordc < 128 then c :: ase cs
        else ('\\' :: explode charsc) @ ase cs
  in
  s |> explode |> ase |> implode

let string_of_data = function
  | Asciz s -> "\t.asciz\t" ^ "\"" ^ as_encode s ^ "\""
  | Quad i -> "\t.quad\t" ^ string_of_imm i

let string_of_asm = function
  | Text is -> "\t.text\n" ^ map_concat "\n" string_of_ins is
  | Data ds -> "\t.data\n" ^ map_concat "\n" string_of_data ds

let string_of_elem { lbl; global; asm } : string =
  let sec, body =
    match asm with
    | Text is -> ("\t.text\n", map_concat "\n" string_of_ins is)
    | Data ds -> ("\t.data\n", map_concat "\n" string_of_data ds)
  in
  let glb =
    if global then "\t.globl\t" ^ string_of_lbl (mangle (S.symbol lbl)) ^ "\n"
    else ""
  in

  sec ^ glb
  ^ (if global then string_of_lbl (mangle (S.symbol lbl)) else string_of_lbl lbl)
  ^ ":\n" ^ body

let string_of_prog (p : prog) : string =
  String.concat "\n" (List.map string_of_elem p)

(* Mapping ll comparison operations to X86 condition codes *)
let compile_cnd (c : Ll.cnd) : cnd =
  match c with
  | Ll.Eq -> Eq
  | Ll.Ne -> Neq
  | Ll.Slt -> Lt
  | Ll.Sle -> Le
  | Ll.Sgt -> Gt
  | Ll.Sge -> Ge
  | Ll.Ult -> Ult (* FIXME: this doesn't work for edge cases *)
  | Ll.Ule -> Ule
  | Ll.Ugt -> Ugt
  | Ll.Uge -> Uge

type layout = (Ll.uid * operand) list

let stack i = Ind3 (Lit (Int64.of_int ((i + 1) * -8)), Rbp)

(* A context contains the global type declarations (needed for getelementptr
   calculations) and a stack layout. *)
type ctxt = { tdecls : (Ll.tid * Ll.ty) list; layout : layout }

(* useful for looking up items in tdecls or layouts *)
let lookup m x =
  match List.assoc_opt x m with
  | Some x -> x
  | None -> failwith (Printf.sprintf "item %s not found" (S.name x))

(* compiling operands  ------------------------------------------------------ *)

(* LLVM IR instructions support several kinds of operands.

   LL local %uids live in stack slots, whereas global ids live at
   global addresses that must be computed from a label.  Constants are
   immediately available, and the operand Null is the 64-bit 0 value.

     NOTE: two important facts about global identifiers:

     (1) You should use (mangle gid) to obtain a string
     suitable for naming a global label on your platform (OS X expects
     "_main" while linux expects "main").

     (2) 64-bit assembly labels are not allowed as immediate operands.
     That is, the X86 code: movq _gid %rax which looks like it should
     put the address denoted by _gid into %rax is not allowed.
     Instead, you need to compute an %rip-relative address using the
     leaq instruction:   leaq _gid(%rip) %rax

   One strategy for compiling instruction operands is to use a
   designated register (or registers) for holding the values being
   manipulated by the LLVM IR instruction. You might find it useful to
   implement the following helper function, whose job is to generate
   the X86 instruction that moves an LLVM operand into a designated
   destination (usually a register).
*)

let idx_of_reg = function
  | Rax | Eax | Al -> 0
  | Rcx | Ecx | Cl -> 1
  | Rdx | Edx | Dl -> 2
  | Rbx | Ebx | Bl -> 3
  | Rsp | Esp -> 4
  | Rbp | Ebp -> 5
  | Rsi | Esi | Sil -> 6
  | Rdi | Edi | Dil -> 7
  | R08 | R08d | R08b -> 8
  | R09 | R09d | R09b -> 9
  | R10 | R10d | R10b -> 10
  | R11 | R11d | R11b -> 11
  | R12 | R12d | R12b -> 12
  | R13 | R13d | R13b -> 13
  | R14 | R14d | R14b -> 14
  | R15 | R15d | R15b -> 15
  | Rip -> failwith "%rip is not indexed"

let ty_cast : Ll.ty -> operand -> operand =
 fun ty op ->
  match (ty, op) with
  | Ll.I8, Reg (Rax | Eax | Al) -> Reg Al
  | Ll.I8, Reg (Rcx | Ecx | Cl) -> Reg Cl
  | Ll.I8, Reg (Rdx | Edx | Dl) -> Reg Dl
  | Ll.I8, Reg (Rbx | Ebx | Bl) -> Reg Bl
  | Ll.I8, Reg (Rsi | Esi | Sil) -> Reg Sil
  | Ll.I8, Reg (Rdi | Edi | Dil) -> Reg Dil
  | Ll.I8, Reg (R08 | R08d | R08b) -> Reg R08b
  | Ll.I8, Reg (R09 | R09d | R09b) -> Reg R09b
  | Ll.I8, Reg (R10 | R10d | R10b) -> Reg R10b
  | Ll.I8, Reg (R11 | R11d | R11b) -> Reg R11b
  | Ll.I8, Reg (R12 | R12d | R12b) -> Reg R12b
  | Ll.I8, Reg (R13 | R13d | R13b) -> Reg R13b
  | Ll.I8, Reg (R14 | R14d | R14b) -> Reg R14b
  | Ll.I8, Reg (R15 | R15d | R15b) -> Reg R15b
  | Ll.I32, Reg (Rax | Eax | Al) -> Reg Eax
  | Ll.I32, Reg (Rcx | Ecx | Cl) -> Reg Ecx
  | Ll.I32, Reg (Rdx | Edx | Dl) -> Reg Edx
  | Ll.I32, Reg (Rbx | Ebx | Bl) -> Reg Ebx
  | Ll.I32, Reg (Rsi | Esi | Sil) -> Reg Esi
  | Ll.I32, Reg (Rdi | Edi | Dil) -> Reg Edi
  | Ll.I32, Reg (R08 | R08d | R08b) -> Reg R08d
  | Ll.I32, Reg (R09 | R09d | R09b) -> Reg R09d
  | Ll.I32, Reg (R10 | R10d | R10b) -> Reg R10d
  | Ll.I32, Reg (R11 | R11d | R11b) -> Reg R11d
  | Ll.I32, Reg (R12 | R12d | R12b) -> Reg R12d
  | Ll.I32, Reg (R13 | R13d | R13b) -> Reg R13d
  | Ll.I32, Reg (R14 | R14d | R14b) -> Reg R14d
  | Ll.I32, Reg (R15 | R15d | R15b) -> Reg R15d
  | Ll.I64, Reg (Rax | Eax | Al) -> Reg Rax
  | Ll.I64, Reg (Rcx | Ecx | Cl) -> Reg Rcx
  | Ll.I64, Reg (Rdx | Edx | Dl) -> Reg Rdx
  | Ll.I64, Reg (Rbx | Ebx | Bl) -> Reg Rbx
  | Ll.I64, Reg (Rsi | Esi | Sil) -> Reg Rsi
  | Ll.I64, Reg (Rdi | Edi | Dil) -> Reg Rdi
  | Ll.I64, Reg (R08 | R08d | R08b) -> Reg R08
  | Ll.I64, Reg (R09 | R09d | R09b) -> Reg R09
  | Ll.I64, Reg (R10 | R10d | R10b) -> Reg R10
  | Ll.I64, Reg (R11 | R11d | R11b) -> Reg R11
  | Ll.I64, Reg (R12 | R12d | R12b) -> Reg R12
  | Ll.I64, Reg (R13 | R13d | R13b) -> Reg R13
  | Ll.I64, Reg (R14 | R14d | R14b) -> Reg R14
  | Ll.I64, Reg (R15 | R15d | R15b) -> Reg R15
  | _, op -> op

let compile_operand :
    ctxt -> operand S.table -> Ll.ty -> operand -> Ll.operand -> ins list =
 fun _ctxt asn ty dst src ->
  match src with
  | Null -> [ (Movq, [ Imm (Lit 0L); ty_cast ty dst ]) ]
  | IConst64 i -> [ (Movq, [ Imm (Lit i); ty_cast ty dst ]) ]
  | IConst32 i -> [ (Movq, [ Imm (Lit (Int64.of_int32 i)); ty_cast ty dst ]) ]
  | IConst8 i ->
      [ (Movq, [ Imm (Lit (Int64.of_int (Char.code i))); ty_cast ty dst ]) ]
  | BConst i -> [ (Movq, [ Imm (Lit (if i then 1L else 0L)); ty_cast ty dst ]) ]
  | Gid gid -> [ (Leaq, [ Ind3 (Lbl (mangle gid), Rip); ty_cast ty dst ]) ]
  | Id id -> (
      match (dst, S.ST.find_opt id asn) with
      | Ind3 dst, Some (Ind3 src) ->
          [ (Movq, [ Ind3 src; Reg Rcx ]); (Movq, [ Reg Rcx; Ind3 dst ]) ]
      | dst, Some i when dst = i -> [] (* NOTE: don't comppile noop movs *)
      | dst, Some i -> [ (Movq, [ i; dst ]) ]
      | _, None -> failwith (Printf.sprintf "%s" (S.name id)))

let arg_loc : int -> operand = function
  | 0 -> Reg Rdi
  | 1 -> Reg Rsi
  | 2 -> Reg Rdx
  | 3 -> Reg Rcx
  | 4 -> Reg R08
  | 5 -> Reg R09
  | n -> Ind3 (Lit (Int64.of_int ((3 * 8) + ((n - 6) * 8))), Rbp)

let compile_call :
    ctxt ->
    operand S.table ->
    Ll.operand ->
    (Ll.ty * Ll.operand) list ->
    ins list =
 fun ctxt asn oper args ->
  let replace =
    S.ST.add (S.symbol "llvm.memset.p0.i64") (S.symbol "memset") S.empty
    |> S.ST.add (S.symbol "llvm.memcpy.p0.p0.i64") (S.symbol "memcpy")
  in
  let args = List.map snd args in
  let crsaved = [ Rcx; Rdx; Rsi; Rdi; R08; R09; R10; R11 ] in
  let callins =
    match oper with
    | Gid id -> (
        match S.ST.find_opt id replace with
        | Some id -> (Callq, [ Imm (Lbl (mangle id)) ])
        | None -> (Callq, [ Imm (Lbl (mangle id)) ]))
    | Id id -> (Callq, [ S.ST.find id asn ])
    | _ -> failwith (Ll.string_of_operand oper)
  in
  let pusharg _i dst : ins list =
    let ins = compile_operand ctxt asn Ll.I64 (Reg Rax) dst in
    ins @ [ (Pushq, [ Reg Rax ]) ]
  in
  let poparg i _ =
    ( Popq,
      [
        (match i with
        | 0 -> Reg Rdi
        | 1 -> Reg Rsi
        | 2 -> Reg Rdx
        | 3 -> Reg Rcx
        | 4 -> Reg R08
        | 5 -> Reg R09
        | i -> Ind3 (Lit (Int64.of_int ((3 * 8) + ((i - 6) * 8))), Rbp));
      ] )
  in
  let freen =
    match List.length args with
    | len when len <= 6 -> 0L
    | len -> Int64.of_int ((len - 6) * 8)
  in
  let freeins = (Addq, [ Imm (Lit freen); Reg Rsp ]) in
  List.map (fun r -> (Pushq, [ Reg r ])) crsaved
  @ List.flatten (List.mapi pusharg args)
  @ List.rev (List.mapi poparg args)
  @ [ (Xorq, [ Reg Rax; Reg Rax ]) ]
  @ [ callins; freeins ]
  @ List.map (fun r -> (Popq, [ Reg r ])) (List.rev crsaved)

let rec size_ty : (Ll.uid * Ll.ty) list -> Ll.ty -> int =
 fun tdecls -> function
  | Void | Fun _ -> 0
  | I8 -> 1
  | I32 -> 4
  | I1 | I64 | Ptr _ -> 8 (* FIXME: should i1 be 1? *)
  | Namedt ty ->
      let ty = List.assoc ty tdecls in
      size_ty tdecls ty
  | Struct tys -> List.fold_left (fun sum ty -> sum + size_ty tdecls ty) 0 tys
  | Array (len, ty) -> len * size_ty tdecls ty

let compile_gep :
    ctxt -> operand S.table -> Ll.ty * Ll.operand -> Ll.operand list -> ins list
    =
 fun ctxt asn (ty, oper) ops ->
  let base = compile_operand ctxt asn Ll.I64 (Reg Rcx) oper in
  let rec gep : Ll.operand list -> Ll.ty -> ins list list -> ins list list =
   fun ops ty insns ->
    match (ty, ops) with
    | Namedt tid, _ -> gep ops (lookup ctxt.tdecls tid) insns
    | Struct _, IConst32 i :: tail ->
        let offset : Ll.ty -> int -> int * Ll.ty =
         fun ty idx ->
          match ty with
          | Struct tys ->
              let rec get tys idx offset =
                match tys with
                | ty :: _ when idx == 0 -> (offset, ty)
                | ty :: tys ->
                    get tys (idx - 1) (offset + size_ty ctxt.tdecls ty)
                | _ -> raise BackendFatal
              in
              get tys idx 0
          | _ -> raise BackendFatal
        in
        let parins =
          compile_operand ctxt asn Ll.I64 (Reg Rax)
            (IConst64 (Int64.of_int32 i))
        in
        let offset, ty = offset ty (Int32.to_int i) in
        let offsins = (Movq, [ Imm (Lit (Int64.of_int offset)); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | Array (_, ty), head :: tail ->
        let elmsize = size_ty ctxt.tdecls ty in
        let parins = compile_operand ctxt asn Ll.I64 (Reg Rax) head in
        let offsins = (Imulq, [ Imm (Lit (Int64.of_int elmsize)); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | _, head :: tail ->
        let parins = compile_operand ctxt asn Ll.I64 (Reg Rax) head in
        let offsins = (Imulq, [ Imm (Lit 8L); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | _, [] -> List.rev insns
  in
  base @ List.concat (gep ops (Array (0, ty)) [])

let compile_bop : Ll.bop -> Ll.ty -> opcode =
 fun bop ty ->
  match (bop, ty) with
  | Add, _ -> Addq
  | Sub, _ -> Subq
  | Mul, _ -> Imulq
  | SDiv, _ -> Idivq
  | SRem, _ -> Srem
  | UDiv, _ -> Divq
  | URem, _ -> Urem
  | Shl, _ -> Shlq
  | Lshr, Ll.I8 -> Shrb
  | Lshr, Ll.I32 -> Shrl
  | Lshr, _ -> Shrq
  | Ashr, _ -> Sarq
  | And, _ -> Andq
  | Or, _ -> Orq
  | Xor, _ -> Xorq
(*| Add, Ll.I32 -> Addl
    | Sub, Ll.I32 -> Subl
    | Mul, Ll.I32 -> Imull
    | SDiv, Ll.I32 -> Idivl
    | SRem, Ll.I32 -> Srem
    | Shl, Ll.I32 -> Shll
    | Lshr, Ll.I32 -> Shrl
    | Ashr, Ll.I32 -> Sarl
    | And, Ll.I32 -> Andl
    | Or, Ll.I32 -> Orl
    | Xor, Ll.I32 -> Xorl
    | Add, Ll.I8 -> Addb
    | Sub, Ll.I8 -> Subb
    | Mul, Ll.I8 -> Imulb
    | SDiv, Ll.I8 -> Idivb
    | SRem, Ll.I8 -> Srem
    | Shl, Ll.I8 -> Shlb
    | Lshr, Ll.I8 -> Shrb
    | Ashr, Ll.I8 -> Sarb
    | And, Ll.I8 -> Andb
    | Or, Ll.I8 -> Orb
    | Xor, Ll.I8 -> Xorb
  | _ -> failwith "TODO"*)

let compile_insn :
    ctxt -> operand S.table -> Ll.uid option * Ll.insn -> ins list =
 fun ctxt asn insn ->
  (Comment (Ll.string_of_named_insn insn), [])
  ::
  (match insn with
  | Some dst, Call (_, oper, args) -> (
      match S.ST.find_opt dst asn with
      | Some dst ->
          let callins = compile_call ctxt asn oper args in
          let storins = (Movq, [ Reg Rax; dst ]) in
          callins @ [ storins ]
      | None ->
          let callins = compile_call ctxt asn oper args in
          callins)
  | Some dst, _ when Option.is_none (S.ST.find_opt dst asn) -> []
  | Some dst, Binop (SDiv, Ll.I32, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivl, [ Reg Ecx ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (SDiv, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (SRem, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      (* FIXME: %edx is overwritten *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rdx; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (UDiv, Ll.I32, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Divl, [ Reg Ecx ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (UDiv, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Divq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (URem, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      (* FIXME: %edx is overwritten *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Divq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rdx; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (Lshr, ty, lop, rop) ->
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let opins = (compile_bop Lshr ty, [ Reg Cl; ty_cast ty (Reg Rax) ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]
  | Some dst, Binop (Shl, ty, lop, rop) ->
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let opins = (compile_bop Shl ty, [ Reg Cl; Reg Rax ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]
  (*| Some dst, Binop (bop, Ll.I8, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rcx) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let opins =
        ( compile_bop bop Ll.I32,
          [ ty_cast Ll.I32 (Reg Rcx); ty_cast Ll.I32 (Reg Rax) ] )
      in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]*)
  (*| Some dst, Binop (bop, Ll.I32, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let opins =
        ( compile_bop bop Ll.I32,
          [ ty_cast Ll.I32 (Reg Rcx); ty_cast Ll.I32 (Reg Rax) ] )
      in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]*)
  | Some dst, Binop (bop, ty, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) lop in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) rop in
      let opins = (compile_bop bop ty, [ Reg Rcx; Reg Rax ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]
  | Some dst, Alloca ty ->
      let dst = S.ST.find dst asn in
      let size = size_ty ctxt.tdecls ty in
      [
        (Subq, [ Imm (Lit (Int64.of_int size)); Reg Rsp ]);
        (Movq, [ Reg Rsp; dst ]);
      ]
  | Some dst, AllocaN (ty, (oty, o)) ->
      let dst = S.ST.find dst asn in
      let oins = compile_operand ctxt asn oty (Reg Rax) o in
      let size = size_ty ctxt.tdecls ty in
      let offsins = (Imulq, [ Imm (Lit (Int64.of_int size)); Reg Rax ]) in
      oins @ [ offsins ]
      @ [ (Subq, [ Reg Rax; Reg Rsp ]); (Movq, [ Reg Rsp; dst ]) ]
  | Some dst, Load (Ll.I8, src) -> (
      (* if the variable is unassigned, it's not used so can be optimized away *)
      match S.ST.find_opt dst asn with
      | Some dst ->
          let operins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
          let loadins = (Movb, [ Ind2 Rax; Reg Al ]) in
          let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
          let storins = (Movb, [ Reg Al; byteofquad dst ]) in
          operins @ [ loadins; zeroins; storins ]
      | None -> [])
  | Some dst, Load (Ll.I32, src) -> (
      (* if the variable is unassigned, it's not used so can be optimized away *)
      match S.ST.find_opt dst asn with
      | Some dst ->
          let operins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
          let loadins = (Movl, [ Ind2 Rax; Reg Eax ]) in
          let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
          let storins = (Movl, [ Reg Eax; longofquad dst ]) in
          operins @ [ loadins; zeroins; storins ]
      | None -> [])
  | Some dst, Load (_, src) -> (
      (* if the variable is unassigned, it's not used so can be optimized away *)
      match S.ST.find_opt dst asn with
      | Some dst ->
          let operins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
          let loadins = (Movq, [ Ind2 Rax; Reg Rax ]) in
          let storins = (Movq, [ Reg Rax; dst ]) in
          operins @ [ loadins; storins ]
      | None -> [])
  | None, Store (Ll.I8, src, dst) ->
      let sins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let dins = compile_operand ctxt asn Ll.I64 (Reg Rcx) dst in
      let storins =
        match dst with
        | Id _ -> [ (Movb, [ Reg Al; Ind2 Rcx ]) ]
        | _ -> raise BackendFatal
      in
      sins @ dins @ storins
  | None, Store (Ll.I32, src, dst) ->
      let sins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let dins = compile_operand ctxt asn Ll.I64 (Reg Rcx) dst in
      let storins =
        match dst with
        | Id _ -> [ (Movl, [ Reg Eax; Ind2 Rcx ]) ]
        | _ -> raise BackendFatal
      in
      sins @ dins @ storins
  | None, Store (_, src, dst) ->
      let sins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let dins = compile_operand ctxt asn Ll.I64 (Reg Rcx) dst in
      let storins =
        match dst with
        | Id _ -> (Movq, [ Reg Rax; Ind2 Rcx ])
        | _ -> failwith (Ll.string_of_operand dst)
      in
      sins @ dins @ [ storins ]
  | Some dst, Icmp (cnd, Ll.I32, l, r) ->
      let lop = Reg Eax in
      let rop = Reg Ecx in
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 (Reg Rax) l in
      let rins = compile_operand ctxt asn Ll.I64 (Reg Rcx) r in
      let setzins = (Movq, [ Imm (Lit 0L); dst ]) in
      let cmpinsn = (Cmpl, [ rop; lop ]) in
      let setinsn = (Set (compile_cnd cnd), [ byteofquad dst ]) in
      lins @ rins @ [ cmpinsn; setzins; setinsn ]
  | Some dst, Icmp (cnd, _, l, r) ->
      let lop = Reg Rax in
      let rop = Reg Rcx in
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn Ll.I64 lop l in
      let rins = compile_operand ctxt asn Ll.I64 rop r in
      let setzins = (Movq, [ Imm (Lit 0L); dst ]) in
      let cmpinsn = (Cmpq, [ rop; lop ]) in
      let setinsn = (Set (compile_cnd cnd), [ byteofquad dst ]) in
      lins @ rins @ [ cmpinsn; setzins; setinsn ]
  | None, Call (_, oper, args) -> compile_call ctxt asn oper args
  | Some dst, Bitcast (_, src, _) ->
      (*Printf.printf "%s\n" (S.name dst);*)
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Gep (ty, src, operlist) ->
      let dst = S.ST.find dst asn in
      let gepinsns = compile_gep ctxt asn (ty, src) operlist in
      let stored = (Movq, [ Reg Rcx; dst ]) in
      gepinsns @ [ stored ]
  | Some dst, Zext (Ll.I8, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movb, [ Reg Al; byteofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Zext (Ll.I32, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movl, [ Reg Eax; longofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Zext (_, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Sext (Ll.I8, src, _) ->
      (* FIXME: test all of these sexts *)
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movb, [ Reg Al; byteofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Sext (Ll.I32, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movl, [ Reg Eax; longofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Sext (_, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Ptrtoint (_, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Trunc (_, src, Ll.I1) | Some dst, Trunc (_, src, Ll.I8) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movb, [ Reg Al; byteofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Trunc (_, src, Ll.I32) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn Ll.I64 (Reg Rax) src in
      let zeroins = (Movq, [ Imm (Lit 0L); dst ]) in
      let storins = (Movl, [ Reg Eax; longofquad dst ]) in
      opins @ [ zeroins; storins ]
  | Some dst, Select (o, (_, o1), (_, o2)) ->
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let oins = compile_operand ctxt asn Ll.I64 (Reg Rcx) o in
      let o1ins = compile_operand ctxt asn Ll.I64 (Reg Rax) o1 in
      let o2ins = compile_operand ctxt asn Ll.I64 (Reg Rdx) o2 in
      let cmpins = (Cmpq, [ Imm (Lit 0L); Reg Rcx ]) in
      let storins = (Cmoveq, [ Reg Rdx; Reg Rax ]) in
      let finins = (Movq, [ Reg Rax; dst ]) in
      let popins = (Popq, [ Reg Rdx ]) in
      (*oins @ o1ins @ o2ins @ [ cmpins ] @ [ storins ]*)
      if dst = Reg Rdx then oins @ o1ins @ o2ins @ [ cmpins; storins; finins ]
      else
        [ pushdx ] @ oins @ o1ins @ o2ins @ [ cmpins; storins; finins; popins ]
  | Some _dst, PhiNode _ -> []
  | insn -> failwith (Ll.string_of_named_insn insn))

let compile_terminator :
    ctxt -> S.symbol -> operand S.table -> ins list -> Ll.terminator -> ins list
    =
 fun ctxt fname asn movs term ->
  (Comment (Ll.string_of_terminator term), [])
  ::
  (match term with
  | Ret (_, Some oper) ->
      let operins = compile_operand ctxt asn Ll.I64 (Reg Rax) oper in
      operins
      @ [
          (Movq, [ Reg Rbp; Reg Rsp ]);
          (Popq, [ Reg R15 ]);
          (Popq, [ Reg R14 ]);
          (Popq, [ Reg R13 ]);
          (Popq, [ Reg R12 ]);
          (Popq, [ Reg Rbx ]);
          (Popq, [ Reg Rbp ]);
          (Retq, []);
        ]
  | Ret (_, None) ->
      [
        (*(Movq, [ Imm (Lit 0L); Reg Rax ]); (* FIXME *)*)
        (Movq, [ Reg Rbp; Reg Rsp ]);
        (Popq, [ Reg R15 ]);
        (Popq, [ Reg R14 ]);
        (Popq, [ Reg R13 ]);
        (Popq, [ Reg R12 ]);
        (Popq, [ Reg Rbx ]);
        (Popq, [ Reg Rbp ]);
        (Retq, []);
      ]
  | Br lbl -> movs @ [ (Jmp, [ Imm (Lbl (S.name fname ^ S.name lbl)) ]) ]
  | Cbr (oper, thn, els) ->
      let operins = compile_operand ctxt asn Ll.I64 (Reg Rax) oper in
      let zeroins = (Movq, [ Imm (Lit 0L); Reg Rcx ]) in
      let cmpins : ins = (Cmpq, [ Reg Rax; Reg Rcx ]) in
      let jeq = (J Eq, [ Imm (Lbl (S.name fname ^ S.name els)) ]) in
      let jmp = (Jmp, [ Imm (Lbl (S.name fname ^ S.name thn)) ]) in
      operins @ [ zeroins; cmpins ] @ movs @ [ jeq; jmp ]
  | Unreachable ->
      (* undefined, so do literally nothing *)
      [])

module C = Coloring.Mark (Lva.G)

type allocator = Simple of int | Briggs of int | Greedy of int | Linearscan

let allocator_of_string n = function
  | s when String.starts_with ~prefix:s "simple" -> Simple n
  | s when String.starts_with ~prefix:s "briggs" -> Briggs n
  | s when String.starts_with ~prefix:s "greedy" -> Greedy n
  | s when String.starts_with ~prefix:s "linearscan" -> Linearscan
  | "" -> Greedy 0 (* NOTE: default allocator *)
  | s -> failwith ("invalid allocator: " ^ s)

let string_of_allocator = function
  | Simple k -> "simple " ^ string_of_int k
  | Briggs k -> "briggs " ^ string_of_int k
  | Greedy k -> "greedy " ^ string_of_int k
  | Linearscan -> "linear"

module VS = Set.Make (Lva.G.V)
module VT = Map.Make (Lva.G.V)
module Ints = Set.Make (Int)

type mark =
  | Color of S.symbol * Lva.G.V.t
  | PotentialSpill of S.symbol * Lva.G.V.t

type assign = Color of S.symbol * int | ActualSpill of S.symbol

module Regs = Set.Make (struct
  type t = reg

  let compare a b = compare a b
end)

let coalesce_briggs k (prefs : S.SS.t S.ST.t)
    ((l, g) : Lva.G.V.t S.ST.t * Lva.G.t) : Lva.G.V.t S.table * Lva.G.t =
  let _str v =
    "\"{ " ^ Ll.mapcat ", " S.name (Lva.G.V.label v |> S.SS.elements) ^ " }\""
  in
  let try_coalesce ops (ol, g) =
    (*Printf.printf "trying to coalesce: ";
      S.SS.iter (fun e -> Printf.printf "%s " (S.name e)) ops;
      Printf.printf "\n";

      Printf.printf "%s\n" (dot g);*)

    (* step 1) check if degree of coalesced node <= k *)
    let neighs =
      S.SS.fold
        (fun e acc ->
          let v = S.ST.find e ol in
          (*Printf.printf "%s\n" (S.name e);*)
          Lva.G.succ g v |> List.map Lva.G.V.label
          |> List.fold_left S.SS.union acc)
        ops S.SS.empty
    in
    let neighs = S.SS.diff neighs ops in

    (*Printf.printf "resulting neighs: ";
      S.SS.iter (fun e -> Printf.printf "%s " (S.name e)) neighs;
      Printf.printf "\n";*)

    (* FIXME: check corner case = k *)
    if S.SS.cardinal neighs < k then (
      (*Printf.printf "neighbors < k, proceeding..\n";*)
      let g' = Lva.G.create () in

      let tocoalesce, l' =
        Lva.G.fold_vertex
          (fun v (tocoalese, l') ->
            let s = Lva.G.V.label v in
            if S.SS.is_empty (S.SS.inter s ops) then (
              (* nothing in common, add it with no changes *)
              let v' = Lva.G.V.create s in
              Lva.G.add_vertex g' v';
              let l' =
                S.SS.fold
                  (fun e t ->
                    (*Printf.printf "Setting %s to new ..\n" (S.name e);*)
                    S.ST.add e v' t)
                  s l'
              in
              (tocoalese, l'))
            else
              (* something in common, add them to coalesced node *)
              (S.SS.union tocoalese s, l'))
          g (S.SS.empty, S.ST.empty)
      in

      let v' = Lva.G.V.create tocoalesce in
      Lva.G.add_vertex g' v';

      let l' =
        S.SS.fold
          (fun e t ->
            (*Printf.printf "Setting %s to lst ..\n" (S.name e);*)
            S.ST.add e v' t)
          tocoalesce l'
      in

      (*S.ST.iter
          (fun k v ->
            Printf.printf "kk: %s\n" (S.name k);
            let _ = G.succ g' v in
            ())
          l';

        S.ST.iter (fun k _ -> Printf.printf "k: %s\n" (S.name k)) l';*)
      Lva.G.iter_edges
        (fun v1 v2 ->
          let s1 = Lva.G.V.label v1 in
          let s2 = Lva.G.V.label v2 in
          S.SS.iter
            (fun e1 ->
              S.SS.iter
                (fun e2 ->
                  let v1 = S.ST.find e1 l' in
                  let v2 = S.ST.find e2 l' in
                  if v1 <> v2 then Lva.G.add_edge g' v1 v2)
                s2)
            s1)
        g;

      (*Printf.printf "%s\n" (dot g');*)
      (l', g'))
    else ((*Printf.printf "returning same %s\n" (dot g);*)
          ol, g)
  in
  (*let rec partition inset outsets =
      match S.SS.choose_opt inset with
      | Some e ->
          let rec place outset =
            match outset with
            | ss :: tail
              when S.SS.for_all
                     (fun e2 -> Lva.G.mem_edge g (S.ST.find e l) (S.ST.find e2 l))
                     ss ->
                ss :: place tail
            | ss :: tail -> S.SS.add e ss :: tail
            | [] -> [ S.SS.add e S.SS.empty ]
          in
          let outsets = place outsets in
          let inset = S.SS.remove e inset in
          partition inset outsets
      | None -> outsets
    in*)
  S.ST.fold
    (fun k prefs acc ->
      let interf e = not (Lva.G.mem_edge g (S.ST.find k l) (S.ST.find e l)) in
      let ops = S.SS.filter interf prefs |> S.SS.add k in
      try_coalesce ops acc)
    prefs (l, g)

let coalesce (alc : allocator) (prefs : S.SS.t S.ST.t)
    ((l, g) : Lva.G.V.t S.ST.t * Lva.G.t) : Lva.G.V.t S.table * Lva.G.t =
  match alc with Briggs k -> coalesce_briggs k prefs (l, g) | _ -> (l, g)

let alloc a param insns (in_, out) : operand S.table =
  (*let var i =
      let j =
        match i with
        (*| 0 -> Reg Rax
          | 1 -> Reg Rcx (* NOTE: %rax and %rcx are scratch registers *)*)
        | 0 -> Reg Rdx
        | 1 -> Reg Rbx
        | 2 -> Reg Rsi
        | 3 -> Reg Rdi
        | 4 -> Reg R08
        | 5 -> Reg R09
        | 6 -> Reg R10
        | 7 -> Reg R11
        | 8 -> Reg R12
        | 9 -> Reg R13
        | 10 -> Reg R14
        | 11 -> Reg R15
        | i -> Ind3 (Lit (Int64.of_int ((i - 11) * -8)), Rbp)
      in
      flush stdout;
      j
    in*)
  let reg_of_int = function
    | 0 -> Rdx
    | 1 -> Rbx
    | 2 -> Rsi
    | 3 -> Rdi
    | 4 -> R08
    | 5 -> R09
    | 6 -> R10
    | 7 -> R11
    | 8 -> R12
    | 9 -> R13
    | 10 -> R14
    | 11 -> R15
    | i -> failwith ("out of bounds: " ^ string_of_int i)
  in
  let l =
    match a with
    | Greedy k ->
        let var i =
          match i with
          | i when i >= k -> Ind3 (Lit (Int64.of_int ((i - (k - 1)) * -8)), Rbp)
          | i -> Reg (reg_of_int i)
        in
        let l, _g = Lva.interf param insns in_ out in
        let c = ref 0 in
        S.ST.map
          (fun _v ->
            let v = var !c in
            c := !c + 1;
            v)
          l
    | Simple c ->
        let l, g = Lva.interf param insns in_ out in
        let register i = Reg (reg_of_int i) in
        let count = ref 0 in
        let rec simp (spills : S.SS.t) =
          if !count >= 10 then failwith "error";
          count := !count + 1;

          (* Printf.printf "Spills: ";
             S.SS.iter (fun k -> Printf.printf "%s, " (S.name k)) spills;
             Printf.printf "\n";*)
          let spilled k _v = not (S.SS.mem k spills) in
          let simplify () =
            (* mark nodes as colorables *)
            let rec remove_vertex (removed_vertices : VS.t)
                (l : Lva.G.V.t S.table) : mark list =
              let insig _k v =
                let mem k = not (VS.mem k removed_vertices) in
                let degree = Lva.G.succ g v |> List.filter mem |> List.length in
                if degree < c then Some (v, degree) else None
              in
              match
                S.ST.filter spilled l |> S.ST.filter_map insig
                |> S.ST.choose_opt
              with
              | Some (k, (v, _deg)) ->
                  (* Printf.printf "removing %s (%d < %d)\n" (S.name k) deg c;*)
                  Color (k, v)
                  :: remove_vertex (VS.add v removed_vertices) (S.ST.remove k l)
              | None -> spill removed_vertices l
            and spill (removed_vertices : VS.t) (l : Lva.G.V.t S.table) =
              match S.ST.filter spilled l |> S.ST.choose_opt with
              | Some (k, v) ->
                  PotentialSpill (k, v)
                  :: remove_vertex (VS.add v removed_vertices) (S.ST.remove k l)
              | None -> []
            in
            remove_vertex VS.empty l
          in
          let markers = simplify () in
          (* Printf.printf "Marked as colorable: ";
             List.iter
               (fun (m : mark) ->
                 match m with
                 | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
                 | PotentialSpill (k, _v) -> Printf.printf "spill %s, " (S.name k))
               markers;
             Printf.printf "\n";*)
          let rec add = function
            | 0 -> Ints.empty
            | i -> Ints.add (i - 1) (add (i - 1))
          in
          let indices = add c in
          let rec select (assignments : int VT.t) (markers : mark list) :
              assign list =
            match markers with
            | Color (k, v) :: tail ->
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose avail_assignments in
                (* Printf.printf "coloring %s %d\n" (S.name k) assignment;*)
                Color (k, assignment)
                :: select (VT.add v assignment assignments) tail
            | PotentialSpill (k, v) :: tail -> (
                (* potential spill *)
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose_opt avail_assignments in
                match assignment with
                | Some assignment ->
                    (* Printf.printf "coloring %s %d\n" (S.name k) assignment;*)
                    Color (k, assignment)
                    :: select (VT.add v assignment assignments) tail
                | None ->
                    (* actual spill *)
                    let actual_spills = actual_spill assignments markers in
                    let assignments = List.map (fun a -> a) actual_spills in
                    assignments)
            | [] -> []
          and actual_spill (assignments : int VT.t) markers : assign list =
            match markers with
            | PotentialSpill (k, v) :: tail -> (
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose_opt avail_assignments in
                match assignment with
                | Some assignment ->
                    actual_spill (VT.add v assignment assignments) tail
                | None ->
                    (* push actual spill *)
                    ActualSpill k :: actual_spill assignments tail)
            | _ :: tail -> actual_spill assignments tail
            | [] -> []
          in
          let assignments : assign list = List.rev markers |> select VT.empty in
          (* Printf.printf "Assignments: ";
             List.iter
               (function
                 | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
                 | ActualSpill k -> Printf.printf "actual spill %s, " (S.name k))
               assignments;
             Printf.printf "\n";*)
          let spills2 =
            List.filter_map
              (function Color _ -> None | ActualSpill k -> Some k)
              assignments
          in
          if List.length spills2 = 0 then
            snd
              (S.SS.fold
                 (fun k (i, a) -> (i + 1, S.ST.add k (stack i) a))
                 spills
                 ( 0,
                   List.fold_left
                     (fun t v ->
                       match v with
                       | Color (k, c) ->
                           (* Printf.printf "assigning %s %d\n" (S.name k) c;*)
                           S.ST.add k (register c) t
                       | ActualSpill _k -> failwith "unreachable")
                     S.ST.empty assignments ))
          else simp (S.SS.union (S.SS.of_list spills2) spills)
        in
        simp S.SS.empty
    | Briggs c ->
        let prefs = Lva.prefer insns in
        let l, g = Lva.interf param insns in_ out in
        let l, g = coalesce_briggs c prefs (l, g) in
        let register = function
          (*| 0 -> Reg Rax
            | 1 -> Reg Rcx (* NOTE: %rax and %rcx are scratch registers *)*)
          | 0 -> Reg Rdx
          | 1 -> Reg Rbx
          | 2 -> Reg Rsi
          | 3 -> Reg Rdi
          | 4 -> Reg R08
          | 5 -> Reg R09
          | 6 -> Reg R10
          | 7 -> Reg R11
          | 8 -> Reg R12
          | 9 -> Reg R13
          | 10 -> Reg R14
          | 11 -> Reg R15
          | _ -> failwith "unreachable"
        in
        let count = ref 0 in
        let rec simp (spills : S.SS.t) =
          if !count >= 10 then failwith "error";
          count := !count + 1;

          (* Printf.printf "Spills: ";
             S.SS.iter (fun k -> Printf.printf "%s, " (S.name k)) spills;
             Printf.printf "\n";*)
          let spilled k _v = not (S.SS.mem k spills) in
          let simplify () =
            (* mark nodes as colorables *)
            let rec remove_vertex (removed_vertices : VS.t)
                (l : Lva.G.V.t S.table) : mark list =
              let insig _k v =
                let mem k = not (VS.mem k removed_vertices) in
                let degree = Lva.G.succ g v |> List.filter mem |> List.length in
                if degree < c then Some (v, degree) else None
              in
              match
                S.ST.filter spilled l |> S.ST.filter_map insig
                |> S.ST.choose_opt
              with
              | Some (k, (v, _deg)) ->
                  (* Printf.printf "removing %s (%d < %d)\n" (S.name k) deg c;*)
                  Color (k, v)
                  :: remove_vertex (VS.add v removed_vertices) (S.ST.remove k l)
              | None -> spill removed_vertices l
            and spill (removed_vertices : VS.t) (l : Lva.G.V.t S.table) =
              match S.ST.filter spilled l |> S.ST.choose_opt with
              | Some (k, v) ->
                  PotentialSpill (k, v)
                  :: remove_vertex (VS.add v removed_vertices) (S.ST.remove k l)
              | None -> []
            in
            remove_vertex VS.empty l
          in
          let markers = simplify () in
          (* Printf.printf "Marked as colorable: ";
             List.iter
               (fun (m : mark) ->
                 match m with
                 | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
                 | PotentialSpill (k, _v) -> Printf.printf "spill %s, " (S.name k))
               markers;
             Printf.printf "\n";*)
          let rec add = function
            | 0 -> Ints.empty
            | i -> Ints.add (i - 1) (add (i - 1))
          in
          let indices = add c in
          let rec select (assignments : int VT.t) (markers : mark list) :
              assign list =
            match markers with
            | Color (k, v) :: tail ->
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose avail_assignments in
                (* Printf.printf "coloring %s %d\n" (S.name k) assignment;*)
                Color (k, assignment)
                :: select (VT.add v assignment assignments) tail
            | PotentialSpill (k, v) :: tail -> (
                (* potential spill *)
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose_opt avail_assignments in
                match assignment with
                | Some assignment ->
                    (* Printf.printf "coloring %s %d\n" (S.name k) assignment;*)
                    Color (k, assignment)
                    :: select (VT.add v assignment assignments) tail
                | None ->
                    (* actual spill *)
                    let actual_spills = actual_spill assignments markers in
                    let assignments = List.map (fun a -> a) actual_spills in
                    assignments)
            | [] -> []
          and actual_spill (assignments : int VT.t) markers : assign list =
            match markers with
            | PotentialSpill (k, v) :: tail -> (
                let neighbor_assignments =
                  Lva.G.succ g v
                  |> List.filter_map (fun v -> VT.find_opt v assignments)
                  |> List.fold_left (fun s i -> Ints.add i s) Ints.empty
                in
                let avail_assignments =
                  Ints.diff indices neighbor_assignments
                in
                let assignment = Ints.choose_opt avail_assignments in
                match assignment with
                | Some assignment ->
                    actual_spill (VT.add v assignment assignments) tail
                | None ->
                    (* push actual spill *)
                    ActualSpill k :: actual_spill assignments tail)
            | _ :: tail -> actual_spill assignments tail
            | [] -> []
          in
          let assignments : assign list = List.rev markers |> select VT.empty in
          (* Printf.printf "Assignments: ";
             List.iter
               (function
                 | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
                 | ActualSpill k -> Printf.printf "actual spill %s, " (S.name k))
               assignments;
             Printf.printf "\n";*)
          let spills2 =
            List.filter_map
              (function Color _ -> None | ActualSpill k -> Some k)
              assignments
          in
          if List.length spills2 = 0 then
            snd
              (S.SS.fold
                 (fun k (i, a) -> (i + 1, S.ST.add k (stack i) a))
                 spills
                 ( 0,
                   List.fold_left
                     (fun t v ->
                       match v with
                       | Color (k, c) ->
                           (* Printf.printf "assigning %s %d\n" (S.name k) c;*)
                           S.ST.add k (register c) t
                       | ActualSpill _k -> failwith "unreachable")
                     S.ST.empty assignments ))
          else simp (S.SS.union (S.SS.of_list spills2) spills)
        in
        simp S.SS.empty
    | Linearscan ->
        let insns =
          List.filter (function Cfg.Label _ -> false | _ -> true) insns
        in
        let intervals = Linear.intervals param insns (in_, out) in
        let avail =
          Regs.of_list
            [ Rdx; Rbx; Rsi; Rdi; R08; R09; R10; R11; R12; R13; R14; R15 ]
        in
        let scan (idx, avail, assigns, spills) _ins =
          match
            List.find_opt
              (fun (k, _) -> fst (S.ST.find k intervals) = idx)
              (S.ST.bindings intervals)
          with
          | Some (k, (livestart, liveend)) ->
              if Regs.is_empty avail then
                (* spill the longest interval currently assigned *)
                let longest =
                  S.ST.fold
                    (fun k r (k2, r2, len2) ->
                      match S.ST.find_opt k intervals with
                      | Some (nlivestart, nliveend) ->
                          let len = nliveend - nlivestart in
                          if len > len2 then (k, Some r, len) else (k2, r2, len2)
                      | None -> (k2, r2, len2))
                    assigns
                    (k, None, liveend - livestart)
                in
                match longest with
                | k2, Some r, _ ->
                    (*Printf.printf "spilling %s to assign %s = %s\n" (S.name k2)
                      (S.name k) (string_of_reg r);*)
                    ( idx + 1,
                      avail,
                      S.ST.add k r (S.ST.remove k2 assigns),
                      S.SS.add k2 spills )
                | _, None, _ ->
                    (*Printf.printf "spilling %s\n" (S.name k);*)
                    (idx + 1, avail, assigns, S.SS.add k spills)
              else
                (* otherwise assign to available register *)
                let reg = Regs.choose avail in
                (*Printf.printf "assigning %s = %s\n" (S.name k)
                  (string_of_reg reg);*)
                (idx + 1, Regs.remove reg avail, S.ST.add k reg assigns, spills)
          | None -> (idx + 1, avail, assigns, spills)
        in
        let avail, assigns, spills =
          List.fold_left
            (fun (avail, assigns, spills) k ->
              match Regs.choose_opt avail with
              | Some r ->
                  (*Printf.printf "assigning %s = %s, regs is now" (S.name k)
                      (string_of_reg r);
                    Regs.iter
                      (fun r -> Printf.printf " %s" (string_of_reg r))
                      (Regs.remove r avail);
                    Printf.printf "\n";*)
                  (Regs.remove r avail, S.ST.add k r assigns, spills)
              | None ->
                  Printf.printf "spilling %s\n" (S.name k);
                  (avail, assigns, S.SS.add k spills))
            (avail, Symbol.empty, S.SS.empty)
            param
        in
        let _, _, assigns, spills =
          List.fold_left scan (0, avail, assigns, spills) insns
        in
        let assigns = S.ST.map (fun r -> Reg r) assigns in
        let _, assigns =
          S.SS.fold
            (fun k (i, acc) -> (i + 1, S.ST.add k (stack i) acc))
            spills (0, assigns)
        in
        assigns
  in
  l

let insns (_insns : Cfg.insn list) (_l : Lva.G.V.t S.table) (_g : Lva.G.t) :
    int S.table =
  let _insn (_insns : Cfg.insn) (_l : Lva.G.V.t S.table) (_g : Lva.G.t) = 4 in
  S.empty

let compile_fdecl :
    allocator -> (Ll.uid * Ll.ty) list -> Ll.uid -> Ll.fdecl -> elem list =
 fun (alc : allocator) tdecls name { param; cfg; _ } ->
  let fname = name in
  (* move out of pre-assigned parameter registers (rsi, rdi, .. r9) *)
  let (entryl, head), tail = cfg in
  let _, blocks = List.split tail in
  let named_insns =
    head.insns @ List.concat (List.map (fun (b : Ll.block) -> b.insns) blocks)
  in
  let names = List.filter_map (fun x -> x) (List.map fst named_insns) in
  let layout =
    List.mapi
      (fun idx uid -> (uid, Ind3 (Lit (Int64.of_int (-(8 * (idx + 1)))), Rbp)))
      (param @ names)
  in
  let ctxt = { tdecls; layout } in
  let ids, g = Cfg.graph cfg in
  let insns : Cfg.insn list = Cfg.flatten cfg in
  let df = Lva.dataflow insns ids g in
  let asn = alloc alc param insns df in
  let pusharg i _ =
    ( Pushq,
      [
        (match i with
        | 0 -> Reg Rdi
        | 1 -> Reg Rsi
        | 2 -> Reg Rdx
        | 3 -> Reg Rcx
        | 4 -> Reg R08
        | 5 -> Reg R09
        | i -> Ind3 (Lit (Int64.of_int ((3 * 8) + ((i - 6) * 8))), Rbp));
      ] )
  in
  let poparg _i dst =
    match S.ST.find_opt dst asn with
    | Some dst -> (Popq, [ dst ])
    | None -> failwith (Printf.sprintf "cannot pop %s" (S.name dst))
  in
  let min =
    S.ST.fold
      (fun k1 v1 min ->
        match (v1, min) with
        | Ind3 (Lit v1, _), Some (_, v2) when v1 < v2 -> Some (k1, v1)
        | Ind3 (Lit v1, _), None -> Some (k1, v1)
        | _ -> min)
      asn None
    |> Option.map snd |> Option.map Int64.neg
  in
  let min = Option.value min ~default:0L in
  let pro =
    [
      (Pushq, [ Reg Rbp ]);
      (Pushq, [ Reg Rbx ]);
      (Pushq, [ Reg R12 ]);
      (Pushq, [ Reg R13 ]);
      (Pushq, [ Reg R14 ]);
      (Pushq, [ Reg R15 ]);
      (Movq, [ Reg Rsp; Reg Rbp ]);
      (Subq, [ Imm (Lit min); Reg Rsp ]);
    ]
  in
  let pro = pro @ List.mapi pusharg param @ List.mapi poparg (List.rev param) in
  let phis =
    List.filter_map
      (function
        | Cfg.Insn (Some dst, Ll.PhiNode (_, ops)) -> Some (dst, ops)
        | _ -> None)
      insns
  in
  let movs : ins list S.table =
    List.fold_left
      (fun t ((dst, ops) : S.symbol * _) ->
        List.fold_left
          (fun t ((src, lbl) : Ll.operand * _) ->
            let lbl =
              match entryl with Some l when l = lbl -> name | _ -> lbl
            in
            S.ST.update lbl
              (function
                | Some movs ->
                    Some
                      (movs
                      (* FIXME: phi movs need to be placed between jumps *)
                      @ [ (Comment ("phi mov for %" ^ S.name dst), []) ]
                      @ compile_operand ctxt asn Ll.I64 (S.ST.find dst asn) src
                      )
                | None ->
                    Some
                      (compile_operand ctxt asn Ll.I64 (S.ST.find dst asn) src))
              t)
          t ops)
      S.empty phis
  in
  (*S.ST.iter
    (fun k v ->
      Printf.printf "%s: %s\n" (S.name k) (Ll.mapcat "," string_of_ins v))
    movs;*)
  let movs =
    match S.ST.find_opt (S.symbol "entry") movs with
    | Some m -> S.ST.add name m movs
    | _ -> movs
  in
  let rec f name global (insns : (Ll.uid option * Ll.insn) list) = function
    | Cfg.Insn i :: tail -> f name global (insns @ [ i ]) tail
    | Cfg.Term t :: Cfg.Label nname :: tail ->
        [ (name, global, insns, t) ] @ f nname false [] tail
    | [ Cfg.Term t ] -> [ (name, global, insns, t) ]
    | _ -> failwith "invalid cfg"
  in
  f name true [] insns
  |> List.map (fun (name, global, insns, term) ->
         let pro : ins list = if global then pro else [] in
         let head : ins list =
           List.map (compile_insn ctxt asn) insns |> List.flatten
         in
         let head : ins list = pro @ head in
         let movs = Option.value (S.ST.find_opt name movs) ~default:[] in
         let tail = compile_terminator ctxt fname asn movs term in
         {
           lbl = (if global then S.name fname else S.name fname ^ S.name name);
           global;
           asm = Text (head @ tail);
         })

let rec compile_ginit = function
  | Ll.GNull -> [ Quad (Lit 0L) ]
  | GGid gid -> [ Quad (Lbl (mangle gid)) ]
  | GInt c -> [ Quad (Lit c) ]
  | GString s -> [ Asciz s ]
  | GArray gs -> List.concat (List.map compile_gdecl gs)
  | GStruct gs -> List.concat (List.map compile_gdecl gs)

and compile_gdecl (_, g) = compile_ginit g

module Asm = struct
  let ( ~$ ) i = Imm (Lit i) (* int64 constants *)
  let ( ~$$ ) l = Imm (Lbl l) (* label constants *)
  let ( ~% ) r = Reg r (* registers *)

  (* helper functions for building blocks with data or code *)
  let data l ds = { lbl = l; global = true; asm = Data ds }
  let text l is = { lbl = l; global = false; asm = Text is }
  let gtext l is = { lbl = l; global = true; asm = Text is }
end

let compile_prog alc ({ tdecls; gdecls; fdecls; _ } : Ll.prog) : prog =
  let g (lbl, gdecl) = Asm.data (S.name lbl) (compile_gdecl gdecl) in
  let f (name, fdecl) = compile_fdecl alc tdecls name fdecl in
  List.map g gdecls @ List.concat (List.map f fdecls)
