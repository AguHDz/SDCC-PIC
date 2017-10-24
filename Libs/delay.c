#ifndef __I2C_DELAY_H
#define __I2C_DELAY_H

#define __FOSC_CALIBRATED 4000000L    // 4 MHz
// Calibrar a 4 MHz para los distintos modelos de microcontrolador.
// Varia de unos a otros por las instrucciones de paginación que compila
// depende el micro y de su cantidad de memoria de programa.
// Ir añadiendo según se prueban...


#ifdef __PIC16F84A_H__
  #define DELAY_CALIBRATED 69  // Calibrated delay, ~1ms/loop @ 4MHz
#endif
#ifdef __PIC16F877A_H__
  #define DELAY_CALIBRATED 61  // Calibrated delay, ~1ms/loop @ 4MHz
#endif

// Se extrapola a cualquier velocidad del microcontrolador.
#define DELAY_CALIBRATED_VAR (DELAY_CALIBRATED*FOSC/__FOSC_CALIBRATED)


void delay_ms(unsigned int ms)
{
   unsigned int aux;

   while(ms--)
   {
       aux=DELAY_CALIBRATED_VAR;      // Calibrated delay
       while(aux--);
   };
}

#endif
