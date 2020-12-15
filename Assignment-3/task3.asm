;nested subroutines

[org 0x0100]

jmp start

num1: dw 12
num2: dw 12

add2:						; this subroutine have 3 parameters
	push bp
	mov bp,sp

	sub sp,2				; making local variable to store sum

	push ax
	push bx                 ; pushing registers that will be used in subroutine
	push cx

	mov word[bp-2],0        ; initialising local var to 0

	mov ax,[bp+8]
	mov bx,[bp+6]			; accessing arguments passed to subroutine
	mov cx,[bp+4]

	add word[bp-2],ax
	add word[bp-2],bx      ; adding all three arguments
	add word[bp-2],cx

	mov dx,[bp-2]		   ; storing result in dx (to access outside subroutine)

	pop cx
	pop bx
	pop ax                 ; making necessary pops
	mov sp,bp
	pop bp

	ret 6				   ; going back to previous state


add1:                      ;this subroutine have 2 parameters
	push bp
	mov bp,sp

	sub sp,2			   ; local var of add1

	push ax
	push bx				   ; pushing prev registers 
	push cx

	mov word[bp-2],0	   ; initialising local var to 0

	mov ax,[bp+6]          ; accessing arguments passed to this function
	mov bx,[bp+4]

	add word[bp-2],ax	   ; adding a+b
	add word[bp-2],bx

	mov cx,[bp-2]          ; storing result 

	push ax
	push bx				   ; passing arguments for add2
	push cx

	call add2			   ; after call dx will now contain the sum of add2(cx,a,b)


	pop cx
	pop bx
	pop ax				  ; making necessary pops for add1
	mov sp, bp
	pop bp

	ret 4                 ; returning from add1 to main (original state)

start:
	mov ax,[num1]		  
	mov bx,[num2]

	push ax              ; passing arguments to add1
	push bx

	call add1
    ; check dx for final output

mov ax, 0x4c00 
int 0x21 