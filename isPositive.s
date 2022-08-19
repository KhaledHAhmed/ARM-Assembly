.global isPositive

.text

@ bool isPositive(int32_t x);

isPositive:
	CMP R0, #0 	@ Compare (subtract) 0 from R0, set the flags
	MOV R0, #0 	@ Setup return to be 'false'
	BMI END 	@ If N is set, jump to "end:"
	BEQ END 	@ If Z is set, jump to "end:"
	MOV R0, #1 	@ If above conditionals are false, value is positive.  Return
				@ something other than 0

END:
	BX LR
