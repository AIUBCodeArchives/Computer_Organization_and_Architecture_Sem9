.MODEL SMALL
.STACK 100H

.DATA
    PROMPT_MSG  DB 'Enter a number (1, 2, or 3): $'
    CASE1_MSG   DB 'You selected Case 1!$'
    CASE2_MSG   DB 'You selected Case 2!$'
    CASE3_MSG   DB 'You selected Case 3!$'
    DEFAULT_MSG DB 'Default case triggered. Invalid input.$'
    
    ; Jump table definition
    ; JmpTbl is an array of word (DW) pointers to the case labels.
    JmpTbl      DW  Case1, Case2, Case3
    
.CODE
MAIN PROC
    ; Initialize data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Display prompt message
    MOV AH, 09H
    LEA DX, PROMPT_MSG
    INT 21H

    ; Read a single character from the user (input stored in AL)
    MOV AH, 01H
    INT 21H
    
    ; Convert ASCII input ('1', '2', '3') to a numeric value (0, 1, 2)
    ; ASCII '1' is 49. Subtract 48 ('0') to get the numeric value.
    SUB AL, '0' ; AL now holds 1, 2, or 3, or some other number

    ; Check if input is outside the valid range [1, 3]
    CMP AL, 1
    JL  DefaultCase ; Jump if less than 1
    CMP AL, 3
    JG  DefaultCase ; Jump if greater than 3

    ; Calculate the index into the jump table.
    ; Our numeric cases are 1, 2, 3. We adjust the input so it's 0-indexed.
    ; AL holds the value, convert to 0-indexed by subtracting 1.
    SUB AL, 1
    
    ; The jump table holds word (2-byte) addresses.
    ; We need the offset to be an index multiplied by the size of each entry (2 bytes).
    ; We use a non-zero general purpose register for indexing.
    MOV BL, AL    ; Copy value to BL
    MOV BH, 0     ; Clear BH (BX is 16-bit register)
    ADD BX, BX    ; BX * 2 (or use SHL BX, 1)

    ; Jump to the address stored in the jump table using the calculated offset.
    JMP JmpTbl[BX]

DefaultCase:
    MOV AH, 09H
    LEA DX, DEFAULT_MSG
    INT 21H
    JMP EndMain

Case1:
    MOV AH, 09H
    LEA DX, CASE1_MSG
    INT 21H
    JMP EndMain

Case2:
    MOV AH, 09H
    LEA DX, CASE2_MSG
    INT 21H
    JMP EndMain

Case3:
    MOV AH, 09H
    LEA DX, CASE3_MSG
    INT 21H
    JMP EndMain

EndMain:
    ; Exit the program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
