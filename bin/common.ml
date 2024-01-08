open Tigermain

exception CompileError

module S = Map.Make (String)

type compiler = Clang | Tiger | Llvm__2 of Llvm__2.Regalloc.allocator

let red = "\027[0;31m"
and green = "\027[1;32m"
and muted = "\027[1;39m"
and nc = "\027[0m"

let string_of_compiler = function
  | Clang -> "clang"
  | Tiger -> "tiger"
  | Llvm__2 a -> Llvm__2.Regalloc.string_of_allocator a

let print_diff s1 s2 =
  let rec print s1 s2 s3 =
    match (s1, s2, s3) with
    | l1 :: t1, l2 :: t2, [] when l1 = l2 ->
        Printf.printf "     %s\n" l1;
        print t1 t2 []
    | l1 :: _t1, l2 :: _t2, l3 :: t3 when l1 = l2 ->
        Printf.printf "    %s+%s%s\n" green l3 nc;
        print s1 s2 t3
    | l1 :: t1, l2 :: t2, t3 ->
        Printf.printf "    %s-%s%s\n" red l1 nc;
        print t1 t2 (List.rev (l2 :: List.rev t3))
    | t1, t2, l3 :: t3 ->
        Printf.printf "    %s+%s%s\n" green l3 nc;
        print t1 t2 t3
    | l1 :: t1, [], [] ->
        Printf.printf "    %s-%s%s\n" red l1 nc;
        print t1 [] []
    | [], l2 :: t2, [] ->
        Printf.printf "    %s+%s%s\n" green l2 nc;
        print [] t2 []
    | [], [], [] -> ()
  in
  print (String.split_on_char '\n' s1) (String.split_on_char '\n' s2) []

let execs = ref S.empty

let compile_test c test cargs =
  let testname = string_of_compiler c ^ test in
  match S.find_opt testname !execs with
  | Some fn -> fn
  | None ->
      let fn : string = Filename.temp_file "" "" in
      let clangcmd =
        match Llvm__2.Regalloc.os with
        | Linux -> [| "clang"; "-Wno-override-module" |]
        | Darwin ->
            [|
              "clang";
              "-Wno-override-module";
              "-target";
              "x86_64-unknown-darwin";
            |]
      in
      let _ =
        match c with
        | Clang ->
            Llvm__2.Build.create_process "clang"
              (Array.concat [ clangcmd; cargs; [| "-o"; fn |] ])
              test
        | Tiger ->
            let buf = Buffer.create 16 in
            let fmt = Format.formatter_of_buffer buf in
            let _ = Main.llvm test fmt in
            let prog = Buffer.contents buf in
            (match Llvm__2.Regalloc.os with
            | Darwin ->
                Llvm__2.Build.create_process_with_input "clang"
                  (Array.concat
                     [
                       [| "clang"; "-target"; "x86_64-unknown-darwin" |];
                       cargs;
                       [| "-x"; "assembler"; "-o"; fn |];
                     ])
            | Linux ->
                Llvm__2.Build.create_process_with_input "clang"
                  (Array.concat
                     [ [| "clang" |]; cargs; [| "-x"; "assembler"; "-o"; fn |] ]))
              prog fn
            (*(*Llvm__2.Build.create_process "tigerc"
                (Array.concat [ [| "tigerc" |]; [| "-o"; fn |] ])
                test;*)
              let outsfile : string = Filename.temp_file "" ".s" in
              let cmd = cwd ^ "/tigerc" in
              let pid =
                Unix.create_process cmd
                  [| cmd; "-l"; "ll"; test; "-o"; outsfile |]
                  Unix.stdin Unix.stdout Unix.stderr
              in
              let _, status = Unix.waitpid [] pid in
              match status with
              | WEXITED 0 -> (
                  let pid =
                    Unix.create_process "clang"
                      (Array.concat [ clangcmd; cargs; [| outsfile; "-o"; fn |] ])
                      Unix.stdin Unix.stdout Unix.stderr
                  in
                  let _, status = Unix.waitpid [] pid in
                  match status with WEXITED 0 -> () | _ -> raise CompileError)
              | _ -> raise CompileError)*)
        | Llvm__2 alc ->
            let prog : string =
              try
                In_channel.open_text test
                |> Llvm__2.Parse.from_channel Llvm__2.Llparser.prog
                |> Llvm__2.Regalloc.compile_prog alc false
                |> Llvm__2.Regalloc.string_of_prog
              with _ -> raise CompileError
            in
            (match Llvm__2.Regalloc.os with
            | Darwin ->
                Llvm__2.Build.create_process_with_input "clang"
                  (Array.concat
                     [
                       [| "clang"; "-target"; "x86_64-unknown-darwin" |];
                       cargs;
                       [| "-x"; "assembler"; "-o"; fn |];
                     ])
            | Linux ->
                Llvm__2.Build.create_process_with_input "clang"
                  (Array.concat
                     [ [| "clang" |]; cargs; [| "-x"; "assembler"; "-o"; fn |] ]))
              prog fn
      in
      execs := S.add testname fn !execs;
      fn

let matches filter s =
  let re = Str.regexp_string filter in
  try
    ignore (Str.search_forward re s 0);
    true
  with Not_found -> false
