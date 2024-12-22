open Types

let print_transition_rule state rule =
  Printf.printf "(%s, %s) -> (%s, %s, %s)\n" state rule.read rule.to_state
    rule.write
    (string_of_action rule.action)

let print_description tmd =
  Printf.printf "Name: %s\n" tmd.name;
  Printf.printf "Alphabet: [ %s ]\n" (String.concat ", " tmd.alphabet);
  Printf.printf "States  : [ %s ]\n" (String.concat ", " tmd.states);
  Printf.printf "Initial : %s\n" tmd.initial;
  Printf.printf "Finals  : [ %s ]\n" (String.concat ", " tmd.finals);
  List.iter
    (fun (state, rules) ->
      List.iter (fun rule -> print_transition_rule state rule) rules)
    tmd.transitions

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
  let read_str = String.make 1 read in
  let rule = List.find (fun rule -> rule.read = read_str) transitions in
  Printf.printf "[%s] (%s, %c) -> (%s, %s, %s)\n" tape tm.state read
    rule.to_state rule.write
    (string_of_action rule.action)
