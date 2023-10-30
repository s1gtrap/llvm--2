let create_process_with_input command args input_string _f =
  let ic, oc = Unix.pipe () in
  let oc = Unix.out_channel_of_descr oc in
  output_string oc input_string;
  close_out oc;
  let input = ic in
  let pid =
    Unix.create_process_env command args (Unix.environment ()) input Unix.stdout
      Unix.stderr
  in
  let _ = Unix.waitpid [] pid in
  ()
