Data segment 

	msgenterchoice db 10,13, "Enter your choice: $"
	msg1 db 10,13, "1.Addition $"
	msg2 db 10,13, "2.subtraction $"
	msg3 db 10,13, "3.Multiplication $"
	msg4 db 10,13, "4.Division$"
	msg5 db 10,13, "5.Exit $"
	msgresult db 10,13, "RESULT IS: $"
	msginput1 db 10,13, "Enter number 1:$"
	msginput2 db 10,13, "Enter number 2:$"
	msgremainder db 10,13, "Remainder is :"
	msgquotient db 10,13, "quotient is :"

	
	result db ?
	result1 dw ?
	choice db ?
	num1 db ?
	num2 db ?

Data ends
Code segment
	Assume CS:code ,DS:Data
	start:

	menu:
		mov AX,Data
		mov DS,AX

		mov AH,09H
		mov DX,offset msgenterchoice
		INT 21H

		mov AH,09H
		mov DX,offset msg1
		INT 21H

		mov AH,09H
		mov DX,offset msg2
		INT 21H

		mov AH,09H
		mov DX,offset msg3
		INT 21H

		mov AH,09H
		mov DX,offset msg4
		INT 21H

		mov AH,09H
		mov DX,offset msg5
		INT 21H
		
		call input	
		mov choice,al

		cmp al,05h
		jnz takeinputs
		mov ah,4ch
		int 21h

		takeinputs:
			

			;NUMBER1--------------------------------------------------------------------

			mov dx,offset msginput1
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
			mov num1,bl


			;NUMBER2---------------------------------------------------------------------

			mov dx,offset msginput2
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
			mov num2,bl




			;ADDITION---------------------------------------------------------------------------------
			cmp choice,01h
			jnz option2

			mov bl,num1
			mov cl,num2
			add bl,cl
			mov result,bl

			;displaying result
			mov dx,offset msgresult
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
			jmp menu

			;SUBTRACTION-------------------------------------------------------------------------------
			option2:
				
				cmp choice,02h
				jnz option3

				mov bl,num1
				mov cl,num2
				sub bl,cl
				mov result,bl

				;displaying result
				mov dx,offset msgresult
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
				jmp menu			

				;MULTIPLICATION-----------------------------------------------------------------------------------	
				option3:	

					cmp choice,03h
					jnz option4

					mov al,num1
					mov bl,num2
					mul bl ;mul instruction works with al
					mov result1,ax

					;displaying result
					
					mov dx,offset msgresult
					mov ah,09h
					int 21h

					mov ax,result1
					and ax,0f000h
					mov cl,12h
					ror ax,cl
					mov bl,al
					call output

					mov ax,result1
					and ax,0f00h
					mov cl,08h
					ror ax,cl
					mov bl,al
					call output

					mov ax,result1
					and ax,0f0h
					mov cl,04h
					ror ax,cl
					mov bl,al
					call output

					mov ax,result1
					and ax,0fh
					mov bl,al
					call output

					jmp menu

					;DIVISION--------------------------------------------------------------------------------
					option4:

						mov ax,0000h
						mov al,num1
						mov bl,num2
						div bl ;div instruction works with al
						mov result1,ax

						;displaying result
					
						mov dx,offset msgresult
						mov ah,09h
						int 21h

						;remainder==========================
						mov dx,offset msgremainder
						mov ah,09h
						int 21h	

						mov ax,result1
						and ax,0f000h
						mov cl,12h
						ror ax,cl
						mov bl,al
						call output

						mov ax,result1
						and ax,0f00h
						mov cl,08h
						ror ax,cl
						mov bl,al
						call output

						;quotient======================
						mov dx,offset msgquotient
						mov ah,09h
						int 21h	

						mov ax,result1
						and ax,00f0h
						mov cl,04h
						ror ax,cl
						mov bl,al
						call output

						mov ax,result1
						and ax,000fh
						mov bl,al
						call output

						jmp menu





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

Code ends
end start
