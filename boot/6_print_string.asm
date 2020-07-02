; [ org 0x7c00 ]
; mov ah, 0x0e
; mov bx, hello
; call print_str
; jmp $

print_string:
    pusha
    mov ah, 0x0e
    loop:
        mov al, [bx]
        int 0x10
        inc bx
        cmp al, 0
        jne loop
    popa
    ret
print_new_line:
    mov ah , 0x0e
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    ret
; hello:
;     db 'Hello , World !' , 0 ;

; times 510 -( $ - $$ ) db 0
; dw 0xaa55
