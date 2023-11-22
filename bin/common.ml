type compiler = Clang | Tiger | Llvm__2 of Llvm__2.Regalloc.allocator

let string_of_compiler = function
  | Clang -> "clang"
  | Tiger -> "tiger"
  | Llvm__2 a -> Llvm__2.Regalloc.string_of_allocator a
