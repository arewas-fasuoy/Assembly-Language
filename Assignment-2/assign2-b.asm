;programm to count the number of even and odd integers in an array using only TEST instruction

[org 0x0100]		

jmp start

num: dw 2,3,6,4,8,67,32			 	;initialising array
evencount: dw 0

start:
	mov ax,0
	mov bx,0
	mov cx,0

loop:
	mov ax, [num+bx]				;iterating through array
	test ax, 1						;checking if LSB of num is 0 or not 
	jnz end
		add word[evencount],1		;adding 1 in even count if LSB is 0

	end:
		add cx,1					;this will count the total number of elements present in array
		add bx,2
		cmp bx,14
		jne loop

	mov ax, [evencount]				;ax will contain the count of even integers
	sub cx, ax						;cx will contain the count of odd integers (oddCount = totalCount - evenCount)
					

mov ax,0x4c00
int 0x21