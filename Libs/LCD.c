//
// Librería manejo integrado displays LCD compatibles con el estándar HITACHI HD44780.
//

#ifndef __LCD_LIB_H
#define __LCD_LIB_H



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

// Valore de RS.
#define LCD_CmdMode   0    // Indicador envío de Comando (instrucción de configuración)
#define LCD_CharMode  1    // Indicador envío de Dato (carácter)

// Librería de retardos.
#include "delay.c"

#ifdef LCD_USE_CREATECHAR
void LCD_createChar(char charnum,
                    char chardata0,
                    char chardata1,
                    char chardata2,
                    char chardata3,
                    char chardata4,
                    char chardata5,
                    char chardata6,
                    char chardata7)
{
  charnum = charnum & 0x07;  // Previene errores sin charnum > 7;
  charnum = charnum << 3;
  LCD_command(LCD_CMD_SET_CGRAM_ADDRESS + charnum);
  LCD_putChar(chardata0);
  LCD_putChar(chardata1);
  LCD_putChar(chardata2);
  LCD_putChar(chardata3);
  LCD_putChar(chardata4);
  LCD_putChar(chardata5);
  LCD_putChar(chardata6);
  LCD_putChar(chardata7);
  LCD_clear;    // Necesario para finalizar la creacion de Custom Character.
}
#endif // LCD_USE_CREATECHAR

#ifndef LCD_BUS_DATA_BITS
  #error "Se debe definir un valor para LCD_BUS_DATA_BITS."
#endif

#if LCD_BUS_DATA_BITS == 4
#define BIT4 0x01<<4
#define BIT5 0x01<<5
#define BIT6 0x01<<6
#define BIT7 0x01<<7
void LCD_send4Bits(char date)
{
    LCD_DATA_4 = (date & BIT4);
    LCD_DATA_5 = (date & BIT5);
    LCD_DATA_6 = (date & BIT6);
    LCD_DATA_7 = (date & BIT7);
    LCD_EN     = 1;
    delay_ms(1);
    LCD_EN     = 0;
    delay_ms(1);
}

void LCD_send(char date)
{
    LCD_send4Bits(date);
    delay_ms(1);
    LCD_send4Bits(date<<4);
    delay_ms(1);
}
#elif LCD_BUS_DATA_BITS == 8
void LCD_send(char date)
{
    LCD_DATA = date;
    LCD_EN     = 1;
    delay_ms(1);
    LCD_EN     = 0;
    delay_ms(1);
}
#else
  #error "LCD_BUS_DATA_BITS debe definirse como '8' o '4'."
#endif // LCD_BUS_DATA_BITS

void LCD_command(char comm)
{
    LCD_RS = LCD_CmdMode;
    LCD_send(comm);
}

void LCD_putChar(char chr)
{
    LCD_RS = LCD_CharMode;
    LCD_send(chr);
}

#ifndef LCD_FILAS
  #define LCD_FILAS 4
#endif
void LCD_gotoXY(char columna, char fila)
{
  if(fila == 0)
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_0);
#if LCD_FILAS > 1
  else if (fila == 1)
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_1);
#endif
#if LCD_FILAS > 2
  else if (fila == 2)
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_2);
  else if (fila == 3)
    LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_3);
#endif
}

void LCD_print(char *str)
{
    while(*str)
    {
        LCD_putChar(*str);
        str++;
    }
}

void LCD_init(void)
{
#if LCD_BUS_DATA_BITS == 4
    TRIS_LCD_DATA_4 = 0;              // Pines iniciados como salida.
    TRIS_LCD_DATA_5 = 0;
    TRIS_LCD_DATA_6 = 0;
    TRIS_LCD_DATA_7 = 0;
#elif LCD_BUS_DATA_BITS == 8
    TRIS_LCD_DATA = 0x00;             // Todos lo pines de puerto como salida.
#endif // LCD_BUS_DATA_BITS
    TRIS_LCD_RS     = 0;
    TRIS_LCD_EN     = 0;

    delay_ms(200);   // Espera para asegurar tension estable tras arranque.
    LCD_RS = 0;
    LCD_EN = 0;

// -- INICIALIZACION POR SOFTWARE DE DISPLAY LCD.
  // Los tiempos de espera son los indicados en todos los
  // datasheets de los displays compatibles con el estandar Hitachi HD44780.
    delay_ms(30);    // Espera 15 ms o más.

#if LCD_BUS_DATA_BITS == 4
    // INICIACION DE DISPLAY MODO 4 BITS DE DATOS.
    LCD_send4Bits(0b00110000);
    delay_ms(5);  // Espera > 4.1 ms
    LCD_send4Bits(0b00110000);
    delay_ms(1);  // Espera > 100 us
    LCD_send4Bits(0b00110000);
    LCD_send4Bits(0b00100000);
    LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_4BIT_INTERFACE + LCD_CMD_2LINES + LCD_CMD_F_FONT_5_8);
#elif LCD_BUS_DATA_BITS == 8
    // INICIACION DE DISPLAY MODO 8 BITS DE DATOS.
    LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_8BIT_INTERFACE);
    delay_ms(5);  // Espera > 4.1 ms
    LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_8BIT_INTERFACE);
    delay_ms(1);  // Espera > 100 Us
    LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_8BIT_INTERFACE + LCD_CMD_2LINES + LCD_CMD_F_FONT_5_8);
#endif // LCD_BUS_DATA_BITS
// -- FIN DE INICIALIZACION POR SOFTWARE DEL DISPLAY LCD.

// -- CONFIGURACION DE DISPLAY LCD.
    //LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_OFF);
    LCD_OFF;
    LCD_command(LCD_CMD_CHARACTER_ENTRY_MODE + LCD_CMD_INCREMENT + LCD_CMD_DISPLAY_SHIFT_OFF);
    //LCD_command(LCD_CMD_DISPLAY_ON_OFF_AND_CURSOR + LCD_CMD_DISPLAY_ON);
    LCD_ON;
    //LCD_command(LCD_CMD_CLEAR_DISPLAY);
    LCD_CLEAR;
}

#endif // __LCD_LIB_H
