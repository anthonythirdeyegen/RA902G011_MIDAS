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

	.EXTERN _gSubdevInfo
	.EXTERN _gSubDevErr
	.PUBLIC _gDCInfo
	.PUBLIC _dcdc_ctrl
	.PUBLIC _dcdc_init
	.PUBLIC _isl_s0
	.PUBLIC _isl_s1
	.PUBLIC _isl_s1_off_sq
	.PUBLIC _isl_s1_on_sq
	.PUBLIC _isl_s1_chg_sq
	.PUBLIC _isl_s1_snk_off_sq
	.PUBLIC _isl_s1_snk_on_sq
	.PUBLIC _isl_s1_snk_chg_sq
	.EXTERN _pdc_get_req_volt
	.PUBLIC _isl_s1_clr_sq
	.PUBLIC _isl_s1_get_info
	.EXTERN _pdc_get_status

	.SECTION .textf,TEXTF
	.TYPE _dcdc_ctrl,function,.LFE1-_dcdc_ctrl
_dcdc_ctrl:
	.STACK _dcdc_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 88
	mov a, !LOWW(_gSubdevInfo)
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bc $.BB@LABEL@1_4
.BB@LABEL@1_1:	; if_break_bb
	mov a, #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 92
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_5
.BB@LABEL@1_2:	; if_break_bb
	dec a
	sknz
.BB@LABEL@1_3:	; switch_clause_bb9
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 97
	call $!_isl_s1
.BB@LABEL@1_4:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 103
	ret
.BB@LABEL@1_5:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 94
	call $!_isl_s0
	ret
.LFE1:
	.TYPE _dcdc_init,function,.LFE2-_dcdc_init
_dcdc_init:
	.STACK _dcdc_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 105
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 107
	movw !LOWW(_gDCInfo), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 108
	movw !LOWW(_gDCInfo+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 109
	movw !LOWW(_gDCInfo+0x00004), ax
	mov a, #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 110
	and a, !LOWW(_gDCInfo+0x00005)
	mov !LOWW(_gDCInfo+0x00005), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 112
	ret
.LFE2:
	.TYPE _isl_s0,function,.LFE3-_isl_s0
_isl_s0:
	.STACK _isl_s0 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 117
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 118
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 122
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 123
	ret
.BB@LABEL@3_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 126
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp a, #0x02
	bc $.BB@LABEL@3_10
.BB@LABEL@3_3:	; if_break_bb
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@3_11
.BB@LABEL@3_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@3_12
.BB@LABEL@3_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@3_13
.BB@LABEL@3_6:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@3_15
.BB@LABEL@3_7:	; if_break_bb
	dec a
	bnz $.BB@LABEL@3_9
.BB@LABEL@3_8:	; switch_clause_bb53
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 154
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 155
	clr1 !LOWW(_gDCInfo+0x00003).3
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 156
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 157
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 158
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@3_9:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 165
	ret
.BB@LABEL@3_10:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 129
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 130
	mov !LOWW(_gDCInfo+0x00004), #0x02
	br $.BB@LABEL@3_14
.BB@LABEL@3_11:	; switch_clause_bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 134
	mov !LOWW(_gDCInfo+0x0000E), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 135
	mov !LOWW(_gDCInfo+0x00004), #0x03
	br $.BB@LABEL@3_14
.BB@LABEL@3_12:	; switch_clause_bb29
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 139
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 140
	mov !LOWW(_gDCInfo+0x00004), #0x04
	br $.BB@LABEL@3_14
.BB@LABEL@3_13:	; switch_clause_bb37
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 144
	mov !LOWW(_gDCInfo+0x0000E), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 145
	mov !LOWW(_gDCInfo+0x00004), #0x05
.BB@LABEL@3_14:	; switch_clause_bb37
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 165
	ret
.BB@LABEL@3_15:	; switch_clause_bb45
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 149
	mov !LOWW(_gDCInfo+0x0000E), #0x05
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 150
	mov !LOWW(_gDCInfo+0x00004), #0x06
	br $.BB@LABEL@3_14
.LFE3:
	.TYPE _isl_s1,function,.LFE4-_isl_s1
_isl_s1:
	.STACK _isl_s1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 169
	mov a, !LOWW(_gDCInfo)
	mov x, a
	bf a.0, $.BB@LABEL@4_5
.BB@LABEL@4_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 170
	movw ax, !LOWW(_gDCInfo)
	cmpw ax, #0x0001
	bnz $.BB@LABEL@4_3
.BB@LABEL@4_2:	; if_then_bb10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 171
	call $!_isl_s1_off_sq
	ret
.BB@LABEL@4_3:	; if_else_bb
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 174
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	onew ax
.BB@LABEL@4_4:	; if_else_bb
	clrb !LOWW(_gDCInfo+0x00004)
	movw !LOWW(_gDCInfo), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 208
	ret
.BB@LABEL@4_5:	; if_else_bb17
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 179
	bf a.1, $.BB@LABEL@4_7
.BB@LABEL@4_6:	; if_then_bb26
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 180
	call $!_isl_s1_on_sq
	ret
.BB@LABEL@4_7:	; if_else_bb27
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 182
	bf a.2, $.BB@LABEL@4_9
.BB@LABEL@4_8:	; if_then_bb35
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 183
	call $!_isl_s1_chg_sq
	ret
.BB@LABEL@4_9:	; if_else_bb36
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 185
	bf a.3, $.BB@LABEL@4_13
.BB@LABEL@4_10:	; if_then_bb44
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 186
	movw ax, !LOWW(_gDCInfo)
	cmpw ax, #0x0008
	bnz $.BB@LABEL@4_12
.BB@LABEL@4_11:	; if_then_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 187
	call $!_isl_s1_snk_off_sq
	ret
.BB@LABEL@4_12:	; if_else_bb50
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 190
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	movw ax, #0x0008
	br $.BB@LABEL@4_4
.BB@LABEL@4_13:	; if_else_bb58
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 195
	bf a.5, $.BB@LABEL@4_15
.BB@LABEL@4_14:	; if_then_bb66
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 196
	call $!_isl_s1_snk_on_sq
	ret
.BB@LABEL@4_15:	; if_else_bb67
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 198
	bf a.6, $.BB@LABEL@4_17
.BB@LABEL@4_16:	; if_then_bb75
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 199
	call $!_isl_s1_snk_chg_sq
	ret
.BB@LABEL@4_17:	; if_else_bb76
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 201
	mov a, !LOWW(_gDCInfo+0x00001)
	bf a.0, $.BB@LABEL@4_19
.BB@LABEL@4_18:	; if_then_bb84
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 202
	clr1 a.0
	mov !LOWW(_gDCInfo+0x00001), a
	ret
.BB@LABEL@4_19:	; if_else_bb88
	mov a, x
	bf a.7, $.BB@LABEL@4_21
.BB@LABEL@4_20:	; if_then_bb95
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 205
	call $!_isl_s1_get_info
.BB@LABEL@4_21:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 208
	ret
.LFE4:
	.TYPE _isl_s1_off_sq,function,.LFE5-_isl_s1_off_sq
_isl_s1_off_sq:
	.STACK _isl_s1_off_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 212
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@5_2
.BB@LABEL@5_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 213
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 214
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 215
	clr1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 217
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@5_5
.BB@LABEL@5_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 222
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@5_7
.BB@LABEL@5_3:	; if_break_bb
	cmp a, #0x0A
	bnz $.BB@LABEL@5_6
.BB@LABEL@5_4:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 229
	clr1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 230
	clr1 !LOWW(_gDCInfo+0x00003).3
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 231
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@5_5:	; switch_clause_bb33
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@5_6:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 240
	ret
.BB@LABEL@5_7:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 224
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 225
	mov !LOWW(_gDCInfo+0x00004), #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 226
	set1 !LOWW(_gSubdevInfo).0
	ret
.LFE5:
	.TYPE _isl_s1_on_sq,function,.LFE6-_isl_s1_on_sq
_isl_s1_on_sq:
	.STACK _isl_s1_on_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 244
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@6_2
.BB@LABEL@6_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 245
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 246
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 247
	clr1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 249
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@6_13
.BB@LABEL@6_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 254
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@6_15
.BB@LABEL@6_3:	; if_break_bb
	add a, #0xEC
	cmp0 a
	bz $.BB@LABEL@6_16
.BB@LABEL@6_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_17
.BB@LABEL@6_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_18
.BB@LABEL@6_6:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_19
.BB@LABEL@6_7:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_20
.BB@LABEL@6_8:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_21
.BB@LABEL@6_9:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_22
.BB@LABEL@6_10:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_24
.BB@LABEL@6_11:	; if_break_bb
	dec a
	bnz $.BB@LABEL@6_14
.BB@LABEL@6_12:	; switch_clause_bb97
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 305
	clr1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 306
	clr1 !LOWW(_gDCInfo+0x00003).3
	mov a, #0x20
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 307
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x2F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@6_13:	; switch_clause_bb97
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@6_14:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 316
	ret
.BB@LABEL@6_15:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 256
	mov !LOWW(_gDCInfo+0x0000E), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 257
	mov !LOWW(_gDCInfo+0x00004), #0x14
	br $.BB@LABEL@6_23
.BB@LABEL@6_16:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 261
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 262
	mov !LOWW(_gDCInfo+0x00004), #0x15
	br $.BB@LABEL@6_23
.BB@LABEL@6_17:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 266
	mov !LOWW(_gDCInfo+0x0000E), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 267
	mov !LOWW(_gDCInfo+0x00004), #0x16
	br $.BB@LABEL@6_23
.BB@LABEL@6_18:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 271
	mov !LOWW(_gDCInfo+0x0000E), #0x05
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 272
	mov !LOWW(_gDCInfo+0x00004), #0x17
	br $.BB@LABEL@6_23
.BB@LABEL@6_19:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 276
	mov !LOWW(_gDCInfo+0x0000E), #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 277
	mov !LOWW(_gDCInfo+0x00004), #0x18
	br $.BB@LABEL@6_23
.BB@LABEL@6_20:	; switch_clause_bb65
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 281
	mov !LOWW(_gDCInfo+0x0000E), #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 282
	mov !LOWW(_gDCInfo+0x00004), #0x19
	br $.BB@LABEL@6_23
.BB@LABEL@6_21:	; switch_clause_bb73
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 289
	mov !LOWW(_gDCInfo+0x0000E), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 290
	mov !LOWW(_gDCInfo+0x00004), #0x1A
	br $.BB@LABEL@6_23
.BB@LABEL@6_22:	; switch_clause_bb81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 295
	mov !LOWW(_gDCInfo+0x0000E), #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 296
	mov !LOWW(_gDCInfo+0x00004), #0x1B
.BB@LABEL@6_23:	; switch_clause_bb81
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 316
	ret
.BB@LABEL@6_24:	; switch_clause_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 300
	mov !LOWW(_gDCInfo+0x0000E), #0x11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 301
	mov !LOWW(_gDCInfo+0x00004), #0x1C
	br $.BB@LABEL@6_23
.LFE6:
	.TYPE _isl_s1_chg_sq,function,.LFE7-_isl_s1_chg_sq
_isl_s1_chg_sq:
	.STACK _isl_s1_chg_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 320
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@7_2
.BB@LABEL@7_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 321
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 322
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 323
	clr1 !LOWW(_gDCInfo).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 325
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@7_8
.BB@LABEL@7_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 330
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@7_10
.BB@LABEL@7_3:	; if_break_bb
	add a, #0xE2
	cmp0 a
	bz $.BB@LABEL@7_11
.BB@LABEL@7_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@7_12
.BB@LABEL@7_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@7_14
.BB@LABEL@7_6:	; if_break_bb
	dec a
	bnz $.BB@LABEL@7_9
.BB@LABEL@7_7:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 356
	clr1 !LOWW(_gDCInfo).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 357
	clr1 !LOWW(_gDCInfo+0x00003).3
.BB@LABEL@7_8:	; switch_clause_bb57
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@7_9:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 367
	ret
.BB@LABEL@7_10:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 332
	mov !LOWW(_gDCInfo+0x0000E), #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 333
	mov !LOWW(_gDCInfo+0x00004), #0x1E
	br $.BB@LABEL@7_13
.BB@LABEL@7_11:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 337
	mov !LOWW(_gDCInfo+0x0000E), #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 338
	mov !LOWW(_gDCInfo+0x00004), #0x1F
	br $.BB@LABEL@7_13
.BB@LABEL@7_12:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 345
	mov !LOWW(_gDCInfo+0x0000E), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 346
	mov !LOWW(_gDCInfo+0x00004), #0x20
.BB@LABEL@7_13:	; switch_clause_bb41
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 367
	ret
.BB@LABEL@7_14:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 351
	mov !LOWW(_gDCInfo+0x0000E), #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 352
	mov !LOWW(_gDCInfo+0x00004), #0x21
	br $.BB@LABEL@7_13
.LFE7:
	.TYPE _isl_s1_snk_off_sq,function,.LFE8-_isl_s1_snk_off_sq
_isl_s1_snk_off_sq:
	.STACK _isl_s1_snk_off_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 372
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@8_2
.BB@LABEL@8_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 373
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 374
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 375
	clr1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 377
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 378
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 379
	ret
.BB@LABEL@8_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 382
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@8_7
.BB@LABEL@8_3:	; if_break_bb
	add a, #0xD8
	cmp0 a
	bz $.BB@LABEL@8_12
.BB@LABEL@8_4:	; if_break_bb
	dec a
	bnz $.BB@LABEL@8_6
.BB@LABEL@8_5:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 400
	clr1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 401
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 402
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 404
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@8_6:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 410
	ret
.BB@LABEL@8_7:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 384
	call !!_pdc_get_req_volt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 385
	or a, x
	bnz $.BB@LABEL@8_9
.BB@LABEL@8_8:	; switch_clause_bb.if_break_bb33_crit_edge
	mov a, #0x05
	br $.BB@LABEL@8_10
.BB@LABEL@8_9:	; if_else_bb
	mov a, #0x14
.BB@LABEL@8_10:	; if_break_bb33
	mov !LOWW(_gDCInfo+0x0000E), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 391
	mov !LOWW(_gDCInfo+0x00004), #0x28
.BB@LABEL@8_11:	; if_break_bb33
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 410
	ret
.BB@LABEL@8_12:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 395
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 396
	mov !LOWW(_gDCInfo+0x00004), #0x29
	br $.BB@LABEL@8_11
.LFE8:
	.TYPE _isl_s1_snk_on_sq,function,.LFE9-_isl_s1_snk_on_sq
_isl_s1_snk_on_sq:
	.STACK _isl_s1_snk_on_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 414
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@9_2
.BB@LABEL@9_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 415
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 416
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 417
	clr1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 419
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 420
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 421
	ret
.BB@LABEL@9_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 424
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@9_10
.BB@LABEL@9_3:	; if_break_bb
	add a, #0xCE
	cmp0 a
	bz $.BB@LABEL@9_11
.BB@LABEL@9_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@9_12
.BB@LABEL@9_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@9_13
.BB@LABEL@9_6:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@9_15
.BB@LABEL@9_7:	; if_break_bb
	dec a
	bnz $.BB@LABEL@9_9
.BB@LABEL@9_8:	; switch_clause_bb65
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 451
	clr1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 452
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 453
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 455
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@9_9:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 461
	ret
.BB@LABEL@9_10:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 426
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 427
	mov !LOWW(_gDCInfo+0x00004), #0x32
	br $.BB@LABEL@9_14
.BB@LABEL@9_11:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 431
	mov !LOWW(_gDCInfo+0x0000E), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 432
	mov !LOWW(_gDCInfo+0x00004), #0x33
	br $.BB@LABEL@9_14
.BB@LABEL@9_12:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 436
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 437
	mov !LOWW(_gDCInfo+0x00004), #0x34
	br $.BB@LABEL@9_14
.BB@LABEL@9_13:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 441
	mov !LOWW(_gDCInfo+0x0000E), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 442
	mov !LOWW(_gDCInfo+0x00004), #0x35
.BB@LABEL@9_14:	; switch_clause_bb49
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 461
	ret
.BB@LABEL@9_15:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 446
	mov !LOWW(_gDCInfo+0x0000E), #0x14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 447
	mov !LOWW(_gDCInfo+0x00004), #0x36
	br $.BB@LABEL@9_14
.LFE9:
	.TYPE _isl_s1_snk_chg_sq,function,.LFE10-_isl_s1_snk_chg_sq
_isl_s1_snk_chg_sq:
	.STACK _isl_s1_snk_chg_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 465
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@10_2
.BB@LABEL@10_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 466
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 467
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 468
	clr1 !LOWW(_gDCInfo).6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 470
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 471
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 472
	ret
.BB@LABEL@10_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 475
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@10_11
.BB@LABEL@10_3:	; if_break_bb
	add a, #0xD9
	cmp0 a
	bz $.BB@LABEL@10_12
.BB@LABEL@10_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@10_13
.BB@LABEL@10_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@10_14
.BB@LABEL@10_6:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@10_15
.BB@LABEL@10_7:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@10_17
.BB@LABEL@10_8:	; if_break_bb
	dec a
	bnz $.BB@LABEL@10_10
.BB@LABEL@10_9:	; switch_clause_bb73
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 507
	clr1 !LOWW(_gDCInfo).6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 508
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 509
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x30
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 511
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x3F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@10_10:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 517
	ret
.BB@LABEL@10_11:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 477
	mov !LOWW(_gDCInfo+0x0000E), #0x15
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 478
	mov !LOWW(_gDCInfo+0x00004), #0x27
	br $.BB@LABEL@10_16
.BB@LABEL@10_12:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 482
	mov !LOWW(_gDCInfo+0x0000E), #0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 483
	mov !LOWW(_gDCInfo+0x00004), #0x28
	br $.BB@LABEL@10_16
.BB@LABEL@10_13:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 487
	mov !LOWW(_gDCInfo+0x0000E), #0x0C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 488
	mov !LOWW(_gDCInfo+0x00004), #0x29
	br $.BB@LABEL@10_16
.BB@LABEL@10_14:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 492
	mov !LOWW(_gDCInfo+0x0000E), #0x0D
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 493
	mov !LOWW(_gDCInfo+0x00004), #0x2A
	br $.BB@LABEL@10_16
.BB@LABEL@10_15:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 497
	mov !LOWW(_gDCInfo+0x0000E), #0x0E
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 498
	mov !LOWW(_gDCInfo+0x00004), #0x2B
.BB@LABEL@10_16:	; switch_clause_bb57
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 517
	ret
.BB@LABEL@10_17:	; switch_clause_bb65
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 502
	mov !LOWW(_gDCInfo+0x0000E), #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 503
	mov !LOWW(_gDCInfo+0x00004), #0x2C
	br $.BB@LABEL@10_16
.LFE10:
	.TYPE _isl_s1_clr_sq,function,.LFE11-_isl_s1_clr_sq
_isl_s1_clr_sq:
	.STACK _isl_s1_clr_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 521
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@11_2
.BB@LABEL@11_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 522
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 523
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 524
	clr1 !LOWW(_gDCInfo+0x00001).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 526
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@11_5
.BB@LABEL@11_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 531
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@11_7
.BB@LABEL@11_3:	; if_break_bb
	cmp a, #0x32
	bnz $.BB@LABEL@11_6
.BB@LABEL@11_4:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 538
	clr1 !LOWW(_gDCInfo+0x00001).0
.BB@LABEL@11_5:	; switch_clause_bb33
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@11_6:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 546
	ret
.BB@LABEL@11_7:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 533
	mov !LOWW(_gDCInfo+0x0000E), #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 534
	mov !LOWW(_gDCInfo+0x00004), #0x32
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 535
	set1 !LOWW(_gSubdevInfo).0
	ret
.LFE11:
	.TYPE _isl_s1_get_info,function,.LFE12-_isl_s1_get_info
_isl_s1_get_info:
	.STACK _isl_s1_get_info = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 548
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 551
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@12_2
.BB@LABEL@12_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 552
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 553
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 554
	clr1 !LOWW(_gDCInfo).7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 556
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@12_11
.BB@LABEL@12_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 561
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@12_13
.BB@LABEL@12_3:	; if_break_bb
	add a, #0xC4
	cmp0 a
	bz $.BB@LABEL@12_15
.BB@LABEL@12_4:	; if_break_bb
	dec a
	bnz $.BB@LABEL@12_12
.BB@LABEL@12_5:	; switch_clause_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 573
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 574
	mov a, [sp+0x00]
	bf a.0, $.BB@LABEL@12_10
.BB@LABEL@12_6:	; bb54
	movw ax, sp
	movw hl, ax
	bf [hl].1, $.BB@LABEL@12_10
.BB@LABEL@12_7:	; if_then_bb72
	mov a, #0xFD
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 575
	and a, !LOWW(_gDCInfo+0x00002)
	mov b, a
	movw ax, !LOWW(_gDCInfo+0x00006)
	clrb x
	and a, #0x60
	cmpw ax, #0x4000
	mov a, b
	sknz
.BB@LABEL@12_8:	; if_then_bb78
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 576
	set1 a.1
.BB@LABEL@12_9:	; if_else_bb
	mov !LOWW(_gDCInfo+0x00002), a
.BB@LABEL@12_10:	; if_break_bb86
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 583
	clr1 !LOWW(_gDCInfo).7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 584
	clr1 !LOWW(_gDCInfo+0x00003).3
.BB@LABEL@12_11:	; if_break_bb86
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@12_12:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 594
	ret
.BB@LABEL@12_13:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 563
	mov !LOWW(_gDCInfo+0x0000E), #0x13
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 564
	mov !LOWW(_gDCInfo+0x00004), #0x3C
.BB@LABEL@12_14:	; switch_clause_bb
	set1 !LOWW(_gSubdevInfo).0
	br $.BB@LABEL@12_12
.BB@LABEL@12_15:	; switch_clause_bb34
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 568
	mov !LOWW(_gDCInfo+0x0000E), #0x12
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/dcdc_ctrl.c", 569
	mov !LOWW(_gDCInfo+0x00004), #0x3D
	br $.BB@LABEL@12_14
.LFE12:
	.SECTION .bss,BSS
	.ALIGN 2
	.TYPE _gDCInfo,object,18
_gDCInfo:
	.DS (18)
