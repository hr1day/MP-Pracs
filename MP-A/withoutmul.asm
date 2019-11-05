data segment

msg1 db 10,13, "Enter the number: $"
msg2 db 10,13, "The result is: $"

result dw ?
num1 db ?
num2 db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax
 
    call input  
    mov num1, bl
    
    call input
    mov num2, bl

    mov ah, 00h
    mov al,num1
    mov cl,num2
    mov bx, 0000h

    A:                      
        add bx, ax
        loop A

    mov result, bx
    mov dx, offset msg2     ;Outputing result
    mov ah, 09h
    int 21h 
        
    mov bx, result
    and bx,0F000h         ;First digit
    ror bx, 0Ch 
    call output
        
    mov bx, result
    and bx,0F00h         ;Second digit
    ror bx, 08h 
    call output
        
    mov bx, result
    and bx,00F0h         ;Third digit
    ror bx, 04h 
    call output
        
    mov bx, result
    and bx,000Fh         ;Fourth digit
    call output       
    
    mov ah, 4ch
    int 21h
        
input proc                      ;Takes a 8 bit number as input and stores the 8 bit number in bl

    mov dx, offset msg1 
    mov ah, 09h
    int 21h    
    call getdigits
    mov bl,al    
    mov cl,04h       
    rol bl, cl
    call getdigits
    add bl,al 

ret
endp


getdigits proc
    mov ah, 01h
    int 21h
    cmp al, 41h
    jc X
    sub al, 07h
    X:  sub al, 30h
ret
endp

output proc                    ;Outputs a 8 bit number stored in bl
    cmp bl, 0Ah
    jc Y
    add bl, 07h
    Y:  
    add bl, 30h
    mov dl, bl
    mov ah, 02h
    int 21h
ret 
endp

code ends
end start