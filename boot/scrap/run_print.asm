[ org 0x7c00 ]
mov ah, 0x0e
mov bx, hello
call print_string
call print_a
jmp $

%include "./print_string.asm"


hello:
    db 'Hello , World !' , 0 ;
dw 0x10
times 510 -( $ - $$ ) db 0
dw 0xaa55