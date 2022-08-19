#include<stdio.h>
#include<stdint.h>
#include<stdlib.h>

void printBinary32(int32_t x) {
	uint32_t i;
	for(i = 1 << 31; i > 0; i = i / 2) {
		if(i & x) {
			printf("1");
		}
		else {
			printf("0");
		}
	}
	printf("\n");
}

void printBinary16(int16_t x) {
	uint16_t i;
	for(i = 1 << 15; i > 0; i = i / 2) {
		if(i & x) {
			printf("1");
		}
		else {
			printf("0");
		}
	}
	printf("\n");
}

void printBinary8(int8_t x) {
	uint8_t i;
	for(i = 1 << 7; i > 0; i = i / 2) {
		if(i & x) {
			printf("1");
		}
		else {
			printf("0");
		}
	}
	printf("\n");
}
	
