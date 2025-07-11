;---------------------------------------------------------------------
;	_swusb_recv_pkt
;
;	UCHAR swusb_recv_pkt(UCHAR recv_buf[11]);
;
;	input:
;		NONE
;	output:
;		recv_buf(AX)	// received data
;	return:
;		receive status
;	note:  
;		This routine runs during D- interrupt processing.
;		It relies on RL78 machine instruction execution times (clock cycles).
;		The effective sampling ratio is 16:1 (24 MHz RL78 clock rate, 1.5 Mbps bit rate).
;		This routine is extremely time-critical.
;---------------------------------------------------------------------

$INCLUDE "swusb_pin_config.inc"

;TRANSLATE_BEGIN

BIT_DPLUS		.EQU	1 << BITPOS_DPLUS
BIT_DMINUS		.EQU	1 << BITPOS_DMINUS
BIT_USBMASK		.EQU	BIT_DPLUS | BIT_DMINUS
PORT_DPLUS		.EQU	USB_PORT_REG.BITPOS_DPLUS
PORT_DMINUS		.EQU	USB_PORT_REG.BITPOS_DMINUS

RECV_STS_CRC16_OK_BIT	.EQU	0x10
RECV_STS_RESET		.EQU	0xFF
RECV_STS_RESUME		.EQU	0xFE
RECV_STS_ERR_SYNC	.EQU	0x80
RECV_STS_ERR_SYNC2	.EQU	0x81
RECV_STS_ERR_OVERRUN	.EQU	0x82
RECV_STS_ERR_STUFF	.EQU	0x83


RECV_MAX	.EQU	11			; 1(PID) + 8(DATA) + 2(CRC)

; [USB20, 8.3.5.2 Data CRCs]
;  If all data and CRC bits are received without error,
;  the 16-bit residual will be 1000000000001101B.
EXPECTED_CRC_RESIDUAL	.EQU	0xB001		; bits in reverse order

; stack frame
STACK_FRAME_SIZE	.EQU	2
SF_RATE_CNT		.EQU	0

;TRANSLATE_END

	.PUBLIC	_swusb_recv_pkt
	.EXTERN	_g_crc_tbl_swap
	.EXTERN	crc16
	.EXTERN	crc16_h
	.EXTERN	crc16_l
	.EXTERN	shift
	.EXTERN	stuff

;-----------------------------------------------
; Comment conventions for low-level instuction execution times
;
;  ;[t] c <xxx> ;comment
;
;   t= Cumulative number of clocks
;       This may include clocks resulting from other routes.
;       Add * to sampling point.
;   c= Number of clocks for that instruction
;       Hatched lines indicate when conditions are not met / established
;   xxx= Processing category
;   comment= Any further comment description
;-----------------------------------------------

;-----------------------------------------------
	.SECTION .textf,TEXTF
_swusb_recv_pkt:
	;Since execution comes here by the falling edge of D- interrupt, 
	;the current state is K or SE 0.
	;TRANSLATE_BEGIN
	MOVW	HL, AX				; HL=recv_buf
	;TRANSLATE_END

	; Wait for J to become established
	MOV	A, #10				;;8clk/loop * 10loop = 80clk = 3.33us
wait_j:
	BT	PORT_DMINUS, $found_j		;[T0] 3/5
	DEC	A				;[] 1
	BNZ	$wait_j				;[] 2/4

	; K or SE0 is long
	MOV	A, USB_PORT_REG
	AND	A, #BIT_USBMASK
	BZ	$found_reset			;SE0 Å® Reset and judge 
	CMP	A, #BIT_DPLUS
	BZ	$found_resume			;K Å® Judge as reume

	; Unexpected signal, SYNC synchronization failure
	MOV	A, #RECV_STS_ERR_SYNC
	RET

found_reset:
	MOV	A, #RECV_STS_RESET
	RET

found_resume:
	MOV	A, #RECV_STS_RESUME
	RET

	; The current state is J.
found_j:
	; Wait 1 bit time (16 clk) or more to become K.
	BF	PORT_DMINUS, $found_k		;[T0+5][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+8][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+11][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+14][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+17][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+20][T1] 3/5
	BF	PORT_DMINUS, $found_k		;[T0+23][T1] 3/5

	; J was long Å® SE 0 (or K) for a short time.
	; If it is single-shot, it is Keep-alive.
	; Otherwise, it is an error -- SYNC detection failure.
	MOV	A, #RECV_STS_ERR_SYNC2
	RET

	; The current state is K.
	; In another 1 bit time, will K continue?
found_k:
	BT	PORT_DMINUS, $found_j		;[T1+5] 3/5
	BT	PORT_DMINUS, $found_j		;[T1+8] 3/5
	BT	PORT_DMINUS, $found_j		;[T1+11] 3/5
	BT	PORT_DMINUS, $found_j		;[T1+14] 3/5
	BT	PORT_DMINUS, $found_j		;[T1+17][-22] 3/5

	;TRANSLATE_BEGIN

	; 2 bits continuous K was detected.
	; Judged as the end of SYNC.
	SUBW	SP, #STACK_FRAME_SIZE		;[-19] 1
	NOP					;[-18] 1

	; Initialize
	MOV	D, #BIT_DPLUS			;[-17] 1 <NRZI> ;previous D-
	MOV	!shift, #0xFF			;[-16] 1 <bit stuff>
	MOV	E, #RECV_MAX + 1		;[-15] 1 <store> ;recvbuf remaining bytes
	MOV	[SP+SF_RATE_CNT], #128		;[-14] 1 <rate>
	MOVW	BC, #0x0000			;[-13] 1 <CRC> ;CRC table offset, dummy value
	NOP					;[-12] 1
	NOP					;[-11] 1
	NOP					;[-10] 1
	NOP					;[-9] 1
	NOP					;[-8] 1
	NOP					;[-7] 1
	NOP					;[-6] 1
	NOP					;[-5] 1
	NOP					;[-4] 1

	; Go to the entrance of Decode main line
	BR	!decode_start			;[-3] 3

;-----------------------------------------------

stuffb0_done:
readb1:
	; read b1
	MOV	A, USB_PORT_REG			;[16*][32*] 1 <sampling>
	AND	A, #BIT_USBMASK			;[17] 1 ;check SE0 <EOP?>
	SKNZ					;[18] 1 <EOP?>
	BR	!eop				;[19] 1/3 <EOP?>
	XCH	A, D				;[20] 1 <NRZI>
	XOR	A, D				;[21] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[22] 1 <NRZI>
	MOV	A, !shift			;[23] 1 <store>
	MOV1	A.1, CY				;[24] 1 <store>
	AND	A, #0b11110011			;[25] 1 <bit stuff>
	MOV	!shift, A			;[26] 1 <store>
	SKNZ					;[27] 1 <bit stuff>
	BR	!stuffb1			;[28] 1/3 <bit stuff>
stuffb1_done:
	SHLW	BC, 1				;[29][45] 1 <CRC> ;BC=table offset
	NOP					;[30][46] 1
	NOP					;[31][47] 1

	; read b2
	MOV	A, USB_PORT_REG			;[32*][48*] 1 <sampling>
	XCH	A, D				;[33] 1 <NRZI>
	XOR	A, D				;[34] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[35] 1 <NRZI>
	MOV	A, !shift			;[36] 1 <store>
	MOV1	A.2, CY				;[37] 1 <store>
	AND	A, #0b11100111			;[38] 1 <bit stuff>
	MOV	!shift, A			;[39] 1 <store>
	SKNZ					;[40] 1 <bit stuff>
	BR	!stuffb2			;[41] 1/3 <bit stuff>
stuffb2_done:
	MOV	A, [SP+SF_RATE_CNT]		;[42][58] 1 <rate>
	ADD	A, !_g_swusb_rate_offset	;[43][59] 1 <rate>
	MOV	[SP+SF_RATE_CNT], A		;[44][60] 1 <rate>
	SKNC					;[45][61] 1 <rate>
	BR	$rateb2				;[46][62] 1/3 <rate>
rateb2:

	; read b3
	MOV	A, USB_PORT_REG			;[48(+/-)1][64(+/-)1]* 1 <sampling>
	XCH	A, D				;[49] 1 <NRZI>
	XOR	A, D				;[50] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[51] 1 <NRZI>
	MOV	A, !shift			;[52] 1 <store>
	MOV1	A.3, CY				;[53] 1 <store>
	AND	A, #0b11001111			;[54] 1 <bit stuff>
	MOV	!shift, A			;[55] 1 <store>
	SKNZ					;[56] 1 <bit stuff>
	BR	!stuffb3			;[57] 1/3 <bit stuff>
stuffb3_done:
	DEC	E				;[58][74] 1 <overrun?>
	SKNZ					;[59][75] 1 <overrun?>
	BR	!overrun			;[60][76] 1/3 <overrun?>
	NOP					;[61][77] 1
	NOP					;[62][78] 1
	NOP					;[63][79] 1

	; read b4
	MOV	A, USB_PORT_REG			;[64*][80*] 1 <sampling>
	XCH	A, D				;[65] 1 <NRZI>
	XOR	A, D				;[66] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[67] 1 <NRZI>
	MOV	A, !shift			;[68] 1 <store>
	MOV1	A.4, CY				;[69] 1 <store>
	AND	A, #0b10011111			;[70] 1 <bit stuff>
	MOV	!shift, A			;[71] 1 <store>
	SKNZ					;[72] 1 <bit stuff>
	BR	!stuffb4			;[73] 1/3 <bit stuff>
stuffb4_done:
	MOVW	AX, #LOWW(_g_crc_tbl_swap)[BC]	;[74][90] 4 <CRC> ;(A,X)=(Table_L,Table_H)
	XOR	A, !crc16_h			;[78][94] 1 <CRC> ;A=Table_L^CRC_H
	MOVW	!crc16, AX			;[79][95] 1 <CRC> ;CRC=(Table_L^CRC_H,Table_H)

	; read b5
	MOV	A, USB_PORT_REG			;[80*][96*] 1 <sampling>
	XCH	A, D				;[81] 1 <NRZI>
	XOR	A, D				;[82] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[83] 1 <NRZI>
	MOV	A, !shift			;[84] 1 <store>
	MOV1	A.5, CY				;[85] 1 <store>
	AND	A, #0b00111111			;[86] 1 <bit stuff>
	MOV	!shift, A			;[87] 1 <store>
	SKNZ					;[88] 1 <bit stuff>
	BR	!stuffb5			;[89] 1/3 <bit stuff>
stuffb5_done:
	MOV	A, E				;[90][106] 1 <CRC>
	CMP	A, #(RECV_MAX - 1)		;[91][107] 1 <CRC>
	MOVW	AX, #0xFFFF			;[92][108] 1 <CRC>
	SKNZ					;[93][109] 1 <CRC>
	MOVW	!crc16, AX			;[94][110] 1/1 <CRC> ;Because PID is not subject to CRC calculation, 
								     ;reset CRC at the beginning timing of DATA
	NOP					;[95][111] 1

	; read b6
	MOV	A, USB_PORT_REG			;[96*][112*] 1 <sampling>
	XCH	A, D				;[97] 1 <NRZI>
	XOR	A, D				;[98] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[99] 1 <NRZI>
	MOV	A, !shift			;[100] 1 <store>
	MOV1	A.6, CY				;[101] 1 <store>
	CMP	A, #2				;[102] 1 <bit stuff>
	MOV	!shift, A			;[103] 1 <store>
	SKNC					;[104] 1 <bit stuff>
	BR	!stuffb6			;[105] 1/3 <bit stuff>
stuffb6_done:
	MOV	A, [SP+SF_RATE_CNT]		;[106][122] 1 <rate>
	ADD	A, !_g_swusb_rate_offset	;[107][123] 1 <rate>
	MOV	[SP+SF_RATE_CNT], A		;[108][124] 1 <rate>
	SKNC					;[109][125] 1 <rate>
	BR	$rateb6				;[110][126] 1/3 <rate>
rateb6:

	; read b7
	MOV	A, USB_PORT_REG			;[112(+/-)1][128(+/-)1]* 1 <sampling>
	XCH	A, D				;[113] 1 <NRZI>
	XOR	A, D				;[114] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[115] 1 <NRZI>
	MOV	A, !shift			;[116] 1 <store>
	MOV1	A.7, CY				;[117] 1 <store>
	CMP	A, #4				;[118] 1 <bit stuff>
	MOV	!shift, A			;[119] 1 <store>
	SKNC					;[120] 1 <bit stuff>
	BR	!stuffb7			;[121] 1/3 <bit stuff>
stuffb7_done:
	XOR	A, !stuff			;[122][138] 1 <store> ;A = shift ^ stuff
	MOV	[HL], A				;[123][139] 1 <store> ;store in receive buffer
	INCW	HL				;[124][140] 1 <store>
	XOR	A, !crc16_l			;[125][141] 1 <CRC> ;A=byte^CRC_L
	MOV	C, A				;[126][142] 1 <CRC>
	CLRB	B				;[127][143] 1 <CRC> ;BC=table index

decode_start:					;===== Decode main line entrance =====

	; read b0
	MOV	A, USB_PORT_REG			;[0*][128*][144*] 1 <sampling>
	AND	A, #BIT_USBMASK			;[1] 1 ;check SE0 <EOP?>
	SKNZ					;[2] 1 <EOP?>
	BR	!eop				;[3] 1/3 <EOP?>
	MOV	!stuff, #0xFF			;[4] 1 <store> ;Initialization at the beginning of byte decoding
	XCH	A, D				;[5] 1 <NRZI>
	XOR	A, D				;[6] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[7] 1 <NRZI>
	MOV	A, !shift			;[8] 1 <store>
	MOV1	A.0, CY				;[9] 1 <store>
	AND	A, #0b11111001			;[10] 1 <bit stuff>
	MOV	!shift, A			;[11] 1 <store>
	SKZ					;[12] 1 <bit stuff>
	BR	!readb1				;[13] 1/3 <bit stuff>
	;BR	!stuffb0

;-----------------------------------------------
; Å´ Start of stuff routine
;stuffb0:
	NOP					;[14] 1
	NOP					;[15] 1
	MOV	A, USB_PORT_REG			;[16*] 1 <sampling>
	XCH	A, D				;[17] 1 <NRZI>
	XOR	A, D				;[18] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error_r	;[19] 3/5 <bit sutff>
	SET1	!shift.0			;[22] 2 <store>
	CLR1	!stuff.0			;[24] 2 <store>
	NOP					;[26] 1
	NOP					;[27] 1
	NOP					;[28] 1
	BR	!stuffb0_done			;[29] 3

stuffb1:
	NOP					;[31] 1
	MOV	A, USB_PORT_REG			;[32*] 1 <sampling>
	XCH	A, D				;[33] 1 <NRZI>
	XOR	A, D				;[34] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error_r	;[35] 3/5 <bit sutff>
	SET1	!shift.1			;[38] 2 <store>
	CLR1	!stuff.1			;[40] 2 <store>
	BR	!stuffb1_done			;[42] 3

stuffb2:
	SET1	!shift.2			;[44] 2 <store>
	CLR1	!stuff.2			;[46] 2 <store>
	MOV	A, USB_PORT_REG			;[48*] 1 <sampling>
	XCH	A, D				;[49] 1 <NRZI>
	XOR	A, D				;[50] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error_r	;[51] 3/5 <bit sutff>
	NOP					;[54] 1
	BR	!stuffb2_done			;[55] 3

stuffb3:
	SET1	!shift.3			;[60] 2 <store>
	CLR1	!stuff.3			;[62] 2 <store>
	MOV	A, USB_PORT_REG			;[64*] 1 <sampling>
	XCH	A, D				;[65] 1 <NRZI>
	XOR	A, D				;[66] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error_r	;[67] 3/5 <bit sutff>
	NOP					;[70] 1
	BR	!stuffb3_done			;[71] 3

stuff_error_r:
	BR	$stuff_error

stuffb4:
	SET1	!shift.4			;[76] 2 <store>
	CLR1	!stuff.4			;[78] 2 <store>
	MOV	A, USB_PORT_REG			;[80*] 1 <sampling>
	XCH	A, D				;[81] 1 <NRZI>
	XOR	A, D				;[82] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error	;[83] 3/5 <bit sutff>
	NOP					;[86] 1
	BR	!stuffb4_done			;[87] 3

stuffb5:
	SET1	!shift.5			;[92] 2 <store>
	CLR1	!stuff.5			;[94] 2 <store>
	MOV	A, USB_PORT_REG			;[96*] 1 <sampling>
	XCH	A, D				;[97] 1 <NRZI>
	XOR	A, D				;[98] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error	;[99] 3/5 <bit sutff>
	NOP					;[102] 1
	BR	!stuffb5_done			;[103] 3

stuffb6:
	SET1	!shift.6			;[108] 2 <store>
	CLR1	!stuff.6			;[110] 2 <store>
	MOV	A, USB_PORT_REG			;[112*] 1 <sampling>
	XCH	A, D				;[113] 1 <NRZI>
	XOR	A, D				;[114] 1 <NRZI>
	BF	A.BITPOS_DMINUS, $stuff_error	;[115] 3/5 <bit sutff>
	NOP					;[118] 1
	BR	!stuffb6_done			;[119] 3

stuffb7:
	SET1	!shift.7			;[124] 2 <store>
	CLR1	!stuff.7			;[126] 2 <store>
	MOV	A, USB_PORT_REG			;[128*] 1 <sampling>
	XCH	A, D				;[129] 1 <NRZI>
	XOR	A, D				;[130] 1 <NRZI>
	MOV1	CY, A.BITPOS_DMINUS		;[131] 1 <bit stuff>
	MOV	A, !shift			;[132] 1 <store> ;stuffb7_done. Assume that A has this value
	NOP					;[133] 1
	SKNC					;[134] 1 <bit stuff>
	BR	!stuffb7_done			;[135] 1/3 <bit stuff>
	;BR	!stuff_error
; Å™ End of stuff routine
;-----------------------------------------------

;-----------------------------------------------
; Å´ Start export
stuff_error:
	MOV	A, #RECV_STS_ERR_STUFF
	ADDW	SP, #STACK_FRAME_SIZE
	RET

eop:
	; EOP was detected.
	; Successful packet reception

	SHLW	BC, 1				;<CRC> ;BC=table offset

	; Number of bytes received
	MOV	A, #RECV_MAX + 1
	SUB	A, E
	MOV	E, A				;E=Number of bytes received

	; CRC update of last byte
	MOVW	AX, #LOWW(_g_crc_tbl_swap)[BC]	;<CRC> ;(A,X)=(Table_L,Table_H)
	XOR	A, !crc16_h			;<CRC> ;A=Table_L^CRC_H
	XCH	A, X				;<CRC> ;(A,X)=(Table_H,Table_L^CRC_H)

	; Return value
	; If the CRC 16 is correct, an OK bit is set
	CMPW	AX, #EXPECTED_CRC_RESIDUAL	; CRC16 check
	MOV	A, E				; Number of bytes received
	SKNZ
	OR	A, #RECV_STS_CRC16_OK_BIT	; CRC16 OK bit
	ADDW	SP, #STACK_FRAME_SIZE
	RET

overrun:
	; buffer overrun error
	MOV	A, #RECV_STS_ERR_OVERRUN
	ADDW	SP, #STACK_FRAME_SIZE
	RET
; Å™ End export
;-----------------------------------------------
;TRANSLATE_END
