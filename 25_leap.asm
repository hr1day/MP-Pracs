Data Segment
msg1 db 10,13,"Enter the year:$"
msg2 db 10,13,"It is a leap year:$"
msg3 db 10,13,"It is not a leap year:$"
numh db ?
numl db ?
check db ?
Data Ends
Code Segment
Assume CS:Code,DS:Data
Start:
	mov ax,data
	mov ds,ax

	mov ah,09h
	mov dx,offset msg1
	int 21h

	call takenumber
	mov numh,al

	call takenumber 
	mov numl,al


	mov bl,04h
	mov ah,numh
	div bl
	cmp ah,00h   ;Checking divisibility by 4
	jz A         ;if divisible check divisibility by 100

	mov ah,09h
	mov dx,offset msg3
	int 21h
	call exit	 ;print not leap year

	A:
	mov bl,64h
	mov ah,numh
	mov al,numl
	div bl
    cmp ah,00h	;checking divisibility by 100
    jz B        ;if it is divisible by 100 then check divisibility with 400

    mov ah,09h
	mov dx,offset msg2
	int 21h
	call exit        ;print leap year if not divisible by 100


    B:
    mov bx,0190h     ;hex value for 400
    mov ah,numh
    mov al,numl
    mov dx,00h
    div bx
    cmp dx,0000h
    jz C


    mov ah,09h
	mov dx,offset msg3
	int 21h
	call exit		;print leap year if not divisible by 400


    C:
    mov ah,09h
	mov dx,offset msg2
	int 21h
	call exit        ;print leap year if divisible by 400



	






input proc
mov ah,01h
int 21h
cmp al,41h
jc laba
sub al,07h
laba:
sub al,30h
ret
endp

output proc
cmp bl,0Ah
jc labd
add bl,07h
labd:
add bl,30h
mov ah,02h
mov dl,bl
int 21h
ret
endp

checkt proc
inc check
ret
endp

takenumber proc
call input
rol al,04h
mov bl,al
call input
add al,bl
ret
endp

exit proc
mov ax,4C00h
int 21h
ret
endp 

Code Ends
 End Start
