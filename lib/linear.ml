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

module IT = Map.Make (Int)

let intervalstart insns (_in_, out) =
  let insn (ordstarts, starts, active) (i, _n) =
    let newout = S.SS.diff out.(i) active in
    ( S.SS.fold
        (fun e a ->
          IT.update i
            (function
              | Some s -> Some (S.SS.add e s) | None -> Some (S.SS.singleton e))
            a)
        newout ordstarts,
      S.SS.fold (fun e a -> S.ST.add e i a) newout starts,
      S.SS.union active newout )
  in
  List.fold_left insn (IT.empty, S.ST.empty, S.SS.empty) insns

let intervalends insns starts (in_, _out) =
  let insn (i, _n) (ordstarts, lengths, active) =
    let newin = S.SS.diff in_.(i) active in
    ( S.SS.fold
        (fun e a ->
          IT.update i
            (function
              | Some s -> Some (S.SS.add e s) | None -> Some (S.SS.singleton e))
            a)
        newin ordstarts,
      S.SS.fold
        (fun e a ->
          IT.update
            (-i + S.ST.find e starts)
            (function
              | Some ss -> Some (S.SS.add e ss)
              | None -> Some (S.SS.singleton e))
            a)
        newin lengths,
      S.SS.union active newin )
  in
  List.fold_right insn insns (IT.empty, IT.empty, S.SS.empty)

let rec expire i (avail, active, incstart, incend) =
  (*Printf.printf "\nexpite\n";
    Printf.printf "active: %s\n" (sos active);
    Printf.printf "incstart:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incstart;
    Printf.printf "incend:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incend;
    Printf.printf "\n";*)
  match IT.min_binding_opt incend with
  | Some (j, end_) ->
      if j >= i then (avail, active, incstart, incend)
      else
        let avail', active' =
          S.SS.fold
            (fun k (avail, active) ->
              match S.ST.find_opt k active with
              | Some reg ->
                  let active' = S.ST.remove k active in
                  let avail' = Regs.add reg avail in
                  (avail', active')
              | None -> (avail, active))
            end_ (avail, active)
        in
        S.SS.iter (fun e -> Printf.printf "%s is now expired\n" (S.name e)) end_;
        (* might need to expite individually *)
        let incend' = IT.remove j incend in
        expire i (avail', active', incstart, incend')
  | None -> (avail, active, incstart, incend)

let rec linearscan lengths insns (avail, active, incstart, incend) =
  (*Printf.printf "\nlinearscan\n";
    Printf.printf "active: %s\n" (sos active);
    Printf.printf "incstart:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incstart;
    Printf.printf "incend:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incend;
    Printf.printf "\n";*)
  match IT.min_binding_opt incstart with
  | Some (i, ss) ->
      let e = S.SS.choose ss in
      Printf.printf "%s is now active\n" (S.name e);
      let ss' = S.SS.remove e ss in
      let incstart' =
        if S.SS.is_empty ss' then IT.remove i incstart
        else IT.add i ss' incstart
      in
      let avail', active', incstart', incend' =
        match Regs.choose_opt avail with
        | Some reg ->
            expire i
              (Regs.remove reg avail, S.ST.add e reg active, incstart', incend)
        | None ->
            let _, spill =
              IT.filter
                (fun _k v -> S.SS.exists (fun e -> S.ST.mem e active) v)
                lengths
              |> IT.min_binding
            in
            let spill = S.SS.find_first (fun e -> S.ST.mem e active) spill in
            let reg = S.ST.find spill active in
            Printf.printf "want to spill %s\n" (S.name spill);
            (* spill *)
            expire i
              (Regs.add reg avail, S.ST.remove spill active, incstart', incend)
      in
      linearscan lengths insns (avail', active', incstart', incend')
  | None -> expire (List.length insns) (avail, active, incstart, incend)

let alloc k insns (in_, out) =
  let avail = List.init k reg_of_int |> Regs.of_list in
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let incstart, starts, _st2 = intervalstart insns (in_, out) in
  let (incend, lengths, _st2) : _ * S.SS.t IT.t * _ =
    intervalends insns starts (in_, out)
  in
  Printf.printf "lenghts:\n";
  IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) lengths;
  let _, asn, _, _ =
    linearscan lengths insns (avail, S.ST.empty, incstart, incend)
  in
  S.ST.iter
    (fun k v -> Printf.printf "%s: %s\n" (S.name k) (string_of_reg v))
    asn;
  (*let intervals = intervals insns d in*)
  (*let _intervals = linearscan k insns d in*)
  (*List.iter
    (fun (i, _n, s, e) ->
      Printf.printf "%d: %s\t{ " i "";
      (*(Cfg.string_of_insn n);*)
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) s;
      Printf.printf "}\t{ ";
      S.SS.iter (fun s -> Printf.printf "%s " (S.name s)) e;
      Printf.printf "}\n")
    intervals;*)
  (*S.ST.iter
    (fun k v -> Printf.printf "%s: %s\n" (S.name k) (string_of_operand v))
    assign;*)
  (*S.ST.iter (fun k (b, e) -> Printf.printf "%s: (%d, %d)\n" (S.name k) b e) is;*)
  failwith "ok"
