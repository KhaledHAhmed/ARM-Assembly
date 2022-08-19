.global isEven

.text 

@ bool isEven(int32_t x);

isEven:
	AND R0, R0, #1 	@ apply a mask to R0
					@ '1' in binary is 00000000 00000000 00000000 00000001
	EOR R0, R0, #1	@ Perform exclusive OR on last bit
	BX LR