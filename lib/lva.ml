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
  | Insn (_, Load (_, o)) -> op o empty
  | Insn (_, Store (_, sop, dop)) -> op sop empty |> op dop
  | Insn (_, Icmp (_, _, lop, rop)) -> op lop empty |> op rop
  | Insn (_, Call (_, _, args)) ->
      List.map snd args |> List.fold_left (fun s e -> op e s) empty
  | Insn (_, Bitcast (_, sop, _)) -> op sop empty
  | Insn (_, Gep (_, bop, ops)) ->
      List.fold_left (fun s o -> op o s) (op bop empty) ops
  | Insn (_, Zext (_, sop, _)) -> op sop empty
  | Insn (_, Ptrtoint (_, sop, _)) -> op sop empty
  | Insn (_, Trunc (_, sop, _)) -> op sop empty
  | Insn (_, PhiNode (_, ops)) ->
      List.map fst ops |> List.fold_left (fun s e -> op e s) empty
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
  let rec dataflow (in_ : S.SS.t array) (out : S.SS.t array) =
    (*print insns ids g in_ out;
      Printf.printf "\n";*)
    let in' = Array.copy in_ in
    let out' = Array.copy out in
    let (in_, out) : S.set array * S.set array =
      List.fold_left
        (fun (in_, out) (i, insn) ->
          (*Printf.printf " def=%s, use=%s\n"
            (printset (def insn))
            (printset (use insn));*)
          (*Printf.printf "  in[%d] = %s, " i (printset in_.(i));*)
          in_.(i) <- S.SS.union (use insn) (S.SS.diff out.(i) (def insn));
          (*Printf.printf "in[%d] = %s\n" i (printset in_.(i));
            Printf.printf "  out[%d] = %s,\n" i (printset in_.(i));*)
          out.(i) <-
            (let succ = Cfg.G.succ g ids.(i) in
             List.fold_left
               (fun s v ->
                 (*Printf.printf "    adding succ[%d] %s to %d\n"
                   (Cfg.G.V.label v)
                   (printset in_.(Cfg.G.V.label v))
                   i;*)
                 S.SS.union s in_.(Cfg.G.V.label v))
               S.SS.empty succ);
          (*Printf.printf "  out[%d] = %s\n" i (printset out.(i));*)
          (in_, out))
        (in_, out)
        (List.mapi (fun i v -> (i, v)) insns)
    in
    if Array.for_all2 S.SS.equal in_ in' && Array.for_all2 S.SS.equal out out'
    then (in', out')
    else dataflow in_ out
  in
  dataflow
    (Array.init (List.length insns) (fun _ -> S.SS.empty))
    (Array.init (List.length insns) (fun _ -> S.SS.empty))

open Graph

module G = Imperative.Graph.Abstract (struct
  type t = S.symbol
end)

module Display = struct
  include G

  let vertex_name v = S.name (V.label v)
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
        let v : G.vertex = G.V.create s in
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
