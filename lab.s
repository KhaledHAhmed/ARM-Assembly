#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <stdbool.h>

extern void stringCopy(char* strTo, char* strFrom); // copies strFrom to strTo
extern void stringCat(char* strFrom, char* strTo); // adds strFrom to end of strTo
extern int32_t sumS32(int32_t x[], int32_t count);
extern int32_t sumS16(int16_t x[], int32_t count);
extern uint64_t sumU32_64(uint32_t x[], uint32_t count);
extern uint32_t countNegative (int16_t x[], uint32_t count);
//extern uint32_t countNonNegative (int16_t x[], uint32_t count);
extern uint32_t countMatches(char str[], char toMatch);
extern int32_t returnMax(int16_t x[], uint32_t count);

#define COUNT 5

int main(void) {

int32_t resultS32;
int16_t arrayInt16[COUNT] = {129, 256, 512, 1024, 2048};
int32_t arrayInt32[COUNT] = {128, 255, 511, 1023, 2047};

int16_t divisor[COUNT] = {1, 2, 3, 4, 6};

uint64_t resultU64;
uint32_t resultU32;
uint32_t arrayUint32[COUNT] = {4000000001, 4000000001, 4000000001, 4000000001, 4000000001};

uint8_t resultU8;

bool resultB;

char test1[20] = "aaaaaaa";
char test2[44] = "bbbbbbb";

stringCopy(test1, test2);

printf("Question 1, stringCopy: Correct answer = bbbbbbb\n");
printf("Question 1, stringCopy: Student answer = %s\n\n", test1);

char test3[20] = "aaaaaaa";
char test4[44] = "bbbbbbb";

stringCat(test3, test4);

printf("Question 2, stringCat: Correct answer = bbbbbbbaaaaaaa\n");
printf("Question 2, stringCat: Student answer = %s\n\n", test4);

printf("Question 3, sumS32: Correct answer = 3964\n");
printf("Question 3, sumS32: Student answer = %d\n\n", sumS32(arrayInt32, COUNT));

printf("Question 4, sumS16: Correct answer = 16\n");
printf("Question 4, sumS16: Student answer = %d\n\n", sumS16(divisor, COUNT));

printf("Question 5, sumU32_64: Correct answer = 20000000005\n");
printf("Question 5, sumU32_64: Student answer = %lld\n\n", sumU32_64(arrayUint32, COUNT));

arrayInt16[2] = 0;
arrayInt16[3] = -1;
arrayInt16[4] = -2047;

printf("Question 6, countNegative: Correct answer = 2\n");
printf("Question 6, countNegative: Student answer = %u\n\n", countNegative(arrayInt16, COUNT));

//printf("Question 7, countNonNegative: Correct answer = 3\n");
//printf("Question 7, countNonNegative: Student answer = %u\n\n", countNonNegative(arrayInt16, COUNT));

char str[] = "aabbccddeeffgghhiijjkkllmmnnooppqqrrss";

printf("Question 8, countMatches: Correct Answer = 2\n");
printf("Question 8, countMatches: Student Answer = %u\n\n", countMatches(str,'s'));

printf("Question 9, returnMax: Correct Answer = 256\n");
printf("Question 9, returnMax: Student Answer = %d\n\n", returnMax(arrayInt16, COUNT));

return EXIT_SUCCESS;

}


//// assembly:

.global stringCopy
.global stringCat
.global sumS32
.global sumS16
.global sumU32_64
.global countNegative
.global countMatches
.global returnMax

.text

@ void stringCopy(char* strTo, char* strFrom);
@                  R0        ,    R1

stringCopy:

copy_loop1:
	LDRB R2, [R1], #1
	STRB R2, [R0], #1
	CMP R2, #0 @ Check for null-terminator
	BNE copy_loop1
	BX LR


@ void stringCat(char* strFrom, char* strTo);
@                     R0      ,      R1

stringCat:
	MOV R2 , R1
	MOV R4 , R0
	MOV R0 , R1

cpy_loop:
    LDRB R3, [R2], #1
    CMP R3, #0 @ Check for null-terminator
	BNE cpy_loop
	SUB R2, R2, #1
cpy_loop1:
	LDRB R5, [R4], #1
	STRB R5, [R2], #1
	CMP R5, #0 @ Check for null-terminator
	BNE cpy_loop1
	BX LR

@ int32_t sumS32(int32_t x[], int32_t count);
@    R0             R0      ,    R1

sumS32:
	MOV R2 , R0
	MOV R0 , #0
sum_loop:
	LDR R3, [R2], #4
	ADD R0 , R0 , R3
	SUBS R1 , R1 , #1
	BNE sum_loop
	@CMP R1 , #0
	@BEQ  end
	@B sum_loop

	@end:
	BX LR

 @ int32_t sumS16(int16_t x[], int32_t count);
 @  R0                R0     ,       R1

sumS16:
	MOV R2 , R0
	MOV R0 , #0
sum_loop1:
	LDRH R3, [R2], #2
	ADD R0 , R0 , R3
	SUBS R1 , R1 , #1
	BNE sum_loop1

	BX LR

@ uint64_t sumU32_64(uint32_t x[], uint32_t count);
@    R0                   R0     ,     R1

sumU32_64:
	MOV R2 , R0
	MOV R0 , #0
sum_loop2:
	LDR R3, [R2], #4
	ADD R0 , R0 , R3
	SUBS R1 , R1 , #1
	BNE sum_loop2
	@ MOV R4 , #0
	@ADDS R0 , R0 , R4
	@MOV R4 , #0
	@ADC R4 , R4 , #0

	BX LR

@ uint32_t countNegative (int16_t x[], uint32_t count);
@     R0                        R0   ,    R1

countNegative:
	MOV R2 , R0
	MOV R0 , #0

count_loop:
	LDRH R3, [R2], #2
	CMP R3 , #0
	ADDMI R0 , R0 , #1

	SUB R1 , R1 , #1
	CMP R1 , #0
	BNE count_loop

	BX LR

@ uint32_t countMatches(char str[], char toMatch);
@  R0                         R0  ,      R1

countMatches:
	MOV R2 , R0
	MOV R0 , #0
count_loop1:
	LDRB R3, [R2], #1
	CMP  R3, R1
	ADDEQ R0 , R0 , #1
	CMP R3 , #0
	BNE count_loop1
	BX LR

@ int32_t returnMax(int16_t x[], uint32_t count);
@  R0                      R0  ,      R1

returnMax:
	MOV R2 , R0
	MOV R0 , #0
max_loop:
	LDRH R3, [R2], #2
	CMP  R3, R2
	MOVGT R0,R3
	CMP R3 , #0
	BNE max_loop
	BX LR
