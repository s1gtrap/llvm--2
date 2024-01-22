module S = Symbol

let def (s : S.SS.t) (insn : Cfg.insn) =
  match insn with Insn (Some dop, _) -> S.SS.add dop s | _ -> s

let use (s : S.SS.t) (insn : Cfg.insn) =
  let op o s = match o with Ll.Id i -> S.SS.add i s | _ -> s in
  let po = Fun.flip op in
  match insn with
  | Label _ | Insn (_, (Alloca _ | Comment _)) -> s
  | Insn (_, AllocaN (_, (_, o)))
  | Insn (_, Bitcast (_, o, _))
  | Insn (_, Load (_, o))
  | Insn (_, Ptrtoint (_, o, _))
  | Insn (_, Sext (_, o, _))
  | Insn (_, Trunc (_, o, _))
  | Insn (_, Zext (_, o, _)) ->
      op o s
  | Insn (_, Binop (_, _, l, r))
  | Insn (_, Icmp (_, _, l, r))
  | Insn (_, Store (_, l, r)) ->
      op l s |> op r
  | Insn (_, Call (_, _, args)) -> List.map snd args |> List.fold_left po s
  | Insn (_, Gep (_, bop, ops)) ->
      List.map snd ops |> List.fold_left po (op (snd bop) s)
  | Insn (_, Select (c, (_, l), (_, r))) -> op c s |> op l |> op r
  | Insn (_, PhiNode (_, _ops)) -> s
  | Term (Ret (_, Some o) | Cbr (o, _, _) | Switch (_, o, _, _)) -> op o s
  | Term (Ret (_, None) | Unreachable | Br _) -> s

let use (s : S.SS.t) (insn : Ll.insn) =
  let op o s = match o with Ll.Id i -> S.SS.add i s | _ -> s in
  let po = Fun.flip op in
  match insn with
  | Alloca _ | Comment _ -> s
  | AllocaN (_, (_, o))
  | Bitcast (_, o, _)
  | Load (_, o)
  | Ptrtoint (_, o, _)
  | Sext (_, o, _)
  | Trunc (_, o, _)
  | Zext (_, o, _) ->
      op o s
  | Binop (_, _, l, r) | Icmp (_, _, l, r) | Store (_, l, r) -> op l s |> op r
  | Call (_, _, args) -> List.map snd args |> List.fold_left po s
  | Gep (_, bop, ops) -> List.map snd ops |> List.fold_left po (op (snd bop) s)
  | Select (c, (_, l), (_, r)) -> op c s |> op l |> op r
  | PhiNode (_, _ops) -> s

let printset s =
  let sos s = Ll.mapcat "," S.name (S.SS.elements s) in
  Printf.sprintf "{%s}" (sos s)

let print (insns : Cfg.insn list) (_ids : Cfg.G.V.t array) (_g : Cfg.G.t)
    (in_ : S.SS.t array) (out : S.SS.t array) =
  Printf.printf "in\tout\n";
  List.iteri
    (fun i n ->
      let sos s = Ll.mapcat "," S.name (S.SS.elements s) in
      Printf.printf "{%s}\t{%s}\t%s\n"
        (sos in_.(i))
        (sos out.(i))
        (Cfg.string_of_insn n))
    insns;
  ()

let dataflow (_insns : Cfg.insn list) (_ids : Cfg.G.V.t array) ?(v = 0)
    ?(r = false) (_g : Cfg.G.t) =
  let _ = (v, r) in
  failwith ""

let dataflow2 (((hname, head), tail) : Ll.cfg) (_ids, _g) =
  let len = List.length head.insns + 1 in
  let len =
    List.fold_left
      (fun a ((_, b) : _ * Ll.block) -> a + List.length b.insns + 1)
      len tail
  in
  let in_ = Fun.const S.SS.empty |> Array.init len in
  let out = Fun.const S.SS.empty |> Array.init len in
  let phis source target =
    let ({ insns; _ } : Ll.block) =
      if Some target = hname then head
      else List.find (fun (name, _) -> name = target) tail |> snd
    in
    List.filter_map
      (function
        | _, Ll.PhiNode (_, ops) ->
            List.find_map
              (function Ll.Id id, l when source = l -> Some id | _ -> None)
              ops
        | _ -> None)
      insns
    |> S.SS.of_list
  in
  let rec dataflow () =
    let rec block (changed, i) : _ * Ll.block -> _ = function
      | name, ({ insns = (def, ins) :: intail; _ } as b) ->
          let use = use S.SS.empty ins in
          let def =
            Option.map S.SS.singleton def |> Option.value ~default:S.SS.empty
          in
          let in' = S.SS.diff out.(i) def |> S.SS.union use in
          let inchanged = S.SS.equal in_.(i) in' |> not in
          if inchanged then in_.(i) <- in';
          let out' = in_.(i + 1) in
          let outchanged = S.SS.equal out.(i) out' |> not in
          if outchanged then out.(i) <- out';
          let changed = changed || inchanged || outchanged in
          block (changed, i + 1) (name, { b with insns = intail })
      | name, { insns = []; terminator } ->
          let _, blocks =
            List.fold_left_map
              (fun a ((n, b) : _ * Ll.block) ->
                (a + List.length b.insns + 1, (a, n, b)))
              (List.length head.insns + 1)
              tail
          in
          let find l = List.find (fun (_, n, _) -> n = l) blocks in
          let use =
            match terminator with
            | Ret (_, Some (Id o)) -> S.SS.singleton o
            | Cbr (Id o, _, _) -> S.SS.singleton o
            | _ -> S.SS.empty
          in
          let in' = S.SS.union use out.(i) in
          let inchanged = S.SS.equal in_.(i) in' |> not in
          if inchanged then in_.(i) <- in';
          let out' =
            match terminator with
            | Br l ->
                let lin, _, _ = find l in
                S.SS.union in_.(lin) (phis name l)
            | Cbr (_, l, r) ->
                let lin, _, _ = find l and rin, _, _ = find r in
                Printf.printf "%d %d\n" lin rin;
                S.SS.union in_.(lin) in_.(rin)
                |> S.SS.union (phis name l)
                |> S.SS.union (phis name r)
            | _ -> S.SS.empty
          in
          let outchanged = S.SS.equal out.(i) out' |> not in
          if outchanged then out.(i) <- out';
          (changed || inchanged || outchanged, i + 1)
    in
    let changed, i =
      block (false, 0) (Option.value hname ~default:(S.symbol ""), head)
    in
    let changed, _ = List.fold_left block (changed, i) tail in
    if changed then dataflow () else (in_, out)
  in
  dataflow ()

open Graph

module G = Imperative.Graph.Abstract (struct
  type t = S.SS.t
end)

module Display = struct
  include G

  let vertex_name v =
    "\"{ " ^ Ll.mapcat ", " S.name (G.V.label v |> S.SS.elements) ^ " }\""

  let graph_attributes _ = []
  let default_vertex_attributes _ = []
  let vertex_attributes _ = []
  let default_edge_attributes _ = []
  let edge_attributes _ = []
  let get_subgraph _ = None
end

module Dot_ = Graphviz.Neato (Display)

let dot g =
  Dot_.fprint_graph Format.str_formatter g;
  Format.flush_str_formatter ()

let vert g e t =
  match S.ST.find_opt e t with
  | Some v -> (v, t)
  | None ->
      let v = S.SS.add e S.SS.empty |> G.V.create in
      G.add_vertex g v;
      (v, S.ST.add e v t)

let interf (params : Ll.uid list) (insns : Cfg.insn list) _ (out : S.SS.t array)
    =
  let g = G.create () in
  let vert2 t e = vert g e t |> snd and vert3 e t = vert g e t |> snd in
  let edge s1 s2 t =
    let v1, t = vert g s1 t in
    let v2, t = vert g s2 t in
    if v1 <> v2 then G.add_edge g v1 v2;
    t
  in
  let t = List.fold_left vert2 S.ST.empty params in
  let param t p1 =
    let param t p2 = if p1 <> p2 then edge p1 p2 t else t in
    List.fold_left param t params
  in
  let t = List.fold_left param t params in
  let setverts t s = S.SS.fold vert3 s t in
  let t = List.map (def S.SS.empty) insns |> List.fold_left setverts t in
  let ids = function Ll.Id id -> Some id | _ -> None in
  let defoutedges t (i, n) =
    let defs = def S.SS.empty n in
    let out =
      match n with
      | Cfg.Insn (_, Ll.PhiNode (_, ops)) ->
          List.map fst ops |> List.filter_map ids |> S.SS.of_list
          |> S.SS.diff out.(i)
      | _ -> out.(i)
    in
    let outedge e1 t = S.SS.fold (edge e1) out t in
    S.SS.fold outedge defs t
  in
  let t = List.mapi (fun i n -> (i, n)) insns |> List.fold_left defoutedges t in
  (t, g)

module VS = Set.Make (G.V)
module VT = Map.Make (G.V)

(*let coalesce _k ops (ol, g) =
    let g' = G.create () in
    let _, l' =
      G.fold_vertex
        (fun v (added, l) ->
          if S.SS.inter ops (G.V.label v) |> S.SS.is_empty then (
            S.SS.iter (fun o -> Printf.printf "%s " (S.name o)) (G.V.label v);
            Printf.printf "\n";

            let v' = G.V.create (G.V.label v) in
            G.add_vertex g' v';
            G.iter_succ
              (fun v2 ->
                match S.ST.find_opt (S.SS.choose (G.V.label v2)) l with
                | Some v2' -> G.add_edge g' v' v2'
                | None -> ())
              g v;
            ( added,
              S.SS.fold
                (fun o a ->
                  Printf.printf "adding %s\n" (S.name o);
                  S.ST.add o v' a)
                (G.V.label v') l ))
          else if not added then (
            let v' = G.V.create ops in
            G.add_vertex g' v';
            S.SS.iter
              (fun op ->
                let v = S.ST.find op ol in
                G.iter_succ
                  (fun v2 ->
                    match S.ST.find_opt (S.SS.choose (G.V.label v2)) l with
                    | Some v2' -> G.add_edge g' v' v2'
                    | None -> ())
                  g v)
              ops;
            (true, S.SS.fold (fun o a -> S.ST.add o v' a) ops l))
          else (added, l))
        g (false, S.ST.empty)
    in
    (l', g')
  in*)
(* FIXME: check if degree is < k *)

(*module GC = Imperative.Graph.Abstract (struct
    type t = S.SS.t
  end)

  module DisplayC = struct
    include GC

    let vertex_name v = Ll.mapcat ", " S.name (V.label v |> S.SS.elements)
    let graph_attributes _ = []
    let default_vertex_attributes _ = []
    let vertex_attributes _ = []
    let default_edge_attributes _ = []
    let edge_attributes _ = []
    let get_subgraph _ = None
  end

  module DotC_ = Graphviz.Neato (DisplayC)

  let dotc g =
    DotC_.fprint_graph Format.str_formatter g;
    Format.flush_str_formatter ()

  let interf_coalesced (param : Ll.uid list) (insns : Cfg.insn list)
      (in_ : S.SS.t array) (out : S.SS.t array) : G.V.t S.table * G.t =
    let verts, g = interf param insns in_ out in
    let copyvert v = GC.add_vertex ()
    let copyedge v1 v2
    G.iter_edges
    let gc = GC.create () in
    (verts, gc)*)
