;bubble sort
.MODEL SMALL
DISPLAY MACRO MSG
        LEA DX, MSG
        MOV AH, 09H
        INT 21H
ENDM
.DATA
LIST DB 02H, 01H, 34H, 0F4H, 09H, 05H
NUMBER EQU $-LIST
MSG1 DB 0DH, 0AH, "1 >> SORT IN ASCENDING ORDER$"
MSG2 DB 0DH, 0AH, "2 >> SORT IN DESCENDING ORDER$"
MSG3 DB 0DH, 0AH, "3 >> EXIT$"
MSG4 DB 0DH, 0AH, "ENTER YOUR CHOICE  :: $"
MSG5 DB 0DH, 0AH, "INVALID CHOICE ENTERED...$"
.CODE
START : MOV AX, @DATA
        MOV DS, AX
        LEA SI, LIST
        MOV CH, NUMBER-1          ; CL STORES THE NUMBER OF ELEMENTS IN LIST
        DISPLAY MSG1              ; DISPLAY THE MENU...
        DISPLAY MSG2
        DISPLAY MSG3
        DISPLAY MSG4
        MOV AH, 01H
        INT 21H
        SUB AL, 30H
        CMP AL, 01H             ; INPUT=1? SORT IN ASCENDING ORDER
        JE ASCSORT
        CMP AL, 02H             ; INPUT=2? SORT IN DESCENDING ORDER
        JE DESSORT
        CMP AL, 03H             ; INPUT=3? EXIT
        JE FINAL
        DISPLAY MSG5
        JMP FINAL
ASCSORT:MOV BL, 00H
AGAIN:  MOV SI, OFFSET LIST
        MOV CL, 00H             ; J VALUE
        MOV BH, CH
        SUB BH, BL              ; N-1-i
NPASS:  CMP CL, BH
        JNC NEXT
        MOV AL, [SI]
        MOV BP, 01H
        CMP AL, DS: [BP][SI]
        JC _NOPE
        XCHG AL, [SI+1]
        XCHG [SI], AL
_NOPE : INC CL
        INC SI
        JMP NPASS
NEXT:   INC BL
        CMP BL, CH
        JC AGAIN
        JMP FINAL

DESSORT:MOV BL, 00H
AGAIN1: MOV SI, OFFSET LIST
        MOV CL, 00H             ; J VALUE
        MOV BH, CH
        SUB BH, BL              ; N-1-i
NPASS1: CMP CL, BH
        JNC NEXT
        MOV AL, [SI]
        MOV BP, 01H
        CMP AL, DS: [BP][SI]
        JNC _NOPE1
        XCHG AL, [SI+1]
        XCHG [SI], AL
_NOPE1: INC CL
        INC SI
        JMP NPASS1
NEXT1:  INC BL
        CMP BL, CH
        JC AGAIN1
FINAL: MOV AH, 4CH
        INT 21H
END START