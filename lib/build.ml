let create_process command args fn =
  let pid =
    Unix.create_process_env command
      (Array.concat [ args; [| fn |] ])
      (Unix.environment ()) Unix.stdin Unix.stdout Unix.stderr
  in
  let _ = Unix.waitpid [] pid in
  ()

let create_process_with_input command args input_string _f =
  let write_file file s =
    Out_channel.with_open_bin file (fun oc -> Out_channel.output_string oc s)
  in
  let fn : string = Filename.temp_file "" "" in
  write_file fn input_string;
  let pid =
    Unix.create_process_env command
      (Array.concat [ args; [| fn |] ])
      (Unix.environment ()) Unix.stdin Unix.stdout Unix.stderr
  in
  let _ = Unix.waitpid [] pid in
  ()
