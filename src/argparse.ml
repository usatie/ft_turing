(* Command line parsing *)
let usage_msg prog_name =
  Printf.sprintf
    {|
Usage:
  %s [-h] jsonfile input

Positional arguments:
  jsonfile        JSON description of the machine
  input           Input of the machine

Optional arguments:
  -h, --help      Show this help message and exit
|}
    prog_name

let usage_error prog_name =
  print_endline (usage_msg prog_name);
  exit 1

let parse_args args =
  let prog_name = args.(0) in
  match Array.to_list args with
  | _ :: ("-h" | "--help") :: _ -> usage_error prog_name
  | [ _; jsonfile; input ] -> (jsonfile, input)
  | _ -> usage_error prog_name
