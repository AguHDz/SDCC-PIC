//
// Librería manejo integrado Reloj de Tiempo Real (RTC) DS1307.
//

#ifndef __DS1307_LIB
#define __DS1307_LIB

#include <stdint.h>
#include "math.c"
#include "I2C.c"

uint8_t  DS1307_DiaSemana;     // Día de la semana (formato numérico 1..7)
uint8_t  DS1307_Dia;           // Día del mes.
uint8_t  DS1307_Mes;           // Mes del año.
uint8_t  DS1307_Ano;           // Año (solo dos dígitos)
uint8_t  DS1307_Hora;          // Hora del día.
uint8_t  DS1307_Minuto;        // Minuto de la hora.
uint8_t  DS1307_Segundo;       // Segundo del minuto.

#define DS1307_CONF 0x80     // La librería no lo usa, por eso se define como
                             // una constante. (Desactiva salida SQWE)


/****************************************************************************
  - Función: DS1307_timeRead
  - Descripción: Lee fecha y hora del DS1307 a través del bus I2C.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void DS1307_timeRead(void)
{
    I2C_start();     // Inicia comunicación I2C.
    I2C_send(0xD0);  // Dirección I2C del DS1307.
    I2C_send(0x00);  // Primera dirección a leer/escribir.
    I2C_start();     // Reinicia comunicación I2C.
    I2C_send(0xD1);  // DS1307 en Modo Escritura.
    DS1307_Segundo   = BCDToDecimal(I2C_read(1)); // ASK = 1
    DS1307_Minuto    = BCDToDecimal(I2C_read(1));
    DS1307_Hora      = BCDToDecimal(I2C_read(1));
    DS1307_DiaSemana = I2C_read(1);  // Valor 1...7 (igual en decimal que en BCD)
    DS1307_Dia       = BCDToDecimal(I2C_read(1));
    DS1307_Mes       = BCDToDecimal(I2C_read(1));
    DS1307_Ano       = BCDToDecimal(I2C_read(0)); // ASK = 0
                         // El DS1307 necesita que el último ASK antes del stop
                         // sea cero (/ASK). De otra manera se producen errores
                         // de lectura I2C.
    I2C_stop();
}

/****************************************************************************
  - Función: DS1307_timeWrite
  - Descripción: Escribe fecha y hora en el DS1307 a través del bus I2C.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void DS1307_timeWrite(void)
{
    I2C_start();     // Inicia comunicación I2C
    I2C_send(0xD0);  // Dirección I2C del DS1307.
    I2C_send(0x00);  // Primera dirección a leer/escribir.
    I2C_send(decimalToBCD(DS1307_Segundo));
    I2C_send(decimalToBCD(DS1307_Minuto));
    I2C_send(decimalToBCD(DS1307_Hora));
    I2C_send(DS1307_DiaSemana);  // Valor 1...7 (igual en decimal que en BCD)
    I2C_send(decimalToBCD(DS1307_Dia));
    I2C_send(decimalToBCD(DS1307_Mes));
    I2C_send(decimalToBCD(DS1307_Ano));
    I2C_send(DS1307_CONF);
    I2C_stop();
}

#endif // __DS1307_LIB
