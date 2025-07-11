#CC-RL Compiler RL78 Assembler Source
#@  CC-RL Version : V1.15.00  [06 Dec 2024]
#@  Commmand :
#@   PDC\subdev\isl9241.c
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_d93bc9dddd52425792dfde713348d7bbcntfnqzp.e5n
#@  compiled at Tue May 06 10:50:57 2025

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
	.PUBLIC _isl_s1_get_info
	.EXTERN _pdc_get_status

	.SECTION .textf,TEXTF
	.TYPE _dcdc_ctrl,function,.LFE1-_dcdc_ctrl
_dcdc_ctrl:
	.STACK _dcdc_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 88
	mov a, !LOWW(_gSubdevInfo)
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bc $.BB@LABEL@1_4
.BB@LABEL@1_1:	; if_break_bb
	mov a, #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 92
	and a, !LOWW(_gDCInfo+0x00005)
	cmp0 a
	bz $.BB@LABEL@1_5
.BB@LABEL@1_2:	; if_break_bb
	dec a
	sknz
.BB@LABEL@1_3:	; switch_clause_bb9
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 97
	call $!_isl_s1
.BB@LABEL@1_4:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 103
	ret
.BB@LABEL@1_5:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 94
	call $!_isl_s0
	ret
.LFE1:
	.TYPE _dcdc_init,function,.LFE2-_dcdc_init
_dcdc_init:
	.STACK _dcdc_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 105
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 107
	movw !LOWW(_gDCInfo), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 108
	movw !LOWW(_gDCInfo+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 109
	movw !LOWW(_gDCInfo+0x00004), ax
	mov a, #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 110
	and a, !LOWW(_gDCInfo+0x00005)
	mov !LOWW(_gDCInfo+0x00005), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 112
	ret
.LFE2:
	.TYPE _isl_s0,function,.LFE3-_isl_s0
_isl_s0:
	.STACK _isl_s0 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 117
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 118
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 122
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 123
	ret
.BB@LABEL@3_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 126
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp a, #0x02
	bc $.BB@LABEL@3_8
.BB@LABEL@3_3:	; if_break_bb
	add a, #0xFE
	cmp0 a
	bz $.BB@LABEL@3_9
.BB@LABEL@3_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@3_11
.BB@LABEL@3_5:	; if_break_bb
	dec a
	bnz $.BB@LABEL@3_7
.BB@LABEL@3_6:	; switch_clause_bb37
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 144
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 145
	clr1 !LOWW(_gDCInfo+0x00003).3
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 146
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 147
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 148
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@3_7:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 155
	ret
.BB@LABEL@3_8:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 129
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 130
	mov !LOWW(_gDCInfo+0x00004), #0x02
	br $.BB@LABEL@3_10
.BB@LABEL@3_9:	; switch_clause_bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 134
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 135
	mov !LOWW(_gDCInfo+0x00004), #0x03
.BB@LABEL@3_10:	; switch_clause_bb21
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 155
	ret
.BB@LABEL@3_11:	; switch_clause_bb29
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 139
	mov !LOWW(_gDCInfo+0x0000E), #0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 140
	mov !LOWW(_gDCInfo+0x00004), #0x04
	br $.BB@LABEL@3_10
.LFE3:
	.TYPE _isl_s1,function,.LFE4-_isl_s1
_isl_s1:
	.STACK _isl_s1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 159
	mov a, !LOWW(_gDCInfo)
	mov x, a
	bf a.0, $.BB@LABEL@4_5
.BB@LABEL@4_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 160
	movw ax, !LOWW(_gDCInfo)
	cmpw ax, #0x0001
	bnz $.BB@LABEL@4_3
.BB@LABEL@4_2:	; if_then_bb10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 161
	call $!_isl_s1_off_sq
	ret
.BB@LABEL@4_3:	; if_else_bb
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 164
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	onew ax
.BB@LABEL@4_4:	; if_else_bb
	clrb !LOWW(_gDCInfo+0x00004)
	movw !LOWW(_gDCInfo), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 198
	ret
.BB@LABEL@4_5:	; if_else_bb17
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 169
	bf a.1, $.BB@LABEL@4_7
.BB@LABEL@4_6:	; if_then_bb26
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 170
	call $!_isl_s1_on_sq
	ret
.BB@LABEL@4_7:	; if_else_bb27
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 172
	bf a.2, $.BB@LABEL@4_9
.BB@LABEL@4_8:	; if_then_bb35
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 173
	call $!_isl_s1_chg_sq
	ret
.BB@LABEL@4_9:	; if_else_bb36
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 175
	bf a.3, $.BB@LABEL@4_13
.BB@LABEL@4_10:	; if_then_bb44
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 176
	movw ax, !LOWW(_gDCInfo)
	cmpw ax, #0x0008
	bnz $.BB@LABEL@4_12
.BB@LABEL@4_11:	; if_then_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 177
	call $!_isl_s1_snk_off_sq
	ret
.BB@LABEL@4_12:	; if_else_bb50
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 180
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0xF1
	mov !LOWW(_gDCInfo+0x00005), a
	movw ax, #0x0008
	br $.BB@LABEL@4_4
.BB@LABEL@4_13:	; if_else_bb58
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 185
	bf a.5, $.BB@LABEL@4_15
.BB@LABEL@4_14:	; if_then_bb66
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 186
	call $!_isl_s1_snk_on_sq
	ret
.BB@LABEL@4_15:	; if_else_bb67
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 188
	bf a.6, $.BB@LABEL@4_17
.BB@LABEL@4_16:	; if_then_bb75
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 189
	call $!_isl_s1_snk_chg_sq
	ret
.BB@LABEL@4_17:	; if_else_bb76
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 191
	mov a, !LOWW(_gDCInfo+0x00001)
	bf a.0, $.BB@LABEL@4_19
.BB@LABEL@4_18:	; if_then_bb84
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 192
	clr1 a.0
	mov !LOWW(_gDCInfo+0x00001), a
	ret
.BB@LABEL@4_19:	; if_else_bb88
	mov a, x
	bf a.7, $.BB@LABEL@4_21
.BB@LABEL@4_20:	; if_then_bb95
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 195
	call $!_isl_s1_get_info
.BB@LABEL@4_21:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 198
	ret
.LFE4:
	.TYPE _isl_s1_off_sq,function,.LFE5-_isl_s1_off_sq
_isl_s1_off_sq:
	.STACK _isl_s1_off_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 202
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@5_2
.BB@LABEL@5_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 203
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 204
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 205
	clr1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 207
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@5_5
.BB@LABEL@5_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 212
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@5_7
.BB@LABEL@5_3:	; if_break_bb
	cmp a, #0x0A
	bnz $.BB@LABEL@5_6
.BB@LABEL@5_4:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 219
	clr1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 220
	clr1 !LOWW(_gDCInfo+0x00003).3
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 221
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@5_5:	; switch_clause_bb33
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@5_6:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 230
	ret
.BB@LABEL@5_7:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 214
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 215
	mov !LOWW(_gDCInfo+0x00004), #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 216
	set1 !LOWW(_gSubdevInfo).0
	ret
.LFE5:
	.TYPE _isl_s1_on_sq,function,.LFE6-_isl_s1_on_sq
_isl_s1_on_sq:
	.STACK _isl_s1_on_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 234
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@6_2
.BB@LABEL@6_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 235
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 236
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 237
	clr1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 239
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@6_9
.BB@LABEL@6_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 244
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@6_11
.BB@LABEL@6_3:	; if_break_bb
	add a, #0xEC
	cmp0 a
	bz $.BB@LABEL@6_12
.BB@LABEL@6_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_13
.BB@LABEL@6_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_14
.BB@LABEL@6_6:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@6_16
.BB@LABEL@6_7:	; if_break_bb
	dec a
	bnz $.BB@LABEL@6_10
.BB@LABEL@6_8:	; switch_clause_bb65
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 271
	clr1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 272
	clr1 !LOWW(_gDCInfo+0x00003).3
	mov a, #0x20
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 273
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x2F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@6_9:	; switch_clause_bb65
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@6_10:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 282
	ret
.BB@LABEL@6_11:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 246
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 247
	mov !LOWW(_gDCInfo+0x00004), #0x14
	br $.BB@LABEL@6_15
.BB@LABEL@6_12:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 251
	mov !LOWW(_gDCInfo+0x0000E), #0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 252
	mov !LOWW(_gDCInfo+0x00004), #0x15
	br $.BB@LABEL@6_15
.BB@LABEL@6_13:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 256
	mov !LOWW(_gDCInfo+0x0000E), #0x0C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 257
	mov !LOWW(_gDCInfo+0x00004), #0x16
	br $.BB@LABEL@6_15
.BB@LABEL@6_14:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 261
	mov !LOWW(_gDCInfo+0x0000E), #0x0D
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 262
	mov !LOWW(_gDCInfo+0x00004), #0x17
.BB@LABEL@6_15:	; switch_clause_bb49
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 282
	ret
.BB@LABEL@6_16:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 266
	mov !LOWW(_gDCInfo+0x0000E), #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 267
	mov !LOWW(_gDCInfo+0x00004), #0x18
	br $.BB@LABEL@6_15
.LFE6:
	.TYPE _isl_s1_chg_sq,function,.LFE7-_isl_s1_chg_sq
_isl_s1_chg_sq:
	.STACK _isl_s1_chg_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 286
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@7_2
.BB@LABEL@7_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 287
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 288
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 289
	clr1 !LOWW(_gDCInfo).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 291
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@7_7
.BB@LABEL@7_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 296
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@7_9
.BB@LABEL@7_3:	; if_break_bb
	add a, #0xE2
	cmp0 a
	bz $.BB@LABEL@7_10
.BB@LABEL@7_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@7_12
.BB@LABEL@7_5:	; if_break_bb
	dec a
	bnz $.BB@LABEL@7_8
.BB@LABEL@7_6:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 313
	clr1 !LOWW(_gDCInfo).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 314
	clr1 !LOWW(_gDCInfo+0x00003).3
.BB@LABEL@7_7:	; switch_clause_bb49
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@7_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 324
	ret
.BB@LABEL@7_9:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 298
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 299
	mov !LOWW(_gDCInfo+0x00004), #0x1E
	br $.BB@LABEL@7_11
.BB@LABEL@7_10:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 303
	mov !LOWW(_gDCInfo+0x0000E), #0x0C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 304
	mov !LOWW(_gDCInfo+0x00004), #0x1F
.BB@LABEL@7_11:	; switch_clause_bb33
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 324
	ret
.BB@LABEL@7_12:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 308
	mov !LOWW(_gDCInfo+0x0000E), #0x0D
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 309
	mov !LOWW(_gDCInfo+0x00004), #0x20
	br $.BB@LABEL@7_11
.LFE7:
	.TYPE _isl_s1_snk_off_sq,function,.LFE8-_isl_s1_snk_off_sq
_isl_s1_snk_off_sq:
	.STACK _isl_s1_snk_off_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 328
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@8_2
.BB@LABEL@8_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 329
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 330
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 331
	clr1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 333
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 334
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 335
	ret
.BB@LABEL@8_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 338
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@8_9
.BB@LABEL@8_3:	; if_break_bb
	add a, #0xD8
	cmp0 a
	bz $.BB@LABEL@8_10
.BB@LABEL@8_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@8_11
.BB@LABEL@8_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@8_13
.BB@LABEL@8_6:	; if_break_bb
	dec a
	bnz $.BB@LABEL@8_8
.BB@LABEL@8_7:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 360
	clr1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 361
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 362
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 364
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@8_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 370
	ret
.BB@LABEL@8_9:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 340
	mov !LOWW(_gDCInfo+0x0000E), #0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 341
	mov !LOWW(_gDCInfo+0x00004), #0x28
	br $.BB@LABEL@8_12
.BB@LABEL@8_10:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 345
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 346
	mov !LOWW(_gDCInfo+0x00004), #0x29
	br $.BB@LABEL@8_12
.BB@LABEL@8_11:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 350
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 351
	mov !LOWW(_gDCInfo+0x00004), #0x2A
.BB@LABEL@8_12:	; switch_clause_bb41
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 370
	ret
.BB@LABEL@8_13:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 355
	mov !LOWW(_gDCInfo+0x0000E), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 356
	mov !LOWW(_gDCInfo+0x00004), #0x2B
	br $.BB@LABEL@8_12
.LFE8:
	.TYPE _isl_s1_snk_on_sq,function,.LFE9-_isl_s1_snk_on_sq
_isl_s1_snk_on_sq:
	.STACK _isl_s1_snk_on_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 374
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@9_2
.BB@LABEL@9_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 375
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 376
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 377
	clr1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 379
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 380
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 381
	ret
.BB@LABEL@9_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 384
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@9_9
.BB@LABEL@9_3:	; if_break_bb
	add a, #0xCE
	cmp0 a
	bz $.BB@LABEL@9_10
.BB@LABEL@9_4:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@9_11
.BB@LABEL@9_5:	; if_break_bb
	dec a
	cmp0 a
	bz $.BB@LABEL@9_13
.BB@LABEL@9_6:	; if_break_bb
	dec a
	bnz $.BB@LABEL@9_8
.BB@LABEL@9_7:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 406
	clr1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 407
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 408
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 410
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x1F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@9_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 416
	ret
.BB@LABEL@9_9:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 386
	mov !LOWW(_gDCInfo+0x0000E), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 387
	mov !LOWW(_gDCInfo+0x00004), #0x32
	br $.BB@LABEL@9_12
.BB@LABEL@9_10:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 391
	oneb !LOWW(_gDCInfo+0x0000E)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 392
	mov !LOWW(_gDCInfo+0x00004), #0x33
	br $.BB@LABEL@9_12
.BB@LABEL@9_11:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 396
	mov !LOWW(_gDCInfo+0x0000E), #0x0B
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 397
	mov !LOWW(_gDCInfo+0x00004), #0x34
.BB@LABEL@9_12:	; switch_clause_bb41
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 416
	ret
.BB@LABEL@9_13:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 401
	mov !LOWW(_gDCInfo+0x0000E), #0x09
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 402
	mov !LOWW(_gDCInfo+0x00004), #0x35
	br $.BB@LABEL@9_12
.LFE9:
	.TYPE _isl_s1_snk_chg_sq,function,.LFE10-_isl_s1_snk_chg_sq
_isl_s1_snk_chg_sq:
	.STACK _isl_s1_snk_chg_sq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 420
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@10_2
.BB@LABEL@10_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 421
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 422
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 423
	clr1 !LOWW(_gDCInfo).6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 425
	clrb !LOWW(_gDCInfo+0x00005)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 426
	clrb !LOWW(_gDCInfo+0x00004)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 427
	ret
.BB@LABEL@10_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 430
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 462
	clr1 !LOWW(_gDCInfo).6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 463
	clr1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 464
	clrb !LOWW(_gDCInfo+0x00004)
	mov a, #0x30
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 466
	or a, !LOWW(_gDCInfo+0x00005)
	and a, #0x3F
	mov !LOWW(_gDCInfo+0x00005), a
.BB@LABEL@10_10:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 472
	ret
.BB@LABEL@10_11:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 432
	mov !LOWW(_gDCInfo+0x0000E), #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 433
	mov !LOWW(_gDCInfo+0x00004), #0x27
	br $.BB@LABEL@10_16
.BB@LABEL@10_12:	; switch_clause_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 437
	mov !LOWW(_gDCInfo+0x0000E), #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 438
	mov !LOWW(_gDCInfo+0x00004), #0x28
	br $.BB@LABEL@10_16
.BB@LABEL@10_13:	; switch_clause_bb41
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 442
	mov !LOWW(_gDCInfo+0x0000E), #0x05
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 443
	mov !LOWW(_gDCInfo+0x00004), #0x29
	br $.BB@LABEL@10_16
.BB@LABEL@10_14:	; switch_clause_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 447
	mov !LOWW(_gDCInfo+0x0000E), #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 448
	mov !LOWW(_gDCInfo+0x00004), #0x2A
	br $.BB@LABEL@10_16
.BB@LABEL@10_15:	; switch_clause_bb57
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 452
	mov !LOWW(_gDCInfo+0x0000E), #0x02
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 453
	mov !LOWW(_gDCInfo+0x00004), #0x2B
.BB@LABEL@10_16:	; switch_clause_bb57
	set1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 472
	ret
.BB@LABEL@10_17:	; switch_clause_bb65
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 457
	mov !LOWW(_gDCInfo+0x0000E), #0x0E
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 458
	mov !LOWW(_gDCInfo+0x00004), #0x2C
	br $.BB@LABEL@10_16
.LFE10:
	.TYPE _isl_s1_get_info,function,.LFE11-_isl_s1_get_info
_isl_s1_get_info:
	.STACK _isl_s1_get_info = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 474
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 477
	mov a, !LOWW(_gSubDevErr)
	mov b, a
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bnc $.BB@LABEL@11_2
.BB@LABEL@11_1:	; if_then_bb
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 478
	clr1 a.0
	mov !LOWW(_gSubDevErr), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 479
	set1 !LOWW(_gDCInfo+0x00003).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 480
	clr1 !LOWW(_gDCInfo).7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 482
	clrb !LOWW(_gDCInfo+0x00005)
	br $.BB@LABEL@11_11
.BB@LABEL@11_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 487
	mov a, !LOWW(_gDCInfo+0x00004)
	cmp0 a
	bz $.BB@LABEL@11_13
.BB@LABEL@11_3:	; if_break_bb
	add a, #0xC4
	cmp0 a
	bz $.BB@LABEL@11_15
.BB@LABEL@11_4:	; if_break_bb
	dec a
	bnz $.BB@LABEL@11_12
.BB@LABEL@11_5:	; switch_clause_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 499
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 500
	mov a, [sp+0x00]
	bf a.0, $.BB@LABEL@11_10
.BB@LABEL@11_6:	; bb54
	movw ax, sp
	movw hl, ax
	bf [hl].1, $.BB@LABEL@11_10
.BB@LABEL@11_7:	; if_then_bb72
	mov a, #0xFD
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 501
	and a, !LOWW(_gDCInfo+0x00002)
	mov b, a
	movw ax, !LOWW(_gDCInfo+0x00006)
	clrb x
	and a, #0x60
	cmpw ax, #0x4000
	mov a, b
	sknz
.BB@LABEL@11_8:	; if_then_bb78
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 502
	set1 a.1
.BB@LABEL@11_9:	; if_else_bb
	mov !LOWW(_gDCInfo+0x00002), a
.BB@LABEL@11_10:	; if_break_bb86
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 509
	clr1 !LOWW(_gDCInfo).7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 510
	clr1 !LOWW(_gDCInfo+0x00003).3
.BB@LABEL@11_11:	; if_break_bb86
	clrb !LOWW(_gDCInfo+0x00004)
.BB@LABEL@11_12:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 520
	ret
.BB@LABEL@11_13:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 489
	mov !LOWW(_gDCInfo+0x0000E), #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 490
	mov !LOWW(_gDCInfo+0x00004), #0x3C
.BB@LABEL@11_14:	; switch_clause_bb
	set1 !LOWW(_gSubdevInfo).0
	br $.BB@LABEL@11_12
.BB@LABEL@11_15:	; switch_clause_bb34
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 494
	mov !LOWW(_gDCInfo+0x0000E), #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/dcdc_ctrl.c", 495
	mov !LOWW(_gDCInfo+0x00004), #0x3D
	br $.BB@LABEL@11_14
.LFE11:
	.SECTION .bss,BSS
	.ALIGN 2
	.TYPE _gDCInfo,object,18
_gDCInfo:
	.DS (18)
