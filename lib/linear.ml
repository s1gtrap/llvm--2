open Common
open X86
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
          Printf.printf "%s\n" (S.name e);
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

let rec expire i (avail, active, assign, incstart, incend) =
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
        (*S.SS.iter (fun e -> Printf.printf "%s is now expired\n" (S.name e)) end_;*)
        (* might need to expite individually *)
        let incend' = IT.remove j incend in
        expire i (avail', active', assign, incstart, incend')
  | None -> (avail, active, assign, incstart, incend)

let rec linearscan lengths insns spills (avail, active, assign, incstart, incend)
    =
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
      (*Printf.printf "%s is now active\n" (S.name e);*)
      let ss' = S.SS.remove e ss in
      let incstart' =
        if S.SS.is_empty ss' then IT.remove i incstart
        else IT.add i ss' incstart
      in
      let spills, (avail', active', assign, incstart', incend') =
        match Regs.choose_opt avail with
        | Some reg ->
            ( spills,
              expire i
                ( Regs.remove reg avail,
                  S.ST.add e reg active,
                  S.ST.add e (Reg reg) assign,
                  incstart',
                  incend ) )
        | None ->
            let _, spill =
              IT.filter
                (fun _k v -> S.SS.exists (fun e -> S.ST.mem e active) v)
                lengths
              |> IT.min_binding
            in
            let spill = S.SS.find_first (fun e -> S.ST.mem e active) spill in
            let reg = S.ST.find spill active in
            (*Printf.printf "want to spill %s\n" (S.name spill);*)
            (* spill *)
            ( spills + 1,
              expire i
                ( Regs.add reg avail,
                  S.ST.remove spill active,
                  S.ST.add e (stack spills) assign,
                  incstart',
                  incend ) )
      in
      linearscan lengths insns spills
        (avail', active', assign, incstart', incend')
  | None -> expire (List.length insns) (avail, active, assign, incstart, incend)

let alloc k insns (in_, out) =
  let avail = List.init k reg_of_int |> Regs.of_list in
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let incstart, starts, _st2 = intervalstart insns (in_, out) in
  let starts = S.SS.fold (fun e s -> S.ST.add e 0 s) in_.(0) starts in
  let incstart =
    IT.update 0
      (function
        | Some ss -> Some (S.SS.union ss in_.(0)) | None -> Some in_.(0))
      incstart
  in
  let (incend, lengths, _st2) : _ * S.SS.t IT.t * _ =
    intervalends insns starts (in_, out)
  in
  (*Printf.printf "lenghts:\n";
    IT.iter (fun k v -> Printf.printf "  %d: %s\n" k (sos v)) lengths;*)
  let _, _, asn, _, _ =
    linearscan lengths insns 0 (avail, S.ST.empty, S.ST.empty, incstart, incend)
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
