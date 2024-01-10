module S = Symbol
module Ints = Set.Make (Int)

let sos s = Ll.mapcat "," S.name (S.SS.elements s)
