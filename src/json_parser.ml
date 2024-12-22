(* json_parser.ml *)

open Yojson.Basic.Util
open Types

let transition_rule_of_json json =
  {
    read = json |> member "read" |> to_string;
    to_state = json |> member "to_state" |> to_string;
    write = json |> member "write" |> to_string;
    action = json |> member "action" |> to_string |> action_of_string;
  }

let description_of_json json =
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
