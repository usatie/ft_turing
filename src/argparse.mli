(* argparse.mli *)

(**
  Parses the command-line arguments.

  [parse_args args] takes an array of command-line arguments and returns a tuple
  containing the JSON file path and the input string.

  If the arguments are invalid or [-h]/[--help] is provided, the program will
  display the usage message and exit.
*)
val parse_args : string array -> string * string
