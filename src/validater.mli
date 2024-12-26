open Types

val validate_description : turing_machine_description -> (turing_machine_description, string) result
val validate_input : turing_machine_description -> string -> (string, string) result
val (>>=) : ('a, 'b) result -> ('a -> ('c, 'b) result) -> ('c, 'b) result
