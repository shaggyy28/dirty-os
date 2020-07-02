;;;;;;;;;;;;;;without return address stored;;;;;;;;;;
;     mov al, 61
;     jmp square
; return_to_here:
;     mov ah , 0x0e                   ; teletype bios routine
;     int 0x10                        ; print(al)
;     jmp padding

; square:
;     add al, 1
;     jmp return_to_here


;;;;;;;;;;;;;;with call and ret;;;;;;;;;;
mov ah , 0x0e                   ; teletype bios routine
mov al, 0x41
call square
jmp padding

square:
    ; add al, 1
    int 0x10                        ; print(al)
    ret

; Padding and magic BIOS number.
padding:
    times 510 -( $ - $$ ) db 0
    dw 0xaa55