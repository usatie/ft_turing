(* Main *)
let () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  let jsondata = Yojson.Basic.from_file jsonfile in
  let tmd = Turing_machine.description_of_json jsondata in
  Turing_machine.print_description tmd
