(* Main *)
let () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  Printf.printf "JSON File: %s\nInput: %s\n" jsonfile input
