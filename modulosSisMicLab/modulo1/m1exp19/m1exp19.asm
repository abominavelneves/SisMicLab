    .cdecls "msp430.h"
    .global main
    .text 
main:
    mov     #0x89AB,R12
    mov     #v,R13
    call    #w16_asc
    jmp     $
    nop 
w16_asc:
    push    R4
    push    R5
    push    R6
    push    R7
    mov.b   #12,R7
    clr     R5
    mov.b   #4,R6
    mov.b   #4,R4
    add     #3,R13
    jmp     w16_asc_loop
w16_asc_loop:
    rra     R12
    rrc     R5
    dec     R4
    jnz     w16_asc_loop
shift_nib:
    rra     R5
    dec     R7
    jnz     shift_nib
    and     #0xF,R5
nib_asc:
    cmp     #0xA,R5
    jn      nib_num
    jge     nib_carac
nib_num:
    add.b   #0x30,R5
    mov.b   R5,0(R13)
    mov.b   #12,R7
    mov.b   #0,R5
    mov.b   #4,R4
    dec     R13
    dec     R6
    jnz     w16_asc_loop
    jmp     w16_ret
nib_carac:
    add.b   #0x37,R5
    mov.b   R5,0(R13)
    mov.b   #0,R5
    dec     R13
    mov.b   #12,R7
    mov.b   #4,R4
    dec     R6
    jnz     w16_asc_loop
    jmp     w16_ret    
w16_ret:    
    pop     R7
    pop     R6
    pop     R5
    pop     R4
    ret 

    .data
v:  .byte   0,0,0,0
