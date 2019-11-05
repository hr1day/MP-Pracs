data segment

msg1 db 10,13, "Enter the number: $"
msg2 db 10,13, "The gcd is: $"
msg3 db 10,13, "tset$"
msg4 db 10,13, "test 2$"

result db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax

call input  ;Inputs a 2 digit number
mov ch,bl   ;Make copy

call input


;First number in ch. Second number in bl

cmp bl,ch
jnz  B

A:  
    call output
    mov ah, 4ch
    int 21h

B:                             
    jnc C  
    sub ch,bl
    cmp bl,ch
    jz A
    
    jc B
    
    
C:  sub bl,ch                   
    cmp bl,ch
    
    jz A
    jc B
    jnc C

        
        
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

    mov dx, offset msg2 
    mov ah, 09h
    int 21h 
    
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

mov ah, 4ch
    int 21h


code ends
end start