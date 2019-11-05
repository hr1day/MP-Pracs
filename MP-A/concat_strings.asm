EXTRA SEGMENT
    INST1 DB 20 DUP(0)
EXTRA ENDS

DATA SEGMENT
    INST2 DB 20 DUP(0)
    RESULT DB 40 DUP(0)
    MSG1 DB 10,13,'ENTER THE FIRST STRING: $'
    MSG2 DB 10,13,'ENTER THE SECOND STRING: $'
    MSG3 DB 10,13,'CONCATENATED STRING IS: $'
   
DATA ENDS

CODE SEGMENT
    
    ASSUME CS:CODE,DS:DATA,ES:EXTRA
    START:
    
    MOV AX,DATA
    MOV DS,AX
    
    MOV AX,EXTRA
    MOV ES,AX
    
    MOV DX,offset MSG1
    MOV AH,09H
    INT 21H
    
    MOV BX,00H
    
    UP1:    ;taking input character by character
        
        MOV AH,01H
        INT 21H
        CMP AL,0DH
        JE DOWN1
        MOV [INST1+BX],AL
        INC BX
        JMP UP1
    
    DOWN1:

        
        MOV DX,offset MSG2
        MOV AH,09H
        INT 21H
    
        MOV CX,BX ;storing length of string1
    
        MOV BX,00H ;reinitializing bx
        
        UP2:     ;taking input character by character
        
            MOV AH,01H
            INT 21H
            CMP AL,0DH
            JE DOWN2
            MOV [INST2+BX],AL
            INC BX
            JMP UP2
        
        DOWN2:
    
            PUSH BX  ;pushes value of bx into stack(length of string 2)
            MOV DI,0
            MOV SI,0
            
            UP3:
                
                MOV AL,[INST1+DI]
                MOV [RESULT+SI],AL
                INC SI
                INC DI
                LOOP UP3 ;prints uptill string 1
            
            POP CX ;pops string2 length value to cx
            MOV DI,0
            
            UP4:
                
                MOV AL,[INST2+DI]
                MOV [RESULT+SI],AL
                INC SI
                INC DI
                LOOP UP4
                
            MOV DX,offset MSG3
            MOV AH,09H
            INT 21H
            MOV [RESULT+SI],'$'
            LEA DX,RESULT
            MOV AH,09H
            INT 21H
            MOV AH,4CH
            INT 21H
CODE ENDS
END START
END
