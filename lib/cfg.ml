open Graph
module S = Symbol

type insn =
  | Label of S.symbol
  | Insn of (Ll.uid option * Ll.insn)
  | Term of Ll.terminator

let string_of_insn = function
  | Label l -> Printf.sprintf "%s:" (S.name l)
  | Insn i -> Printf.sprintf "    %s" (Ll.string_of_named_insn i)
  | Term t -> Printf.sprintf "    %s" (Ll.string_of_terminator t)

module G = Imperative.Digraph.Abstract (struct
  type t = int
end)

module Display = struct
  include G

  let vertex_name v = string_of_int (V.label v)
  let graph_attributes _ = []
  let default_vertex_attributes _ = []
  let vertex_attributes _ = []
  let default_edge_attributes _ = []
  let edge_attributes _ = []
  let get_subgraph _ = None
end

module Dot_ = Graphviz.Dot (Display)

let parse = Parse.from_string Llparser.cfgeof

let dot g =
  Dot_.fprint_graph Format.str_formatter g;
  Format.flush_str_formatter ()

let indices ((head, tail) : Ll.cfg) : G.V.t array =
  let off = List.length head.insns + 1 in
  let insns (b : Ll.block) = b.insns in
  let tail = List.map snd tail |> List.map insns |> List.map List.length in
  let len = List.fold_left ( + ) off tail in
  let len = len + (2 * List.length tail) in
  Array.init len G.V.create

let blocks ids ((head, tail) : Ll.cfg) : G.V.t S.table =
  let f (i, t) ((n, b) : _ * Ll.block) =
    (i + List.length b.insns + 2, S.enter (t, n, ids.(i)))
  in
  snd (List.fold_left f (List.length head.insns + 1, S.empty) tail)

let graph ((head, tail) : Ll.cfg) : G.V.t array * G.t =
  let g = G.create () in
  let ids = indices (head, tail) in
  let blk = blocks ids (head, tail) in
  let blk l = S.ST.find l blk in
  let add i = G.add_vertex g i in
  List.iter add (Array.to_list ids);
  let _, tail =
    List.map snd tail
    |> List.fold_left_map
         (fun o (b : Ll.block) -> (o + List.length b.insns + 2, (o, b)))
         (List.length head.insns + 1)
  in
  let add_edge i j = G.add_edge g ids.(i) (blk j) in
  let f ((i, b) : _ * Ll.block) =
    for i = i to i + List.length b.insns - 1 do
      G.add_edge g ids.(i) ids.(i + 1)
    done;
    let i = i + List.length b.insns in
    match b with
    | { terminator = Ret _; _ } -> ()
    | { terminator = Br l; _ } -> add_edge i l
    | { terminator = Cbr (_, l, r); _ } ->
        add_edge i l;
        add_edge i r
    | { terminator = Unreachable; _ } -> ()
  in
  f (0, head);
  List.iter
    (fun ((i, b) : _ * Ll.block) ->
      G.add_edge g ids.(i) ids.(i + 1);
      let i = i + 1 in
      for i = i to i + List.length b.insns - 1 do
        G.add_edge g ids.(i) ids.(i + 1)
      done;
      let i = i + List.length b.insns in
      match b with
      | { terminator = Ret _; _ } -> ()
      | { terminator = Br l; _ } -> add_edge i l
      | { terminator = Cbr (_, l, r); _ } ->
          add_edge i l;
          add_edge i r
      | { terminator = Unreachable; _ } -> ())
    tail;
  (ids, g)

let%test "graph" =
  let cfg = parse "ret void" in
  let _ids, g = graph cfg in
  dot g = "digraph G {\n  1;\n  3;\n  \n  \n  1 -> 3;\n  \n  }\n"

let%test "graph" =
  let cfg = parse "    br label %a\na:\n    br label %b\nb:\n    ret void" in
  let _ids, g = graph cfg in
  dot g = "digraph G {\n  0;\n  1;\n  2;\n  3;\n  \n  \n  1 -> 3;\n  \n  }\n"

let flatten ((head, tail) : Ll.cfg) : insn list =
  let insn i = Insn i in
  let named_block ((n, b) : _ * Ll.block) =
    [ Label n ] @ List.map insn b.insns @ [ Term b.terminator ]
  in
  List.map insn head.insns @ [ Term head.terminator ]
  @ List.flatten (List.map named_block tail)
