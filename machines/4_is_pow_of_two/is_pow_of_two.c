// ""  -> n
// "0" -> y
// "00" -> y
// "000" -> n
// "0000" -> y
// "00000" -> n
// ...     -> n
// "00000000" -> y
void is_pow_of_two(char *input) {
	// 1. Check empty input
	if (*input == '\0') {
		printf("n\n");
		return;
	}
	// 2. Validate input (only contains '0's)
	while (1) {
		if (*input == '0') {
			input++;
		} else if (*input == '\0') {
			input--;
			break;
		}
	}
	// 3. Go back to the beginning of the input
	while (1) {
		if (*input == '0') {
			input--;
		} else if (*input == '\0') {
			input++;
			break;
		}
	}
	// 4. Check if the input is a power of two
	/*
	 * if (streq(input, "0")) {
	 *   goto exit.yes;
	 * } else {
	 *   consume_zero = true;
	 *   while (1) {
	 *     if (*input == '0') {
	 *       if (consume_zero) *input = 'M';
	 *       consume_zero = !consume_zero;
	 *       input++;
	 *     } else if (*input == 'M') {
	 *       input++;
	 *     } else if (*input == '\0') {
	 *       input--;
	 *       break;
	 *     }
	 *   }
	 * }
	*/

restore.yes:
  // Go back to the beginning of the input
  while (*input) input--;
  input++;
  // Replace 'M' with '0'
  while (*input) {
	if (*input == 'M') *input = '0';
	input++;
  }
  // Print 'y'
  *input = 'y';
  return;

restore.no:
  // Go back to the beginning of the input
  while (*input) input--;
  input++;
  // Replace 'M' with '0'
  while (*input) {
	if (*input == 'M') *input = '0';
	input++;
  }
  // Print 'n'
  *input = 'n';
  return;

exit.yes:
  while (*input) input++;
  *input = 'y';
  return;

exit.no:
  while (*input) input++;
  *input = 'n';
  return;
}
