open Common

let def t (ins : Cfg.insn) idx =
  match ins with
  | Label _ -> t
  | Insn (Some dop, _) -> Symbol.ST.add dop idx t
  | Insn (None, _) -> t
  | Term _ -> t

let use t (insn : Cfg.insn) idx =
  (* FIXME: combine with use in lva.ml *)
  let op o s = match o with Ll.Id i -> Symbol.ST.add i idx s | _ -> s in
  match insn with
  | Label _ -> t
  | Insn (_, Binop (_, _, lop, rop)) -> op lop t |> op rop
  | Insn (_, Alloca _) -> t
  | Insn (_, AllocaN (_, (_, o))) -> op o t
  | Insn (_, Load (_, o)) -> op o t
  | Insn (_, Store (_, sop, dop)) -> op sop t |> op dop
  | Insn (_, Icmp (_, _, lop, rop)) -> op lop t |> op rop
  | Insn (_, Call (_, _, args)) ->
      List.map snd args |> List.fold_left (fun s e -> op e s) t
  | Insn (_, Bitcast (_, sop, _)) -> op sop t
  | Insn (_, Gep (_, bop, ops)) ->
      List.map snd ops |> List.fold_left (fun s o -> op o s) (op (snd bop) t)
  | Insn (_, Zext (_, sop, _)) -> op sop t
  | Insn (_, Sext (_, sop, _)) -> op sop t
  | Insn (_, Ptrtoint (_, sop, _)) -> op sop t
  | Insn (_, Trunc (_, sop, _)) -> op sop t
  | Insn (_, PhiNode (_, ops)) ->
      List.map fst ops |> List.fold_left (fun s e -> op e s) t
  | Insn (_, Select (o, (_, o1), (_, o2))) -> op o t |> op o1 |> op o2
  | Term (Ret (_, Some sop)) -> op sop t
  | Term (Ret (_, None)) -> t
  | Term (Br _) -> t
  | Term (Cbr (c, _, _)) -> op c t
  | Term (Switch (_, o, _, _)) -> op o t
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
  print_intervals insns intervals;
  intervals

let intervals insns (in_, out) =
  let insn (starts, t, active) (i, n) =
    Printf.printf "%s\n" (Cfg.string_of_insn n);
    (* init ins and outs if not present *)
    let init s (added, t, active) =
      ( S.SS.filter (fun s -> not (S.ST.mem s t)) s |> S.SS.union added,
        S.SS.fold
          (fun s t ->
            S.ST.update s
              (function
                | Some j ->
                    active.(i) <- S.SS.add s active.(i);
                    active.(j) <- S.SS.remove s active.(j);
                    Some i
                | None ->
                    active.(i) <- S.SS.add s active.(i);
                    Some i)
              t)
          s t,
        active )
    in
    (* set latest use in outs *)
    let end_ s (added, t, active) =
      ( S.SS.filter (fun s -> not (S.ST.mem s t)) s |> S.SS.union added,
        S.SS.fold
          (fun s t ->
            S.ST.update s
              (function
                | Some j ->
                    active.(i) <- S.SS.add s active.(i);
                    active.(j) <- S.SS.remove s active.(j);
                    Some i
                | None -> Some i)
              t)
          s t,
        active )
    in
    let a, t, c =
      init in_.(i) (S.SS.empty, t, active) |> init out.(i) |> end_ out.(i)
    in
    ((i, n, a) :: starts, t, c)
  in
  let starts, _t, active =
    List.fold_left insn
      ([], S.ST.empty, Array.init (List.length insns) (Fun.const S.SS.empty))
      insns
  in
  List.rev starts |> List.map (fun (i, n, a) -> (i, n, a, active.(i)))

let linearscan insns _asn _is =
  let insn (assign, active) (_i, _n) = (assign, active) in
  List.fold_left insn (S.ST.empty, S.ST.empty) insns

let alloc k insns d =
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let _avail = Regs.of_list (List.init k reg_of_int) in
  let intervals = intervals insns d in
  List.iter
    (fun (i, _n, s, e) ->
      Printf.printf "%d: %s\t{ " i "";
      (*(Cfg.string_of_insn n);*)
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) s;
      Printf.printf "}\t{ ";
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) e;
      Printf.printf "}\n")
    intervals;
  (*S.ST.iter (fun k (b, e) -> Printf.printf "%s: (%d, %d)\n" (S.name k) b e) is;*)
  let insn t _i = t in
  List.fold_left insn S.ST.empty insns
