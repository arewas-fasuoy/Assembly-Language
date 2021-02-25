;-----------------PROGRAMM FOR RESTRAUNT MENU SYSTEM------------------
[org 0x0100]

section .text

    jmp startt

;SUBROUTINE TO CLEAR SCREEN
 clrscr:
    push es
    push ax
    push cx
    push di

    mov  ax, 0xb800
    mov  es, ax
    xor  di, di
    mov  ax, 0x0720
    mov  cx, 2000

    cld               
    rep stosw          

    pop di
    pop  cx
    pop  ax
    pop  es
    ret
; -------------------------------------------------

;SUBROUTINE TO PRINT MAIN MENU
main_menu:
    push bp
    mov  bp, sp
    push es
    push ax
    push cx 
    push si 
    push di 

    mov ax, 0xb800 
    mov es, ax          ;loading into ex 0xb800
    
    ;printing msg1 
    mov di, 2920                     
    mov si, [bp + 28]
    mov cx, [bp + 30]
    mov ah, 0x03         ;for changing style byte

    call printstr
    call newline
    call newline

    ;printing msg2
    mov di, 2880
    mov si, [bp + 24]
    mov cx, [bp + 26]
    call newline
    mov ah, 0x07 
    call printstr

    call newline
    call newline

    ;printing msg3
    mov di, 2880
    mov si, [bp + 20]
    mov cx, [bp + 22]
    mov ah, 0x07
    call printstr

    ;printing msg4
    mov di, 2880
    mov si, [bp + 16]
    mov cx, [bp + 18]
    call newline
    mov ah, 0x07
    call printstr

    ;printing msg5
    mov di, 2880
    mov si, [bp + 12]
    mov cx, [bp + 14]
    call newline
    mov ah, 0x07
    call printstr

    ;printing msg6
    mov di, 2880
    mov si, [bp + 8]
    mov cx, [bp + 10]
    call newline
    mov ah, 0x07
    call printstr

    call newline
    call newline 

    ;printing stars
    mov di, 2920               
    mov si, [bp + 4]
    mov cx, [bp + 6]
    mov ah, 0x03      ;for changing style byte
    call printstr


    pop di 
    pop si 
    pop cx 
    pop ax 
    pop es 
    pop bp 
    ret 28 
;---------------------------------------------------------

;PRINT STRING CHARACTER WISE
printstr:
  nextchar: 
        mov al, [si]           ; char to print     
        mov [es:di], ax        ; load char to vedio memory
        add di, 2              ; jmp to next cell of vedio memory   
        add si, 1              ; jmp to next char

        loop nextchar
 
    ret
;---------------------------------------------------------

;SUBROUTINE TO CALCULATE LENGTH OF STRING
strlen:
    push bp
    mov  bp,sp
    push es
    push cx
    push di

    les  di, [bp+4]     ; load DI from BP+4 and ES from BP+6
    mov  cx, 0xffff    
    
    xor  al, al       
    repne scasb         

    mov  ax, 0xffff     
    sub  ax, cx         ; find how many times CX was decremented 

    dec  ax             ; exclude null from the length 

    pop  di
    pop  cx
    pop  es
    pop  bp
    ret  4
;---------------------------------------------------------

;SUBROUTINE TO PRINT NEWLINE
newline: 
    mov ah,2            ; insert newline
    mov dl, 0AH
    int 21h 

    mov dl, 0DH         ; carriage return
    int 21h
    ret 
;---------------------------------------------------------

;EXIT FROM PROGRAMM
    exit:
    call clrscr

    lea dx,[bye]       ; display thankyou msg      
    mov ah,9
    int 21h

    call newline
    call newline

    mov ah,0x4c        ;terminate from programm 
    int 21h
;----------------------------------------------------------

;SUBROUTINE TO CALCULATE BILL
calculate_bill:
   
    call newline
    call newline

    lea dx,[msg7]       ; print string
    mov ah,9
    int 21h

    mov ah,1            ; take input
    int 21h

    sub al,30H          ; convert to ASCII
    mov [val1],al       ; store at val1

    call newline 
    lea dx,[msg8]
    mov ah,9
    int 21h

    mov ah,1
    int 21h

    sub al,30H
    mov [val2],al
    mul byte[val1]      ; multiply price with quantity
    add [total],ax      ; store in total for later adding more prices to it 
    mov ax,[total]

    add ah,30H          ; convert back from ASCII
    add al,30H
    mov bx,ax
    call newline
    call newline

    lea dx,[msg9]
    mov ah,9
    int 21h

    mov ah,2            ; print total 
    mov dl,bh
    int 21h
    mov ah,2
    mov dl,bl
    int 21h
    call newline
    call newline

    lea dx,[msg10]      ; prompt to exit or continue
    mov ah,9
    int 21h

    mov ah,1            ; take input
    int 21h

    mov bl,al
    
    mov ah,1                
    int 21h

    cmp bl,'1'
    je startt
    call exit

    ret
;----------------------------------------------------------------- 
;MAIN OF PROGRAMM
startt: 
    call clrscr 

    ;calculate lenghth for msg1
    push ds
    mov  ax, msg1
    push ax
    call strlen          ; return value is in AX

    ;push lenght and msg on stack (inorder to call main_menu subroutine)
    push ax 
    mov ax, msg1 
    push ax

    ;for msg2
    push ds
    mov  ax, msg2
    push ax
    call strlen          

    push ax 
    mov ax, msg2 
    push ax 


    ;for msg3
    push ds
    mov  ax, msg3
    push ax
    call strlen          

    push ax 
    mov ax, msg3 
    push ax


    ;for msg4
    push ds
    mov  ax, msg4
    push ax
    call strlen         

    push ax 
    mov ax, msg4 
    push ax
 

    ;for msg5
    push ds
    mov  ax, msg5
    push ax
    call strlen         

    push ax 
    mov ax, msg5 
    push ax
    

    ;for msg6 
    push ds
    mov  ax, msg6
    push ax
    call strlen         

    push ax 
    mov ax, msg6 
    push ax

    ;for stars
    push ds
    mov  ax, stars
    push ax
    call strlen          

    push ax 
    mov ax, stars 
    push ax
 
    call main_menu 

    mov bl, 0  
    call newline
    
    lea dx,[MSG5]   ;for printing string
    mov ah,9
    int 21h
    
    
    mov ah, 1        ; read a character
    int 21h


    mov bl,al
    
    mov ah,1                
    int 21h
    
    cmp bl, '1'
    je appetizers
    cmp bl, '2'
    je maindish
    cmp bl, '3'
    je desserts
    cmp bl, '4'
    je exit


;DISPLAY MENU FOR APPETIZERS    
appetizers:
    call clrscr
    call newline

    lea dx,[menu1]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    ; display items
    lea dx,[item1]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item2]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item3]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[exitmsg]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline

    lea dx,[line]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    mov bl, 0  
    call newline
    
    lea dx,[MSG5]
    mov ah,9
    int 21h                 ; menu display ends here 

    mov ah,1                ; take input to choose item
    int 21h


    mov bl,al
    
    mov ah,1                
    int 21h
    
    cmp bl, '4'
    je startt
    call calculate_bill
;-----------------------------------------------------------    

;DISPLAY MENU FOR MAINDISH
maindish:
    call clrscr
    call newline

    lea dx,[menu2]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    ; display items
    lea dx,[item4]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item5]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item6]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[exitmsg]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline

    lea dx,[line]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    mov bl, 0  
    call newline
    
    lea dx,[MSG5]
    mov ah,9
    int 21h                 ; menu display ends here 

    mov ah,1                ; take input to choose item
    int 21h


    mov bl,al
    
    mov ah,1                
    int 21h
    
    cmp bl, '4'
    je startt
    call calculate_bill
;------------------------------------------------------------------    
    
;DISPLAY MENU FOR DESSERTS    
desserts:
    call clrscr
    call newline

    lea dx,[menu3]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    ; display items
    lea dx,[item7]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item8]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[item9]
    mov ah,9
    int 21h

    call newline
    call newline

    lea dx,[exitmsg]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline

    lea dx,[line]
    mov ah,9
    int 21h

    call newline
    call newline
    call newline
    
    mov bl, 0  
    call newline
    
    lea dx,[MSG5]
    mov ah,9
    int 21h                 ; menu display ends here 

    mov ah,1                ; take input to choose item
    int 21h

    mov bl,al

    mov ah,1                
    int 21h

    
    cmp bl, '4'
    je startt
    call calculate_bill
;--------------------------------------------------------------

;DATA
section .data

  msg1: db '******** WELCOME TO OUR RESTAURANT *******', 0
  msg2: db '------MAIN MENU------ ',0
  msg3: db '1- Appetizers.',0
  msg4: db '2- Main Dishes',0
  msg5: db '3- Desserts.',0
  msg6: db '4- Exit From Menu.',0
  stars: db '*****************************************', 0
  line: db '--------------------------------------------$' 
  MSG5 DB 'Your Choice: $'
  menu1: db '----------------APPETIZERS------------------$'
  item1: db '1-Fish Crackers.       RS. 5.0/-$'
  item2: db '2-Chicken Wings.       RS. 2.0/-$'
  item3: db '3-Fish Fillets.        RS. 3.0/-$'
  menu2: db '----------------MAIN DISHES------------------$'
  item4: db '1-Mashroom Stake.      RS. 6.0/-$'
  item5: db '2-Fried Rice.          RS. 7.0/-$'
  item6: db '3-Fish Curry.          RS. 9.0/-$'
  menu3: db '------------------Desserts-------------------$'
  item7: db '1-Molten Lava Cake.    RS. 8.0/-$'
  item8: db '2-Ice Cake.            RS. 3.0/-$'
  item9: db '3-Brownies.            RS. 6.0/-$'
  exitmsg: db '4-Go Back to Main Menu.$'
  bye: db '                     ****** THANK YOU !! ******$'
  msg7: db 'Enter Price of the Item: $'
  msg8: db 'Enter Quantity  $'
  msg9: db 'TOTAL: $'
  total: dw 0
  msg10: db 'Press 1 to continue OR Press 0 exit: $'
  MSG times 10 db ('$') ;to input string
  val1: db 0
  val2: db 0
;----------------------------------END OF PROGRAMM------------------------------------------