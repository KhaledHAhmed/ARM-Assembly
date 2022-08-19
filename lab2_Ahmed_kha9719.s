.global stringCopy
.global stringCat
.global sumS32
.global sumS16
.global sumU32_64
.global countNegative
.global countNonNegative
.global countMatches
.global returnMax
.global returnMin

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
	MOV R4 , R1
	MOV R1 , #0
sum_loop2:
	LDR R3, [R2], #4
	ADDS R0 , R0 , R3
	ADC  R1, R1 , #0
	SUBS R4 , R4 , #1
	BNE sum_loop2

	BX LR

@ uint32_t countNegative (int16_t x[], uint32_t count);
@     R0                        R0   ,    R1

countNegative:

    MOV R2 , R0
	MOV R0 , #0
	MOV R3 , #0

count_loop:

	LDRSH R3 , [R2], #2
	CMP  R3 , #0
	ADDLT R0 , R0 , #1
	SUBS R1 , R1 , #1
	BNE count_loop

	BX LR

@ uint32_t countNonNegative (int16_t x[], uint32_t count);
@  R0                            R0         R1

countNonNegative:
	MOV R2 , R0
	MOV R0 , #0
	MOV R3 , #0

countn_loop:

	LDRSH R3 , [R2], #2
	CMP  R3 , #0
	ADDGE R0 , R0 , #1
	SUBS R1 , R1 , #1
	BNE countn_loop
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
	LDRSH R3, [R2], #2
	CMP  R3, R0
	MOVGT R0,R3
	@CMP R3 , #0
	SUBS R1 , R1 , #1
	BNE max_loop
	BX LR

@ int32_t returnMin(int16_t x[], uint32_t count);
@  R0                    R0    ,    R1

returnMin:
	MOV R2 , R0
	MOV R0 , #0
min_loop:

	LDRSH R3, [R2], #2
	CMP  R3, R0
	MOVLT R0,R3
	SUBS R1 , R1 , #1
	BNE min_loop

	BX LR
