type status =
  | Exit of int * string * string
  | Error of Unix.process_status * string * string
  | Timeout

let string_of_status = function
  | Exit (code, stdout, stderr) ->
      Printf.sprintf "Exit (%d, \"%s\", \"%s\")" code (String.escaped stdout)
        (String.escaped stderr)
  | Error (WEXITED _, _, _) -> failwith "unreachable"
  | Error (WSIGNALED code, stdout, stderr) ->
      Printf.sprintf "Error (WSIGNALED %d, \"%s\", \"%s\")" code
        (String.escaped stdout) (String.escaped stderr)
  | Error (WSTOPPED code, stdout, stderr) ->
      Printf.sprintf "Error (WSTOPPED %d, \"%s\", \"%s\")" code
        (String.escaped stdout) (String.escaped stderr)
  | Timeout -> "Timeout"

let execute command : status =
  match Unix.fork () with
  | 0 -> (
      let _ = Unix.alarm 2 in
      let pid =
        Unix.create_process_env command [| command |] (Unix.environment ())
          Unix.stdin Unix.stdout Unix.stderr
      in
      match Unix.waitpid [] pid with
      | _, WEXITED code -> exit code
      | _, WSIGNALED code ->
          Printf.eprintf "WSIGNALED %d\n" code;
          exit 0xffffffff
      | _, WSTOPPED code ->
          Printf.eprintf "WSTOPPED %d\n" code;
          exit 0xffffffff)
  | pid ->
      let _ = Unix.waitpid [] pid in
      Exit (0, command, "")

let () =
  let _ = Printf.sprintf "%s\n" (string_of_status Timeout) in
  let _ =
    Printf.sprintf "%s\n" (string_of_status (Error (WSTOPPED 0, "", "")))
  in
  Printf.printf "%s\n" (string_of_status (execute "ls"));
  Printf.printf "%s\n" (string_of_status (execute "xxd"))
