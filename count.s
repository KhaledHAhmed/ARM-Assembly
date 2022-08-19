.global countUpToFifty
.global countDownToZero

.text

@ int32_t countUpToFifty(int32_t x);
@	R0						R0
@ perform x++ until x >= 50

countUpToFifty:
	MOV R1, #50			@ Place upper bound in register
loopUp:
	CMP R0, R1			@ Compare present value against upper bound
	BGE exit			@ If present value greater than or equal to upper bound,
						@ jump to exit
	ADD	R0, R0, #1		@ Add 1 to the present value of x
	B loopUp			@ Jump to loopUp


@ int32_t countDownToZero(int32_t x);
@ 	R0						  R0
@ perform x-- until x <= 0

countDownToZero:
loopDown:
	CMP R0, #0			@ Compare present value of x against 0
	BLE exit			@ If x less than or equal to zero, jump to exit
	SUB R0, R0, #1		@ Subtract 1 from present value of x
	B loopDown			@ Jump to loopDown

exit:
	BX LR
