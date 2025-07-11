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

	.EXTERN _gSndMess
	.EXTERN _gSmbsEvent
	.EXTERN _gucVdmFlg
	.EXTERN _gucWaitSmbsCmdComp
	.EXTERN _gucDrSwapMode_bak
	.EXTERN _gucPrSwapMode_bak
	.EXTERN _gucInputPwr_bak
	.EXTERN _guCtrlCnf1_bak
	.EXTERN _guCtrlCnf2_bak
	.EXTERN _usSmbsRdo_bak
	.PUBLIC _user_smbs_init
	.EXTERN _smbs_init
	.EXTERN _smbs_set_ctrl_conf1
	.EXTERN _smbs_set_ctrl_conf2
	.EXTERN _smbs_set_sys_conf1
	.EXTERN _smbs_set_sys_conf2
	.EXTERN _smbs_set_dev_cap
	.PUBLIC _user_func_smbs
	.EXTERN _smbs_get_cmd
	.EXTERN _pdc_get_cmd_result
	.EXTERN _smbs_set_cmd_result
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_status
	.EXTERN _smbs_get_ctrl_conf1
	.EXTERN _pdc_set_port_conf
	.EXTERN _pdc_set_sys_conf
	.EXTERN _pdc_set_snk_conf
	.EXTERN _smbs_get_ctrl_conf2
	.EXTERN _pdc_set_src_conf
	.EXTERN _smbs_get_obj_data_sel
	.EXTERN _smbs_set_obj_data
	.EXTERN _smbs_get_obj_data
	.EXTERN _user_func_set_snk_intrusive_en
	.PUBLIC _user_func_smbs_clr_rdo
	.EXTERN _user_func_set_snk_intrusive_dis

	.SECTION .textf,TEXTF
	.TYPE _user_smbs_init,function,.LFE1-_user_smbs_init
_user_smbs_init:
	.STACK _user_smbs_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 34
	oneb c
	movw ax, #0x1802
	call !!_smbs_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 35
	clrb c
	movw ax, #0x0101
	call !!_smbs_set_ctrl_conf1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 36
	clrb c
	clrw ax
	call !!_smbs_set_ctrl_conf2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 37
	clrw ax
	call !!_smbs_set_sys_conf1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 38
	clrw ax
	call !!_smbs_set_sys_conf2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 39
	clrw ax
	call !!_smbs_set_dev_cap
	ret
.LFE1:
	.TYPE _user_func_smbs,function,.LFE2-_user_func_smbs
_user_func_smbs:
	.STACK _user_func_smbs = 52
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 42
	subw sp, #0x2E
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 45
	movw de, #0x001C
	clrw bc
	movw ax, sp
	addw ax, #0x0012
	call !!_memset
	clrw ax
	movw [sp+0x12], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 47
	cmp !LOWW(_gucVdmFlg), #0x01
	.bz $!.BB@LABEL@2_165
.BB@LABEL@2_1:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 51
	mov a, !LOWW(_gSmbsEvent)
	bf a.0, $.BB@LABEL@2_14
.BB@LABEL@2_2:	; if_then_bb57
	movw ax, sp
	addw ax, #0x000D
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 53
	movw bc, ax
	addw ax, #0xFFFC
	call !!_smbs_get_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 54
	cmp a, #0x01
	bnz $.BB@LABEL@2_6
.BB@LABEL@2_3:	; if_then_bb64
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 55
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	bnz $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_then_bb70
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 56
	mov a, #0x04
	br $.BB@LABEL@2_11
.BB@LABEL@2_5:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 59
	mov a, [sp+0x0D]
	mov x, a
	mov a, [sp+0x09]
	call !!_pdc_set_cmd
	br $.BB@LABEL@2_12
.BB@LABEL@2_6:	; if_else_bb74
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 63
	cmp a, #0x02
	bz $.BB@LABEL@2_8
.BB@LABEL@2_7:	; if_else_bb74.if_break_bb91_crit_edge
	clrb a
	br $.BB@LABEL@2_13
.BB@LABEL@2_8:	; if_then_bb80
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 65
	mov a, [sp+0x09]
	cmp a, #0xA0
	bnz $.BB@LABEL@2_10
.BB@LABEL@2_9:	; if_then_bb86
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 68
	clrb a
	br $.BB@LABEL@2_11
.BB@LABEL@2_10:	; if_else_bb87
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 71
	mov a, #0x02
.BB@LABEL@2_11:	; if_else_bb87
	call !!_smbs_set_cmd_result
.BB@LABEL@2_12:	; if_else_bb87
	oneb a
.BB@LABEL@2_13:	; if_else_bb87
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 77
	clr1 !LOWW(_gSmbsEvent).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 78
	oneb !LOWW(_gucWaitSmbsCmdComp)
	br $!.BB@LABEL@2_159
.BB@LABEL@2_14:	; if_else_bb95
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 80
	.bf a.1, $!.BB@LABEL@2_95
.BB@LABEL@2_15:	; if_then_bb103
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 81
	call !!_pdc_get_status
	movw [sp+0x0A], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 85
	call !!_smbs_get_ctrl_conf1
	movw [sp+0x04], ax
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 87
	bt [hl].0, $.BB@LABEL@2_17
.BB@LABEL@2_16:	; if_then_bb103.if_break_bb330_crit_edge
	clrb a
	br $!.BB@LABEL@2_36
.BB@LABEL@2_17:	; if_then_bb119
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 88
	bt [hl].1, $.BB@LABEL@2_19
.BB@LABEL@2_18:	; if_then_bb119.if_break_bb224_crit_edge
	clrb a
	br $.BB@LABEL@2_27
.BB@LABEL@2_19:	; if_then_bb130
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 89
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].4, $.BB@LABEL@2_22
.BB@LABEL@2_20:	; bb140
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].6, $.BB@LABEL@2_22
.BB@LABEL@2_21:	; bb140.if_break_bb171_crit_edge
	clrb a
	br $.BB@LABEL@2_23
.BB@LABEL@2_22:	; if_then_bb158
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 90
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	clr1 [hl].4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 91
	clr1 [hl].6
	oneb a
.BB@LABEL@2_23:	; if_then_bb158
	mov [sp+0x01], a
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	bt [hl].1, $.BB@LABEL@2_28
.BB@LABEL@2_24:	; if_then_bb182
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 95
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].5, $.BB@LABEL@2_26
.BB@LABEL@2_25:	; bb192
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_28
.BB@LABEL@2_26:	; if_then_bb209
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 96
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	clr1 [hl].5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 97
	clr1 [hl].7
	oneb a
.BB@LABEL@2_27:	; if_then_bb209
	mov [sp+0x01], a
.BB@LABEL@2_28:	; if_break_bb224
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	bt [hl].1, $.BB@LABEL@2_37
.BB@LABEL@2_29:	; if_then_bb235
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 103
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].5, $.BB@LABEL@2_31
.BB@LABEL@2_30:	; bb245
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_32
.BB@LABEL@2_31:	; if_then_bb262
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 104
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	clr1 [hl].5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 105
	clr1 [hl].7
	oneb a
	mov [sp+0x01], a
.BB@LABEL@2_32:	; if_break_bb275
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	bf [hl].1, $.BB@LABEL@2_37
.BB@LABEL@2_33:	; if_then_bb286
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 109
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].4, $.BB@LABEL@2_35
.BB@LABEL@2_34:	; bb296
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_37
.BB@LABEL@2_35:	; if_then_bb314
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 110
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	clr1 [hl].4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 111
	clr1 [hl].6
	oneb a
.BB@LABEL@2_36:	; if_then_bb314
	mov [sp+0x01], a
.BB@LABEL@2_37:	; if_break_bb330
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 118
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].5, $.BB@LABEL@2_39
.BB@LABEL@2_38:	; bb340
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].4, $.BB@LABEL@2_41
.BB@LABEL@2_39:	; bb357
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_42
.BB@LABEL@2_40:	; bb366
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_42
.BB@LABEL@2_41:	; if_then_bb391
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 120
	mov a, [sp+0x05]
	and a, #0x0F
	mov [sp+0x05], a
	oneb a
	mov [sp+0x01], a
.BB@LABEL@2_42:	; if_break_bb396
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 124
	movw ax, [sp+0x04]
	xor a, !LOWW(_guCtrlCnf1_bak+0x00001)
	xch a, x
	xor a, !LOWW(_guCtrlCnf1_bak)
	xch a, x
	clrb x
	and a, #0xF0
	or a, x
	bnz $.BB@LABEL@2_44
.BB@LABEL@2_43:	; if_break_bb396.if_break_bb458_crit_edge
	clrb a
	mov [sp+0x00], a
	br $.BB@LABEL@2_54
.BB@LABEL@2_44:	; if_then_bb406
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 126
	mov a, [sp+0x05]
	bf a.4, $.BB@LABEL@2_48
.BB@LABEL@2_45:	; if_then_bb417
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 127
	bf a.6, $.BB@LABEL@2_47
.BB@LABEL@2_46:	; if_then_bb417.if_break_bb456_crit_edge
	mov x, #0x14
	br $.BB@LABEL@2_53
.BB@LABEL@2_47:	; if_else_bb429
	mov x, #0x34
	br $.BB@LABEL@2_53
.BB@LABEL@2_48:	; if_else_bb431
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 134
	bt a.5, $.BB@LABEL@2_50
.BB@LABEL@2_49:	; if_else_bb431.if_break_bb456_crit_edge
	mov x, #0x3C
	br $.BB@LABEL@2_53
.BB@LABEL@2_50:	; if_then_bb442
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 135
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_52
.BB@LABEL@2_51:	; if_then_bb442.if_break_bb456_crit_edge
	mov x, #0x28
	br $.BB@LABEL@2_53
.BB@LABEL@2_52:	; if_else_bb453
	mov x, #0x38
.BB@LABEL@2_53:	; if_break_bb456
	oneb a
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 142
	mov a, x
	oneb x
	call !!_pdc_set_port_conf
.BB@LABEL@2_54:	; if_break_bb458
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 146
	mov a, !LOWW(_guCtrlCnf1_bak)
	mov b, a
	mov1 CY, a.0
	xor1 CY, [hl].0
	bc $.BB@LABEL@2_56
.BB@LABEL@2_55:	; bb472
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	mov a, b
	mov1 CY, a.1
	xor1 CY, [hl].1
	bnc $.BB@LABEL@2_61
.BB@LABEL@2_56:	; if_then_bb494
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 148
	bf [hl].1, $.BB@LABEL@2_58
.BB@LABEL@2_57:	; if_then_bb494.if_break_bb525_crit_edge
	mov d, #0x01
	br $.BB@LABEL@2_62
.BB@LABEL@2_58:	; if_else_bb509
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 156
	bt [hl].0, $.BB@LABEL@2_60
.BB@LABEL@2_59:	; if_else_bb509.if_break_bb525_crit_edge
	mov d, #0x00
	br $.BB@LABEL@2_62
.BB@LABEL@2_60:	; if_then_bb520
	mov d, #0x03
	br $.BB@LABEL@2_62
.BB@LABEL@2_61:	; if_else_bb523
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 161
	mov a, !LOWW(_gucPrSwapMode_bak)
	mov d, a
.BB@LABEL@2_62:	; if_break_bb525
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 164
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	mov a, !LOWW(_guCtrlCnf1_bak+0x00001)
	mov b, a
	mov1 CY, a.0
	xor1 CY, [hl].0
	bc $.BB@LABEL@2_64
.BB@LABEL@2_63:	; bb539
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	mov a, b
	mov1 CY, a.1
	xor1 CY, [hl].1
	bnc $.BB@LABEL@2_69
.BB@LABEL@2_64:	; if_then_bb561
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 166
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bf [hl].1, $.BB@LABEL@2_66
.BB@LABEL@2_65:	; if_then_bb561.if_break_bb592_crit_edge
	oneb b
	br $.BB@LABEL@2_70
.BB@LABEL@2_66:	; if_else_bb576
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 174
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	bt [hl].0, $.BB@LABEL@2_68
.BB@LABEL@2_67:	; if_else_bb576.if_break_bb592_crit_edge
	clrb b
	br $.BB@LABEL@2_70
.BB@LABEL@2_68:	; if_then_bb587
	mov b, #0x03
	br $.BB@LABEL@2_70
.BB@LABEL@2_69:	; if_else_bb590
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 179
	mov b, !LOWW(_gucDrSwapMode_bak)
.BB@LABEL@2_70:	; if_break_bb592
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 182
	mov a, !LOWW(_guCtrlCnf1_bak)
	mov c, a
	mov1 CY, a.4
	xor1 CY, [hl].4
	bnc $.BB@LABEL@2_72
.BB@LABEL@2_71:	; if_else_bb647
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	mov a, c
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 197
	mov1 CY, a.4
	mov1 [hl].4, CY
	clrb c
	oneb a
	mov [sp+0x01], a
	br $.BB@LABEL@2_73
.BB@LABEL@2_72:	; if_else_bb662
	mov a, #0x18
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 202
	and a, !LOWW(_gucInputPwr_bak)
	mov c, a
.BB@LABEL@2_73:	; if_break_bb670
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 205
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	mov a, !LOWW(_guCtrlCnf1_bak+0x00001)
	mov e, a
	mov1 CY, a.2
	xor1 CY, [hl].2
	bnc $.BB@LABEL@2_75
.BB@LABEL@2_74:	; if_else_bb735
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 224
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	mov a, e
	mov1 CY, a.2
	mov1 [hl].2, CY
	oneb a
	mov [sp+0x01], a
	br $.BB@LABEL@2_76
.BB@LABEL@2_75:	; if_else_bb750
	mov a, #0x07
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 229
	and a, !LOWW(_gucInputPwr_bak)
	or c, a
.BB@LABEL@2_76:	; if_break_bb758
	mov a, d
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 232
	cmp a, !LOWW(_gucPrSwapMode_bak)
	bnz $.BB@LABEL@2_79
.BB@LABEL@2_77:	; bb765
	mov a, b
	cmp a, !LOWW(_gucDrSwapMode_bak)
	bnz $.BB@LABEL@2_79
.BB@LABEL@2_78:	; bb779
	mov a, c
	cmp a, !LOWW(_gucInputPwr_bak)
	bz $.BB@LABEL@2_80
.BB@LABEL@2_79:	; if_then_bb794
	mov a, d
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 235
	mov !LOWW(_gucPrSwapMode_bak), a
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 236
	mov !LOWW(_gucDrSwapMode_bak), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 240
	mov c, !LOWW(_gucInputPwr_bak)
	mov x, !LOWW(_gucPrSwapMode_bak)
	clrb b
	call !!_pdc_set_sys_conf
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_80:	; if_break_bb803
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 244
	mov a, [sp+0x04]
	shr a, 0x05
	mov x, a
	mov a, !LOWW(_guCtrlCnf1_bak)
	shr a, 0x05
	cmp a, x
	bz $.BB@LABEL@2_86
.BB@LABEL@2_81:	; if_then_bb816
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 246
	mov a, [sp+0x04]
	and a, #0xE0
	cmp0 a
	bnz $.BB@LABEL@2_83
.BB@LABEL@2_82:	; if_then_bb816.if_break_bb848_crit_edge
	mov a, #0x04
	br $.BB@LABEL@2_85
.BB@LABEL@2_83:	; bb825
	mov a, [sp+0x04]
	shr a, 0x05
	cmp a, #0x05
	bnc $.BB@LABEL@2_82
.BB@LABEL@2_84:	; if_then_bb842
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 248
	mov a, [sp+0x04]
	shr a, 0x05
.BB@LABEL@2_85:	; if_break_bb848
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 250
	mov e, a
	mov d, #0x00
	clrw bc
	movw ax, #0xEA60
	call !!_pdc_set_snk_conf
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 251
	movw !LOWW(_usSmbsRdo_bak), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 252
	movw !LOWW(_usSmbsRdo_bak+0x00002), ax
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_86:	; if_break_bb850
	movw ax, sp
	addw ax, #0x000A
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_92
.BB@LABEL@2_87:	; bb860
	mov a, [sp+0x0A]
	and a, #0x02
	mov x, a
	mov a, [sp+0x01]
	cmp0 a
	bnz $.BB@LABEL@2_92
.BB@LABEL@2_88:	; bb860
	cmp0 x
	bz $.BB@LABEL@2_92
.BB@LABEL@2_89:	; if_then_bb890
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 257
	movw ax, sp
	addw ax, #0x0005
	movw hl, #LOWW(_guCtrlCnf1_bak+0x00001)
	mov1 CY, [hl].2
	movw hl, ax
	xor1 CY, [hl].2
	bnc $.BB@LABEL@2_92
.BB@LABEL@2_90:	; bb904
	movw hl, #LOWW(_guCtrlCnf2_bak+0x00001)
	bf [hl].2, $.BB@LABEL@2_92
.BB@LABEL@2_91:	; if_then_bb919
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 259
	movw ax, #0x2100
	call !!_pdc_set_cmd
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_92:	; if_break_bb921
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 264
	movw ax, [sp+0x04]
	movw de, ax
	movw !LOWW(_guCtrlCnf1_bak), ax
	mov a, [sp+0x01]
	mov c, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 265
	cmp0 c
	bz $.BB@LABEL@2_94
.BB@LABEL@2_93:	; if_then_bb930
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 266
	movw ax, de
	call !!_smbs_set_ctrl_conf1
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_94:	; if_break_bb933
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 269
	clr1 !LOWW(_gSmbsEvent).1
	br $!.BB@LABEL@2_159
.BB@LABEL@2_95:	; if_else_bb937
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 271
	.bf a.2, $!.BB@LABEL@2_125
.BB@LABEL@2_96:	; if_then_bb945
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 272
	call !!_pdc_get_status
	movw [sp+0x10], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 276
	call !!_smbs_get_ctrl_conf2
	movw [sp+0x06], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 277
	xor a, !LOWW(_guCtrlCnf2_bak+0x00001)
	xch a, x
	xor a, !LOWW(_guCtrlCnf2_bak)
	xch a, x
	and a, #0x03
	or a, x
	bnz $.BB@LABEL@2_99
.BB@LABEL@2_97:	; bb963
	mov a, [sp+0x07]
	shr a, 0x05
	mov x, a
	mov a, !LOWW(_guCtrlCnf2_bak+0x00001)
	shr a, 0x05
	cmp a, x
	bnz $.BB@LABEL@2_99
.BB@LABEL@2_98:	; bb963.if_break_bb1056_crit_edge
	clrb a
	br $.BB@LABEL@2_108
.BB@LABEL@2_99:	; if_then_bb983
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 282
	movw ax, [sp+0x06]
	and a, #0x03
	or a, x
	bnz $.BB@LABEL@2_101
.BB@LABEL@2_100:	; if_then_bb983.if_break_bb1021_crit_edge
	clrw bc
	movw hl, #0xEA60
	br $.BB@LABEL@2_103
.BB@LABEL@2_101:	; bb993
	movw ax, [sp+0x06]
	and a, #0x03
	cmpw ax, #0x00F1
	bnc $.BB@LABEL@2_100
.BB@LABEL@2_102:	; if_then_bb1011
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 284
	movw ax, [sp+0x06]
	and a, #0x03
	movw bc, #0x00FA
	mulhu
	movw hl, ax
.BB@LABEL@2_103:	; if_break_bb1021
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 287
	mov a, [sp+0x07]
	and a, #0xE0
	cmp0 a
	bnz $.BB@LABEL@2_105
.BB@LABEL@2_104:	; if_break_bb1021.if_break_bb1053_crit_edge
	mov e, #0x04
	br $.BB@LABEL@2_107
.BB@LABEL@2_105:	; bb1030
	mov a, [sp+0x07]
	shr a, 0x05
	cmp a, #0x05
	bnc $.BB@LABEL@2_104
.BB@LABEL@2_106:	; if_then_bb1047
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 289
	mov a, [sp+0x07]
	shr a, 0x05
	mov e, a
.BB@LABEL@2_107:	; if_break_bb1053
	movw ax, #0x0003
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 291
	push ax
	movw ax, hl
	mov d, #0x00
	call !!_pdc_set_src_conf
	pop ax
	oneb a
.BB@LABEL@2_108:	; if_break_bb1053
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 295
	movw ax, sp
	addw ax, #0x0007
	movw hl, ax
	mov a, !LOWW(_guCtrlCnf2_bak+0x00001)
	mov b, a
	mov1 CY, a.4
	xor1 CY, [hl].4
	bc $.BB@LABEL@2_110
.BB@LABEL@2_109:	; if_break_bb1056.if_break_bb1119_crit_edge
	clrb a
	br $.BB@LABEL@2_111
.BB@LABEL@2_110:	; if_else_bb1096
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 303
	movw ax, sp
	addw ax, #0x0007
	movw hl, ax
	mov a, b
	mov1 CY, a.4
	mov1 [hl].4, CY
	oneb a
.BB@LABEL@2_111:	; if_else_bb1096
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 311
	movw ax, sp
	addw ax, #0x0007
	movw hl, ax
	mov a, !LOWW(_guCtrlCnf2_bak+0x00001)
	mov b, a
	mov1 CY, a.3
	xor1 CY, [hl].3
	bc $.BB@LABEL@2_113
.BB@LABEL@2_112:	; bb1133
	movw ax, sp
	addw ax, #0x0007
	movw hl, ax
	mov a, b
	mov1 CY, a.2
	xor1 CY, [hl].2
	bnc $.BB@LABEL@2_114
.BB@LABEL@2_113:	; if_else_bb1244
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 334
	movw hl, #LOWW(_guCtrlCnf2_bak+0x00001)
	mov1 CY, [hl].3
	mov a, [sp+0x07]
	mov1 a.3, CY
	mov [sp+0x07], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 335
	mov1 CY, [hl].2
	mov1 a.2, CY
	mov [sp+0x07], a
	oneb a
	mov [sp+0x01], a
.BB@LABEL@2_114:	; if_break_bb1300
	movw ax, sp
	addw ax, #0x0010
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_122
.BB@LABEL@2_115:	; bb1310
	mov a, [sp+0x10]
	and a, #0x02
	mov x, a
	mov a, [sp+0x01]
	cmp0 a
	bnz $.BB@LABEL@2_122
.BB@LABEL@2_116:	; bb1310
	cmp0 x
	bz $.BB@LABEL@2_122
.BB@LABEL@2_117:	; if_then_bb1340
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 350
	movw ax, [sp+0x06]
	xor a, !LOWW(_guCtrlCnf2_bak+0x00001)
	xch a, x
	xor a, !LOWW(_guCtrlCnf2_bak)
	xch a, x
	and a, #0x03
	or a, x
	bnz $.BB@LABEL@2_121
.BB@LABEL@2_118:	; bb1353
	mov a, [sp+0x07]
	shr a, 0x05
	mov x, a
	mov a, !LOWW(_guCtrlCnf2_bak+0x00001)
	shr a, 0x05
	cmp a, x
	bnz $.BB@LABEL@2_121
.BB@LABEL@2_119:	; bb1372
	movw hl, #LOWW(_guCtrlCnf1_bak+0x00001)
	bf [hl].2, $.BB@LABEL@2_122
.BB@LABEL@2_120:	; bb1379
	movw ax, sp
	addw ax, #0x0007
	movw hl, #LOWW(_guCtrlCnf2_bak+0x00001)
	mov1 CY, [hl].2
	movw hl, ax
	xor1 CY, [hl].2
	bnc $.BB@LABEL@2_122
.BB@LABEL@2_121:	; if_then_bb1408
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 354
	movw ax, #0x2100
	call !!_pdc_set_cmd
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_122:	; if_break_bb1410
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 358
	movw ax, [sp+0x06]
	movw de, ax
	movw !LOWW(_guCtrlCnf2_bak), ax
	mov a, [sp+0x01]
	mov c, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 359
	cmp0 c
	bz $.BB@LABEL@2_124
.BB@LABEL@2_123:	; if_then_bb1419
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 360
	movw ax, de
	call !!_smbs_set_ctrl_conf2
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_124:	; if_break_bb1422
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 363
	clr1 !LOWW(_gSmbsEvent).2
	br $!.BB@LABEL@2_159
.BB@LABEL@2_125:	; if_else_bb1426
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 365
	bf a.3, $.BB@LABEL@2_130
.BB@LABEL@2_126:	; if_then_bb1434
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 366
	call !!_smbs_get_obj_data_sel
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 368
	dec a
	bz $.BB@LABEL@2_128
.BB@LABEL@2_127:	; if_then_bb1434.if_break_bb1458_crit_edge
	clrb c
	br $.BB@LABEL@2_129
.BB@LABEL@2_128:	; if_then_bb1441
	onew ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 370
	movw [sp+0x12], ax
	movw ax, #0x912C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 371
	movw [sp+0x14], ax
	movw ax, #0x0002
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 372
	movw [sp+0x16], ax
	movw ax, #0xD12C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 373
	movw [sp+0x18], ax
	movw ax, #0x0004
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 374
	movw [sp+0x1A], ax
	movw ax, #0xB12C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 375
	movw [sp+0x1C], ax
	movw ax, #0x0006
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 376
	movw [sp+0x1E], ax
	movw ax, #0x412C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 377
	movw [sp+0x20], ax
	mov c, #0x10
.BB@LABEL@2_129:	; if_break_bb1458
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 380
	clrb b
	movw ax, sp
	addw ax, #0x0012
	call !!_smbs_set_obj_data
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 382
	clr1 !LOWW(_gSmbsEvent).3
	oneb a
	mov [sp+0x00], a
	br $!.BB@LABEL@2_159
.BB@LABEL@2_130:	; if_else_bb1465
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 384
	bt a.5, $.BB@LABEL@2_132
.BB@LABEL@2_131:	; if_else_bb1465.if_break_bb1738_crit_edge
	clrb a
	mov [sp+0x00], a
	br $!.BB@LABEL@2_159
.BB@LABEL@2_132:	; if_then_bb1473
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 385
	call !!_pdc_get_status
	movw [sp+0x0E], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 386
	call !!_smbs_get_obj_data_sel
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 387
	mov [sp+0x08], #0x00
	movw ax, sp
	addw ax, #0x000C
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 389
	movw de, ax
	addw ax, #0xFFFC
	movw bc, ax
	addw ax, #0x000A
	call !!_smbs_get_obj_data
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 391
	cmp a, #0x08
	bnz $.BB@LABEL@2_138
.BB@LABEL@2_133:	; if_then_bb1484
	movw ax, sp
	addw ax, #0x000E
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 392
	bt [hl].0, $.BB@LABEL@2_135
.BB@LABEL@2_134:	; if_then_bb1484.if_break_bb1720_crit_edge
	clrb a
	mov [sp+0x00], a
	oneb a
	br $!.BB@LABEL@2_156
.BB@LABEL@2_135:	; bb1494
	movw ax, sp
	addw ax, #0x000E
	movw hl, ax
	bt [hl].1, $.BB@LABEL@2_134
.BB@LABEL@2_136:	; bb1511
	movw ax, sp
	addw ax, #0x000F
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_134
.BB@LABEL@2_137:	; if_then_bb1528
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 393
	movw ax, [sp+0x12]
	movw !LOWW(_usSmbsRdo_bak), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 394
	movw ax, [sp+0x14]
	movw !LOWW(_usSmbsRdo_bak+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 395
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x12]
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 396
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x14]
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 397
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 398
	call !!_user_func_set_snk_intrusive_en
	oneb a
	mov [sp+0x00], a
	clrb a
	br $!.BB@LABEL@2_156
.BB@LABEL@2_138:	; if_else_bb1550
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 405
	cmp a, #0x11
	bnz $.BB@LABEL@2_142
.BB@LABEL@2_139:	; if_then_bb1556
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 407
	mov a, [sp+0x08]
	shrw ax, 8+0x00000
	addw ax, #0x0003
	and a, #0x01
	xch a, x
	and a, #0xFC
	xch a, x
	movw bc, ax
	movw ax, !LOWW(_gSndMess+0x00002)
	clrb x
	and a, #0xFE
	addw ax, bc
	movw !LOWW(_gSndMess+0x00002), ax
	mov d, #0x00
	br $.BB@LABEL@2_141
.BB@LABEL@2_140:	; bb1566
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 409
	mov a, d
	mov x, #0x02
	mulu x
	movw bc, ax
	movw ax, sp
	addw ax, #0x0012
	addw ax, bc
	movw hl, ax
	movw ax, bc
	addw ax, !LOWW(_gSndMess)
	movw [sp+0x00], ax
	movw ax, [hl]
	movw bc, ax
	pop hl
	push hl
	movw ax, bc
	movw [hl], ax
	inc d
.BB@LABEL@2_141:	; bb1578
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 408
	movw ax, !LOWW(_gSndMess+0x00002)
	shrw ax, 0x01
	clrb a
	movw bc, ax
	mov a, d
	shrw ax, 8+0x00000
	cmpw ax, bc
	bc $.BB@LABEL@2_140
	br $!.BB@LABEL@2_155
.BB@LABEL@2_142:	; if_else_bb1589
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 412
	cmp a, #0x32
	bnz $.BB@LABEL@2_144
.BB@LABEL@2_143:	; if_then_bb1595
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 413
	movw ax, !LOWW(_gSndMess+0x00002)
	clrb x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 414
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x12]
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 415
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x14]
	movw [de+0x02], ax
	br $!.BB@LABEL@2_155
.BB@LABEL@2_144:	; if_else_bb1609
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 417
	cmp a, #0x31
	.bnz $!.BB@LABEL@2_134
.BB@LABEL@2_145:	; if_then_bb1615
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 418
	mov a, [sp+0x0C]
	mov b, a
	cmp0 b
	bnz $.BB@LABEL@2_151
.BB@LABEL@2_146:	; if_then_bb1621
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 419
	movw ax, [sp+0x12]
	or a, x
	.bz $!.BB@LABEL@2_134
.BB@LABEL@2_147:	; bb1627
	mov a, [sp+0x08]
	cmp a, #0x02
	.bc $!.BB@LABEL@2_134
.BB@LABEL@2_148:	; if_else_bb1641
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 424
	movw ax, [sp+0x12]
	and a, #0x01
	movw bc, ax
	movw ax, !LOWW(_gSndMess+0x00002)
	clrb x
	and a, #0xFE
	addw ax, bc
	movw !LOWW(_gSndMess+0x00002), ax
	clrb a
	br $.BB@LABEL@2_150
.BB@LABEL@2_149:	; bb1649
	mov a, [sp+0x00]
	mov b, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 426
	mov x, #0x02
	mulu x
	movw de, ax
	addw ax, !LOWW(_gSndMess)
	movw hl, ax
	movw ax, sp
	addw ax, #0x0012
	addw ax, de
	addw ax, #0x0002
	movw de, ax
	movw ax, [de]
	movw [hl], ax
	inc b
	mov a, b
.BB@LABEL@2_150:	; bb1649
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 425
	mov a, [sp+0x08]
	shrw ax, 8+0x00000
	decw ax
	shrw ax, 0x01
	movw bc, ax
	mov a, [sp+0x00]
	shrw ax, 8+0x00000
	cmpw ax, bc
	bc $.BB@LABEL@2_149
	br $.BB@LABEL@2_155
.BB@LABEL@2_151:	; if_else_bb1675
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 431
	mov a, [sp+0x08]
	cmp a, #0x02
	.bc $!.BB@LABEL@2_134
.BB@LABEL@2_152:	; if_else_bb1682
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 436
	mov x, a
	mov a, b
	mulu x
	addw ax, #0x01FE
	shrw ax, 0x01
	movw [sp+0x02], ax
	mov d, #0x00
	br $.BB@LABEL@2_154
.BB@LABEL@2_153:	; bb1691
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 438
	mov a, d
	mov x, #0x02
	mulu x
	movw bc, ax
	movw ax, sp
	addw ax, #0x0012
	addw ax, bc
	movw hl, ax
	movw ax, [sp+0x02]
	clrb a
	addw ax, ax
	addw ax, !LOWW(_gSndMess)
	movw [sp+0x00], ax
	movw ax, [hl]
	movw bc, ax
	pop hl
	push hl
	movw ax, bc
	movw [hl], ax
	inc d
.BB@LABEL@2_154:	; bb1703
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 437
	mov a, [sp+0x08]
	shrw ax, 8+0x00000
	incw ax
	shrw ax, 0x01
	movw bc, ax
	mov a, d
	shrw ax, 8+0x00000
	cmpw ax, bc
	bc $.BB@LABEL@2_153
.BB@LABEL@2_155:	; bb1578.if_break_bb1720_crit_edge
	clrb a
	mov [sp+0x00], a
.BB@LABEL@2_156:	; if_break_bb1720
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 447
	cmp0 a
	bz $.BB@LABEL@2_158
.BB@LABEL@2_157:	; if_then_bb1726
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 448
	mov b, a
	mov a, [sp+0x08]
	mov c, a
	movw ax, sp
	addw ax, #0x0012
	call !!_smbs_set_obj_data
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_158:	; if_break_bb1730
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 452
	clr1 !LOWW(_gSmbsEvent).5
.BB@LABEL@2_159:	; if_break_bb1738
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 455
	cmp0 !LOWW(_gucWaitSmbsCmdComp)
	bz $.BB@LABEL@2_162
.BB@LABEL@2_160:	; if_then_bb1744
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 456
	call !!_pdc_get_cmd_result
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 457
	cmp a, #0x08
	bz $.BB@LABEL@2_162
.BB@LABEL@2_161:	; if_then_bb1751
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 458
	call !!_smbs_set_cmd_result
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 460
	clrb !LOWW(_gucWaitSmbsCmdComp)
	oneb a
	mov [sp+0x00], a
.BB@LABEL@2_162:	; if_break_bb1754
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 464
	cmp0 !LOWW(_gucWaitSmbsCmdComp)
	bnz $.BB@LABEL@2_164
.BB@LABEL@2_163:	; if_break_bb1754
	mov a, [sp+0x00]
	cmp0 a
	bz $.BB@LABEL@2_165
.BB@LABEL@2_164:	; if_break_bb1754.bb1777_crit_edge
	clrb a
	br $.BB@LABEL@2_166
.BB@LABEL@2_165:	; if_else_bb1774
	mov a, #0x07
.BB@LABEL@2_166:	; bb1777
	addw sp, #0x2E
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 470
	ret
.LFE2:
	.TYPE _user_func_smbs_clr_rdo,function,.LFE3-_user_func_smbs_clr_rdo
_user_func_smbs_clr_rdo:
	.STACK _user_func_smbs_clr_rdo = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 474
	call !!_user_func_set_snk_intrusive_dis
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 475
	movw !LOWW(_usSmbsRdo_bak), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main_smbs.c", 476
	movw !LOWW(_usSmbsRdo_bak+0x00002), ax
	ret
.LFE3:
