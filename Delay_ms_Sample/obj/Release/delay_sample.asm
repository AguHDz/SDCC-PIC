;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.6.0 #9615 (MINGW64)
;--------------------------------------------------------
; PIC port for the 14-bit core
;--------------------------------------------------------
;	.file	"delay_sample.c"
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
UDL_delay_sample_0	udata
r0x1001	res	1
r0x1000	res	1
r0x1002	res	1
r0x1003	res	1
r0x1004	res	1
r0x1005	res	1
r0x1006	res	1
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
code_delay_sample	code
;***
;  pBlock Stats: dbName = M
;***
;has an exit
;functions called:
;   _delay_ms
;   _delay_ms
;3 compiler assigned registers:
;   r0x1006
;   r0x1007
;   STK00
;; Starting pCode block
S_delay_sample__main	code
_main:
; 2 exit points
;	.line	11; "delay_sample.c"	TRISB = 0xF0;                 //porta como salida menos RA4(desactivado)
	MOVLW	0xf0
	BANKSEL	_TRISB
	MOVWF	_TRISB
;	.line	12; "delay_sample.c"	PORTB = 0x00;
	BANKSEL	_PORTB
	CLRF	_PORTB
;	.line	13; "delay_sample.c"	GIE   = 0;                    //todas las interrupciones desactivadas
	BCF	_INTCONbits,7
_00117_DS_:
;	.line	16; "delay_sample.c"	RB0 = !RB0;
	CLRF	r0x1006
	BANKSEL	_PORTBbits
	BTFSC	_PORTBbits,0
	INCF	r0x1006,F
	MOVF	r0x1006,W
	MOVLW	0x00
	BTFSC	STATUS,2
	MOVLW	0x01
;;1	MOVWF	r0x1007
	MOVWF	r0x1006
	RRF	r0x1006,W
	BTFSS	STATUS,0
	BCF	_PORTBbits,0
	BTFSC	STATUS,0
	BSF	_PORTBbits,0
;	.line	17; "delay_sample.c"	delay_ms(1);
	MOVLW	0x01
	MOVWF	STK00
	MOVLW	0x00
	PAGESEL	_delay_ms
	CALL	_delay_ms
	PAGESEL	$
	GOTO	_00117_DS_
	RETURN	
; exit point of _main

;***
;  pBlock Stats: dbName = C
;***
;has an exit
;7 compiler assigned registers:
;   r0x1000
;   STK00
;   r0x1001
;   r0x1002
;   r0x1003
;   r0x1004
;   r0x1005
;; Starting pCode block
S_delay_sample__delay_ms	code
_delay_ms:
; 2 exit points
;	.line	22; "../Libs/delay.c"	void delay_ms(unsigned int ms)
	MOVWF	r0x1000
	MOVF	STK00,W
	MOVWF	r0x1001
_00108_DS_:
;	.line	26; "../Libs/delay.c"	while(ms--)
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
	GOTO	_00111_DS_
;	.line	29; "../Libs/delay.c"	while(aux--);
	MOVLW	0x59
	MOVWF	r0x1002
	MOVLW	0x01
	MOVWF	r0x1003
_00105_DS_:
	MOVF	r0x1002,W
	MOVWF	r0x1004
	MOVF	r0x1003,W
	MOVWF	r0x1005
	MOVLW	0xff
	ADDWF	r0x1002,F
	BTFSS	STATUS,0
	DECF	r0x1003,F
	MOVF	r0x1004,W
	IORWF	r0x1005,W
	BTFSC	STATUS,2
	GOTO	_00108_DS_
	GOTO	_00105_DS_
_00111_DS_:
	RETURN	
; exit point of _delay_ms


;	code size estimation:
;	   56+    5 =    61 instructions (  132 byte)

	end
