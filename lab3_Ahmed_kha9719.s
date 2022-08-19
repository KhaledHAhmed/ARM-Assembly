.global sortDecendingInPlace
.global sumF32
.global maxF32
.global prodF64
.global dotpF64
.global absSumF64
.global sqrtSumF64
.global getDirection
.global getAddNo
.global getCity

.text

@ void sortDecendingInPlace (int16_t x[], uint32_t count);
@                                R0     ,    R1

sortDecendingInPlace:
	PUSH {R4, R5, R6}
SORT_MAIN_LOOP:
	MOV R4, R0
	MOV R2, #0
	MOV R6, R1
	LDRSH R3, [R0]
SORT_LOOP_START:
	SUBS R6, R6, #1
	CMP R6, #0
	BEQ INCREMENT_REGISTER
	ADD R2, R2, #2
	ADD R4, R4, #2
	LDRSH R5, [R4]
	CMP R3, R5
	BMI SWAP_DATA
	B SORT_LOOP_START
SWAP_DATA:
	STRH R5, [R0]
	ADD R0, R0, R2
	STRH R3, [R0]
	SUB R0, R0, R2
	MOV R3, R5
	B SORT_LOOP_START
INCREMENT_REGISTER:
	ADD R0, R0, #2
	SUBS R1, R1, #1
	CMP R1, #0
	BEQ sortDecendingInPlace_end
	B SORT_MAIN_LOOP
sortDecendingInPlace_end:
	POP {R4, R5, R6}

BX LR



@ float sumF32(float x[], uint32_t count);
@  R0            R0     , R1

sumF32:
	MOV R2, #0
	VMOV S0, R2

fsum_loop:
	CMP R1, #0
	BEQ fsum_end
	VLDR.F32 S1, [R0]
	VADD.F32 S0, S0, S1
	SUB R1, R1, #1
	ADD R0, R0, #4
	B fsum_loop

fsum_end:
	VMOV R0, S0

BX LR


@ float maxF32(float x[], uint32_t count);
@  R0               R0  ,      R1

maxF32:
	MOV R2, #0
	VMOV S0, R2
  VMOV S2, R0

max_loop:
	CMP R1, #0
	BEQ max_end
	VLDR.F32 S1, [R0]
  VCMP.F32 S1, S0
	VMOVGT.F32 S0,S1
	SUB R1, R1, #1
	ADD R0, R0, #4
	B max_loop

max_end:

	MOV R0, #0
	VMOV R0, S0

BX LR

@ char getDirection (BUSINESS business[], uint32_t index);
@ R0                           R0       ,       R1

getDirection:

    MOV R3, #120
    MUL R2, R1, R3
    ADD R0, R0, #44
    ADD R0, R0, R2
    LDR R0, [R0]


BX LR


@ uint32_t getAddNo (BUSINESS business[], uint32_t index);
@ R0                             R0     ,   R1

getAddNo:
   MOV R3, #120
   MUL R2, R1, R3
   ADD R0, R0, #40
   ADD R0, R0, R2
   LDR R0, [R0]

BX LR

@ char * getCity(BUSINESS business[], uint32_t index);
@  R0                       R0      ,   R1

getCity:
     MOV R3, #120
     MUL R2, R1, R3
     ADD R0, R0, #78
     ADD R0, R0, R2

BX LR

@ double prodF64(double x[], uint32_t count);
@ R1:R0             R0     , R1

prodF64:

	MOV R2, #0
	VMOV D0, R2, R2
	MOV R3 , #1
  VMOV S4, R3
	VCVT.F64.U32 D0, S4
prod_loop:
	CMP R1, #0
	BEQ prod_end
	VLDR.F64 D1, [R0]
	VMUL.F64 D0, D0, D1
	SUB R1, R1, #1
	ADD R0, R0, #8

	B prod_loop

prod_end:
	VMOV R0, R1, D0 @ Move D0 to R1:R0
BX LR

@ double absSumF64 (double x[], uint32_t count);
@ R1:R0                  R0      ,    R1

absSumF64:

	MOV R2, #0
	VMOV D0, R2, R2

abs_sum_loop:
	CMP R1, #0
	BEQ abs_sum_end
	VLDR.F64 D1, [R0]
	VADD.F64 D0, D0, D1
	SUB R1, R1, #1
	ADD R0, R0, #8
	B abs_sum_loop

abs_sum_end:
	VABS.F64 D0, D0
	VMOV R0, R1, D0

BX LR

@ double sqrtSumF64(double x[], uint32_t count);
@ R1:R0                  R0   ,    R1

sqrtSumF64:
	MOV R2, #0
	VMOV D0, R2, R2

sqrt_sum_loop:
	CMP R1, #0
	BEQ sqrt_sum_end
	VLDR.F64 D1, [R0]
	VADD.F64 D0, D0, D1
	SUB R1, R1, #1
	ADD R0, R0, #8
	B sqrt_sum_loop

sqrt_sum_end:
	VSQRT.F64 D0, D0
	VMOV R0, R1, D0

BX LR

@ double dotpF64(double x[], double y[], uint32_t count);
@ R1:R0           R0       ,  R1       ,   R2

dotpF64:

	 MOV R3, #0
	VMOV D0, R3, R3
	VMOV D1, R3, R3
	VMOV D2, R3, R3
	VMOV D3, R3, R3

dotp_loop:
	CMP R2, #0
	BEQ dotp_end
	VLDR.F64 D1, [R0]
	VLDR.F64 D2, [R1]
	VMUL.F64 D3, D1, D2
	VADD.F64 D0, D0, D3
	SUB R2, R2, #1
	ADD R0, R0, #8
	ADD R1, R1, #8

	B dotp_loop

dotp_end:
	MOV R0, #0
	MOV R1, #0
	VMOV R0, R1, D0 @ Move D0 to R1:R0

BX LR
