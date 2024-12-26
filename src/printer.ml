open Types

(* Function to create a string composed of a repeated character *)
let repeat_char c n = String.init n (fun _ -> c)

(* Function to center a string within a given width *)
let center_string s width =
  let len = String.length s in
  if len > width then
    (* If string is longer than the available width, truncate it *)
    String.sub s 0 width
  else
    let total_padding = width - len in
    let left_padding = total_padding / 2 in
    let right_padding = total_padding - left_padding in
    repeat_char ' ' left_padding ^ s ^ repeat_char ' ' right_padding

(* Main function to print the box *)
let print_box s width =
  if width < 2 then print_endline "Width must be at least 2 to create a box."
  else
    let border = repeat_char '*' width in
    let empty_line = "*" ^ repeat_char ' ' (width - 2) ^ "*" in
    let centered_line = "*" ^ center_string s (width - 2) ^ "*" in
    (* Print the box: top border, empty line, centered string, empty line, bottom border *)
    print_endline border;
    print_endline empty_line;
    print_endline centered_line;
    print_endline empty_line;
    print_endline border

let print_transition_rule state rule =
  Printf.printf "(%s, %c) -> (%s, %c, %s)\n" state rule.read rule.to_state
    rule.write
    (string_of_action rule.action)

let print_description tmd =
  let width = 80 in
  print_box tmd.name width;
  Printf.printf "Alphabet: [ %s ]\n" (String.concat ", " tmd.alphabet);
  Printf.printf "States  : [ %s ]\n" (String.concat ", " tmd.states);
  Printf.printf "Initial : %s\n" tmd.initial;
  Printf.printf "Finals  : [ %s ]\n" (String.concat ", " tmd.finals);
  List.iter
    (fun (state, rules) ->
      List.iter (fun rule -> print_transition_rule state rule) rules)
    tmd.transitions;
  let border = repeat_char '*' width in
  print_endline border

let format_tape tape pos =
  (* Split before pos, at pos, and after pos *)
  let before = String.sub tape 0 pos in
  let at = String.sub tape pos 1 in
  let after = String.sub tape (pos + 1) (String.length tape - pos - 1) in
  (* Replace empty with _ *)
  Printf.sprintf "%s<%s>%s" before at after

let rec print_machine tm =
  let tape = format_tape tm.tape tm.head_pos in
  let read = tm.tape.[tm.head_pos] in
  let transitions = List.assoc tm.state tm.description.transitions in
  let rule = List.find (fun rule -> rule.read = read) transitions in
  Printf.printf "[%s] (%s, %c) -> (%s, %c, %s)\n" tape tm.state read
    rule.to_state rule.write
    (string_of_action rule.action)
