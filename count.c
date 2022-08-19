#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

extern int32_t countUpToFifty(int32_t x);
extern int32_t countDownToZero(int32_t x);

int main(void) {
	int32_t a, b;

	printf("Input integer: ");
	scanf("%d", &a);

	//b = countUpToFifty(a);
	b = countDownToZero(a);

	printf("Final count = %d\n", b);

	return EXIT_SUCCESS;
}
