#include<stdio.h>
#include<stdlib.h>
#include<stdint.h>
#include<stdbool.h>

extern bool isEven(int32_t x);

int main(void) {

	int32_t a;
	
	printf("Input a number: ");
	scanf("%d", &a);

	printf("A = %d and is ", a);

	if(isEven(a)) {
		printf("even\n");
	}
	else {
		printf("odd\n");
	}
	return EXIT_SUCCESS;
}
