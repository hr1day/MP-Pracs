Data Segment
	msg1 db 10,13, "Enter Number: $"
	num db ?
	msg2 db 10,13, "Product of Numbers is: $"
	factorial dw ?
Data Ends
Code Segment
	Assume CS: Code, DS: Data

	start:

		mov ax, data
		mov ds, ax

		mov dx, offset msg1
		mov ah, 09h
		int 21h

		mov ah, 01h
		int 21h
		Call input
		mov bl, al
		rol bl, 04h

		mov ah, 01h
		int 21h
		Call input
		add bl, al

		mov num, bl
		mov ax, 0000h
		mov al, 01h

		labelFactorial:

			cmp bl, 00h
			jz labelFact
			MUL bl
			sub bl, 01h
			jmp labelFactorial

			labelFact:
				mov bl, 01h
				MUL bl

		mov factorial, ax

		mov dx, offset msg2
		mov ah, 09h
		int 21h

		mov bx, factorial

		and bx, 0f000h
		ror bx, 12
		Call output

		mov bx, factorial
		and bx, 0f00h
		ror bx, 8
		Call output

		mov bx, factorial
		and bx, 0f0h
		ror bx, 4
		Call output

		mov bx, factorial
		and bx, 0fh
		Call output

		mov ah, 4ch
		int 21h

		input proc
			cmp al, 41h
			jc labelIn
			sub al, 07h

			labelIn:
				sub al, 30h

			ret
			endp

		output proc
			cmp bl, 0ah
			jc labelOut
			add bl, 07h

			labelOut:
				add bl, 30h

			mov dl, bl
			mov ah, 02h
			int 21h

			ret
			endp

Code Ends
	end start
