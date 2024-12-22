(* json_parser.mli *)

open Types

val transition_rule_of_json : Yojson.Basic.t -> transition_rule
val description_of_json : Yojson.Basic.t -> turing_machine_description
