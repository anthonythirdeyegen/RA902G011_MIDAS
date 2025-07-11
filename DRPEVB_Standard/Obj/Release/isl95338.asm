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
	.EXTERN _gSmbmInfo
	.EXTERN _gDCInfo
	.PUBLIC _gIsl95338Info
	.PUBLIC _init_isl95338
	.PUBLIC _isl95338_ctrl
	.PUBLIC _isl95338_cmd_handler
	.PUBLIC _isl95338_cmd
	.PUBLIC _isl95338_end_processing
	.EXTERN _smbm_set_subdev
	.EXTERN _pdc_get_req_volt
	.EXTERN _pdc_get_req_cur
	.EXTERN _pdc_is_pps_mode
	.EXTERN _pdc_get_rdo
	.EXTERN _smbm_set_protocol
	.EXTERN _smbm_clr_status

	.SECTION .textf,TEXTF
	.TYPE _init_isl95338,function,.LFE1-_init_isl95338
_init_isl95338:
	.STACK _init_isl95338 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 80
	clrb !LOWW(_gIsl95338Info)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 81
	clrb !LOWW(_gIsl95338Info+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 82
	ret
.LFE1:
	.TYPE _isl95338_ctrl,function,.LFE2-_isl95338_ctrl
_isl95338_ctrl:
	.STACK _isl95338_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 87
	mov a, !LOWW(_gIsl95338Info)
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 90
	call $!_isl95338_cmd_handler
	ret
.BB@LABEL@2_4:	; switch_clause_bb2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 93
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 96
	call $!_isl95338_end_processing
.BB@LABEL@2_8:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 103
	ret
.LFE2:
	.TYPE _isl95338_cmd_handler,function,.LFE3-_isl95338_cmd_handler
_isl95338_cmd_handler:
	.STACK _isl95338_cmd_handler = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 108
	cmp0 !LOWW(_gSmbmInfo)
	bz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 109
	mov !LOWW(_gIsl95338Info), #0x81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 111
	ret
.BB@LABEL@3_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 114
	clrb !LOWW(_gSmbmInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 115
	clr1 !LOWW(_gSubDevErr).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 117
	movw ax, #0x0290
	call !!_smbm_set_subdev
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 118
	call $!_isl95338_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 119
	mov !LOWW(_gIsl95338Info), #0x82
	ret
.LFE3:
	.TYPE _isl95338_cmd,function,.LFE4-_isl95338_cmd
_isl95338_cmd:
	.STACK _isl95338_cmd = 18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 125
	subw sp, #0x0A
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 128
	movw [sp+0x08], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 137
	mov a, !LOWW(_gDCInfo+0x0000E)
	dec a
	mov d, a
	shrw ax, 8+0x00000
	movw bc, ax
	mov a, d
	cmp a, #0x15
	bnc $.BB@LABEL@4_2
.BB@LABEL@4_1:	; entry
	movw ax, bc
	movw bc, ax
	mov a, MIRLW(.SWITCH@LABEL@4_1+0x0002A)[bc]
	shlw bc, 0x01
	mov cs, a
	movw ax, MIRLW(.SWITCH@LABEL@4_1)[bc]
	br ax
.BB@LABEL@4_2:	; entry.switch_break_bb_crit_edge
	clrb b
	br $!.BB@LABEL@4_73
.BB@LABEL@4_3:	; switch_clause_bb11
	movw ax, #0x6800
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 165
	movw [sp+0x08], ax
	mov b, #0x3D
	br $!.BB@LABEL@4_73
.BB@LABEL@4_4:	; switch_clause_bb12
	movw ax, #0x8000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 172
	movw [sp+0x08], ax
	mov b, #0x4C
	br $!.BB@LABEL@4_73
.BB@LABEL@4_5:	; switch_clause_bb13
	clrw ax
.BB@LABEL@4_6:	; switch_clause_bb13
	movw [sp+0x08], ax
	mov b, #0x4E
	br $!.BB@LABEL@4_73
.BB@LABEL@4_7:	; switch_clause_bb15
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 193
	call !!_pdc_get_req_volt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 197
	movw bc, #0x0065
	mulhu
	movw [sp+0x00], ax
	movw ax, bc
	movw [sp+0x04], ax
	movw ax, [sp+0x00]
	movw hl, #0x0000
	movw de, #0x0064
	divwu
	movw [sp+0x02], ax
	movw ax, bc
	movw [sp+0x06], ax
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 201
	movw hl, #0x0000
	movw de, #0x000C
	divwu
	movw ax, de
	addw ax, hl
	movw ax, [sp+0x04]
	movw bc, ax
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 199
	movw hl, #0x0000
	movw de, #0x04B0
	divwu
	movw bc, #0x000C
	mulh
	movw [sp+0x04], ax
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 201
	bnz $.BB@LABEL@4_10
.BB@LABEL@4_8:	; switch_clause_bb15
	bc $.BB@LABEL@4_10
.BB@LABEL@4_9:	; switch_clause_bb15.if_break_bb_crit_edge
	movw de, ax
	movw ax, [sp+0x06]
	movw bc, ax
	br $.BB@LABEL@4_12
.BB@LABEL@4_10:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 202
	addw ax, #0x000C
	movw de, ax
	movw ax, [sp+0x06]
	movw bc, ax
	sknc
.BB@LABEL@4_11:	; if_then_bb
	incw bc
.BB@LABEL@4_12:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 204
	movw ax, de
	movw hl, #0x0000
	movw de, #0x000C
	divwu
	movw hl, sp
	movw bc, #0x000C
	mulh
	movw bc, ax
	movw ax, [sp+0x02]
	xchw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 206
	subw ax, bc
	movw [hl], ax
	clrw ax
	sknc
.BB@LABEL@4_13:	; if_break_bb
	decw ax
.BB@LABEL@4_14:	; if_break_bb
	subw ax, [hl+0x06]
	movw de, ax
	movw ax, bc
	subw ax, [hl+0x04]
	movw hl, ax
	movw ax, [sp+0x06]
	movw bc, ax
	sknc
.BB@LABEL@4_15:	; if_break_bb
	decw ax
.BB@LABEL@4_16:	; if_break_bb
	cmpw ax, de
	movw ax, hl
	movw hl, sp
	sknz
.BB@LABEL@4_17:	; if_break_bb
	cmpw ax, [hl+0x00]
.BB@LABEL@4_18:	; if_break_bb
	bnh $.BB@LABEL@4_21
.BB@LABEL@4_19:	; if_then_bb47
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 207
	addw ax, #0x000C
	movw [sp+0x02], ax
	sknc
.BB@LABEL@4_20:	; if_then_bb47
	incw bc
.BB@LABEL@4_21:	; if_break_bb50
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 209
	movw hl, #0x0000
	movw de, #0x000C
	divwu
	shlw ax, 0x03
	movw [sp+0x08], ax
	mov b, #0x49
	br $!.BB@LABEL@4_73
.BB@LABEL@4_22:	; switch_clause_bb55
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 214
	call !!_pdc_get_req_cur
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 215
	call !!_pdc_is_pps_mode
	mov d, a
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 214
	movw bc, #0x000A
	mulh
	movw [sp+0x02], ax
	mov a, d
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 215
	cmp0 a
	clrw bc
	bnz $.BB@LABEL@4_24
.BB@LABEL@4_23:	; if_then_bb64
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 216
	movw bc, #0x0078
	mulhu
	movw hl, #0x0000
	movw de, #0x0064
	divwu
	movw [sp+0x02], ax
.BB@LABEL@4_24:	; if_break_bb68
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 220
	and a, #0x03
	or a, x
	movw ax, [sp+0x02]
	movw de, ax
	bnz $.BB@LABEL@4_26
.BB@LABEL@4_25:	; if_break_bb68.if_break_bb81_crit_edge
	push bc
	pop hl
	br $.BB@LABEL@4_29
.BB@LABEL@4_26:	; if_then_bb78
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 221
	addw ax, #0x0400
	movw [sp+0x00], ax
	movw ax, bc
	sknc
.BB@LABEL@4_27:	; if_then_bb78
	incw ax
.BB@LABEL@4_28:	; if_then_bb78
	movw hl, ax
	movw ax, [sp+0x00]
.BB@LABEL@4_29:	; if_break_bb81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 223
	clrb x
	and a, #0xFC
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 225
	subw ax, de
	movw [sp+0x00], ax
	movw ax, hl
	sknc
.BB@LABEL@4_30:	; if_break_bb81
	decw ax
.BB@LABEL@4_31:	; if_break_bb81
	subw ax, bc
	movw hl, ax
	mov a, d
	and a, #0x03
	mov d, a
	clrw ax
	cmpw ax, hl
	movw hl, sp
	movw ax, de
	sknz
.BB@LABEL@4_32:	; if_break_bb81
	cmpw ax, [hl+0x00]
.BB@LABEL@4_33:	; if_break_bb81
	bnh $.BB@LABEL@4_36
.BB@LABEL@4_34:	; if_then_bb94
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 226
	addw ax, #0x0400
	movw [sp+0x02], ax
	sknc
.BB@LABEL@4_35:	; if_then_bb94
	incw bc
.BB@LABEL@4_36:	; if_break_bb97
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 228
	shlw bc, 0x0D
	movw ax, [sp+0x02]
	shrw ax, 0x03
	addw ax, bc
	xch a, x
	and a, #0x80
	xch a, x
	movw [sp+0x08], ax
	mov b, #0x4A
	br $!.BB@LABEL@4_73
.BB@LABEL@4_37:	; if_break_bb111
	movw ax, #0x1300
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 237
	movw [sp+0x08], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 238
	movw !LOWW(_gDCInfo+0x00006), ax
	mov b, #0x48
	br $!.BB@LABEL@4_73
.BB@LABEL@4_38:	; if_break_bb125
	movw ax, #0x125C
.BB@LABEL@4_39:	; if_break_bb125
	movw [sp+0x08], ax
	mov b, #0x14
	br $!.BB@LABEL@4_73
.BB@LABEL@4_40:	; if_break_bb162
	movw ax, #0x2C48
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 264
	movw [sp+0x08], ax
	mov b, #0x15
	br $!.BB@LABEL@4_73
.BB@LABEL@4_41:	; if_break_bb176
	movw ax, #0x03E8
	br $.BB@LABEL@4_39
.BB@LABEL@4_42:	; switch_clause_bb180
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 278
	call !!_pdc_get_req_cur
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 279
	call !!_pdc_is_pps_mode
	mov d, a
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 278
	movw bc, #0x000A
	mulh
	movw [sp+0x02], ax
	mov a, d
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 279
	cmp0 a
	clrw bc
	bnz $.BB@LABEL@4_44
.BB@LABEL@4_43:	; if_then_bb189
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 280
	movw bc, #0x0078
	mulhu
	movw hl, #0x0000
	movw de, #0x0064
	divwu
	movw [sp+0x02], ax
.BB@LABEL@4_44:	; if_break_bb193
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 284
	and a, #0x03
	or a, x
	movw ax, [sp+0x02]
	movw de, ax
	bnz $.BB@LABEL@4_46
.BB@LABEL@4_45:	; if_break_bb193.if_break_bb206_crit_edge
	push bc
	pop hl
	br $.BB@LABEL@4_49
.BB@LABEL@4_46:	; if_then_bb203
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 285
	addw ax, #0x0400
	movw [sp+0x00], ax
	movw ax, bc
	sknc
.BB@LABEL@4_47:	; if_then_bb203
	incw ax
.BB@LABEL@4_48:	; if_then_bb203
	movw hl, ax
	movw ax, [sp+0x00]
.BB@LABEL@4_49:	; if_break_bb206
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 287
	clrb x
	and a, #0xFC
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 289
	subw ax, de
	movw [sp+0x00], ax
	movw ax, hl
	sknc
.BB@LABEL@4_50:	; if_break_bb206
	decw ax
.BB@LABEL@4_51:	; if_break_bb206
	subw ax, bc
	movw hl, ax
	mov a, d
	and a, #0x03
	mov d, a
	clrw ax
	cmpw ax, hl
	movw hl, sp
	movw ax, de
	sknz
.BB@LABEL@4_52:	; if_break_bb206
	cmpw ax, [hl+0x00]
.BB@LABEL@4_53:	; if_break_bb206
	bnh $.BB@LABEL@4_56
.BB@LABEL@4_54:	; if_then_bb219
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 290
	addw ax, #0x0400
	movw [sp+0x02], ax
	sknc
.BB@LABEL@4_55:	; if_then_bb219
	incw bc
.BB@LABEL@4_56:	; if_break_bb222
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 292
	shlw bc, 0x0D
	movw ax, [sp+0x02]
	shrw ax, 0x03
	addw ax, bc
	xch a, x
	and a, #0x80
	xch a, x
	movw [sp+0x08], ax
	mov b, #0x47
	br $.BB@LABEL@4_73
.BB@LABEL@4_57:	; switch_clause_bb227
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 297
	clrb a
	call !!_pdc_get_rdo
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 298
	shlw bc, 0x06
	shrw ax, 0x0A
	addw ax, bc
	and a, #0x03
	movw bc, #0x000A
	mulh
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 300
	cmpw ax, #0x0064
	bnc $.BB@LABEL@4_59
.BB@LABEL@4_58:	; switch_clause_bb227.if_break_bb253_crit_edge
	clrw ax
	br $.BB@LABEL@4_60
.BB@LABEL@4_59:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 304
	movw bc, #0x000A
	mulhu
	addw ax, #0xFC18
	shrw ax, 0x03
	and a, #0x1F
	xch a, x
	and a, #0xFC
	xch a, x
.BB@LABEL@4_60:	; if_break_bb253
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 307
	movw [sp+0x08], ax
	mov b, #0x3F
	br $.BB@LABEL@4_73
.BB@LABEL@4_61:	; switch_clause_bb257
	movw ax, #0x0003
	br $!.BB@LABEL@4_6
.BB@LABEL@4_62:	; switch_clause_bb258
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 321
	call !!_pdc_get_req_cur
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 342
	or a, x
	bnz $.BB@LABEL@4_64
.BB@LABEL@4_63:	; if_then_bb265
	movw ax, #0x4006
	br $.BB@LABEL@4_65
.BB@LABEL@4_64:	; if_else_bb266
	movw ax, #0x4002
.BB@LABEL@4_65:	; if_else_bb266
	movw [sp+0x08], ax
	mov b, #0x3C
	br $.BB@LABEL@4_73
.BB@LABEL@4_66:	; switch_clause_bb268
	movw ax, #0x4806
	br $.BB@LABEL@4_65
.BB@LABEL@4_67:	; switch_clause_bb269
	mov b, #0x3A
	clrb a
	br $.BB@LABEL@4_74
.BB@LABEL@4_68:	; switch_clause_bb270
	mov b, #0x4D
	clrb a
	br $.BB@LABEL@4_74
.BB@LABEL@4_69:	; switch_clause_bb272
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 404
	call !!_pdc_get_req_cur
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 405
	or a, x
	bnz $.BB@LABEL@4_71
.BB@LABEL@4_70:	; if_then_bb279
	clrw ax
	br $.BB@LABEL@4_72
.BB@LABEL@4_71:	; if_else_bb280
	movw ax, #0x0003
.BB@LABEL@4_72:	; if_else_bb280
	movw [sp+0x08], ax
	mov b, #0x39
.BB@LABEL@4_73:	; if_else_bb280
	oneb a
.BB@LABEL@4_74:	; switch_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 421
	mov1 CY, a.0
	onew ax
	push ax
	movw ax, #0x0002
	push ax
	bnc $.BB@LABEL@4_76
.BB@LABEL@4_75:	; if_then_bb288
	movw ax, sp
	addw ax, #0x000C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 422
	movw de, ax
	mov x, #0x08
	br $.BB@LABEL@4_77
.BB@LABEL@4_76:	; if_else_bb290
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 433
	movw de, #LOWW(_gDCInfo+0x00006)
	mov x, #0x09
.BB@LABEL@4_77:	; if_else_bb290
	mov a, b
	movw bc, #0x0200
	call !!_smbm_set_protocol
	addw sp, #0x0E
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 444
	ret
.LFE4:
	.TYPE _isl95338_end_processing,function,.LFE5-_isl95338_end_processing
_isl95338_end_processing:
	.STACK _isl95338_end_processing = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 449
	cmp !LOWW(_gSmbmInfo), #0x18
	bnz $.BB@LABEL@5_2
.BB@LABEL@5_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 450
	set1 !LOWW(_gSubDevErr).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 451
	mov a, !LOWW(_gSmbmInfo+0x00002)
	mov !LOWW(_gSubDevErr+0x00001), a
.BB@LABEL@5_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 453
	call !!_smbm_clr_status
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 455
	clrb !LOWW(_gIsl95338Info)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 456
	clr1 !LOWW(_gSubdevInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/subdev/isl95338.c", 458
	ret
.LFE5:
	.SECTION .bss,BSS
	.TYPE _gIsl95338Info,object,2
_gIsl95338Info:
	.DS (2)
	.SECTION .const, CONST
	.ALIGN 2
.SWITCH@LABEL@4_1:
	.DB2 LOWW(.BB@LABEL@4_63)
	.DB2 LOWW(.BB@LABEL@4_3)
	.DB2 LOWW(.BB@LABEL@4_4)
	.DB2 LOWW(.BB@LABEL@4_5)
	.DB2 LOWW(.BB@LABEL@4_71)
	.DB2 LOWW(.BB@LABEL@4_2)
	.DB2 LOWW(.BB@LABEL@4_7)
	.DB2 LOWW(.BB@LABEL@4_22)
	.DB2 LOWW(.BB@LABEL@4_37)
	.DB2 LOWW(.BB@LABEL@4_38)
	.DB2 LOWW(.BB@LABEL@4_40)
	.DB2 LOWW(.BB@LABEL@4_41)
	.DB2 LOWW(.BB@LABEL@4_42)
	.DB2 LOWW(.BB@LABEL@4_57)
	.DB2 LOWW(.BB@LABEL@4_61)
	.DB2 LOWW(.BB@LABEL@4_62)
	.DB2 LOWW(.BB@LABEL@4_66)
	.DB2 LOWW(.BB@LABEL@4_67)
	.DB2 LOWW(.BB@LABEL@4_68)
	.DB2 LOWW(.BB@LABEL@4_70)
	.DB2 LOWW(.BB@LABEL@4_69)
	.DB LOW(HIGHW(.BB@LABEL@4_63))
	.DB LOW(HIGHW(.BB@LABEL@4_3))
	.DB LOW(HIGHW(.BB@LABEL@4_4))
	.DB LOW(HIGHW(.BB@LABEL@4_5))
	.DB LOW(HIGHW(.BB@LABEL@4_71))
	.DB LOW(HIGHW(.BB@LABEL@4_2))
	.DB LOW(HIGHW(.BB@LABEL@4_7))
	.DB LOW(HIGHW(.BB@LABEL@4_22))
	.DB LOW(HIGHW(.BB@LABEL@4_37))
	.DB LOW(HIGHW(.BB@LABEL@4_38))
	.DB LOW(HIGHW(.BB@LABEL@4_40))
	.DB LOW(HIGHW(.BB@LABEL@4_41))
	.DB LOW(HIGHW(.BB@LABEL@4_42))
	.DB LOW(HIGHW(.BB@LABEL@4_57))
	.DB LOW(HIGHW(.BB@LABEL@4_61))
	.DB LOW(HIGHW(.BB@LABEL@4_62))
	.DB LOW(HIGHW(.BB@LABEL@4_66))
	.DB LOW(HIGHW(.BB@LABEL@4_67))
	.DB LOW(HIGHW(.BB@LABEL@4_68))
	.DB LOW(HIGHW(.BB@LABEL@4_70))
	.DB LOW(HIGHW(.BB@LABEL@4_69))
