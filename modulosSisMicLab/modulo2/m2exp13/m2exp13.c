#include <msp430.h>
#include <stdint.h>
#include<gp_io.h>
volatile int number = 0;

void debounce(){
    volatile int old = 0;
    volatile int new = 0;
    volatile int count = 300;
    while(count){
        old = new;
        new = !(P2IN & BIT1 || P1IN & BIT1); 
        if(old == new){
            count--;
        } else {
            count = 300;
        }
    }
}

int main(void)
{
    WDTCTL = WDTPW | WDTHOLD; // Stop watchdog


    // Interrupções
    P1IES |= BIT1;
    P1IE  |= BIT1;
    P2IES |= BIT1;
    P2IE  |= BIT1;

    __enable_interrupt();
    P1IFG &=~ BIT1;
    P2IFG &=~ BIT1;
    setPins();
    while(1){
        switch(number){
            case 0:
                P1OUT &=~ BIT0;
                P4OUT &=~ BIT7;
                break;
            case 1:
                P1OUT &=~ BIT0;
                P4OUT |= BIT7;
                break;
            case 2:
                P1OUT |= BIT0;
                P4OUT &=~ BIT7;
                break;
            case 3:
                P1OUT |= BIT0;
                P4OUT |= BIT7;
                break;
        }
    }
}

#pragma vector = PORT1_VECTOR
__interrupt void p1_isr(){
    debounce();
    number--;
    if (number < 0){
        number = 3;
    }
    P1IFG &=~ BIT1;
    debounce();
}

#pragma vector = PORT2_VECTOR
__interrupt void p2_isr(){
    debounce();
    number++;
    if (number > 3){
        number = 0;
    }
    P2IFG &=~ BIT1;
    debounce();
}
