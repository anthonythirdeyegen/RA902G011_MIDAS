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

	.EXTERN _gSndMess
	.EXTERN _gusTemp
	.EXTERN _gucVdmFlg
	.PUBLIC _user_func_chk_device
	.EXTERN _pdc_get_status
	.EXTERN _pdc_get_an_volt
	.EXTERN _pdc_is_pps_mode
	.EXTERN _pdc_get_req_volt
	.EXTERN _pdc_set_dev_stat
	.PUBLIC _user_func_snd_mess
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_cmd_result
	.PUBLIC _user_func_start_timer_thermistor
	.PUBLIC _user_func_stop_timer_thermistor
	.PUBLIC _user_func_intr_timer_thermistor
	.EXTERN _pdc_set_int_routine
	.EXTERN _pdc_req_update_an
	.EXTERN _pdc_timer_active

	.SECTION .textf,TEXTF
	.TYPE _user_func_chk_device,function,.LFE1-_user_func_chk_device
_user_func_chk_device:
	.STACK _user_func_chk_device = 14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 22
	subw sp, #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 27
	call !!_pdc_get_status
	movw [sp+0x08], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 28
	oneb a
	call !!_pdc_get_an_volt
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 29
	mov a, #0x04
	call !!_pdc_get_an_volt
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 33
	mov a, [sp+0x08]
	bt a.1, $.BB@LABEL@1_2
.BB@LABEL@1_1:	; entry.if_break_bb54_crit_edge
	clrb a
	br $.BB@LABEL@1_8
.BB@LABEL@1_2:	; bb
	call !!_pdc_is_pps_mode
	cmp0 a
	bnz $.BB@LABEL@1_1
.BB@LABEL@1_3:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 34
	movw ax, sp
	addw ax, #0x0009
	movw hl, ax
	bf [hl].7, $.BB@LABEL@1_1
.BB@LABEL@1_4:	; if_then_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 35
	call !!_pdc_get_req_volt
	movw bc, #0x0055
	mulhu
	movw hl, #0x0000
	movw de, #0x0064
	divwu
	movw de, ax
	movw ax, [sp+0x00]
	sarw ax, 0x0F
	cmpw ax, bc
	movw ax, [sp+0x00]
	sknz
.BB@LABEL@1_5:	; if_then_bb42
	cmpw ax, de
.BB@LABEL@1_6:	; if_then_bb42
	bnc $.BB@LABEL@1_1
.BB@LABEL@1_7:	; if_then_bb52
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 37
	clrb !LOWW(_gucVdmFlg)
	oneb a
.BB@LABEL@1_8:	; if_then_bb52
	mov [sp+0x07], a
	movw ax, sp
	addw ax, #0x0008
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 42
	bt [hl].0, $.BB@LABEL@1_10
.BB@LABEL@1_9:	; if_break_bb54.if_break_bb90_crit_edge
	clrb a
	br $.BB@LABEL@1_15
.BB@LABEL@1_10:	; bb64
	movw ax, sp
	addw ax, #0x0008
	movw hl, ax
	bt [hl].1, $.BB@LABEL@1_9
.BB@LABEL@1_11:	; if_then_bb82
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 43
	sarw ax, 0x0F
	cmpw ax, #0x0000
	movw ax, [sp+0x00]
	sknz
.BB@LABEL@1_12:	; if_then_bb82
	cmpw ax, #0x59D9
.BB@LABEL@1_13:	; if_then_bb82
	bc $.BB@LABEL@1_9
.BB@LABEL@1_14:	; if_then_bb88
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 45
	clrb !LOWW(_gucVdmFlg)
	oneb a
.BB@LABEL@1_15:	; if_then_bb88
	mov [sp+0x06], a
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 49
	addw ax, ax
	bnh $.BB@LABEL@1_26
.BB@LABEL@1_16:	; if_then_bb95
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 50
	cmpw ax, #0x0AED
	bc $.BB@LABEL@1_18
.BB@LABEL@1_17:	; if_then_bb101
	movw ax, #0x0AEC
	br $.BB@LABEL@1_21
.BB@LABEL@1_18:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 53
	cmpw ax, #0x00A7
	bc $.BB@LABEL@1_20
.BB@LABEL@1_19:	; if_else_bb.bb164_crit_edge
	mov a, #0x06
	mov b, a
	br $.BB@LABEL@1_25
.BB@LABEL@1_20:	; if_then_bb108
	clrw ax
.BB@LABEL@1_21:	; if_then_bb108
	movw !LOWW(_gusTemp), ax
	br $.BB@LABEL@1_26
.BB@LABEL@1_22:	; bb110
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 59
	sarw ax, 8+0x00000
	addw ax, ax
	movw [sp+0x00], ax
	addw ax, #SMRLW(_temp_table_volt@2@user_func_chk_device)
	movw hl, ax
	movw ax, [sp+0x02]
	cmpw ax, [hl+0x00]
	bnh $.BB@LABEL@1_24
.BB@LABEL@1_23:	; if_then_bb119
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 60
	sarw ax, 8+0x00000
	addw ax, ax
	addw ax, #SMRLW(_temp_table_temp@1@user_func_chk_device)
	movw de, ax
	movw ax, [de]
	movw [sp+0x04], ax
	movw ax, de
	addw ax, #0x0002
	movw hl, ax
	movw ax, [sp+0x00]
	addw ax, #SMRLW(_temp_table_volt@2@user_func_chk_device)
	movw [sp+0x00], ax
	movw de, ax
	movw ax, [de]
	movw de, ax
	movw ax, [hl]
	movw hl, sp
	subw ax, [hl+0x04]
	movw bc, ax
	movw ax, [sp+0x02]
	subw ax, de
	mulhu
	movw [sp+0x02], ax
	movw ax, [hl]
	addw ax, #0x0002
	movw hl, ax
	movw ax, [hl]
	subw ax, de
	movw de, ax
	movw ax, [sp+0x02]
	movw hl, #0x0000
	divwu
	movw bc, ax
	movw ax, [sp+0x04]
	addw ax, bc
	br $.BB@LABEL@1_21
.BB@LABEL@1_24:	; if_break_bb161
	dec b
	mov a, b
.BB@LABEL@1_25:	; bb164
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 58
	bf a.7, $.BB@LABEL@1_22
.BB@LABEL@1_26:	; if_break_bb174
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 70
	movw ax, !LOWW(_gusTemp)
	cmpw ax, #0x0051
	bc $.BB@LABEL@1_28
.BB@LABEL@1_27:	; if_then_bb179
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 73
	clrb !LOWW(_gucVdmFlg)
	oneb a
	mov [sp+0x01], a
	mov [sp+0x00], #0x03
	br $.BB@LABEL@1_31
.BB@LABEL@1_28:	; if_else_bb180
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 75
	cmpw ax, #0x003D
	clrb a
	mov [sp+0x01], a
	bnc $.BB@LABEL@1_30
.BB@LABEL@1_29:	; if_else_bb180.if_break_bb187_crit_edge
	oneb a
	mov [sp+0x00], a
	br $.BB@LABEL@1_31
.BB@LABEL@1_30:	; if_then_bb185
	mov [sp+0x00], #0x02
.BB@LABEL@1_31:	; if_break_bb187
	movw ax, sp
	addw ax, #0x0008
	movw hl, ax
	bt [hl].0, $.BB@LABEL@1_34
.BB@LABEL@1_32:	; if_break_bb187
	mov a, [sp+0x01]
	cmp0 a
	sknz
.BB@LABEL@1_33:	; if_then_bb210
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 80
	call $!_user_func_stop_timer_thermistor
.BB@LABEL@1_34:	; if_break_bb211
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 83
	mov a, !LOWW(_gusTemp)
	mov e, a
	mov a, [sp+0x00]
	mov b, a
	mov a, [sp+0x06]
	mov c, a
	mov a, [sp+0x01]
	mov x, a
	mov a, [sp+0x07]
	call !!_pdc_set_dev_stat
	movw ax, sp
	addw ax, #0x0008
	movw hl, ax
	bf [hl].1, $.BB@LABEL@1_36
.BB@LABEL@1_35:	; bb227
	movw ax, sp
	addw ax, #0x0009
	movw hl, ax
	bt [hl].7, $.BB@LABEL@1_39
.BB@LABEL@1_36:	; if_else_bb246
	mov a, [sp+0x06]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 120
	shrw ax, 8+0x00000
	movw bc, ax
	clrw ax
	subw ax, bc
	movw de, ax
	mov a, [sp+0x01]
	shrw ax, 8+0x00000
	movw bc, ax
	mov a, [sp+0x07]
	shrw ax, 8+0x00000
	addw ax, bc
	cmpw ax, de
	bnz $.BB@LABEL@1_39
.BB@LABEL@1_37:	; bb258
	mov a, #0x07
.BB@LABEL@1_38:	; bb258
	addw sp, #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 122
	ret
.BB@LABEL@1_39:	; bb266
	clrb a
	br $.BB@LABEL@1_38
.LFE1:
	.TYPE _user_func_snd_mess,function,.LFE2-_user_func_snd_mess
_user_func_snd_mess:
	.STACK _user_func_snd_mess = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 124
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 126
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 128
	mov a, [sp+0x01]
	mov1 CY, a.7
	mov a, !LOWW(_gucVdmFlg)
	bnc $.BB@LABEL@2_9
.BB@LABEL@2_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 129
	cmp0 a
	bnz $.BB@LABEL@2_12
.BB@LABEL@2_2:	; if_then_bb17
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 131
	movw de, !LOWW(_gSndMess)
	bf [hl].6, $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb17.if_break_bb_crit_edge
	movw ax, #0xA001
	br $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_else_bb
	movw ax, #0x8001
.BB@LABEL@2_5:	; if_break_bb
	movw [de], ax
	movw ax, sp
	movw hl, ax
	bt [hl].6, $.BB@LABEL@2_8
.BB@LABEL@2_6:	; bb
	movw ax, sp
	movw hl, ax
	bf [hl].1, $.BB@LABEL@2_11
.BB@LABEL@2_7:	; bb52
	movw ax, sp
	movw hl, ax
	bf [hl].2, $.BB@LABEL@2_11
.BB@LABEL@2_8:	; if_then_bb77
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 141
	movw de, !LOWW(_gSndMess)
	movw ax, #0xFF00
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 142
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 143
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 144
	oneb !LOWW(_gucVdmFlg)
	br $.BB@LABEL@2_12
.BB@LABEL@2_9:	; if_else_bb86
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 151
	dec a
	bnz $.BB@LABEL@2_12
.BB@LABEL@2_10:	; if_then_bb93
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 152
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	skz
.BB@LABEL@2_11:	; if_then_bb99
	mov !LOWW(_gucVdmFlg), #0x02
.BB@LABEL@2_12:	; if_break_bb102
	mov a, #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 159
	cmp !LOWW(_gucVdmFlg), #0x01
	sknz
.BB@LABEL@2_13:	; if_break_bb102
	clrb a
.BB@LABEL@2_14:	; if_break_bb102
	pop bc
	ret
.LFE2:
	.TYPE _user_func_start_timer_thermistor,function,.LFE3-_user_func_start_timer_thermistor
_user_func_start_timer_thermistor:
	.STACK _user_func_start_timer_thermistor = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 169
	mov a, #LOW(HIGHW(_user_func_intr_timer_thermistor))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_user_func_intr_timer_thermistor)
	mov a, #0x0D
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 171
	movw 0xFFF66, #0x2DB3
	movw de, #0x01B2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 172
	movw ax, [de+0x04]
	or a, #0x10
	movw [de+0x04], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 173
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 174
	clr1 0xFFFE6.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 175
	movw ax, [de]
	xch a, x
	or a, #0x08
	xch a, x
	movw [de], ax
	ret
.LFE3:
	.TYPE _user_func_stop_timer_thermistor,function,.LFE4-_user_func_stop_timer_thermistor
_user_func_stop_timer_thermistor:
	.STACK _user_func_stop_timer_thermistor = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 178
	movw de, #0x01B4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 180
	movw ax, [de]
	xch a, x
	or a, #0x08
	xch a, x
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 181
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 182
	set1 0xFFFE6.5
	ret
.LFE4:
	.TYPE _user_func_intr_timer_thermistor,function,.LFE5-_user_func_intr_timer_thermistor
_user_func_intr_timer_thermistor:
	.STACK _user_func_intr_timer_thermistor = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 187
	oneb a
	call !!_pdc_req_update_an
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/PDC/user_main_protection.c", 188
	call !!_pdc_timer_active
	ret
.LFE5:
	.SECTION .const,CONST
	.ALIGN 2
	.TYPE _temp_table_volt@2@user_func_chk_device,object,16
_temp_table_volt@2@user_func_chk_device:
	.DB2 0x00A7,0x0175,0x0230,0x031F,0x07CD,0x08D1,0x09AC,0x0AEC
	.ALIGN 2
	.TYPE _temp_table_temp@1@user_func_chk_device,object,16
_temp_table_temp@1@user_func_chk_device:
	.DB2 0x0003,0x0014,0x001E,0x0028,0x0050,0x005A,0x0064,0x0078
