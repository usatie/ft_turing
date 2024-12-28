void is_palindrome(char *input) {
	while (*input) {              // 1. main loop: read
		let c = *input;           // (state memory)
		*input = '\0';            // 1. main loop: write
		input++;                  // 1. main loop: RIGHT
		
		while (*input) input++;   // 2. goto last character: read, RIGHT
		input--;                  // 2. goto last character: LEFT

		if (*input == '\0') {     // 3. check last character: read
			break;                // 3. check last character: to_state(HALT), write
		}                         // 3. check last character
		if (c != *input) {        // 3. check last character
			input++;              // 3. check last character
			*input = 'n';         // 4. return false
			return;               // 4. return false
		}
		*input = '\0';            // 3. check last character

		while (*input) input--;   // 5. goto first character
		input++;                  // 5. goto first character
	}
	*input = 'y';
	return;
}

/*
void is_palindrome(char *input) {
1_main_loop:
	if (*input == '\0') {		// read
		*input = 'y';			// write
	 	return;					// HALT
	} else {					// read
		let c = *input;			// (state memory)
		*input = '\0';			// write
		input++;				// RIGHT
		goto 2_goto_last;		// to_state
	}

2_goto_last:
	if (*input == '\0') {		// read
		input--;				// LEFT
		goto 3_check_last;		// to_state
	} else {					// read
		input++;				// RIGHT
		goto 2_goto_last;		// to_state
	}

3_check_last:
	if (*input == '\0') {		// read
		*input = 'y';			// write
	 	return;					// HALT
	} else if (*input != c) {	// read
		input++;				// RIGHT
		goto exit.false			// to_state
	} else {					// read
		*input = '\0';			// write
		input--;				// LEFT
		goto 5_goto_first;		// to_state
	}

5_goto_first:
	if (*input == '\0') {		// read
		input++;				// RIGHT
		goto 1_main_loop;		// to_state
	} else {					// read
		input++;				// RIGHT
		goto 5_goto_first;		// to_state
	}

exit.false:
	*input = 'n';				// write
	return;						// HALT
}
*/

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
