;programm for adding list of numbers
[ORG 0x0100]

	mov bx, num 	; loading address of num into bx
	mov cx, 10	; moving constant 10 to cx register
	mov ax, 0	; moving 0 to register ax 
; loop
l1: add ax, [bx]	; adding value, at address stored in bx, to ax
	add bx, 2	; taking 2 byte jump
	sub cx, 1	; decrementing value of cx by 1
	jnz l1		; jump, if zero flag is not set, to label l1

	mov [total], ax	; storing value of ax in total 
	
	mov ax, 0x4c00
	int 0x21

num: dw 10,20,30,40,50,10,20,30,50,50
total: dw 0
