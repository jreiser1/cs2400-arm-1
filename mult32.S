		;		ARM Programming Assignment #1: 32 bit multiplier
		;
		;		Write a 32-bit multiplier.
		;		Use the standard shift-and-add operation.
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.
		
		
		
		;		CHECK STACKOVERFLOW FOR THE ANSWER
		
numbers	DCD		0x5, 0x3
result	FILL		8
carry	FILL		4
		
		adr		r0, numbers
		ldr		r1, [r0], #4
		ldr		r2, [r0]
		stmdb	sp!, {r1, r2}
		bl		mult
		adr		r1, result
		str		r0, [r1]
		adr		r1, carry
		str		r2, [r1]
		
		end
		
mult
		ldmia	sp!, {r0, r1} ;load operands onto the stack
		stmdb	sp!, {r4, r5, r7}
		mov		r2, #1	;shift tracking bit
		mov		r3, #-1	;counter (have to start at -1 because incrementation happens immediately)
		mov		r4, #0	;result register
		mov		r5, #0	;temp
loop
		cmp		r3, #33	;compare to make sure result isnt too large
		beq		move
		tst		r2, r0	; testing bit to see if its 1
		lsl		r2, r2, #1	; shift r2 left by 1 bit
		add		r3, r3, #1
		beq		loop
		mov		r5, r1 ;storing r1 into temp register
		lsl		r5, r5, r3
		adds		r4, r4, r5
		movcs	r7, #1 ;if carry set to 1, move 1 into r7 to act as flag
		bal		loop
		
move
		mov		r0, r4
		mov		r2, r7
		ldmia	sp!, {r4, r5, r7}
		mov		pc, lr
		
