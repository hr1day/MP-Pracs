data segment

msg1 db 10,13, "Enter the dividend: $"
msg2 db 10,13, "Enter the divisor: $"
msg3 db 10,13, "The quotient is: $"
msg4 db 10,13, "The remainder is: $"

result db ?
num1 db ?
num2 db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax
 
    mov dx, offset msg1
    mov ah, 09h
    int 21h
    call input  
    mov num1, bl
    
    mov dx, offset msg2
    mov ah, 09h
    int 21h
    call input
    mov num2, bl

    mov ah, 00h
    mov al,num1
    mov bl,num2
    mov cl, 00h

    A:                      
        sub al, bl
        inc cl
        cmp al, num2
        jnc A
    
    mov dx, offset msg4
    mov ah, 09h
    int 21h
    mov bl,al
    call output  
   
    mov dx, offset msg3
    mov ah, 09h
    int 21h
    mov bl,cl
    call output  
    
    
    
    mov ah, 4ch
    int 21h
        
input proc                      ;Takes a 8 bit number as input and stores the 8 bit number in bl
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
    
    mov result,bl
    and bl,0F0h         ;First digit
    mov cl,04h
    ror bl, cl 
    call showdigits
    mov bl,result       ;Second digit
    and bl,0Fh          
    call showdigits

ret 
endp
    
showdigits proc
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