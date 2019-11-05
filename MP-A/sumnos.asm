data segment
	
	msg1 db 10,13, "Enter the number of elements: $"
	msg2 db 10,13, "Enter the number: $"
	msg3 db,10,13, "The sum is : $"
	summation db ?
	count db ?
	count1 db ?
	result db ?
data ends

code segment

assume CS:code, DS:data
	start:
		mov ax,data
		mov ds,ax

		mov dx,offset msg1
		mov ah,09h
		int 21h

		;first digit
		call input
		mov bl,al
		mov cl,04h
		rol bl,cl

		;second digit
		call input
		add bl,al ;bl contain the final no.
		
		mov count,bl
		mov count1 ,bl
		
		mov cl,count
		mov si,1000h



		takeinput :

			mov count,cl
			mov dx,offset msg2
			mov ah,09h
			int 21h			

			;first digit
			call input
			mov bl,al
			mov cl,04h
			rol bl,cl

			;second digit
			call input
			add bl,al ;bl contain the final no.
			mov [si],bl	

			inc si
			mov cl,count
			loop takeinput

		
		mov bl,00h
		mov si,1000h
		mov cl,count1	
		adding:
			mov al,[si]
			add bl,al
			inc si
			loop adding
		
		mov result,bl
		
		;displaying result
				mov dx,offset msg3
				mov ah,09h
				int 21h
				and bl,0f0h
				mov cl,04h
				ror bl,cl
				call output
				mov bl,result
				and bl,0fh
				mov dl,bl
				call output
			


			



		mov ah,4ch
		int 21h




		input proc
		
			mov ah,01h
			int 21h
		
			cmp al,41h
			jc lessthan41h
			sub al,07h

			lessthan41h :
			sub al,30h

			ret
		endp

		output proc
		
			cmp bl, 0Ah
			jc B
			add bl, 07h
			
			B:  
			add bl, 30h
			mov dl, bl
			mov ah, 02h
			int 21h
			
			ret
		endp





code ends
end start