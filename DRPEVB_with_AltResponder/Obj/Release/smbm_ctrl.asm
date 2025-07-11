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

	.EXTERN _gSubdevInfo
	.PUBLIC _gSmbmInfo
	.PUBLIC _smbm_init
	.EXTERN _pdc_set_int_routine
	.PUBLIC _smbm_ctrl
	.EXTERN _subdev_get_alert_signal
	.EXTERN _subdev_get_alerthandler
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pd_tm_chk_user_stat
	.EXTERN _pd_tm_stop_user_cnt
	.PUBLIC _smbm_set_subdev
	.PUBLIC _smbm_set_protocol
	.PUBLIC _smbm_clr_status
	.PUBLIC _smbm_reset
	.PUBLIC _smbm_int_write_routine
	.PUBLIC _smbm_int_read_routine
	.PUBLIC _smbm_copy_word
	.EXTERN _pdc_timer_active

	.SECTION .textf,TEXTF
	.TYPE _smbm_init,function,.LFE1-_smbm_init
_smbm_init:
	.STACK _smbm_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 55
	clrb !LOWW(_gSmbmInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 56
	clrb !LOWW(_gSmbmInfo+0x00001)
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 57
	movw !LOWW(_gSmbmInfo+0x00004), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 58
	movw !LOWW(_gSmbmInfo+0x00008), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 59
	movw !LOWW(_gSmbmInfo+0x00006), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 58
	clrb !LOWW(_gSmbmInfo+0x0000A)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 60
	clrb !LOWW(_gSmbmInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 61
	clrb !LOWW(_gSmbmInfo+0x00003)
	movw de, #0x00FC
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 63
	mov a, [de]
	set1 a.1
	mov [de], a
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 68
	movw !0x0508, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 70
	movw de, #0x0000
	clrw bc
	mov a, #0x10
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 72
	clr1 0xFFFE7.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 74
	ret
.LFE1:
	.TYPE _smbm_ctrl,function,.LFE2-_smbm_ctrl
_smbm_ctrl:
	.STACK _smbm_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 84
	call !!_subdev_get_alert_signal
	cmp0 a
	bz $.BB@LABEL@2_2
.BB@LABEL@2_1:	; bb
	movw ax, !0x0504
	shlw ax, 0x08
	bnc $.BB@LABEL@2_6
.BB@LABEL@2_2:	; bb14
	cmp0 !LOWW(_gSubdevInfo+0x00002)
	bnz $.BB@LABEL@2_6
.BB@LABEL@2_3:	; bb26
	cmp0 !LOWW(_gSmbmInfo+0x00003)
	bnz $.BB@LABEL@2_6
.BB@LABEL@2_4:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 87
	call !!_subdev_get_alerthandler
	cmp0 a
	skz
.BB@LABEL@2_5:	; if_then_bb44
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 88
	mov !LOWW(_gSubdevInfo+0x00002), #0xFF
.BB@LABEL@2_6:	; if_break_bb45
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 92
	mov a, !LOWW(_gSmbmInfo)
	dec a
	cmp0 a
	bz $.BB@LABEL@2_11
.BB@LABEL@2_7:	; if_break_bb45
	dec a
	cmp0 a
	bz $.BB@LABEL@2_16
.BB@LABEL@2_8:	; if_break_bb45
	cmp a, #0x05
	bnz $.BB@LABEL@2_25
.BB@LABEL@2_9:	; switch_clause_bb102
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 135
	mov a, !LOWW(_gSmbmInfo+0x00001)
	cmp0 a
	bnz $.BB@LABEL@2_20
.BB@LABEL@2_10:	; switch_clause_bb102.if_break_bb118_crit_edge
	mov a, #0x0E
	br $.BB@LABEL@2_23
.BB@LABEL@2_11:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 97
	mov a, !LOWW(_gSmbmInfo+0x00001)
	cmp0 a
	bnz $.BB@LABEL@2_13
.BB@LABEL@2_12:	; switch_clause_bb.if_break_bb62_crit_edge
	mov a, #0x06
	br $.BB@LABEL@2_23
.BB@LABEL@2_13:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 101
	dec a
	bnz $.BB@LABEL@2_15
.BB@LABEL@2_14:	; if_else_bb.if_break_bb62_crit_edge
	mov a, #0x02
	br $.BB@LABEL@2_23
.BB@LABEL@2_15:	; if_else_bb60
	oneb a
	br $.BB@LABEL@2_23
.BB@LABEL@2_16:	; switch_clause_bb76
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 119
	movw ax, !LOWW(_gSmbmInfo+0x00004)
	cmpw ax, #0x0000
	bz $.BB@LABEL@2_25
.BB@LABEL@2_17:	; if_then_bb81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 120
	movw bc, ax
	mov a, #0x07
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	bnz $.BB@LABEL@2_25
.BB@LABEL@2_18:	; if_then_bb88
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 121
	mov a, #0x07
	call !!_pd_tm_stop_user_cnt
	movw ax, #0xFFFF
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 122
	addw ax, !LOWW(_gSmbmInfo+0x00004)
	movw !LOWW(_gSmbmInfo+0x00004), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 123
	or a, x
	bnz $.BB@LABEL@2_24
.BB@LABEL@2_19:	; if_then_bb96
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 124
	movw !0x0500, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 125
	mov !LOWW(_gSmbmInfo+0x00002), #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 126
	mov !LOWW(_gSmbmInfo), #0x18
	ret
.BB@LABEL@2_20:	; if_else_bb109
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 139
	dec a
	bnz $.BB@LABEL@2_22
.BB@LABEL@2_21:	; if_else_bb109.if_break_bb118_crit_edge
	mov a, #0x0A
	br $.BB@LABEL@2_23
.BB@LABEL@2_22:	; if_else_bb116
	clrb a
.BB@LABEL@2_23:	; if_break_bb118
	mov !LOWW(_gSmbmInfo), #0x02
	shrw ax, 8+0x00000
	movw bc, ax
	movw ax, #0xFFFF
	addw ax, !LOWW(_gSmbmInfo+0x00006)
	shlw ax, 0x08
	addw ax, bc
	movw !0x0500, ax
	movw ax, !LOWW(_gSmbmInfo+0x00004)
	or a, x
	bz $.BB@LABEL@2_25
.BB@LABEL@2_24:	; if_then_bb129
	mov a, #0x07
	call !!_pd_tm_start_user_cnt
.BB@LABEL@2_25:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 158
	ret
.LFE2:
	.TYPE _smbm_set_subdev,function,.LFE3-_smbm_set_subdev
_smbm_set_subdev:
	.STACK _smbm_set_subdev = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 163
	cmp0 !LOWW(_gSmbmInfo)
	sknz
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 167
	movw !0x050C, ax
.BB@LABEL@3_2:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 171
	ret
.LFE3:
	.TYPE _smbm_set_protocol,function,.LFE4-_smbm_set_protocol
_smbm_set_protocol:
	.STACK _smbm_set_protocol = 12
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 176
	push de
	push bc
	push hl
	push ax
	mov h, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 181
	movw ax, !0x0508
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 183
	mov a, !LOWW(_gSmbmInfo)
	mov b, a
	cmp0 a
	bz $.BB@LABEL@4_2
.BB@LABEL@4_1:	; entry
	mov a, b
	cmp a, #0x06
	.bnz $!.BB@LABEL@4_18
.BB@LABEL@4_2:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 186
	mov a, c
	mov x, #0x80
	mulu x
	movw bc, ax
	mov a, [sp+0x00]
	shrw ax, 8+0x00000
	movw de, ax
	mov a, h
	movw hl, sp
	clrb x
	or a, b
	xch a, x
	or a, c
	or a, e
	xch a, x
	or a, d
	movw !0x0510, ax
	movw ax, [sp+0x0C]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 187
	movw !LOWW(_gSmbmInfo+0x00006), ax
	movw ax, [sp+0x06]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 188
	or a, x
	bz $.BB@LABEL@4_4
.BB@LABEL@4_3:	; if_then_bb.bb42_crit_edge
	mov b, #0x0F
	br $.BB@LABEL@4_5
.BB@LABEL@4_4:	; bb41
	clrb b
.BB@LABEL@4_5:	; bb42
	movw ax, [sp+0x06]
	movw !LOWW(_gSmbmInfo+0x00008), ax
	mov a, b
	mov !LOWW(_gSmbmInfo+0x0000A), a
	mov a, [sp+0x05]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 189
	mov !LOWW(_gSmbmInfo+0x00001), a
	mov a, [hl]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 191
	shrw ax, 8+0x00000
	shrw ax, 0x01
	bc $.BB@LABEL@4_10
.BB@LABEL@4_6:	; if_then_bb54
	onew ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 193
	addw ax, !LOWW(_gSmbmInfo+0x00006)
	shrw ax, 0x01
	movw [sp+0x04], ax
	movw ax, #0x0514
	clrw bc
	br $.BB@LABEL@4_8
.BB@LABEL@4_7:	; bb58
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 197
	movw ax, bc
	addw ax, ax
	addw ax, [hl+0x06]
	movw de, ax
	movw ax, [de]
	movw de, ax
	movw ax, [hl]
	xchw ax, de
	movw [de], ax
	movw ax, [hl]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 198
	addw ax, #0x0002
	incw bc
.BB@LABEL@4_8:	; bb58
	movw [hl], ax
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 195
	cmpw ax, [hl+0x04]
	bc $.BB@LABEL@4_7
.BB@LABEL@4_9:	; bb76
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 200
	mov a, #LOW(HIGHW(_smbm_int_write_routine))
	movw bc, #LOWW(_smbm_int_write_routine)
	br $.BB@LABEL@4_11
.BB@LABEL@4_10:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 203
	mov a, #LOW(HIGHW(_smbm_int_read_routine))
	movw bc, #LOWW(_smbm_int_read_routine)
.BB@LABEL@4_11:	; if_else_bb
	shrw ax, 8+0x00000
	movw de, ax
	mov a, #0x10
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 206
	cmp !LOWW(_gSmbmInfo+0x00001), #0x01
	mov a, [sp+0x02]
	mov x, a
	bnz $.BB@LABEL@4_13
.BB@LABEL@4_12:	; if_then_bb88
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 207
	set1 a.3
	mov [sp+0x02], a
	mov a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 208
	or a, #0x09
	br $.BB@LABEL@4_14
.BB@LABEL@4_13:	; if_else_bb103
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 211
	set1 a.0
.BB@LABEL@4_14:	; if_else_bb103
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 216
	movw ax, [sp+0x02]
	movw !0x0508, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 218
	cmp0 !LOWW(_gSmbmInfo)
	bnz $.BB@LABEL@4_16
.BB@LABEL@4_15:	; if_break_bb111.if_break_bb121_crit_edge
	oneb a
	br $.BB@LABEL@4_17
.BB@LABEL@4_16:	; if_else_bb120
	mov a, #0x07
.BB@LABEL@4_17:	; if_break_bb121
	mov !LOWW(_gSmbmInfo), a
	movw ax, [sp+0x0E]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 225
	movw !LOWW(_gSmbmInfo+0x00004), ax
.BB@LABEL@4_18:	; return
	addw sp, #0x08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 228
	ret
.LFE4:
	.TYPE _smbm_clr_status,function,.LFE5-_smbm_clr_status
_smbm_clr_status:
	.STACK _smbm_clr_status = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 235
	mov a, !LOWW(_gSmbmInfo)
	cmp a, #0x18
	bz $.BB@LABEL@5_2
.BB@LABEL@5_1:	; entry
	cmp a, #0x06
	bnz $.BB@LABEL@5_3
.BB@LABEL@5_2:	; if_then_bb
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 238
	movw !0x0500, ax
.BB@LABEL@5_3:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 241
	clrb !LOWW(_gSmbmInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 243
	ret
.LFE5:
	.TYPE _smbm_reset,function,.LFE6-_smbm_reset
_smbm_reset:
	.STACK _smbm_reset = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 251
	di
	movw ax, #0x000F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 252
	movw !0x0504, ax
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 256
	movw !0x0508, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 259
	movw de, #0x0000
	clrw bc
	mov a, #0x10
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 261
	mov a, !LOWW(_gSmbmInfo)
	shrw ax, 8+0x00000
	shlw ax, 0x0F
	bnc $.BB@LABEL@6_2
.BB@LABEL@6_1:	; if_then_bb
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 262
	movw !0x0500, ax
.BB@LABEL@6_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 265
	clrb !LOWW(_gSmbmInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 267
	ei
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 269
	ret
.LFE6:
	.TYPE _smbm_int_write_routine,function,.LFE7-_smbm_int_write_routine
_smbm_int_write_routine:
	.STACK _smbm_int_write_routine = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 275
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 280
	movw ax, !0x0504
	movw [sp+0x00], ax
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 282
	bf [hl].1, $.BB@LABEL@7_2
.BB@LABEL@7_1:	; entry.bb26_crit_edge
	clrb a
	br $.BB@LABEL@7_4
.BB@LABEL@7_2:	; bb
	movw ax, sp
	movw hl, ax
	bt [hl].2, $.BB@LABEL@7_1
.BB@LABEL@7_3:	; bb25
	oneb a
.BB@LABEL@7_4:	; bb26
	cmp0 a
	mov a, [sp+0x00]
	mov x, a
	bnz $.BB@LABEL@7_6
.BB@LABEL@7_5:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 284
	mov a, [sp+0x00]
	shr a, 0x01
	and a, #0x02
	mov b, a
	mov a, x
	mov1 CY, a.1
	mov a, b
	mov1 a.2, CY
	mov !LOWW(_gSmbmInfo+0x00002), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 285
	mov !LOWW(_gSmbmInfo), #0x18
	br $.BB@LABEL@7_10
.BB@LABEL@7_6:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 287
	bf a.3, $.BB@LABEL@7_8
.BB@LABEL@7_7:	; if_then_bb62
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 288
	mov !LOWW(_gSmbmInfo), #0x06
	br $.BB@LABEL@7_10
.BB@LABEL@7_8:	; if_else_bb63
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@7_11
.BB@LABEL@7_9:	; if_then_bb75
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 291
	mov !LOWW(_gSmbmInfo), #0x08
.BB@LABEL@7_10:	; if_then_bb99
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 301
	mov a, #0x07
	call !!_pd_tm_stop_user_cnt
	movw ax, #0x000F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 304
	movw !0x0504, ax
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 309
	movw !0x0508, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 311
	movw de, #0x0000
	clrw bc
	mov a, #0x10
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 312
	call !!_pdc_timer_active
.BB@LABEL@7_11:	; if_else_bb76
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 315
	ret
.LFE7:
	.TYPE _smbm_int_read_routine,function,.LFE8-_smbm_int_read_routine
_smbm_int_read_routine:
	.STACK _smbm_int_read_routine = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 320
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 325
	movw ax, !0x0504
	movw [sp+0x00], ax
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 327
	bf [hl].1, $.BB@LABEL@8_2
.BB@LABEL@8_1:	; entry.bb26_crit_edge
	clrb a
	br $.BB@LABEL@8_4
.BB@LABEL@8_2:	; bb
	movw ax, sp
	movw hl, ax
	bt [hl].2, $.BB@LABEL@8_1
.BB@LABEL@8_3:	; bb25
	oneb a
.BB@LABEL@8_4:	; bb26
	cmp0 a
	mov a, [sp+0x00]
	mov x, a
	bnz $.BB@LABEL@8_6
.BB@LABEL@8_5:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 329
	mov a, [sp+0x00]
	shr a, 0x01
	and a, #0x02
	mov b, a
	mov a, x
	mov1 CY, a.1
	mov a, b
	mov1 a.2, CY
	mov !LOWW(_gSmbmInfo+0x00002), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 330
	mov !LOWW(_gSmbmInfo), #0x18
	br $.BB@LABEL@8_10
.BB@LABEL@8_6:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 332
	bf a.3, $.BB@LABEL@8_8
.BB@LABEL@8_7:	; if_then_bb62
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 333
	mov !LOWW(_gSmbmInfo), #0x06
	br $.BB@LABEL@8_10
.BB@LABEL@8_8:	; if_else_bb63
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@8_13
.BB@LABEL@8_9:	; if_then_bb75
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 336
	mov !LOWW(_gSmbmInfo), #0x08
.BB@LABEL@8_10:	; if_then_bb99
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 347
	mov a, #0x07
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 349
	cmp !LOWW(_gSmbmInfo), #0x18
	bz $.BB@LABEL@8_12
.BB@LABEL@8_11:	; if_then_bb106
	onew ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 350
	addw ax, !LOWW(_gSmbmInfo+0x00006)
	shrw ax, 0x01
	movw de, ax
	movw bc, !LOWW(_gSmbmInfo+0x00008)
	movw ax, #0x0514
	call $!_smbm_copy_word
.BB@LABEL@8_12:	; if_break_bb113
	movw ax, #0x000F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 354
	movw !0x0504, ax
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 358
	movw !0x0508, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 360
	movw de, #0x0000
	clrw bc
	mov a, #0x10
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 361
	call !!_pdc_timer_active
.BB@LABEL@8_13:	; if_else_bb76
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 364
	ret
.LFE8:
	.TYPE _smbm_copy_word,function,.LFE9-_smbm_copy_word
_smbm_copy_word:
	.STACK _smbm_copy_word = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 366
	push ax
	push hl
	push bc
	clrw ax
	br $.BB@LABEL@9_2
.BB@LABEL@9_1:	; bb
	movw ax, [sp+0x04]
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 371
	movw ax, [hl]
	movw bc, ax
	pop hl
	push hl
	movw ax, bc
	movw [hl], ax
	movw ax, [sp+0x04]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 373
	addw ax, #0x0002
	movw [sp+0x04], ax
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 372
	addw ax, #0x0002
	movw [sp+0x00], ax
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 373
	incw ax
.BB@LABEL@9_2:	; bb
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 370
	cmpw ax, de
	bc $.BB@LABEL@9_1
.BB@LABEL@9_3:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/smbm_ctrl.c", 376
	addw sp, #0x06
	ret
.LFE9:
	.SECTION .bss,BSS
	.ALIGN 2
	.TYPE _gSmbmInfo,object,12
_gSmbmInfo:
	.DS (12)
