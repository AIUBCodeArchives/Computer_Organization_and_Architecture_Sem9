.MODEL SMALL
.STACK 100h
.DATA
    num DB 7        ; The number to check
    msg_greater DB 'Number is greater than 5$'
    msg_not_greater DB 'Number is not greater than 5$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX      ; Initialize Data Segment

    ; --- Start of IF-ELSE logic ---
    MOV AL, num     ; Load 'num' into AL
    CMP AL, 5       ; Compare AL with 5
    JLE NOT_GREATER ; Jump if Less than or Equal to NOT_GREATER label

    ; --- IF_BLOCK (num > 5) ---
    MOV DX, OFFSET msg_greater ; Load address of the 'greater' message
    MOV AH, 09h     ; DOS print string function
    INT 21h         ; Call DOS
    JMP END_IF      ; Unconditional jump to skip the else block

    ; --- ELSE_BLOCK (num <= 5) ---
    NOT_GREATER:
    MOV DX, OFFSET msg_not_greater ; Load address of the 'not greater' message
    MOV AH, 09h     ; DOS print string function
    INT 21h         ; Call DOS

    ; --- END_IF_ELSE ---
    END_IF:

    ; Program termination
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN