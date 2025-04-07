    .cdecls "msp430.h"
    .global main
    .text 
main:
    clr     R4
    mov     #0x2400,R4
    mov.b   #0,0(R4)
    mov.b   #1,1(R4)
    inc     R4
    mov.b   #18,R13
    call    #fib
    jmp     $
    nop
fib:
    inc     R4
    mov.b   -2(R4),0(R4)
    add.b   -1(R4),0(R4)
    dec     R13
    jnz     fib
    ret
