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
#@   PDC\user_main_authentication.c
#@   PDC\user_main_protection.c
#@   PDC\subdev\isl95338.c
#@   PDC\subdev\relamcu.c
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_a1bd8f6515f746a38e66ad14f6afd87clhozzw5x.izr
#@  compiled at Tue May 06 10:50:44 2025

	.EXTERN _gSndMess
	.EXTERN _gucVdmFlg
	.EXTERN _gucAuthFlg
	.PUBLIC _user_func_auth
	.EXTERN _pdc_get_status
	.EXTERN _auth_get_status
	.EXTERN _auth_run_initiator
	.EXTERN _auth_get_result
	.EXTERN _pdc_set_snk_conf
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_cmd_result

	.SECTION .textf,TEXTF
	.TYPE _user_func_auth,function,.LFE1-_user_func_auth
_user_func_auth:
	.STACK _user_func_auth = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 19
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 24
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 25
	mov a, [sp+0x01]
	bf a.7, $.BB@LABEL@1_8
.BB@LABEL@1_1:	; bb
	cmp0 !LOWW(_gucAuthFlg)
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_2:	; bb22
	cmp0 !LOWW(_gucVdmFlg)
	bnz $.BB@LABEL@1_8
.BB@LABEL@1_3:	; if_then_bb
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@1_14
.BB@LABEL@1_4:	; bb44
	movw ax, sp
	movw hl, ax
	bt [hl].1, $.BB@LABEL@1_14
.BB@LABEL@1_5:	; if_then_bb63
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 30
	call !!_auth_get_status
	dec a
	bnz $.BB@LABEL@1_7
.BB@LABEL@1_6:	; if_then_bb69
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 31
	clrb a
	call !!_auth_run_initiator
.BB@LABEL@1_7:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 33
	oneb !LOWW(_gucAuthFlg)
	br $!.BB@LABEL@1_22
.BB@LABEL@1_8:	; if_else_bb71
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 39
	mov a, !LOWW(_gucAuthFlg)
	cmp a, #0x01
	bnz $.BB@LABEL@1_15
.BB@LABEL@1_9:	; if_then_bb77
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 40
	call !!_auth_get_status
	dec a
	.bnz $!.BB@LABEL@1_22
.BB@LABEL@1_10:	; if_then_bb83
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 41
	call !!_auth_get_result
	cmp0 a
	bnz $.BB@LABEL@1_12
.BB@LABEL@1_11:	; if_then_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 42
	mov !LOWW(_gucAuthFlg), #0x02
	br $!.BB@LABEL@1_22
.BB@LABEL@1_12:	; if_else_bb90
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 44
	call !!_auth_get_result
	cmp a, #0x06
	bnz $.BB@LABEL@1_14
.BB@LABEL@1_13:	; if_then_bb96
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 45
	mov !LOWW(_gucAuthFlg), #0x03
	br $.BB@LABEL@1_22
.BB@LABEL@1_14:	; if_else_bb97
	mov !LOWW(_gucAuthFlg), #0x0F
	br $.BB@LABEL@1_22
.BB@LABEL@1_15:	; if_else_bb101
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 52
	cmp a, #0x02
	bnz $.BB@LABEL@1_17
.BB@LABEL@1_16:	; if_then_bb107
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 53
	movw de, #0x0005
	clrw bc
	movw ax, #0xEA60
	call !!_pdc_set_snk_conf
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 54
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 55
	movw ax, #0x2200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 56
	mov !LOWW(_gucAuthFlg), #0x14
	br $.BB@LABEL@1_22
.BB@LABEL@1_17:	; if_else_bb111
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 58
	cmp a, #0x03
	bnz $.BB@LABEL@1_19
.BB@LABEL@1_18:	; if_then_bb117
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 59
	movw de, #0x0001
	clrw bc
	movw ax, #0x3A98
	call !!_pdc_set_snk_conf
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 60
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 61
	movw ax, #0x2200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 62
	mov !LOWW(_gucAuthFlg), #0x04
	br $.BB@LABEL@1_22
.BB@LABEL@1_19:	; if_else_bb121
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 64
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x0004
	bnz $.BB@LABEL@1_22
.BB@LABEL@1_20:	; if_then_bb128
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 65
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	bz $.BB@LABEL@1_22
.BB@LABEL@1_21:	; if_then_bb134
	mov a, #0x0F
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 66
	or a, !LOWW(_gucAuthFlg)
	mov !LOWW(_gucAuthFlg), a
.BB@LABEL@1_22:	; if_break_bb144
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main_authentication.c", 306
	mov a, !LOWW(_gucAuthFlg)
	cmp0 a
	bz $.BB@LABEL@1_24
.BB@LABEL@1_23:	; if_break_bb144
	clrb b
	br $.BB@LABEL@1_25
.BB@LABEL@1_24:	; if_break_bb144
	oneb b
.BB@LABEL@1_25:	; if_break_bb144
	shrw ax, 8+0x00000
	shlw ax, 0x0C
	shrw ax, 0x0C
	cmpw ax, #0x000F
	bz $.BB@LABEL@1_27
.BB@LABEL@1_26:	; if_break_bb144
	clrb a
	br $.BB@LABEL@1_28
.BB@LABEL@1_27:	; if_break_bb144
	oneb a
.BB@LABEL@1_28:	; if_break_bb144
	or a, b
	cmp0 a
	clrb a
	skz
.BB@LABEL@1_29:	; if_break_bb144
	mov a, #0x07
.BB@LABEL@1_30:	; if_break_bb144
	pop bc
	ret
.LFE1:
