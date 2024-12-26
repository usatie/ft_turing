open Utils

(* Main *)
let main () =
  try
    let jsonfile, input = Argparse.parse_args Sys.argv in
    let jsondata = Yojson.Basic.from_file jsonfile in
    let tmd = Json_parser.description_of_json jsondata in
    Validater.validate_description tmd >>= fun valid_tmd ->
    Validater.validate_input valid_tmd input >>= fun valid_input ->
    Printer.print_description valid_tmd;
    let tm = Turing_machine.create_machine tmd valid_input in
    Turing_machine.run_machine tm;
    Ok ()
  with
  | Yojson.Json_error msg -> Error ("Invalid json: " ^ msg)
  | exn -> Error ("Unexpected error: " ^ Printexc.to_string exn)

let () =
  match main () with
  | Ok () -> ()
  | Error msg ->
      Printf.eprintf "Error: %s\n" msg;
      exit 1
