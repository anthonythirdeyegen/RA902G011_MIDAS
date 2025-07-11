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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_f77933be31b343fd93ec8db906f6b563gqip02wt.1wf
#@  compiled at Tue May 06 10:50:36 2025

	.PUBLIC _gSubdevInfo
	.PUBLIC _gSubDevErr
	.EXTERN _init_isl95338
	.EXTERN _isl95338_ctrl
	.PUBLIC _subdev_init
	.PUBLIC _subdev_ctrl
	.PUBLIC _subdev_get_alerthandler
	.PUBLIC _subdev_get_alert_signal

	.SECTION .textf,TEXTF
	.TYPE _subdev_init,function,.LFE1-_subdev_init
_subdev_init:
	.STACK _subdev_init = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 81
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 85
	clrb !LOWW(_gSubdevInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 86
	clrb !LOWW(_gSubdevInfo+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 87
	clrb !LOWW(_gSubdevInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 88
	clrb !LOWW(_gSubdevInfo+0x00003)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 90
	clrb !LOWW(_gSubDevErr)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 91
	clrb !LOWW(_gSubDevErr+0x00001)
	clrb a
	br $.BB@LABEL@1_5
.BB@LABEL@1_1:	; bb
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 94
	mov x, #0x04
	mulu x
	movw hl, ax
	addw ax, #SMRLW(_ulSuvdevInitFunc@2)
	movw de, ax
	movw ax, [de+0x02]
	movw bc, ax
	movw ax, [de]
	addw ax, bc
	sknz
.BB@LABEL@1_2:	; bb
	bnc $.BB@LABEL@1_4
.BB@LABEL@1_3:	; if_then_bb
	movw ax, hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 95
	addw ax, #SMRLW(_ulSuvdevInitFunc@2)
	movw de, ax
	mov a, [de+0x02]
	mov cs, a
	movw ax, [de]
	movw hl, ax
	call hl
.BB@LABEL@1_4:	; if_break_bb
	mov a, [sp+0x00]
	inc a
.BB@LABEL@1_5:	; if_break_bb
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 93
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	bc $.BB@LABEL@1_1
.BB@LABEL@1_6:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 100
	pop ax
	ret
.LFE1:
	.TYPE _subdev_ctrl,function,.LFE2-_subdev_ctrl
_subdev_ctrl:
	.STACK _subdev_ctrl = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 105
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 109
	mov a, !LOWW(_gSubdevInfo+0x00001)
	mov c, a
	cmp0 a
	bz $.BB@LABEL@2_6
.BB@LABEL@2_1:	; entry.bb46_crit_edge
	clrb a
	mov b, a
	br $.BB@LABEL@2_5
.BB@LABEL@2_2:	; bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 112
	shrw ax, 8+0x00000
	addw ax, #SMRLW(_ucBitMask@1)
	movw hl, ax
	mov a, c
	and a, [hl]
	cmp0 a
	bz $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 117
	mov a, SMRLW(_ucBitMask@1)[b]
	xor a, #0xFF
	and a, !LOWW(_gSubdevInfo+0x00001)
	mov c, a
	mov !LOWW(_gSubdevInfo+0x00001), a
.BB@LABEL@2_4:	; if_break_bb43
	inc b
	mov a, b
.BB@LABEL@2_5:	; bb46
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 111
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	bc $.BB@LABEL@2_2
	br $!.BB@LABEL@2_21
.BB@LABEL@2_6:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 123
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bz $.BB@LABEL@2_12
.BB@LABEL@2_7:	; if_else_bb.bb105_crit_edge
	clrb a
	mov b, a
	br $.BB@LABEL@2_11
.BB@LABEL@2_8:	; bb60
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 125
	shrw ax, 8+0x00000
	addw ax, #SMRLW(_ucBitMask@1)
	movw hl, ax
	mov a, !LOWW(_gSubdevInfo+0x00002)
	mov x, a
	and a, [hl]
	cmp0 a
	bz $.BB@LABEL@2_10
.BB@LABEL@2_9:	; if_else_bb91
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 131
	mov a, SMRLW(_ucBitMask@1)[b]
	xor a, #0xFF
	and a, x
	mov !LOWW(_gSubdevInfo+0x00002), a
.BB@LABEL@2_10:	; if_break_bb102
	inc b
	mov a, b
.BB@LABEL@2_11:	; bb105
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 124
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	bc $.BB@LABEL@2_8
.BB@LABEL@2_12:	; if_break_bb112
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 137
	cmp0 !LOWW(_gSubdevInfo)
	bz $.BB@LABEL@2_21
.BB@LABEL@2_13:	; if_break_bb112.bb163_crit_edge
	clrb a
	br $.BB@LABEL@2_20
.BB@LABEL@2_14:	; bb119
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 139
	shrw ax, 8+0x00000
	addw ax, #SMRLW(_ucBitMask@1)
	movw hl, ax
	mov a, !LOWW(_gSubdevInfo)
	mov [sp+0x00], a
	and a, [hl]
	cmp0 a
	bz $.BB@LABEL@2_19
.BB@LABEL@2_15:	; if_then_bb131
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 141
	mov x, #0x04
	mulu x
	movw hl, ax
	addw ax, #SMRLW(_ulSubdevFunc@4)
	movw de, ax
	movw ax, [de+0x02]
	movw bc, ax
	movw ax, [de]
	addw ax, bc
	sknz
.BB@LABEL@2_16:	; if_then_bb131
	bnc $.BB@LABEL@2_18
.BB@LABEL@2_17:	; if_then_bb139
	movw ax, hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 142
	addw ax, #SMRLW(_ulSubdevFunc@4)
	movw de, ax
	mov a, [de+0x02]
	mov cs, a
	movw ax, [de]
	movw hl, ax
	call hl
	br $.BB@LABEL@2_19
.BB@LABEL@2_18:	; if_else_bb149
	pop bc
	push bc
	movw hl, sp
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 145
	mov a, SMRLW(_ucBitMask@1)[b]
	xor a, #0xFF
	and a, [hl]
	mov !LOWW(_gSubdevInfo), a
.BB@LABEL@2_19:	; if_break_bb160
	mov a, [sp+0x01]
	inc a
.BB@LABEL@2_20:	; if_break_bb160
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 138
	shrw ax, 8+0x00000
	cmpw ax, #0x0008
	bc $.BB@LABEL@2_14
.BB@LABEL@2_21:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 153
	pop ax
	ret
.LFE2:
	.TYPE _subdev_get_alerthandler,function,.LFE3-_subdev_get_alerthandler
_subdev_get_alerthandler:
	.STACK _subdev_get_alerthandler = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 155
	clrw ax
	movw bc, ax
	br $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 159
	incw bc
	movw ax, bc
.BB@LABEL@3_2:	; bb11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 158
	xor a, #0x80
	cmpw ax, #0x8008
	bc $.BB@LABEL@3_1
.BB@LABEL@3_3:	; bb18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 165
	clrb a
	ret
.LFE3:
	.TYPE _subdev_get_alert_signal,function,.LFE4-_subdev_get_alert_signal
_subdev_get_alert_signal:
	.STACK _subdev_get_alert_signal = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/subdev_ctrl.c", 170
	oneb a
	ret
.LFE4:
	.SECTION .bss,BSS
	.TYPE _gSubdevInfo,object,4
_gSubdevInfo:
	.DS (4)
	.TYPE _gSubDevErr,object,2
_gSubDevErr:
	.DS (2)
	.SECTION .const,CONST
	.TYPE _ucBitMask@1,object,8
_ucBitMask@1:
	.DB 0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80
	.ALIGN 2
	.TYPE _ulSuvdevInitFunc@2,object,32
_ulSuvdevInitFunc@2:
	.DB2 LOWW(_init_isl95338)
	.DB LOW(HIGHW(_init_isl95338))
	.DB 0x00
	.DS (28)
	.ALIGN 2
	.TYPE _ulSuvdevAlertFunc@3,object,32
_ulSuvdevAlertFunc@3:
	.DS (32)
	.ALIGN 2
	.TYPE _ulSubdevFunc@4,object,32
_ulSubdevFunc@4:
	.DB2 LOWW(_isl95338_ctrl)
	.DB LOW(HIGHW(_isl95338_ctrl))
	.DB 0x00
	.DS (28)
	.ALIGN 2
	.TYPE _ulSubdevResetFunc@5,object,32
_ulSubdevResetFunc@5:
	.DS (32)
