open Turing_machine

(* Main *)
let () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  let jsondata = Yojson.Basic.from_file jsonfile in
  let tm = turing_machine_of_json jsondata in
  print_turing_machine tm
