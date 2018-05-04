#include <msp430.h>
#include <stdio.h>

unsigned int periods[] = { 512, 1024, 2048, 4096 };
unsigned short current = 0;

int main(void)
{
  volatile unsigned int i;

  WDTCTL = WDTPW + WDTHOLD;            
  FLL_CTL0 |= XCAP14PF;                

 
  do
  {
    IFG1 &= ~OFIFG;                    
    for (i = 0x47FF; i > 0; i--);      
  }
  while ((IFG1 & OFIFG));              
  
  P1IES &= 0x03;
  
  P3SEL |= 0x20;
  P3DIR |= 0x20;
  P1IE |= 0x03;
  TBCCR0 = periods[0];
  TBCCTL0 = 0;
  
  TBCCTL4 = OUTMOD_7;
  TBCCR4 = periods[0]/2;
  TBCTL = MC_1 + TASSEL_2 + ID_3;
  __bis_SR_register(LPM0_bits + GIE);   // Enter LPM0 with interrupt
}

#pragma vector=PORT1_VECTOR
__interrupt void onButtonClickHandler (void)
{
 
  if(P1IFG & 0x01){     
     current = (current + 1) % 4;     
     TBCCR0 = periods[current];
     TBCCR4 = periods[current]/2;
  } else if(P1IFG & 0x02){     
     current = (current == 0)? 3 : current - 1;     
     TBCCR0 = periods[current];
     TBCCR4 = periods[current]/2;
  }
  P1IFG = 0;
}
