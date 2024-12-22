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

let format_tape tape = Printf.sprintf "%s" tape

let print_machine tm =
  let tape = format_tape tm.tape in
  let read = tm.tape.[tm.head_pos] in
  let transitions = List.assoc tm.state tm.description.transitions in
  let read_str = String.make 1 read in
  let rule = List.find (fun rule -> rule.read = read_str) transitions in
  Printf.printf "[%s] (%s, %c) -> (%s, %s, %s)\n" tape tm.state read
    rule.to_state rule.write
    (string_of_action rule.action)
