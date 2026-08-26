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
#@   PDC\subdev\tmuxhs4446.c
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_ecc9417ec240495db11f2574a45372a1ol0f4dbw.oia
#@  compiled at Wed Aug 26 14:31:31 2026

	.EXTERN _gPdc
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.PUBLIC _main
	.EXTERN _R_MAIN_UserInit
	.EXTERN _pdc_active
	.EXTERN _pd_core
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
	.EXTERN _subdev_ctrl
	.EXTERN _smbm_ctrl

	.SECTION .textf,TEXTF
	.TYPE _main,function,.LFE1-_main
_main:
	.STACK _main = 6
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 70
	push hl
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 73
	call !!_R_MAIN_UserInit
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 76
	call !!_pdc_active
	br $!.BB@LABEL@1_16
.BB@LABEL@1_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 87
	movw ax, !LOWW(_gPdc)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_2:	; bb17
	movw ax, !LOWW(_gPdc+0x00002)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_3:	; bb27
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_4:	; bb38
	movw ax, !LOWW(_gDCInfo+0x00002)
	xch a, x
	and a, #0xF0
	xch a, x
	or a, x
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_5:	; bb50
	mov a, #0xF0
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_7
.BB@LABEL@1_6:	; bb63
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bz $.BB@LABEL@1_8
.BB@LABEL@1_7:	; if_then_bb76
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 93
	call !!_user_func_event
	br $.BB@LABEL@1_15
.BB@LABEL@1_8:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 96
	call !!_user_func_chk_device
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 100
	call !!_user_func_snd_attention
	mov b, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 96
	and x, a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 100
	and a, x
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 101
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
.BB@LABEL@1_11:	; switch_clause_bb96
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 111
	call !!_pdc_stop
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 112
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 113
	stop
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 114
	call !!_pdc_run
	br $.BB@LABEL@1_14
.BB@LABEL@1_12:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 103
	halt
	br $.BB@LABEL@1_15
.BB@LABEL@1_13:	; switch_clause_bb91
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 106
	call !!_pdc_get_idle_time
	movw bc, ax
	mov a, #LOW(HIGHW(_tm_12bit_intr_hdlr))
	shrw ax, 8+0x00000
	movw de, ax
	movw ax, bc
	movw bc, #LOWW(_tm_12bit_intr_hdlr)
	call !!_tm_12bit_start_gtimer
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 107
	halt
.BB@LABEL@1_14:	; switch_clause_bb96
	call !!_tm_12tm_stop_gtimer
.BB@LABEL@1_15:	; if_break_bb102
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 123
	call !!_subdev_ctrl
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 124
	call !!_smbm_ctrl
.BB@LABEL@1_16:	; bb103
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 78
	call !!_pd_core
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 81
	call !!_sw_ctrl
	mov x, a
	mov a, [sp+0x00]
	and a, x
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 83
	mov a, !LOWW(_gPdc+0x00001)
	.bf a.7, $!.BB@LABEL@1_1
.BB@LABEL@1_17:	; return
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/r_main.c", 128
	pop ax
	ret
.LFE1:
