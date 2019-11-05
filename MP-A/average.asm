data segment

msg1 db 10,13, "Enter the number of elements: $"
msg2 db 10,13, "Enter the number: $"
msg3 db 10,13, "The average is: $"
msg4 db 10,13, "$"
msg5 db 10,13, "testing$"

result db ?
count db ?

data ends


code segment

assume cs:code, ds:data
start:

mov ax, data
mov ds, ax

mov dx, offset msg1
mov ah, 09h
int 21h
call input
mov count,bl                       ;making a copy
mov cl,bl

mov si, 1000h
get:                                ;input loop
        mov dx, offset msg2
        mov ah, 09h
        int 21h
        call input
        mov [si], bl
        inc si
        loop get
               
mov ax, 0000h
mov si, 1000h
mov cl,count

avg:  
        mov bl, [si]
        add al, bl
        inc si
        loop avg
        
 
mov bl,count
div bl
mov bl,al                        ;al has the quotient
mov dx, offset msg3
mov ah, 09h
int 21h   
call output

mov ah, 4ch
int 21h
     
        
input proc                      ;Takes a 8 bit number as input and stores the 8 bit number in bl
  
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


code ends
end start