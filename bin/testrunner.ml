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
      Printf.printf "spawning child...\n";
      flush stdout;
      let pid =
        Unix.create_process_env command [| command |] (Unix.environment ())
          Unix.stdin stdout_write Unix.stderr
      in
      Printf.printf "spawned child!\n";
      flush stdout;
      match Unix.waitpid [] pid with
      | _, WEXITED code ->
          Unix.close stdout_read;
          Printf.printf "exiting WEXITED %d\n" code;
          flush stdout;
          exit code
      | _, WSIGNALED code ->
          Printf.printf "exiting WSIGNALED %d\n" code;
          flush stdout;
          Unix.close stdout_read;
          exit 0xffffffff
      | _, WSTOPPED code ->
          Printf.printf "exiting WSTOPPED %d\n" code;
          flush stdout;
          Unix.close stdout_read;
          exit 0xffffffff)
  | pid ->
      Unix.close stdout_write;
      let output = ref "" in
      let buffer = Bytes.create 1024 in
      let rec read_output () =
        flush stdout;
        let len = Unix.read stdout_read buffer 0 1024 in
        flush stdout;
        if len > 0 then (
          output := !output ^ Bytes.sub_string buffer 0 len;
          read_output ())
      in
      Printf.printf "reading stdout...\n";
      flush stdout;
      (try read_output () with _ -> ());
      Unix.close stdout_read;
      Printf.printf "done reading stdout!\n";
      flush stdout;

      Printf.printf "waiting...\n";
      flush stdout;
      let _ = Unix.waitpid [] pid in
      Printf.printf "done!\n";
      flush stdout;
      Exit (0, !output, "")

let () =
  let _ = Printf.sprintf "%s\n" (string_of_status Timeout) in
  let _ =
    Printf.sprintf "%s\n" (string_of_status (Error (WSTOPPED 0, "", "")))
  in
  Printf.printf "\n1:\n";
  Printf.printf "%s\n" (string_of_status (execute "ls"));
  Printf.printf "\n2:\n";
  Printf.printf "%s\n" (string_of_status (execute "xxd"))
