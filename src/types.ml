(* types.ml *)

type action = Left | Right

let action_of_string = function
  | "LEFT" -> Left
  | "RIGHT" -> Right
  | s -> failwith ("action_of_string: " ^ s)

let string_of_action = function Left -> "LEFT" | Right -> "RIGHT"

let string_of_alphabet alphabet =
  Printf.sprintf "[ %s ]"
    (String.concat ", " (List.map (String.make 1) alphabet))

type transition_rule = {
  read : char;
  to_state : string;
  write : char;
  action : action;
}

type turing_machine_description = {
  name : string;
  alphabet : char list;
  blank : char;
  states : string list;
  initial : string;
  finals : string list;
  transitions : (string * transition_rule list) list;
}

type turing_machine = {
  description : turing_machine_description;
  tape : string;
  head_pos : int;
  state : string;
}
