[ORG 0x0100]

mov ax, 0
mov bx, 0
mov dx, 0
mov cx, 0
max:
	mov ax, [data+bx]
	cmp ax, [data+bx+2]
	jbe l1
		cmp dx, ax
		jae iter
			mov dx, ax

	l1:
	mov dx, [data+bx+2]

	iter:
	add bx, 2
	cmp bx, 8
	jne max

mov bx, 10
mov ax, 0

min:
	mov ax, [data+bx]
	cmp ax, [data+bx+2]
	jae l2
		mov cx, ax


	l2:
	cmp cx, ax
	jbe iter2
	mov cx, [data+bx+2]

	iter2:
	add bx, 2
	cmp bx, 18 
	jne min


add dx, cx
mov [total], dx

mov ax, 0x4c00
int 0x21 

data: dw 1, 4, 7, 9, 2, 6, 4,1, 7, 4
total: dw 0