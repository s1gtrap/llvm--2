module S = Symbol
module Ints = Set.Make (Int)

let sos s = Ll.mapcat "," S.name (S.SS.elements s)

type allocator =
  | Simple of int
  | Briggs of int
  | Greedy of int
  | Linearscan of int

let allocator_of_string n = function
  | s when String.starts_with ~prefix:s "simple" -> Simple n
  | s when String.starts_with ~prefix:s "briggs" -> Briggs n
  | s when String.starts_with ~prefix:s "greedy" -> Greedy n
  | s when String.starts_with ~prefix:s "linearscan" -> Linearscan n
  | "" -> Greedy 0 (* NOTE: default allocator *)
  | s -> failwith ("invalid allocator: " ^ s)

let string_of_allocator = function
  | Simple k -> "simple " ^ string_of_int k
  | Briggs k -> "briggs " ^ string_of_int k
  | Greedy k -> "greedy " ^ string_of_int k
  | Linearscan k -> "linear " ^ string_of_int k
