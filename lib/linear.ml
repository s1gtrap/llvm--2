let def t (ins : Cfg.insn) idx =
  match ins with
  | Label _ -> t
  | Insn (Some dop, _) ->
      Printf.printf "adding %s \n" (Symbol.name dop);
      Symbol.ST.add dop idx t
  | Insn (None, _) -> t
  | Term _ -> t

let use t (insn : Cfg.insn) idx =
  let op o s = match o with Ll.Id i -> Symbol.ST.add i idx s | _ -> s in
  match insn with
  | Label _ -> t
  | Insn (_, Binop (_, _, lop, rop)) -> op lop t |> op rop
  | Insn (_, Alloca _) -> t
  | Insn (_, Load (_, o)) -> op o t
  | Insn (_, Store (_, sop, dop)) -> op sop t |> op dop
  | Insn (_, Icmp (_, _, lop, rop)) -> op lop t |> op rop
  | Insn (_, Call (_, _, args)) ->
      List.map snd args |> List.fold_left (fun s e -> op e s) t
  | Insn (_, Bitcast (_, sop, _)) -> op sop t
  | Insn (_, Gep (_, bop, ops)) ->
      List.fold_left (fun s o -> op o s) (op bop t) ops
  | Insn (_, Zext (_, sop, _)) -> op sop t
  | Insn (_, Ptrtoint (_, sop, _)) -> op sop t
  | Insn (_, Trunc (_, sop, _)) -> op sop t
  | Insn (_, PhiNode (_, ops)) ->
      List.map fst ops |> List.fold_left (fun s e -> op e s) t
  | Term (Ret (_, Some sop)) -> op sop t
  | Term (Ret (_, None)) -> t
  | Term (Br _) -> t
  | Term (Cbr (c, _, _)) -> op c t
  | Term Unreachable -> t
  | _ -> failwith (Cfg.string_of_insn insn)

let print_intervals insns intervals =
  let variables = Symbol.ST.bindings intervals |> List.map fst in
  List.iteri
    (fun idx ins ->
      List.iter
        (fun k ->
          let livestart, liveend = Symbol.ST.find k intervals in
          if idx = livestart then Printf.printf ",-"
          else if livestart < idx && idx < liveend then Printf.printf "| "
          else if idx = liveend then Printf.printf "'-"
          else Printf.printf "  ")
        variables;
      Printf.printf "%s\n" (Cfg.string_of_insn ins))
    insns

let intervals params insns (_livein, _liveout) =
  let insns = List.filter (function Cfg.Label _ -> false | _ -> true) insns in
  let param t k = Symbol.ST.add k (-1) t in
  let defs = List.fold_left param Symbol.empty params in
  let uses = Symbol.empty in
  let rec intervals defs uses = function
    | idx, ins :: tail ->
        let defs = def defs ins idx in
        let uses = use uses ins idx in
        intervals defs uses (idx + 1, tail)
    | _, [] -> (defs, uses)
  in
  let defs, uses = intervals defs uses (0, insns) in
  let intervals =
    Symbol.ST.filter_map
      (fun k livestart ->
        Symbol.ST.find_opt k uses
        |> Option.map (fun liveend -> (livestart, liveend)))
      defs
  in
  intervals
