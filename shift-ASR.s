.global shift8
.global shift32

.text

@  int32_t shift(int32_t x, int32_t y);
@     R0,			R0, 		R1

shift8:
shift32:
	MOV R0, R0, LSR R1 @ Change LSR to ASR to see difference in output
	BX LR
