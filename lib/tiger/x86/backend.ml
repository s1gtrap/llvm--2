(**************************************************************************)
(* AU compilation.                                                        *)
(* Skeleton file -- expected to be modified as part of the assignment     *)
(**************************************************************************)

(* ll ir compilation -------------------------------------------------------- *)

open Tigercommon
module S = Symbol
open X86
open Ll

exception BackendFatal (* use this for impossible cases *)

(* Helpers ------------------------------------------------------------------ *)

(* Platform-specific symbol generation *)

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

(* Mapping ll comparison operations to X86 condition codes *)
let compile_cnd (c : Ll.cnd) : X86.cnd =
  match c with
  | Ll.Eq -> X86.Eq
  | Ll.Ne -> X86.Neq
  | Ll.Slt -> X86.Lt
  | Ll.Sle -> X86.Le
  | Ll.Sgt -> X86.Gt
  | Ll.Sge -> X86.Ge

(* locals and layout -------------------------------------------------------- *)

(* One key problem in compiling the LLVM IR is how to map its local
   identifiers to X86 abstractions.  For the best performance, one
   would want to use an X86 register for each LLVM %uid.  However,
   since there are an unlimited number of %uids and only 16 registers,
   doing so effectively is quite difficult.  We will see later in the
   course how _register allocation_ algorithms can do a good job at
   this.

   A simpler, but less performant, implementation is to map each %uid
   in the LLVM source to a _stack slot_ (i.e. a region of memory in
   the stack).  Since LLVMlite, unlike real LLVM, permits %uid locals
   to store only 64-bit data, each stack slot is an 8-byte value.

   [ NOTE: For compiling LLVMlite, even i1 data values should be
   represented as a 8-byte quad. This greatly simplifies code
   generation. ]

   We call the datastructure that maps each %uid to its stack slot a
   'stack layout'.  A stack layout maps a uid to an X86 operand for
   accessing its contents.  For this compilation strategy, the operand
   is always an offset from %rbp (in bytes) that represents a storage slot in
   the stack.
*)

type layout = (Ll.uid * X86.operand) list

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

let compile_operand : ty -> ctxt -> X86.operand -> Ll.operand -> ins =
 fun ty ctxt dst src ->
  let mov = match ty with I8 -> Movb | I32 -> Movl | _ -> Movq in
  let dst =
    match (ty, dst) with
    | I8, Reg (Rax | Eax | Al) -> Reg Al
    | I8, Reg (Rcx | Ecx | Cl) -> Reg Cl
    | I8, Reg (Rdx | Edx | Dl) -> Reg Dl
    | I8, Reg (Rbx | Ebx | Bl) -> Reg Bl
    | I8, Reg (Rsp | Esp | Spl) -> Reg Spl
    | I8, Reg (Rbp | Ebp | Bpl) -> Reg Bpl
    | I8, Reg (Rsi | Esi | Sil) -> Reg Sil
    | I8, Reg (Rdi | Edi | Dil) -> Reg Dil
    | I8, Reg (R08 | R08d | R08b) -> Reg R08b
    | I8, Reg (R09 | R09d | R09b) -> Reg R09b
    | I8, Reg (R10 | R10d | R10b) -> Reg R10b
    | I8, Reg (R11 | R11d | R11b) -> Reg R11b
    | I8, Reg (R12 | R12d | R12b) -> Reg R12b
    | I8, Reg (R13 | R13d | R13b) -> Reg R13b
    | I8, Reg (R14 | R14d | R14b) -> Reg R14b
    | I8, Reg (R15 | R15d | R15b) -> Reg R15b
    | I32, Reg (Rax | Eax | Al) -> Reg Eax
    | I32, Reg (Rcx | Ecx | Cl) -> Reg Ecx
    | I32, Reg (Rdx | Edx | Dl) -> Reg Edx
    | I32, Reg (Rbx | Ebx | Bl) -> Reg Ebx
    | I32, Reg (Rsp | Esp | Spl) -> Reg Esp
    | I32, Reg (Rbp | Ebp | Bpl) -> Reg Ebp
    | I32, Reg (Rsi | Esi | Sil) -> Reg Esi
    | I32, Reg (Rdi | Edi | Dil) -> Reg Edi
    | I32, Reg (R08 | R08d | R08b) -> Reg R08d
    | I32, Reg (R09 | R09d | R09b) -> Reg R09d
    | I32, Reg (R10 | R10d | R10b) -> Reg R10d
    | I32, Reg (R11 | R11d | R11b) -> Reg R11d
    | I32, Reg (R12 | R12d | R12b) -> Reg R12d
    | I32, Reg (R13 | R13d | R13b) -> Reg R13d
    | I32, Reg (R14 | R14d | R14b) -> Reg R14d
    | I32, Reg (R15 | R15d | R15b) -> Reg R15d
    | I64, Reg (Rax | Eax | Al) -> Reg Rax
    | I64, Reg (Rcx | Ecx | Cl) -> Reg Rcx
    | I64, Reg (Rdx | Edx | Dl) -> Reg Rdx
    | I64, Reg (Rbx | Ebx | Bl) -> Reg Rbx
    | I64, Reg (Rsp | Esp | Spl) -> Reg Rsp
    | I64, Reg (Rbp | Ebp | Bpl) -> Reg Rbp
    | I64, Reg (Rsi | Esi | Sil) -> Reg Rsi
    | I64, Reg (Rdi | Edi | Dil) -> Reg Rdi
    | I64, Reg (R08 | R08d | R08b) -> Reg R08
    | I64, Reg (R09 | R09d | R09b) -> Reg R09
    | I64, Reg (R10 | R10d | R10b) -> Reg R10
    | I64, Reg (R11 | R11d | R11b) -> Reg R11
    | I64, Reg (R12 | R12d | R12b) -> Reg R12
    | I64, Reg (R13 | R13d | R13b) -> Reg R13
    | I64, Reg (R14 | R14d | R14b) -> Reg R14
    | I64, Reg (R15 | R15d | R15b) -> Reg R15
    | _, reg -> reg
  in
  match src with
  | Null -> (mov, [ Imm (Lit 0L); dst ])
  | Const i -> (mov, [ Imm (Lit i); dst ])
  | Gid gid -> (Leaq, [ Ind3 (Lbl (mangle gid), Rip); dst ])
  | Id id -> (mov, [ lookup ctxt.layout id; dst ])

let arg_loc : int -> X86.operand = function
  | 0 -> Reg Rdi
  | 1 -> Reg Rsi
  | 2 -> Reg Rdx
  | 3 -> Reg Rcx
  | 4 -> Reg R08
  | 5 -> Reg R09
  | n -> Ind3 (Lit (Int64.of_int ((3 * 8) + ((n - 6) * 8))), Rbp)

(* compiling call  ---------------------------------------------------------- *)

(* You will probably find it helpful to implement a helper function that
   generates code for the LLVM IR call instruction.

   The code you generate should follow the x64 System V AMD64 ABI
   calling conventions, which places the first six 64-bit (or smaller)
   values in registers and pushes the rest onto the stack.  Note that,
   since all LLVM IR operands are 64-bit values, the first six
   operands will always be placed in registers.  (See the notes about
   compiling fdecl below.)

   [ NOTE: It is the caller's responsibility to clean up arguments
   pushed onto the stack, so you must free the stack space after the
   call returns. ]

   [ NOTE: Don't forget to preserve caller-save registers (only if
   needed). ]
*)

let compile_call : ctxt -> Ll.operand -> (ty * Ll.operand) list -> ins list =
 fun ctxt oper args ->
  let args = List.map snd args in
  let push oper =
    let operins = compile_operand I64 ctxt (Reg R10) oper in
    [ operins; (Pushq, [ Reg R10 ]) ]
  in
  let storereg idx oper =
    let insn = compile_operand I64 ctxt (Reg R10) oper in
    let reg = arg_loc idx in
    [ insn; (Movq, [ Reg R10; reg ]) ]
  in
  let arginsns =
    let regs, stack =
      let rec separate args acc idx =
        match args with
        | args when idx == 6 -> (List.rev acc, args)
        | arg :: args -> separate args (arg :: acc) (idx + 1)
        | [] -> (List.rev acc, [])
      in
      separate args [] 0
    in
    List.concat (List.mapi storereg regs @ List.map push (List.rev stack))
  in
  let callins =
    match oper with
    | Gid id ->
        [
          (Movq, [ Imm (Lit 0L); Reg Rax ]); (Callq, [ Imm (Lbl (mangle id)) ]);
        ]
    | _ -> raise BackendFatal
  in
  let freen =
    match List.length args with len when len <= 6 -> 0 | len -> (len - 6) * 8
  in
  let freeins = (Addq, [ Imm (Lit (Int64.of_int freen)); Reg Rsp ]) in
  arginsns @ callins @ [ freeins ]

(* compiling getelementptr (gep)  ------------------------------------------- *)

(* The getelementptr instruction computes an address by indexing into
   a datastructure, following a path of offsets.  It computes the
   address based on the size of the data, which is dictated by the
   data's type.

   To compile getelmentptr, you must generate x86 code that performs
   the appropriate arithemetic calculations.
*)

(* Function size_ty maps an LLVMlite type to a size in bytes.
   (needed for getelementptr)

   - the size of a struct is the sum of the sizes of each component
   - the size of an array of t's with n elements is n * the size of t
   - all pointers, I1, and I64 are 8 bytes
   - the size of a named type is the size of its definition

   - Void, i8, and functions have undefined sizes according to LLVMlite
     your function should simply return 0
*)

let rec size_ty : (uid * ty) list -> ty -> quad =
 fun tdecls -> function
  | Void | Fun _ -> 1L
  | I1 | I8 -> 1L
  | I32 -> 4L
  | I64 | Ptr _ -> 8L
  | Namedt ty ->
      let ty = List.assoc ty tdecls in
      size_ty tdecls ty
  | Struct tys ->
      List.fold_left (fun sum ty -> Int64.add sum (size_ty tdecls ty)) 0L tys
  | Array (len, ty) -> Int64.mul len (size_ty tdecls ty)

let compile_gep : ctxt -> ty * Ll.operand -> Ll.operand list -> ins list =
 fun ctxt (ty, oper) ops ->
  let base = compile_operand I64 ctxt (Reg R11) oper in
  let rec gep : Ll.operand list -> ty -> ins list list -> ins list list =
   fun ops ty insns ->
    match (ty, ops) with
    | Namedt tid, _ -> gep ops (lookup ctxt.tdecls tid) insns
    | Struct _, Const i :: tail ->
        let offset : ty -> int -> quad * ty =
         fun ty idx ->
          match ty with
          | Struct tys ->
              let rec get tys idx offset =
                match tys with
                | ty :: _ when idx == 0 -> (offset, ty)
                | ty :: tys ->
                    get tys (idx - 1)
                      (Int64.add offset (size_ty ctxt.tdecls ty))
                | _ -> raise BackendFatal
              in
              get tys idx 0L
          | _ -> raise BackendFatal
        in
        let parins = compile_operand I64 ctxt (Reg R10) (Const i) in
        let offset, ty = offset ty (Int64.to_int i) in
        let offsins = (Movq, [ Imm (Lit offset); Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | Array (_, ty), head :: tail ->
        let elmsize = size_ty ctxt.tdecls ty in
        let parins = compile_operand I64 ctxt (Reg R10) head in
        let offsins = (Imulq, [ Imm (Lit elmsize); Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | _, head :: tail ->
        let parins = compile_operand I64 ctxt (Reg R10) head in
        let offsins = (Imulq, [ Imm (Lit 8L); Reg R10; Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | _, [] -> List.rev insns
  in
  base :: List.concat (gep ops (Array (0L, ty)) [])

(* compiling instructions  -------------------------------------------------- *)

(* The result of compiling a single LLVM instruction might be many x86
   instructions.  We have not determined the structure of this code
   for you. Some of the instructions require only a couple assembly
   instructions, while others require more.  We have suggested that
   you need at least compile_operand, compile_call, and compile_gep
   helpers; you may introduce more as you see fit.

   Here are a few notes:

   - Icmp:  the Set instruction may be of use.  Depending on how you
     compile Cbr, you may want to ensure that the value produced by
     Icmp is exactly 0 or 1.

   - Load & Store: these need to dereference the pointers. Const and
     Null operands aren't valid pointers.  Don't forget to
     Platform.mangle the global identifier.

   - Alloca: needs to return a pointer into the stack

   - Bitcast: does nothing interesting at the assembly level
*)

let compile_bop : bop -> opcode = function
  | Add -> Addq
  | Sub -> Subq
  | Mul -> Imulq
  | SDiv | SRem -> failwith "unreachable"
  | Shl -> Shlq
  | Lshr -> Shrq
  | Ashr -> Sarq
  | And -> Andq
  | Or -> Orq
  | Xor -> Xorq

let compile_insn : ctxt -> uid option * insn -> ins list =
 fun ctxt insn ->
  (Comment (Ll.string_of_named_insn insn), [])
  ::
  (match insn with
  | Some dst, Binop (SDiv, ty, lop, rop) ->
      (* RAX and R10 are volatile, should be good? *)
      let lins = compile_operand ty ctxt (Reg Rax) lop in
      let rins = compile_operand ty ctxt (Reg R10) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg R10 ]) in
      let storins = (Movq, [ Reg Rax; lookup ctxt.layout dst ]) in
      [ lins; rins; cqtoins; opins; storins ]
  | Some dst, Binop (SRem, ty, lop, rop) ->
      let lins = compile_operand ty ctxt (Reg Rax) lop in
      let rins = compile_operand ty ctxt (Reg Rcx) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg Rcx ]) in
      let storins = (Movq, [ Reg Rdx; lookup ctxt.layout dst ]) in
      [ lins; rins; cqtoins; opins; storins ]
  | Some dst, Binop (bop, ty, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let lins = compile_operand ty ctxt (Reg Rax) lop in
      let rins = compile_operand ty ctxt (Reg Rcx) rop in
      let opins = (compile_bop bop, [ Reg Rcx; Reg Rax ]) in
      let storins = (Movq, [ Reg Rax; lookup ctxt.layout dst ]) in
      [ lins; rins; opins; storins ]
  | Some dst, Alloca ty ->
      let size = size_ty ctxt.tdecls ty in
      [
        (Subq, [ Imm (Lit size); Reg Rsp ]);
        (Movq, [ Reg Rsp; lookup ctxt.layout dst ]);
      ]
  | Some dst, Load (I8, src) ->
      let operins = compile_operand I64 ctxt (Reg R10) src in
      let zeroins = (Xorq, [ Reg Rcx; Reg Rcx ]) in
      let loadins = (Movb, [ Ind2 R10; Reg Cl ]) in
      let storins = (Movq, [ Reg Rcx; lookup ctxt.layout dst ]) in
      [ operins; zeroins; loadins; storins ]
  | Some dst, Load (I32, src) ->
      let operins = compile_operand I64 ctxt (Reg R10) src in
      let zeroins = (Xorq, [ Reg Rcx; Reg Rcx ]) in
      let loadins = (Movl, [ Ind2 R10; Reg Ecx ]) in
      let storins = (Movq, [ Reg Rcx; lookup ctxt.layout dst ]) in
      [ operins; zeroins; loadins; storins ]
  | Some dst, Load (_ty, src) ->
      let operins = compile_operand I64 ctxt (Reg R10) src in
      let zeroins = (Xorq, [ Reg Rcx; Reg Rcx ]) in
      let loadins = (Movq, [ Ind2 R10; Reg Rcx ]) in
      let storins = (Movq, [ Reg Rcx; lookup ctxt.layout dst ]) in
      [ operins; zeroins; loadins; storins ]
  | None, Store (I8, src, dst) ->
      let sins = compile_operand I8 ctxt (Reg R10) src in
      let dins = compile_operand I8 ctxt (Reg R11) dst in
      let storins =
        match dst with
        | Id _ -> (Movb, [ Reg R10b; Ind2 R11 ])
        | _ -> raise BackendFatal
      in
      [ sins; dins; storins ]
  | None, Store (I32, src, dst) ->
      let sins = compile_operand I32 ctxt (Reg R10) src in
      let dins = compile_operand I64 ctxt (Reg R11) dst in
      let storins =
        match dst with
        | Id _ -> (Movl, [ Reg R10d; Ind2 R11 ])
        | _ -> raise BackendFatal
      in
      [ sins; dins; storins ]
  | None, Store (ty, src, dst) ->
      let sins = compile_operand ty ctxt (Reg R10) src in
      let dins = compile_operand ty ctxt (Reg R11) dst in
      let storins =
        match dst with
        | Id _ -> (Movq, [ Reg R10; Ind2 R11 ])
        | _ -> raise BackendFatal
      in
      [ sins; dins; storins ]
  | Some dst, Icmp (cnd, ty, l, r) ->
      let lop = Reg R10 in
      let rop = Reg R11 in
      let lins = compile_operand ty ctxt lop l in
      let rins = compile_operand ty ctxt rop r in
      let cmpinsn = (Cmpq, [ rop; lop ]) in
      let setzins = (Movq, [ Imm (Lit 0L); lookup ctxt.layout dst ]) in
      let setinsn = (Set (compile_cnd cnd), [ lookup ctxt.layout dst ]) in
      [ lins; rins; cmpinsn; setzins; setinsn ]
  | Some dst, Call (_, oper, args) ->
      let callins : ins list = compile_call ctxt oper args in
      let storins : ins = (Movq, [ Reg Rax; lookup ctxt.layout dst ]) in
      callins @ [ storins ]
  | None, Call (_, oper, args) -> compile_call ctxt oper args
  | Some dst, Bitcast (_, src, _) ->
      let opins = compile_operand I64 ctxt (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | Some dst, Gep (ty, src, operlist) ->
      let gepinsns = compile_gep ctxt (ty, src) operlist in
      let stored = (Movq, [ Reg R11; lookup ctxt.layout dst ]) in
      gepinsns @ [ stored ]
  | Some dst, Zext (ty, src, _) ->
      (* FIXME: maybe pick destination register by size? *)
      let zeroins = (Xorq, [ Reg R10; Reg R10 ]) in
      let opins = compile_operand ty ctxt (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ zeroins; opins; storins ]
  | Some dst, Trunc (_, src, _) ->
      (* FIXME: maybe shouldn't be hardcoded to i64? *)
      let opins = compile_operand I64 ctxt (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | Some dst, Ptrtoint (_, src, _) ->
      let opins = compile_operand I64 ctxt (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | insn -> failwith (string_of_named_insn insn))

(* compiling terminators  --------------------------------------------------- *)

(* Compile block terminators is not too difficult:

   - Ret should properly exit the function: freeing stack space,
     restoring the value of %rbp, and putting the return value (if
     any) in %rax.

   - Br should jump

   - Cbr branch should treat its operand as a boolean conditional
*)

let compile_terminator : lbl -> ctxt -> terminator -> ins list =
 fun name ctxt term ->
  match term with
  | Ret (ty, Some oper) ->
      let operins = compile_operand ty ctxt (Reg Rax) oper in
      [ operins; (Movq, [ Reg Rbp; Reg Rsp ]); (Popq, [ Reg Rbp ]); (Retq, []) ]
  | Ret (_, None) ->
      [ (Movq, [ Reg Rbp; Reg Rsp ]); (Popq, [ Reg Rbp ]); (Retq, []) ]
  | Br lbl -> [ (Jmp, [ Imm (Lbl (S.name name ^ S.name lbl)) ]) ]
  | Cbr (oper, thn, els) ->
      let operins = compile_operand I64 ctxt (Reg Rax) oper in
      let zeroins = (Movq, [ Imm (Lit 0L); Reg R10 ]) in
      let cmpins : ins = (Cmpq, [ Reg Rax; Reg R10 ]) in
      let jeq = (J Eq, [ Imm (Lbl (S.name name ^ S.name els)) ]) in
      let jmp = (Jmp, [ Imm (Lbl (S.name name ^ S.name thn)) ]) in
      [ operins; zeroins; cmpins; jeq; jmp ]

(* compiling blocks --------------------------------------------------------- *)

(* We have left this helper function here for you to complete. *)
let compile_block : lbl -> ctxt -> block -> ins list =
 fun name ctxt { insns; terminator } ->
  let insns = List.concat @@ List.map (compile_insn ctxt) insns in
  let term = compile_terminator name ctxt terminator in
  List.append insns term

let compile_lbl_block : lbl -> lbl -> ctxt -> block -> elem =
 fun name lbl ctxt { insns; terminator } ->
  let lbl = S.name name ^ S.name lbl in
  let insns = List.concat @@ List.map (compile_insn ctxt) insns in
  let term = compile_terminator name ctxt terminator in
  { lbl; global = false; asm = Text (List.append insns term) }

(* compile_fdecl ------------------------------------------------------------ *)

(* This helper function computes the location of the nth incoming
   function argument: either in a register or relative to %rbp,
   according to the calling conventions.  You might find it useful for
   compile_fdecl.

   [ NOTE: the first six arguments are numbered 0 .. 5 ]
*)

(* The code for the entry-point of a function must do several things:

   - since our simple compiler maps local %uids to stack slots,
     compiling the control-flow-graph body of an fdecl requires us to
     compute the layout (see the discussion of locals and layout)

   - the function code should also comply with the calling
     conventions, typically by moving arguments out of the parameter
     registers (or stack slots) into local storage space.  For our
     simple compilation strategy, that local storage space should be
     in the stack. (So the function parameters can also be accounted
     for in the layout.)

   - the function entry code should allocate the stack storage needed
     to hold all of the local stack slots.
*)

let compile_fdecl : (uid * ty) list -> uid -> fdecl -> elem list =
 fun tdecls name { fty = _; param; cfg } ->
  let head, tail = cfg in
  let _, blocks = List.split tail in
  let named_insns =
    head.insns @ List.concat (List.map (fun b -> b.insns) blocks)
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
  let arg idx param =
    [
      (Movq, [ arg_loc idx; Reg R10 ]);
      (Movq, [ Reg R10; lookup ctxt.layout param ]);
    ]
  in
  let args = List.concat (List.mapi arg param) in
  let elems =
    List.map (fun (lbl, blk) -> compile_lbl_block name lbl ctxt blk) tail
  in
  let body = compile_block name ctxt head in
  let text = pro @ args @ body in
  [ { lbl = mangle name; global = true; asm = Text text } ] @ elems

(* compile_gdecl ------------------------------------------------------------ *)

(* Compile a global value into an X86 global data declaration and map
   a global uid to its associated X86 label.
*)

let rec compile_ginit = function
  | GNull -> [ Quad (Lit 0L) ]
  | GGid gid -> [ Quad (Lbl (mangle gid)) ]
  | GInt c -> [ Quad (Lit c) ]
  | GString s -> [ Asciz s ]
  | GArray gs -> List.concat (List.map compile_gdecl gs)
  | GStruct gs -> List.concat (List.map compile_gdecl gs)

and compile_gdecl (_, g) = compile_ginit g

(* compile_prog ------------------------------------------------------------- *)

let compile_prog ({ tdecls; gdecls; fdecls } : Ll.prog) : X86.prog =
  let g (lbl, gdecl) = Asm.data (mangle lbl) (compile_gdecl gdecl) in
  let f (name, fdecl) = compile_fdecl tdecls name fdecl in
  List.map g gdecls @ List.concat (List.map f fdecls)
