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

let ( >>= ) = Result.bind

let validate_input tmd input =
  input
  |> contains_only_allowed_alphabet tmd.alphabet
  >>= does_not_contain_blank tmd.blank
