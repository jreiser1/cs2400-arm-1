		;		ARM Programming Assignment #1: 16 bit multiplier
		;
		;		Write a 16-bit multiplier, meaning numbers that have their high 16 bits set to 0.
		;		Use the standard shift-and-add operation.
		;		Note that we cannot address half-words here. We can only address words and bytes (B).
		;		Use the two numbers as an example but write it so it works for any two 16-bit numbers.
		;		Write the result in the provided "fill" word.
		;		Indicate if there was a high-bit carry using the provided "fill" word.
		
		
numbers	DCD		0b1100101010010001, 0b1111010101000011
result	FILL		4
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
		stmdb	sp!, {r4, r5}
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
		mov		r5, r1	 ;storing r1 into temp register
		lsl		r5, r5, r3
		adds		r4, r4, r5
		bal		loop
		
move
		mov		r0, r4, lsr #15
		cmp		r0, #0
		movne	r2, #1 ;setting carry bit
		mov		r3, #0xFF ;create first two bits of mask
		add		r3, r3, #0xFF00 ;finish creating mask for comparison
		and		r4, r4, r3 ;mask number high bits
		mov		r0, r4 ;store newly masked number into r0 for return
		ldmia	sp!, {r4, r5}
		mov		pc, lr
