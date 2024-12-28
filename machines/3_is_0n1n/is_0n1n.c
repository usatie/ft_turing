// "00001111" -> y
// "000011"   -> n
// "01"       -> y
// "0"        -> n
// "1"        -> n
// ""         -> y
void is_on1n(char *input) {
	while (1) {
		// 1. ConsumeZero
		if (*input == '\0') goto exit.yes;
		if (*input == '1') goto exit.no;
		else if (*input == '0') {
			*input = '.';					// marker
			input++;						// RIGHT
		}
		// 2. Go to last character
		while (1) {
			if (*input == '\0') {
				input--;					// LEFT
				break;
			}
			else if (*input == '0' || *input == '1') {
				input++;					// RIGHT
				continue;
			}
		}
		// 3. ConsumeOne
		if (*input == '\0' || *input == '0') goto exit.no;
		else if (*input == '1') {
			*input = '.';					// marker
			input--;						// LEFT
		}
		// 4. Go to the first character
		while (1) {
			if (*input == '\0') {
				input++;					// RIGHT
				break;
			}
			else if (*input == '0' || *input == '1') {
				input++;					// LEFT
				continue;
			}
		}
	}
exit.no:
	while (*input) input++;
	*input = 'n';
	return;
exit.yes:
	while (*input) input++;
	*input = 'y';
	return;
}
