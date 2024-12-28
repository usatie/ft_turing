import json
import copy

def expand_states(data):
    states = data["states"]
    for state in states:
        if state.endswith(".<alpha>"):
            expanded_states = []
            for letter in "abcdefghijklmnopqrstuvwxyz":
                new_state = state.replace("<alpha>", letter)
                expanded_states.append(new_state)
            idx = states.index(state)
            data["states"] = states[:idx] + expanded_states + states[idx+1:]

def expand_transition_rules_alpha(data):
    transition_rules = copy.deepcopy(data["transitions"])
    for state, rules in transition_rules.items():
        if state.endswith(".<alpha>"):
            expanded = {}
            for letter in "abcdefghijklmnopqrstuvwxyz":
                new_state = state.replace("<alpha>", letter)
                new_rules = copy.deepcopy(rules)
                for rule in new_rules:
                    if rule["read"] == "<alpha>":
                        rule["read"] = letter
                    if rule["to_state"].endswith(".<alpha>"):
                        rule["to_state"] = rule["to_state"].replace("<alpha>", letter)
                    if rule["write"] == "<alpha>":
                        rule["write"] = letter
                expanded.update({new_state: new_rules})
            data["transitions"].update(expanded)
            data["transitions"].pop(state)

def expand_transition_rules_any(data):
    transition_rules = copy.deepcopy(data["transitions"])
    for state, rules in transition_rules.items():
        tmp_rules = copy.deepcopy(rules)
        for rule in tmp_rules:
            if rule["read"] == "<any>":
                rules.remove(rule)
                existing_alphabet = set([r["read"] for r in rules if r["read"] != "<any>"])
                for letter in data["alphabet"]:
                    if letter in existing_alphabet:
                        continue
                    write = letter if rule["write"] == "<read>" else rule["write"]
                    to_state = rule["to_state"] if not rule["to_state"].endswith("<read>") else rule["to_state"].replace("<read>", letter)
                    rules.append({ "read": letter, "to_state": to_state, "write": write, "action": rule["action"] })
                data["transitions"][state] = rules

def expand_transition_rules(data):
    expand_transition_rules_alpha(data)
    expand_transition_rules_any(data)

if __name__ == '__main__':
    data = {
        "name"   : "is_palindrome",
        "alphabet": [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "." ],
        "blank"  : ".",
        "states" : [ "1_main_loop", "2_goto_last.<alpha>", "3_checklast", "4_return_false", "5_goto_first", "HALT" ],
        "initial" : "1_main_loop",
        "finals" : [ "HALT" ],
        "transitions" : {
            "1_main_loop": [
                { "read" : ".", "to_state": "HALT", "write": "y", "action": "RIGHT"},
                { "read" : "<any>", "to_state": "2_goto_last.<read>", "write": ".", "action": "RIGHT"},
            ],
            "2_goto_last.<alpha>": [
                { "read" : ".", "to_state": "3_checklast.<alpha>", "write": ".", "action": "LEFT"},
                { "read" : "<any>", "to_state": "2_goto_last.<alpha>", "write": "<read>", "action": "RIGHT"},
            ],
            "3_checklast.<alpha>": [
                { "read" : ".", "to_state": "HALT", "write": "y", "action": "RIGHT"},
                { "read" : "<alpha>", "to_state": "5_goto_first", "write": ".", "action": "LEFT"},
                { "read" : "<any>", "to_state": "4_return_false", "write": "<read>", "action": "RIGHT"},
            ],
            "4_return_false": [
                { "read" : ".", "to_state": "HALT", "write": "n", "action": "RIGHT"}
            ],
            "5_goto_first": [
                { "read" : ".", "to_state": "1_main_loop", "write": ".", "action": "RIGHT"},
                { "read" : "<any>", "to_state": "5_goto_first", "write": "<read>", "action": "LEFT"},
            ]
        }
    }
    expand_states(data)
    expand_transition_rules(data)
    print(json.dumps(data, indent=2))
