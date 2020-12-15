; 16 bit division

[org 0x0100]

; EXAMPLE 01 :- Dividing 8/2=4 
mov ax, 0
mov bx, 0

mov ax, [dividend]
mov bl, [diviser]

div bl	; this means 8/2 or AX/BL ( result :- AL = qoutient and AH = remainder )

; EXAMPLE 02 :- Dividing 50/32= 1 (qoutient) and 18 (remainder)
mov ax, 0
mov bx, 0

mov ax, [dividend+2]
mov bl, [diviser+1]

div bl 	; this means 50/32 or AX/BL ( result :- AL = qoutient and AH = remainder )

mov ax, 0x4c00 
int 0x21 

dividend: dw 47, 50
diviser: db 10, 32