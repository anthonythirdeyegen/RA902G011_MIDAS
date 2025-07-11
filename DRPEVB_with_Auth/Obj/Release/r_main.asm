#CC-RL Compiler RL78 Assembler Source
#@  CC-RL Version : V1.15.00  [06 Dec 2024]
#@  Commmand :
#@   ..\..\Core\r_systeminit.c
#@   ..\..\PDC\smbm_ctrl.c
#@   ..\..\PDC\user_timer.c
#@   r_main.c
#@   R_Main_UserInit.c
#@   PDC\dcdc_ctrl.c
#@   PDC\led_ctrl.c
#@   PDC\sw_ctrl.c
#@   PDC\user_main.c
#@   PDC\user_main_authentication.c
#@   PDC\user_main_protection.c
#@   PDC\subdev\isl95338.c
#@   PDC\subdev\relamcu.c
#@   PDC\subdev\subdev_ctrl.c
#@   pd_defs.c
#@   -cpu=S3
#@   -obj_path=Obj\Release
#@   -dev=C:\Program Files (x86)\Renesas Electronics\CS+\CC\Device\RL78\Devicefile\DR9A02G011.DVF
#@   -g
#@   -Osame_code
#@   -I PDC\subdev
#@   -I PDC
#@   -I .
#@   -I ..\..\Core
#@   -I ..\..\PDC
#@   -I ..\..\PDC\Lib
#@   -D RELEASE_BUILD=1,PPS_SPRT=0
#@   -asm_path=Obj\Release
#@   -asmopt=-prn_path=Obj\Release
#@   -c
#@   -MAKEUD=Obj\Release
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_a1bd8f6515f746a38e66ad14f6afd87clhozzw5x.izr
#@  compiled at Tue May 06 10:50:44 2025

	.EXTERN _gPdc
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.EXTERN _gAmcu
	.PUBLIC _main
	.EXTERN _R_MAIN_UserInit
	.EXTERN _pdc_active
	.EXTERN _auth_pd_core
	.EXTERN _led_ctrl
	.EXTERN _sw_ctrl
	.EXTERN _user_func_event
	.EXTERN _user_func_chk_device
	.EXTERN _user_func_auth
	.EXTERN _tm_12bit_start_gtimer
	.EXTERN _pdc_get_idle_time
	.EXTERN _tm_12bit_intr_hdlr
	.EXTERN _tm_12tm_stop_gtimer
	.EXTERN _pdc_stop
	.EXTERN _pdc_run
	.EXTERN _dcdc_ctrl
	.EXTERN _subdev_ctrl
	.EXTERN _smbm_ctrl

	.SECTION .textf,TEXTF
	.TYPE _main,function,.LFE1-_main
_main:
	.STACK _main = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 72
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 75
	call !!_R_MAIN_UserInit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 78
	call !!_pdc_active
	br $!.BB@LABEL@1_17
.BB@LABEL@1_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 89
	movw ax, !LOWW(_gPdc)
	or a, x
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_2:	; bb23
	movw ax, !LOWW(_gPdc+0x00002)
	or a, x
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_3:	; bb33
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_4:	; bb44
	movw ax, !LOWW(_gDCInfo+0x00002)
	xch a, x
	and a, #0xF0
	xch a, x
	or a, x
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_5:	; bb56
	mov a, #0xF0
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_8
.BB@LABEL@1_6:	; bb69
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_7:	; bb81
	movw ax, !LOWW(_gAmcu)
	or a, x
	bz $.BB@LABEL@1_9
.BB@LABEL@1_8:	; if_then_bb93
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 96
	call !!_user_func_event
	br $.BB@LABEL@1_16
.BB@LABEL@1_9:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 99
	call !!_user_func_chk_device
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 103
	call !!_user_func_auth
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 99
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 103
	and a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 105
	dec a
	cmp0 a
	bz $.BB@LABEL@1_13
.BB@LABEL@1_10:	; if_else_bb
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@1_14
.BB@LABEL@1_11:	; if_else_bb
	cmp a, #0x04
	bnz $.BB@LABEL@1_16
.BB@LABEL@1_12:	; switch_clause_bb113
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 115
	call !!_pdc_stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 116
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 117
	stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 118
	call !!_pdc_run
	br $.BB@LABEL@1_15
.BB@LABEL@1_13:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 107
	halt
	br $.BB@LABEL@1_16
.BB@LABEL@1_14:	; switch_clause_bb108
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 110
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 111
	halt
.BB@LABEL@1_15:	; switch_clause_bb113
	call !!_tm_12tm_stop_gtimer
.BB@LABEL@1_16:	; if_break_bb119
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 125
	call !!_dcdc_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 126
	call !!_subdev_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 127
	call !!_smbm_ctrl
.BB@LABEL@1_17:	; bb120
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 80
	call !!_auth_pd_core
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 82
	call !!_led_ctrl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 83
	call !!_sw_ctrl
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 82
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 83
	and a, x
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 85
	mov a, !LOWW(_gPdc+0x00001)
	.bf a.7, $!.BB@LABEL@1_1
.BB@LABEL@1_18:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/r_main.c", 131
	pop ax
	ret
.LFE1:
