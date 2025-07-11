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

	.EXTERN _gPdc
	.EXTERN _gSndMess
	.EXTERN _gRcvMess
	.EXTERN _gDCInfo
	.EXTERN _gLed
	.PUBLIC _gusTemp
	.PUBLIC _gucVdmFlg
	.PUBLIC _gucWaiCmp
	.PUBLIC _gucOmfData
	.PUBLIC _gucReserved
	.PUBLIC _gucEnterModeEnable
	.PUBLIC _gucLEDStatus
	.PUBLIC _user_init
	.EXTERN _init_tau0_channel3
	.EXTERN _init_tm_12bit
	.EXTERN _dcdc_init
	.EXTERN _subdev_init
	.EXTERN _smbm_init
	.EXTERN _led_init
	.EXTERN _sw_init
	.PUBLIC _user_func_event
	.EXTERN _pdc_get_status
	.EXTERN _user_func_start_timer_thermistor
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pdc_get_an_volt
	.EXTERN _pd_tm_chk_user_stat
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_req_volt

	.SECTION .textf,TEXTF
	.TYPE _user_init,function,.LFE1-_user_init
_user_init:
	.STACK _user_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 36
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 37
	clr1 0xFFF01.7
	clr1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 38
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 39
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 40
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 41
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 42
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 43
	set1 !0x0058.2
	set1 0xFFF08.2
	clr1 0xFFF28.2
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 45
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 46
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 47
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 48
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 54
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 55
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 56
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 57
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 58
	clrb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 59
	clrb !LOWW(_gucLEDStatus)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 61
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 62
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 64
	call !!_dcdc_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 65
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 66
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 67
	call !!_led_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 68
	call !!_sw_init
	ret
.LFE1:
	.TYPE _user_func_event,function,.LFE2-_user_func_event
_user_func_event:
	.STACK _user_func_event = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 71
	subw sp, #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 73
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 75
	mov a, !LOWW(_gPdc+0x00002)
	.bf a.0, $!.BB@LABEL@2_14
.BB@LABEL@2_1:	; if_then_bb
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 76
	bf [hl].0, $.BB@LABEL@2_6
.BB@LABEL@2_2:	; if_then_bb22
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 80
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 81
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 82
	mov a, [sp+0x00]
	mov1 CY, a.1
	mov a, !LOWW(_gLed)
	bnc $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb33
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 83
	set1 a.0
	br $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 86
	set1 a.1
.BB@LABEL@2_5:	; if_break_bb
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 88
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 89
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_89
.BB@LABEL@2_6:	; if_else_bb43
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 92
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_9
.BB@LABEL@2_7:	; if_then_bb49
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 96
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 97
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 98
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 99
	clrb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 100
	clrb !LOWW(_gucLEDStatus)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 101
	mov a, !LOWW(_gPdc)
	bt a.1, $.BB@LABEL@2_13
.BB@LABEL@2_8:	; if_then_bb61
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 102
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 103
	set1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 104
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_89
.BB@LABEL@2_9:	; if_else_bb68
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 111
	mov a, #0x03
	call !!_pdc_get_an_volt
	.bt a.7, $!.BB@LABEL@2_89
.BB@LABEL@2_10:	; if_then_bb74
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 113
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@2_12
.BB@LABEL@2_11:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_89
.BB@LABEL@2_12:	; if_then_bb90
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 115
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 116
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 117
	clr1 0xFFF07.1
.BB@LABEL@2_13:	; if_else_bb63
	clr1 !LOWW(_gPdc+0x00002).0
	br $!.BB@LABEL@2_89
.BB@LABEL@2_14:	; if_else_bb99
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 124
	bf a.1, $.BB@LABEL@2_19
.BB@LABEL@2_15:	; if_then_bb107
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 125
	mov a, !LOWW(_gLed)
	bf [hl].1, $.BB@LABEL@2_17
.BB@LABEL@2_16:	; if_then_bb118
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 126
	set1 a.0
	br $.BB@LABEL@2_18
.BB@LABEL@2_17:	; if_else_bb122
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 129
	set1 a.1
.BB@LABEL@2_18:	; if_break_bb126
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 131
	clr1 !LOWW(_gPdc+0x00002).1
	br $!.BB@LABEL@2_89
.BB@LABEL@2_19:	; if_else_bb130
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 133
	bf a.2, $.BB@LABEL@2_21
.BB@LABEL@2_20:	; if_then_bb138
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 134
	clr1 a.2
	br $.BB@LABEL@2_25
.BB@LABEL@2_21:	; if_else_bb142
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 136
	bf a.3, $.BB@LABEL@2_23
.BB@LABEL@2_22:	; if_then_bb150
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 142
	clr1 a.3
	br $.BB@LABEL@2_25
.BB@LABEL@2_23:	; if_else_bb154
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 144
	bf a.4, $.BB@LABEL@2_26
.BB@LABEL@2_24:	; if_then_bb162
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 146
	clr1 a.4
.BB@LABEL@2_25:	; if_then_bb162
	mov !LOWW(_gPdc+0x00002), a
	br $!.BB@LABEL@2_89
.BB@LABEL@2_26:	; if_else_bb166
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 148
	bf a.5, $.BB@LABEL@2_28
.BB@LABEL@2_27:	; if_then_bb174
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 149
	clr1 a.5
	br $.BB@LABEL@2_25
.BB@LABEL@2_28:	; if_else_bb178
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 151
	.bf a.6, $!.BB@LABEL@2_75
.BB@LABEL@2_29:	; if_then_bb186
	mov a, #0xC0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 152
	and a, !LOWW(_gRcvMess+0x00003)
	cmp a, #0x40
	.bnz $!.BB@LABEL@2_74
.BB@LABEL@2_30:	; if_then_bb193
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 154
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 155
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x04], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 156
	movw ax, sp
	addw ax, #0x0003
	movw hl, ax
	.bf [hl].7, $!.BB@LABEL@2_71
.BB@LABEL@2_31:	; if_then_bb217
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 157
	mov a, [sp+0x02]
	and a, #0x1F
	cmp a, #0x02
	bnz $.BB@LABEL@2_42
.BB@LABEL@2_32:	; bb227
	movw ax, [sp+0x04]
	cmpw ax, #0xFF00
	bnz $.BB@LABEL@2_42
.BB@LABEL@2_33:	; bb242
	movw ax, !LOWW(_gRcvMess+0x00002)
	and a, #0x01
	cmpw ax, #0x0004
	bnz $.BB@LABEL@2_42
.BB@LABEL@2_34:	; bb255
	movw ax, sp
	movw hl, ax
	bf [hl].2, $.BB@LABEL@2_36
.BB@LABEL@2_35:	; bb265
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_42
.BB@LABEL@2_36:	; if_then_bb290
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 162
	movw de, !LOWW(_gSndMess)
	bf [hl].6, $.BB@LABEL@2_38
.BB@LABEL@2_37:	; if_then_bb290.if_break_bb307_crit_edge
	movw ax, #0xA042
	br $.BB@LABEL@2_39
.BB@LABEL@2_38:	; if_else_bb304
	movw ax, #0x8042
.BB@LABEL@2_39:	; if_break_bb307
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 168
	movw de, !LOWW(_gSndMess)
	movw ax, #0xFF00
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 169
	movw de, !LOWW(_gSndMess)
	clrw ax
	movw [de+0x04], ax
	movw ax, #0x1234
.BB@LABEL@2_40:	; if_break_bb307
	movw de, !LOWW(_gSndMess)
	movw [de+0x06], ax
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x08
	and a, #0x08
.BB@LABEL@2_41:	; if_break_bb307
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	mov a, #0x2F
	br $!.BB@LABEL@2_73
.BB@LABEL@2_42:	; if_else_bb317
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 174
	mov a, [sp+0x02]
	and a, #0x1F
	cmp a, #0x03
	bnz $.BB@LABEL@2_51
.BB@LABEL@2_43:	; bb327
	movw ax, [sp+0x04]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_51
.BB@LABEL@2_44:	; bb342
	movw ax, !LOWW(_gRcvMess+0x00002)
	and a, #0x01
	cmpw ax, #0x0004
	bnz $.BB@LABEL@2_51
.BB@LABEL@2_45:	; bb355
	movw ax, sp
	movw hl, ax
	bf [hl].2, $.BB@LABEL@2_47
.BB@LABEL@2_46:	; bb365
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_51
.BB@LABEL@2_47:	; if_then_bb390
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 179
	movw de, !LOWW(_gSndMess)
	bf [hl].6, $.BB@LABEL@2_49
.BB@LABEL@2_48:	; if_then_bb390.if_break_bb407_crit_edge
	movw ax, #0xA043
	br $.BB@LABEL@2_50
.BB@LABEL@2_49:	; if_else_bb404
	movw ax, #0x8043
.BB@LABEL@2_50:	; if_break_bb407
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 185
	movw de, !LOWW(_gSndMess)
	movw ax, #0x1234
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 186
	movw de, !LOWW(_gSndMess)
	onew ax
	movw [de+0x04], ax
	clrw ax
	br $.BB@LABEL@2_40
.BB@LABEL@2_51:	; if_else_bb417
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 191
	mov a, [sp+0x02]
	and a, #0x1F
	cmp a, #0x04
	bnz $.BB@LABEL@2_58
.BB@LABEL@2_52:	; bb427
	movw ax, [sp+0x04]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_58
.BB@LABEL@2_53:	; bb442
	movw ax, !LOWW(_gRcvMess+0x00002)
	and a, #0x01
	cmpw ax, #0x0004
	bnz $.BB@LABEL@2_58
.BB@LABEL@2_54:	; bb455
	movw ax, sp
	movw hl, ax
	bt [hl].2, $.BB@LABEL@2_58
.BB@LABEL@2_55:	; if_then_bb473
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 195
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 196
	oneb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 198
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_57
.BB@LABEL@2_56:	; if_then_bb473.if_break_bb491_crit_edge
	movw ax, #0xA044
	br $.BB@LABEL@2_65
.BB@LABEL@2_57:	; if_else_bb488
	movw ax, #0x8044
	br $.BB@LABEL@2_65
.BB@LABEL@2_58:	; if_else_bb497
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 208
	mov a, [sp+0x02]
	and a, #0x1F
	cmp a, #0x05
	bnz $.BB@LABEL@2_67
.BB@LABEL@2_59:	; bb507
	movw ax, [sp+0x04]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_67
.BB@LABEL@2_60:	; bb522
	movw ax, !LOWW(_gRcvMess+0x00002)
	and a, #0x01
	cmpw ax, #0x0004
	bnz $.BB@LABEL@2_67
.BB@LABEL@2_61:	; bb535
	movw ax, sp
	movw hl, ax
	bt [hl].2, $.BB@LABEL@2_67
.BB@LABEL@2_62:	; if_then_bb553
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 212
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 213
	clrb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 214
	clrb !LOWW(_gucLEDStatus)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 216
	mov a, [sp+0x00]
	movw de, !LOWW(_gSndMess)
	bf a.6, $.BB@LABEL@2_64
.BB@LABEL@2_63:	; if_then_bb553.if_break_bb571_crit_edge
	movw ax, #0xA045
	br $.BB@LABEL@2_65
.BB@LABEL@2_64:	; if_else_bb568
	movw ax, #0x8045
.BB@LABEL@2_65:	; if_break_bb571
	movw [de], ax
	movw ax, #0x1234
.BB@LABEL@2_66:	; if_break_bb571
	movw de, !LOWW(_gSndMess)
	movw [de+0x02], ax
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	br $!.BB@LABEL@2_41
.BB@LABEL@2_67:	; if_else_bb577
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 227
	mov a, [sp+0x02]
	set1 a.7
	clr1 a.6
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 228
	mov a, [sp+0x00]
	mov1 CY, a.6
	movw de, !LOWW(_gSndMess)
	movw ax, sp
	bnc $.BB@LABEL@2_69
.BB@LABEL@2_68:	; if_else_bb577.if_break_bb610_crit_edge
	addw ax, #0x0002
	br $.BB@LABEL@2_70
.BB@LABEL@2_69:	; if_else_bb602
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 232
	addw ax, #0x0004
.BB@LABEL@2_70:	; if_break_bb610
	movw hl, ax
	movw ax, [hl]
	movw [de], ax
	movw ax, #0xFF00
	br $.BB@LABEL@2_66
.BB@LABEL@2_71:	; if_else_bb620
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_74
.BB@LABEL@2_72:	; if_then_bb631
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 240
	mov a, #0x10
.BB@LABEL@2_73:	; if_then_bb631
	clrb x
	call !!_pdc_set_cmd
.BB@LABEL@2_74:	; if_break_bb634
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 243
	clr1 !LOWW(_gPdc+0x00002).6
	br $.BB@LABEL@2_89
.BB@LABEL@2_75:	; if_else_bb638
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 245
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@2_80
.BB@LABEL@2_76:	; if_then_bb646
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 246
	bf [hl].1, $.BB@LABEL@2_78
.BB@LABEL@2_77:	; if_then_bb657
	mov a, b
	clr1 a.3
	br $.BB@LABEL@2_88
.BB@LABEL@2_78:	; if_else_bb661
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 250
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_89
.BB@LABEL@2_79:	; if_then_bb666
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 251
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@2_77
.BB@LABEL@2_80:	; if_else_bb675
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 256
	bf a.2, $.BB@LABEL@2_82
.BB@LABEL@2_81:	; if_then_bb683
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 257
	clr1 a.2
	br $.BB@LABEL@2_88
.BB@LABEL@2_82:	; if_else_bb687
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 259
	bf a.4, $.BB@LABEL@2_84
.BB@LABEL@2_83:	; if_then_bb695
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 260
	clr1 a.4
	br $.BB@LABEL@2_88
.BB@LABEL@2_84:	; if_else_bb699
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 262
	bf a.5, $.BB@LABEL@2_86
.BB@LABEL@2_85:	; if_then_bb707
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 263
	clr1 a.5
	br $.BB@LABEL@2_88
.BB@LABEL@2_86:	; if_else_bb711
	bf a.6, $.BB@LABEL@2_89
.BB@LABEL@2_87:	; if_then_bb719
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 266
	clr1 a.6
.BB@LABEL@2_88:	; if_then_bb719
	mov !LOWW(_gPdc+0x00003), a
.BB@LABEL@2_89:	; if_break_bb734
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 269
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@2_91
.BB@LABEL@2_90:	; if_then_bb741
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 270
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 271
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 272
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@2_130
.BB@LABEL@2_91:	; if_else_bb745
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 274
	bf a.6, $.BB@LABEL@2_96
.BB@LABEL@2_92:	; if_then_bb753
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 275
	bf [hl].3, $.BB@LABEL@2_94
.BB@LABEL@2_93:	; if_then_bb764
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 276
	set1 0xFFF01.6
	br $.BB@LABEL@2_95
.BB@LABEL@2_94:	; if_else_bb765
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 279
	set1 0xFFF01.7
.BB@LABEL@2_95:	; if_break_bb766
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 281
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@2_130
.BB@LABEL@2_96:	; if_else_bb770
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 283
	bf a.1, $.BB@LABEL@2_106
.BB@LABEL@2_97:	; if_then_bb778
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 284
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_99
.BB@LABEL@2_98:	; if_then_bb784
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 285
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 286
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_130
.BB@LABEL@2_99:	; if_else_bb788
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 292
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@2_101
.BB@LABEL@2_100:	; if_then_bb796
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 293
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	br $.BB@LABEL@2_103
.BB@LABEL@2_101:	; if_else_bb803
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 299
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@2_130
.BB@LABEL@2_102:	; if_then_bb809
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 301
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@2_104
.BB@LABEL@2_103:	; if_then_bb814
	clr1 0xFFF07.1
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_130
.BB@LABEL@2_104:	; if_else_bb818
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 306
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@2_130
.BB@LABEL@2_105:	; if_then_bb823
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 307
	clr1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 308
	set1 0xFFF07.1
	br $!.BB@LABEL@2_130
.BB@LABEL@2_106:	; if_else_bb829
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 314
	bf a.4, $.BB@LABEL@2_111
.BB@LABEL@2_107:	; if_then_bb837
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_109
.BB@LABEL@2_108:	; if_else_bb852
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 320
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@2_109:	; if_then_bb857
	clr1 0xFFF07.3
.BB@LABEL@2_110:	; if_break_bb862
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 325
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@2_130
.BB@LABEL@2_111:	; if_else_bb866
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 327
	bf a.0, $.BB@LABEL@2_114
.BB@LABEL@2_112:	; if_then_bb874
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 328
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_130
.BB@LABEL@2_113:	; if_then_bb879
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 329
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 330
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 331
	clr1 !LOWW(_gPdc).0
	br $.BB@LABEL@2_130
.BB@LABEL@2_114:	; if_else_bb887
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 334
	bf a.2, $.BB@LABEL@2_118
.BB@LABEL@2_115:	; if_then_bb895
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 338
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_130
.BB@LABEL@2_116:	; if_then_bb900
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 339
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 340
	clr1 a.2
.BB@LABEL@2_117:	; if_then_bb900
	mov !LOWW(_gPdc), a
	br $.BB@LABEL@2_130
.BB@LABEL@2_118:	; if_else_bb908
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 343
	bf a.3, $.BB@LABEL@2_121
.BB@LABEL@2_119:	; if_then_bb916
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 344
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_130
.BB@LABEL@2_120:	; if_then_bb921
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 345
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 346
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 347
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@2_130
.BB@LABEL@2_121:	; if_else_bb929
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 350
	bf a.5, $.BB@LABEL@2_124
.BB@LABEL@2_122:	; if_then_bb937
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 351
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_130
.BB@LABEL@2_123:	; if_then_bb942
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 352
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 353
	clr1 a.5
	br $.BB@LABEL@2_117
.BB@LABEL@2_124:	; if_else_bb950
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 356
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@2_126
.BB@LABEL@2_125:	; if_then_bb958
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 357
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@2_130
.BB@LABEL@2_126:	; if_else_bb962
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 359
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@2_128
.BB@LABEL@2_127:	; if_then_bb970
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 361
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 362
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@2_130
.BB@LABEL@2_128:	; if_else_bb974
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 364
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@2_130
.BB@LABEL@2_129:	; if_then_bb979
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 365
	movw !LOWW(_gDCInfo+0x00002), ax
.BB@LABEL@2_130:	; return
	addw sp, #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 367
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
	.TYPE _gucReserved,object,1
_gucReserved:
	.DS (1)
	.TYPE _gucEnterModeEnable,object,1
_gucEnterModeEnable:
	.DS (1)
	.TYPE _gucLEDStatus,object,1
_gucLEDStatus:
	.DS (1)
