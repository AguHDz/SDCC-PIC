#include <pic14/pic16f84a.h>

#define FOSC 20000000L    // 4 MHz
#include "../Libs/delay.c"

///PROGRAMA
void main(void)
{
//    ADCON1 = 0x07;       // Todos los pines configurados como digitales.
//    ADCON0 = 0x00;       // Desactiva conversor A/D.
   TRISB = 0xF0;                 //porta como salida menos RA4(desactivado)
   PORTB = 0x00;
   GIE   = 0;                    //todas las interrupciones desactivadas

   while(1) {                    //bucle...
      RB0 = !RB0;
      delay_ms(1);
   };                            //...infinito
}
