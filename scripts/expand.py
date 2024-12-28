import json
import copy
import sys

def expand_states(data):
    states = data["states"]
    for state in states:
        letters = None
        if state.endswith(".<alpha>"):
            placeholder = "<alpha>"
            letters = "abcdefghijklmnopqrstuvwxyz"
        elif state.endswith(".<alphanum>"):
            placeholder = "<alphanum>"
            letters = "abcdefghijklmnopqrstuvwxyz0123456789"
        if letters:
            expanded_states = []
            for letter in letters:
                new_state = state.replace(placeholder, letter)
                expanded_states.append(new_state)
            idx = states.index(state)
            data["states"] = states[:idx] + expanded_states + states[idx+1:]

def expand_transition_rules_alpha(data):
    transition_rules = copy.deepcopy(data["transitions"])
    for state, rules in transition_rules.items():
        letters = None
        if state.endswith(".<alpha>"):
            placeholder = "<alpha>"
            letters = "abcdefghijklmnopqrstuvwxyz"
        elif state.endswith(".<alphanum>"):
            placeholder = "<alphanum>"
            letters = "abcdefghijklmnopqrstuvwxyz0123456789"
        if letters:
            expanded = {}
            for letter in letters:
                new_state = state.replace(placeholder, letter)
                new_rules = copy.deepcopy(rules)
                for rule in new_rules:
                    if rule["read"] == placeholder:
                        rule["read"] = letter
                    if rule["to_state"].endswith(placeholder):
                        rule["to_state"] = rule["to_state"].replace(placeholder, letter)
                    if rule["write"] == placeholder:
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

def load_json_from_file(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
            data = json.load(file)
            return data
    except FileNotFoundError:
        print(f"Error: File not found - {file_path}")
        sys.exit(1)
    except json.JSONDecodeError as e:
        print(f"Error: Invalid JSON format - {e}")
        sys.exit(1)

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("Usage: python expand.py <path>")
        sys.exit(1)
    file_path = sys.argv[1]
    data = load_json_from_file(file_path)
    expand_states(data)
    expand_transition_rules(data)
    print(json.dumps(data, indent=2))
