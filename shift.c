#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "printBinary.c"

extern int32_t shiftBy(int32_t x, int32_t y);

int main(void) {

	int32_t a, b, c;

	c = shiftBy(a, b);

	printf("a = %d\n", a);
	printBinary32(a);

	printf("c = %d\n", c);
	printBinary32(c);

	return EXIT_SUCCESS;
}
