module S = Symbol

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

module Regs = Set.Make (struct
  type t = reg

  let compare a b = compare a b
end)
