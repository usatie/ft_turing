(* printer.mli *)

open Types

val print_transition_rule : string -> transition_rule -> unit
val print_description : turing_machine_description -> unit
val print_machine : turing_machine -> unit
val format_tape : string -> int -> string
