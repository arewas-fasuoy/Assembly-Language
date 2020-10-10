; programm to find square of 20 using direct addressing

[ORG 0x0100]
	
	mov ax, 0		; empty ax
	mov cx, 20		; loading 20 to register cx
	

loop: add ax, [num]		; adding value of num to ax
	sub cx, 1		; descrementing cx by 1
	jnz loop		; jump to loop if zero flag is not set

	mov [total], ax		; storing result in total
	
	mov ax, 0x4c00
	int 0x21

num: dw 20
total: dw 0
