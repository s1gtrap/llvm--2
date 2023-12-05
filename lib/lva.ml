module S = Symbol

let def (insn : Cfg.insn) =
  let empty = S.SS.empty in
  match insn with
  | Label _ -> empty
  | Insn (Some dop, _) -> S.SS.add dop empty
  | Insn (None, _) -> empty
  | Term _ -> empty

let use (insn : Cfg.insn) =
  let empty = S.SS.empty in
  let op o s = match o with Ll.Id i -> S.SS.add i s | _ -> s in
  match insn with
  | Label _ -> empty
  | Insn (_, Binop (_, _, lop, rop)) -> op lop empty |> op rop
  | Insn (_, Alloca _) -> empty
  | Insn (_, AllocaN (_, (_, o))) -> op o empty
  | Insn (_, Load (_, o)) -> op o empty
  | Insn (_, Store (_, sop, dop)) -> op sop empty |> op dop
  | Insn (_, Icmp (_, _, lop, rop)) -> op lop empty |> op rop
  | Insn (_, Call (_, _, args)) ->
      List.map snd args |> List.fold_left (fun s e -> op e s) empty
  | Insn (_, Bitcast (_, sop, _)) -> op sop empty
  | Insn (_, Gep (_, bop, ops)) ->
      List.fold_left (fun s o -> op o s) (op bop empty) ops
  | Insn (_, Zext (_, sop, _)) -> op sop empty
  | Insn (_, Sext (_, sop, _)) -> op sop empty
  | Insn (_, Ptrtoint (_, sop, _)) -> op sop empty
  | Insn (_, Trunc (_, sop, _)) -> op sop empty
  | Insn (_, PhiNode (_, ops)) ->
      List.map fst ops |> List.fold_left (fun s e -> op e s) empty
  | Insn (_, Select (o, (_, o1), (_, o2))) -> op o empty |> op o1 |> op o2
  | Term (Ret (_, Some sop)) -> op sop empty
  | Term (Ret (_, None)) -> empty
  | Term (Br _) -> empty
  | Term (Cbr (c, _, _)) -> op c empty
  | Term Unreachable -> empty
  | _ -> failwith (Cfg.string_of_insn insn)

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
  let numinsns = List.mapi (fun i v -> (i, v)) insns |> List.rev in
  let in_ = Array.init (List.length insns) (fun _ -> S.SS.empty) in
  let out = Array.init (List.length insns) (fun _ -> S.SS.empty) in
  let rec dataflow () =
    let changed =
      List.fold_left
        (fun changed (i, insn) ->
          let newout =
            let succ = Cfg.G.succ g ids.(i) in
            List.fold_left
              (fun s v -> S.SS.union s in_.(Cfg.G.V.label v))
              S.SS.empty succ
          in
          let outchanged = not (S.SS.equal newout out.(i)) in
          if outchanged then out.(i) <- newout;
          let newin = S.SS.union (use insn) (S.SS.diff out.(i) (def insn)) in
          let inchanged = not (S.SS.equal newin in_.(i)) in
          if inchanged then in_.(i) <- newin;
          changed || inchanged || outchanged)
        false numinsns
    in
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
  List.map def insns |> List.iter (S.SS.iter (fun v -> ignore (vert v)));
  List.iteri
    (fun i n ->
      let d = def n in
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

let prefer (insns : Cfg.insn list) : S.SS.t list =
  let l : S.SS.t list =
    let func = function
      | Cfg.Insn (Some o1, Ll.PhiNode (_, ops)) ->
          Some
            (List.map fst ops
            |> List.fold_left
                 (fun set ins ->
                   match ins with Ll.Id op -> S.SS.add op set | _ -> set)
                 (S.SS.add o1 S.SS.empty))
      | _ -> None
    in
    List.filter_map func insns
  in
  l

let coalesce_briggs (prefs : S.SS.t list) ((l, g) : G.V.t S.ST.t * G.t) :
    G.V.t S.table * G.t =
  let _str v =
    "\"{ " ^ Ll.mapcat ", " S.name (G.V.label v |> S.SS.elements) ^ " }\""
  in
  let coalesce ops (ol, g) =
    let g' = G.create () in
    let _, l' =
      G.fold_vertex
        (fun v (added, l) ->
          if S.SS.inter ops (G.V.label v) |> S.SS.is_empty then (
            let v' = G.V.create (G.V.label v) in
            G.add_vertex g' v';
            G.iter_succ
              (fun v2 ->
                match S.ST.find_opt (S.SS.choose (G.V.label v2)) l with
                | Some v2' -> G.add_edge g' v' v2'
                | None -> ())
              g v;
            (added, S.SS.fold (fun o a -> S.ST.add o v' a) (G.V.label v') l))
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
  in
  (* FIXME: check if degree is < k *)
  List.fold_left (fun acc ops -> coalesce ops acc) (l, g) prefs

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
