(**************************************************************************)
(* AU Compilation. Assignment submissions must not modify this file       *)
(**************************************************************************)

(** Tigerc compiler main *)

open Tigercommon
open Tigerx86
module A = Absyn
module A' = Tabsyn
module S = Symbol

(** Open the file and initialize the lexer buffer. Observe that the input
    buffer must be closed by the caller. *)

let initLexer filename =
  let input = open_in filename in
  let filebuf = Lexing.from_channel input in
  (* obs that we need to initialize the pos_fname field ourselves *)
  filebuf.lex_curr_p <- { filebuf.lex_curr_p with pos_fname = filename };
  (input, filebuf)

let x86 p = Backend.compile_prog p

let llvmparse file =
  let open Llvmparser in
  let input, filebuf = initLexer file in
  let parseRes =
    try Llparser.prog Lllexer.token filebuf with
    | Lllexer.Error msg -> failwith (Printf.sprintf "%s%!" msg)
    | Llparser.Error ->
        let pos1 = Lexing.lexeme_start_p filebuf in
        let pos2 = Lexing.lexeme_end_p filebuf in
        let lexeme = Lexing.lexeme filebuf in
        failwith
          (Printf.sprintf "%s:%d:%d - %d:%d: syntax error '%s'\n" pos1.pos_fname
             pos1.pos_lnum
             (pos1.pos_cnum - pos1.pos_bol)
             pos2.pos_lnum
             (pos2.pos_cnum - pos2.pos_bol + 1)
             lexeme)
  in

  close_in input;
  parseRes

(* Our reference compiler should allow for stopping at different phases
   in the compilation and allow us to pick the right backend. We implement
   this using a straightforward command-line parsing/checking *)

(* --- command-line checking; dispatching to the right phase --- *)

let llvm file out =
  file |> llvmparse |> x86 |> X86.string_of_prog |> Format.fprintf out "%s\n";
  Format.pp_print_flush out ();
  flush_all ();
  ()
(* obs: exits the program *)
