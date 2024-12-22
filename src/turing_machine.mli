(* turing_machine.mli *)

open Types

val create_machine : turing_machine_description -> string -> turing_machine
val run_machine : turing_machine -> unit
