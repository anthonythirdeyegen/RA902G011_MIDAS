#CC-RL Compiler RL78 Assembler Source
#@  CC-RL Version : V1.15.00  [06 Dec 2024]
#@  Commmand :
#@   ..\..\Core\r_systeminit.c
#@   ..\..\PDC\smbm_ctrl.c
#@   ..\..\PDC\user_timer.c
#@   pd_defs.c
#@   r_main.c
#@   R_Main_UserInit.c
#@   PDC\dcdc_ctrl.c
#@   PDC\led_ctrl.c
#@   PDC\sw_ctrl.c
#@   PDC\user_main.c
#@   PDC\user_main_protection.c
#@   PDC\subdev\isl95338.c
#@   PDC\subdev\subdev_ctrl.c
#@   -cpu=S3
#@   -obj_path=Obj\Release
#@   -dev=C:\Program Files (x86)\Renesas Electronics\CS+\CC\Device\RL78\Devicefile\DR9A02G011.DVF
#@   -g
#@   -Osame_code
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_4c3a7638c87f40a0a08c50a18542095edbh5bdb1.u5c
#@  compiled at Tue May 06 10:51:09 2025

	.EXTERN _gPdc
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.PUBLIC _main
	.EXTERN _R_MAIN_UserInit
	.EXTERN _pdc_active
	.EXTERN _pd_core
	.EXTERN _led_ctrl
	.EXTERN _sw_ctrl
	.EXTERN _user_func_event
	.EXTERN _user_func_chk_device
	.EXTERN _user_func_snd_attention
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 69
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 72
	call !!_R_MAIN_UserInit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 75
	call !!_pdc_active
	br $!.BB@LABEL@1_16
.BB@LABEL@1_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 86
	movw ax, !LOWW(_gPdc)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_2:	; bb23
	movw ax, !LOWW(_gPdc+0x00002)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_3:	; bb33
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_4:	; bb44
	movw ax, !LOWW(_gDCInfo+0x00002)
	xch a, x
	and a, #0xF0
	xch a, x
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_5:	; bb56
	mov a, #0xF0
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_7
.BB@LABEL@1_6:	; bb69
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bz $.BB@LABEL@1_8
.BB@LABEL@1_7:	; if_then_bb82
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 92
	call !!_user_func_event
	br $.BB@LABEL@1_15
.BB@LABEL@1_8:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 95
	call !!_user_func_chk_device
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 99
	call !!_user_func_snd_attention
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 95
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 99
	and a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 100
	dec a
	cmp0 a
	bz $.BB@LABEL@1_12
.BB@LABEL@1_9:	; if_else_bb
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@1_13
.BB@LABEL@1_10:	; if_else_bb
	cmp a, #0x04
	bnz $.BB@LABEL@1_15
.BB@LABEL@1_11:	; switch_clause_bb103
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 110
	call !!_pdc_stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 111
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 112
	stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 113
	call !!_pdc_run
	br $.BB@LABEL@1_14
.BB@LABEL@1_12:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 102
	halt
	br $.BB@LABEL@1_15
.BB@LABEL@1_13:	; switch_clause_bb98
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 105
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 106
	halt
.BB@LABEL@1_14:	; switch_clause_bb103
	call !!_tm_12tm_stop_gtimer
.BB@LABEL@1_15:	; if_break_bb109
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 120
	call !!_dcdc_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 121
	call !!_subdev_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 122
	call !!_smbm_ctrl
.BB@LABEL@1_16:	; bb110
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 77
	call !!_pd_core
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 79
	call !!_led_ctrl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 80
	call !!_sw_ctrl
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 79
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 80
	and a, x
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 82
	mov a, !LOWW(_gPdc+0x00001)
	.bf a.7, $!.BB@LABEL@1_1
.BB@LABEL@1_17:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 126
	pop ax
	ret
.LFE1:
