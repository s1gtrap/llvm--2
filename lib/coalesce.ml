open Common

let sos s = Ll.mapcat " " S.name (S.SS.to_seq s |> List.of_seq)

let coalesce v1 v2 (st, g) =
  if v1 = v2 then (st, g)
  else
    let g' = Lva.G.create () in
    let st', vt', _ =
      Lva.G.fold_vertex
        (fun v (st, vt, jn) ->
          if v = v1 || v = v2 then (
            match jn with
            | None ->
                let s = Lva.G.V.label v in
                (st, vt, Some (v, s))
            | Some (v1, s1) ->
                let s' = Lva.G.V.label v |> S.SS.union s1 in
                let v' = Lva.G.V.create s' in
                Lva.G.add_vertex g' v';
                ( S.SS.fold (fun e l -> S.ST.add e v' l) s' st,
                  Lva.VT.add v1 v' vt |> Lva.VT.add v v',
                  None ))
          else
            let s = Lva.G.V.label v in
            let v' = Lva.G.V.create s in
            Lva.G.add_vertex g' v';
            ( S.SS.fold (fun e st -> S.ST.add e v' st) s st,
              Lva.VT.add v v' vt,
              jn ))
        g
        (S.ST.empty, Lva.VT.empty, None)
    in
    Lva.G.iter_edges
      (fun v1 v2 ->
        let v1 = Lva.VT.find v1 vt' in
        let v2 = Lva.VT.find v2 vt' in
        if v1 <> v2 then Lva.G.add_edge g' v1 v2)
      g;
    (st', g')

let coalesce_briggs k (prefs : S.SS.t S.ST.t)
    ((l, g) : Lva.G.V.t S.ST.t * Lva.G.t) : Lva.G.V.t S.table * Lva.G.t =
  let try_coalesce sop dop (l, g) =
    let sneighs = S.ST.find sop l |> Lva.G.succ g |> Lva.VS.of_list
    and dneighs = S.ST.find dop l |> Lva.G.succ g |> Lva.VS.of_list in
    let neighs = Lva.VS.union sneighs dneighs in
    let sign v = Lva.G.succ g v |> List.length >= k in
    let signeighs = Lva.VS.filter sign neighs in
    if
      (not (Lva.G.mem_edge g (S.ST.find sop l) (S.ST.find dop l)))
      && Lva.VS.cardinal signeighs < k
    then coalesce (S.ST.find sop l) (S.ST.find dop l) (l, g)
    else (l, g)
  in
  let try_pref sop dops (l, g) = S.SS.fold (try_coalesce sop) dops (l, g) in
  S.ST.fold try_pref prefs (l, g)

let coalesce (alc : allocator) (prefs : S.SS.t S.ST.t)
    ((l, g) : Lva.G.V.t S.ST.t * Lva.G.t) : Lva.G.V.t S.table * Lva.G.t =
  match alc with Briggs k -> coalesce_briggs k prefs (l, g) | _ -> (l, g)
