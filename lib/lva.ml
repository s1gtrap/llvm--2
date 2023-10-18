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
  | Insn (_, Gep (_, bop, ops)) ->
      List.fold_left (fun s o -> op o s) (op bop empty) ops
  | Insn (_, Zext (_, sop, _)) -> op sop empty
  | Insn (_, Ptrtoint (_, sop, _)) -> op sop empty
  | Insn (_, PhiNode (_, ops)) ->
      List.map fst ops |> List.fold_left (fun s e -> op e s) empty
  | Term (Ret (_, Some sop)) -> op sop empty
  | Term (Ret (_, None)) -> empty
  | Term (Br _) -> empty
  | Term (Cbr _) -> empty
  | Term Unreachable -> empty
  | _ -> failwith (Cfg.string_of_insn insn)

let print (insns : Cfg.insn list) (_ids : Cfg.G.V.t array) (_g : Cfg.G.t)
    (in_ : Symbol.SS.t array) (out : Symbol.SS.t array) =
  List.iteri
    (fun i n ->
      let sos s = Ll.mapcat "," Symbol.name (Symbol.SS.elements s) in
      Printf.printf "{%s}\t{%s}\t%s\n"
        (sos in_.(i))
        (sos out.(i))
        (Cfg.string_of_insn n))
    insns;
  ()

let dataflow (insns : Cfg.insn list) (ids : Cfg.G.V.t array) (g : Cfg.G.t) =
  let rec dataflow (in_ : Symbol.SS.t array) (out : Symbol.SS.t array) =
    print insns ids g in_ out;
    Printf.printf "\n";
    let in' = Array.copy in_ in
    let out' = Array.copy out in
    let ((in_, out) : Symbol.set array * Symbol.set array) =
      List.fold_left
        (fun (in_, out) (i, insn) ->
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
    if
      Array.for_all2 Symbol.SS.equal in_ in'
      && Array.for_all2 Symbol.SS.equal out out'
    then (in', out')
    else dataflow in_ out
  in
  dataflow
    (Array.init (List.length insns) (fun _ -> Symbol.SS.empty))
    (Array.init (List.length insns) (fun _ -> Symbol.SS.empty))
