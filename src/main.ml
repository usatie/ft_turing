(* Main *)
open Yojson.Basic
open Yojson.Basic.Util

(* 遷移時のアクションを表す型 *)
type action = Left | Right

let action_of_string = function
  | "LEFT" -> Left
  | "RIGHT" -> Right
  | s -> failwith ("Unknown action: " ^ s)

let string_of_action = function Left -> "LEFT" | Right -> "RIGHT"

(* 単一の遷移規則を表す型 *)
type transition_rule = {
  read : string;
  to_state : string;
  write : string;
  action : action;
}

(* 全体のTuringマシン設定を表す型 *)
type turing_machine = {
  name : string;
  alphabet : string list;
  blank : string;
  states : string list;
  initial : string;
  finals : string list;
  transitions : (string * transition_rule list) list;
}

(* JSONオブジェクトからtransition_ruleを構築 *)
let transition_rule_of_json json =
  {
    read = json |> member "read" |> to_string;
    to_state = json |> member "to_state" |> to_string;
    write = json |> member "write" |> to_string;
    action = json |> member "action" |> to_string |> action_of_string;
  }

(* JSONからturing_machineをパースする関数 *)
let turing_machine_of_json json =
  {
    name = json |> member "name" |> to_string;
    alphabet = json |> member "alphabet" |> to_list |> List.map to_string;
    blank = json |> member "blank" |> to_string;
    states = json |> member "states" |> to_list |> List.map to_string;
    initial = json |> member "initial" |> to_string;
    finals = json |> member "finals" |> to_list |> List.map to_string;
    transitions =
      json |> member "transitions" |> to_assoc
      |> List.map (fun (state, transitions_json) ->
             let rules =
               transitions_json |> to_list |> List.map transition_rule_of_json
             in
             (state, rules));
  }

let print_transition_rule state rule =
  Printf.printf "(%s, %s) -> (%s, %s, %s)\n" state rule.read rule.to_state
    rule.write
    (string_of_action rule.action)

let print_turing_machine tm =
  Printf.printf "Name: %s\n" tm.name;
  Printf.printf "Alphabet: [ %s ]\n" (String.concat ", " tm.alphabet);
  (* Printf.printf "Blank: %s\n" tm.blank; *)
  Printf.printf "States  : [ %s ]\n" (String.concat ", " tm.states);
  Printf.printf "Initial : %s\n" tm.initial;
  Printf.printf "Finals  : [ %s ]\n" (String.concat ", " tm.finals);
  List.iter
    (fun (state, rules) ->
      List.iter (fun rule -> print_transition_rule state rule) rules)
    tm.transitions

let () =
  let jsonfile, input = Argparse.parse_args Sys.argv in
  let jsondata = Yojson.Basic.from_file jsonfile in
  let tm = turing_machine_of_json jsondata in
  print_turing_machine tm
