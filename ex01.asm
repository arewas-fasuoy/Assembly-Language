; programm to add two numbers
[ORG 0x100]

mov ax, 5 		; moving constant 5 into register ax
mov bx, 10		; moving constant 10 into reigster bx
add ax, bx		; adding value of bx into value of ax 

mov ax, 0x4c00
int 0x21

