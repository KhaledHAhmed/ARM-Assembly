.global add2 @ Indicate the contents of the file
.global add3

.text  @ Tell the assembler our code begins at this point

@ int32_t add2(int32_t x, int32_t y);
@					R0, 	R1

add2:
	ADD R0, R0, R1 @ R0 = x + y
	BX LR

@ int32_t add3(int32_t x, int32_t y, int32_t z);
@				            	R0		     R1		     	R2

add3:
	ADD R0, R0, R1 @ R0 = x + y
	ADD R0, R0, R2 @ R0 = R0 + z
	BX LR
