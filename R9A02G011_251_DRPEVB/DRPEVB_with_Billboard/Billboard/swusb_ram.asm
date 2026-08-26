;---------------------------------------------------------------------
;	RAM definition
;	(recv_pkt.asm, xmit_pkt.asm, measure_pkt.asm shared area)
;---------------------------------------------------------------------

	.PUBLIC	sp_save
	.PUBLIC	crc16
	.PUBLIC	crc16_h
	.PUBLIC	crc16_l
	.PUBLIC	shift
	.PUBLIC	stuff
	.PUBLIC	xmit_buf


	.SECTION .bss,BSS
				;	recv_pkt.asm	xmit_pkt.asm	measure_pkt.asm
	.ALIGN 2
sp_save:
crc16:
crc16_h:			; Since we handle byte order reversal, big endian
	.DS (1)			;	crc16				sp_save
crc16_l:
	.DS (1)			;	crc16				sp_save

shift:
	.DS (1)			;	shift

stuff:
xmit_buf:
	.DS (1)			;	stuff		xmit_buf

