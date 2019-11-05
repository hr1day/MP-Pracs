; NOTE ~ All the inputs and outputs are in HEXADECIMAL. 
; Same as gcd program, just added the formula to calculate lcm from gcd before calling output
; lcm = (num1 * num2) / gcd

data segment

msg1 db 10,13, "Enter the number: $"
msg2 db 10,13, "The lcm is: $"
msg3 db 10,13, "tset$"
msg4 db 10,13, "test 2$"

result db ?
num1 db ?
num2 db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax,data
mov ds, ax

call input  ;Inputs a 2 digit number
mov cl,bl   ;Make copy
mov num1, cl

call input
mov num2, bl


;First number in cl. Second number in bl

cmp bl,cl
jnz  B

A:  
    mov al, num1
    mov cl, num2
    mul cl
    div bl
    mov bl,al
    call output
    mov ah, 4ch
    int 21h

B:                             
    jnc C  
    sub cl,bl
    cmp bl,cl
    jz A
    
    jc B
    
    
C:  sub bl,cl                   
    cmp bl,cl
    
    jz A
    jc B
    jnc C

        
        
input proc                      ;Takes a 8 bit number as input and stores the 8 bit number in bl

    mov dx, offset msg1 
    mov ah, 09h
    int 21h    
    call getdigits
    mov bl,al           
    rol bl, 04h
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
    ror bl, 04h 
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