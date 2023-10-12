open Graph

module G = Imperative.Graph.Abstract (struct
  type t = int * int
end)

let cfg_of_prog (_ : Ll.prog) : int = 2
