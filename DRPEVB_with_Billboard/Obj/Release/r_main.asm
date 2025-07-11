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

	.EXTERN _gPdc
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.PUBLIC _led
	.PUBLIC _main
	.EXTERN _R_MAIN_UserInit
	.EXTERN _bbc_main
	.EXTERN _pdc_active
	.EXTERN _pd_core
	.EXTERN _led_ctrl
	.EXTERN _sw_ctrl
	.EXTERN _user_func_event
	.EXTERN _user_func_chk_device
	.EXTERN _tm_12bit_start_gtimer
	.EXTERN _pdc_get_idle_time
	.EXTERN _tm_12bit_intr_hdlr
	.EXTERN _tm_12tm_stop_gtimer
	.EXTERN _pdc_stop
	.EXTERN _pdc_run
	.EXTERN _dcdc_ctrl
	.EXTERN _subdev_ctrl
	.EXTERN _smbm_ctrl
	.EXTERN _swusb_proc

	.SECTION .textf,TEXTF
	.TYPE _led,function,.LFE1-_led
_led:
	.STACK _led = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/billboard.h", 12
	mov1 CY, a.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/billboard.h", 13
	mov a, 0xFFF08
	mov1 a.2, CY
	mov 0xFFF08, a
	ret
.LFE1:
	.TYPE _main,function,.LFE2-_main
_main:
	.STACK _main = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 70
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 73
	call !!_R_MAIN_UserInit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 74
	call !!_bbc_main
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 77
	call !!_pdc_active
	br $!.BB@LABEL@2_16
.BB@LABEL@2_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 88
	movw ax, !LOWW(_gPdc)
	or a, x
	bnz $.BB@LABEL@2_7
.BB@LABEL@2_2:	; bb23
	movw ax, !LOWW(_gPdc+0x00002)
	or a, x
	bnz $.BB@LABEL@2_7
.BB@LABEL@2_3:	; bb33
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_7
.BB@LABEL@2_4:	; bb44
	movw ax, !LOWW(_gDCInfo+0x00002)
	xch a, x
	and a, #0xF0
	xch a, x
	or a, x
	bnz $.BB@LABEL@2_7
.BB@LABEL@2_5:	; bb56
	mov a, #0xF0
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@2_7
.BB@LABEL@2_6:	; bb69
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bz $.BB@LABEL@2_8
.BB@LABEL@2_7:	; if_then_bb82
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 94
	call !!_user_func_event
	br $.BB@LABEL@2_15
.BB@LABEL@2_8:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 97
	call !!_user_func_chk_device
	mov x, a
	mov a, [sp+0x00]
	and a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 102
	dec a
	cmp0 a
	bz $.BB@LABEL@2_12
.BB@LABEL@2_9:	; if_else_bb
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@2_13
.BB@LABEL@2_10:	; if_else_bb
	cmp a, #0x04
	bnz $.BB@LABEL@2_15
.BB@LABEL@2_11:	; switch_clause_bb97
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 112
	call !!_pdc_stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 113
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 114
	stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 115
	call !!_pdc_run
	br $.BB@LABEL@2_14
.BB@LABEL@2_12:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 104
	halt
	br $.BB@LABEL@2_15
.BB@LABEL@2_13:	; switch_clause_bb92
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 107
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 108
	halt
.BB@LABEL@2_14:	; switch_clause_bb97
	call !!_tm_12tm_stop_gtimer
.BB@LABEL@2_15:	; if_break_bb103
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 122
	call !!_dcdc_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 123
	call !!_subdev_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 124
	call !!_smbm_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 125
	call !!_swusb_proc
.BB@LABEL@2_16:	; bb104
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 79
	call !!_pd_core
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 81
	call !!_led_ctrl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 82
	call !!_sw_ctrl
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 81
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 82
	and a, x
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 84
	mov a, !LOWW(_gPdc+0x00001)
	.bf a.7, $!.BB@LABEL@2_1
.BB@LABEL@2_17:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/r_main.c", 129
	pop ax
	ret
.LFE2:
