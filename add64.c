#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>

extern int64_t add64(int64_t x, int64_t y);

int main(void) {

	uint64_t a, b, c;
	a = 20000000000;
	b = 10000000000;

	c = add64(a, b);

	printf("c = %lld\n", c);  // Use long long int to ensure 64-bits

	return EXIT_SUCCESS;

}
