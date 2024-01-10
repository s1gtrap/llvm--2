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

let indices (((entrylbl, head), tail) : Ll.cfg) : G.V.t array =
  let off = match entrylbl with Some _ -> 1 | None -> 0 in
  let off = off + List.length head.insns + 1 in
  let insns (b : Ll.block) = b.insns in
  let tail = List.map snd tail |> List.map insns |> List.map List.length in
  let len = List.fold_left ( + ) off tail in
  let len = len + (2 * List.length tail) in
  Array.init len G.V.create

let blocks ids (((entrylbl, head), tail) : Ll.cfg) : G.V.t S.table =
  let f (i, t) ((n, b) : _ * Ll.block) =
    (i + List.length b.insns + 2, S.enter (t, n, ids.(i + 1)))
  in
  let off, blk =
    match entrylbl with
    | Some e -> (1, S.ST.add e ids.(0) S.ST.empty)
    | None -> (0, S.ST.empty)
  in
  snd (List.fold_left f (off + List.length head.insns + 1, blk) tail)

let flatten ((head, tail) : Ll.cfg) : insn list =
  let label l = Label l and insn i = Insn i in
  let block (b : Ll.block) = List.map insn b.insns @ [ Term b.terminator ] in
  let named_opt (n, b) = (Option.map label n |> Option.to_list) @ block b in
  let named (n, b) = Label n :: block b in
  named_opt head @ (List.map named tail |> List.flatten)

let graph ((head, tail) : Ll.cfg) : G.V.t array * G.t =
  let insns = flatten (head, tail) |> List.mapi (fun i n -> (i, n)) in
  let verts = Array.init (List.length insns) G.V.create in
  let addbl t = function i, Label l -> S.ST.add l verts.(i + 1) t | _ -> t in
  let blocks = List.fold_left addbl S.ST.empty insns in
  let g = G.create () in
  Array.iter (G.add_vertex g) verts;
  let addterm i = function
    | Ll.Ret _ -> ()
    | Br lbl -> G.add_edge g verts.(i) (S.ST.find lbl blocks)
    | Cbr (_, l1, l2) ->
        G.add_edge g verts.(i) (S.ST.find l1 blocks);
        G.add_edge g verts.(i) (S.ST.find l2 blocks)
    | _ -> failwith ""
  in
  let addedges = function
    | _, Label _ -> ()
    | i, Insn _ -> G.add_edge g verts.(i) verts.(i + 1)
    | i, Term term -> addterm i term
  in
  List.iter addedges insns;
  (verts, g)
