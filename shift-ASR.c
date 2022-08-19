#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "printBinary.c"

extern int8_t shift8(int8_t x, int8_t y);
extern int32_t shift32(int32_t x, int32_t y);

int main() {

	int8_t a, b, c;

	printf("\n----------8-bit shift-----------\n\n");
	printf("Input integer to shift: ");
	scanf("%hhd", &a);

	printf("Input shift amount: ");
	scanf("%hhd", &b);

	c = shift8(a, b);

	printf("\nInput = %hhd\n", a); 
	printBinary8(a);

	printf("\nOutput = %hhd\n", c);
	printBinary8(c);

	printf("\n----------32-bit shift----------\n\n");

	int32_t d, e, f;

	printf("Input integer to shift: ");
	scanf("%d", &d);

	printf("Input shift amount: ");
	scanf("%d", &e);

	f = shift32(d, e);

	printf("\nInput = %d\n", d);
	printBinary32(d);

	printf("\nOutput = %d\n", f);
	printBinary32(f);

	return EXIT_SUCCESS;
}
