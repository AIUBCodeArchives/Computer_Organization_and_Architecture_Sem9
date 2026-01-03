.model small
.stack 100h
.data
    msg_range db 'In range$'

.code
main proc
    mov ax, @data
    mov ds, ax

    mov al, 5       ; Test value

    ; Check if AL > 0
    cmp al, 0
    jle skip_range  ; Jump if Less than or Equal to 'skip_range' (If condition false)

    ; Check if AL < 10 (Nested condition)
    cmp al, 10
    jge skip_range  ; Jump if Greater than or Equal to 'skip_range' (If condition false)

    ; --- IF block starts here (both conditions were true) ---
    mov dx, offset msg_range
    mov ah, 9
    int 21h
    ; --- IF block ends here ---

skip_range:
    ; Code continues here
    
    mov ah, 4ch
    int 21h
main endp
end main