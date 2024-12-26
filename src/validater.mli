open Types

val validate_description : turing_machine_description -> (turing_machine_description, string) result
val validate_input : turing_machine_description -> string -> (string, string) result
