(* types.mli *)

type action = Left | Right

val action_of_string : string -> action
val string_of_action : action -> string

type transition_rule = {
  read : string;
  to_state : string;
  write : string;
  action : action;
}

type turing_machine_description = {
  name : string;
  alphabet : string list;
  blank : string;
  states : string list;
  initial : string;
  finals : string list;
  transitions : (string * transition_rule list) list;
}

type turing_machine = {
  description: turing_machine_description;
  tape: string;
  head_pos: int;
  state: string;
}