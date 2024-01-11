open Common
open X86
module IT = Map.Make (Int)

let intervalstart insns (in_, out) =
  let insn (ordstarts, starts, active) (i, _n) =
    let newout = S.SS.diff (S.SS.union in_.(i) out.(i)) active in
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

let intervalends insns starts (in_, out) =
  let insn (i, _n) (ordstarts, lengths, ends, active) =
    let newin = S.SS.diff (S.SS.union in_.(i) out.(i)) active in
    ( S.SS.fold
        (fun e a ->
          IT.update i
            (function
              | Some s -> Some (S.SS.add e s) | None -> Some (S.SS.singleton e))
            a)
        newin ordstarts,
      S.SS.fold
        (fun e a ->
          (*Printf.printf "%s\n" (S.name e);*)
          IT.update
            (-i + S.ST.find e starts)
            (function
              | Some ss -> Some (S.SS.add e ss)
              | None -> Some (S.SS.singleton e))
            a)
        newin lengths,
      S.SS.fold (fun e a -> S.ST.add e i a) newin ends,
      S.SS.union active newin )
  in
  List.fold_right insn insns (IT.empty, IT.empty, S.ST.empty, S.SS.empty)

let rec expire i (avail, active, assign, incstart, incend) =
  (*Printf.printf "\nexpite\n";
    Printf.printf "  avail: ";
    Regs.iter (fun r -> Printf.printf "%s " (string_of_reg r)) avail;
    Printf.printf "\n";
    Printf.printf "  active:\n";
    S.ST.iter
      (fun k v -> Printf.printf "    %s: %s\n" (S.name k) (string_of_reg v))
      active;
    Printf.printf "\n";*)
  (*Printf.printf "\nexpite\n";
    Printf.printf "active: %s\n" (sos active);
    Printf.printf "incstart:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incstart;
    Printf.printf "incend:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incend;
    Printf.printf "\n";*)
  match IT.min_binding_opt incend with
  | Some (j, end_) ->
      if j >= i then (avail, active, assign, incstart, incend)
      else
        let s = S.SS.choose end_ in
        (*Printf.printf "%s \n" (S.name s);*)
        let reg = S.ST.find s active in
        let active' = S.ST.remove s active in
        let avail' = Regs.add reg avail in
        (*Printf.printf "erase %s\n" (S.name s);*)
        (*S.SS.iter (fun e -> Printf.printf "%s is now expired\n" (S.name e)) end_;*)
        (* might need to expite individually *)
        let incend' = IT.remove j incend in
        expire i (avail', active', assign, incstart, incend')
  | None -> (avail, active, assign, incstart, incend)

let rec linearscan insns spills ?(v = 0)
    (lengths, avail, active, assign, incstart, incend) =
  if v >= 2 then (
    Printf.printf "\nlinearscan\n";
    Printf.printf "  avail: ";
    Regs.iter (fun r -> Printf.printf "%s " (string_of_reg r)) avail;
    Printf.printf "\n";
    Printf.printf "  active:\n";
    S.ST.iter
      (fun k v -> Printf.printf "    %s: %s\n" (S.name k) (string_of_reg v))
      active;
    Printf.printf "\n";
    Printf.printf "  incstart:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incstart;
    Printf.printf "  incend:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) incend;
    Printf.printf "\n");
  match IT.min_binding_opt incstart with
  | Some (i, ss) ->
      let e = S.SS.choose ss in
      (*Printf.printf "%s is now active\n" (S.name e);*)
      let ss' = S.SS.remove e ss in
      let incstart' =
        if S.SS.is_empty ss' then IT.remove i incstart
        else IT.add i ss' incstart
      in
      let spills, lengths', (avail', active', assign', incstart', incend') =
        match Regs.choose_opt avail with
        | Some reg ->
            (*Printf.printf "assign:" Printf.printf "  avail was %s\n"
              (string_of_reg reg);*)
            (*Printf.printf "assign %s to %s\n" (S.name e) (string_of_reg reg);
              Printf.printf "  avail is now ";*)
            (*Regs.iter
                (fun r -> Printf.printf "%s " (string_of_reg r))
                (Regs.remove reg avail);
              Printf.printf "\n";
                Printf.printf "  set %s to %s\n" (S.name e) (string_of_reg reg);*)
            ( spills,
              lengths,
              expire i
                ( Regs.remove reg avail,
                  S.ST.add e reg active,
                  S.ST.add e (Reg reg) assign,
                  incstart',
                  incend ) )
        | None ->
            let j, spill =
              IT.filter
                (fun _k v -> S.SS.exists (fun e -> S.ST.mem e active) v)
                lengths
              |> IT.min_binding
            in
            (*Printf.printf "  active:\n";*)
            (*S.ST.iter
                (fun k v ->
                  Printf.printf "    %s: %s\n" (S.name k) (string_of_reg v))
                active;
              Printf.printf "spill: %s\n" (sos spill);*)
            let spill =
              S.SS.filter
                (fun e ->
                  (*Printf.printf "    is %s a member of active?\n" (S.name e);*)
                  S.ST.mem e active)
                spill
              |> S.SS.choose
            in
            let reg = S.ST.find spill active in
            (*Printf.printf "want to spill %s\n" (S.name spill);
              Printf.printf "assign %s to %s\n" (S.name e) (string_of_reg reg);*)
            (* spill *)
            (*Printf.printf "spilled %s to %s\n" (S.name spill)
                  (stack spills |> string_of_operand);
                Printf.printf "assigned %s to %s\n" (S.name spill)
                  (string_of_reg reg);
              Printf.printf "  unset %s\n" (S.name spill);
              Printf.printf "  set %s to %s\n" (S.name spill)
                (string_of_operand (stack spills));*)
            let lengths' =
              IT.update j
                (function
                  | Some ss ->
                      (*Printf.printf "  removing %s from lengths\n"
                        (S.name spill);*)
                      let ss' = S.SS.remove spill ss in
                      if S.SS.is_empty ss' then None else Some ss'
                  | None -> None)
                lengths
            in
            let incend' =
              IT.filter_map
                (fun _ ss ->
                  let ss' = S.SS.remove spill ss in
                  if S.SS.is_empty ss' then None else Some ss')
                incend
            in
            (*Printf.printf "  set %s to %s\n" (S.name e) (string_of_reg reg);*)
            ( spills + 1,
              lengths',
              expire i
                ( avail,
                  S.ST.remove spill active |> S.ST.add e reg,
                  S.ST.remove spill assign
                  |> S.ST.add spill (stack spills)
                  |> S.ST.add e (Reg reg),
                  incstart',
                  incend' ) )
      in
      linearscan insns spills
        (lengths', avail', active', assign', incstart', incend')
  | None -> expire (List.length insns) (avail, active, assign, incstart, incend)

let print (insns : (_ * Cfg.insn) list) (in_, out) =
  let _, starts, _ = intervalstart insns (in_, out) in
  let _, _, ends, _ = intervalends insns starts (in_, out) in
  let ids = S.ST.bindings starts |> List.map fst in
  let print _ (i, n) =
    let print s =
      let start = S.ST.find s starts in
      let end_ = S.ST.find s ends in
      Printf.printf "%s"
        (if start = end_ then ""
         else if S.ST.find s starts = i then ".-"
         else if start <= i && i < end_ then "| "
         else if i = end_ then "'-"
         else "  ")
    in
    List.iter print ids;
    Printf.printf "%s\n" (Cfg.string_of_insn n)
  in
  List.iteri print insns

let alloc k insns ?(v = 0) (in_, out) =
  let avail = List.init k reg_of_int |> Regs.of_list in
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let incstart, starts, _st2 = intervalstart insns (in_, out) in
  let starts = S.SS.fold (fun e s -> S.ST.add e 0 s) in_.(0) starts in
  let incend, lengths, _, _ = intervalends insns starts (in_, out) in
  if v >= 2 then (
    Printf.printf "lenghts:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) lengths);
  let _, _, asn, _, _ =
    linearscan insns 0 ~v
      (lengths, avail, S.ST.empty, S.ST.empty, incstart, incend)
  in
  (*S.ST.iter
    (fun k v -> Printf.printf "%s: %s\n" (S.name k) (string_of_operand v))
    asn;*)
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
  asn
