;programm to find number whose digits have maximum sum

[org 0x0100]

jmp start

data: dw 47,72,31

findMax:                   ; subroutine  to find number whose digits has max sum
	
	push bp
	mov bp,sp
	
	sub sp,2			   ; local variable to store the number
	
	push ax
	push bx                ; storing prev values of the registers that we will modify in subroutine
	push cx
	push si
	
	mov word[bp-2],0       ; initializing local variable to 0
	
	mov bx,[bp+6]          ; accessing arguments passed to subroutine
	
	mov si,0
	mov cx,10
	mov dx,0

	loop:
		xor ax,ax
		xor dx, dx
		mov ax,[bx+si]
		div cx
		add ax,dx
		mov dx,[bx+si]
		cmp ax,[bp-2]
		jbe skip
			mov [bp-2],dx  ; storing number, in local variable, whose digits have max sum
		
		skip:
		add si,2
		cmp si,[bp+4]      ; [bp+4] contains 4 which was passed as argument to subroutine
		jne loop

		mov dx,[bp-2]	   ; stroing the val of local var in dx
		
		pop si
		pop cx             ; doing all necessary pops
		pop bx
		pop ax
		mov sp,bp
		pop bp
		
		ret 4             ; getting back to initial(original) state

start:
	mov ax,data
	mov bx,4

	push ax				 ; passing arguments
	push bx

	call findMax		
	; check dx for the value returned from subroutine 

mov ax, 0x4c00 
int 0x21 