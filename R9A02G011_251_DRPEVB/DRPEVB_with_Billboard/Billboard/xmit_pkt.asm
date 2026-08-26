;---------------------------------------------------------------------
;	_xmit_pkt
;
;	void swusb_xmit_handshake_pkt(UCHAR pid);
;
;	input:
;		<A>	pid	: PID
;	output:
;		NONE
;	return:
;		NONE
;---------------------------------------------------------------------

;---------------------------------------------------------------------
;	_swusb_xmit_data_pkt
;
;	void swusb_xmit_data_pkt(const UCHAR *buf, UCHAR len);
;
;	input:
;		<AX>	buf	: Transmit data address after SYNC
;		<C>	len	: Transmission data length
;	output:
;		NONE
;	return:
;		NONE
;---------------------------------------------------------------------

$INCLUDE "swusb_pin_config.inc"

;TRANSLATE_BEGIN

BIT_DPLUS		.EQU	1 << BITPOS_DPLUS
BIT_DMINUS		.EQU	1 << BITPOS_DMINUS
BIT_USBMASK		.EQU	BIT_DPLUS | BIT_DMINUS
PORT_DPLUS		.EQU	USB_PORT_REG.BITPOS_DPLUS
PORT_DMINUS		.EQU	USB_PORT_REG.BITPOS_DMINUS

;TRANSLATE_END

	.EXTERN	xmit_buf

TOGGLE		.MACRO
	XOR	USB_PORT_REG, #BIT_USBMASK	;[T+0] 2 ; The output terminal changes at the 2nd clock
	.ENDM

NOT_TOGGLE	.MACRO
	.ENDM

NOP4		.MACRO
	NOP					;[T+0] 1
	NOP					;[T+1] 1
	NOP					;[T+2] 1
	NOP					;[T+3] 1
	.ENDM

NOP5		.MACRO
	NOP					;[T+0] 1
	NOP					;[T+1] 1
	NOP					;[T+2] 1
	NOP					;[T+3] 1
	NOP					;[T+4] 1
	.ENDM

NOP12		.MACRO
	NOP					;[T+0] 1
	NOP					;[T+1] 1
	NOP					;[T+2] 1
	NOP					;[T+3] 1
	NOP					;[T+4] 1
	NOP					;[T+5] 1
	NOP					;[T+6] 1
	NOP					;[T+7] 1
	NOP					;[T+8] 1
	NOP					;[T+9] 1
	NOP					;[T+10] 1
	NOP					;[T+11] 1
	.ENDM

	.PUBLIC	_swusb_xmit_handshake_pkt
	.PUBLIC	_swusb_xmit_data_pkt

;-----------------------------------------------
; Comment conventions 
;
;  ;[t] c <xxx> ;comment
;
; t = cumulative clock number
;     Write where you come back from another route.
;     Add * to toggle point.
; c = number of clocks for that instruction
;     Shaded lines indicate when condition is not met / established
; xxx = processing category
; comment = any comment description
;-----------------------------------------------

;-----------------------------------------------
	.SECTION .textf,TEXTF
;TRANSLATE_BEGIN
_swusb_xmit_data_pkt:
	MOVW	HL, AX				;buf
	MOV	A, C				;len
	INC	A
	MOV	B, A				;len
	BR	$xmit_common

_swusb_xmit_handshake_pkt:
	MOVW	HL, #LOWW(xmit_buf)
	MOV	[HL], A				;UCHAR pid
	MOV	B, #2				;xmit_len

xmit_common:
	;TRANSLATE_END
	; Currently the bus is Idle.
	; Change D +, D- to OUT and make it J output state.
	CLR1	PORT_DPLUS
	SET1	PORT_DMINUS
	MOV	A, USB_PM_REG
	AND	A, #(0xFF ^ BIT_USBMASK)
	MOV	USB_PM_REG, A			; Set the corresponding bit of the PM register to 0
	;TRANSLATE_BEGIN

	; S Å© 0x80 (SYNC pattern)
	MOV	!shift, #0x80
	BR	!entry


;-----------------------------------------------
; Å´ nochg routine
nochgb0:
	NOT_TOGGLE				;[129] 0
	DEC	C				;[129] 1 <bit stuff>
	BNZ	$chkb1				;[130] 2/4 <bit stuff>
	NOP12					;[132] 12
	BR	!startb0			;[140] 3

nochgb1:
	NOT_TOGGLE				;[13] 0
	DEC	C				;[13] 1 <bit stuff>
	BNZ	$chkb2				;[14] 2/4 <bit stuff>
	NOP12					;[16] 12
	BR	!startb1			;[28] 3

nochgb2:
	NOT_TOGGLE				;[29] 0
	DEC	C				;[29] 1 <bit stuff>
	BNZ	$chkb3				;[30] 2/4 <bit stuff>
	NOP12					;[32] 12
	BR	!startb2			;[44] 3

nochgb3:
	NOT_TOGGLE				;[45] 0
	DEC	C				;[45] 1 <bit stuff>
	BNZ	$chkb4				;[46] 2/4 <bit stuff>
	NOP12					;[48] 12
	BR	!startb3			;[60] 3
; Å™ nochg routine end
;-----------------------------------------------

chkb0:
	MOV	A, [HL]				;[119] 1 <load>
	MOV	!shift, A			;[120] 1 <load>
	INCW	HL				;[121] 1 <load>
	NOP					;[122] 1
	NOP					;[123] 1
	BT	A.0, $nochgb0			;[124] 3/5 <NRZI>

entry:
startb0:
	TOGGLE					;[-1][127][143]* 2 <NRZI>
	MOV	C, #6				;[1] 1 <bit stuff>
	NOP4					;[2][130] 4
chkb1:
	NOP					;[6][134] 1
	MOV	A, !shift			;[7][135] 1 <NRZI>
	BT	A.1, $nochgb1			;[8][136] 3/5 <NRZI>
	NOP4					;[11] 4
startb1:
	TOGGLE					;[15][31]* 2 <NRZI>
	MOV	C, #6				;[17][33] 1 <bit stuff>
chkb2:
	NOP5					;[18] 5
	MOV	A, !shift			;[23] 1 <NRZI>
	BT	A.2, $nochgb2			;[24] 3/5 <NRZI>
	NOP4					;[27] 4
startb2:
	TOGGLE					;[31][47]* 2 <NRZI>
	MOV	C, #6				;[33] 1 <bit stuff>
chkb3:
	NOP5					;[34] 5
	MOV	A, !shift			;[39] 1 <NRZI>
	BT	A.3, $nochgb3			;[40] 3/5 <NRZI>
	NOP4					;[43] 4
startb3:
	TOGGLE					;[47][63]* 2 <NRZI>
	MOV	C, #6				;[49] 1 <bit stuff>
chkb4:
	NOP5					;[50] 5
	MOV	A, !shift			;[55] 1 <NRZI>
	BT	A.4, $nochgb4			;[56] 3/5 <NRZI>
	NOP4					;[59] 4
startb4:
	TOGGLE					;[63][79]* 2 <NRZI>
	MOV	C, #6				;[65] 1 <bit stuff>
chkb5:
	NOP5					;[66] 5
	MOV	A, !shift			;[71] 1 <NRZI>
	BT	A.5, $nochgb5			;[72] 3/5 <NRZI>
	NOP4					;[75] 4
startb5:
	TOGGLE					;[79][95]* 2 <NRZI>
	MOV	C, #6				;[81] 1 <bit stuff>
chkb6:
	NOP5					;[82] 5
	MOV	A, !shift			;[87] 1 <NRZI>
	BT	A.6, $nochgb6			;[88] 3/5 <NRZI>
	NOP4					;[91] 4
startb6:
	TOGGLE					;[95][111]* 2 <NRZI>
	MOV	C, #6				;[97] 1 <bit stuff>
chkb7:
	NOP5					;[98] 5
	MOV	A, !shift			;[103] 1 <NRZI>
	BT	A.7, $nochgb7			;[104] 3/5 <NRZI>
	NOP4					;[107] 4
startb7:
	TOGGLE					;[111][127]* 2 <NRZI>
	MOV	C, #6				;[113] 1 <bit stuff>
chknext:
	; End of data?
	DEC	B				;[114] 1 <loop>
	SKZ					;[115] 1 <loop>
	BR	!chkb0				;[116] 1/3 <loop>
	BR	!eop				;[117] 3

;-----------------------------------------------
; Å´ nochg routine

nochgb4:
	NOT_TOGGLE				;[61] 0
	DEC	C				;[61] 1 <bit stuff>
	BNZ	$chkb5				;[62] 2/4 <bit stuff>
	NOP12					;[64] 12
	BR	!startb4			;[76] 3

nochgb5:
	NOT_TOGGLE				;[77] 0
	DEC	C				;[77] 1 <bit stuff>
	BNZ	$chkb6				;[78] 2/4 <bit stuff>
	NOP12					;[80] 12
	BR	!startb5			;[92] 3

nochgb6:
	NOT_TOGGLE				;[93] 0
	DEC	C				;[93] 1 <bit stuff>
	BNZ	$chkb7				;[94] 2/4 <bit stuff>
	NOP12					;[96] 12
	BR	!startb6			;[108] 3

nochgb7:
	NOT_TOGGLE				;[109] 0
	DEC	C				;[109] 1 <bit stuff>
	BNZ	$chknext			;[110] 2/4 <bit stuff>
	NOP12					;[112] 12
	BR	!startb7			;[124] 3

; Å™ nochg routine end
;-----------------------------------------------

eop:
	NOP					;[120] 1
	NOP					;[121] 1
	NOP					;[122] 1
	NOP					;[123] 1
	NOP					;[124] 1
	NOP					;[125] 1
;TRANSLATE_END

	;EOP output
	MOV	A, USB_PORT_REG			;[126] 1
	AND	A, #(0xFF ^ BIT_USBMASK)	;[127] 1
	MOV	USB_PORT_REG, A			;[128][T0]* 1

	; Wait for EOP width, 2 bit time (32 clk)
	MOV	A, #6				;[T0+1] 1
wait_eop:
	DEC	A				;[T0+2+5n] 1
	BNZ	$wait_eop			;[T0+3+5n] 2/4
	NOP					;[T0+5+5n=T0+30] 1

	;J output
	SET1	PORT_DMINUS			;[T0+31][T1-1]* 2 ; The output terminal changes at the 2nd clock

	;1bit time(16clk)ë“Ç¬
	MOV	A, #2				;[T1+1] 1
wait_last_j:
	DEC	A				;[T1+2+5n] 1
	BNZ	$wait_last_j			;[T1+3+5n] 2/4
	NOP					;[T1+5+5n=T1+10] 1
	NOP					;[T1+11] 1
	NOP					;[T1+12] 1
	NOP					;[T1+13] 1

	; Idle transition (switch to INPUT)
	MOV	A, USB_PM_REG			;[T1+14] 1
	OR	A, #BIT_USBMASK			;[T1+15] 1
	MOV	USB_PM_REG, A			;[T1+16] 1 ; Set corresponding bit of PM register to 1

;TRANSLATE_BEGIN
	RET
;TRANSLATE_END
