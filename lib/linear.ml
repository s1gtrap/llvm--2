open Common
open X86

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

let intervals insns (in_, out) =
  let insn (starts, t, active) (i, n) =
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
  let starts, _, active =
    List.fold_left insn
      ([], S.ST.empty, Array.init (List.length insns) (Fun.const S.SS.empty))
      insns
  in
  List.rev starts |> List.map (fun (i, n, a) -> (i, n, a, active.(i)))

let linearscan k insns =
  let avail = Regs.of_list (List.init k reg_of_int) in
  let spill i = Ind3 (Lit (Int64.of_int ((i * -8) - 8)), Rbp) in
  let insn (avail, active, assign) (_, _n, s, _e) =
    (*Printf.printf "%s\n" (Cfg.string_of_insn n);*)
    let start s (avail, active, assign) =
      match Regs.choose_opt avail with
      | Some reg -> (Regs.remove reg avail, S.ST.add s reg active, assign)
      | None ->
          (* FIXME: order by remaining or total length *)
          let z, reg = S.ST.choose active in
          ( avail,
            S.ST.remove z active |> S.ST.add s reg,
            S.ST.add z (S.ST.cardinal assign |> spill) assign )
    in
    S.SS.fold start s (avail, active, assign)
  in
  let _, active, assign =
    List.fold_left insn (avail, S.ST.empty, S.ST.empty) insns
  in
  S.ST.fold (fun k v acc -> S.ST.add k (Reg v) acc) active assign

let alloc k insns d =
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let intervals = intervals insns d in
  (*List.iter
    (fun (i, _n, s, e) ->
      Printf.printf "%d: %s\t{ " i "";
      (*(Cfg.string_of_insn n);*)
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) s;
      Printf.printf "}\t{ ";
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) e;
      Printf.printf "}\n")
    intervals;*)
  let assign = linearscan k intervals in
  (*S.ST.iter
    (fun k v -> Printf.printf "%s: %s\n" (S.name k) (string_of_operand v))
    assign;*)
  (*S.ST.iter (fun k (b, e) -> Printf.printf "%s: (%d, %d)\n" (S.name k) b e) is;*)
  assign
