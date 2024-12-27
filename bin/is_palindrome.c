void is_palindrome(char *input) {
	while (*input) {
		let c = *input; // If this is expressed as state memory, it would be so lengthy...
		*input = '\0';
		input++;
		// Move to the end of the string
		while (*input) input++;
		input--;
		if (*input == '\0') {
			break;
		}
		if (c != *input) {
			input++;
			*input = 'n';
			return;
		}
		*input = '\0';
		// Go back to the beginning of the string
		while (*input) input--;
		input++;
	}
	*input = 'y';
	return;
}
/*
{
	"name"   : "is_palindrome",
	"alphabet": [ "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "." ],
	"blank"  : ".",
	"states" : [ "1_main_loop", "2_goto_last.<alpha>", "3_checklast", "4_return_false", "5_goto_first", "HALT" ],
	"initial" : "1_main_loop",
	"finals" : [ "HALT" ],
	"transitions" : {
		"1_main_loop": [
			{ "read" : ".", "to_state": "HALT", "write": "y", "action": "RIGHT"},
			{ "read" : "a", "to_state": "2_goto_last.a", "write": ".", "action": "RIGHT"},
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
*/
