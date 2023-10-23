open Graph
module S = Symbol

exception BackendFatal (* use this for impossible cases *)

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
  let glb = if global then "\t.globl\t" ^ string_of_lbl lbl ^ "\n" else "" in
  sec ^ glb ^ string_of_lbl lbl ^ ":\n" ^ body

let string_of_prog (p : prog) : string =
  String.concat "\n" (List.map string_of_elem p)

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

let compile_operand : ctxt -> operand S.table -> operand -> Ll.operand -> ins =
 fun _ctxt asn dst src ->
  match src with
  | Null -> (Movq, [ Imm (Lit 0L); dst ])
  | IConst64 i -> (Movq, [ Imm (Lit i); dst ])
  | IConst32 i -> (Movq, [ Imm (Lit (Int64.of_int32 i)); dst ])
  | IConst8 i -> (Movq, [ Imm (Lit (Int64.of_int (Char.code i))); dst ])
  | BConst i -> (Movq, [ Imm (Lit (if i then 1L else 0L)); dst ])
  | Gid gid -> (Movq, [ Imm (Lbl (S.name gid)); dst ])
  | Id id ->
      ( Movq,
        [
          (match S.ST.find_opt id asn with
          | Some i -> i
          | None -> failwith (Printf.sprintf "%s" (S.name id)));
          dst;
        ] )

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
  let push oper =
    let operins = compile_operand ctxt asn (Reg R10) oper in
    [ operins; (Pushq, [ Reg R10 ]) ]
  in
  let storereg idx oper =
    let insn = compile_operand ctxt asn (Reg R10) oper in
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
    | Gid id -> (Callq, [ Imm (Lbl (mangle id)) ])
    | _ -> raise BackendFatal
  in
  let freen =
    match List.length args with
    | len when len <= 6 -> 0L
    | len -> Int64.of_int ((len - 6) * 8)
  in
  let freeins = (Addq, [ Imm (Lit freen); Reg Rsp ]) in
  arginsns @ [ callins; freeins ]

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
  let base = compile_operand ctxt asn (Reg R11) oper in
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
          compile_operand ctxt asn (Reg R10) (IConst64 (Int64.of_int32 i))
        in
        let offset, ty = offset ty (Int32.to_int i) in
        let offsins = (Movq, [ Imm (Lit (Int64.of_int offset)); Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | Array (_, ty), head :: tail ->
        let elmsize = size_ty ctxt.tdecls ty in
        let parins = compile_operand ctxt asn (Reg R10) head in
        let offsins = (Imulq, [ Imm (Lit (Int64.of_int elmsize)); Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | _, head :: tail ->
        let parins = compile_operand ctxt asn (Reg R10) head in
        let offsins = (Imulq, [ Imm (Lit 8L); Reg R10; Reg R10 ]) in
        let childins = (Addq, [ Reg R10; Reg R11 ]) in
        gep tail ty ([ parins; offsins; childins ] :: insns)
    | _, [] -> List.rev insns
  in
  base :: List.concat (gep ops (Array (0, ty)) [])

let compile_bop : Ll.bop -> opcode = function
  | Add -> Addq
  | Sub -> Subq
  | Mul -> Imulq
  | SDiv -> Idivq
  | SRem -> failwith "TODO"
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
      (* RAX and R10 are volatile, should be good? *)
      let lins = compile_operand ctxt asn (Reg Rax) lop in
      let rins = compile_operand ctxt asn (Reg R10) rop in
      let cqtoins = (Cqto, []) in
      let opins = (Idivq, [ Reg R10 ]) in
      let storins = (Movq, [ Reg Rax; lookup ctxt.layout dst ]) in
      [ lins; rins; cqtoins; opins; storins ]
  | Some dst, Binop (bop, _, lop, rop) ->
      (* RAX and RCX are volatile, should be good? *)
      let dst = S.ST.find dst asn in
      let lins = compile_operand ctxt asn (Reg Rax) lop in
      let rins = compile_operand ctxt asn (Reg Rcx) rop in
      let opins = (compile_bop bop, [ Reg Rcx; Reg Rax ]) in
      let storins = (Movq, [ Reg Rax; dst ]) in
      [ lins; rins; opins; storins ]
  | Some dst, Alloca ty ->
      let size = size_ty ctxt.tdecls ty in
      [
        (Subq, [ Imm (Lit (Int64.of_int size)); Reg Rsp ]);
        (Movq, [ Reg Rsp; lookup ctxt.layout dst ]);
      ]
  | Some dst, Load (_, src) ->
      let operins = compile_operand ctxt asn (Reg R10) src in
      let loadins = (Movq, [ Ind2 R10; Reg R10 ]) in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ operins; loadins; storins ]
  | None, Store (_, src, dst) ->
      let sins = compile_operand ctxt asn (Reg R10) src in
      let dins = compile_operand ctxt asn (Reg R11) dst in
      let storins =
        match dst with
        | Id _ -> (Movq, [ Reg R10; Ind2 R11 ])
        | _ -> raise BackendFatal
      in
      [ sins; dins; storins ]
  | Some dst, Icmp (cnd, _, l, r) ->
      let lop = Reg R10 in
      let rop = Reg R11 in
      let lins = compile_operand ctxt asn lop l in
      let rins = compile_operand ctxt asn rop r in
      let cmpinsn = (Cmpq, [ rop; lop ]) in
      let setzins = (Movq, [ Imm (Lit 0L); lookup ctxt.layout dst ]) in
      let setinsn = (Set (compile_cnd cnd), [ lookup ctxt.layout dst ]) in
      [ lins; rins; cmpinsn; setzins; setinsn ]
  | Some dst, Call (_, oper, args) ->
      let callins : ins list = compile_call ctxt asn oper args in
      let storins : ins = (Movq, [ Reg Rax; lookup ctxt.layout dst ]) in
      callins @ [ storins ]
  | None, Call (_, oper, args) -> compile_call ctxt asn oper args
  | Some dst, Bitcast (_, src, _) ->
      let opins = compile_operand ctxt asn (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | Some dst, Gep (ty, src, operlist) ->
      let gepinsns = compile_gep ctxt asn (ty, src) operlist in
      let stored = (Movq, [ Reg R11; lookup ctxt.layout dst ]) in
      gepinsns @ [ stored ]
  | Some dst, Zext (_, src, _) ->
      let opins = compile_operand ctxt asn (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | Some dst, Ptrtoint (_, src, _) ->
      let opins = compile_operand ctxt asn (Reg R10) src in
      let storins = (Movq, [ Reg R10; lookup ctxt.layout dst ]) in
      [ opins; storins ]
  | Some _dst, PhiNode _ -> []
  | insn -> failwith (Ll.string_of_named_insn insn))

let compile_terminator : ctxt -> operand S.table -> Ll.terminator -> ins list =
 fun ctxt asn term ->
  (Comment (Ll.string_of_terminator term), [])
  ::
  (match term with
  | Ret (_, Some oper) ->
      let operins = compile_operand ctxt asn (Reg Rax) oper in
      [ operins; (Movq, [ Reg Rbp; Reg Rsp ]); (Popq, [ Reg Rbp ]); (Retq, []) ]
  | Ret (_, None) ->
      [ (Movq, [ Reg Rbp; Reg Rsp ]); (Popq, [ Reg Rbp ]); (Retq, []) ]
  | Br lbl -> [ (Jmp, [ Imm (Lbl (S.name lbl)) ]) ]
  | Cbr (oper, thn, els) ->
      let operins = compile_operand ctxt asn (Reg Rax) oper in
      let zeroins = (Movq, [ Imm (Lit 0L); Reg R10 ]) in
      let cmpins : ins = (Cmpq, [ Reg Rax; Reg R10 ]) in
      let jeq = (J Eq, [ Imm (Lbl (S.name els)) ]) in
      let jmp = (Jmp, [ Imm (Lbl (S.name thn)) ]) in
      [ operins; zeroins; cmpins; jeq; jmp ]
  | _ -> failwith "")

module C = Coloring.Mark (Lva.G)

let alloc (l : Lva.G.V.t S.table) (g : Lva.G.t) : int S.table =
  C.coloring g 9;
  S.ST.map (fun v -> Lva.G.Mark.get v) l

let insns (_insns : Cfg.insn list) (l : Lva.G.V.t S.table) (g : Lva.G.t) :
    int S.table =
  let _asn = alloc l g in
  let _insn (_insns : Cfg.insn) (_l : Lva.G.V.t S.table) (_g : Lva.G.t) = 4 in
  S.empty

let compile_fdecl : (Ll.uid * Ll.ty) list -> Ll.uid -> Ll.fdecl -> elem list =
 fun tdecls name { param; cfg; _ } ->
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
  let rec zip a b =
    match (a, b) with
    | a :: taila, b :: tailb -> [ (a, b) ] @ zip taila tailb
    | [], _ | _, [] -> []
  in
  let _arg = function
    | 0 -> Reg Rdi
    | 1 -> Reg Rsi
    | 2 -> Reg Rdx
    | 3 -> Reg Rcx
    | 4 -> Reg R08
    | 5 -> Reg R09
    | _i -> Ind3 (Lit 0L, Rbp)
  in
  let var i =
    match i + 2 with
    | 0 -> Reg Rax
    | 1 -> Reg Rcx
    | 2 -> Reg Rdx
    | 3 -> Reg Rbx
    | 4 -> Reg Rsi
    | 5 -> Reg Rdi
    | 6 -> Reg R08
    | 7 -> Reg R09
    | 8 -> Reg R10
    | 9 -> Reg R11
    | 10 -> Reg R12
    | 11 -> Reg R13
    | 12 -> Reg R14
    | 13 -> Reg R15
    | _i -> Ind3 (Lit 0L, Rbp)
  in
  let _param = zip param [ Rdi; Rsi; Rdx; Rcx; R08; R09 ] in
  let ids, g = Cfg.graph cfg in
  let insns : Cfg.insn list = Cfg.flatten cfg in
  let in_, out = Lva.dataflow insns ids g in
  let lbl, itf = Lva.interf insns in_ out in
  let asn = alloc lbl itf |> S.ST.map var in
  let rec f name global (insns : (Ll.uid option * Ll.insn) list) = function
    | Cfg.Insn i :: tail -> f name global (insns @ [ i ]) tail
    | Cfg.Term t :: Cfg.Label nname :: tail ->
        [ (name, global, insns, t) ] @ f nname false [] tail
    | [ Cfg.Term t ] -> [ (name, global, insns, t) ]
    | _ -> failwith "invalid cfg"
  in
  f name true [] insns
  |> List.map (fun (name, global, insns, term) ->
         let head = List.map (compile_insn ctxt asn) insns |> List.flatten in
         let tail = compile_terminator ctxt asn term in
         { lbl = S.name name; global; asm = Text (pro @ head @ tail) })

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

let compile_prog ({ tdecls; gdecls; fdecls; _ } : Ll.prog) : prog =
  let g (lbl, gdecl) = Asm.data (mangle lbl) (compile_gdecl gdecl) in
  let f (name, fdecl) = compile_fdecl tdecls name fdecl in
  List.map g gdecls @ List.concat (List.map f fdecls)