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
  | Ax
  | Cx
  | Dx
  | Bx
  | Si
  | Di
  | R08w
  | R09w
  | R10w
  | R11w
  | R12w
  | R13w
  | R14w
  | R15w
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
  | Ax -> "%ax"
  | Cx -> "%cx"
  | Dx -> "%dx"
  | Bx -> "%bx"
  | Si -> "%si"
  | Di -> "%di"
  | R08w -> "%r8w"
  | R09w -> "%r9w"
  | R10w -> "%r10w"
  | R11w -> "%r11w"
  | R12w -> "%r12w"
  | R13w -> "%r13w"
  | R14w -> "%r14w"
  | R15w -> "%r15w"
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

module Regs = Set.Make (struct
  type t = reg

  let compare a b = compare a b
end)

type lbl = string

let string_of_lbl (l : lbl) : string = l

type quad = int64
type imm = Lit of quad | Lbl of lbl

let string_of_imm = function
  | Lit i -> Int64.to_string i
  | Lbl l -> string_of_lbl l

type operand =
  | Imm of imm (* immediate *)
  | Reg of reg (* register *)
  | Ind1 of imm (* indirect: displacement *)
  | Ind2 of reg (* indirect: (%reg) *)
  | Ind3 of (imm * reg)

let string_of_operand (oper : operand) : string =
  match oper with
  | Imm i -> "$" ^ string_of_imm i
  | Reg r -> string_of_reg r
  | Ind1 i -> string_of_imm i
  | Ind2 r -> "(" ^ string_of_reg r ^ ")"
  | Ind3 (i, r) -> string_of_imm i ^ "(" ^ string_of_reg r ^ ")"

let stack i = Ind3 (Lit (Int64.of_int ((i + 1) * -8)), Rbp)
