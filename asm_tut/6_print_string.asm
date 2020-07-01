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

; hello:
;     db 'Hello , World !' , 0 ;

; times 510 -( $ - $$ ) db 0
; dw 0xaa55
