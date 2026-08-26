;---------------------------------------------------------------------
;	_swusb_measure_pkt
;
;	UCHAR swusb_measure_pkt(UCHAR *bit_count, USHORT *clk_count);
;
;	input:
;		NONE
;	output:
;		bit_count(AX)	number of bits
;		clk_count(BC)	number of clocks
;	return:
;		0: Successful packet measurement
;		0xFF: Reset detection
;		0xFE: Resume detection
;		0x80:  Error （SYNC detection failure）
;		0x81:  Error （bit stuff violation)
;---------------------------------------------------------------------

$INCLUDE "swusb_pin_config.inc"

BIT_DPLUS		.EQU	1 << BITPOS_DPLUS
BIT_DMINUS		.EQU	1 << BITPOS_DMINUS
BIT_USBMASK		.EQU	BIT_DPLUS | BIT_DMINUS
PORT_DPLUS		.EQU	USB_PORT_REG.BITPOS_DPLUS
PORT_DMINUS		.EQU	USB_PORT_REG.BITPOS_DMINUS

MEASURE_STS_OK			.EQU	0
MEASURE_STS_RESET		.EQU	0xFF
MEASURE_STS_RESUME		.EQU	0xFE
MEASURE_STS_ERR_SYNC		.EQU	0x80
MEASURE_STS_ERR_BIT_SUTFF	.EQU	0x81


	.PUBLIC	_swusb_measure_pkt
	.EXTERN	sp_save

;-----------------------------------------------
; Comment conventions
;
; [t] c <xxx>; comment
;
; t = cumulative clock number
; c = number of clocks for that instruction
; Shaded lines indicate when condition is not met / established
; xxx = processing category
; comment = any comment description
;-----------------------------------------------

;-----------------------------------------------
	.SECTION .textf,TEXTF
_swusb_measure_pkt:
	PUSH	AX				; bit_count
	PUSH	BC				; clk_count

	; Because it comes here at the falling edge interrupt of D-,
        ; the current state is K or SE 0.

	; Wait for J to come
	MOV	A, #10				;;8clk/loop * 10loop = 80clk = 3.33us
wait_j:
	BT	PORT_DMINUS, $found_j		; [ ] 3/5
	DEC	A				; [ ] 1
	BNZ	$wait_j				; [ ] 2/4

	; K or SE0 is long
	MOV	A, USB_PORT_REG
	AND	A, #BIT_USBMASK
	BZ	$found_reset			;SE0 → Reset and determination
	CMP	A, #BIT_DPLUS
	BZ	$found_resume			; K → resume detected

	; Unexpected signal; sync failure
	MOV	A, #MEASURE_STS_ERR_SYNC
	POP	HL
	POP	HL
	RET

found_reset:
	MOV	A, #MEASURE_STS_RESET
	POP	HL
	POP	HL
	RET

found_resume:
	MOV	A, #MEASURE_STS_RESUME
	POP	HL
	POP	HL
	RET

	; The current state is J
found_j:
	; Wait 1 bit time (16 clk) or more to become K.
	BF	PORT_DMINUS, $found_k		;[T0+5][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+8][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+11][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+14][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+17][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+20][Tm-32] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+23][Tm-32] 3/5

	; J was long → short time SE0 (or K).
        ; If it is single-shot it is Keep-alive.
        ; If it is not single, it is a SYNC detection failure.
        ;' It is an error.
	MOV	A, #MEASURE_STS_ERR_SYNC
	POP	HL
	POP	HL
	RET

	; The current state is K.
        ; Another one bit time, K continues?
found_k:
	BT	PORT_DMINUS, $found_j		;[Tm-27] 3/5
	BT	PORT_DMINUS, $found_j		;[Tm-24] 3/5
	BT	PORT_DMINUS, $found_j		;[Tm-21] 3/5
	BT	PORT_DMINUS, $found_j		;[Tm-18] 3/5
	BT	PORT_DMINUS, $found_j		;[Tm-15] 3/5

	; 2 bit continuous K was detected.
        ; Detected as the end of SYNC.
	NOP					;[Tm-12] 1
	NOP					;[Tm-11] 1
	NOP					;[Tm-10] 1
	NOP					;[Tm-9] 1
	NOP					;[Tm-8] 1
	NOP					;[Tm-7] 1
	NOP					;[Tm-6] 1
	NOP					;[Tm-5] 1
	NOP					;[Tm-4] 1
	NOP					;[Tm-3] 1
	NOP					;[Tm-2] 1
	NOP					;[Tm-1] 1
	NOP					;[Tm] 1  This is the beginning of b0.
	NOP					;[Tm+1] 1
	MOVW	AX, SP				;[Tm+2] 1 ;save SP
	MOVW	!sp_save, AX			;[Tm+3] 1 ;save SP
	MOVW	SP, #0				;[Tm+4] 1 <sum> ;initialize clk count
	CLRB	A				;[Tm+5] 1 <sum> :initialize bit count

	; Start with polling of D + / D- which is High
	BT	PORT_DMINUS, $dm_prepare	;[Tm+6][Tp+6] 3/5

dp_prepare:
	NOP					;[Tm+9] 1
	NOP					;[Tm+10] 1
	BR	!dp_entry			;[Tm+11] 3

dm_prepare:
	BR	!dm_entry			;[Tp+11] 3

;-----------------------------------------------
; ↓ Macro
DP_POLL		.MACRO	dp_falled		;[T] 3/5
	MOV1	CY, PORT_DPLUS			;[T] 1
	SKC			 		;[T+1] 1
	BR	!dp_falled			;[T+2] 1/3
	.ENDM

DM_POLL		.MACRO	dm_falled		;[T] 3/5
	MOV1	CY, PORT_DMINUS			;[T] 1
	SKC					;[T+1] 1
	BR	!dm_falled			;[T+2] 1/3
	.ENDM

DP_FALLED	.MACRO	index, nbit		;[T] 6
	ADD	A, #nbit			;[T] 1 <sum> ;add bit count
	NOP					;[T+1] 1
	ADDW	SP, #(index * 3 + 14) * 2	;[T+2] 1 ;add clk count （Since SP can only hold an even number, it holds a double value）
	BR	!dp_end				;[T+3] 3
	.ENDM

DM_FALLED	.MACRO	index, nbit		;[T] 6
	ADD	A, #nbit			;[T] 1 <sum> ;add bit count
	NOP					;[T+1] 1
	ADDW	SP, #(index * 3 + 14) * 2	;[T+2] 1 ;add clk count （Since SP can only hold an even number, it holds a double value）
	BR	!dm_end				;[T+3] 3
	.ENDM
; ↑ End of Macro
;-----------------------------------------------

dm_end:
	; check EOP
	; Since I saw D- = Low, I should check D+ = Low.
	MOV1	CY, PORT_DPLUS			;[Tm+11] 1
	SKC					;[Tm+12] 1
	BR	!eop				;[Tm+13] 1/3

dp_entry:
	; Poll D+
	; ---(1 bit width less than Tm + 24)---
	DP_POLL	dp_falled0			;[Tm+14][Tp] 3/5
	DP_POLL	dp_falled1			;[Tm+17][Tp] 3/5
	DP_POLL	dp_falled2			;[Tm+20][Tp] 3/5
	DP_POLL	dp_falled3			;[Tm+23][Tp] 3/5

	; ---(Tm + 24 or more is 2 bit width)---
	DP_POLL	dp_falled4			;[Tm+26][Tp] 3/5
	DP_POLL	dp_falled5			;[Tm+29][Tp] 3/5
	DP_POLL	dp_falled6			;[Tm+32][Tp] 3/5
	DP_POLL	dp_falled7			;[Tm+35][Tp] 3/5
	DP_POLL	dp_falled8			;[Tm+38][Tp] 3/5

	; ---(3 bit width for Tm + 40 and higher)---
	DP_POLL	dp_falled9			;[Tm+41][Tp] 3/5
	DP_POLL	dp_falled10			;[Tm+44][Tp] 3/5
	DP_POLL	dp_falled11			;[Tm+47][Tp] 3/5
	DP_POLL	dp_falled12			;[Tm+50][Tp] 3/5
	DP_POLL	dp_falled13			;[Tm+53][Tp] 3/5

	; ---(4 bit width for Tm + 56 and higher)---
	DP_POLL	dp_falled14			;[Tm+56][Tp] 3/5
	DP_POLL	dp_falled15			;[Tm+59][Tp] 3/5
	DP_POLL	dp_falled16			;[Tm+62][Tp] 3/5
	DP_POLL	dp_falled17			;[Tm+65][Tp] 3/5
	DP_POLL	dp_falled18			;[Tm+68][Tp] 3/5
	DP_POLL	dp_falled19			;[Tm+71][Tp] 3/5

	; ---(5 bit width for Tm + 72 and higher)---
	DP_POLL	dp_falled20			;[Tm+74][Tp] 3/5
	DP_POLL	dp_falled21			;[Tm+77][Tp] 3/5
	DP_POLL	dp_falled22			;[Tm+80][Tp] 3/5
	DP_POLL	dp_falled23			;[Tm+83][Tp] 3/5
	DP_POLL	dp_falled24			;[Tm+86][Tp] 3/5

	; ---(6 bit width for Tm + 88 and higher)---
	DP_POLL	dp_falled25			;[Tm+89][Tp] 3/5
	DP_POLL	dp_falled26			;[Tm+92][Tp] 3/5
	DP_POLL	dp_falled27			;[Tm+95][Tp] 3/5
	DP_POLL	dp_falled28			;[Tm+98][Tp] 3/5
	DP_POLL	dp_falled29			;[Tm+101][Tp] 3/5

	; ---(7 bit width for Tm + 104 and higher)---
	DP_POLL	dp_falled30			;[Tm+104][Tp] 3/5
	DP_POLL	dp_falled31			;[Tm+107][Tp] 3/5
	DP_POLL	dp_falled32			;[Tm+110][Tp] 3/5
	DP_POLL	dp_falled33			;[Tm+113][Tp] 3/5
	DP_POLL	dp_falled34			;[Tm+116][Tp] 3/5
	DP_POLL	dp_falled35			;[Tm+119][Tp] 3/5

	; ---(Tm + 120.4 or more is bit stuff violation)---
	BR	!bit_stuff_error

;-----------------------------------------------
; ↓ Summary routine
dp_falled0:	DP_FALLED	0, 1		;[Tp+5] 6
dp_falled1:	DP_FALLED	1, 1		;[Tp+5] 6
dp_falled2:	DP_FALLED	2, 1		;[Tp+5] 6
dp_falled3:	DP_FALLED	3, 1		;[Tp+5] 6
dp_falled4:	DP_FALLED	4, 2		;[Tp+5] 6
dp_falled5:	DP_FALLED	5, 2		;[Tp+5] 6
dp_falled6:	DP_FALLED	6, 2		;[Tp+5] 6
dp_falled7:	DP_FALLED	7, 2		;[Tp+5] 6
dp_falled8:	DP_FALLED	8, 2		;[Tp+5] 6
dp_falled9:	DP_FALLED	9, 3		;[Tp+5] 6
dp_falled10:	DP_FALLED	10, 3		;[Tp+5] 6
dp_falled11:	DP_FALLED	11, 3		;[Tp+5] 6
dp_falled12:	DP_FALLED	12, 3		;[Tp+5] 6
dp_falled13:	DP_FALLED	13, 3		;[Tp+5] 6
dp_falled14:	DP_FALLED	14, 4		;[Tp+5] 6
dp_falled15:	DP_FALLED	15, 4		;[Tp+5] 6
dp_falled16:	DP_FALLED	16, 4		;[Tp+5] 6
dp_falled17:	DP_FALLED	17, 4		;[Tp+5] 6
dp_falled18:	DP_FALLED	18, 4		;[Tp+5] 6
dp_falled19:	DP_FALLED	19, 4		;[Tp+5] 6
dp_falled20:	DP_FALLED	20, 5		;[Tp+5] 6
dp_falled21:	DP_FALLED	21, 5		;[Tp+5] 6
dp_falled22:	DP_FALLED	22, 5		;[Tp+5] 6
dp_falled23:	DP_FALLED	23, 5		;[Tp+5] 6
dp_falled24:	DP_FALLED	24, 5		;[Tp+5] 6
dp_falled25:	DP_FALLED	25, 6		;[Tp+5] 6
dp_falled26:	DP_FALLED	26, 6		;[Tp+5] 6
dp_falled27:	DP_FALLED	27, 6		;[Tp+5] 6
dp_falled28:	DP_FALLED	28, 6		;[Tp+5] 6
dp_falled29:	DP_FALLED	29, 6		;[Tp+5] 6
dp_falled30:	DP_FALLED	30, 7		;[Tp+5] 6
dp_falled31:	DP_FALLED	31, 7		;[Tp+5] 6
dp_falled32:	DP_FALLED	32, 7		;[Tp+5] 6
dp_falled33:	DP_FALLED	33, 7		;[Tp+5] 6
dp_falled34:	DP_FALLED	34, 7		;[Tp+5] 6
dp_falled35:	DP_FALLED	35, 7		;[Tp+5] 6
; ↑ Summary tourint end
;-----------------------------------------------

dp_end:
	; check EOP
	; We have seen D + = Low, so we can check D- = Low.
	MOV1	CY, PORT_DMINUS			;[Tp+11] 1
	SKC					;[Tp+12] 1
	BR	!eop				;[Tp+13] 1/3

dm_entry:
	; Poll D-
	; ---(1 bit width, less than Tp + 24)---
	DM_POLL	dm_falled0			;[Tp+14][Tm] 3/5
	DM_POLL	dm_falled1			;[Tp+17][Tm] 3/5
	DM_POLL	dm_falled2			;[Tp+20][Tm] 3/5
	DM_POLL	dm_falled3			;[Tp+23][Tm] 3/5

	; ---(2 bit width for Tp + 24 or more)---
	DM_POLL	dm_falled4			;[Tp+26][Tm] 3/5
	DM_POLL	dm_falled5			;[Tp+29][Tm] 3/5
	DM_POLL	dm_falled6			;[Tp+32][Tm] 3/5
	DM_POLL	dm_falled7			;[Tp+35][Tm] 3/5
	DM_POLL	dm_falled8			;[Tp+38][Tm] 3/5

	; ---(3 bit width for Tp + 40 or more)---
	DM_POLL	dm_falled9			;[Tp+41][Tm] 3/5
	DM_POLL	dm_falled10			;[Tp+44][Tm] 3/5
	DM_POLL	dm_falled11			;[Tp+47][Tm] 3/5
	DM_POLL	dm_falled12			;[Tp+50][Tm] 3/5
	DM_POLL	dm_falled13			;[Tp+53][Tm] 3/5

	; ---(4 bit width for Tp + 56 and above)---
	DM_POLL	dm_falled14			;[Tp+56][Tm] 3/5
	DM_POLL	dm_falled15			;[Tp+59][Tm] 3/5
	DM_POLL	dm_falled16			;[Tp+62][Tm] 3/5
	DM_POLL	dm_falled17			;[Tp+65][Tm] 3/5
	DM_POLL	dm_falled18			;[Tp+68][Tm] 3/5
	DM_POLL	dm_falled19			;[Tp+71][Tm] 3/5

	; ---(5 bit width for Tp + 72 and above)---
	DM_POLL	dm_falled20			;[Tp+74][Tm] 3/5
	DM_POLL	dm_falled21			;[Tp+77][Tm] 3/5
	DM_POLL	dm_falled22			;[Tp+80][Tm] 3/5
	DM_POLL	dm_falled23			;[Tp+83][Tm] 3/5
	DM_POLL	dm_falled24			;[Tp+86][Tm] 3/5

	; ---(6 bit width for Tp + 88 and higher)---
	DM_POLL	dm_falled25			;[Tp+89][Tm] 3/5
	DM_POLL	dm_falled26			;[Tp+92][Tm] 3/5
	DM_POLL	dm_falled27			;[Tp+95][Tm] 3/5
	DM_POLL	dm_falled28			;[Tp+98][Tm] 3/5
	DM_POLL	dm_falled29			;[Tp+101][Tm] 3/5

	; ---(7 bit width for Tp + 104 and higher)---
	DM_POLL	dm_falled30			;[Tp+104][Tm] 3/5
	DM_POLL	dm_falled31			;[Tp+107][Tm] 3/5
	DM_POLL	dm_falled32			;[Tp+110][Tm] 3/5
	DM_POLL	dm_falled33			;[Tp+113][Tm] 3/5
	DM_POLL	dm_falled34			;[Tp+116][Tm] 3/5
	DM_POLL	dm_falled35			;[Tp+119][Tm] 3/5

	; ---(Tp + 120.4 or more is bit stuff violation)---
	BR	!bit_stuff_error

;-----------------------------------------------
; ↓ Summary routine
dm_falled0:	DM_FALLED	0, 1		;[Tm+5] 6
dm_falled1:	DM_FALLED	1, 1		;[Tm+5] 6
dm_falled2:	DM_FALLED	2, 1		;[Tm+5] 6
dm_falled3:	DM_FALLED	3, 1		;[Tm+5] 6
dm_falled4:	DM_FALLED	4, 2		;[Tm+5] 6
dm_falled5:	DM_FALLED	5, 2		;[Tm+5] 6
dm_falled6:	DM_FALLED	6, 2		;[Tm+5] 6
dm_falled7:	DM_FALLED	7, 2		;[Tm+5] 6
dm_falled8:	DM_FALLED	8, 2		;[Tm+5] 6
dm_falled9:	DM_FALLED	9, 3		;[Tm+5] 6
dm_falled10:	DM_FALLED	10, 3		;[Tm+5] 6
dm_falled11:	DM_FALLED	11, 3		;[Tm+5] 6
dm_falled12:	DM_FALLED	12, 3		;[Tm+5] 6
dm_falled13:	DM_FALLED	13, 3		;[Tm+5] 6
dm_falled14:	DM_FALLED	14, 4		;[Tm+5] 6
dm_falled15:	DM_FALLED	15, 4		;[Tm+5] 6
dm_falled16:	DM_FALLED	16, 4		;[Tm+5] 6
dm_falled17:	DM_FALLED	17, 4		;[Tm+5] 6
dm_falled18:	DM_FALLED	18, 4		;[Tm+5] 6
dm_falled19:	DM_FALLED	19, 4		;[Tm+5] 6
dm_falled20:	DM_FALLED	20, 5		;[Tm+5] 6
dm_falled21:	DM_FALLED	21, 5		;[Tm+5] 6
dm_falled22:	DM_FALLED	22, 5		;[Tm+5] 6
dm_falled23:	DM_FALLED	23, 5		;[Tm+5] 6
dm_falled24:	DM_FALLED	24, 5		;[Tm+5] 6
dm_falled25:	DM_FALLED	25, 6		;[Tm+5] 6
dm_falled26:	DM_FALLED	26, 6		;[Tm+5] 6
dm_falled27:	DM_FALLED	27, 6		;[Tm+5] 6
dm_falled28:	DM_FALLED	28, 6		;[Tm+5] 6
dm_falled29:	DM_FALLED	29, 6		;[Tm+5] 6
dm_falled30:	DM_FALLED	30, 7		;[Tm+5] 6
dm_falled31:	DM_FALLED	31, 7		;[Tm+5] 6
dm_falled32:	DM_FALLED	32, 7		;[Tm+5] 6
dm_falled33:	DM_FALLED	33, 7		;[Tm+5] 6
dm_falled34:	DM_FALLED	34, 7		;[Tm+5] 6
dm_falled35:	DM_FALLED	35, 7		;[Tm+5] 6
; ↑ Summary routine end
;-----------------------------------------------


eop:
	MOV	B, A				;[Tp+16][Tm+16] 1 ;B=bit count
	MOVW	AX, SP				;[Tp+17] 1 ;AX=(clk count) * 2
	SHRW	AX, 1				;[Tp+18] 1 ;AX=clk count
	MOVW	DE, AX				;[Tp+19] 1 ;DE=clk count

	MOVW	AX, !sp_save			;[Tp+20] 1 ;restore SP
	MOVW	SP, AX				;[Tp+21] 1 ;restore SP

	MOVW	AX, DE				;[Tp+22] 1 ;AX=clk count
	POP	DE				;[Tp+23] 1 ;USHORT *clk_count
	POP	HL				;[Tp+24] 1 ;UCHAR *bit_count
	MOVW	[DE], AX			;[Tp+25] 1 ; *clk_count = (clk count)
	MOV	A, B				;[Tp+26] 1 ;A=bit count
	MOV	[HL], A				;[Tp+27] 1 ; *bit_count = (bit count)
	MOV	A, #MEASURE_STS_OK		;[Tp+28] 1
	RET					;[Tp+29] 6

bit_stuff_error:
	MOVW	AX, !sp_save			;restore SP
	MOVW	SP, AX				;restore SP
	POP	HL
	POP	HL
	MOV	A, #MEASURE_STS_ERR_BIT_SUTFF
	RET
