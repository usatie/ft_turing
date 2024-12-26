(* json_parser.ml *)

open Yojson.Basic.Util
open Types

let to_char json =
  let s = json |> to_string in
  if String.length s = 1 then s.[0]
  else failwith "JSON value is not single character"

let transition_rule_of_json json =
  {
    read = json |> member "read" |> to_char;
    to_state = json |> member "to_state" |> to_string;
    write = json |> member "write" |> to_char;
    action = json |> member "action" |> to_string |> action_of_string;
  }

let description_of_json json =
  {
    name = json |> member "name" |> to_string;
    alphabet = json |> member "alphabet" |> to_list |> List.map to_char;
    blank = json |> member "blank" |> to_char;
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
