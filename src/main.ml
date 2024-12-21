(* Main *)
let main () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  let jsondata = Yojson.Basic.from_file jsonfile in
  let tmd = Turing_machine.description_of_json jsondata in
  Turing_machine.print_description tmd;
  let tm = Turing_machine.f tmd input in
  Printf.printf "%s\n" tm.tape

let () = try main () with
  | Yojson.Json_error msg -> Printf.eprintf "Invalid json: %s\n" msg; exit 1
  | exn ->
    Printf.eprintf "Unknown error: %s\n" (Printexc.to_string exn);
    Printf.eprintf "Backtrace:\n%s\n" (Printexc.get_backtrace ());
    exit 1
