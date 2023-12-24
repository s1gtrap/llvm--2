module S = Symbol

let def (s : S.SS.t) (insn : Cfg.insn) =
  match insn with Insn (Some dop, _) -> S.SS.add dop s | _ -> s

let use (s : S.SS.t) (insn : Cfg.insn) =
  let op o s = match o with Ll.Id i -> S.SS.add i s | _ -> s in
  let po s o = op o s in
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

let dataflow (insns : Cfg.insn list) (ids : Cfg.G.V.t array) (g : Cfg.G.t) =
  let insns = List.mapi (fun i v -> (i, v)) insns |> List.rev in
  let in_ = Array.init (List.length insns) (fun _ -> S.SS.empty) in
  let out = Array.init (List.length insns) (fun _ -> S.SS.empty) in
  let rec dataflow () =
    let flowout (i, _) =
      let newout =
        let succ = Cfg.G.succ g ids.(i) in
        List.fold_left
          (fun s v -> S.SS.union s in_.(Cfg.G.V.label v))
          S.SS.empty succ
      in
      let changed = not (S.SS.equal newout out.(i)) in
      if changed then out.(i) <- newout;
      changed
    in
    let flowin (i, insn) =
      let newin =
        S.SS.union (use S.SS.empty insn)
          (S.SS.diff out.(i) (def S.SS.empty insn))
      in
      let changed = not (S.SS.equal newin in_.(i)) in
      if changed then in_.(i) <- newin;
      changed
    in
    let flow changed insn = changed || flowout insn || flowin insn in
    if List.fold_left flow false insns then dataflow () else (in_, out)
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

let interf (param : Ll.uid list) (insns : Cfg.insn list) (_in_ : S.SS.t array)
    (out : S.SS.t array) : G.V.t S.table * G.t =
  let g = G.create () in
  let verts : G.vertex S.table ref = ref S.empty in
  let vert (s : S.symbol) : G.vertex =
    match S.ST.find_opt s !verts with
    | Some v -> v
    | None ->
        let v : G.vertex = G.V.create (S.SS.add s S.SS.empty) in
        G.add_vertex g v;
        verts := S.ST.add s v !verts;
        v
  in
  (* add all function parameters *)
  List.iter (fun s -> ignore (vert s)) param;
  (*S.SS.iter
    (fun i ->
      let _ = vert i in
      ())
    in_.(0);*)
  List.iter
    (fun p1 ->
      List.iter
        (fun p2 ->
          if p1 <> p2 then
            let v1 : G.V.t = vert p1 in
            let v2 : G.V.t = vert p2 in
            if v1 <> v2 then G.add_edge g v1 v2)
        param)
    param;
  (* add all defs *)
  List.map (def S.SS.empty) insns
  |> List.iter (S.SS.iter (fun v -> ignore (vert v)));
  List.iteri
    (fun i n ->
      let d = def S.SS.empty n in
      S.SS.iter
        (fun e1 ->
          S.SS.iter
            (fun e2 ->
              let v1 : G.V.t = vert e1 in
              let v2 : G.V.t = vert e2 in
              if v1 <> v2 then G.add_edge g v1 v2)
            out.(i))
        d;
      ())
    insns;
  (!verts, g)

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
