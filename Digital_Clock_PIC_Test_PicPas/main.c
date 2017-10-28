/*
*  (C) AguHDz 20-OCT-2017
*  Ultima Actualizacion: 28-OCT-2017
*
*  Compilador SDCC v.3.6.0 (http://sdcc.sourceforge.net)
*
*  Microcontrolador: PIC16F877A
*
*  RELOJ DIGITAL (TEST COMPARACION COMPILADORES)
*  =============================================
*  Este proyecto es una demostración del uso del compilador PicPas con
*  el microcontrolador 16F84A para hacer un reloj de tiempo real con
*  el integrado DS1307.
*
*  Se trata de un reloj totalmente funcional con tres botones de ajuste
*  SET, INC y DEC.
*
*  Ajuste:
*
*  1. Pulsar SET durante 1 segundo.
*  2. Aparece el cursor bajo los dígitos de año. Pulsar INC para
*     incremetar el año o DEC para decrementarlo. Cada pulsación
*     produce el avance o retroceso de una unidad del digito
*     editado. La pulsación larga permite un avance o retroceso
*     repetitivo haciendo más cómodo el ajuste.
*  3. Pulsar SET para pasar a la edición del mes y proceder del
*     mismo modo que en el ajuste del año pulsando INC o DEC.
*  4. Pulsar SET para ajustar del mismo modo el día del mes, hora,
*     y minutos. (los segundos siempre se inIcian a cero después
*     de cada ajuste)
*  5. Tras ajustar minutos y pulsar SET se pasa a la edición del
*     día de la semana (LUN...DOM). Proceder de igual manera
*     pulsando INC o DEC.
*  6. Pulsar SET para finalizar ajuste. El reloj comienza a funcionar
*     con la nueva hora y día.
*
*  NOTAS:
*  - Durante la edición, llegado al límete inferior o superior del
*    dígito editado se pasa automáticamente al valor inferior o
*    superior. Límites:
*        - Año: 00..99
*        - Mes: 01..12
*        - Día: 01..31 (28, 29 o 30 dependiendo del mes)
*        - Hora: 00..23
*        - Minuto: 00..59
*        - Día de Semana: LUN..DOM
*  - El límite superior del mes de febrero para años bisiestos
*    y los meses de 30 y 31 días los ajusta el programa de manera
*    automática. En caso de error en la edición, corrige el valor
*    de manera automática al límite superior válido para el mes.
*  - El integrado DS1307 es un reloj de tiempo real que funciona
*    de manera autónoma, y que sigue funcionando gracias a su batería
*    sin necesidad de suministro eléctrico exterior, por lo que no es
*    necesario ajustar el reloj cada vez que se desconecta la
*    alimentación. Gracias a su bajo consumo, con una batería
*    tipo botón estándar de 48mAh puede seguir funcionando durante
*    más de 10 años sin necesidad de suministro eléctrico exterior.
*/
#include <pic14/pic16f877a.h>

#include <stdint.h>                // Define variables del modo estándar uint8_t, int16_t...
#include <stdbool.h>               // Define el tipo de dato a bit (bool o boolean)

static __code uint16_t __at (_CONFIG) configword1 = _CP_OFF & _DEBUG_OFF & _WRT_OFF &
                      _CPD_OFF & _LVP_ON & _BOREN_ON & _PWRTE_ON & _WDT_OFF & _HS_OSC;

/************************************************************************************************/
/******************************** D E F I N I C I O N E S ***************************************/
/************************************************************************************************/
//
// __I/O pin & estados_________________________________________________________
#define INPUT_PIN           1           // Pin de entrada.
#define OUTPUT_PIN          0           // Pin de salida.
#define HIGH_ST             1           // Estado digital alto (HIGH)
#define LOW_ST              0           // Estado digital bajo (LOW)
//
// __delay_ms()________________________________________________________________
#define FOSC                4000000L    // 4 MHz
//
// __RTC DS1307________________________________________________________________
#define DS1307_CONF         0x90        // 1 Hz en salida SOUT del DS1307.
#define SOUT                RA3         // Pin que lee la salida SOUT
#define SOUT_DIR            TRISA3
//
// __Comunicación I2C__________________________________________________________
#define SDA                 RB0         // Pin SDA del bus I2C
#define SCL                 RB1         // Pin SCL del bus I2C
#define SDA_DIR             TRISB0
#define SCL_DIR             TRISB1
#define SDA_HIGH            SDA = 1     // SDA nivel alto. (HIGH)
#define SDA_LOW             SDA = 0     // SDA nivel bajo. (LOW)
#define SDA_INPUT           SDA_DIR = 1 // SDA como entrada.
#define SDA_OUTPUT          SDA_DIR = 0 // SDA como salida.
#define SCL_OUTPUT          SCL_DIR = 0 // SCL como salida.
#define SCL_HIGH            SCL = 1     // SCL nivel alto.
#define SCL_LOW             SCL = 0     // SCL nivel bajo.
//
// __Pulsadores________________________________________________________________
#define P_INC               RA0    // Pulsador INC
#define P_DEC               RA1    // Pulsador DEC
#define P_SET               RA2    // Pulsador SET
#define P_INC_DIR           TRISA0
#define P_DEC_DIR           TRISA1
#define P_SET_DIR           TRISA2
#define TIEMPO_ANTIREBOTE   10     // Milisegundos espera evitar rebote mecánico de pulsador.
#define TIEMPO_REPETICION   500    // Milisegundos pulsación continua que equivale a otra pulsación.
//
// __Display LCD_______________________________________________________________
// Bus de datos de 4 bits.
#define LCD_DATA_4          RB4         // Pines de datos
#define LCD_DATA_5          RB5
#define LCD_DATA_6          RB6
#define LCD_DATA_7          RB7
#define LCD_RS              RB2         // Pin RS
#define LCD_EN              RB3         // Pin Enable
#define LCD_DATA_4_DIR      TRISB4
#define LCD_DATA_5_DIR      TRISB5
#define LCD_DATA_6_DIR      TRISB6
#define LCD_DATA_7_DIR      TRISB7
#define LCD_RS_DIR          TRISB2
#define LCD_EN_DIR          TRISB3
// Valores de RS.
#define LCD_CmdMode   0    // Indicador envío de Comando (instrucción de configuración)
#define LCD_CharMode  1    // Indicador envío de Dato (carácter)
// ---------------------------------------------------------------------------
// COMANDOS PARA DISPLAY LCD COMPATIBLE CON ESTANDAR HITACHI HD44780
// ---------------------------------------------------------------------------
#define LCD_CMD_CLEAR_DISPLAY               0x01

#define LCD_CMD_DISPLAY_AND_CURSOR_HOME     0x02

#define LCD_CMD_CHARACTER_ENTRY_MODE        0x04
#define     LCD_CMD_INCREMENT               0x02
#define     LCD_CMD_DECREMENT               0x00
#define     LCD_CMD_DISPLAY_SHIFT_ON        0x01
#define     LCD_CMD_DISPLAY_SHIFT_OFF       0x00

#define LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR   0x08
#define     LCD_CMD_DISPLAY_ON              0x04
#define     LCD_CMD_DISPLAY_OFF             0x00
#define     LCD_CMD_CURSOR_UNDERLINE_ON     0x02
#define     LCD_CMD_CURSOR_UNDERLINE_OFF    0x00
#define     LCD_CMD_CURSOR_BLINK_ON         0x01
#define     LCD_CMD_CURSOR_BLINK_OFF        0x00

#define LCD_CMD_DISPLAY_AND_CURSOR_SHIFT    0x10
#define     LCD_CMD_DISPLAY_SHIFT           0x08
#define     LCD_CMD_CURSOR_MOVE             0x00
#define     LCD_CMD_RIGHT                   0x04
#define     LCD_CMD_LEFT                    0x00

#define LCD_CMD_FUNCTION_SET                0x20
#define     LCD_CMD_8BIT_INTERFACE          0x10
#define     LCD_CMD_4BIT_INTERFACE          0x00
#define     LCD_CMD_2LINES                  0x08
#define     LCD_CMD_1LINE                   0x00
#define     LCD_CMD_F_FONT_5_10             0x02
#define     LCD_CMD_F_FONT_5_8              0x00

#define LCD_CMD_SET_DISPLAY_ADDRESS         0x80
#define     LCD_CMD_ROW_0                   0x00
#define     LCD_CMD_ROW_1                   0x40
#define     LCD_CMD_ROW_2                   0x14
#define     LCD_CMD_ROW_3                   0x54

#define LCD_CMD_SET_CGRAM_ADDRESS           0x40

#define LCD_CURSOR_HOME \
    LCD_command(LCD_CMD_DISPLAY_AND_CURSOR_HOME)

#define LCD_CLEAR \
    LCD_command(LCD_CMD_CLEAR_DISPLAY)

#define LCD_CURSOR_UNDELINE \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON + \
    LCD_CMD_CURSOR_UNDERLINE_ON)

#define LCD_CURSOR_BLINK \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON + \
    LCD_CMD_CURSOR_BLINK_ON)

#define LCD_CURSOR_UNDERLINE_BLINK \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON + \
    LCD_CMD_CURSOR_UNDERLINE_ON + LCD_CMD_CURSOR_BLINK_ON)

#define LCD_CURSOR_OFF \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON + \
    LCD_CMD_CURSOR_UNDERLINE_OFF + LCD_CMD_CURSOR_BLINK_OFF)

#define LCD_ON \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON)

#define LCD_OFF \
    LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_OFF)

#define LCD_DISPLAY_SHIFT_RIGHT \
    LCD_command(LCD_CMD_DISPLAY_AND_CURSOR_SHIFT + LCD_CMD_DISPLAY_SHIFT + LCD_CMD_RIGHT)

#define LCD_DISPLAY_SHIFT_LEFT \
  LCD_command(LCD_CMD_DISPLAY_AND_CURSOR_SHIFT + LCD_CMD_DISPLAY_SHIFT + LCD_CMD_LEFT)

#define LCD_DISPLAY_CURSOR_RIGHT \
    LCD_command(LCD_CMD_DISPLAY_AND_CURSOR_SHIFT + LCD_CMD_CURSOR_MOVE + LCD_CMD_RIGHT)

#define LCD_DISPLAY_CURSOR_LEFT \
    LCD_command(LCD_CMD_DISPLAY_AND_CURSOR_SHIFT + LCD_CMD_CURSOR_MOVE + LCD_CMD_LEFT)
// ---------------------------------------------------------------------------


/************************************************************************************************/
/************************** V A R I A B L E S   G L O B A L E S  ********************************/
/************************************************************************************************/

// RTC DS1307
uint8_t  DS1307_DiaSemana;      // Día de la semana (formato numérico 1..7)
uint8_t  DS1307_Dia;            // Día del mes.
uint8_t  DS1307_Mes;            // Mes del año.
uint8_t  DS1307_Ano;            // Año (solo dos dígitos)
uint8_t  DS1307_Hora;           // Hora del día.
uint8_t  DS1307_Minuto;         // Minuto de la hora.
uint8_t  DS1307_Segundo;        // Segundo del minuto.

// Menú edición de fecha y hora.
uint8_t editMenuState;          // Posición o estado dentro del menú de edición.


/************************************************************************************************/
/********************************** F U N C I O N E S *******************************************/
/************************************************************************************************/

/****************************************************************************
  - Función: delay_ms
  - Descripción: Pausa el programa por milisegundos.
  - Entrada:
      > ms: milisegundo de pausa
  - Salida: Ninguna.
*****************************************************************************/
void delay_ms(uint16_t ms)
{
#define __FOSC_CALIBRATED 4000000L    // Calibrado a 4 MHz
#ifdef __PIC16F877A_H__
  #define DELAY_CALIBRATED 61  // Calibrated delay, ~1ms/loop @ 4MHz
#endif
// Se extrapola a cualquier velocidad del microcontrolador.
#define DELAY_CALIBRATED_VAR (DELAY_CALIBRATED*FOSC/__FOSC_CALIBRATED)
   uint16_t aux;

   while(ms--)
   {
       aux=DELAY_CALIBRATED_VAR;      // Calibrated delay
       while(aux--);
   };
}

/****************************************************************************
  Funciones de manejo de display LCD 16x4
*****************************************************************************/
void LCD_send4Bits(uint8_t date)
{
    LCD_DATA_4 = (date & 0x10);
    LCD_DATA_5 = (date & 0x20);
    LCD_DATA_6 = (date & 0x40);
    LCD_DATA_7 = (date & 0x80);
    LCD_EN     = HIGH_ST;
    delay_ms(1);
    LCD_EN     = LOW_ST;
    delay_ms(1);
}
void LCD_send(uint8_t date)
{
    LCD_send4Bits(date);
    LCD_send4Bits(date<<4);
}
void LCD_command(uint8_t comm)
{
    LCD_RS = LCD_CmdMode;
    LCD_send(comm);
}
void LCD_putChar(uint8_t chr)
{
    LCD_RS = LCD_CharMode;
    LCD_send(chr);
}
void LCD_gotoXY(uint8_t columna, uint8_t fila)
{
  if(fila == 0)
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_0);
  else
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_1);
}
void LCD_print(uint8_t *str)
{
    while(*str)
    {
        LCD_putChar(*str);
        str++;
    }
}
void LCD_init(void)
{
    LCD_DATA_4_DIR = OUTPUT_PIN;   // Pines iniciados como Salidas.
    LCD_DATA_5_DIR = OUTPUT_PIN;
    LCD_DATA_6_DIR = OUTPUT_PIN;
    LCD_DATA_7_DIR = OUTPUT_PIN;
    LCD_RS_DIR     = OUTPUT_PIN;
    LCD_EN_DIR     = OUTPUT_PIN;

    delay_ms(200);   // Espera para asegurar tensión estable tras inicio.
    LCD_RS = LOW_ST;
    LCD_EN = LOW_ST;

    // INICIALIZACION POR SOFTWARE DE DISPLAY LCD.
    // Los tiempos de espera y secuencia de datos son los indicados en todos los
    // datasheets de los displays compatibles con el estándar Hitachi HD44780.
    delay_ms(30);    // Espera >= 15 ms
    // INICIACION DE DISPLAY MODO 4 BITS DE DATOS.
    LCD_send4Bits(0b00110000);
    delay_ms(5);    // Espera >= 4.1 ms
    LCD_send4Bits(0b00110000);
    delay_ms(1);    // Espera >= 100 us
    LCD_send4Bits(0b00110000);
    LCD_send4Bits(0b00100000);
    LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_4BIT_INTERFACE + LCD_CMD_2LINES + LCD_CMD_F_FONT_5_8);
    // FIN DE INICIALIZACION POR SOFTWARE DEL DISPLAY LCD.

    // CONFIGURACION DE DISPLAY LCD.
    LCD_OFF;
    LCD_command(LCD_CMD_CHARACTER_ENTRY_MODE + LCD_CMD_INCREMENT + LCD_CMD_DISPLAY_SHIFT_OFF);
    LCD_ON;
    LCD_CLEAR;
}

/****************************************************************************
  Funciones de comunicación I2C mediante software.
*****************************************************************************/
void I2C_start(void)
{
    SDA_HIGH;
    SCL_HIGH;
    SCL_OUTPUT;    // Configura pines I2C como Salidas.
    SDA_OUTPUT;
    SDA_LOW;             // START function for communicate I2C
    SCL_LOW;
}
void I2C_stop(void)
{
    SDA_LOW;
    SCL_HIGH;            // STOP function for communicate I2C
    SDA_HIGH;
}
bool I2C_writeByte(uint8_t dato)     // Send data to I2C
{
    uint8_t i;
    bool ACKbit;

    for(i=0; i<8; i++)
    {
        SDA = (dato & 0x80);    // SDA = bit de más peso del valor dato.
        SCL_HIGH;
        dato<<=1;
        SCL_LOW;
    }

    SDA_INPUT;
    SCL_HIGH;
    ACKbit = SDA;
    SCL_LOW;
    SDA_OUTPUT;
    SDA_LOW;
    return ACKbit;
}
uint8_t I2C_readByte(bool ACKBit)   // Receive data from I2C
{
    uint8_t i;
    uint8_t dato=0;

    SDA_INPUT;
    for(i=0; i<8; i++)
    {
        SCL_HIGH;
        dato<<=1;
        if(SDA) dato|=1;
        SCL_LOW;
    }

    SDA_OUTPUT;
    SDA = !ACKBit;
    SCL_HIGH;
    SCL_LOW;
    return dato;
}

/****************************************************************************
  - Función: BCDToDecimal
  - Descripción: Transforma un número en formato BCD a Decimal.
  - Entrada:
      > bcdByte: Número en formato BCD
  - Salida: Número en formato Decimal.
*****************************************************************************/
uint8_t BCDToDecimal(uint8_t bcdByte)
{
    uint8_t a,b,dec;
    a=(((bcdByte & 0xF0) >> 4) * 10);
    b=(bcdByte & 0x0F);
    dec=a+b;
    return dec;
}

/****************************************************************************
  - Función: decimalToBCD
  - Descripción: Transforma un número en formato Decimal a BCD.
  - Entrada:
      > decimalByte: Número en formato Decimal
  - Salida: Número en formato BCD.
*****************************************************************************/
uint8_t decimalToBCD (uint8_t decimalByte)
{
    uint8_t a,b,bcd;
    a=((decimalByte / 10) << 4);
    b= (decimalByte % 10);
    bcd=a|b;
    return bcd;
}

/****************************************************************************
  - Función: DS1307_timeRead
  - Descripción: Lee fecha y hora del DS1307 a través del bus I2C.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void DS1307_timeRead(void)
{
    I2C_start();          // Inicia comunicación I2C.
    I2C_writeByte(0xD0);  // Dirección I2C del DS1307.
    I2C_writeByte(0x00);  // Primera dirección a leer/escribir.
    I2C_start();          // Reinicia comunicación I2C.
    I2C_writeByte(0xD1);  // DS1307 en Modo Escritura.
    DS1307_Segundo   = BCDToDecimal(I2C_readByte(true)); // ASK = 1
    DS1307_Minuto    = BCDToDecimal(I2C_readByte(true));
    DS1307_Hora      = BCDToDecimal(I2C_readByte(true));
    DS1307_DiaSemana = I2C_readByte(true);  // Valor 1...7 (igual en decimal que en BCD)
    DS1307_Dia       = BCDToDecimal(I2C_readByte(true));
    DS1307_Mes       = BCDToDecimal(I2C_readByte(true));
    DS1307_Ano       = BCDToDecimal(I2C_readByte(false)); // ASK = 0
            // El último ASK antes del Stop debe ser sea cero (/ASK).
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
    I2C_start();          // Inicia comunicación I2C
    I2C_writeByte(0xD0);  // Dirección I2C del DS1307.
    I2C_writeByte(0x00);  // Primera dirección a leer/escribir.
    I2C_writeByte(0);     // Siempre que se ajusta la fecha y hora los Segundos=0.
    I2C_writeByte(decimalToBCD(DS1307_Minuto));
    I2C_writeByte(decimalToBCD(DS1307_Hora));
    I2C_writeByte(DS1307_DiaSemana);  // Valor 1...7 (igual en decimal que en BCD)
    I2C_writeByte(decimalToBCD(DS1307_Dia));
    I2C_writeByte(decimalToBCD(DS1307_Mes));
    I2C_writeByte(decimalToBCD(DS1307_Ano));
    I2C_stop();
}

/****************************************************************************
  - Función: LCDPrintDiaSemana
  - Descripción: Muesta en display LCD el día de la semana actual en
    formato texto.
  - Variables Entrada:
      > dia: Día de la semana en formato numérico (0:Domingo... 6:Sábado)
  - Variables Salida: Ninguna.
*****************************************************************************/
void LCDPrintDiaSemana(void)
{
    switch (DS1307_DiaSemana)
    {
    case 1:
        LCD_print("DOM");
        break;
    case 2:
        LCD_print("LUN");
        break;
    case 3:
        LCD_print("MAR");
        break;
    case 4:
        LCD_print("MIE");
        break;
    case 5:
        LCD_print("JUE");
        break;
    case 6:
        LCD_print("VIE");
        break;
    case 7:
        LCD_print("SAB");
        break;
    }
}

/****************************************************************************
  - Función: bisiesto
  - Descripción: Comprueba si el año actual es bisiesto [margen de 2000 a 2099].
      Para otros márgenes de años, habría que aplicar el algoritmo genérico
      teniendo en cuenta los años múltiplos de 100 o 400.
  - NOTAS: Detalle curioso. Para siglos anteriores al XX, habría que tener en
      cuenta que en España y otros países catolicos el mes de octubre de 1582
      sólo tuvo 20 días. Ese mes, el día siguiente al jueves 4 fue viernes 15.
      En el resto del mundo, el cambio fue produciendose en los siguientes
      siglos (hasta el XX). Por ejemplo, en Inglaterra y colonias fue en 1752
      (el día siguiente al 03/09/1752 fue 14/091782). Este cambio introdujo
      las reglas actuales para los años multiplos de 100 y 400.
  - Entrada: Ninguna.
  - Salida:
      > Devuelve 1 si el año es bisiesto, y 0 si no lo es.
*****************************************************************************/
bool bisiesto(void)
{
    // Devuelve 0 si (DS1307_timeAno%4)!=0, y 1 si (DS1307_timeAno%4)==0
    return !(DS1307_Ano%4);
}

/****************************************************************************
  - Función: diasDelMes
  - Descripción: Devuelve el número de días de cualquier mes del año actual.
  - Entrada: Ninguna.
  - Salida:
      > Número en días del mes.
*****************************************************************************/
uint8_t diasDelMes(void)
{
    if(DS1307_Mes==2)                 // Mes = febrero
    {
        return bisiesto() ? 29 : 28;  // Bisiesto: 29 días / No bisiesto: 28 días.
    }
    if((DS1307_Mes==4) || (DS1307_Mes==6) || (DS1307_Mes==9) || (DS1307_Mes==11))
    {
        return 30;                    // Meses de 30 días.
    }
    return 31;                        // Meses de 31 días.
}

/****************************************************************************
  - Función: LCDPrintNumero
  - Descripción: Imprime en la pantalla LCD un número de 2 dígitos.
  - Entrada:
      > numero: Número entre 0 y 99 a imprimir.
  - Salida: Ninguna.
*****************************************************************************/
void LCDPrintNumero(uint8_t numero)
{
    LCD_putChar((numero/10)+48);   // Imprime dígito decena.
    LCD_putChar((numero%10)+48);   // Imprime dígito unidad.
}

/****************************************************************************
  - Función: timeShow
  - Descripción: Muestra en el display LCD la fecha y hora.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void timeShow(void)
{
    LCD_gotoXY(1,0);
    LCDPrintNumero(DS1307_Dia);
    LCD_putChar('/');
    LCDPrintNumero(DS1307_Mes);
    LCD_putChar('/');
    LCDPrintNumero(DS1307_Ano);
    LCD_print("   ");
    LCDPrintDiaSemana();
    LCD_gotoXY(1,1);
    LCDPrintNumero(DS1307_Hora);
    LCD_putChar(':');
    LCDPrintNumero(DS1307_Minuto);
    LCD_putChar(':');
    LCDPrintNumero(DS1307_Segundo);
}

/****************************************************************************
  - Función: cicloTimeSet
  - Descripción: Subfunción de la función timeRead() que edita las variables
    del día y hora del reloj.
  - Entrada:
      > limInf : Límite Inferior de la variable editada.
      > limSup : Límite Superior de la variable editada.
      > lcdX   : Posición X del display en la que se muestra la variable.
      > lcdY   : Posición Y (fila) del display en la que se muestra la variable.
      > dato   : Dato editado.
  - Salida: Ninguna.
*****************************************************************************/
void cicloTimeSet(uint8_t limInf, uint8_t limSup, uint8_t lcdX, uint8_t lcdY, uint8_t* dato)
{
    while((P_INC && P_DEC)==LOW_ST)  // Si se pulsa INC o DEC.
    {
        LCD_CURSOR_OFF;
        if(P_INC==LOW_ST)            // Se ha pulsado INC.
        {
            (*dato)++;
            if(*dato>limSup) *dato=limInf;  // Controla que no se supere el límite superior.
        }
        else                    // Se ha pulsado DEC.
        {
            (*dato)--;
            if((*dato<limInf)||(*dato==0xFF)) *dato=limSup; // Si limInf==0 (*Dato)-- puede ser 0xFF.

        }
        LCD_gotoXY(lcdX, lcdY);            // Coloca el cursor en la posición de inicio de impresión del dato editado.
        if(lcdX==12) LCDPrintDiaSemana();  // Si se está editando del día de la semana, se imprime el texto.
        else LCDPrintNumero(*dato);        // El resto son variables numéricas de 2 dígitos.
        delay_ms(TIEMPO_REPETICION);       // Espera el tiempo de autorepetición de la tecla pulsada.
    }

    if(P_SET==LOW_ST)                // Si se pulsa SET.
    {
        editMenuState++;
        while(P_SET==LOW_ST) delay_ms(TIEMPO_ANTIREBOTE);  // Espera antirebote mecánico del pulsador.
        if(*dato>limSup) *dato=limSup;  // Evita posible bug al modificar el año o el mes, si
        // no se modifica el día y en ese año o mes ya no es válido.
    }

    if(lcdX==12) lcdX++;       // Si se está editando el día de la semana, se desplaza el cursor
                               // una posición más, ya que el texto ocupa 3 posiciones, en lugar
                               // de dos como el resto de variables.
    LCD_gotoXY(++lcdX, lcdY);  // Coloca el cursor en la parte izquierda de la variable editada.
    LCD_CURSOR_UNDELINE;       // Cursor On
}

/****************************************************************************
  - Función: timeRead
  - Descripción: Set fecha y hora mediante pulsadores y cursor en display LCD.
    Programado según la lógica de una "máquina de estado". La variable global
    editMenuState indica la posición del cursor dentro del bucle de fijación de fecha y
    hora.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void timeSet(void)
#define SET_ANO             1
#define SET_MES             2
#define SET_DIA             3
#define SET_HORA            4
#define SET_MINUTO          5
#define SET_DIA_SEM         6
#define SALIR_SET_TIME      7
{
    LCD_gotoXY(7,1);           // Goto posición de Segundos en display.
    LCDPrintNumero(0);         // 00 en posición de Segundos del display.
    LCD_CURSOR_UNDELINE;       // Cursor On
    while(editMenuState<SALIR_SET_TIME)
    {
        while(editMenuState==SET_ANO)     cicloTimeSet(0,99,7,0,&DS1307_Ano);            // Set año.
        while(editMenuState==SET_MES)     cicloTimeSet(1,12,4,0,&DS1307_Mes);            // Set mes.
        while(editMenuState==SET_DIA)     cicloTimeSet(1,diasDelMes(),1,0,&DS1307_Dia);  // Set día.
        while(editMenuState==SET_HORA)    cicloTimeSet(0,23,1,1,&DS1307_Hora);           // Set hora.
        while(editMenuState==SET_MINUTO)  cicloTimeSet(0,59,4,1,&DS1307_Minuto);         // Set minutos.
        while(editMenuState==SET_DIA_SEM) cicloTimeSet(1,7,12,0,&DS1307_DiaSemana);      // Set día de la semana.
    }
    LCD_CURSOR_OFF;
}


/****************************************************************************
  - Función: Setup
  - Descripción: Inicializa Microcontrolador y Hardware externo conectado.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void setup(void)
{
    CMCON  = 0x07;          // Deshabilita comparadores.
    ADCON1 = 0x06;          // Todos los pines configurados como digitales.
    ADCON0 = 0x00;          // Desactiva conversor A/D.
    GIE    = false;         // Todas las interrupciones desactivadas.

    P_INC_DIR = INPUT_PIN;  // Configura Pulsadores como Entradas.
    P_DEC_DIR = INPUT_PIN;
    P_SET_DIR = INPUT_PIN;
    SOUT_DIR  = INPUT_PIN;

    I2C_start();                 // Inicia comunicación I2C
    I2C_writeByte(0xD0);         // Dirección I2C del DS1307.
    I2C_writeByte(0x07);         // Escribe en la dirección 07h.
    I2C_writeByte(DS1307_CONF);  // Configura 1 Hz en salida SOUT del DS1307
    I2C_stop();

    LCD_init();                  // Inicializa display LCD.
}

/****************************************************************************
  - Función: main
  - Descripción: Programa Principal.
  - Entrada: Ninguna.
  - Salida: Ninguna.
*****************************************************************************/
void main(void)
{
    setup();

    while(true)
    {
        if(P_SET==LOW_ST)   // Comprueba si se ha pulsado SET
        {
            editMenuState=1;
            // Espera fin pulsación y antirebote mecánico.
            while(P_SET==LOW_ST) delay_ms(TIEMPO_ANTIREBOTE);
            timeSet();            // Ajuste de reloj.
            DS1307_timeWrite();   // Envía datos editados.
        }

        DS1307_timeRead();  // Lee datos de fecha y hora.
        timeShow();         // Actualiza display LCD con fecha y hora.

        // Espera 1 segundo usando salida SOUT del DS1307 (1 Hz)
        while(SOUT);        // Espera durante pulso alto.
        while(!SOUT);       // Espera durante pulso bajo.
    }
}
