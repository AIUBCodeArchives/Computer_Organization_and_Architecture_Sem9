.model small
.stack 100h
.data
    msg_equal db 'Equal$'
    
.code
main proc
    mov ax, @data   ; Initialize data segment
    mov ds, ax
    
    mov al, 5       ; Set AL to 5 (the value to check)
    
    cmp al, 5       ; Compare AL with 5. This sets the Zero Flag (ZF) if they are equal.
    jne skip_if     ; Jump if Not Equal (JNE) to 'skip_if' label.
    
    ; --- IF block starts here ---
    mov dx, offset msg_equal
    mov ah, 9       ; DOS function to print string
    int 21h         ; Call DOS interrupt
    ; --- IF block ends here ---

skip_if:
    ; Code continues here after the IF block (regardless of the condition)
    
    mov ah, 4ch     ; DOS function to terminate program
    int 21h         ; Call DOS interrupt
main endp
end main