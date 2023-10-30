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
  let stdout_read, stdout_write = Unix.pipe () in
  match Unix.fork () with
  | 0 -> (
      let _ = Unix.alarm 2 in
      let pid =
        Unix.create_process_env command [| command |] (Unix.environment ())
          Unix.stdin stdout_write Unix.stderr
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
      let read read write =
        Unix.close write;
        let output = ref "" in
        let buffer = Bytes.create 1024 in
        let rec r (_ : unit) =
          let len = Unix.read stdout_read buffer 0 1024 in
          if len > 0 then (
            output := !output ^ Bytes.sub_string buffer 0 len;
            r ())
        in
        r ();
        Unix.close read;
        !output
      in
      let stdout = try read stdout_read stdout_write with _ -> "" in

      let _ = Unix.waitpid [] pid in
      Exit (0, stdout, "")

let () =
  let _ = Printf.sprintf "%s\n" (string_of_status Timeout) in
  let _ =
    Printf.sprintf "%s\n" (string_of_status (Error (WSTOPPED 0, "", "")))
  in
  Printf.printf "%s\n" (string_of_status (execute "ls"));
  Printf.printf "%s\n" (string_of_status (execute "xxd"))
