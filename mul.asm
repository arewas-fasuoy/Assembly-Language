; multiplying two bytes

[org 0x0100]

; EXAMPLE 01 :- Multiplying 4x3=12
mov ax, 0
mov bx,0

mov al,[multiplicand]
mov bl,[multiplier]

mul bl ; this means 4x2 or ALxBL (result will be stored in AX)

; EXAMPLE 02 :- Multiplying 50x16=800
mov ax,0
mov bx,0

mov al,[multiplicand+1]
mov bl,[multiplier+1]

mul bl ; this means 50x16 or ALxBL (result will be stored in AX)

mov ax, 0x4c00 
int 0x21 

multiplicand: db 4, 50
multiplier: db 3, 16