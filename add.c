#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>

extern int32_t add2(int32_t x, int32_t y);
extern int32_t add3(int32_t x, int32_t y, int32_t z);

int main(void) {

	uint32_t a, b, c, d;
	a = 100;
	b = -200;

	c = add2(a, b);

	printf("c = %d\n", c);
	
	d = add3(a, b, c);
	
	printf("d = %d\n", d);

	return EXIT_SUCCESS;

}
