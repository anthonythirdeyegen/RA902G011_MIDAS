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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_59a5d8447a894e378cfee1e352f48c4brd5t4jkp.pur
#@  compiled at Tue May 06 10:51:03 2025

	.EXTERN _gSndMess
	.EXTERN _gRcvMess
	.EXTERN _gusTemp
	.EXTERN _gucVdmFlg
	.PUBLIC _user_func_chk_device
	.EXTERN _pdc_get_status
	.EXTERN _pdc_get_an_volt
	.EXTERN _pdc_is_pps_mode
	.EXTERN _pdc_get_req_volt
	.EXTERN _pdc_set_dev_stat
	.PUBLIC _user_func_snd_mess
	.EXTERN _pdc_set_user_ams_mode
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_cmd_result
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pd_tm_chk_user_stat
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 22
	subw sp, #0x0A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 27
	call !!_pdc_get_status
	movw [sp+0x08], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 28
	oneb a
	call !!_pdc_get_an_volt
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 29
	mov a, #0x04
	call !!_pdc_get_an_volt
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 33
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 34
	movw ax, sp
	addw ax, #0x0009
	movw hl, ax
	bf [hl].7, $.BB@LABEL@1_1
.BB@LABEL@1_4:	; if_then_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 35
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 37
	clrb !LOWW(_gucVdmFlg)
	oneb a
.BB@LABEL@1_8:	; if_then_bb52
	mov [sp+0x07], a
	movw ax, sp
	addw ax, #0x0008
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 42
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 43
	sarw ax, 0x0F
	cmpw ax, #0x0000
	movw ax, [sp+0x00]
	sknz
.BB@LABEL@1_12:	; if_then_bb82
	cmpw ax, #0x59D9
.BB@LABEL@1_13:	; if_then_bb82
	bc $.BB@LABEL@1_9
.BB@LABEL@1_14:	; if_then_bb88
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 45
	clrb !LOWW(_gucVdmFlg)
	oneb a
.BB@LABEL@1_15:	; if_then_bb88
	mov [sp+0x06], a
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 49
	addw ax, ax
	bnh $.BB@LABEL@1_26
.BB@LABEL@1_16:	; if_then_bb95
	movw ax, [sp+0x02]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 50
	cmpw ax, #0x0AED
	bc $.BB@LABEL@1_18
.BB@LABEL@1_17:	; if_then_bb101
	movw ax, #0x0AEC
	br $.BB@LABEL@1_21
.BB@LABEL@1_18:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 53
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 59
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 60
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 58
	bf a.7, $.BB@LABEL@1_22
.BB@LABEL@1_26:	; if_break_bb174
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 70
	movw ax, !LOWW(_gusTemp)
	cmpw ax, #0x0051
	bc $.BB@LABEL@1_28
.BB@LABEL@1_27:	; if_then_bb179
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 73
	clrb !LOWW(_gucVdmFlg)
	oneb a
	mov [sp+0x01], a
	mov [sp+0x00], #0x03
	br $.BB@LABEL@1_31
.BB@LABEL@1_28:	; if_else_bb180
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 75
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 80
	call $!_user_func_stop_timer_thermistor
.BB@LABEL@1_34:	; if_break_bb211
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 83
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 120
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 122
	ret
.BB@LABEL@1_39:	; bb266
	clrb a
	br $.BB@LABEL@1_38
.LFE1:
	.TYPE _user_func_snd_mess,function,.LFE2-_user_func_snd_mess
_user_func_snd_mess:
	.STACK _user_func_snd_mess = 26
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 124
	subw sp, #0x16
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 126
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 128
	mov a, !LOWW(_gucVdmFlg)
	cmp0 a
	bnz $.BB@LABEL@2_10
.BB@LABEL@2_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 129
	movw ax, sp
	incw ax
	movw hl, ax
	.bf [hl].7, $!.BB@LABEL@2_71
.BB@LABEL@2_2:	; if_then_bb26
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 130
	oneb a
	call !!_pdc_set_user_ams_mode
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 132
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb26.if_break_bb_crit_edge
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
	bf [hl].1, $.BB@LABEL@2_9
.BB@LABEL@2_7:	; bb61
	movw ax, sp
	movw hl, ax
	bf [hl].2, $.BB@LABEL@2_9
.BB@LABEL@2_8:	; if_then_bb86
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 142
	movw de, !LOWW(_gSndMess)
	movw ax, #0xFF00
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 143
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 144
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 145
	oneb !LOWW(_gucVdmFlg)
	br $!.BB@LABEL@2_71
.BB@LABEL@2_9:	; if_else_bb92
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 148
	mov !LOWW(_gucVdmFlg), #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 149
	clrb a
	call !!_pdc_set_user_ams_mode
	br $!.BB@LABEL@2_71
.BB@LABEL@2_10:	; if_else_bb96
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 153
	cmp a, #0x01
	bnz $.BB@LABEL@2_13
.BB@LABEL@2_11:	; if_then_bb102
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 154
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	.bz $!.BB@LABEL@2_71
.BB@LABEL@2_12:	; if_then_bb108
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 157
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 158
	mov !LOWW(_gucVdmFlg), #0x02
	br $!.BB@LABEL@2_71
.BB@LABEL@2_13:	; if_else_bb111
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 161
	cmp a, #0x02
	bnz $.BB@LABEL@2_21
.BB@LABEL@2_14:	; if_then_bb117
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 163
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 164
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x04], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 165
	mov a, [sp+0x02]
	and a, #0x1F
	dec a
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_15:	; bb141
	movw ax, [sp+0x04]
	cmpw ax, #0xFF00
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_16:	; bb156
	mov a, [sp+0x02]
	and a, #0xC0
	cmp a, #0x40
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_17:	; if_then_bb173
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 168
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 169
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_19
.BB@LABEL@2_18:	; if_then_bb173.if_break_bb191_crit_edge
	movw ax, #0xA002
	br $.BB@LABEL@2_20
.BB@LABEL@2_19:	; if_else_bb188
	movw ax, #0x8002
.BB@LABEL@2_20:	; if_break_bb191
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 175
	movw de, !LOWW(_gSndMess)
	movw ax, #0xFF00
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 176
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 177
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 178
	mov !LOWW(_gucVdmFlg), #0x03
	br $!.BB@LABEL@2_71
.BB@LABEL@2_21:	; if_else_bb208
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 186
	cmp a, #0x03
	bnz $.BB@LABEL@2_24
.BB@LABEL@2_22:	; if_then_bb214
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 187
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	.bz $!.BB@LABEL@2_71
.BB@LABEL@2_23:	; if_then_bb220
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 188
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 189
	mov !LOWW(_gucVdmFlg), #0x04
	br $!.BB@LABEL@2_71
.BB@LABEL@2_24:	; if_else_bb223
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 192
	cmp a, #0x04
	bnz $.BB@LABEL@2_32
.BB@LABEL@2_25:	; if_then_bb229
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 194
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x12], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 195
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x14], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 196
	mov a, [sp+0x12]
	and a, #0x1F
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_26:	; bb253
	movw ax, [sp+0x14]
	cmpw ax, #0xFF00
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_27:	; bb268
	mov a, [sp+0x12]
	and a, #0xC0
	cmp a, #0x40
	.bnz $!.BB@LABEL@2_43
.BB@LABEL@2_28:	; if_then_bb285
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 199
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 200
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_30
.BB@LABEL@2_29:	; if_then_bb285.if_break_bb303_crit_edge
	movw ax, #0xA003
	br $.BB@LABEL@2_31
.BB@LABEL@2_30:	; if_else_bb300
	movw ax, #0x8003
.BB@LABEL@2_31:	; if_break_bb303
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 206
	movw de, !LOWW(_gSndMess)
	movw ax, #0x1234
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 207
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 208
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 209
	mov !LOWW(_gucVdmFlg), #0x05
	br $!.BB@LABEL@2_71
.BB@LABEL@2_32:	; if_else_bb320
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 217
	cmp a, #0x05
	bnz $.BB@LABEL@2_35
.BB@LABEL@2_33:	; if_then_bb326
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 218
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	.bz $!.BB@LABEL@2_71
.BB@LABEL@2_34:	; if_then_bb332
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 219
	mov !LOWW(_gucVdmFlg), #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 220
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	br $!.BB@LABEL@2_71
.BB@LABEL@2_35:	; if_else_bb335
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 223
	cmp a, #0x06
	bnz $.BB@LABEL@2_45
.BB@LABEL@2_36:	; if_then_bb341
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 225
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x0E], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 226
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x10], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 227
	mov a, [sp+0x0E]
	and a, #0x1F
	cmp a, #0x03
	bnz $.BB@LABEL@2_43
.BB@LABEL@2_37:	; bb365
	movw ax, [sp+0x10]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_43
.BB@LABEL@2_38:	; bb380
	mov a, [sp+0x0E]
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_43
.BB@LABEL@2_39:	; if_then_bb397
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 230
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 231
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_41
.BB@LABEL@2_40:	; if_then_bb397.if_break_bb415_crit_edge
	movw ax, #0xA004
	br $.BB@LABEL@2_42
.BB@LABEL@2_41:	; if_else_bb412
	movw ax, #0x8004
.BB@LABEL@2_42:	; if_break_bb415
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 237
	movw de, !LOWW(_gSndMess)
	movw ax, #0x1234
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 238
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 239
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 240
	mov !LOWW(_gucVdmFlg), #0x07
	br $!.BB@LABEL@2_71
.BB@LABEL@2_43:	; if_else_bb421
	movw bc, #0x001B
.BB@LABEL@2_44:	; if_else_bb421
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bz $!.BB@LABEL@2_67, $!.BB@LABEL@2_71
.BB@LABEL@2_45:	; if_else_bb432
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 248
	cmp a, #0x07
	bnz $.BB@LABEL@2_48
.BB@LABEL@2_46:	; if_then_bb438
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 249
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	.bz $!.BB@LABEL@2_71
.BB@LABEL@2_47:	; if_then_bb444
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 250
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 251
	mov !LOWW(_gucVdmFlg), #0x08
	br $!.BB@LABEL@2_71
.BB@LABEL@2_48:	; if_else_bb447
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 254
	cmp a, #0x08
	bnz $.BB@LABEL@2_54
.BB@LABEL@2_49:	; if_then_bb453
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 256
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x0A], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 257
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x0C], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 258
	mov a, [sp+0x0A]
	and a, #0x1F
	cmp a, #0x04
	bnz $.BB@LABEL@2_53
.BB@LABEL@2_50:	; bb477
	movw ax, [sp+0x0C]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_53
.BB@LABEL@2_51:	; bb492
	mov a, [sp+0x0A]
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_53
.BB@LABEL@2_52:	; if_then_bb509
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 261
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 262
	mov !LOWW(_gucVdmFlg), #0x09
	br $!.BB@LABEL@2_71
.BB@LABEL@2_53:	; if_else_bb511
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 264
	movw bc, #0x002D
	br $.BB@LABEL@2_44
.BB@LABEL@2_54:	; if_else_bb522
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 270
	cmp a, #0x09
	bnz $.BB@LABEL@2_60
.BB@LABEL@2_55:	; if_then_bb528
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 271
	movw bc, #0xEA60
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_71
.BB@LABEL@2_56:	; if_then_bb534
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 272
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 273
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_58
.BB@LABEL@2_57:	; if_then_bb534.if_break_bb552_crit_edge
	movw ax, #0xA005
	br $.BB@LABEL@2_59
.BB@LABEL@2_58:	; if_else_bb549
	movw ax, #0x8005
.BB@LABEL@2_59:	; if_break_bb552
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 279
	movw de, !LOWW(_gSndMess)
	movw ax, #0x1234
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 280
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 281
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 282
	mov !LOWW(_gucVdmFlg), #0x0A
	br $.BB@LABEL@2_71
.BB@LABEL@2_60:	; if_else_bb559
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 285
	cmp a, #0x0A
	bnz $.BB@LABEL@2_63
.BB@LABEL@2_61:	; if_then_bb565
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 286
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	bz $.BB@LABEL@2_71
.BB@LABEL@2_62:	; if_then_bb571
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 287
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 288
	mov !LOWW(_gucVdmFlg), #0x0B
	br $.BB@LABEL@2_71
.BB@LABEL@2_63:	; if_else_bb574
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 291
	cmp a, #0x0B
	bnz $.BB@LABEL@2_71
.BB@LABEL@2_64:	; if_then_bb580
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 293
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x06], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 294
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x08], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 295
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x05
	bnz $.BB@LABEL@2_68
.BB@LABEL@2_65:	; bb604
	movw ax, [sp+0x08]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_68
.BB@LABEL@2_66:	; bb619
	mov a, [sp+0x06]
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_68
.BB@LABEL@2_67:	; if_then_bb636
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	br $.BB@LABEL@2_70
.BB@LABEL@2_68:	; if_else_bb639
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 302
	movw bc, #0x002D
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	bnz $.BB@LABEL@2_71
.BB@LABEL@2_69:	; if_then_bb645
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 303
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 304
	movw ax, #0x6000
	call !!_pdc_set_cmd
.BB@LABEL@2_70:	; if_then_bb645
	clrb a
	call !!_pdc_set_user_ams_mode
	mov !LOWW(_gucVdmFlg), #0x0F
.BB@LABEL@2_71:	; if_break_bb661
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 310
	mov a, !LOWW(_gucVdmFlg)
	mov x, a
	cmp a, #0x0F
	bz $.BB@LABEL@2_73
.BB@LABEL@2_72:	; if_break_bb661
	clrb b
	br $.BB@LABEL@2_74
.BB@LABEL@2_73:	; if_break_bb661
	oneb b
.BB@LABEL@2_74:	; if_break_bb661
	cmp0 x
	bz $.BB@LABEL@2_76
.BB@LABEL@2_75:	; if_break_bb661
	clrb x
	br $.BB@LABEL@2_77
.BB@LABEL@2_76:	; if_break_bb661
	oneb x
.BB@LABEL@2_77:	; if_break_bb661
	mov a, b
	or x, a
	cmp0 x
	clrb a
	skz
.BB@LABEL@2_78:	; if_break_bb661
	mov a, #0x07
.BB@LABEL@2_79:	; if_break_bb661
	addw sp, #0x16
	ret
.LFE2:
	.TYPE _user_func_start_timer_thermistor,function,.LFE3-_user_func_start_timer_thermistor
_user_func_start_timer_thermistor:
	.STACK _user_func_start_timer_thermistor = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 320
	mov a, #LOW(HIGHW(_user_func_intr_timer_thermistor))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_user_func_intr_timer_thermistor)
	mov a, #0x0D
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 322
	movw 0xFFF66, #0x2DB3
	movw de, #0x01B2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 323
	movw ax, [de+0x04]
	or a, #0x10
	movw [de+0x04], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 324
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 325
	clr1 0xFFFE6.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 326
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 329
	movw de, #0x01B4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 331
	movw ax, [de]
	xch a, x
	or a, #0x08
	xch a, x
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 332
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 333
	set1 0xFFFE6.5
	ret
.LFE4:
	.TYPE _user_func_intr_timer_thermistor,function,.LFE5-_user_func_intr_timer_thermistor
_user_func_intr_timer_thermistor:
	.STACK _user_func_intr_timer_thermistor = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 338
	oneb a
	call !!_pdc_req_update_an
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main_protection.c", 339
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
