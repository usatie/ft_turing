(* json_parser.mli *)

open Types

val transition_rule_of_json : Yojson.Basic.t -> transition_rule
val description_of_json : Yojson.Basic.t -> turing_machine_description

(* printer.mli *)

open Types

val print_transition_rule : string -> transition_rule -> unit
val print_description : turing_machine_description -> unit

(* turing_machine.mli *)

open Types

val create_machine : turing_machine_description -> string -> turing_machine
