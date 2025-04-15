    .cdecls "msp430.h"
    .global main
    .text 
main:
    mov     #m,R11
    mov     #4,R12  ;numero de linhas da matriz
    mov     #3,R13  ;numero de colunas da matriz
    call    #mat_transp
    jmp     $
    nop
mat_transp:
    push    R4
    push    R5
    push    R6
    push    R7
    push    R8
    mov     R13,R4
    mov     R12,R5
    mov     #2,R14
    mov     R4,R6
    add     R4,R6   ;deslocamento para o proximo elemento 

    push    R9      ;numero de repetiçoes
    clr     R7      ;quantos elementos para voltar para o zero 
    mov     R4,R9

back:
    add     R5,R7
    dec     R9
    jnz     back
    add     R7,R7
    mov     R4,R8
    push    R10
    mov     #mT,R10

mat_loop:
    mov     @R11,0(R10)
    add     R6,R11
    add     #2,R10
    dec     R5
    jnz     mat_loop
    sub     R7,R11
    add     #2,R11
    mov     R12,R5
    dec     R8
    jnz     mat_loop
mat_ret:
    pop     R10
    pop     R9
    pop     R8
    pop     R7
    pop     R6
    pop     R5
    pop     R4
    ret 

    .data
m:  .word   2, 9, 5, 1, 0, 7, 4, 6, 10, 3, 8, 2
mT: .word   0,0,0,0,0,0