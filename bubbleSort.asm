    .cdecls "msp430.h"
    .global main
    .text 
main:
    mov     #v,R12
    mov.b   #5,R13
    call    #bubbleSortMain
    jmp     $
    nop

bubbleSortMain:
    push    R4
    push    R5
    push    R6
    push    R7
    clr     R7
    clr     R4
    clr     R5
    clr     R6
    mov.b   R13,R7
    dec     R7;alteração nova
    jmp     bubbleSortInLoop

bubbleSortInLoop:
    mov.b   @R12+,R4
    mov.b   @R12,R5
    cmp     R4,R5
    jn      swap
    jnz     no_swap

swap:
    mov.b   @R12,R6
    mov.b   R4,0(R12)
    mov.b   R5,-1(R12)
    dec     R7
    jnz     bubbleSortInLoop
    jmp     bubbleSortOutLoop

no_swap:
    dec     R7
    jnz     bubbleSortInLoop
    jmp     bubbleSortOutLoop

bubbleSortOutLoop:
    dec     R13
    jnz     bubbleSortMid
    pop     R7
    pop     R6
    pop     R5
    pop     R4
    ret

bubbleSortMid:
    mov.b   #4,R7;r7->5
    mov     #0x2400,R12
    jmp     bubbleSortInLoop
    nop
    .data 
v:  .byte   5,4,3,2,1

;destiny-source->src,dst