open Graph

module S = Symbol

type reg =
  | Rax
  | Rcx
  | Rdx
  | Rbx
  (*| Rsp*)
  (*| Rbp*)
  | Rsi
  | Rdi

module C = Coloring.Mark(Lva.G)

let alloc (g : Lva.G.t) : reg S.table = 
  Printf.printf "%s\n" (Lva.dot g);
  C.coloring g 9;
  Printf.printf "%s\n" (Lva.dot g);
 S.empty
