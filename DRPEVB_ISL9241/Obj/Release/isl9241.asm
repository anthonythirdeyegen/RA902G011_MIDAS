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
	.EXTERN _gSmbmInfo
	.EXTERN _gDCInfo
	.PUBLIC _gIsl9241Info
	.PUBLIC _init_isl9241
	.PUBLIC _isl9241_ctrl
	.PUBLIC _isl9241_cmd_handler
	.PUBLIC _isl9241_cmd
	.PUBLIC _isl9241_end_processing
	.EXTERN _smbm_set_subdev
	.EXTERN _pdc_get_req_cur
	.EXTERN _pdc_get_req_volt
	.EXTERN _smbm_set_protocol
	.EXTERN _smbm_clr_status

	.SECTION .textf,TEXTF
	.TYPE _init_isl9241,function,.LFE1-_init_isl9241
_init_isl9241:
	.STACK _init_isl9241 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 84
	clrb !LOWW(_gIsl9241Info)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 85
	clrb !LOWW(_gIsl9241Info+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 86
	ret
.LFE1:
	.TYPE _isl9241_ctrl,function,.LFE2-_isl9241_ctrl
_isl9241_ctrl:
	.STACK _isl9241_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 91
	mov a, !LOWW(_gIsl9241Info)
	add a, #0x7F
	cmp0 a
	bz $.BB@LABEL@2_3
.BB@LABEL@2_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@2_4
.BB@LABEL@2_2:	; entry
	cmp a, #0x7E
	bnz $.BB@LABEL@2_8
.BB@LABEL@2_3:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 94
	call $!_isl9241_cmd_handler
	ret
.BB@LABEL@2_4:	; switch_clause_bb2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 97
	mov a, !LOWW(_gSmbmInfo)
	cmp a, #0x06
	bz $.BB@LABEL@2_7
.BB@LABEL@2_5:	; switch_clause_bb2
	cmp a, #0x08
	bz $.BB@LABEL@2_7
.BB@LABEL@2_6:	; switch_clause_bb2
	cmp a, #0x18
	sknz
.BB@LABEL@2_7:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 100
	call $!_isl9241_end_processing
.BB@LABEL@2_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 107
	ret
.LFE2:
	.TYPE _isl9241_cmd_handler,function,.LFE3-_isl9241_cmd_handler
_isl9241_cmd_handler:
	.STACK _isl9241_cmd_handler = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 112
	cmp0 !LOWW(_gSmbmInfo)
	bz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 113
	mov !LOWW(_gIsl9241Info), #0x81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 115
	ret
.BB@LABEL@3_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 118
	clrb !LOWW(_gSmbmInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 119
	clr1 !LOWW(_gSubDevErr).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 121
	movw ax, #0x0212
	call !!_smbm_set_subdev
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 122
	call $!_isl9241_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 123
	mov !LOWW(_gIsl9241Info), #0x82
	ret
.LFE3:
	.TYPE _isl9241_cmd,function,.LFE4-_isl9241_cmd
_isl9241_cmd:
	.STACK _isl9241_cmd = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 129
	push hl
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 132
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 136
	mov a, !LOWW(_gDCInfo+0x0000E)
	dec a
	cmp0 a
	bz $.BB@LABEL@4_16
.BB@LABEL@4_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_18
.BB@LABEL@4_2:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_19
.BB@LABEL@4_3:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_21
.BB@LABEL@4_4:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_22
.BB@LABEL@4_5:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_23
.BB@LABEL@4_6:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_24
.BB@LABEL@4_7:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_25
.BB@LABEL@4_8:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_28
.BB@LABEL@4_9:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_29
.BB@LABEL@4_10:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_31
.BB@LABEL@4_11:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@4_32
.BB@LABEL@4_12:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@4_35
.BB@LABEL@4_13:	; entry
	dec a
	cmp0 a
	.bz $!.BB@LABEL@4_36
.BB@LABEL@4_14:	; entry
	dec a
	.bz $!.BB@LABEL@4_37
.BB@LABEL@4_15:	; entry.switch_break_bb_crit_edge
	clrb b
	br $!.BB@LABEL@4_41
.BB@LABEL@4_16:	; switch_clause_bb
	clrw ax
.BB@LABEL@4_17:	; switch_clause_bb
	movw [sp+0x00], ax
	mov b, #0x39
	br $!.BB@LABEL@4_41
.BB@LABEL@4_18:	; switch_clause_bb6
	movw ax, #0x0080
	br $.BB@LABEL@4_17
.BB@LABEL@4_19:	; switch_clause_bb7
	movw ax, #0x0103
.BB@LABEL@4_20:	; switch_clause_bb7
	movw [sp+0x00], ax
	mov b, #0x3C
	br $!.BB@LABEL@4_41
.BB@LABEL@4_21:	; switch_clause_bb8
	movw ax, #0x0903
	br $.BB@LABEL@4_20
.BB@LABEL@4_22:	; switch_clause_bb9
	movw ax, #0xE000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 161
	movw [sp+0x00], ax
	mov b, #0x3D
	br $.BB@LABEL@4_41
.BB@LABEL@4_23:	; switch_clause_bb10
	mov b, #0x3A
	clrb a
	br $.BB@LABEL@4_42
.BB@LABEL@4_24:	; switch_clause_bb11
	mov b, #0x4D
	clrb a
	br $.BB@LABEL@4_42
.BB@LABEL@4_25:	; switch_clause_bb12
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 176
	call !!_pdc_get_req_cur
	movw !LOWW(_gDCInfo+0x0000C), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 177
	cmpw ax, #0x0065
	bc $.BB@LABEL@4_28
.BB@LABEL@4_26:	; if_else_bb
	movw ax, #0x2EE0
.BB@LABEL@4_27:	; if_else_bb
	movw [sp+0x00], ax
	mov b, #0x15
	br $.BB@LABEL@4_41
.BB@LABEL@4_28:	; switch_clause_bb17
	clrw ax
	br $.BB@LABEL@4_27
.BB@LABEL@4_29:	; switch_clause_bb18
	movw ax, #0x2328
.BB@LABEL@4_30:	; switch_clause_bb18
	movw [sp+0x00], ax
	mov b, #0x3E
	br $.BB@LABEL@4_41
.BB@LABEL@4_31:	; switch_clause_bb19
	clrw ax
	br $.BB@LABEL@4_30
.BB@LABEL@4_32:	; switch_clause_bb20
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 202
	call !!_pdc_get_req_volt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 203
	addw ax, #0x0006
	clrw bc
	sknc
.BB@LABEL@4_33:	; switch_clause_bb20
	incw bc
.BB@LABEL@4_34:	; switch_clause_bb20
	movw hl, #0x0000
	movw de, #0x000C
	divwu
	shlw ax, 0x03
	movw [sp+0x00], ax
	mov b, #0x49
	br $.BB@LABEL@4_41
.BB@LABEL@4_35:	; switch_clause_bb28
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 208
	call !!_pdc_get_req_cur
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 209
	addw ax, #0x0010
	xch a, x
	and a, #0xE0
	xch a, x
	movw [sp+0x00], ax
	mov b, #0x4A
	br $.BB@LABEL@4_41
.BB@LABEL@4_36:	; switch_clause_bb36
	movw ax, #0x07D0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 214
	movw [sp+0x00], ax
	mov b, #0x14
	br $.BB@LABEL@4_41
.BB@LABEL@4_37:	; switch_clause_bb37
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 219
	call !!_pdc_get_req_cur
	movw !LOWW(_gDCInfo+0x0000C), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 220
	cmpw ax, #0x0065
	bnc $.BB@LABEL@4_39
.BB@LABEL@4_38:	; if_then_bb43
	clrw ax
	br $.BB@LABEL@4_40
.BB@LABEL@4_39:	; if_else_bb44
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 224
	addw ax, #0xFF9C
.BB@LABEL@4_40:	; if_else_bb44
	movw [sp+0x00], ax
	mov b, #0x3F
.BB@LABEL@4_41:	; if_else_bb44
	oneb a
.BB@LABEL@4_42:	; switch_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 230
	mov1 CY, a.0
	onew ax
	push ax
	movw ax, #0x0002
	push ax
	bnc $.BB@LABEL@4_44
.BB@LABEL@4_43:	; if_then_bb54
	movw ax, sp
	addw ax, #0x0004
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 231
	movw de, ax
	mov x, #0x08
	br $.BB@LABEL@4_45
.BB@LABEL@4_44:	; if_else_bb56
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 242
	movw de, #LOWW(_gDCInfo+0x00006)
	mov x, #0x09
.BB@LABEL@4_45:	; if_else_bb56
	mov a, b
	movw bc, #0x0200
	call !!_smbm_set_protocol
	addw sp, #0x04
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 253
	ret
.LFE4:
	.TYPE _isl9241_end_processing,function,.LFE5-_isl9241_end_processing
_isl9241_end_processing:
	.STACK _isl9241_end_processing = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 258
	cmp !LOWW(_gSmbmInfo), #0x18
	bnz $.BB@LABEL@5_2
.BB@LABEL@5_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 259
	set1 !LOWW(_gSubDevErr).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 260
	mov a, !LOWW(_gSmbmInfo+0x00002)
	mov !LOWW(_gSubDevErr+0x00001), a
.BB@LABEL@5_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 262
	call !!_smbm_clr_status
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 264
	clrb !LOWW(_gIsl9241Info)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 265
	clr1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_ISL9241/PDC/subdev/isl9241.c", 267
	ret
.LFE5:
	.SECTION .bss,BSS
	.TYPE _gIsl9241Info,object,2
_gIsl9241Info:
	.DS (2)
