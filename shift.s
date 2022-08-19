.global shiftBy

.text

@ int32_t shiftBy(int32_t x, int32_t y);
@    R0			          	R0			R1

shiftBy:
	MOV R0, R0, LSL R1 	@ Execute a logical shift left by number of
						@ positions specificed in R1
	BX LR
