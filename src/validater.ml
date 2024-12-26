open Utils
open Types

let contains_only_allowed_alphabet alphabet input =
  if String.for_all (fun c -> List.mem c alphabet) input then Ok input
  else
    Error
      ("String contains characters not in allowed alphabet: "
      ^ string_of_alphabet alphabet)

let does_not_contain_blank blank input =
  if String.contains input blank then Error "String contains blank character"
  else Ok input

let blank_is_part_of_alphabet alphabet blank = List.mem blank alphabet

let validate_description tmd =
  if blank_is_part_of_alphabet tmd.alphabet tmd.blank then Ok tmd
  else Error "Blank character must be part of the alphabet"

let validate_input tmd input =
  input
  |> contains_only_allowed_alphabet tmd.alphabet
  >>= does_not_contain_blank tmd.blank
