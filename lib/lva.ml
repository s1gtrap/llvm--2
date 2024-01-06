module S = Symbol

let def (s : S.SS.t) (insn : Cfg.insn) =
  match insn with Insn (Some dop, _) -> S.SS.add dop s | _ -> s

let use (s : S.SS.t) (insn : Cfg.insn) =
  let op o s = match o with Ll.Id i -> S.SS.add i s | _ -> s in
  let po = Fun.flip op in
  match insn with
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
  | Insn (_, PhiNode (_, ops)) -> List.map fst ops |> List.fold_left po s
  | Term (Ret (_, Some o) | Cbr (o, _, _)) -> op o s
  | _ -> s

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

let dataflow (insns : Cfg.insn list) (ids : Cfg.G.V.t array) ?(v = false)
    ?(r = false) (g : Cfg.G.t) =
  let insns = List.mapi (fun i v -> (i, v)) insns in
  let insns = if r then List.rev insns else insns in
  let in_ = Array.init (List.length insns) (Fun.const S.SS.empty) in
  let out = Array.init (List.length insns) (Fun.const S.SS.empty) in
  let changes = Array.init (List.length insns) (Fun.const []) in
  let rec dataflow () =
    let flowout (i, _) =
      let succ = Cfg.G.succ g ids.(i) in
      List.fold_left
        (fun s v -> S.SS.union s in_.(Cfg.G.V.label v))
        S.SS.empty succ
    in
    let flowin (i, insn) =
      S.SS.union (use S.SS.empty insn) (S.SS.diff out.(i) (def S.SS.empty insn))
    in
    let flow changed (i, insn) =
      let in' = flowin (i, insn) and out' = flowout (i, insn) in
      let ic = not (S.SS.equal in' in_.(i))
      and oc = not (S.SS.equal out' out.(i)) in
      if ic then in_.(i) <- in';
      if oc then out.(i) <- out';
      if v then changes.(i) <- (List.append changes.(i)) [ (in_.(i), out.(i)) ];
      changed || ic || oc
    in
    if List.fold_left flow false insns then dataflow () else (in_, out)
  in
  let flow = dataflow () in
  let printset s = Ll.mapcat "," S.name (S.SS.elements s) in
  if v then (
    Printf.printf "\\begin{NiceTabular}{|c|c c|%s|}\n"
      (Ll.mapcat "|" (Fun.const "c c") changes.(0));
    Printf.printf "  i & use & def & %s\\\\\n"
      (Ll.mapcat " & " (Fun.const "in & out") changes.(0));
    let printsets (s1, s2) = printset s1 ^ "  & " ^ printset s2 in
    let insns = if r then List.rev insns else insns in
    Array.to_list changes
    |> List.iteri (fun i c ->
           Printf.printf "%3d " i;
           let insn = List.nth insns i in
           Printf.printf " & %s"
             (printsets (use S.SS.empty (snd insn), def S.SS.empty (snd insn)));
           Printf.printf " & %s\\\\\n" (Ll.mapcat " & " printsets c));
    Printf.printf "\\end{NiceTabular}\n");
  flow

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

let interf (params : Ll.uid list) (insns : Cfg.insn list) _ (out : S.SS.t array)
    : G.V.t S.table * G.t =
  let g = G.create () in
  let vert (s : S.symbol) (t : G.vertex S.ST.t) : G.vertex * G.vertex S.ST.t =
    match S.ST.find_opt s t with
    | Some v -> (v, t)
    | None ->
        let v = S.SS.add s S.SS.empty |> G.V.create in
        G.add_vertex g v;
        (v, S.ST.add s v t)
  in
  let vert2 t s = vert s t |> snd and vert3 s t = vert s t |> snd in
  (* add params *)
  let t = List.fold_left vert2 S.ST.empty params in
  (* connect all params *)
  let edge v1 v2 t =
    let v1, t = vert v1 t in
    let v2, t = vert v2 t in
    if v1 <> v2 then G.add_edge g v1 v2;
    t
  in
  let param t p1 =
    let param t p2 = if p1 <> p2 then edge p1 p2 t else t in
    List.fold_left param t params
  in
  let t = List.fold_left param t params in
  (* add all defs *)
  let setverts t s = S.SS.fold vert3 s t in
  let t = List.map (def S.SS.empty) insns |> List.fold_left setverts t in
  let defoutedges t (i, n) =
    let defs = def S.SS.empty n in
    let outedge e1 t = S.SS.fold (edge e1) out.(i) t in
    S.SS.fold outedge defs t
  in
  (List.mapi (fun i n -> (i, n)) insns |> List.fold_left defoutedges t, g)

let prefer (insns : Cfg.insn list) : S.SS.t S.ST.t =
  (* FIXME: test phi nodes > 4 *)
  let l =
    let add (t : S.SS.t S.ST.t) ops =
      List.map (fun a -> List.map (fun b -> (a, b)) ops) ops
      |> List.flatten
      |> List.filter (fun ((_, n1), (_, n2)) -> n1 <> n2)
      |> List.fold_left
           (fun t (a, b) ->
             S.ST.update a
               (function
                 | Some s -> Some (S.SS.add b s)
                 | None -> Some (S.SS.add b S.SS.empty))
               t)
           t
    in
    let func (t : S.SS.t S.ST.t) = function
      | Cfg.Insn (Some o1, Ll.PhiNode (_, ops)) ->
          let ops =
            List.filter_map (function Ll.Id op, _ -> Some op | _ -> None) ops
          in
          add t (o1 :: ops)
      | Cfg.Insn (Some op, _) -> add t [ op ]
      | _ -> t
    in
    List.fold_left func S.ST.empty insns
  in
  l

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
