print_string:
    pusha
    loop:
        mov al, [bx]
        int 0x10
        inc bx
        cmp al, 0
        jne loop
    popa
    ret

print_a:
    pusha
    mov al, 'A'
    int 0x10
    popa
    ret