.MODEL SMALL

; MACRO TO DISPLAY THE MESSAGE....
DISPLAY MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM

.DATA
LIST DB 01H, 05H, 07H, 10H, 12H, 14H
NUMBER EQU ($-LIST)
KEY DB 11H             
MSG1 DB 0DH, 0AH, "ELEMENT FOUND IN THE LIST...$"
MSG2 DB 0DH, 0AH, "SEARCH FAILED !! ELEMENT NOT FOUND IN THE LIST $"

.CODE
START : MOV AX, @DATA
        MOV DS, AX
        MOV CH, NUMBER-1   ; HIGH VALUE...
        MOV CL, 00H        ; LOW VALUE...
AGAIN:  MOV SI, OFFSET LIST
        XOR AX, AX
        CMP CL, CH
        JE NEXT
        JNC FAILED
NEXT:   MOV AL, CL
        ADD AL, CH
        SHR AL, 01H             ; DIVIDE BY 2
        MOV BL, AL
        XOR AH, AH              ; CLEAR AH
        MOV BP, AX
        MOV AL, DS:[BP][SI]
        CMP AL, KEY             ; COMPARE KEY AND A[i]        
        JE SUCCESS              ; IF EQUAL, DISPLAY SUCCESS MESSAGE
        JC INCLOW
        MOV CH, BL              ; IF KEY>A[i]  SHIFT HIGH        
        DEC CH
        JMP AGAIN
INCLOW: MOV CL, BL              ; IF KEY<A[i]  SHIFT LOW
        INC CL
        JMP AGAIN
SUCCESS:DISPLAY MSG1            
        JMP FINAL
FAILED: DISPLAY MSG2            ; JOB OVER. TERMINATE....
FINAL : MOV AH, 4CH
        INT 21H
END START