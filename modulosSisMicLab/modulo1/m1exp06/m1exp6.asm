    .cdecls "msp430.h"
    .global main
    .text 
main:
    mov.w   #1307,R12
    mov.w  #5,R13

    call    #umult8
    jmp     $
    nop
umult8:
    add     #0,R12
    jz      mult8_zero
    add     #0,R13
    jz      mult8_zero

    push    R4
    clr     R4

    call    #mult8_subrot
    ret
mult8_subrot:
    add     R12,R4
    dec     R13
    jnz     mult8_subrot
    mov.w   R4,R12

    pop     R4
    ret     
mult8_zero:
    mov     #0,R12
    ret
