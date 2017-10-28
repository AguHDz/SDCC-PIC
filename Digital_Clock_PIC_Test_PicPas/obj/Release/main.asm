;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"main.c"
	list	p=16f877a
	radix dec
	include "p16f877a.inc"
;--------------------------------------------------------
; config word(s)
;--------------------------------------------------------
	__config 0x3ff2
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_STATUSbits
	extern	_PORTAbits
	extern	_PORTBbits
	extern	_PORTCbits
	extern	_PORTDbits
	extern	_PORTEbits
	extern	_INTCONbits
	extern	_PIR1bits
	extern	_PIR2bits
	extern	_T1CONbits
	extern	_T2CONbits
	extern	_SSPCONbits
	extern	_CCP1CONbits
	extern	_RCSTAbits
	extern	_CCP2CONbits
	extern	_ADCON0bits
	extern	_OPTION_REGbits
	extern	_TRISAbits
	extern	_TRISBbits
	extern	_TRISCbits
	extern	_TRISDbits
	extern	_TRISEbits
	extern	_PIE1bits
	extern	_PIE2bits
	extern	_PCONbits
	extern	_SSPCON2bits
	extern	_SSPSTATbits
	extern	_TXSTAbits
	extern	_CMCONbits
	extern	_CVRCONbits
	extern	_ADCON1bits
	extern	_EECON1bits
	extern	_INDF
	extern	_TMR0
	extern	_PCL
	extern	_STATUS
	extern	_FSR
	extern	_PORTA
	extern	_PORTB
	extern	_PORTC
	extern	_PORTD
	extern	_PORTE
	extern	_PCLATH
	extern	_INTCON
	extern	_PIR1
	extern	_PIR2
	extern	_TMR1
	extern	_TMR1L
	extern	_TMR1H
	extern	_T1CON
	extern	_TMR2
	extern	_T2CON
	extern	_SSPBUF
	extern	_SSPCON
	extern	_CCPR1
	extern	_CCPR1L
	extern	_CCPR1H
	extern	_CCP1CON
	extern	_RCSTA
	extern	_TXREG
	extern	_RCREG
	extern	_CCPR2
	extern	_CCPR2L
	extern	_CCPR2H
	extern	_CCP2CON
	extern	_ADRESH
	extern	_ADCON0
	extern	_OPTION_REG
	extern	_TRISA
	extern	_TRISB
	extern	_TRISC
	extern	_TRISD
	extern	_TRISE
	extern	_PIE1
	extern	_PIE2
	extern	_PCON
	extern	_SSPCON2
	extern	_PR2
	extern	_SSPADD
	extern	_SSPSTAT
	extern	_TXSTA
	extern	_SPBRG
	extern	_CMCON
	extern	_CVRCON
	extern	_ADRESL
	extern	_ADCON1
	extern	_EEDATA
	extern	_EEADR
	extern	_EEDATH
	extern	_EEADRH
	extern	_EECON1
	extern	_EECON2
	extern	__gptrget1
	extern	__mulchar
	extern	__divuchar
	extern	__moduchar
	extern	__gptrput1
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_delay_ms
	global	_LCD_send4Bits
	global	_LCD_send
	global	_LCD_command
	global	_LCD_putChar
	global	_LCD_gotoXY
	global	_LCD_print
	global	_LCD_init
	global	_I2C_start
	global	_I2C_stop
	global	_I2C_writeByte
	global	_I2C_readByte
	global	_BCDToDecimal
	global	_decimalToBCD
	global	_DS1307_timeRead
	global	_DS1307_timeWrite
	global	_LCDPrintDiaSemana
	global	_bisiesto
	global	_diasDelMes
	global	_LCDPrintNumero
	global	_timeShow
	global	_cicloTimeSet
	global	_timeSet
	global	_setup
	global	_main
	global	_DS1307_DiaSemana
	global	_DS1307_Dia
	global	_DS1307_Mes
	global	_DS1307_Ano
	global	_DS1307_Hora
	global	_DS1307_Minuto
	global	_DS1307_Segundo
	global	_editMenuState

	global PSAVE
	global SSAVE
	global WSAVE
	global STK12
	global STK11
	global STK10
	global STK09
	global STK08
	global STK07
	global STK06
	global STK05
	global STK04
	global STK03
	global STK02
	global STK01
	global STK00

sharebank udata_ovr 0x0070
PSAVE	res 1
SSAVE	res 1
WSAVE	res 1
STK12	res 1
STK11	res 1
STK10	res 1
STK09	res 1
STK08	res 1
STK07	res 1
STK06	res 1
STK05	res 1
STK04	res 1
STK03	res 1
STK02	res 1
STK01	res 1
STK00	res 1

;--------------------------------------------------------
; global definitions
;--------------------------------------------------------
UD_main_0	udata
_DS1307_DiaSemana	res	1

UD_main_1	udata
_DS1307_Dia	res	1

UD_main_2	udata
_DS1307_Mes	res	1

UD_main_3	udata
_DS1307_Ano	res	1

UD_main_4	udata
_DS1307_Hora	res	1

UD_main_5	udata
_DS1307_Minuto	res	1

UD_main_6	udata
_DS1307_Segundo	res	1

UD_main_7	udata
_editMenuState	res	1

;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x1009	res	1
r0x1008	res	1
r0x100A	res	1
r0x100B	res	1
r0x100C	res	1
r0x100D	res	1
r0x100E	res	1
r0x100F	res	1
r0x1010	res	1
r0x1011	res	1
r0x1013	res	1
r0x1014	res	1
r0x1015	res	1
r0x1016	res	1
r0x1017	res	1
r0x1018	res	1
r0x1019	res	1
r0x101A	res	1
r0x101C	res	1
r0x101B	res	1
r0x101D	res	1
r0x101E	res	1
r0x1021	res	1
r0x1020	res	1
r0x101F	res	1
r0x1022	res	1
r0x1023	res	1
r0x1024	res	1
r0x1026	res	1
r0x1025	res	1
r0x1027	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------

ID_main_0	code
___str_0
	retlw 0x44 ; 'D'
	retlw 0x4f ; 'O'
	retlw 0x4d ; 'M'
	retlw 0x00 ; '.'

ID_main_1	code
___str_1
	retlw 0x4c ; 'L'
	retlw 0x55 ; 'U'
	retlw 0x4e ; 'N'
	retlw 0x00 ; '.'

ID_main_2	code
___str_2
	retlw 0x4d ; 'M'
	retlw 0x41 ; 'A'
	retlw 0x52 ; 'R'
	retlw 0x00 ; '.'

ID_main_3	code
___str_3
	retlw 0x4d ; 'M'
	retlw 0x49 ; 'I'
	retlw 0x45 ; 'E'
	retlw 0x00 ; '.'

ID_main_4	code
___str_4
	retlw 0x4a ; 'J'
	retlw 0x55 ; 'U'
	retlw 0x45 ; 'E'
	retlw 0x00 ; '.'

ID_main_5	code
___str_5
	retlw 0x56 ; 'V'
	retlw 0x49 ; 'I'
	retlw 0x45 ; 'E'
	retlw 0x00 ; '.'

ID_main_6	code
___str_6
	retlw 0x53 ; 'S'
	retlw 0x41 ; 'A'
	retlw 0x42 ; 'B'
	retlw 0x00 ; '.'

ID_main_7	code
___str_7
	retlw 0x20 ; ' '
	retlw 0x20 ; ' '
	retlw 0x20 ; ' '
	retlw 0x00 ; '.'
;--------------------------------------------------------
; overlayable items in internal ram 
;--------------------------------------------------------
;	udata_ovr
;--------------------------------------------------------
; reset vector 
;--------------------------------------------------------
STARTUP	code 0x0000
	nop
	pagesel __sdcc_gsinit_startup
	goto	__sdcc_gsinit_startup
;--------------------------------------------------------
; code
;--------------------------------------------------------
code_main	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _setup
;   _delay_ms
;   _timeSet
;   _DS1307_timeWrite
;   _DS1307_timeRead
;   _timeShow
;   _setup
;   _delay_ms
;   _timeSet
;   _DS1307_timeWrite
;   _DS1307_timeRead
;   _timeShow
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_main__main	code
_main:
; 2 exit points
;	.line	703; "main.c"	setup();
	PAGESEL	_setup
	CALL	_setup
	PAGESEL	$
_00363_DS_:
;	.line	707; "main.c"	if(P_SET==LOW_ST)   // Comprueba si se ha pulsado SET
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,2
	GOTO	_00355_DS_
;	.line	709; "main.c"	editMenuState=1;
	MOVLW	0x01
	BANKSEL	_editMenuState
	MOVWF	_editMenuState
_00351_DS_:
;	.line	711; "main.c"	while(P_SET==LOW_ST) delay_ms(TIEMPO_ANTIREBOTE);
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,2
	GOTO	_00353_DS_
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	GOTO	_00351_DS_
_00353_DS_:
;	.line	712; "main.c"	timeSet();
	PAGESEL	_timeSet
	CALL	_timeSet
	PAGESEL	$
;	.line	713; "main.c"	DS1307_timeWrite();
	PAGESEL	_DS1307_timeWrite
	CALL	_DS1307_timeWrite
	PAGESEL	$
_00355_DS_:
;	.line	716; "main.c"	DS1307_timeRead();
	PAGESEL	_DS1307_timeRead
	CALL	_DS1307_timeRead
	PAGESEL	$
;	.line	718; "main.c"	timeShow();         // Actualiza display LCD con fecha y hora.
	PAGESEL	_timeShow
	CALL	_timeShow
	PAGESEL	$
_00356_DS_:
;	.line	721; "main.c"	while(SOUT);        // Espera durante pulso alto.
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,3
	GOTO	_00356_DS_
_00359_DS_:
;	.line	722; "main.c"	while(!SOUT);       // Espera durante pulso bajo.
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,3
	GOTO	_00363_DS_
	GOTO	_00359_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_stop
;   _LCD_init
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_stop
;   _LCD_init
;; Starting pCode block
S_main__setup	code
_setup:
; 2 exit points
;	.line	676; "main.c"	CMCON  = 0x07;          // Deshabilita comparadores.
	MOVLW	0x07
	BANKSEL	_CMCON
	MOVWF	_CMCON
;	.line	677; "main.c"	ADCON1 = 0x06;          // Todos los pines configurados como digitales.
	MOVLW	0x06
	MOVWF	_ADCON1
;	.line	678; "main.c"	ADCON0 = 0x00;          // Desactiva conversor A/D.
	BANKSEL	_ADCON0
	CLRF	_ADCON0
;	.line	679; "main.c"	GIE    = false;         // Todas las interrupciones desactivadas.
	BCF	_INTCONbits,7
;	.line	681; "main.c"	P_INC_DIR = INPUT_PIN;  // Configura Pulsadores como Entradas.
	BANKSEL	_TRISAbits
	BSF	_TRISAbits,0
;	.line	682; "main.c"	P_DEC_DIR = INPUT_PIN;
	BSF	_TRISAbits,1
;	.line	683; "main.c"	P_SET_DIR = INPUT_PIN;
	BSF	_TRISAbits,2
;	.line	684; "main.c"	SOUT_DIR  = INPUT_PIN;
	BSF	_TRISAbits,3
;	.line	686; "main.c"	I2C_start();            // Inicia comunicación I2C
	PAGESEL	_I2C_start
	CALL	_I2C_start
	PAGESEL	$
;	.line	687; "main.c"	I2C_writeByte(0xD0);         // Dirección I2C del DS1307.
	MOVLW	0xd0
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	688; "main.c"	I2C_writeByte(0x07);         // Escribe en la dirección 07h.
	MOVLW	0x07
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	689; "main.c"	I2C_writeByte(DS1307_CONF);  // Configura 1 Hz en salida SOUT del DS1307
	MOVLW	0x90
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	690; "main.c"	I2C_stop();
	PAGESEL	_I2C_stop
	CALL	_I2C_stop
	PAGESEL	$
;	.line	692; "main.c"	LCD_init();             // Inicializa display LCD.
	PAGESEL	_LCD_init
	CALL	_LCD_init
	PAGESEL	$
	RETURN	
; exit point of _setup

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_command
;   _cicloTimeSet
;   _cicloTimeSet
;   _diasDelMes
;   _cicloTimeSet
;   _cicloTimeSet
;   _cicloTimeSet
;   _cicloTimeSet
;   _LCD_command
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_command
;   _cicloTimeSet
;   _cicloTimeSet
;   _diasDelMes
;   _cicloTimeSet
;   _cicloTimeSet
;   _cicloTimeSet
;   _cicloTimeSet
;   _LCD_command
;10 compiler assigned registers:
;   STK00
;   r0x1025
;   r0x1026
;   r0x1027
;   STK05
;   STK04
;   STK03
;   STK02
;   STK01
;   r0x1028
;; Starting pCode block
S_main__timeSet	code
_timeSet:
; 2 exit points
;	.line	652; "main.c"	LCD_gotoXY(7,1);           // Goto posición de Segundos en display.
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x07
	PAGESEL	_LCD_gotoXY
	CALL	_LCD_gotoXY
	PAGESEL	$
;	.line	653; "main.c"	LCDPrintNumero(0);         // 00 en posición de Segundos del display.
	MOVLW	0x00
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	654; "main.c"	LCD_CURSOR_UNDELINE;       // Cursor On
	MOVLW	0x0e
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;;unsigned compare: left < lit(0x7=7), size=1
_00340_DS_:
;	.line	655; "main.c"	while(editMenuState<SALIR_SET_TIME)
	MOVLW	0x07
	BANKSEL	_editMenuState
	SUBWF	_editMenuState,W
	BTFSC	STATUS,0
	GOTO	_00342_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
_00322_DS_:
;	.line	657; "main.c"	while(editMenuState==SET_ANO)     cicloTimeSet(0,99,7,0,&DS1307_Ano);            // Set año.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x01
	BTFSS	STATUS,2
	GOTO	_00325_DS_
	MOVLW	high (_DS1307_Ano + 0)
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVLW	(_DS1307_Ano + 0)
	MOVWF	r0x1026
	CLRF	r0x1027
	MOVF	r0x1026,W
	MOVWF	STK05
	MOVF	r0x1025,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x07
	MOVWF	STK01
	MOVLW	0x63
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00322_DS_
_00325_DS_:
;	.line	658; "main.c"	while(editMenuState==SET_MES)     cicloTimeSet(1,12,4,0,&DS1307_Mes);            // Set mes.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x02
	BTFSS	STATUS,2
	GOTO	_00328_DS_
	MOVLW	high (_DS1307_Mes + 0)
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVLW	(_DS1307_Mes + 0)
	MOVWF	r0x1026
	CLRF	r0x1027
	MOVF	r0x1026,W
	MOVWF	STK05
	MOVF	r0x1025,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x04
	MOVWF	STK01
	MOVLW	0x0c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00325_DS_
_00328_DS_:
;	.line	659; "main.c"	while(editMenuState==SET_DIA)     cicloTimeSet(1,diasDelMes(),1,0,&DS1307_Dia);  // Set día.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x03
	BTFSS	STATUS,2
	GOTO	_00331_DS_
	PAGESEL	_diasDelMes
	CALL	_diasDelMes
	PAGESEL	$
	BANKSEL	r0x1026
	MOVWF	r0x1026
	MOVLW	high (_DS1307_Dia + 0)
	MOVWF	r0x1027
	MOVLW	(_DS1307_Dia + 0)
	MOVWF	r0x1025
	MOVWF	STK05
	MOVF	r0x1027,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x01
	MOVWF	STK01
	MOVF	r0x1026,W
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00328_DS_
_00331_DS_:
;	.line	660; "main.c"	while(editMenuState==SET_HORA)    cicloTimeSet(0,23,1,1,&DS1307_Hora);           // Set hora.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x04
	BTFSS	STATUS,2
	GOTO	_00334_DS_
	MOVLW	high (_DS1307_Hora + 0)
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVLW	(_DS1307_Hora + 0)
	MOVWF	r0x1026
	CLRF	r0x1027
	MOVF	r0x1026,W
	MOVWF	STK05
	MOVF	r0x1025,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x01
	MOVWF	STK02
	MOVLW	0x01
	MOVWF	STK01
	MOVLW	0x17
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00331_DS_
_00334_DS_:
;	.line	661; "main.c"	while(editMenuState==SET_MINUTO)  cicloTimeSet(0,59,4,1,&DS1307_Minuto);         // Set minutos.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x05
	BTFSS	STATUS,2
	GOTO	_00337_DS_
	MOVLW	high (_DS1307_Minuto + 0)
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVLW	(_DS1307_Minuto + 0)
	MOVWF	r0x1026
	CLRF	r0x1027
	MOVF	r0x1026,W
	MOVWF	STK05
	MOVF	r0x1025,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x01
	MOVWF	STK02
	MOVLW	0x04
	MOVWF	STK01
	MOVLW	0x3b
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00334_DS_
_00337_DS_:
;	.line	662; "main.c"	while(editMenuState==SET_DIA_SEM) cicloTimeSet(1,7,12,0,&DS1307_DiaSemana);      // Set día de la semana.
	BANKSEL	_editMenuState
	MOVF	_editMenuState,W
	XORLW	0x06
	BTFSS	STATUS,2
	GOTO	_00340_DS_
	MOVLW	high (_DS1307_DiaSemana + 0)
	BANKSEL	r0x1025
	MOVWF	r0x1025
	MOVLW	(_DS1307_DiaSemana + 0)
	MOVWF	r0x1026
	CLRF	r0x1027
	MOVF	r0x1026,W
	MOVWF	STK05
	MOVF	r0x1025,W
	MOVWF	STK04
	MOVLW	0x00
	MOVWF	STK03
	MOVLW	0x00
	MOVWF	STK02
	MOVLW	0x0c
	MOVWF	STK01
	MOVLW	0x07
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_cicloTimeSet
	CALL	_cicloTimeSet
	PAGESEL	$
	GOTO	_00337_DS_
_00342_DS_:
;	.line	664; "main.c"	LCD_CURSOR_OFF;
	MOVLW	0x0c
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
	RETURN	
; exit point of _timeSet

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_command
;   __gptrget1
;   __gptrput1
;   __gptrput1
;   __gptrget1
;   __gptrput1
;   __gptrget1
;   __gptrput1
;   _LCD_gotoXY
;   _LCDPrintDiaSemana
;   __gptrget1
;   _LCDPrintNumero
;   _delay_ms
;   _delay_ms
;   __gptrget1
;   __gptrput1
;   _LCD_gotoXY
;   _LCD_command
;   _LCD_command
;   __gptrget1
;   __gptrput1
;   __gptrput1
;   __gptrget1
;   __gptrput1
;   __gptrget1
;   __gptrput1
;   _LCD_gotoXY
;   _LCDPrintDiaSemana
;   __gptrget1
;   _LCDPrintNumero
;   _delay_ms
;   _delay_ms
;   __gptrget1
;   __gptrput1
;   _LCD_gotoXY
;   _LCD_command
;16 compiler assigned registers:
;   r0x101B
;   STK00
;   r0x101C
;   STK01
;   r0x101D
;   STK02
;   r0x101E
;   STK03
;   r0x101F
;   STK04
;   r0x1020
;   STK05
;   r0x1021
;   r0x1022
;   r0x1023
;   r0x1024
;; Starting pCode block
S_main__cicloTimeSet	code
_cicloTimeSet:
; 2 exit points
;	.line	597; "main.c"	void cicloTimeSet(uint8_t limInf, uint8_t limSup, uint8_t lcdX, uint8_t lcdY, uint8_t* dato)
	BANKSEL	r0x101B
	MOVWF	r0x101B
	MOVF	STK00,W
	MOVWF	r0x101C
	MOVF	STK01,W
	MOVWF	r0x101D
	MOVF	STK02,W
	MOVWF	r0x101E
	MOVF	STK03,W
	MOVWF	r0x101F
	MOVF	STK04,W
	MOVWF	r0x1020
	MOVF	STK05,W
	MOVWF	r0x1021
;	.line	599; "main.c"	while((P_INC && P_DEC)==LOW_ST)  // Si se pulsa INC o DEC.
	CLRF	r0x1022
	MOVF	r0x101D,W
	XORLW	0x0c
	BTFSC	STATUS,2
	INCF	r0x1022,F
_00269_DS_:
	BANKSEL	_PORTAbits
	BTFSS	_PORTAbits,0
	GOTO	_00270_DS_
	BTFSC	_PORTAbits,1
	GOTO	_00271_DS_
_00270_DS_:
;	.line	601; "main.c"	LCD_CURSOR_OFF;
	MOVLW	0x0c
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;	.line	602; "main.c"	if(P_INC==LOW_ST)            // Se ha pulsado INC.
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,0
	GOTO	_00264_DS_
;	.line	604; "main.c"	(*dato)++;
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1023
	MOVWF	r0x1023
	INCF	r0x1023,F
	MOVF	r0x1023,W
	MOVWF	STK02
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
;	.line	605; "main.c"	if(*dato>limSup) *dato=limInf;  // Controla que no se supere el límite superior.
	BANKSEL	r0x1023
	MOVF	r0x1023,W
	SUBWF	r0x101C,W
	BTFSC	STATUS,0
	GOTO	_00265_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
	MOVF	r0x101B,W
	MOVWF	STK02
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
	GOTO	_00265_DS_
_00264_DS_:
;	.line	609; "main.c"	(*dato)--;
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1023
	MOVWF	r0x1023
	DECF	r0x1023,F
	MOVF	r0x1023,W
	MOVWF	STK02
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
;	.line	610; "main.c"	if((*dato<limInf)||(*dato==0xFF)) *dato=limSup; // Si limInf==0 (*Dato)-- puede ser 0xFF.
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1024
	MOVWF	r0x1024
	MOVF	r0x101B,W
	SUBWF	r0x1023,W
	BTFSS	STATUS,0
	GOTO	_00260_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
	MOVF	r0x1024,W
	XORLW	0xff
	BTFSS	STATUS,2
	GOTO	_00265_DS_
_00260_DS_:
	BANKSEL	r0x101C
	MOVF	r0x101C,W
	MOVWF	STK02
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
_00265_DS_:
;	.line	613; "main.c"	LCD_gotoXY(lcdX, lcdY);            // Coloca el cursor en la posición de inicio de impresión del dato editado.
	BANKSEL	r0x101E
	MOVF	r0x101E,W
	MOVWF	STK00
	MOVF	r0x101D,W
	PAGESEL	_LCD_gotoXY
	CALL	_LCD_gotoXY
	PAGESEL	$
;	.line	614; "main.c"	if(lcdX==12) LCDPrintDiaSemana();  // Si se está editando del día de la semana, se imprime el texto.
	BANKSEL	r0x1022
	MOVF	r0x1022,W
	BTFSC	STATUS,2
	GOTO	_00267_DS_
	PAGESEL	_LCDPrintDiaSemana
	CALL	_LCDPrintDiaSemana
	PAGESEL	$
	GOTO	_00268_DS_
_00267_DS_:
;	.line	615; "main.c"	else LCDPrintNumero(*dato);        // El resto son variables numéricas de 2 dígitos.
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1023
	MOVWF	r0x1023
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
_00268_DS_:
;	.line	616; "main.c"	delay_ms(TIEMPO_REPETICION);       // Espera el tiempo de autorepetición de la tecla pulsada.
	MOVLW	0xf4
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	GOTO	_00269_DS_
_00271_DS_:
;	.line	619; "main.c"	if(P_SET==LOW_ST)                // Si se pulsa SET.
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,2
	GOTO	_00278_DS_
;	.line	621; "main.c"	editMenuState++;
	BANKSEL	_editMenuState
	INCF	_editMenuState,F
_00272_DS_:
;	.line	622; "main.c"	while(P_SET==LOW_ST) delay_ms(TIEMPO_ANTIREBOTE);  // Espera antirebote mecánico del pulsador.
	BANKSEL	_PORTAbits
	BTFSC	_PORTAbits,2
	GOTO	_00274_DS_
	MOVLW	0x0a
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	GOTO	_00272_DS_
_00274_DS_:
;	.line	623; "main.c"	if(*dato>limSup) *dato=limSup;  // Evita posible bug al modificar el año o el mes, si
	BANKSEL	r0x1021
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x101B
	MOVWF	r0x101B
	SUBWF	r0x101C,W
	BTFSC	STATUS,0
	GOTO	_00278_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
	MOVF	r0x101C,W
	MOVWF	STK02
	MOVF	r0x1021,W
	MOVWF	STK01
	MOVF	r0x1020,W
	MOVWF	STK00
	MOVF	r0x101F,W
	PAGESEL	__gptrput1
	CALL	__gptrput1
	PAGESEL	$
_00278_DS_:
;	.line	627; "main.c"	if(lcdX==12) lcdX++;       // Si se está editando el día de la semana, se desplaza el cursor
	MOVLW	0x00
;	.line	630; "main.c"	LCD_gotoXY(++lcdX, lcdY);  // Coloca el cursor en la parte izquierda de la variable editada.
	BANKSEL	r0x1022
	IORWF	r0x1022,W
	BTFSS	STATUS,2
	INCF	r0x101D,F
	INCF	r0x101D,F
	MOVF	r0x101E,W
	MOVWF	STK00
	MOVF	r0x101D,W
	PAGESEL	_LCD_gotoXY
	CALL	_LCD_gotoXY
	PAGESEL	$
;	.line	631; "main.c"	LCD_CURSOR_UNDELINE;       // Cursor On
	MOVLW	0x0e
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
	RETURN	
; exit point of _cicloTimeSet

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_print
;   _LCDPrintDiaSemana
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_print
;   _LCDPrintDiaSemana
;   _LCD_gotoXY
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;   _LCD_putChar
;   _LCDPrintNumero
;5 compiler assigned registers:
;   STK00
;   r0x101B
;   r0x101C
;   r0x101D
;   STK01
;; Starting pCode block
S_main__timeShow	code
_timeShow:
; 2 exit points
;	.line	569; "main.c"	LCD_gotoXY(1,0);
	MOVLW	0x00
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_LCD_gotoXY
	CALL	_LCD_gotoXY
	PAGESEL	$
;	.line	570; "main.c"	LCDPrintNumero(DS1307_Dia);
	BANKSEL	_DS1307_Dia
	MOVF	_DS1307_Dia,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	571; "main.c"	LCD_putChar('/');
	MOVLW	0x2f
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	572; "main.c"	LCDPrintNumero(DS1307_Mes);
	BANKSEL	_DS1307_Mes
	MOVF	_DS1307_Mes,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	573; "main.c"	LCD_putChar('/');
	MOVLW	0x2f
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	574; "main.c"	LCDPrintNumero(DS1307_Ano);
	BANKSEL	_DS1307_Ano
	MOVF	_DS1307_Ano,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	575; "main.c"	LCD_print("   ");
	MOVLW	high (___str_7 + 0)
	BANKSEL	r0x101B
	MOVWF	r0x101B
	MOVLW	(___str_7 + 0)
	MOVWF	r0x101C
	MOVLW	0x80
	MOVWF	r0x101D
	MOVF	r0x101C,W
	MOVWF	STK01
	MOVF	r0x101B,W
	MOVWF	STK00
	MOVF	r0x101D,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	576; "main.c"	LCDPrintDiaSemana();
	PAGESEL	_LCDPrintDiaSemana
	CALL	_LCDPrintDiaSemana
	PAGESEL	$
;	.line	577; "main.c"	LCD_gotoXY(1,1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_LCD_gotoXY
	CALL	_LCD_gotoXY
	PAGESEL	$
;	.line	578; "main.c"	LCDPrintNumero(DS1307_Hora);
	BANKSEL	_DS1307_Hora
	MOVF	_DS1307_Hora,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	579; "main.c"	LCD_putChar(':');
	MOVLW	0x3a
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	580; "main.c"	LCDPrintNumero(DS1307_Minuto);
	BANKSEL	_DS1307_Minuto
	MOVF	_DS1307_Minuto,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
;	.line	581; "main.c"	LCD_putChar(':');
	MOVLW	0x3a
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	582; "main.c"	LCDPrintNumero(DS1307_Segundo);
	BANKSEL	_DS1307_Segundo
	MOVF	_DS1307_Segundo,W
	PAGESEL	_LCDPrintNumero
	CALL	_LCDPrintNumero
	PAGESEL	$
	RETURN	
; exit point of _timeShow

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __divuchar
;   _LCD_putChar
;   __moduchar
;   _LCD_putChar
;   __divuchar
;   _LCD_putChar
;   __moduchar
;   _LCD_putChar
;3 compiler assigned registers:
;   r0x1014
;   STK00
;   r0x1015
;; Starting pCode block
S_main__LCDPrintNumero	code
_LCDPrintNumero:
; 2 exit points
;	.line	555; "main.c"	void LCDPrintNumero(uint8_t numero)
	BANKSEL	r0x1014
	MOVWF	r0x1014
;	.line	557; "main.c"	LCD_putChar((numero/10)+48);   // Imprime dígito decena.
	MOVLW	0x0a
	MOVWF	STK00
	MOVF	r0x1014,W
	PAGESEL	__divuchar
	CALL	__divuchar
	PAGESEL	$
	BANKSEL	r0x1015
	MOVWF	r0x1015
	MOVLW	0x30
	ADDWF	r0x1015,F
	MOVF	r0x1015,W
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	558; "main.c"	LCD_putChar((numero%10)+48);   // Imprime dígito unidad.
	MOVLW	0x0a
	MOVWF	STK00
	BANKSEL	r0x1014
	MOVF	r0x1014,W
	PAGESEL	__moduchar
	CALL	__moduchar
	PAGESEL	$
	BANKSEL	r0x1015
	MOVWF	r0x1015
	MOVLW	0x30
	ADDWF	r0x1015,W
	MOVWF	r0x1014
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
	RETURN	
; exit point of _LCDPrintNumero

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _bisiesto
;   _bisiesto
;1 compiler assigned register :
;   r0x100A
;; Starting pCode block
S_main__diasDelMes	code
_diasDelMes:
; 2 exit points
;	.line	537; "main.c"	if(DS1307_Mes==2)                 // Mes = febrero
	BANKSEL	_DS1307_Mes
	MOVF	_DS1307_Mes,W
	XORLW	0x02
	BTFSS	STATUS,2
	GOTO	_00218_DS_
;	.line	539; "main.c"	return bisiesto() ? 29 : 28;  // Bisiesto: 29 días / No bisiesto: 28 días.
	PAGESEL	_bisiesto
	CALL	_bisiesto
	PAGESEL	$
	BANKSEL	r0x100A
	MOVWF	r0x100A
	MOVF	r0x100A,W
	BTFSC	STATUS,2
	GOTO	_00226_DS_
	MOVLW	0x1d
	MOVWF	r0x100A
	GOTO	_00227_DS_
_00226_DS_:
	MOVLW	0x1c
	BANKSEL	r0x100A
	MOVWF	r0x100A
_00227_DS_:
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	GOTO	_00224_DS_
_00218_DS_:
;	.line	541; "main.c"	if((DS1307_Mes==4) || (DS1307_Mes==6) || (DS1307_Mes==9) || (DS1307_Mes==11))
	BANKSEL	_DS1307_Mes
	MOVF	_DS1307_Mes,W
	XORLW	0x04
	BTFSC	STATUS,2
	GOTO	_00219_DS_
	MOVF	_DS1307_Mes,W
	XORLW	0x06
	BTFSC	STATUS,2
	GOTO	_00219_DS_
	MOVF	_DS1307_Mes,W
	XORLW	0x09
	BTFSC	STATUS,2
	GOTO	_00219_DS_
	MOVF	_DS1307_Mes,W
	XORLW	0x0b
	BTFSS	STATUS,2
	GOTO	_00220_DS_
_00219_DS_:
;	.line	543; "main.c"	return 30;                    // Meses de 30 días.
	MOVLW	0x1e
	GOTO	_00224_DS_
_00220_DS_:
;	.line	545; "main.c"	return 31;                        // Meses de 31 días.
	MOVLW	0x1f
_00224_DS_:
	RETURN	
; exit point of _diasDelMes

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;2 compiler assigned registers:
;   r0x1008
;   r0x1009
;; Starting pCode block
S_main__bisiesto	code
_bisiesto:
; 2 exit points
;	.line	525; "main.c"	return !(DS1307_Ano%4);
	MOVLW	0x03
	BANKSEL	_DS1307_Ano
	ANDWF	_DS1307_Ano,W
	BANKSEL	r0x1008
	MOVWF	r0x1008
	MOVF	r0x1008,W
	MOVLW	0x00
	BTFSC	STATUS,2
	MOVLW	0x01
;;1	MOVWF	r0x1009
	RETURN	
; exit point of _bisiesto

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;   _LCD_print
;5 compiler assigned registers:
;   r0x1018
;   r0x1019
;   r0x101A
;   STK01
;   STK00
;; Starting pCode block
S_main__LCDPrintDiaSemana	code
_LCDPrintDiaSemana:
; 2 exit points
;;unsigned compare: left < lit(0x1=1), size=1
;	.line	480; "main.c"	switch (DS1307_DiaSemana)
	MOVLW	0x01
	BANKSEL	_DS1307_DiaSemana
	SUBWF	_DS1307_DiaSemana,W
	BTFSS	STATUS,0
	GOTO	_00198_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
;;swapping arguments (AOP_TYPEs 1/3)
;;unsigned compare: left >= lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	_DS1307_DiaSemana,W
	BTFSC	STATUS,0
	GOTO	_00198_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
	DECF	_DS1307_DiaSemana,W
	BANKSEL	r0x1018
	MOVWF	r0x1018
	MOVLW	HIGH(_00208_DS_)
	BANKSEL	PCLATH
	MOVWF	PCLATH
	MOVLW	_00208_DS_
	BANKSEL	r0x1018
	ADDWF	r0x1018,W
	BTFSS	STATUS,0
	GOTO	_00001_DS_
	BANKSEL	PCLATH
	INCF	PCLATH,F
_00001_DS_:
	MOVWF	PCL
_00208_DS_:
	GOTO	_00190_DS_
	GOTO	_00191_DS_
	GOTO	_00192_DS_
	GOTO	_00193_DS_
	GOTO	_00194_DS_
	GOTO	_00195_DS_
	GOTO	_00196_DS_
_00190_DS_:
;	.line	483; "main.c"	LCD_print("DOM");
	MOVLW	high (___str_0 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_0 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	484; "main.c"	break;
	GOTO	_00198_DS_
_00191_DS_:
;	.line	486; "main.c"	LCD_print("LUN");
	MOVLW	high (___str_1 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_1 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	487; "main.c"	break;
	GOTO	_00198_DS_
_00192_DS_:
;	.line	489; "main.c"	LCD_print("MAR");
	MOVLW	high (___str_2 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_2 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	490; "main.c"	break;
	GOTO	_00198_DS_
_00193_DS_:
;	.line	492; "main.c"	LCD_print("MIE");
	MOVLW	high (___str_3 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_3 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	493; "main.c"	break;
	GOTO	_00198_DS_
_00194_DS_:
;	.line	495; "main.c"	LCD_print("JUE");
	MOVLW	high (___str_4 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_4 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	496; "main.c"	break;
	GOTO	_00198_DS_
_00195_DS_:
;	.line	498; "main.c"	LCD_print("VIE");
	MOVLW	high (___str_5 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_5 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
;	.line	499; "main.c"	break;
	GOTO	_00198_DS_
_00196_DS_:
;	.line	501; "main.c"	LCD_print("SAB");
	MOVLW	high (___str_6 + 0)
	BANKSEL	r0x1019
	MOVWF	r0x1019
	MOVLW	(___str_6 + 0)
	MOVWF	r0x1018
	MOVLW	0x80
	MOVWF	r0x101A
	MOVF	r0x1018,W
	MOVWF	STK01
	MOVF	r0x1019,W
	MOVWF	STK00
	MOVF	r0x101A,W
	PAGESEL	_LCD_print
	CALL	_LCD_print
	PAGESEL	$
_00198_DS_:
;	.line	503; "main.c"	}
	RETURN	
; exit point of _LCDPrintDiaSemana

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _I2C_stop
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _decimalToBCD
;   _I2C_writeByte
;   _I2C_stop
;1 compiler assigned register :
;   r0x100C
;; Starting pCode block
S_main__DS1307_timeWrite	code
_DS1307_timeWrite:
; 2 exit points
;	.line	457; "main.c"	I2C_start();          // Inicia comunicación I2C
	PAGESEL	_I2C_start
	CALL	_I2C_start
	PAGESEL	$
;	.line	458; "main.c"	I2C_writeByte(0xD0);  // Dirección I2C del DS1307.
	MOVLW	0xd0
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	459; "main.c"	I2C_writeByte(0x00);  // Primera dirección a leer/escribir.
	MOVLW	0x00
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	460; "main.c"	I2C_writeByte(0);     // Siempre que se ajusta la fecha y hora los Segundos=0.
	MOVLW	0x00
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	461; "main.c"	I2C_writeByte(decimalToBCD(DS1307_Minuto));
	BANKSEL	_DS1307_Minuto
	MOVF	_DS1307_Minuto,W
	PAGESEL	_decimalToBCD
	CALL	_decimalToBCD
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	462; "main.c"	I2C_writeByte(decimalToBCD(DS1307_Hora));
	BANKSEL	_DS1307_Hora
	MOVF	_DS1307_Hora,W
	PAGESEL	_decimalToBCD
	CALL	_decimalToBCD
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	463; "main.c"	I2C_writeByte(DS1307_DiaSemana);  // Valor 1...7 (igual en decimal que en BCD)
	BANKSEL	_DS1307_DiaSemana
	MOVF	_DS1307_DiaSemana,W
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	464; "main.c"	I2C_writeByte(decimalToBCD(DS1307_Dia));
	BANKSEL	_DS1307_Dia
	MOVF	_DS1307_Dia,W
	PAGESEL	_decimalToBCD
	CALL	_decimalToBCD
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	465; "main.c"	I2C_writeByte(decimalToBCD(DS1307_Mes));
	BANKSEL	_DS1307_Mes
	MOVF	_DS1307_Mes,W
	PAGESEL	_decimalToBCD
	CALL	_decimalToBCD
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	466; "main.c"	I2C_writeByte(decimalToBCD(DS1307_Ano));
	BANKSEL	_DS1307_Ano
	MOVF	_DS1307_Ano,W
	PAGESEL	_decimalToBCD
	CALL	_decimalToBCD
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	467; "main.c"	I2C_stop();
	PAGESEL	_I2C_stop
	CALL	_I2C_stop
	PAGESEL	$
	RETURN	
; exit point of _DS1307_timeWrite

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_start
;   _I2C_writeByte
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_stop
;   _I2C_start
;   _I2C_writeByte
;   _I2C_writeByte
;   _I2C_start
;   _I2C_writeByte
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_readByte
;   _BCDToDecimal
;   _I2C_stop
;1 compiler assigned register :
;   r0x100C
;; Starting pCode block
S_main__DS1307_timeRead	code
_DS1307_timeRead:
; 2 exit points
;	.line	433; "main.c"	I2C_start();          // Inicia comunicación I2C.
	PAGESEL	_I2C_start
	CALL	_I2C_start
	PAGESEL	$
;	.line	434; "main.c"	I2C_writeByte(0xD0);  // Dirección I2C del DS1307.
	MOVLW	0xd0
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	435; "main.c"	I2C_writeByte(0x00);  // Primera dirección a leer/escribir.
	MOVLW	0x00
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	436; "main.c"	I2C_start();          // Reinicia comunicación I2C.
	PAGESEL	_I2C_start
	CALL	_I2C_start
	PAGESEL	$
;	.line	437; "main.c"	I2C_writeByte(0xD1);  // DS1307 en Modo Escritura.
	MOVLW	0xd1
	PAGESEL	_I2C_writeByte
	CALL	_I2C_writeByte
	PAGESEL	$
;	.line	438; "main.c"	DS1307_Segundo   = BCDToDecimal(I2C_readByte(true)); // ASK = 1
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Segundo
	MOVWF	_DS1307_Segundo
;	.line	439; "main.c"	DS1307_Minuto    = BCDToDecimal(I2C_readByte(true));
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Minuto
	MOVWF	_DS1307_Minuto
;	.line	440; "main.c"	DS1307_Hora      = BCDToDecimal(I2C_readByte(true));
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Hora
	MOVWF	_DS1307_Hora
;	.line	441; "main.c"	DS1307_DiaSemana = I2C_readByte(true);  // Valor 1...7 (igual en decimal que en BCD)
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	_DS1307_DiaSemana
	MOVWF	_DS1307_DiaSemana
;	.line	442; "main.c"	DS1307_Dia       = BCDToDecimal(I2C_readByte(true));
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Dia
	MOVWF	_DS1307_Dia
;	.line	443; "main.c"	DS1307_Mes       = BCDToDecimal(I2C_readByte(true));
	MOVLW	0x01
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Mes
	MOVWF	_DS1307_Mes
;	.line	444; "main.c"	DS1307_Ano       = BCDToDecimal(I2C_readByte(false)); // ASK = 0
	MOVLW	0x00
	PAGESEL	_I2C_readByte
	CALL	_I2C_readByte
	PAGESEL	$
	BANKSEL	r0x100C
	MOVWF	r0x100C
	PAGESEL	_BCDToDecimal
	CALL	_BCDToDecimal
	PAGESEL	$
	BANKSEL	_DS1307_Ano
	MOVWF	_DS1307_Ano
;	.line	446; "main.c"	I2C_stop();
	PAGESEL	_I2C_stop
	CALL	_I2C_stop
	PAGESEL	$
	RETURN	
; exit point of _DS1307_timeRead

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __divuchar
;   __moduchar
;   __divuchar
;   __moduchar
;4 compiler assigned registers:
;   r0x1008
;   STK00
;   r0x1009
;   r0x100A
;; Starting pCode block
S_main__decimalToBCD	code
_decimalToBCD:
; 2 exit points
;	.line	416; "main.c"	uint8_t decimalToBCD (uint8_t decimalByte)
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	419; "main.c"	a=((decimalByte / 10) << 4);
	MOVLW	0x0a
	MOVWF	STK00
	MOVF	r0x1008,W
	PAGESEL	__divuchar
	CALL	__divuchar
	PAGESEL	$
	BANKSEL	r0x1009
	MOVWF	r0x1009
	SWAPF	r0x1009,W
	ANDLW	0xf0
	MOVWF	r0x100A
;	.line	420; "main.c"	b= (decimalByte % 10);
	MOVLW	0x0a
	MOVWF	STK00
	MOVF	r0x1008,W
	PAGESEL	__moduchar
	CALL	__moduchar
	PAGESEL	$
;	.line	421; "main.c"	bcd=a|b;
	BANKSEL	r0x1009
	MOVWF	r0x1009
	IORWF	r0x100A,W
;	.line	422; "main.c"	return bcd;
	MOVWF	r0x1008
	RETURN	
; exit point of _decimalToBCD

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __mulchar
;   __mulchar
;4 compiler assigned registers:
;   r0x1008
;   r0x1009
;   r0x100A
;   STK00
;; Starting pCode block
S_main__BCDToDecimal	code
_BCDToDecimal:
; 2 exit points
;	.line	400; "main.c"	uint8_t BCDToDecimal(uint8_t bcdByte)
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	403; "main.c"	a=(((bcdByte & 0xF0) >> 4) * 10);
	MOVLW	0xf0
	ANDWF	r0x1008,W
	MOVWF	r0x1009
	SWAPF	r0x1009,W
	ANDLW	0x0f
	MOVWF	r0x100A
	MOVLW	0x0a
	MOVWF	STK00
	MOVF	r0x100A,W
	PAGESEL	__mulchar
	CALL	__mulchar
	PAGESEL	$
	BANKSEL	r0x1009
	MOVWF	r0x1009
;	.line	404; "main.c"	b=(bcdByte & 0x0F);
	MOVLW	0x0f
	ANDWF	r0x1008,F
;	.line	405; "main.c"	dec=a+b;
	MOVF	r0x1008,W
	ADDWF	r0x1009,F
;	.line	406; "main.c"	return dec;
	MOVF	r0x1009,W
	RETURN	
; exit point of _BCDToDecimal

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;3 compiler assigned registers:
;   r0x1008
;   r0x1009
;   r0x100A
;; Starting pCode block
S_main__I2C_readByte	code
_I2C_readByte:
; 2 exit points
;	.line	372; "main.c"	uint8_t I2C_readByte(bool ACKBit)   // Receive data from I2C
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	375; "main.c"	uint8_t dato=0;
	CLRF	r0x1009
;	.line	377; "main.c"	SDA_INPUT;
	BANKSEL	_TRISBbits
	BSF	_TRISBbits,0
;	.line	378; "main.c"	for(i=0; i<8; i++)
	BANKSEL	r0x100A
	CLRF	r0x100A
_00169_DS_:
;	.line	380; "main.c"	SCL_HIGH;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,1
;	.line	381; "main.c"	dato<<=1;
	BCF	STATUS,0
;	.line	382; "main.c"	if(SDA) dato|=1;
	BANKSEL	r0x1009
	RLF	r0x1009,F
;	.line	383; "main.c"	SCL_LOW;
	BANKSEL	_PORTBbits
	BTFSS	_PORTBbits,0
	GOTO	_00002_DS_
	BANKSEL	r0x1009
	BSF	r0x1009,0
_00002_DS_:
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,1
;	.line	378; "main.c"	for(i=0; i<8; i++)
	BANKSEL	r0x100A
	INCF	r0x100A,F
;;unsigned compare: left < lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	r0x100A,W
	BTFSS	STATUS,0
	GOTO	_00169_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
;	.line	386; "main.c"	SDA_OUTPUT;
	BANKSEL	_TRISBbits
	BCF	_TRISBbits,0
;	.line	387; "main.c"	SDA = !ACKBit;
	BANKSEL	r0x1008
	MOVF	r0x1008,W
	MOVLW	0x00
	BTFSC	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100A
	MOVWF	r0x1008
	RRF	r0x1008,W
	BTFSC	STATUS,0
	GOTO	_00003_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
_00003_DS_:
	BTFSS	STATUS,0
	GOTO	_00004_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,0
_00004_DS_:
;	.line	388; "main.c"	SCL_HIGH;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,1
;	.line	389; "main.c"	SCL_LOW;
	BCF	_PORTBbits,1
;	.line	390; "main.c"	return dato;
	BANKSEL	r0x1009
	MOVF	r0x1009,W
	RETURN	
; exit point of _I2C_readByte

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;4 compiler assigned registers:
;   r0x1008
;   r0x1009
;   r0x100A
;   r0x100B
;; Starting pCode block
S_main__I2C_writeByte	code
_I2C_writeByte:
; 2 exit points
;	.line	351; "main.c"	bool I2C_writeByte(uint8_t dato)     // Send data to I2C
	BANKSEL	r0x1008
	MOVWF	r0x1008
;	.line	356; "main.c"	for(i=0; i<8; i++)
	CLRF	r0x1009
_00161_DS_:
;	.line	358; "main.c"	SDA = (dato & 0x80);    // SDA = bit de más peso del valor dato.
	BANKSEL	r0x1008
	MOVF	r0x1008,W
	ANDLW	0x80
	BTFSS	STATUS,2
	MOVLW	0x01
;;1	MOVWF	r0x100A
	MOVWF	r0x100B
	RRF	r0x100B,W
	BTFSC	STATUS,0
	GOTO	_00005_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
_00005_DS_:
	BTFSS	STATUS,0
	GOTO	_00006_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,0
_00006_DS_:
;	.line	359; "main.c"	SCL_HIGH;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,1
;	.line	360; "main.c"	dato<<=1;
	BCF	STATUS,0
	BANKSEL	r0x1008
	RLF	r0x1008,F
;	.line	361; "main.c"	SCL_LOW;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,1
;	.line	356; "main.c"	for(i=0; i<8; i++)
	BANKSEL	r0x1009
	INCF	r0x1009,F
;;unsigned compare: left < lit(0x8=8), size=1
	MOVLW	0x08
	SUBWF	r0x1009,W
	BTFSS	STATUS,0
	GOTO	_00161_DS_
;;genSkipc:3257: created from rifx:00000000047658D0
;	.line	364; "main.c"	SDA_INPUT;
	BANKSEL	_TRISBbits
	BSF	_TRISBbits,0
;	.line	365; "main.c"	SCL_HIGH;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,1
;	.line	366; "main.c"	ACKbit = SDA;
	BANKSEL	r0x1008
	CLRF	r0x1008
	BANKSEL	_PORTBbits
	BTFSS	_PORTBbits,0
	GOTO	_00007_DS_
	BANKSEL	r0x1008
	INCF	r0x1008,F
_00007_DS_:
	BANKSEL	r0x1008
	MOVF	r0x1008,W
	BTFSC	STATUS,2
	MOVLW	0x01
	MOVWF	r0x1009
;	.line	367; "main.c"	SCL_LOW;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,1
;	.line	368; "main.c"	SDA_OUTPUT;
	BANKSEL	_TRISBbits
	BCF	_TRISBbits,0
;	.line	369; "main.c"	SDA_LOW;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
;	.line	370; "main.c"	return ACKbit;
	BANKSEL	r0x1009
	MOVF	r0x1009,W
	RETURN	
; exit point of _I2C_writeByte

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_main__I2C_stop	code
_I2C_stop:
; 2 exit points
;	.line	347; "main.c"	SDA_LOW;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
;	.line	348; "main.c"	SCL_HIGH;            // STOP function for communicate I2C
	BSF	_PORTBbits,1
;	.line	349; "main.c"	SDA_HIGH;
	BSF	_PORTBbits,0
	RETURN	
; exit point of _I2C_stop

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;; Starting pCode block
S_main__I2C_start	code
_I2C_start:
; 2 exit points
;	.line	338; "main.c"	SDA_HIGH;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,0
;	.line	339; "main.c"	SCL_HIGH;
	BSF	_PORTBbits,1
;	.line	340; "main.c"	SCL_OUTPUT;    // Configura pines I2C como Salidas.
	BANKSEL	_TRISBbits
	BCF	_TRISBbits,1
;	.line	341; "main.c"	SDA_OUTPUT;
	BCF	_TRISBbits,0
;	.line	342; "main.c"	SDA_LOW;             // START function for communicate I2C
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,0
;	.line	343; "main.c"	SCL_LOW;
	BCF	_PORTBbits,1
	RETURN	
; exit point of _I2C_start

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;   _LCD_send4Bits
;   _delay_ms
;   _LCD_send4Bits
;   _delay_ms
;   _LCD_send4Bits
;   _LCD_send4Bits
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _delay_ms
;   _delay_ms
;   _LCD_send4Bits
;   _delay_ms
;   _LCD_send4Bits
;   _delay_ms
;   _LCD_send4Bits
;   _LCD_send4Bits
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _LCD_command
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_main__LCD_init	code
_LCD_init:
; 2 exit points
;	.line	301; "main.c"	LCD_DATA_4_DIR = OUTPUT_PIN;   // Pines iniciados como Salidas.
	BANKSEL	_TRISBbits
	BCF	_TRISBbits,4
;	.line	302; "main.c"	LCD_DATA_5_DIR = OUTPUT_PIN;
	BCF	_TRISBbits,5
;	.line	303; "main.c"	LCD_DATA_6_DIR = OUTPUT_PIN;
	BCF	_TRISBbits,6
;	.line	304; "main.c"	LCD_DATA_7_DIR = OUTPUT_PIN;
	BCF	_TRISBbits,7
;	.line	305; "main.c"	LCD_RS_DIR     = OUTPUT_PIN;
	BCF	_TRISBbits,2
;	.line	306; "main.c"	LCD_EN_DIR     = OUTPUT_PIN;
	BCF	_TRISBbits,3
;	.line	308; "main.c"	delay_ms(200);   // Espera para asegurar tensión estable tras inicio.
	MOVLW	0xc8
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	309; "main.c"	LCD_RS = LOW_ST;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,2
;	.line	310; "main.c"	LCD_EN = LOW_ST;
	BCF	_PORTBbits,3
;	.line	315; "main.c"	delay_ms(30);    // Espera >= 15 ms
	MOVLW	0x1e
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	317; "main.c"	LCD_send4Bits(0b00110000);
	MOVLW	0x30
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
;	.line	318; "main.c"	delay_ms(5);    // Espera >= 4.1 ms
	MOVLW	0x05
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	319; "main.c"	LCD_send4Bits(0b00110000);
	MOVLW	0x30
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
;	.line	320; "main.c"	delay_ms(1);    // Espera >= 100 us
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	321; "main.c"	LCD_send4Bits(0b00110000);
	MOVLW	0x30
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
;	.line	322; "main.c"	LCD_send4Bits(0b00100000);
	MOVLW	0x20
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
;	.line	323; "main.c"	LCD_command(LCD_CMD_FUNCTION_SET + LCD_CMD_4BIT_INTERFACE + LCD_CMD_2LINES + LCD_CMD_F_FONT_5_8);
	MOVLW	0x28
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;	.line	327; "main.c"	LCD_OFF;
	MOVLW	0x08
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;	.line	328; "main.c"	LCD_command(LCD_CMD_CHARACTER_ENTRY_MODE + LCD_CMD_INCREMENT + LCD_CMD_DISPLAY_SHIFT_OFF);
	MOVLW	0x06
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;	.line	329; "main.c"	LCD_ON;
	MOVLW	0x0c
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
;	.line	330; "main.c"	LCD_CLEAR;
	MOVLW	0x01
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
	RETURN	
; exit point of _LCD_init

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   __gptrget1
;   _LCD_putChar
;   __gptrget1
;   _LCD_putChar
;6 compiler assigned registers:
;   r0x1014
;   STK00
;   r0x1015
;   STK01
;   r0x1016
;   r0x1017
;; Starting pCode block
S_main__LCD_print	code
_LCD_print:
; 2 exit points
;	.line	291; "main.c"	void LCD_print(uint8_t *str)
	BANKSEL	r0x1014
	MOVWF	r0x1014
	MOVF	STK00,W
	MOVWF	r0x1015
	MOVF	STK01,W
	MOVWF	r0x1016
_00140_DS_:
;	.line	293; "main.c"	while(*str)
	BANKSEL	r0x1016
	MOVF	r0x1016,W
	MOVWF	STK01
	MOVF	r0x1015,W
	MOVWF	STK00
	MOVF	r0x1014,W
	PAGESEL	__gptrget1
	CALL	__gptrget1
	PAGESEL	$
	BANKSEL	r0x1017
	MOVWF	r0x1017
	MOVF	r0x1017,W
	BTFSC	STATUS,2
	GOTO	_00143_DS_
;	.line	295; "main.c"	LCD_putChar(*str);
	MOVF	r0x1017,W
	PAGESEL	_LCD_putChar
	CALL	_LCD_putChar
	PAGESEL	$
;	.line	296; "main.c"	str++;
	BANKSEL	r0x1016
	INCF	r0x1016,F
	BTFSC	STATUS,2
	INCF	r0x1015,F
	BTFSC	STATUS,2
	INCF	r0x1014,F
	GOTO	_00140_DS_
_00143_DS_:
	RETURN	
; exit point of _LCD_print

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_command
;   _LCD_command
;   _LCD_command
;   _LCD_command
;3 compiler assigned registers:
;   r0x1014
;   STK00
;   r0x1015
;; Starting pCode block
S_main__LCD_gotoXY	code
_LCD_gotoXY:
; 2 exit points
;	.line	284; "main.c"	void LCD_gotoXY(uint8_t columna, uint8_t fila)
	BANKSEL	r0x1014
	MOVWF	r0x1014
	MOVF	STK00,W
	MOVWF	r0x1015
;	.line	286; "main.c"	if(fila == 0)
	MOVF	r0x1015,W
	BTFSS	STATUS,2
	GOTO	_00133_DS_
;	.line	287; "main.c"	LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_0);
	MOVLW	0x80
	ADDWF	r0x1014,W
	MOVWF	r0x1015
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
	GOTO	_00135_DS_
_00133_DS_:
;	.line	289; "main.c"	LCD_command(LCD_CMD_SET_DISPLAY_ADDRESS + columna + LCD_CMD_ROW_1);
	MOVLW	0xc0
	BANKSEL	r0x1014
	ADDWF	r0x1014,F
	MOVF	r0x1014,W
	PAGESEL	_LCD_command
	CALL	_LCD_command
	PAGESEL	$
_00135_DS_:
	RETURN	
; exit point of _LCD_gotoXY

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_send
;   _LCD_send
;1 compiler assigned register :
;   r0x1013
;; Starting pCode block
S_main__LCD_putChar	code
_LCD_putChar:
; 2 exit points
;	.line	279; "main.c"	void LCD_putChar(uint8_t chr)
	BANKSEL	r0x1013
	MOVWF	r0x1013
;	.line	281; "main.c"	LCD_RS = LCD_CharMode;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,2
;	.line	282; "main.c"	LCD_send(chr);
	BANKSEL	r0x1013
	MOVF	r0x1013,W
	PAGESEL	_LCD_send
	CALL	_LCD_send
	PAGESEL	$
	RETURN	
; exit point of _LCD_putChar

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_send
;   _LCD_send
;1 compiler assigned register :
;   r0x1013
;; Starting pCode block
S_main__LCD_command	code
_LCD_command:
; 2 exit points
;	.line	274; "main.c"	void LCD_command(uint8_t comm)
	BANKSEL	r0x1013
	MOVWF	r0x1013
;	.line	276; "main.c"	LCD_RS = LCD_CmdMode;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,2
;	.line	277; "main.c"	LCD_send(comm);
	BANKSEL	r0x1013
	MOVF	r0x1013,W
	PAGESEL	_LCD_send
	CALL	_LCD_send
	PAGESEL	$
	RETURN	
; exit point of _LCD_command

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _LCD_send4Bits
;   _LCD_send4Bits
;   _LCD_send4Bits
;   _LCD_send4Bits
;2 compiler assigned registers:
;   r0x1011
;   r0x1012
;; Starting pCode block
S_main__LCD_send	code
_LCD_send:
; 2 exit points
;	.line	269; "main.c"	void LCD_send(uint8_t date)
	BANKSEL	r0x1011
	MOVWF	r0x1011
;	.line	271; "main.c"	LCD_send4Bits(date);
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
;	.line	272; "main.c"	LCD_send4Bits(date<<4);
	BANKSEL	r0x1011
	SWAPF	r0x1011,W
	ANDLW	0xf0
;;1	MOVWF	r0x1012
	PAGESEL	_LCD_send4Bits
	CALL	_LCD_send4Bits
	PAGESEL	$
	RETURN	
; exit point of _LCD_send

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;4 compiler assigned registers:
;   r0x100E
;   r0x100F
;   r0x1010
;   STK00
;; Starting pCode block
S_main__LCD_send4Bits	code
_LCD_send4Bits:
; 2 exit points
;	.line	258; "main.c"	void LCD_send4Bits(uint8_t date)
	BANKSEL	r0x100E
	MOVWF	r0x100E
;	.line	260; "main.c"	LCD_DATA_4 = (date & 0x10);
	ANDLW	0x10
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100F
	MOVWF	r0x1010
	RRF	r0x1010,W
	BTFSC	STATUS,0
	GOTO	_00008_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,4
_00008_DS_:
	BTFSS	STATUS,0
	GOTO	_00009_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,4
_00009_DS_:
;	.line	261; "main.c"	LCD_DATA_5 = (date & 0x20);
	BANKSEL	r0x100E
	MOVF	r0x100E,W
	ANDLW	0x20
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100F
	MOVWF	r0x1010
	RRF	r0x1010,W
	BTFSC	STATUS,0
	GOTO	_00010_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,5
_00010_DS_:
	BTFSS	STATUS,0
	GOTO	_00011_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,5
_00011_DS_:
;	.line	262; "main.c"	LCD_DATA_6 = (date & 0x40);
	BANKSEL	r0x100E
	MOVF	r0x100E,W
	ANDLW	0x40
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100F
	MOVWF	r0x1010
	RRF	r0x1010,W
	BTFSC	STATUS,0
	GOTO	_00012_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,6
_00012_DS_:
	BTFSS	STATUS,0
	GOTO	_00013_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,6
_00013_DS_:
;	.line	263; "main.c"	LCD_DATA_7 = (date & 0x80);
	BANKSEL	r0x100E
	MOVF	r0x100E,W
	ANDLW	0x80
	BTFSS	STATUS,2
	MOVLW	0x01
	MOVWF	r0x100F
	MOVWF	r0x100E
	RRF	r0x100E,W
	BTFSC	STATUS,0
	GOTO	_00014_DS_
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,7
_00014_DS_:
	BTFSS	STATUS,0
	GOTO	_00015_DS_
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,7
_00015_DS_:
;	.line	264; "main.c"	LCD_EN     = HIGH_ST;
	BANKSEL	_PORTBbits
	BSF	_PORTBbits,3
;	.line	265; "main.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	266; "main.c"	LCD_EN     = LOW_ST;
	BANKSEL	_PORTBbits
	BCF	_PORTBbits,3
;	.line	267; "main.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	RETURN	
; exit point of _LCD_send4Bits

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;7 compiler assigned registers:
;   r0x1008
;   STK00
;   r0x1009
;   r0x100A
;   r0x100B
;   r0x100C
;   r0x100D
;; Starting pCode block
S_main__delay_ms	code
_delay_ms:
; 2 exit points
;	.line	238; "main.c"	void delay_ms(uint16_t ms)
	BANKSEL	r0x1008
	MOVWF	r0x1008
	MOVF	STK00,W
	MOVWF	r0x1009
_00108_DS_:
;	.line	248; "main.c"	while(ms--)
	BANKSEL	r0x1009
	MOVF	r0x1009,W
	MOVWF	r0x100A
	MOVF	r0x1008,W
	MOVWF	r0x100B
	MOVLW	0xff
	ADDWF	r0x1009,F
	BTFSS	STATUS,0
	DECF	r0x1008,F
	MOVF	r0x100A,W
	IORWF	r0x100B,W
	BTFSC	STATUS,2
	GOTO	_00111_DS_
;	.line	251; "main.c"	while(aux--);
	MOVLW	0x3d
	MOVWF	r0x100A
	CLRF	r0x100B
_00105_DS_:
	BANKSEL	r0x100A
	MOVF	r0x100A,W
	MOVWF	r0x100C
	MOVF	r0x100B,W
	MOVWF	r0x100D
	MOVLW	0xff
	ADDWF	r0x100A,F
	BTFSS	STATUS,0
	DECF	r0x100B,F
	MOVF	r0x100C,W
	IORWF	r0x100D,W
	BTFSC	STATUS,2
	GOTO	_00108_DS_
	GOTO	_00105_DS_
_00111_DS_:
	RETURN	
; exit point of _delay_ms


;	code size estimation:
;	  965+  427 =  1392 instructions ( 3638 byte)

	end
