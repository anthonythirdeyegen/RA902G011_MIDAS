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
#@   PDC\user_main_protection.c
#@   PDC\user_main_smbs.c
#@   PDC\subdev\isl95338.c
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_e3002be62e4449b4be3cba83f694525fphcbxarf.1nx
#@  compiled at Tue May 06 10:50:51 2025

	.EXTERN _gPdc
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.PUBLIC _main
	.EXTERN _R_MAIN_UserInit
	.EXTERN _pdc_active
	.EXTERN _pd_core
	.EXTERN _smbs_core
	.EXTERN _led_ctrl
	.EXTERN _sw_ctrl
	.EXTERN _user_func_event
	.EXTERN _user_func_chk_device
	.EXTERN _user_func_smbs
	.EXTERN _smbs_is_deep_sleep
	.EXTERN _pdc_enter_deep
	.EXTERN _tm_12bit_start_gtimer
	.EXTERN _tm_12bit_intr_hdlr
	.EXTERN _tm_12tm_stop_gtimer
	.EXTERN _pdc_get_idle_time
	.EXTERN _pdc_stop
	.EXTERN _pdc_run
	.EXTERN _dcdc_ctrl
	.EXTERN _subdev_ctrl
	.EXTERN _smbm_ctrl

	.SECTION .textf,TEXTF
	.TYPE _main,function,.LFE1-_main
_main:
	.STACK _main = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 70
	subw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 73
	call !!_R_MAIN_UserInit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 76
	call !!_pdc_active
	br $!.BB@LABEL@1_18
.BB@LABEL@1_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 88
	movw ax, !LOWW(_gPdc)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_2:	; bb30
	movw ax, !LOWW(_gPdc+0x00002)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_3:	; bb40
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_4:	; bb51
	movw ax, !LOWW(_gDCInfo+0x00002)
	xch a, x
	and a, #0xF0
	xch a, x
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_5:	; bb63
	mov a, #0xF0
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_7
.BB@LABEL@1_6:	; bb76
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bz $.BB@LABEL@1_8
.BB@LABEL@1_7:	; if_then_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 94
	call !!_user_func_event
	br $.BB@LABEL@1_17
.BB@LABEL@1_8:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 97
	call !!_user_func_chk_device
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 101
	call !!_user_func_smbs
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 103
	call !!_smbs_is_deep_sleep
	movw hl, sp
	cmp0 a
	bz $.BB@LABEL@1_10
.BB@LABEL@1_9:	; if_then_bb107
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 104
	call !!_pdc_enter_deep
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 105
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	movw ax, #0x0111
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 106
	stop
	br $.BB@LABEL@1_16
.BB@LABEL@1_10:	; if_else_bb111
	mov a, [sp+0x02]
	and a, [hl+0x01]
	and a, [hl]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 110
	dec a
	cmp0 a
	bz $.BB@LABEL@1_14
.BB@LABEL@1_11:	; if_else_bb111
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@1_15
.BB@LABEL@1_12:	; if_else_bb111
	cmp a, #0x04
	bnz $.BB@LABEL@1_17
.BB@LABEL@1_13:	; switch_clause_bb119
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 120
	call !!_pdc_stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 121
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 122
	stop
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 123
	call !!_pdc_run
	br $.BB@LABEL@1_16
.BB@LABEL@1_14:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 112
	halt
	br $.BB@LABEL@1_17
.BB@LABEL@1_15:	; switch_clause_bb114
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 115
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 116
	halt
.BB@LABEL@1_16:	; switch_clause_bb119
	call !!_tm_12tm_stop_gtimer
.BB@LABEL@1_17:	; if_break_bb126
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 131
	call !!_dcdc_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 132
	call !!_subdev_ctrl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 133
	call !!_smbm_ctrl
.BB@LABEL@1_18:	; bb127
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 78
	call !!_pd_core
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 79
	call !!_smbs_core
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 81
	call !!_led_ctrl
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 82
	call !!_sw_ctrl
	mov b, a
	movw hl, sp
	mov a, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 79
	and a, [hl+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 81
	and a, [hl]
	mov x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 82
	and a, x
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 84
	mov a, !LOWW(_gPdc+0x00001)
	.bf a.7, $!.BB@LABEL@1_1
.BB@LABEL@1_19:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/r_main.c", 137
	addw sp, #0x04
	ret
.LFE1:
