open Yojson.Basic.Util
open Types

let create_machine tmd input =
  { description = tmd; tape = input; head_pos = 0; state = tmd.initial }

let transition_rule_of_json json =
  {
    read = json |> member "read" |> to_string;
    to_state = json |> member "to_state" |> to_string;
    write = json |> member "write" |> to_string;
    action = json |> member "action" |> to_string |> action_of_string;
  }

let description_of_json json =
  try
    {
      name = json |> member "name" |> to_string;
      alphabet = json |> member "alphabet" |> to_list |> List.map to_string;
      blank = json |> member "blank" |> to_string;
      states = json |> member "states" |> to_list |> List.map to_string;
      initial = json |> member "initial" |> to_string;
      finals = json |> member "finals" |> to_list |> List.map to_string;
      transitions =
        json |> member "transitions" |> to_assoc
        |> List.map (fun (state, transitions_json) ->
               let rules =
                 transitions_json |> to_list |> List.map transition_rule_of_json
               in
               (state, rules));
    }
  with exn ->
    let msg = Printf.sprintf "Invalid JSON: %s" (Printexc.to_string exn) in
    raise (Invalid_argument msg)

let print_transition_rule state rule =
  Printf.printf "(%s, %s) -> (%s, %s, %s)\n" state rule.read rule.to_state
    rule.write
    (string_of_action rule.action)

let print_description tmd =
  Printf.printf "Name: %s\n" tmd.name;
  Printf.printf "Alphabet: [ %s ]\n" (String.concat ", " tmd.alphabet);
  Printf.printf "States  : [ %s ]\n" (String.concat ", " tmd.states);
  Printf.printf "Initial : %s\n" tmd.initial;
  Printf.printf "Finals  : [ %s ]\n" (String.concat ", " tmd.finals);
  List.iter
    (fun (state, rules) ->
      List.iter (fun rule -> print_transition_rule state rule) rules)
    tmd.transitions
