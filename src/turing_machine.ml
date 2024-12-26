open Yojson.Basic.Util
open Types

let create_machine tmd input =
  {
    description = tmd;
    tape = input ^ ".............";
    head_pos = 0;
    state = tmd.initial;
  }

let rec run_machine machine =
  if List.mem machine.state machine.description.finals then
    Printf.printf "[%s]\n" machine.tape
  else (
    Printer.print_machine machine;
    let read = machine.tape.[machine.head_pos] in
    let transitions =
      List.assoc machine.state machine.description.transitions
    in
    let rule = List.find (fun rule -> rule.read = read) transitions in
    let before = String.sub machine.tape 0 machine.head_pos in
    let after =
      String.sub machine.tape (machine.head_pos + 1)
        (String.length machine.tape - machine.head_pos - 1)
    in
    let new_tape = Printf.sprintf "%s%c%s" before rule.write after in
    let new_pos =
      match rule.action with
      | Left -> machine.head_pos - 1
      | Right -> machine.head_pos + 1
    in
    let new_state = rule.to_state in
    run_machine
      { machine with tape = new_tape; head_pos = new_pos; state = new_state })
