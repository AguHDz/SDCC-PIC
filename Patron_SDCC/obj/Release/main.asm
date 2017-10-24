;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"main.c"
	list	p=16f84a
	radix dec
	include "p16f84a.inc"
;--------------------------------------------------------
; external declarations
;--------------------------------------------------------
	extern	_STATUSbits
	extern	_PORTAbits
	extern	_PORTBbits
	extern	_INTCONbits
	extern	_OPTION_REGbits
	extern	_TRISAbits
	extern	_TRISBbits
	extern	_EECON1bits
	extern	_INDF
	extern	_TMR0
	extern	_PCL
	extern	_STATUS
	extern	_FSR
	extern	_PORTA
	extern	_PORTB
	extern	_EEDATA
	extern	_EEADR
	extern	_PCLATH
	extern	_INTCON
	extern	_OPTION_REG
	extern	_TRISA
	extern	_TRISB
	extern	_EECON1
	extern	_EECON2
	extern	__sdcc_gsinit_startup
;--------------------------------------------------------
; global declarations
;--------------------------------------------------------
	global	_izquierda
	global	_derecha
	global	_delay_ms
	global	_main

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

sharebank udata_ovr 0x000C
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
;--------------------------------------------------------
; absolute symbol definitions
;--------------------------------------------------------
;--------------------------------------------------------
; compiler-defined variables
;--------------------------------------------------------
UDL_main_0	udata
r0x1001	res	1
r0x1000	res	1
r0x1002	res	1
r0x1003	res	1
;--------------------------------------------------------
; initialized data
;--------------------------------------------------------
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
;   _derecha
;   _izquierda
;   _derecha
;   _izquierda
;; Starting pCode block
S_main__main	code
_main:
; 2 exit points
;	.line	33; "main.c"	TRISA = 0xF0;                 //porta como salida menos RA4(desactivado)
	MOVLW	0xf0
	BANKSEL	_TRISA
	MOVWF	_TRISA
;	.line	34; "main.c"	GIE   = 0;                    //todas las interrupciones desactivadas
	BANKSEL	_INTCONbits
	BCF	_INTCONbits,7
_00106_DS_:
;	.line	37; "main.c"	derecha();
	PAGESEL	_derecha
	CALL	_derecha
	PAGESEL	$
;	.line	38; "main.c"	izquierda();
	PAGESEL	_izquierda
	CALL	_izquierda
	PAGESEL	$
	GOTO	_00106_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_main__izquierda	code
_izquierda:
; 2 exit points
;	.line	71; "main.c"	RA3 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,3
;	.line	72; "main.c"	RA2 = 1;
	BSF	_PORTAbits,2
;	.line	73; "main.c"	delay_ms(300);
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	74; "main.c"	RA2 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,2
;	.line	75; "main.c"	RA1 = 1;
	BSF	_PORTAbits,1
;	.line	76; "main.c"	delay_ms(300);
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	77; "main.c"	RA1 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,1
	RETURN	
; exit point of _izquierda

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;   _delay_ms
;1 compiler assigned register :
;   STK00
;; Starting pCode block
S_main__derecha	code
_derecha:
; 2 exit points
;	.line	56; "main.c"	RA0 = 1;
	BANKSEL	_PORTAbits
	BSF	_PORTAbits,0
;	.line	57; "main.c"	delay_ms(300);  // ~300ms @ 4MHz
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	58; "main.c"	RA0 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,0
;	.line	59; "main.c"	RA1 = 1;
	BSF	_PORTAbits,1
;	.line	60; "main.c"	delay_ms(300);
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	61; "main.c"	RA1 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,1
;	.line	62; "main.c"	RA2 = 1;
	BSF	_PORTAbits,2
;	.line	63; "main.c"	delay_ms(300);
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
;	.line	64; "main.c"	RA2 = 0;
	BANKSEL	_PORTAbits
	BCF	_PORTAbits,2
;	.line	65; "main.c"	RA3 = 1;
	BSF	_PORTAbits,3
;	.line	66; "main.c"	delay_ms(300);
	MOVLW	0x2c
	MOVWF	STK00
	MOVLW	0x01
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	RETURN	
; exit point of _derecha

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;5 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;; Starting pCode block
S_main__delay_ms	code
_delay_ms:
; 2 exit points
;	.line	43; "main.c"	void delay_ms(int ms)
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
_00114_DS_:
;	.line	47; "main.c"	while(ms--)
	MOVF	r0x1001,W
	MOVWF	r0x1002
	MOVF	r0x1000,W
	MOVWF	r0x1003
	MOVLW	0xff
	ADDWF	r0x1001,F
	BTFSS	STATUS,0
	DECF	r0x1000,F
	MOVF	r0x1002,W
	IORWF	r0x1003,W
	BTFSC	STATUS,2
	GOTO	_00117_DS_
;	.line	50; "main.c"	while(aux--);
	MOVLW	0x32
	MOVWF	r0x1002
_00111_DS_:
	MOVF	r0x1002,W
	MOVWF	r0x1003
	DECF	r0x1002,F
	MOVF	r0x1003,W
	BTFSC	STATUS,2
	GOTO	_00114_DS_
	GOTO	_00111_DS_
_00117_DS_:
	RETURN	
; exit point of _delay_ms


;	code size estimation:
;	   70+   25 =    95 instructions (  240 byte)

	end
