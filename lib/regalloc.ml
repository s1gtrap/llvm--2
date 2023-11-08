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

(* Condition Codes *)
type cnd = Eq | Neq | Gt | Ge | Lt | Le

type opcode =
  | Movq
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
  | Shrq
  | Srem
  | Jmp
  | J of cnd
  | Cmpq
  | Set of cnd
  | Callq
  | Retq
  | Cqto
  | Idivq
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

let string_of_opcode (opc : opcode) : string =
  match opc with
  | Movq -> "movq"
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
  | Shrq -> "shrq"
  | Srem -> "srem"
  | Jmp -> "jmp"
  | J c -> "j" ^ string_of_cnd c
  | Cmpq -> "cmpq"
  | Set c -> "set" ^ string_of_cnd c
  | Callq -> "callq"
  | Retq -> "retq"
  | Cqto -> "cqto"
  | Idivq -> "idivq"
  | Comment s -> "# " ^ String.escaped s

let map_concat s f l = String.concat s (List.map f l)

let string_of_shift oper args =
  match args with
  | [ Imm _; _ ] as args ->
      "\t" ^ string_of_opcode oper ^ "\t"
      ^ map_concat ", " string_of_operand args
  | [ Reg Rcx; dst ] ->
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

type layout = (Ll.uid * operand) list

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

let compile_operand :
    ctxt -> operand S.table -> operand -> Ll.operand -> ins list =
 fun _ctxt asn dst src ->
  match src with
  | Null -> [ (Movq, [ Imm (Lit 0L); dst ]) ]
  | IConst64 i -> [ (Movq, [ Imm (Lit i); dst ]) ]
  | IConst32 i -> [ (Movq, [ Imm (Lit (Int64.of_int32 i)); dst ]) ]
  | IConst8 i -> [ (Movq, [ Imm (Lit (Int64.of_int (Char.code i))); dst ]) ]
  | BConst i -> [ (Movq, [ Imm (Lit (if i then 1L else 0L)); dst ]) ]
  | Gid gid -> [ (Leaq, [ Ind3 (Lbl (mangle gid), Rip); dst ]) ]
  | Id id -> (
      match (dst, S.ST.find_opt id asn) with
      | Ind3 dst, Some (Ind3 src) ->
          [ (Movq, [ Ind3 src; Reg Rcx ]); (Movq, [ Reg Rcx; Ind3 dst ]) ]
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
  let args = List.map snd args in
  let crsaved = [ Rcx; Rdx; Rsi; Rdi; R08; R09; R10; R11 ] in
  let callins =
    match oper with
    | Gid id -> (Callq, [ Imm (Lbl (mangle id)) ])
    | _ -> raise BackendFatal
  in
  let pusharg _i dst : ins list =
    let ins = compile_operand ctxt asn (Reg Rax) dst in
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
  @ [ callins; freeins ]
  @ List.map (fun r -> (Popq, [ Reg r ])) (List.rev crsaved)

let rec size_ty : (Ll.uid * Ll.ty) list -> Ll.ty -> int =
 fun tdecls -> function
  | Void | I8 | Fun _ -> 0
  | I1 | I32 | I64 | Ptr _ -> 8
  | Namedt ty ->
      let ty = List.assoc ty tdecls in
      size_ty tdecls ty
  | Struct tys -> List.fold_left (fun sum ty -> sum + size_ty tdecls ty) 0 tys
  | Array (len, ty) -> len * size_ty tdecls ty

let compile_gep :
    ctxt -> operand S.table -> Ll.ty * Ll.operand -> Ll.operand list -> ins list
    =
 fun ctxt asn (ty, oper) ops ->
  let base = compile_operand ctxt asn (Reg Rcx) oper in
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
          compile_operand ctxt asn (Reg Rax) (IConst64 (Int64.of_int32 i))
        in
        let offset, ty = offset ty (Int32.to_int i) in
        let offsins = (Movq, [ Imm (Lit (Int64.of_int offset)); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | Array (_, ty), head :: tail ->
        let elmsize = size_ty ctxt.tdecls ty in
        let parins = compile_operand ctxt asn (Reg Rax) head in
        let offsins = (Imulq, [ Imm (Lit (Int64.of_int elmsize)); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | _, head :: tail ->
        let parins = compile_operand ctxt asn (Reg Rax) head in
        let offsins = (Imulq, [ Imm (Lit 8L); Reg Rax ]) in
        let childins = (Addq, [ Reg Rax; Reg Rcx ]) in
        gep tail ty ((parins @ [ offsins; childins ]) :: insns)
    | _, [] -> List.rev insns
  in
  base @ List.concat (gep ops (Array (0, ty)) [])

let compile_bop : Ll.bop -> opcode = function
  | Add -> Addq
  | Sub -> Subq
  | Mul -> Imulq
  | SDiv -> Idivq
  | SRem -> Srem
  | Shl -> Shlq
  | Lshr -> Shrq
  | Ashr -> Sarq
  | And -> Andq
  | Or -> Orq
  | Xor -> Xorq

let compile_insn :
    ctxt -> operand S.table -> Ll.uid option * Ll.insn -> ins list =
 fun ctxt asn insn ->
  (Comment (Ll.string_of_named_insn insn), [])
  ::
  (match insn with
  | Some dst, Binop (SDiv, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let pushdx = (Pushq, [ Reg Rdx ]) in
      let lins = compile_operand ctxt asn (Reg Rax) lop in
      let rins = compile_operand ctxt asn (Reg Rcx) rop in
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
      let lins = compile_operand ctxt asn (Reg Rax) lop in
      let rins = compile_operand ctxt asn (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rdx; dst ]) in
      let popdx = (Popq, [ Reg Rdx ]) in
      if dst = Reg Rdx then lins @ rins @ [ cqtoins; opins; storins ]
      else [ pushdx ] @ lins @ rins @ [ cqtoins; opins; storins; popdx ]
  | Some dst, Binop (bop, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn (Reg Rax) lop in
      let rins = compile_operand ctxt asn (Reg Rcx) rop in
      let opins = (compile_bop bop, [ Reg Rcx; Reg Rax ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      lins @ rins @ [ opins; storins ]
  | Some dst, Alloca ty ->
      let dst = S.ST.find dst asn in
      let size = size_ty ctxt.tdecls ty in
      [
        (Subq, [ Imm (Lit (Int64.of_int size)); Reg Rsp ]);
        (Movq, [ Reg Rsp; dst ]);
      ]
  | Some dst, Load (_, src) -> (
      (* if the variable is unassigned, it's not used so can be optimized away *)
      match S.ST.find_opt dst asn with
      | Some dst ->
          let operins = compile_operand ctxt asn (Reg Rax) src in
          let loadins = (Movq, [ Ind2 Rax; Reg Rax ]) in
          let storins = (Movq, [ Reg Rax; dst ]) in
          operins @ [ loadins; storins ]
      | None -> [])
  | None, Store (_, src, dst) ->
      let sins = compile_operand ctxt asn (Reg Rax) src in
      let dins = compile_operand ctxt asn (Reg Rcx) dst in
      let storins =
        match dst with
        | Id _ -> (Movq, [ Reg Rax; Ind2 Rcx ])
        | _ -> raise BackendFatal
      in
      sins @ dins @ [ storins ]
  | Some dst, Icmp (cnd, _, l, r) ->
      let lop = Reg Rax in
      let rop = Reg Rcx in
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn lop l in
      let rins = compile_operand ctxt asn rop r in
      let cmpinsn = (Cmpq, [ rop; lop ]) in
      let setzins = (Movq, [ Imm (Lit 0L); dst ]) in
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
      in
      let setinsn = (Set (compile_cnd cnd), [ byteofquad dst ]) in
      lins @ rins @ [ cmpinsn; setzins; setinsn ]
  | Some dst, Call (_, oper, args) ->
      let dst = S.ST.find dst asn in
      let callins : ins list = compile_call ctxt asn oper args in
      let storins : ins = (Movq, [ Reg Rax; dst ]) in
      callins @ [ storins ]
  | None, Call (_, oper, args) -> compile_call ctxt asn oper args
  | Some dst, Bitcast (_, src, _) ->
      (*Printf.printf "%s\n" (S.name dst);*)
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Gep (ty, src, operlist) ->
      let dst = S.ST.find dst asn in
      let gepinsns = compile_gep ctxt asn (ty, src) operlist in
      let stored = (Movq, [ Reg Rcx; dst ]) in
      gepinsns @ [ stored ]
  | Some dst, Zext (_, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some dst, Ptrtoint (_, src, _) ->
      let dst = S.ST.find dst asn in
      let opins = compile_operand ctxt asn (Reg Rax) src in
      let storins = (Movq, [ Reg Rax; dst ]) in
      opins @ [ storins ]
  | Some _dst, PhiNode _ -> []
  | insn -> failwith (Ll.string_of_named_insn insn))

let compile_terminator :
    ctxt -> operand S.table -> ins list -> Ll.terminator -> ins list =
 fun ctxt asn movs term ->
  (Comment (Ll.string_of_terminator term), [])
  ::
  (match term with
  | Ret (_, Some oper) ->
      let operins = compile_operand ctxt asn (Reg Rax) oper in
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
  | Br lbl -> movs @ [ (Jmp, [ Imm (Lbl (S.name lbl)) ]) ]
  | Cbr (oper, thn, els) ->
      let operins = compile_operand ctxt asn (Reg Rax) oper in
      let zeroins = (Movq, [ Imm (Lit 0L); Reg Rcx ]) in
      let cmpins : ins = (Cmpq, [ Reg Rax; Reg Rcx ]) in
      let jeq = (J Eq, [ Imm (Lbl (S.name els)) ]) in
      let jmp = (Jmp, [ Imm (Lbl (S.name thn)) ]) in
      operins @ [ zeroins; cmpins ] @ movs @ [ jeq; jmp ]
  | _ -> failwith "")

module C = Coloring.Mark (Lva.G)

type allocator = Ocamlgraph | Briggs | Greedy

let string_of_allocator = function
  | Ocamlgraph -> "ocamlgraph"
  | Briggs -> "briggs"
  | Greedy -> "greedy"

module VS = Set.Make (Lva.G.V)
module VT = Map.Make (Lva.G.V)
module Ints = Set.Make (Int)

type mark =
  | Color of S.symbol * Lva.G.V.t
  | PotentialSpill of S.symbol * Lva.G.V.t

type assign = Color of S.symbol * int | ActualSpill of S.symbol

let alloc a (l : Lva.G.V.t S.table) (g : Lva.G.t) : operand S.table =
  let var i =
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
  in
  let l =
    match a with
    | Ocamlgraph ->
        C.coloring g 12;
        S.ST.mapi (fun _k v -> Lva.G.Mark.get v) l |> S.ST.map var
    | Greedy ->
        let c = ref 0 in
        S.ST.map
          (fun _v ->
            let v = var !c in
            c := !c + 1;
            v)
          l
    | Briggs ->
        let c = 2 in
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
        let stack i = Ind3 (Lit (Int64.of_int ((i + 1) * -8)), Rbp) in
        let rec simp (spills : S.SS.t) =
          Printf.printf "Spills: ";
          S.SS.iter (fun k -> Printf.printf "%s, " (S.name k)) spills;
          Printf.printf "\n";
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
              | Some (k, (v, deg)) ->
                  Printf.printf "removing %s (%d < %d)\n" (S.name k) deg c;
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
          Printf.printf "Marked as colorable: ";
          List.iter
            (fun (m : mark) ->
              match m with
              | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
              | PotentialSpill (k, _v) -> Printf.printf "spill %s, " (S.name k))
            markers;
          Printf.printf "\n";
          let indices = Ints.add 1 (Ints.add 0 Ints.empty) in
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
                Printf.printf "coloring %s %d\n" (S.name k) assignment;
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
                    Printf.printf "coloring %s %d\n" (S.name k) assignment;
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
          Printf.printf "Assignments: ";
          List.iter
            (function
              | Color (k, _v) -> Printf.printf "color %s, " (S.name k)
              | ActualSpill k -> Printf.printf "actual spill %s, " (S.name k))
            assignments;
          Printf.printf "\n";
          let spills2 =
            List.filter_map
              (function Color _ -> None | ActualSpill k -> Some k)
              assignments
          in
          if List.is_empty spills2 then
            snd
              (S.SS.fold
                 (fun k (i, a) -> (i + 1, S.ST.add k (stack i) a))
                 spills
                 ( 0,
                   List.fold_left
                     (fun t v ->
                       match v with
                       | Color (k, c) -> S.ST.add k (register c) t
                       | ActualSpill _k -> failwith "unreachable")
                     S.ST.empty assignments ))
          else simp (S.SS.of_list spills2)
        in
        simp S.SS.empty
  in
  l

let insns (_insns : Cfg.insn list) (_l : Lva.G.V.t S.table) (_g : Lva.G.t) :
    int S.table =
  let _insn (_insns : Cfg.insn) (_l : Lva.G.V.t S.table) (_g : Lva.G.t) = 4 in
  S.empty

let compile_fdecl :
    allocator -> (Ll.uid * Ll.ty) list -> Ll.uid -> Ll.fdecl -> elem list =
 fun (alc : allocator) tdecls name { param; cfg; _ } ->
  (* move out of pre-assigned parameter registers (rsi, rdi, .. r9) *)
  let head, tail = cfg in
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
  let pro =
    [
      (Pushq, [ Reg Rbp ]);
      (Pushq, [ Reg Rbx ]);
      (Pushq, [ Reg R12 ]);
      (Pushq, [ Reg R13 ]);
      (Pushq, [ Reg R14 ]);
      (Pushq, [ Reg R15 ]);
      (Movq, [ Reg Rsp; Reg Rbp ]);
      ( Subq,
        [
          Imm
            (Lit
               (Int64.of_int
                  ((List.length named_insns + List.length param) * 8)));
          Reg Rsp;
        ] );
    ]
  in
  let ids, g = Cfg.graph cfg in
  let insns : Cfg.insn list = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let lbl, itf = Lva.interf param insns in_ out in
  let asn = alloc alc lbl itf in
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
  let pro = pro @ List.mapi pusharg param @ List.mapi poparg (List.rev param) in
  let _var i =
    match i + 2 with
    | 0 -> Reg Rax
    | 1 -> Reg Rcx
    | 2 -> Reg Rdx
    | 3 -> Reg Rbx
    | 4 -> Reg Rsi
    | 5 -> Reg Rdi
    | 6 -> Reg R08
    | 7 -> Reg R09
    | 8 -> Reg Rax
    | 9 -> Reg Rcx
    | 10 -> Reg R12
    | 11 -> Reg R13
    | 12 -> Reg R14
    | 13 -> Reg R15
    | _i -> Ind3 (Lit 0L, Rbp)
  in
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
            S.ST.update lbl
              (function
                | Some movs ->
                    Some
                      (movs @ compile_operand ctxt asn (S.ST.find dst asn) src)
                | None ->
                    Some (compile_operand ctxt asn (S.ST.find dst asn) src))
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
         let tail = compile_terminator ctxt asn movs term in
         { lbl = S.name name; global; asm = Text (head @ tail) })

let rec compile_ginit = function
  | Ll.GNull -> [ Quad (Lit 0L) ]
  | GGid gid -> [ Quad (Lbl (mangle gid)) ]
  | GInt c -> [ Quad (Lit (Int64.of_int c)) ]
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
