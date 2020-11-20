;programm to find the minimum number of shifts to make a number 0

[org 0x0100]

jmp start

num: dw 4
count1: dw 0
count2: dw 0

start:
	mov ax,[num]
	mov bx,[num]
loop1:							    ;this loop is to count logical right shifts 
	and ax,255						;AND ax with 255 to check if the number is zero or not
	jz stop1
		shr ax,1
		add word[count1],1			;incrementing count on each shift
		jmp loop1
	stop1:
		mov cx, [count1]

loop2:								;this loop is to count logical left shifts
	and bx,255
	jz stop2
		shl bx,1
		add word[count2],1
		jmp loop2
	stop2:
		mov dx, [count2]


	cmp cx,dx						;compare both counts to find the minimum count
	jbe end
		mov cx,dx					;cx will contain the count of minimum shifts required

end:								
	mov [num],ax					;make the original 0

mov ax,0x4c00						;end of programm
int 0x21



