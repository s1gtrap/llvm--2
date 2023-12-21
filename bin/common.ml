open Tigermain

exception CompileError

module S = Map.Make (String)

type compiler = Clang | Tiger | Llvm__2 of Llvm__2.Regalloc.allocator

let string_of_compiler = function
  | Clang -> "clang"
  | Tiger -> "tiger"
  | Llvm__2 a -> Llvm__2.Regalloc.string_of_allocator a

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
                |> Llvm__2.Regalloc.compile_prog alc
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
