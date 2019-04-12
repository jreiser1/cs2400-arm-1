		;		ARM Programming Assignment #1: Capitalizer
		;
		;		Write a program that goes through the characters in chars,
		;		and Capitalizes every lower-case letter that it finds..
		;		Write the number of capitalizations the program performed
		;		In the caps "fill" memory provided.
		
		;		Your code here
		
chars	DCD		'a', 'B', '5', 'q', '0', 'O', '1', 's', 'b', 'i', 'G'
caps		FILL		4
		
		
		adr		r0, chars
		;		array index
		mov		r1, #0
		;		num of capitalizations
		mov		r3, #0
		
loop
		;actual	data pulled from array
		ldr		r2, [r0,r1]
		cmp		r2, #0x60
		subgt	r2, r2, #32
		addgt	r3, r3, #1
		add		r1, r1, #4
		cmp		r1, #44
		bne		loop
		
		adr		r0, caps
		str		r3, [r0]
		
		END