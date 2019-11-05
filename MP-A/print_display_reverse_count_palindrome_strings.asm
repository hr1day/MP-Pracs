Data segment

	msg1 db 10,13, "1.ACCEPT STRING: $"
	msg2 db 10,13, "2.DISPLAY STRING: $"
	msg3 db 10,13, "3.DISPLAY REVERSE STRING: $"
	msg4 db 10,13, "4.CHECK PALINDROME: $"
	msg5 db 10,13, "5.COUNT LENGHT: $"
	msg6 db 10,13, "6.EXIT $"
	msgchoice db 10,13, "ENTER YOUR CHOICE: $"
	msgenterstring db 10,13, "ENTER A STRING: $"
	msgenteredstring db 10,13, "YOUR STRING: $"
	msgreversestring db 10,13, "REVERSE STRING: $"
	msgpalin db 10,13, "STRING IS PALINDROME $"
	msgnotpalin db 10,13, "STRING IS NOT PALINDROME $"
	msglength db 10,13, "LENGTH OF THE STRING IS: $"




	choice db ?
	length db ?



Data ends
Code segment
		Assume DS:Data,CS:Code
	start:

		mov AX,Data
		mov DS,AX


	menu:
		
		mov DX,offset msg1
		mov AH,09H
		INT 21h

		mov DX,offset msg2
		mov AH,09H
		INT 21h

		mov DX,offset msg3
		mov AH,09H
		INT 21h

		mov DX,offset msg4
		mov AH,09H
		INT 21h

		mov DX,offset msg5
		mov AH,09H
		INT 21h

		mov DX,offset msg6
		mov AH,09H
		INT 21h

		

		;taking input
		mov AH,01H
		INT 21H
		SUB AL,30H	;coz ascii and shit
		mov choice,AL

		;if you want to exit
		cmp AL,06H
		jnz checkoption1
		mov AH,4CH
		INT 21h

		;option1
		checkoption1:
		cmp AL,01H
		jnz checkoption2
		call option1
		jmp menu


		;option2
		checkoption2:
		cmp AL,02H
		jnz checkoption3
		call option2
		jmp menu

		;option3
		checkoption3:
		cmp AL,03H
		jnz checkoption4
		call option3
		jmp menu

		;option4
		checkoption4:
		cmp AL,04H
		jnz checkoption5
		call option4
		jmp menu

		;option5
		checkoption5:
		cmp AL,05H
		call option5
		jmp menu

		



		option1 proc
			
			mov SI,1000H
			mov DI,1000H
			mov CX,00H

			;asking user to enter astring
			mov DX,offset msgenterstring
			mov AH,09H
			INT 21H

			
			back:
				
				;accepting input character by character	
				
				mov AH,01H
				INT 21H

				;check if the user has pressed enter or not
				cmp AL,0DH
				jz newline

				inc CX
				mov [SI],AL
				mov [DI],AL

				inc SI
				inc DI
				jmp back
				
				newline:
					mov length,CL

			ret
		endp

		

		option2 proc

			mov DX,offset msgenteredstring
			mov AH,09H
			INT 21H

			mov CL,length
			mov CH,00H
			mov SI,1000H

			disp:

				;displaying character by character
				mov DL,[SI]
				mov AH,02H
				INT 21H
				inc SI
				loop disp

			ret
		endp



		option3 proc

			mov DX,offset msgreversestring
			mov AH,09H
			INT 21H

			mov CL,length
			mov CH,00H
			mov SI,1000H
			add SI,CX
			dec SI

			rev:
				mov DL,[SI]
				mov AH,02H
				INT 21H
				dec SI
				loop rev
			
			ret
		endp



		option4 proc

			mov SI,1000H
			mov DI,1000H
			mov CL,length
			mov CH,00H
			add DI,CX
			dec DI

			palin:
				mov AL,[SI]
				cmp AL,[DI]
				jnz notpalin
				inc SI
				dec DI
				loop palin

				mov DX,offset msgpalin
				mov AH,09H
				INT 21H
				ret



			notpalin:
				mov DX,offset msgnotpalin
				mov AH,09H
				INT 21H


			ret
		endp

		option5 proc

			mov DX,offset msglength
			mov AH,09H
			INT 21H

			mov BL,length
			and BL,0F0H
			mov CL,04H
			ror BL,CL
			call output

			mov BL,length
			and BL,0FH
			call output


			ret
		endp



		output proc

			cmp BL,0AH
			jc lab
			add BL,07H

			lab:
				add BL,30H
				mov DL,BL
				mov AH,02H
				INT 21H

			ret
		endp

		


code ends
end start