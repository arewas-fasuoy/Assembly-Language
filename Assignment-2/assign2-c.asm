;programm to add and subtract 1 from integers at even and odd indices respectively

;logic used: start from LSB and flip all bits one by one until you find a zero bit(from rightside).
;Finaly flip that first found zero bit as well
;for subtraction do the opposite

[org 0x0100]
jmp start

array: dw 23,65,12,6,45,38,44,9,87,100
num: dw 0

start:
	mov cx, 0
	mov ax, 0
	mov bx, 0

even_loop:						;this loop is to add 1 in integers at even indices
	mov word[num], 1
	mov cx, [array+bx]
	
	loop1:
		mov ax, [num]			
		AND ax, cx				;check if bit is 0 or 1
		cmp ax, [num]			
		jnz stop1				;jump will be taken if bit is zero
			xor cx, [num]		;xor num with cx to flip the bit at cx
			shl [num], 1		;shift num to left by 1 in order to move to the next bit on right for the nect iteration
			jmp loop1

	stop1:
		xor cx, [num]			;this will xor the first zero bit found 
		mov [array+bx], cx		;overwrite the old value in array with new one
		add bx, 4
		cmp bx, 20				
		jne even_loop

mov cx, 0
mov bx, 2
mov ax, 0

odd_loop:						;this loop is to subtract 1 from integers at odd indices
	mov word[num], 1
	mov cx, [array+bx]
	
	loop2:
		mov ax, [num]
		AND ax, cx
		cmp ax, [num]
		jz stop2
			xor cx, [num]
			shl [num], 1
			jmp loop2

	stop2:
		xor cx, [num]
		mov [array+bx], cx
		add bx, 4
		cmp bx, 22
		jne odd_loop


mov ax, 0x4c00
int 0x21







