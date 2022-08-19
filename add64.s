.global add64

.text

@ int64_t add64(int64_t x, int64_t y);
@ x = R1:R0, y = R3:R2, return = R1:R0

add64:
	ADDS R0, R0, R2 @ Add low order bits, set the flags
	ADC R1, R1, R3 @ Check the carry flag, add high order bits
	BX LR
