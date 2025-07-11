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

	.EXTERN _gPdc
	.EXTERN _gRcvMess
	.EXTERN _gDCInfo
	.EXTERN _gSubdevInfo
	.EXTERN _gAmcu
	.EXTERN _gLed
	.PUBLIC _gusTemp
	.PUBLIC _gucVdmFlg
	.PUBLIC _gucWaiCmp
	.PUBLIC _gucOmfData
	.PUBLIC _gucAuthFlg
	.PUBLIC _user_init
	.EXTERN _init_tau0_channel3
	.EXTERN _init_tm_12bit
	.EXTERN _dcdc_init
	.EXTERN _subdev_init
	.EXTERN _smbm_init
	.EXTERN _auth_init
	.EXTERN _relamcu_reset_err
	.EXTERN _led_init
	.EXTERN _sw_init
	.PUBLIC _user_func_event
	.EXTERN _pdc_get_status
	.EXTERN _user_func_start_timer_thermistor
	.EXTERN _pdc_set_snk_conf
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pdc_get_an_volt
	.EXTERN _pd_tm_chk_user_stat
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_req_volt

	.SECTION .textf,TEXTF
	.TYPE _user_init,function,.LFE1-_user_init
_user_init:
	.STACK _user_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 38
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 39
	clr1 0xFFF01.7
	clr1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 40
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 41
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 42
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 43
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 44
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 45
	set1 !0x0058.2
	set1 0xFFF08.2
	clr1 0xFFF28.2
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 47
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 48
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 49
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 50
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 56
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 57
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 58
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 59
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 60
	clrb !LOWW(_gucAuthFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 62
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 63
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 65
	call !!_dcdc_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 66
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 67
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 71
	mov a, #LOW(HIGHW(_relamcu_reset_err))
	shrw ax, 8+0x00000
	movw bc, ax
	mov e, #0x05
	movw ax, #LOWW(_relamcu_reset_err)
	call !!_auth_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 73
	call !!_led_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 74
	call !!_sw_init
	ret
.LFE1:
	.TYPE _user_func_event,function,.LFE2-_user_func_event
_user_func_event:
	.STACK _user_func_event = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 77
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 79
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 81
	mov a, !LOWW(_gPdc+0x00002)
	.bf a.0, $!.BB@LABEL@2_14
.BB@LABEL@2_1:	; if_then_bb
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 82
	bf [hl].0, $.BB@LABEL@2_6
.BB@LABEL@2_2:	; if_then_bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 86
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 87
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 88
	mov a, [sp+0x00]
	mov1 CY, a.1
	mov a, !LOWW(_gLed)
	bnc $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb32
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 89
	set1 a.0
	br $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 92
	set1 a.1
.BB@LABEL@2_5:	; if_break_bb
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 94
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 95
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_49
.BB@LABEL@2_6:	; if_else_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 98
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_9
.BB@LABEL@2_7:	; if_then_bb48
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 102
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 103
	clrb !LOWW(_gucAuthFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 107
	movw de, #0x0001
	clrw bc
	movw ax, #0x3A98
	call !!_pdc_set_snk_conf
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 109
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 110
	mov a, !LOWW(_gPdc)
	bt a.1, $.BB@LABEL@2_13
.BB@LABEL@2_8:	; if_then_bb59
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 111
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 112
	set1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 113
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_49
.BB@LABEL@2_9:	; if_else_bb66
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 120
	mov a, #0x03
	call !!_pdc_get_an_volt
	.bt a.7, $!.BB@LABEL@2_49
.BB@LABEL@2_10:	; if_then_bb72
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 122
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@2_12
.BB@LABEL@2_11:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_49
.BB@LABEL@2_12:	; if_then_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 124
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 125
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 126
	clr1 0xFFF07.1
.BB@LABEL@2_13:	; if_else_bb61
	clr1 !LOWW(_gPdc+0x00002).0
	br $!.BB@LABEL@2_49
.BB@LABEL@2_14:	; if_else_bb98
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 133
	bf a.1, $.BB@LABEL@2_19
.BB@LABEL@2_15:	; if_then_bb106
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 134
	mov a, !LOWW(_gLed)
	bf [hl].1, $.BB@LABEL@2_17
.BB@LABEL@2_16:	; if_then_bb117
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 135
	set1 a.0
	br $.BB@LABEL@2_18
.BB@LABEL@2_17:	; if_else_bb121
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 138
	set1 a.1
.BB@LABEL@2_18:	; if_break_bb125
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 140
	clr1 !LOWW(_gPdc+0x00002).1
	br $!.BB@LABEL@2_49
.BB@LABEL@2_19:	; if_else_bb129
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 142
	bf a.2, $.BB@LABEL@2_21
.BB@LABEL@2_20:	; if_then_bb137
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 143
	clr1 a.2
	br $.BB@LABEL@2_25
.BB@LABEL@2_21:	; if_else_bb141
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 145
	bf a.3, $.BB@LABEL@2_23
.BB@LABEL@2_22:	; if_then_bb149
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 151
	clr1 a.3
	br $.BB@LABEL@2_25
.BB@LABEL@2_23:	; if_else_bb153
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 153
	bf a.4, $.BB@LABEL@2_26
.BB@LABEL@2_24:	; if_then_bb161
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 155
	clr1 a.4
.BB@LABEL@2_25:	; if_then_bb161
	mov !LOWW(_gPdc+0x00002), a
	br $.BB@LABEL@2_49
.BB@LABEL@2_26:	; if_else_bb165
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 157
	bf a.5, $.BB@LABEL@2_28
.BB@LABEL@2_27:	; if_then_bb173
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 158
	clr1 a.5
	br $.BB@LABEL@2_25
.BB@LABEL@2_28:	; if_else_bb177
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 160
	bf a.6, $.BB@LABEL@2_35
.BB@LABEL@2_29:	; if_then_bb185
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 161
	mov a, !LOWW(_gRcvMess+0x00003)
	mov x, a
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_34
.BB@LABEL@2_30:	; if_then_bb192
	mov a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 162
	shr a, 0x01
	and a, #0x1F
	cmp a, #0x0F
	bnz $.BB@LABEL@2_34
.BB@LABEL@2_31:	; if_then_bb200
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_34
.BB@LABEL@2_32:	; bb210
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	addw ax, ax
	bc $.BB@LABEL@2_34
.BB@LABEL@2_33:	; if_then_bb225
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 165
	movw ax, #0x1000
	call !!_pdc_set_cmd
.BB@LABEL@2_34:	; if_break_bb228
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 169
	clr1 !LOWW(_gPdc+0x00002).6
	br $.BB@LABEL@2_49
.BB@LABEL@2_35:	; if_else_bb232
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 171
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@2_40
.BB@LABEL@2_36:	; if_then_bb240
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 172
	bf [hl].1, $.BB@LABEL@2_38
.BB@LABEL@2_37:	; if_then_bb251
	mov a, b
	clr1 a.3
	br $.BB@LABEL@2_48
.BB@LABEL@2_38:	; if_else_bb255
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 176
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_49
.BB@LABEL@2_39:	; if_then_bb260
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 177
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@2_37
.BB@LABEL@2_40:	; if_else_bb269
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 182
	bf a.2, $.BB@LABEL@2_42
.BB@LABEL@2_41:	; if_then_bb277
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 183
	clr1 a.2
	br $.BB@LABEL@2_48
.BB@LABEL@2_42:	; if_else_bb281
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 185
	bf a.4, $.BB@LABEL@2_44
.BB@LABEL@2_43:	; if_then_bb289
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 186
	clr1 a.4
	br $.BB@LABEL@2_48
.BB@LABEL@2_44:	; if_else_bb293
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 188
	bf a.5, $.BB@LABEL@2_46
.BB@LABEL@2_45:	; if_then_bb301
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 189
	clr1 a.5
	br $.BB@LABEL@2_48
.BB@LABEL@2_46:	; if_else_bb305
	bf a.6, $.BB@LABEL@2_49
.BB@LABEL@2_47:	; if_then_bb313
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 192
	clr1 a.6
.BB@LABEL@2_48:	; if_then_bb313
	mov !LOWW(_gPdc+0x00003), a
.BB@LABEL@2_49:	; if_break_bb328
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 195
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@2_51
.BB@LABEL@2_50:	; if_then_bb335
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 196
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 197
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 198
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@2_99
.BB@LABEL@2_51:	; if_else_bb339
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 200
	bf a.6, $.BB@LABEL@2_56
.BB@LABEL@2_52:	; if_then_bb347
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 201
	bf [hl].3, $.BB@LABEL@2_54
.BB@LABEL@2_53:	; if_then_bb358
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 202
	set1 0xFFF01.6
	br $.BB@LABEL@2_55
.BB@LABEL@2_54:	; if_else_bb359
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 205
	set1 0xFFF01.7
.BB@LABEL@2_55:	; if_break_bb360
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 207
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@2_99
.BB@LABEL@2_56:	; if_else_bb364
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 209
	bf a.1, $.BB@LABEL@2_66
.BB@LABEL@2_57:	; if_then_bb372
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 210
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_59
.BB@LABEL@2_58:	; if_then_bb378
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 211
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 212
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_99
.BB@LABEL@2_59:	; if_else_bb382
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 218
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@2_61
.BB@LABEL@2_60:	; if_then_bb390
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 219
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	br $.BB@LABEL@2_63
.BB@LABEL@2_61:	; if_else_bb397
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 225
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@2_99
.BB@LABEL@2_62:	; if_then_bb403
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 227
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@2_64
.BB@LABEL@2_63:	; if_then_bb408
	clr1 0xFFF07.1
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_99
.BB@LABEL@2_64:	; if_else_bb412
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 232
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@2_99
.BB@LABEL@2_65:	; if_then_bb417
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 233
	clr1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 234
	set1 0xFFF07.1
	br $!.BB@LABEL@2_99
.BB@LABEL@2_66:	; if_else_bb423
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 240
	bf a.4, $.BB@LABEL@2_71
.BB@LABEL@2_67:	; if_then_bb431
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_69
.BB@LABEL@2_68:	; if_else_bb446
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 246
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@2_69:	; if_then_bb451
	clr1 0xFFF07.3
.BB@LABEL@2_70:	; if_break_bb456
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 251
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@2_99
.BB@LABEL@2_71:	; if_else_bb460
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 253
	bf a.0, $.BB@LABEL@2_74
.BB@LABEL@2_72:	; if_then_bb468
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 254
	movw ax, !LOWW(_gDCInfo)
	or a, x
	.bnz $!.BB@LABEL@2_99
.BB@LABEL@2_73:	; if_then_bb473
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 255
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 256
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 257
	clr1 !LOWW(_gPdc).0
	br $!.BB@LABEL@2_99
.BB@LABEL@2_74:	; if_else_bb481
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 260
	bf a.2, $.BB@LABEL@2_78
.BB@LABEL@2_75:	; if_then_bb489
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 264
	movw ax, !LOWW(_gDCInfo)
	or a, x
	.bnz $!.BB@LABEL@2_99
.BB@LABEL@2_76:	; if_then_bb494
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 265
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 266
	clr1 a.2
.BB@LABEL@2_77:	; if_then_bb494
	mov !LOWW(_gPdc), a
	br $!.BB@LABEL@2_99
.BB@LABEL@2_78:	; if_else_bb502
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 269
	bf a.3, $.BB@LABEL@2_81
.BB@LABEL@2_79:	; if_then_bb510
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 270
	movw ax, !LOWW(_gDCInfo)
	or a, x
	.bnz $!.BB@LABEL@2_99
.BB@LABEL@2_80:	; if_then_bb515
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 271
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 272
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 273
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@2_99
.BB@LABEL@2_81:	; if_else_bb523
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 276
	bf a.5, $.BB@LABEL@2_84
.BB@LABEL@2_82:	; if_then_bb531
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 277
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_99
.BB@LABEL@2_83:	; if_then_bb536
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 278
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 279
	clr1 a.5
	br $.BB@LABEL@2_77
.BB@LABEL@2_84:	; if_else_bb544
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 282
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@2_86
.BB@LABEL@2_85:	; if_then_bb552
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 283
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@2_99
.BB@LABEL@2_86:	; if_else_bb556
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 285
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@2_88
.BB@LABEL@2_87:	; if_then_bb564
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 287
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 288
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@2_99
.BB@LABEL@2_88:	; if_else_bb568
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 290
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@2_90
.BB@LABEL@2_89:	; if_then_bb573
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 291
	movw !LOWW(_gDCInfo+0x00002), ax
	br $.BB@LABEL@2_99
.BB@LABEL@2_90:	; if_else_bb574
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 293
	mov a, !LOWW(_gAmcu)
	bf a.0, $.BB@LABEL@2_92
.BB@LABEL@2_91:	; if_then_bb582
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 294
	clr1 0xFFF03.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 295
	clr1 !LOWW(_gAmcu).0
	br $.BB@LABEL@2_99
.BB@LABEL@2_92:	; if_else_bb586
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 297
	bf a.1, $.BB@LABEL@2_94
.BB@LABEL@2_93:	; if_then_bb594
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 298
	set1 0xFFF03.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 299
	clr1 !LOWW(_gAmcu).1
	br $.BB@LABEL@2_99
.BB@LABEL@2_94:	; if_else_bb598
	bf a.2, $.BB@LABEL@2_97
.BB@LABEL@2_95:	; bb605
	mov a, !LOWW(_gSubdevInfo)
	mov b, a
	shrw ax, 8+0x00000
	shlw ax, 0x0F
	bc $.BB@LABEL@2_97
.BB@LABEL@2_96:	; if_then_bb619
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 304
	set1 a.1
	mov !LOWW(_gSubdevInfo), a
	br $.BB@LABEL@2_99
.BB@LABEL@2_97:	; if_else_bb624
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 306
	mov a, !LOWW(_gAmcu)
	bf a.3, $.BB@LABEL@2_99
.BB@LABEL@2_98:	; if_then_bb632
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 307
	set1 !LOWW(_gSubdevInfo+0x00001).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 308
	clr1 a.3
	mov !LOWW(_gAmcu), a
.BB@LABEL@2_99:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/user_main.c", 310
	ret
.LFE2:
	.SECTION .bss,BSS
	.ALIGN 2
	.TYPE _gusTemp,object,2
_gusTemp:
	.DS (2)
	.TYPE _gucVdmFlg,object,1
_gucVdmFlg:
	.DS (1)
	.TYPE _gucWaiCmp,object,1
_gucWaiCmp:
	.DS (1)
	.TYPE _gucOmfData,object,1
_gucOmfData:
	.DS (1)
	.TYPE _gucAuthFlg,object,1
_gucAuthFlg:
	.DS (1)
