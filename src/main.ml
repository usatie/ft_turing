(* Main *)
let main () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  let jsondata = Yojson.Basic.from_file jsonfile in
  let tmd = Json_parser.description_of_json jsondata in
  let result = Validater.validate_input tmd input in
  match result with
  | Ok input ->
      Printer.print_description tmd;
      let tm = Turing_machine.create_machine tmd input in
      Turing_machine.run_machine tm
  | Error err_msg -> Printf.printf "Validation failed: %s\n" err_msg

let () =
  try main () with
  | Yojson.Json_error msg ->
      Printf.eprintf "Invalid json: %s\n" msg;
      exit 1
  | exn ->
      Printf.eprintf "Error: %s\n" (Printexc.to_string exn);
      exit 1
