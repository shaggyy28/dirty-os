mov al, 0x41
mov ah, 0x0e
int 0x10
call change
int 0x10
jmp padding

change:
    pusha               ; pushes all registers to stack
    mov al, 0x42
    int 0x10
    call neo_change
    int 0x10
    popa
    ret                 ; pops all registers to stack

neo_change:
    pusha               ; pushes all registers to stack
    mov al, 0x43
    int 0x10
    popa
    ret                 ; pops all registers to stack


padding:
    times 510 -( $ - $$ ) db 0
    dw 0xaa55

