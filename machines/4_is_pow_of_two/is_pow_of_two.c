// ""  -> n
// "0" -> y
// "00" -> y
// "000" -> n
// "0000" -> y
// "00000" -> n
// ...     -> n
// "00000000" -> y
void is_pow_of_two(char *input) {
	// Check if the input only contains '0's
	while (1) {
		if (*input == '\0') {
			input--;
		}
		if (*input != '0') {
			break;
		}
	}
	// go to first character
	while (1) {
		if (*input == '\0') {
			input--;
		}
		if (*input == '0') {
			input++;
			break;
		}
		input--;
	}
	while (1) {
		if (*input == '\0') {
			printf("y\n");
			return;
		}
		if (*input != '0') {
			printf("n\n");
			return;
		}
		input++;
	}
}
