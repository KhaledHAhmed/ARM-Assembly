#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<stdbool.h>

extern bool isPositive(int32_t x);

int main(void) {

	int32_t a;
	
	a = 20;

	if(isPositive(a)) {
		printf("a is positive\n");
	}
	else {
		printf("a is negative\n");
	}
	return EXIT_SUCCESS;
}
