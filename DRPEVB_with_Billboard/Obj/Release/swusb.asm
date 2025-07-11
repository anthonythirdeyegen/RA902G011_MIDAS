#CC-RL Compiler RL78 Assembler Source
#@  CC-RL Version : V1.15.00  [06 Dec 2024]
#@  Commmand :
#@   Billboard\bbc_main.c
#@   Billboard\crc16.c
#@   Billboard\swusb.c
#@   Billboard\swusb_io.c
#@   ..\..\Core\r_systeminit.c
#@   ..\..\PDC\smbm_ctrl.c
#@   ..\..\PDC\user_timer.c
#@   PDC\dcdc_ctrl.c
#@   PDC\led_ctrl.c
#@   PDC\sw_ctrl.c
#@   PDC\user_main.c
#@   PDC\user_main_protection.c
#@   pd_defs.c
#@   r_main.c
#@   R_Main_UserInit.c
#@   PDC\subdev\isl95338.c
#@   PDC\subdev\subdev_ctrl.c
#@   -cpu=S3
#@   -obj_path=Obj\Release
#@   -dev=C:\Program Files (x86)\Renesas Electronics\CS+\CC\Device\RL78\Devicefile\DR9A02G011.DVF
#@   -g
#@   -Osame_code
#@   -I Billboard
#@   -I PDC\subdev
#@   -I PDC
#@   -I .
#@   -I ..\..\PDC\Lib
#@   -I ..\..\PDC
#@   -I ..\..\Core
#@   -D RELEASE_BUILD=1,PPS_SPRT=0
#@   -asm_path=Obj\Release
#@   -asmopt=-prn_path=Obj\Release
#@   -c
#@   -MAKEUD=Obj\Release
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_c0b7818164c94c2192d757ba2474eae6iiaofrot.nwu
#@  compiled at Tue May 06 10:51:15 2025

	$mirror _g_crc_tbl_swap
	.PUBLIC _thalt
	.PUBLIC _tbp
	.PUBLIC _tbuf
	.PUBLIC _g_swusb_rate_offset
	.PUBLIC _msg
	.PUBLIC _msghalt
	.PUBLIC _msgd
	.EXTERN _swusb_measure_pkt
	.EXTERN _swusb_recv_pkt
	.EXTERN _swusb_xmit_data_pkt
	.EXTERN _swusb_xmit_handshake_pkt
	.EXTERN _memset
	.EXTERN _memcpy
	.PUBLIC _swusb_init
	.EXTERN _swusb_io_init
	.EXTERN _pdc_set_int_routine
	.PUBLIC _swusb_proc
	.PUBLIC _swusb_is_transferring
	.PUBLIC _swusb_measure_rate
	.PUBLIC _swusb_enable
	.EXTERN _swusb_io_is_enabled
	.EXTERN _swusb_io_enable
	.PUBLIC _swusb_disable
	.EXTERN _swusb_io_disable
	.PUBLIC _swusb_set_power_supply
	.PUBLIC _swusb_bb_configured
	.PUBLIC _swusb_bb_set_additional_failure_info

	.SECTION .textf,TEXTF
	.TYPE _msg,function,.LFE1-_msg
_msg:
	.STACK _msg = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 34
	cmp !LOWW(_thalt), #0x01
	bz $.BB@LABEL@1_5
.BB@LABEL@1_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 37
	movw bc, !LOWW(_tbp)
	mov LOWW(_tbuf)[bc], a
	onew ax
	addw ax, !LOWW(_tbp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 38
	cmpw ax, #0x0010
	skc
.BB@LABEL@1_2:	; if_then_bb15
	clrw ax
.BB@LABEL@1_3:	; if_break_bb
	movw !LOWW(_tbp), ax
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 39
	mov LOWW(_tbuf)[bc], #0x5F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 40
	mov a, !LOWW(_thalt)
	mov b, a
	shrw ax, 8+0x00000
	cmpw ax, #0x0002
	bc $.BB@LABEL@1_5
.BB@LABEL@1_4:	; if_then_bb24
	mov a, b
	dec a
	mov !LOWW(_thalt), a
.BB@LABEL@1_5:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 42
	ret
.LFE1:
	.TYPE _msghalt,function,.LFE2-_msghalt
_msghalt:
	.STACK _msghalt = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 45
	push ax
	mov b, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 49
	mov a, b
	call $!_msg
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 50
	cmp0 !LOWW(_thalt)
	bnz $.BB@LABEL@2_2
.BB@LABEL@2_1:	; if_then_bb
	mov a, [sp+0x00]
	mov !LOWW(_thalt), a
.BB@LABEL@2_2:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 51
	ret
.LFE2:
	.TYPE _msgd,function,.LFE3-_msgd
_msgd:
	.STACK _msgd = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 54
	push bc
	push ax
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 58
	cmp0 a
	bnz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; entry.bb16_crit_edge
	clrw bc
	movw ax, bc
	br $.BB@LABEL@3_4
.BB@LABEL@3_2:	; if_then_bb
	call $!_msg
	br $.BB@LABEL@3_1
.BB@LABEL@3_3:	; bb
	movw ax, [sp+0x04]
	addw ax, bc
	movw de, ax
	mov a, [de]
	call $!_msg
	movw ax, [sp+0x00]
	incw ax
	movw bc, ax
.BB@LABEL@3_4:	; bb
	movw [sp+0x00], ax
	mov a, [sp+0x02]
	shrw ax, 8+0x00000
	or a, #0x80
	movw de, ax
	movw ax, bc
	xor a, #0x80
	cmpw ax, de
	bc $.BB@LABEL@3_3
.BB@LABEL@3_5:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/trace_buffer219.h", 60
	addw sp, #0x06
	ret
.LFE3:
	.TYPE _crc5_calc@1,function,.LFE4-_crc5_calc@1
_crc5_calc@1:
	.STACK _crc5_calc@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 260
	movw de, ax
	movw bc, #0x0B1F
	br $.BB@LABEL@4_4
.BB@LABEL@4_1:	; bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 266
	mov a, e
	xor a, c
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@4_3
.BB@LABEL@4_2:	; if_then_bb
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 267
	xor a, #0x28
	mov c, a
.BB@LABEL@4_3:	; if_break_bb
	movw ax, de
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 269
	shrw ax, 0x01
	movw de, ax
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 268
	shr a, 0x01
	mov c, a
.BB@LABEL@4_4:	; bb22
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 265
	dec b
	cmp0 a
	bnz $.BB@LABEL@4_1
.BB@LABEL@4_5:	; bb30
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 271
	xor a, #0x1F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 272
	ret
.LFE4:
	.TYPE _request_measure_on_bus_reset@1,function,.LFE5-_request_measure_on_bus_reset@1
_request_measure_on_bus_reset@1:
	.STACK _request_measure_on_bus_reset@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 280
	mov es, #0x00
	mov a, es:!0xF70A
	shrw ax, 8+0x00000
	clrb a
	xch a, x
	and a, #0xC0
	xch a, x
	or a, x
	sknz
.BB@LABEL@5_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 281
	set1 !LOWW(_g_field@8).0
.BB@LABEL@5_2:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 283
	ret
.LFE5:
	.TYPE _device_set_address@1,function,.LFE6-_device_set_address@1
_device_set_address@1:
	.STACK _device_set_address@1 = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 299
	push hl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 306
	shrw ax, 8+0x00000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 307
	call $!_crc5_calc@1
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 309
	mov !LOWW(_g_expected_token@2), a
	clrb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 308
	shlw ax, 0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 310
	mov !LOWW(_g_expected_token@2+0x00001), a
	pop ax
	ret
.LFE6:
	.TYPE _device_reset@1,function,.LFE7-_device_reset@1
_device_reset@1:
	.STACK _device_reset@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 316
	clrb !LOWW(_g_xact_state@1)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 317
	clrb a
	call $!_device_set_address@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 318
	clrb !LOWW(_g_in_data_pkt_len@4)
	mov a, #0x87
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 322
	and a, !LOWW(_g_field@8)
	mov !LOWW(_g_field@8), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 323
	clrb !LOWW(_g_transfer_state@9)
	mov a, #0xFC
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 325
	and a, !LOWW(_g_field@8)
	mov !LOWW(_g_field@8), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 328
	call $!_request_measure_on_bus_reset@1
	ret
.LFE7:
	.TYPE _device_configure@1,function,.LFE8-_device_configure@1
_device_configure@1:
	.STACK _device_configure@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 334
	set1 !LOWW(_g_field@8).6
	ret
.LFE8:
	.TYPE _device_deconfigure@1,function,.LFE9-_device_deconfigure@1
_device_deconfigure@1:
	.STACK _device_deconfigure@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 340
	clr1 !LOWW(_g_field@8).6
	ret
.LFE9:
	.TYPE _calibrate_bitrate@1,function,.LFE10-_calibrate_bitrate@1
_calibrate_bitrate@1:
	.STACK _calibrate_bitrate@1 = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 343
	subw sp, #0x04
	movw ax, sp
	addw ax, #0x0002
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 348
	movw bc, ax
	decw ax
	call !!_swusb_measure_pkt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 349
	cmp0 a
	bnz $.BB@LABEL@10_5
.BB@LABEL@10_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 350
	mov a, [sp+0x01]
	mov b, a
	shrw ax, 8+0x00000
	cmpw ax, #0x0058
	bc $.BB@LABEL@10_7
.BB@LABEL@10_2:	; bb
	mov a, b
	shrw ax, 8+0x00000
	cmpw ax, #0x0062
	bnc $.BB@LABEL@10_7
.BB@LABEL@10_3:	; if_then_bb24
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 372
	movw ax, [sp+0x02]
	movw bc, ax
	shlw ax, 0x09
	movw hl, ax
	mov a, [sp+0x01]
	mov [sp+0x00], a
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	shrw ax, 0x07
	movw bc, ax
	mov a, [sp+0x00]
	shrw ax, 8+0x00001
	addw ax, hl
	movw hl, #0x0000
	divwu
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 373
	addw ax, #0xE080
	cmpw ax, #0x0100
	bnc $.BB@LABEL@10_7
.BB@LABEL@10_4:	; if_then_bb53
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 374
	xor a, #0x80
	mov !LOWW(_g_swusb_rate_offset), a
	mov a, #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 378
	or a, !LOWW(_g_field@8)
	clr1 a.0
	mov !LOWW(_g_field@8), a
	br $.BB@LABEL@10_7
.BB@LABEL@10_5:	; if_else_bb64
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 384
	inc a
	sknz
.BB@LABEL@10_6:	; if_then_bb70
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 386
	call $!_device_reset@1
.BB@LABEL@10_7:	; return
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 391
	ret
.LFE10:
	.TYPE _int_dminus_handler@1,function,.LFE11-_int_dminus_handler@1
_int_dminus_handler@1:
	.STACK _int_dminus_handler@1 = 16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 394
	subw sp, #0x0C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 399
	mov a, !LOWW(_g_field@8)
	bf a.0, $.BB@LABEL@11_3
.BB@LABEL@11_1:	; bb
	bt a.1, $.BB@LABEL@11_3
.BB@LABEL@11_2:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 400
	call $!_calibrate_bitrate@1
	br $!.BB@LABEL@11_50
.BB@LABEL@11_3:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 402
	movw ax, sp
	incw ax
	call !!_swusb_recv_pkt
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 403
	shrw ax, 8+0x00000
	shlw ax, 0x09
	.bc $!.BB@LABEL@11_42
.BB@LABEL@11_4:	; if_then_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 405
	mov a, [sp+0x01]
	shrw ax, 8+0x00000
	clrb a
	xch a, x
	and a, #0x33
	xch a, x
	cmpw ax, #0x0021
	bnz $.BB@LABEL@11_22
.BB@LABEL@11_5:	; if_then_bb51
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 407
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x0003
	.bnz $!.BB@LABEL@11_47
.BB@LABEL@11_6:	; bb57
	mov a, [sp+0x02]
	cmp a, !LOWW(_g_expected_token@2)
	.bnz $!.BB@LABEL@11_47
.BB@LABEL@11_7:	; bb73
	mov a, [sp+0x03]
	cmp a, !LOWW(_g_expected_token@2+0x00001)
	.bnz $!.BB@LABEL@11_47
.BB@LABEL@11_8:	; if_then_bb90
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 409
	mov a, [sp+0x01]
	cmp a, #0x2D
	bnz $.BB@LABEL@11_10
.BB@LABEL@11_9:	; if_then_bb98
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 411
	oneb !LOWW(_g_xact_state@1)
	br $!.BB@LABEL@11_50
.BB@LABEL@11_10:	; if_else_bb99
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 412
	mov a, [sp+0x01]
	cmp a, #0xE1
	bnz $.BB@LABEL@11_12
.BB@LABEL@11_11:	; if_then_bb107
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 414
	mov !LOWW(_g_xact_state@1), #0x02
	br $!.BB@LABEL@11_50
.BB@LABEL@11_12:	; if_else_bb108
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 415
	mov a, [sp+0x01]
	cmp a, #0x69
	.bnz $!.BB@LABEL@11_47
.BB@LABEL@11_13:	; if_then_bb116
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 417
	cmp0 !LOWW(_g_in_data_pkt_len@4)
	mov a, !LOWW(_g_field@8)
	bz $.BB@LABEL@11_18
.BB@LABEL@11_14:	; if_then_bb122
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 419
	bf a.2, $.BB@LABEL@11_16
.BB@LABEL@11_15:	; if_then_bb122.if_break_bb_crit_edge
	mov a, #0x4B
	br $.BB@LABEL@11_17
.BB@LABEL@11_16:	; if_else_bb131
	mov a, #0xC3
.BB@LABEL@11_17:	; if_break_bb
	mov !LOWW(_g_in_data_pkt@5), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 423
	mov c, !LOWW(_g_in_data_pkt_len@4)
	movw ax, #LOWW(_g_in_data_pkt@5)
	call !!_swusb_xmit_data_pkt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 424
	mov !LOWW(_g_xact_state@1), #0x03
	br $!.BB@LABEL@11_50
.BB@LABEL@11_18:	; if_else_bb133
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 425
	bf a.3, $.BB@LABEL@11_21
.BB@LABEL@11_19:	; if_then_bb141
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 427
	mov a, #0x1E
.BB@LABEL@11_20:	; if_then_bb141
	call !!_swusb_xmit_handshake_pkt
	br $!.BB@LABEL@11_47
.BB@LABEL@11_21:	; if_else_bb142
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 431
	mov a, #0x5A
	br $.BB@LABEL@11_20
.BB@LABEL@11_22:	; if_else_bb151
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 444
	mov a, !LOWW(_g_xact_state@1)
	cmp a, #0x01
	bnz $.BB@LABEL@11_29
.BB@LABEL@11_23:	; if_then_bb157
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 447
	mov a, [sp+0x01]
	cmp a, #0xC3
	.bnz $!.BB@LABEL@11_47
.BB@LABEL@11_24:	; bb164
	mov a, [sp+0x00]
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x0003
	.bc $!.BB@LABEL@11_47
.BB@LABEL@11_25:	; if_then_bb178
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 449
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	.bnc $!.BB@LABEL@11_45
.BB@LABEL@11_26:	; if_then_bb185
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 453
	mov a, #0xD2
	call !!_swusb_xmit_handshake_pkt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 461
	mov a, [sp+0x02]
	mov !LOWW(_g_setup_data@3), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 462
	mov a, [sp+0x03]
	mov !LOWW(_g_setup_data@3+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 463
	mov a, [sp+0x04]
	mov !LOWW(_g_setup_data@3+0x00002), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 464
	mov a, [sp+0x05]
	mov !LOWW(_g_setup_data@3+0x00003), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 465
	mov a, [sp+0x06]
	mov !LOWW(_g_setup_data@3+0x00004), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 466
	mov a, [sp+0x08]
	mov !LOWW(_g_setup_data@3+0x00005), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 467
	mov a, [sp+0x09]
	cmp0 a
	skz
.BB@LABEL@11_27:	; if_then_bb214
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 468
	mov !LOWW(_g_setup_data@3+0x00005), #0xFF
.BB@LABEL@11_28:	; if_break_bb215
	mov a, #0x14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 473
	or a, !LOWW(_g_field@8)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 474
	clr1 a.3
	mov !LOWW(_g_field@8), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 475
	clrb !LOWW(_g_in_data_pkt_len@4)
	br $!.BB@LABEL@11_47
.BB@LABEL@11_29:	; if_else_bb228
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 486
	cmp a, #0x02
	bnz $.BB@LABEL@11_35
.BB@LABEL@11_30:	; if_then_bb234
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 488
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x0003
	.bc $!.BB@LABEL@11_47
.BB@LABEL@11_31:	; if_then_bb241
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 489
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	bnc $.BB@LABEL@11_45
.BB@LABEL@11_32:	; if_then_bb248
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 490
	mov a, [sp+0x01]
	cmp a, #0x4B
	bz $.BB@LABEL@11_34
.BB@LABEL@11_33:	; if_else_bb260
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 496
	mov a, [sp+0x01]
	cmp a, #0xC3
	bnz $.BB@LABEL@11_47
.BB@LABEL@11_34:	; if_then_bb268
	mov a, #0xD2
	call !!_swusb_xmit_handshake_pkt
	clr1 !LOWW(_g_field@8).1
	br $.BB@LABEL@11_47
.BB@LABEL@11_35:	; if_else_bb277
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 512
	cmp a, #0x03
	bnz $.BB@LABEL@11_47
.BB@LABEL@11_36:	; if_then_bb283
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 515
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x0001
	bnz $.BB@LABEL@11_47
.BB@LABEL@11_37:	; bb289
	mov a, [sp+0x01]
	cmp a, #0xD2
	bnz $.BB@LABEL@11_47
.BB@LABEL@11_38:	; if_then_bb304
	mov a, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 517
	xor a, !LOWW(_g_field@8)
	mov b, a
	mov !LOWW(_g_field@8), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 518
	mov a, !LOWW(_g_in_data_pkt_len@4)
	shrw ax, 8+0x00000
	cmpw ax, #0x000B
	bnc $.BB@LABEL@11_40
.BB@LABEL@11_39:	; if_then_bb320
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 520
	set1 a.3
	mov b, a
	mov !LOWW(_g_field@8), a
.BB@LABEL@11_40:	; if_break_bb324
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 522
	clrb !LOWW(_g_in_data_pkt_len@4)
	mov a, b
	bf a.5, $.BB@LABEL@11_47
.BB@LABEL@11_41:	; if_then_bb332
	mov a, #0x7F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 526
	and a, !LOWW(_g_setup_data@3+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 527
	call $!_device_set_address@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 528
	clr1 !LOWW(_g_field@8).5
	br $.BB@LABEL@11_47
.BB@LABEL@11_42:	; if_else_bb349
	mov a, [sp+0x00]
	mov x, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 543
	add a, #0x7E
	cmp a, #0x02
	bnc $.BB@LABEL@11_48
.BB@LABEL@11_43:	; if_then_bb367
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 544
	mov a, !LOWW(_g_xact_state@1)
	cmp a, #0x01
	bz $.BB@LABEL@11_45
.BB@LABEL@11_44:	; if_then_bb367
	cmp a, #0x02
	bnz $.BB@LABEL@11_47
.BB@LABEL@11_45:	; if_then_bb385
	mov es, #0x00
	mov a, es:!0xF70A
	shrw ax, 8+0x00000
	clrb a
	xch a, x
	and a, #0xC0
	xch a, x
	cmpw ax, #0x0040
	sknz
.BB@LABEL@11_46:	; if_then_bb.i34
	set1 !LOWW(_g_field@8).0
.BB@LABEL@11_47:	; if_break_bb386
	clrb !LOWW(_g_xact_state@1)
	br $.BB@LABEL@11_50
.BB@LABEL@11_48:	; if_else_bb387
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 553
	inc x
	sknz
.BB@LABEL@11_49:	; if_then_bb393
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 555
	call $!_device_reset@1
.BB@LABEL@11_50:	; if_else_bb394
	addw sp, #0x0C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 561
	ret
.LFE11:
	.TYPE _crc16_calc@1,function,.LFE12-_crc16_calc@1
_crc16_calc@1:
	.STACK _crc16_calc@1 = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 563
	push bc
	movw de, ax
	movw hl, #0xFFFF
	br $.BB@LABEL@12_2
.BB@LABEL@12_1:	; bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 569
	mov a, [de]
	shrw ax, 8+0x00000
	movw bc, ax
	movw ax, hl
	clrb a
	xor a, b
	xch a, x
	xor a, c
	xch a, x
	movw bc, ax
	shlw bc, 0x01
	movw ax, SMRLW(_g_crc_tbl_swap)[bc]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 570
	xch a, x
	movw bc, ax
	movw ax, hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 571
	shrw ax, 0x08
	xor a, b
	xch a, x
	xor a, c
	xch a, x
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 569
	incw de
.BB@LABEL@12_2:	; bb24
	mov a, [sp+0x00]
	mov x, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 568
	dec a
	mov [sp+0x00], a
	cmp0 x
	bnz $.BB@LABEL@12_1
.BB@LABEL@12_3:	; bb31
	movw ax, #0xFFFF
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 573
	subw ax, hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 574
	pop bc
	ret
.LFE12:
	.TYPE _memcpy_param_core@1,function,.LFE13-_memcpy_param_core@1
_memcpy_param_core@1:
	.STACK _memcpy_param_core@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 578
	movw hl, ax
	br $.BB@LABEL@13_2
.BB@LABEL@13_1:	; bb
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 581
	mov es, a
	mov a, es:[de]
	mov [hl], a
	incw de
	incw hl
.BB@LABEL@13_2:	; bb15
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 580
	dec b
	cmp0 a
	bnz $.BB@LABEL@13_1
.BB@LABEL@13_3:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 583
	ret
.LFE13:
	.TYPE _decode_string_param_core@1,function,.LFE14-_decode_string_param_core@1
_decode_string_param_core@1:
	.STACK _decode_string_param_core@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 587
	br $.BB@LABEL@14_2
.BB@LABEL@14_1:	; bb
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 590
	mov es, a
	mov a, es:[de]
	mov [hl], a
	incw de
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 591
	mov [hl+0x01], #0x00
	movw ax, hl
	addw ax, #0x0002
.BB@LABEL@14_2:	; bb
	movw hl, ax
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 589
	dec b
	cmp0 a
	bnz $.BB@LABEL@14_1
.BB@LABEL@14_3:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 593
	ret
.LFE14:
	.TYPE _make_string_index@1,function,.LFE15-_make_string_index@1
_make_string_index@1:
	.STACK _make_string_index@1 = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 596
	push hl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 598
	mov es, #0x00
	movw bc, #0x0100
	movw hl, es:!0xF73C
	br $.BB@LABEL@15_2
.BB@LABEL@15_1:	; bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 603
	mov a, e
	add b, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 604
	inc c
	movw ax, hl
	shrw ax, 0x01
	movw hl, ax
.BB@LABEL@15_2:	; bb16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 602
	movw ax, hl
	shlw ax, 0x0F
	shrw ax, 0x0F
	movw de, ax
	mov a, [sp+0x00]
	cmp c, a
	bc $.BB@LABEL@15_1
.BB@LABEL@15_3:	; bb23
	movw ax, de
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 606
	or a, x
	clrb a
	sknz
.BB@LABEL@15_4:	; bb23
	mov b, a
.BB@LABEL@15_5:	; bb23
	mov a, b
	pop bc
	ret
.LFE15:
	.TYPE _make_i_alternate_mode_string@1,function,.LFE16-_make_i_alternate_mode_string@1
_make_i_alternate_mode_string@1:
	.STACK _make_i_alternate_mode_string@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 613
	add a, #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 615
	call $!_make_string_index@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 616
	ret
.LFE16:
	.TYPE _get_max_string_index@1,function,.LFE17-_get_max_string_index@1
_get_max_string_index@1:
	.STACK _get_max_string_index@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 621
	mov es, #0x00
	mov d, #0x00
	movw ax, es:!0xF73C
	br $.BB@LABEL@17_2
.BB@LABEL@17_1:	; bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 627
	inc d
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 626
	decw ax
	and a, b
	xch a, x
	and a, c
	xch a, x
.BB@LABEL@17_2:	; bb9
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 625
	cmpw ax, #0x0000
	bnz $.BB@LABEL@17_1
.BB@LABEL@17_3:	; bb13
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 630
	mov a, d
	ret
.LFE17:
	.TYPE _make_bm_attributes@1,function,.LFE18-_make_bm_attributes@1
_make_bm_attributes@1:
	.STACK _make_bm_attributes@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 635
	mov es, #0x00
	mov a, es:!0xF70A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 636
	shrw ax, 8+0x00000
	shrw ax, 0x01
	mov a, #0xC0
	skc
.BB@LABEL@18_1:	; entry
	mov a, #0x80
.BB@LABEL@18_2:	; entry
	ret
.LFE18:
	.TYPE _make_vconn_power_field@1,function,.LFE19-_make_vconn_power_field@1
_make_vconn_power_field@1:
	.STACK _make_vconn_power_field@1 = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 640
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 642
	mov es, #0x00
	mov a, es:!0xF71E
	mov [sp+0x00], a
	mov x, a
	mov a, [sp+0x00]
	xch a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 643
	and a, #0x80
	xch a, x
	and a, #0x7F
	xch a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 644
	pop bc
	ret
.LFE19:
	.TYPE _make_in_data_bos_and_container_id@1,function,.LFE20-_make_in_data_bos_and_container_id@1
_make_in_data_bos_and_container_id@1:
	.STACK _make_in_data_bos_and_container_id@1 = 18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 648
	subw sp, #0x0E
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 650
	cmp0 c
	bz $.BB@LABEL@20_5
.BB@LABEL@20_1:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@20_6
.BB@LABEL@20_2:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@20_7
.BB@LABEL@20_3:	; entry
	dec c
	bnz $.BB@LABEL@20_10
.BB@LABEL@20_4:	; switch_clause_bb59
	movw ax, #0xF71B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 678
	movw [sp+0x06], ax
	mov [sp+0x08], #0x00
	movw ax, [sp+0x06]
	movw de, ax
	movw ax, hl
	movw bc, #0x0100
	call $!_memcpy_param_core@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 679
	oneb a
	br $.BB@LABEL@20_11
.BB@LABEL@20_5:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 653
	mov es, #0x00
	mov a, es:!0xF71C
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 656
	mov [hl+0x00], #0x05
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 657
	mov [hl+0x01], #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 654
	shrw ax, 8+0x00000
	movw bc, ax
	shlw ax, 0x03
	movw de, ax
	shlw bc, 0x02
	movw ax, bc
	addw ax, de
	addw ax, #0x0045
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 658
	mov a, x
	mov [hl+0x02], a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 659
	mov [hl+0x03], a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 660
	add a, #0x02
	mov [hl+0x04], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 662
	mov [hl+0x05], #0x14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 663
	mov [hl+0x06], #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 664
	mov [hl+0x07], #0x04
	br $.BB@LABEL@20_9
.BB@LABEL@20_6:	; switch_clause_bb43
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 669
	mov [hl+0x00], #0x00
	movw ax, #0xF70C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 670
	movw [sp+0x02], ax
	mov [sp+0x04], #0x00
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, hl
	incw ax
	mov b, #0x07
	br $.BB@LABEL@20_8
.BB@LABEL@20_7:	; switch_clause_bb51
	movw ax, #0xF713
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 674
	movw [sp+0x0A], ax
	mov [sp+0x0C], #0x00
	movw ax, [sp+0x0A]
	movw de, ax
	movw ax, hl
	mov b, #0x08
.BB@LABEL@20_8:	; switch_clause_bb51
	clrb c
	call $!_memcpy_param_core@1
.BB@LABEL@20_9:	; switch_clause_bb51
	mov a, #0x08
	br $.BB@LABEL@20_11
.BB@LABEL@20_10:	; bb68
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 684
	clrb a
.BB@LABEL@20_11:	; bb68
	addw sp, #0x0E
	ret
.LFE20:
	.TYPE _make_in_data_billboard_capability@1,function,.LFE21-_make_in_data_billboard_capability@1
_make_in_data_billboard_capability@1:
	.STACK _make_in_data_billboard_capability@1 = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 688
	push ax
	push hl
	movw de, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 690
	cmp0 c
	bz $.BB@LABEL@21_9
.BB@LABEL@21_1:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@21_10
.BB@LABEL@21_2:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@21_11
.BB@LABEL@21_3:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@21_11
.BB@LABEL@21_4:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@21_11
.BB@LABEL@21_5:	; entry
	dec c
	cmp0 c
	bz $.BB@LABEL@21_13
.BB@LABEL@21_6:	; entry
	dec c
	cmp0 c
	.bz $!.BB@LABEL@21_14
.BB@LABEL@21_7:	; entry
	dec c
	.bz $!.BB@LABEL@21_21
.BB@LABEL@21_8:	; entry.bb157_crit_edge
	clrb a
	br $!.BB@LABEL@21_16
.BB@LABEL@21_9:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 694
	mov es, #0x00
	mov a, es:!0xF71C
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 696
	shl a, 0x02
	add a, #0x2C
	mov [de], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 697
	mov [de+0x01], #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 698
	mov [de+0x02], #0x0D
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 699
	mov a, #0x05
	call $!_make_string_index@1
	mov b, a
	movw ax, [sp+0x02]
	movw de, ax
	mov a, b
	mov [de+0x03], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 694
	mov es, #0x00
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 700
	mov [de+0x04], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 701
	mov a, es:!0xF71D
	mov [de+0x05], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 702
	call $!_make_vconn_power_field@1
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 703
	mov a, x
	mov b, a
	movw ax, [sp+0x02]
	movw de, ax
	mov a, b
	mov [de+0x06], a
	movw ax, hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 704
	br $!.BB@LABEL@21_19
.BB@LABEL@21_10:	; switch_clause_bb44
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 709
	mov a, !LOWW(_g_bbc_configured@6)
	mov [de], a
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 710
	incw ax
	movw de, #0x0007
	br $.BB@LABEL@21_12
.BB@LABEL@21_11:	; switch_clause_bb62
	movw ax, de
	movw de, #0x0008
.BB@LABEL@21_12:	; switch_clause_bb62
	clrw bc
	call !!_memset
	br $.BB@LABEL@21_20
.BB@LABEL@21_13:	; switch_clause_bb67
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 728
	mov [de+0x00], #0x21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 729
	mov [de+0x01], #0x01
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 730
	mov a, !LOWW(_g_bbc_additional_failure_info@7)
	mov [de+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 731
	mov [de+0x03], #0x00
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 732
	mov es, #0x00
	movw ax, es:!0xF720
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 733
	mov a, x
	mov [de+0x04], a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 734
	mov [de+0x05], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 735
	mov a, es:!0xF728
	mov [de+0x06], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 736
	clrb a
	br $.BB@LABEL@21_18
.BB@LABEL@21_14:	; switch_clause_bb95
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 743
	mov es, #0x00
	movw ax, es:!0xF722
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 744
	mov a, x
	mov [de], a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 745
	mov [de+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 746
	mov a, es:!0xF729
	mov [de+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 747
	oneb a
	call $!_make_i_alternate_mode_string@1
	mov b, a
	movw ax, [sp+0x02]
	movw de, ax
	mov a, b
	mov [de+0x03], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 743
	mov es, #0x00
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 748
	cmp es:!0xF71C, #0x02
	bnz $.BB@LABEL@21_17
.BB@LABEL@21_15:	; switch_clause_bb95.bb157_crit_edge
	mov a, #0x04
.BB@LABEL@21_16:	; bb157
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 773
	ret
.BB@LABEL@21_17:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 751
	movw ax, es:!0xF724
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 752
	mov a, x
	mov [de+0x04], a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 753
	mov [de+0x05], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 754
	mov a, es:!0xF72A
	mov [de+0x06], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 755
	mov a, #0x02
.BB@LABEL@21_18:	; if_break_bb
	call $!_make_i_alternate_mode_string@1
	mov b, a
	movw ax, [sp+0x02]
	movw de, ax
	mov a, b
.BB@LABEL@21_19:	; if_break_bb
	mov [de+0x07], a
.BB@LABEL@21_20:	; if_break_bb
	mov a, #0x08
	br $.BB@LABEL@21_16
.BB@LABEL@21_21:	; switch_clause_bb136
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 762
	mov es, #0x00
	movw ax, es:!0xF726
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 763
	mov a, x
	mov [de], a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 764
	mov [de+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 765
	mov a, es:!0xF72B
	mov [de+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 766
	mov a, #0x03
	call $!_make_i_alternate_mode_string@1
	mov b, a
	movw ax, [sp+0x02]
	movw de, ax
	mov a, b
	mov [de+0x03], a
	br $.BB@LABEL@21_15
.LFE21:
	.TYPE _make_in_data_billboard_alternate_mode_capability@1,function,.LFE22-_make_in_data_billboard_alternate_mode_capability@1
_make_in_data_billboard_alternate_mode_capability@1:
	.STACK _make_in_data_billboard_alternate_mode_capability@1 = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 778
	subw sp, #0x04
	push ax
	movw de, ax
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 790
	mov [de+0x03], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 787
	mov [de+0x00], #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 788
	mov [de+0x01], #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 789
	mov [de+0x02], #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 791
	mov x, #0x04
	mulu x
	addw ax, #SMRLW(_vdo_param_ptr@11@make_in_data_billboard_alternate_mode_capability@1)
	movw de, ax
	addw ax, #0x0002
	movw hl, ax
	movw ax, [de]
	movw [sp+0x02], ax
	mov a, [hl]
	mov [sp+0x04], a
	mov c, a
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, [sp+0x00]
	addw ax, #0x0004
	mov b, #0x04
	call $!_memcpy_param_core@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 793
	mov a, #0x08
	addw sp, #0x06
	ret
.LFE22:
	.TYPE _make_in_data@1,function,.LFE23-_make_in_data@1
_make_in_data@1:
	.STACK _make_in_data@1 = 30
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 799
	subw sp, #0x1A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 804
	mov a, !LOWW(_g_transfer_state@9)
	mov c, a
	dec a
	cmp a, #0x02
	bc $.BB@LABEL@23_15
.BB@LABEL@23_1:	; entry
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@23_16
.BB@LABEL@23_2:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@23_17
.BB@LABEL@23_3:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_18
.BB@LABEL@23_4:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_19
.BB@LABEL@23_5:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_22
.BB@LABEL@23_6:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_23
.BB@LABEL@23_7:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_24
.BB@LABEL@23_8:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_35
.BB@LABEL@23_9:	; entry
	dec a
	cmp a, #0x0A
	.bc $!.BB@LABEL@23_38
.BB@LABEL@23_10:	; entry
	add a, #0xF6
	cmp0 a
	.bz $!.BB@LABEL@23_50
.BB@LABEL@23_11:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@23_54
.BB@LABEL@23_12:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@23_14
.BB@LABEL@23_13:	; entry
	dec a
	.bnz $!.BB@LABEL@23_62
.BB@LABEL@23_14:	; switch_clause_bb318
	clrb !LOWW(_g_in_data_pkt@5+0x00001)
	br $!.BB@LABEL@23_55
.BB@LABEL@23_15:	; entry.bb321_crit_edge
	clrb a
	mov [sp+0x02], a
	br $!.BB@LABEL@23_57
.BB@LABEL@23_16:	; switch_clause_bb18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 815
	mov !LOWW(_g_transfer_state@9), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 817
	mov !LOWW(_g_in_data_pkt@5+0x00001), #0x12
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 818
	oneb !LOWW(_g_in_data_pkt@5+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 819
	oneb !LOWW(_g_in_data_pkt@5+0x00003)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 820
	mov !LOWW(_g_in_data_pkt@5+0x00004), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 821
	mov !LOWW(_g_in_data_pkt@5+0x00005), #0x11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 822
	clrb !LOWW(_g_in_data_pkt@5+0x00006)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 823
	clrb !LOWW(_g_in_data_pkt@5+0x00007)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 824
	mov !LOWW(_g_in_data_pkt@5+0x00008), #0x08
	br $.BB@LABEL@23_21
.BB@LABEL@23_17:	; switch_clause_bb19
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 831
	mov !LOWW(_g_transfer_state@9), #0x05
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 832
	mov es, #0x00
	movw ax, es:!0xF704
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 833
	mov a, x
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 834
	mov !LOWW(_g_in_data_pkt@5+0x00002), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 835
	movw ax, es:!0xF706
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 836
	mov a, x
	mov !LOWW(_g_in_data_pkt@5+0x00003), a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 837
	mov !LOWW(_g_in_data_pkt@5+0x00004), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 838
	movw ax, es:!0xF708
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 839
	mov a, x
	mov !LOWW(_g_in_data_pkt@5+0x00005), a
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 840
	mov !LOWW(_g_in_data_pkt@5+0x00006), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 841
	clrb a
	call $!_make_string_index@1
	mov !LOWW(_g_in_data_pkt@5+0x00007), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 842
	oneb a
	call $!_make_string_index@1
	br $.BB@LABEL@23_20
.BB@LABEL@23_18:	; switch_clause_bb43
	mov [sp+0x02], #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 848
	mov a, #0x02
	call $!_make_string_index@1
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 849
	oneb !LOWW(_g_in_data_pkt@5+0x00002)
	br $!.BB@LABEL@23_57
.BB@LABEL@23_19:	; switch_clause_bb45
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 855
	mov !LOWW(_g_transfer_state@9), #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 857
	mov !LOWW(_g_in_data_pkt@5+0x00001), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 858
	mov !LOWW(_g_in_data_pkt@5+0x00002), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 859
	mov !LOWW(_g_in_data_pkt@5+0x00003), #0x12
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 860
	clrb !LOWW(_g_in_data_pkt@5+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 861
	oneb !LOWW(_g_in_data_pkt@5+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 862
	oneb !LOWW(_g_in_data_pkt@5+0x00006)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 863
	mov a, #0x03
	call $!_make_string_index@1
	mov !LOWW(_g_in_data_pkt@5+0x00007), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 864
	call $!_make_bm_attributes@1
.BB@LABEL@23_20:	; switch_clause_bb45
	mov !LOWW(_g_in_data_pkt@5+0x00008), a
.BB@LABEL@23_21:	; switch_clause_bb45
	mov [sp+0x02], #0x08
	br $!.BB@LABEL@23_57
.BB@LABEL@23_22:	; switch_clause_bb48
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 869
	mov !LOWW(_g_transfer_state@9), #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 870
	mov es, #0x00
	mov a, es:!0xF70B
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 872
	mov !LOWW(_g_in_data_pkt@5+0x00002), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 873
	mov !LOWW(_g_in_data_pkt@5+0x00003), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 874
	clrb !LOWW(_g_in_data_pkt@5+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 875
	clrb !LOWW(_g_in_data_pkt@5+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 876
	clrb !LOWW(_g_in_data_pkt@5+0x00006)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 877
	mov !LOWW(_g_in_data_pkt@5+0x00007), #0x11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 878
	clrb !LOWW(_g_in_data_pkt@5+0x00008)
	br $.BB@LABEL@23_21
.BB@LABEL@23_23:	; switch_clause_bb50
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 883
	clrb !LOWW(_g_in_data_pkt@5+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 884
	mov a, #0x04
	call $!_make_string_index@1
	mov !LOWW(_g_in_data_pkt@5+0x00002), a
	br $!.BB@LABEL@23_56
.BB@LABEL@23_24:	; switch_clause_bb52
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 891
	mov es, #0x00
	mov a, es:!0xF71C
	mov [sp+0x04], a
	clrb a
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 895
	mov a, !LOWW(_g_transferred_packet_num@10)
	shl a, 0x03
	mov [sp+0x03], a
.BB@LABEL@23_25:	; bb58
	mov a, [sp+0x03]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 910
	shrw ax, 8+0x00000
	cmpw ax, #0x0019
	bnc $.BB@LABEL@23_27
.BB@LABEL@23_26:	; if_then_bb
	mov a, [sp+0x03]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 912
	shr a, 0x03
	mov c, a
	movw ax, sp
	addw ax, #0x0012
	call $!_make_in_data_bos_and_container_id@1
	mov x, a
	mov a, [sp+0x03]
	mov [sp+0x01], a
	br $.BB@LABEL@23_32
.BB@LABEL@23_27:	; if_else_bb
	mov a, [sp+0x04]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 913
	mov x, #0x04
	mulu x
	addw ax, #0x002C
	movw bc, ax
	mov a, [sp+0x03]
	add a, #0xE7
	mov [sp+0x01], a
	shrw ax, 8+0x00000
	cmpw ax, bc
	bnc $.BB@LABEL@23_29
.BB@LABEL@23_28:	; if_then_bb86
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 917
	shr a, 0x03
	mov c, a
	movw ax, sp
	addw ax, #0x0012
	call $!_make_in_data_billboard_capability@1
	br $.BB@LABEL@23_31
.BB@LABEL@23_29:	; if_else_bb93
	mov a, [sp+0x04]
	mov b, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 919
	mov x, #0x08
	mulu x
	movw de, ax
	mov a, [sp+0x01]
	mov x, a
	mov a, b
	shl a, 0x02
	add a, #0x2C
	sub x, a
	mov a, x
	mov [sp+0x01], a
	shrw ax, 8+0x00000
	cmpw ax, de
	.bnc $!.BB@LABEL@23_49
.BB@LABEL@23_30:	; if_then_bb113
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 923
	shr a, 0x03
	mov c, a
	movw ax, sp
	addw ax, #0x0012
	call $!_make_in_data_billboard_alternate_mode_capability@1
.BB@LABEL@23_31:	; if_then_bb113
	mov x, a
.BB@LABEL@23_32:	; if_break_bb123
	movw hl, sp
	mov a, #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 932
	sub a, [hl+0x02]
	mov b, a
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 931
	and a, #0x07
	sub x, a
	mov a, x
	mov [hl], a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 933
	cmp x, a
	sknh
.BB@LABEL@23_33:	; if_then_bb142
	mov [hl], a
.BB@LABEL@23_34:	; if_break_bb144
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 935
	shrw ax, 8+0x00000
	shlw ax, 0x0D
	shrw ax, 0x0D
	movw bc, ax
	mov a, [hl]
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, hl
	addw ax, #0x0012
	addw ax, bc
	movw bc, ax
	mov a, [sp+0x02]
	shrw ax, 8+0x00000
	addw ax, #LOWW(_g_in_data_pkt@5+0x00001)
	call !!_memcpy
	mov a, [sp+0x03]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 936
	add a, x
	mov [sp+0x03], a
	mov a, [sp+0x02]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 937
	add a, x
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 903
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	.bc $!.BB@LABEL@23_25, $!.BB@LABEL@23_49
.BB@LABEL@23_35:	; switch_clause_bb178
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 948
	mov es, #0x00
	movw ax, es:!0xF73C
	or a, x
	bz $.BB@LABEL@23_37
.BB@LABEL@23_36:	; if_then_bb183
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 949
	mov !LOWW(_g_in_data_pkt@5+0x00001), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 950
	mov !LOWW(_g_in_data_pkt@5+0x00002), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 951
	mov !LOWW(_g_in_data_pkt@5+0x00003), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 952
	mov !LOWW(_g_in_data_pkt@5+0x00004), #0x04
	mov [sp+0x02], #0x04
	br $!.BB@LABEL@23_57
.BB@LABEL@23_37:	; if_else_bb184
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 956
	mov !LOWW(_g_in_data_pkt@5+0x00001), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 957
	mov !LOWW(_g_in_data_pkt@5+0x00002), #0x03
	br $!.BB@LABEL@23_56
.BB@LABEL@23_38:	; switch_clause_bb186
	movw ax, #0xF73E
	movw de, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 975
	movw [sp+0x06], ax
	oneb b
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 974
	add a, #0xF6
	mov c, a
	mov es, #0x00
	br $.BB@LABEL@23_40
.BB@LABEL@23_39:	; bb193
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 980
	shrw ax, 8+0x00000
	addw ax, de
	incw ax
	movw de, ax
	mov a, x
	mov [sp+0x06], a
	movw ax, de
	mov [sp+0x07], a
	inc b
.BB@LABEL@23_40:	; bb193
	mov [sp+0x08], #0x00
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 979
	cmp b, a
	mov a, es:[de]
	bc $.BB@LABEL@23_39
.BB@LABEL@23_41:	; bb220
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 984
	mov a, !LOWW(_g_transferred_packet_num@10)
	cmp0 a
	bnz $.BB@LABEL@23_45
.BB@LABEL@23_42:	; if_then_bb232
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 986
	add a, a
	add a, #0x02
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 987
	mov !LOWW(_g_in_data_pkt@5+0x00002), #0x03
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 988
	shrw ax, 8+0x00000
	cmpw ax, #0x0004
	skc
.BB@LABEL@23_43:	; if_then_bb243
	mov [sp+0x00], #0x03
.BB@LABEL@23_44:	; if_break_bb244
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 989
	movw ax, [sp+0x06]
	incw ax
	movw [sp+0x0A], ax
	mov a, [sp+0x08]
	mov c, a
	mov [sp+0x0C], a
	mov a, [sp+0x00]
	mov b, a
	movw ax, [sp+0x0A]
	movw de, ax
	movw ax, #LOWW(_g_in_data_pkt@5+0x00003)
	call $!_decode_string_param_core@1
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 990
	add a, a
	add a, #0x02
	br $.BB@LABEL@23_48
.BB@LABEL@23_45:	; if_else_bb258
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 993
	shl a, 0x02
	dec a
	mov d, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 994
	sub a, d
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 995
	shrw ax, 8+0x00000
	cmpw ax, #0x0005
	skc
.BB@LABEL@23_46:	; if_then_bb275
	mov [sp+0x00], #0x04
.BB@LABEL@23_47:	; if_break_bb276
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 996
	movw ax, [sp+0x06]
	movw bc, ax
	mov a, d
	shrw ax, 8+0x00000
	addw ax, bc
	incw ax
	movw [sp+0x0E], ax
	mov a, [sp+0x08]
	mov c, a
	mov [sp+0x10], a
	mov a, [sp+0x00]
	mov b, a
	movw ax, [sp+0x0E]
	movw de, ax
	movw ax, #LOWW(_g_in_data_pkt@5+0x00001)
	call $!_decode_string_param_core@1
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 997
	add a, a
.BB@LABEL@23_48:	; if_break_bb276
	mov [sp+0x02], a
.BB@LABEL@23_49:	; if_break_bb294
	inc !LOWW(_g_transferred_packet_num@10)
	br $.BB@LABEL@23_57
.BB@LABEL@23_50:	; switch_clause_bb297
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1008
	movw hl, #LOWW(_g_field@8)
	bf [hl].6, $.BB@LABEL@23_52
.BB@LABEL@23_51:	; switch_clause_bb297.bb307_crit_edge
	oneb a
	br $.BB@LABEL@23_53
.BB@LABEL@23_52:	; bb305
	clrb a
.BB@LABEL@23_53:	; bb307
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
	oneb a
	mov [sp+0x02], a
	br $.BB@LABEL@23_57
.BB@LABEL@23_54:	; switch_clause_bb311
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1015
	mov a, !LOWW(_g_field@8)
	shr a, 0x07
	mov !LOWW(_g_in_data_pkt@5+0x00001), a
.BB@LABEL@23_55:	; switch_clause_bb318
	clrb !LOWW(_g_in_data_pkt@5+0x00002)
.BB@LABEL@23_56:	; switch_clause_bb318
	mov [sp+0x02], #0x02
.BB@LABEL@23_57:	; bb321
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1041
	mov x, !LOWW(_g_setup_data@3+0x00005)
	mov a, [sp+0x02]
	cmp a, x
	bnh $.BB@LABEL@23_59
.BB@LABEL@23_58:	; if_then_bb329
	mov a, x
	mov [sp+0x02], a
.BB@LABEL@23_59:	; if_break_bb331
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1043
	mov x, !LOWW(_g_setup_data@3+0x00005)
	sub x, a
	mov a, x
	mov !LOWW(_g_setup_data@3+0x00005), a
	mov a, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1046
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	sknc
.BB@LABEL@23_60:	; if_then_bb343
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1047
	clrb !LOWW(_g_transfer_state@9)
.BB@LABEL@23_61:	; if_break_bb344
	mov a, [sp+0x02]
	mov c, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1051
	movw ax, #LOWW(_g_in_data_pkt@5+0x00001)
	call $!_crc16_calc@1
	movw bc, ax
	mov a, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1052
	shrw ax, 8+0x00000
	addw ax, #LOWW(_g_in_data_pkt@5+0x00001)
	movw de, ax
	mov a, c
	mov [de], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1053
	incw de
	movw ax, bc
	mov [de], a
	mov a, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1058
	add a, #0x03
	mov !LOWW(_g_in_data_pkt_len@4), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1060
	oneb a
	br $.BB@LABEL@23_63
.BB@LABEL@23_62:	; bb368
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1061
	clrb a
.BB@LABEL@23_63:	; bb368
	addw sp, #0x1A
	ret
.LFE23:
	.TYPE _request_set_address@1,function,.LFE24-_request_set_address@1
_request_set_address@1:
	.STACK _request_set_address@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1066
	set1 !LOWW(_g_field@8).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1067
	oneb !LOWW(_g_transfer_state@9)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1068
	call $!_make_in_data@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1069
	ret
.LFE24:
	.TYPE _request_set_configuration@1,function,.LFE25-_request_set_configuration@1
_request_set_configuration@1:
	.STACK _request_set_configuration@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1074
	mov a, !LOWW(_g_setup_data@3+0x00002)
	cmp0 a
	bz $.BB@LABEL@25_3
.BB@LABEL@25_1:	; entry
	dec a
	bnz $.BB@LABEL@25_5
.BB@LABEL@25_2:	; switch_clause_bb4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1080
	call $!_device_configure@1
	br $.BB@LABEL@25_4
.BB@LABEL@25_3:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1076
	call $!_device_deconfigure@1
.BB@LABEL@25_4:	; switch_clause_bb
	mov !LOWW(_g_transfer_state@9), #0x02
	call $!_make_in_data@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1085
	ret
.BB@LABEL@25_5:	; bb8
	clrb a
	ret
.LFE25:
	.TYPE _request_get_descriptor@1,function,.LFE26-_request_get_descriptor@1
_request_get_descriptor@1:
	.STACK _request_get_descriptor@1 = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1088
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1090
	mov a, !LOWW(_g_setup_data@3+0x00002)
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1092
	mov a, !LOWW(_g_setup_data@3+0x00003)
	dec a
	cmp0 a
	bz $.BB@LABEL@26_6
.BB@LABEL@26_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@26_7
.BB@LABEL@26_2:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@26_10
.BB@LABEL@26_3:	; entry
	cmp a, #0x0C
	bnz $.BB@LABEL@26_12
.BB@LABEL@26_4:	; switch_clause_bb13
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1107
	mov !LOWW(_g_transfer_state@9), #0x09
.BB@LABEL@26_5:	; switch_clause_bb13
	clrb !LOWW(_g_transferred_packet_num@10)
	br $.BB@LABEL@26_9
.BB@LABEL@26_6:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1095
	mov !LOWW(_g_transfer_state@9), #0x03
	br $.BB@LABEL@26_9
.BB@LABEL@26_7:	; switch_clause_bb6
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1099
	cmp0 a
	bnz $.BB@LABEL@26_12
.BB@LABEL@26_8:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1100
	mov !LOWW(_g_transfer_state@9), #0x06
.BB@LABEL@26_9:	; if_then_bb
	call $!_make_in_data@1
	pop bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1120
	ret
.BB@LABEL@26_10:	; switch_clause_bb16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1112
	call $!_get_max_string_index@1
	mov x, a
	mov a, [sp+0x00]
	xch a, x
	cmp x, a
	bh $.BB@LABEL@26_12
.BB@LABEL@26_11:	; if_then_bb24
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1113
	add a, #0x0A
	mov !LOWW(_g_transfer_state@9), a
	br $.BB@LABEL@26_5
.BB@LABEL@26_12:	; bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1120
	clrb a
	pop bc
	ret
.LFE26:
	.TYPE _request_get_configutarion@1,function,.LFE27-_request_get_configutarion@1
_request_get_configutarion@1:
	.STACK _request_get_configutarion@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1125
	mov !LOWW(_g_transfer_state@9), #0x15
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1126
	call $!_make_in_data@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1127
	ret
.LFE27:
	.TYPE _request_get_status_device@1,function,.LFE28-_request_get_status_device@1
_request_get_status_device@1:
	.STACK _request_get_status_device@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1132
	mov !LOWW(_g_transfer_state@9), #0x16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1133
	call $!_make_in_data@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1134
	ret
.LFE28:
	.TYPE _request_get_status_interface@1,function,.LFE29-_request_get_status_interface@1
_request_get_status_interface@1:
	.STACK _request_get_status_interface@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1139
	cmp0 !LOWW(_g_setup_data@3+0x00004)
	bnz $.BB@LABEL@29_2
.BB@LABEL@29_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1140
	mov !LOWW(_g_transfer_state@9), #0x17
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1141
	call $!_make_in_data@1
	ret
.BB@LABEL@29_2:	; bb7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1144
	clrb a
	ret
.LFE29:
	.TYPE _request_get_status_endpoint@1,function,.LFE30-_request_get_status_endpoint@1
_request_get_status_endpoint@1:
	.STACK _request_get_status_endpoint@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1149
	cmp0 !LOWW(_g_setup_data@3+0x00004)
	bnz $.BB@LABEL@30_2
.BB@LABEL@30_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1150
	mov !LOWW(_g_transfer_state@9), #0x18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1151
	call $!_make_in_data@1
	ret
.BB@LABEL@30_2:	; bb7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1154
	clrb a
	ret
.LFE30:
	.TYPE _request_dispatch@1,function,.LFE31-_request_dispatch@1
_request_dispatch@1:
	.STACK _request_dispatch@1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1160
	mov a, !LOWW(_g_setup_data@3)
	add a, #0x80
	cmp0 a
	bz $.BB@LABEL@31_8
.BB@LABEL@31_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@31_14
.BB@LABEL@31_2:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@31_16
.BB@LABEL@31_3:	; entry
	cmp a, #0x7E
	bnz $.BB@LABEL@31_18
.BB@LABEL@31_4:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1162
	mov a, !LOWW(_g_setup_data@3+0x00001)
	add a, #0xFB
	cmp0 a
	bz $.BB@LABEL@31_7
.BB@LABEL@31_5:	; switch_clause_bb
	cmp a, #0x04
	bnz $.BB@LABEL@31_18
.BB@LABEL@31_6:	; switch_clause_bb7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1166
	call $!_request_set_configuration@1
	ret
.BB@LABEL@31_7:	; switch_clause_bb5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1164
	call $!_request_set_address@1
	ret
.BB@LABEL@31_8:	; switch_clause_bb10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1171
	mov a, !LOWW(_g_setup_data@3+0x00001)
	cmp0 a
	bz $.BB@LABEL@31_13
.BB@LABEL@31_9:	; switch_clause_bb10
	add a, #0xFA
	cmp0 a
	bz $.BB@LABEL@31_12
.BB@LABEL@31_10:	; switch_clause_bb10
	cmp a, #0x02
	bnz $.BB@LABEL@31_18
.BB@LABEL@31_11:	; switch_clause_bb16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1175
	call $!_request_get_configutarion@1
	ret
.BB@LABEL@31_12:	; switch_clause_bb13
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1173
	call $!_request_get_descriptor@1
	ret
.BB@LABEL@31_13:	; switch_clause_bb19
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1177
	call $!_request_get_status_device@1
	ret
.BB@LABEL@31_14:	; switch_clause_bb23
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1182
	cmp0 !LOWW(_g_setup_data@3+0x00001)
	bnz $.BB@LABEL@31_18
.BB@LABEL@31_15:	; switch_clause_bb26
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1184
	call $!_request_get_status_interface@1
	ret
.BB@LABEL@31_16:	; switch_clause_bb30
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1189
	cmp0 !LOWW(_g_setup_data@3+0x00001)
	bnz $.BB@LABEL@31_18
.BB@LABEL@31_17:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1191
	call $!_request_get_status_endpoint@1
	ret
.BB@LABEL@31_18:	; bb40
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1196
	clrb a
	ret
.LFE31:
	.TYPE _swusb_init,function,.LFE32-_swusb_init
_swusb_init:
	.STACK _swusb_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1198
	mov a, #0x80
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1201
	or a, !LOWW(_g_field@8)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1202
	clr1 a.0
	mov !LOWW(_g_field@8), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1203
	clrb !LOWW(_g_bbc_configured@6)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1204
	clrb !LOWW(_g_bbc_additional_failure_info@7)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1207
	call !!_swusb_io_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1208
	mov a, #LOW(HIGHW(_int_dminus_handler@1))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_int_dminus_handler@1)
	mov a, #0x02
	call !!_pdc_set_int_routine
	ret
.LFE32:
	.TYPE _swusb_proc,function,.LFE33-_swusb_proc
_swusb_proc:
	.STACK _swusb_proc = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1219
	movw hl, #LOWW(_g_field@8)
	bf [hl].4, $.BB@LABEL@33_4
.BB@LABEL@33_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1220
	mov a, #0x77
	call $!_msg
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1222
	call $!_request_dispatch@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1223
	cmp0 a
	sknz
.BB@LABEL@33_2:	; if_then_bb17
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1225
	set1 !LOWW(_g_field@8).3
.BB@LABEL@33_3:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1227
	clr1 !LOWW(_g_field@8).4
	ret
.BB@LABEL@33_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1229
	cmp0 !LOWW(_g_in_data_pkt_len@4)
	bnz $.BB@LABEL@33_8
.BB@LABEL@33_5:	; bb28
	cmp0 !LOWW(_g_transfer_state@9)
	bz $.BB@LABEL@33_8
.BB@LABEL@33_6:	; if_then_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1232
	mov a, #0x72
	call $!_msg
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1233
	call $!_make_in_data@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1234
	cmp0 a
	sknz
.BB@LABEL@33_7:	; if_then_bb54
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1236
	set1 !LOWW(_g_field@8).3
.BB@LABEL@33_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1239
	ret
.LFE33:
	.TYPE _swusb_is_transferring,function,.LFE34-_swusb_is_transferring
_swusb_is_transferring:
	.STACK _swusb_is_transferring = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1243
	cmp0 !LOWW(_g_transfer_state@9)
	bnz $.BB@LABEL@34_2
.BB@LABEL@34_1:	; entry
	clrb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1244
	ret
.BB@LABEL@34_2:	; entry
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1243
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1244
	ret
.LFE34:
	.TYPE _swusb_measure_rate,function,.LFE35-_swusb_measure_rate
_swusb_measure_rate:
	.STACK _swusb_measure_rate = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1248
	set1 !LOWW(_g_field@8).0
	ret
.LFE35:
	.TYPE _swusb_enable,function,.LFE36-_swusb_enable
_swusb_enable:
	.STACK _swusb_enable = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1253
	call !!_swusb_io_is_enabled
	cmp0 a
	bnz $.BB@LABEL@36_2
.BB@LABEL@36_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1255
	call $!_device_reset@1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1258
	mov !LOWW(_g_swusb_rate_offset), #0x80
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1261
	call !!_swusb_io_enable
.BB@LABEL@36_2:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1263
	ret
.LFE36:
	.TYPE _swusb_disable,function,.LFE37-_swusb_disable
_swusb_disable:
	.STACK _swusb_disable = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1268
	call !!_swusb_io_disable
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1271
	call $!_device_reset@1
	ret
.LFE37:
	.TYPE _swusb_set_power_supply,function,.LFE38-_swusb_set_power_supply
_swusb_set_power_supply:
	.STACK _swusb_set_power_supply = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1274
	mov1 CY, a.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1276
	movw hl, #LOWW(_g_field@8)
	mov1 [hl].7, CY
	ret
.LFE38:
	.TYPE _swusb_bb_configured,function,.LFE39-_swusb_bb_configured
_swusb_bb_configured:
	.STACK _swusb_bb_configured = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1279
	push ax
	push hl
	mov b, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1281
	mov es, #0x00
	mov x, es:!0xF71C
	mov a, b
	cmp x, a
	bnh $.BB@LABEL@39_8
.BB@LABEL@39_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1283
	mov x, #0x02
	mulu x
	mov a, x
	mov [sp+0x00], a
	mov b, a
	movw ax, #0x0003
	cmp0 b
	br $.BB@LABEL@39_3
.BB@LABEL@39_2:	; if_then_bb
	addw ax, ax
	dec b
.BB@LABEL@39_3:	; if_then_bb
	bnz $.BB@LABEL@39_2
.BB@LABEL@39_4:	; if_then_bb
	mov a, x
	xor a, #0xFF
	and a, !LOWW(_g_bbc_configured@6)
	mov c, a
	mov !LOWW(_g_bbc_configured@6), a
	mov a, [sp+0x00]
	mov b, a
	mov a, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1284
	shrw ax, 8+0x00000
	shlw ax, 0x0E
	shrw ax, 0x0E
	cmp0 b
	br $.BB@LABEL@39_6
.BB@LABEL@39_5:	; if_then_bb
	addw ax, ax
	dec b
.BB@LABEL@39_6:	; if_then_bb
	bnz $.BB@LABEL@39_5
.BB@LABEL@39_7:	; if_then_bb
	mov a, x
	or a, c
	mov !LOWW(_g_bbc_configured@6), a
.BB@LABEL@39_8:	; return
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1286
	ret
.LFE39:
	.TYPE _swusb_bb_set_additional_failure_info,function,.LFE40-_swusb_bb_set_additional_failure_info
_swusb_bb_set_additional_failure_info:
	.STACK _swusb_bb_set_additional_failure_info = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1288
	mov !LOWW(_g_bbc_additional_failure_info@7), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb.c", 1290
	ret
.LFE40:
	.SECTION .data,DATA
	.TYPE _thalt,object,1
_thalt:
	.DS (1)
	.ALIGN 2
	.TYPE _tbp,object,2
_tbp:
	.DB2 0x0007
	.TYPE _tbuf,object,16
_tbuf:
	.DB 0x2D,0x2D,0x2D,0x2D,0x2D,0x23,0x23
	.DS (9)
	.SECTION .bss,BSS
	.TYPE _g_xact_state@1,object,1
_g_xact_state@1:
	.DS (1)
	.TYPE _g_expected_token@2,object,2
_g_expected_token@2:
	.DS (2)
	.TYPE _g_setup_data@3,object,6
_g_setup_data@3:
	.DS (6)
	.TYPE _g_in_data_pkt_len@4,object,1
_g_in_data_pkt_len@4:
	.DS (1)
	.TYPE _g_in_data_pkt@5,object,11
_g_in_data_pkt@5:
	.DS (11)
	.TYPE _g_swusb_rate_offset,object,1
_g_swusb_rate_offset:
	.DS (1)
	.TYPE _g_bbc_configured@6,object,1
_g_bbc_configured@6:
	.DS (1)
	.TYPE _g_bbc_additional_failure_info@7,object,1
_g_bbc_additional_failure_info@7:
	.DS (1)
	.TYPE _g_field@8,object,1
_g_field@8:
	.DS (1)
	.TYPE _g_transfer_state@9,object,1
_g_transfer_state@9:
	.DS (1)
	.TYPE _g_transferred_packet_num@10,object,1
_g_transferred_packet_num@10:
	.DS (1)
	.SECTION .const,CONST
	.ALIGN 2
	.TYPE _vdo_param_ptr@11@make_in_data_billboard_alternate_mode_capability@1,object,16
_vdo_param_ptr@11@make_in_data_billboard_alternate_mode_capability@1:
	.DB4 0x0000F72C
	.DB4 0x0000F730
	.DB4 0x0000F734
	.DB4 0x0000F738
