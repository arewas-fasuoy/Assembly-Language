;programm to count even and odd numbers in array

[org 0x0100]

jmp start

data: dw 3,9,56,43,1,2,23
countEven: dw 0
countOdd: dw 0

even:						; subroutine to count even numbers
	push bp
	mov bp, sp  

	sub sp, 2               ; making a local variable to store count
	
	push ax				       
	push si                 ; pushing these registers so as to not lose their prev data
	push bx                 
	push cx  

	mov word[bp-2],0		; initialising local variable to 0
	
	mov bx, [bp+6]			; accessing the arguments passed to subroutine	
	mov si, [bp+4]

	mov cl, 2
	mov dx,0

	loop:
		mov ax, [bx+si]
		div cl
		cmp ah, 0
		jne skip
			add word[bp-2],1	; adding 1 to count(local variable)	

		skip:
		sub si,2
		cmp si,-2
		jnz loop

	mov dx,[bp-2]			; storing value of count in dx
	
	pop cx					
	pop bx                  
	pop si                 ; popping values to get back to original state before return
	pop ax
	mov sp, bp             
	pop bp

	ret 

odd:					   ; subroutine to count odd numbers
	push bp
	mov bp, sp

	sub sp, 2             ; making a local variable to store count

	push ax
	push si               ; pushing these registers so as to not lose their prev data
	push bx
	push cx

	mov word[bp-2],0      ; initialising local variable to 0

	mov bx, [bp+6]		  ; accessing the arguments passed to subroutine
	mov si, [bp+4]

	mov cl, 2
	mov dx,0

	loop1:
		mov ax, [bx+si]
		div cl
		cmp ah, 0
		jz skip1
			add word[bp-2],1   ; adding 1 to count(local variable)	
		skip1:
		sub si,2
		cmp si, -2
		jnz loop1

	mov dx,[bp-2]

	pop cx
	pop bx
	pop si
	pop ax
	mov sp, bp
	pop bp

	ret 4                ; ret 4 will pop IP and take 4 byte jump
						 ; SP will now point to it's original address

start:
	mov ax,data
	mov si,12           

	push ax
	push si

	call even
	mov [countEven],dx   ;storing evenCount

	call odd
	mov [countOdd],dx	;storing oddCount


mov ax, 0x4c00 
int 0x21 