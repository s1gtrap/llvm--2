open Common
open X86
module IT = Map.Make (Int)

let add e = function
  | Some s -> Some (S.SS.add e s)
  | None -> Some (S.SS.singleton e)

let intervalstart insns (in_, out) =
  let insn (ordstarts, starts, active) (i, _n) =
    let out' = S.SS.diff (S.SS.union in_.(i) out.(i)) active in
    ( S.SS.fold (fun e a -> IT.update i (add e) a) out' ordstarts,
      S.SS.fold (fun e a -> S.ST.add e i a) out' starts,
      S.SS.union active out' )
  in
  List.fold_left insn (IT.empty, S.ST.empty, S.SS.empty) insns

let intervalends insns (in_, out) =
  let insn (i, _n) (ordends, ends, active) =
    let in' = S.SS.diff (S.SS.union in_.(i) out.(i)) active in
    ( S.SS.fold (fun e a -> IT.update i (add e) a) in' ordends,
      S.SS.fold (fun e a -> S.ST.add e i a) in' ends,
      S.SS.union active in' )
  in
  List.fold_right insn insns (IT.empty, S.ST.empty, S.SS.empty)

let rec expire i (avail, active, assign, incstart, incend) =
  match IT.min_binding_opt incend with
  | Some (j, end_) ->
      if j >= i then (avail, active, assign, incstart, incend)
      else
        let s = S.SS.choose end_ in
        let reg = S.ST.find s active in
        let active' = S.ST.remove s active in
        let avail' = Regs.add reg avail in
        let incend' = IT.remove j incend in
        expire i (avail', active', assign, incstart, incend')
  | None -> (avail, active, assign, incstart, incend)

let rec linearscan insns spills (avail, active, assign, incstart, incend) =
  match IT.min_binding_opt incstart with
  | Some (i, ss) ->
      let e = S.SS.choose ss in
      let ss' = S.SS.remove e ss in
      let incstart' =
        if S.SS.is_empty ss' then IT.remove i incstart
        else IT.add i ss' incstart
      in
      let spills, (avail', active', assign', incstart', incend') =
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
            let _j, spill =
              IT.filter
                (fun _k v -> S.SS.exists (fun e -> S.ST.mem e active) v)
                incend
              |> IT.max_binding
            in
            let spill =
              S.SS.filter (fun e -> S.ST.mem e active) spill |> S.SS.choose
            in
            let reg = S.ST.find spill active in
            let incend' =
              IT.filter_map
                (fun _ ss ->
                  let ss' = S.SS.remove spill ss in
                  if S.SS.is_empty ss' then None else Some ss')
                incend
            in
            ( spills + 1,
              expire i
                ( avail,
                  S.ST.remove spill active |> S.ST.add e reg,
                  S.ST.remove spill assign
                  |> S.ST.add spill (stack spills)
                  |> S.ST.add e (Reg reg),
                  incstart',
                  incend' ) )
      in
      linearscan insns spills (avail', active', assign', incstart', incend')
  | None -> expire (List.length insns) (avail, active, assign, incstart, incend)

let print (insns : (_ * Cfg.insn) list) (in_, out) =
  let _, starts, _ = intervalstart insns (in_, out) in
  let _, ends, _ = intervalends insns (in_, out) in
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

let alloc _k _cfg (_in_, _out) = failwith ""
(*let avail = List.init k reg_of_int |> Regs.of_list in
  let insns = List.mapi (fun i n -> (i, n)) insns in
  let incstart, _, _ = intervalstart insns (in_, out) in
  let incend, _, _ = intervalends insns (in_, out) in
  let _, _, asn, _, _ =
    linearscan insns 0 (avail, S.ST.empty, S.ST.empty, incstart, incend)
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
  asn*)
