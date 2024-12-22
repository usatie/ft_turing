open Yojson.Basic.Util
open Types

let create_machine tmd input =
  { description = tmd; tape = input; head_pos = 0; state = tmd.initial }

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
