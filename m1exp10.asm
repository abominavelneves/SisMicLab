    .cdecls "msp430.h"
    .global main
    .text 
main:
    mov.w   #v,R12
    mov     #10,R13

    call    #sumVetor
    jmp     $
    nop

sumVetor:
    push    R4
    push    R5
    push    R6
    clr     R6

    mov.w   R12,R4
    mov     R13,R5
    mov.b   #0,R12
    call    #sumSubRot
    ret

sumSubRot:
    add.b   @R4+,R6
    dec     R5
    jnz     sumSubRot
    mov.b   R6,R12

    pop     R6
    pop     R5
    pop     R4
    ret

    .data 
v:  .byte   25, 30, 20, 15, 40, 35, 10, 20, 30, 30
