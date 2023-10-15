open Llvm__2

let () =
  let cfg = Parse.from_channel Llparser.cfgeof Stdlib.stdin in
  let ids, g = Cfg.graph cfg in
  let insns = Cfg.flatten cfg in
  Printf.printf "%d\n" (List.length insns);
  List.iteri
    (fun i n ->
      Printf.printf "%d {%s}\t%s\n" i
        (Ll.mapcat ","
           (fun v -> string_of_int (Cfg.G.V.label v))
           (Cfg.G.succ g ids.(i)))
        (Cfg.string_of_insn n))
    insns;
  ()
