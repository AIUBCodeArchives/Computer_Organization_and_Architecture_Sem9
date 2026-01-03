.MODEL SMALL
.STACK 100h
.DATA
    ; Variable to store the result
    X WORD ?
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX      ; Initialize Data Segment

    ; --- Start of IF-ELSE logic ---
    MOV AX, 10      ; Set AX to 10
    MOV BX, 10      ; Set BX to 10 (change to a different value to test 'else' branch)

    CMP AX, BX      ; Compare AX and BX. Sets the Zero Flag (ZF) if equal.
    JNE ELSE_BLOCK  ; Jump to ELSE_BLOCK if Not Equal (ZF=0).
    
    ; --- IF_BLOCK (AX == BX) ---
    MOV WORD PTR X, 1 ; If equal, set X to 1
    JMP END_IF      ; Unconditional jump to skip the else block
    
    ; --- ELSE_BLOCK (AX != BX) ---
    ELSE_BLOCK:
    MOV WORD PTR X, -1; If not equal, set X to -1
    
    ; --- END_IF_ELSE ---
    END_IF:
    
    ; Program termination (DOS function 4Ch)
    MOV AH, 4Ch
    INT 21h
MAIN ENDP
END MAIN