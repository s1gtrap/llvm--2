let def (insn : Cfg.insn) =
  let empty = Symbol.SS.empty in
  match insn with
  | Label _ -> empty
  | Insn (Some dop, _) -> Symbol.SS.add dop empty
  | Insn (None, _) -> empty
  | Term _ -> empty

let use (insn : Cfg.insn) =
  let empty = Symbol.SS.empty in
  let op o s = match o with Ll.Id i -> Symbol.SS.add i s | _ -> s in
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
  | _ -> failwith ""

let dataflow (insns : Cfg.insn list) (ids : Cfg.G.V.t array) (g : Cfg.G.t) =
  let rec dataflow (in_ : Symbol.SS.t array) (out : Symbol.SS.t array) =
    let ((in', out') : Symbol.set array * Symbol.set array) =
      List.fold_left
        (fun (in_, out) (i, insn) ->
          (*let in_ = in_.(i) in
            let out = out.(i) in*)
          in_.(i) <-
            Symbol.SS.union (use insn) (Symbol.SS.diff out.(i) (def insn));
          out.(i) <-
            (let succ = Cfg.G.succ g ids.(i) in
             List.fold_left
               (fun s v -> Symbol.SS.union s in_.(Cfg.G.V.label v))
               Symbol.SS.empty succ);
          (in_, out))
        (in_, out)
        (List.mapi (fun i v -> (i, v)) insns)
    in
    if in_ = in' && out = out' then (in', out') else dataflow in' out'
  in
  dataflow
    (Array.init (List.length insns) (fun _ -> Symbol.SS.empty))
    (Array.init (List.length insns) (fun _ -> Symbol.SS.empty))
