;programm to find the most repeated number in array
[ORG 0x0100]
mov ax, 0
mov bx, 0
mov cx, 9
outerloop:
	mov si, 2
	innerloop:
		mov ax, [data+bx]
		cmp ax, [data+bx+si]
		jne label
			mov dx, [data+bx+si]
			
			
	label:
	add si, 2
	cmp si, 18
	jne innerloop

	


l2:add bx, 2
	sub cx, 1
	jnz outerloop

mov ax, 0x4c00
int 0x21 

data: dw 1, 2, 5, 5, 8, 7, 8,6, 8, 3
count: dw 0
