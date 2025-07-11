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

	.EXTERN _gPdc
	.EXTERN _gRcvMess
	.EXTERN _gDCInfo
	.EXTERN _gLed
	.PUBLIC _gusTemp
	.PUBLIC _gucVdmFlg
	.PUBLIC _gucWaiCmp
	.PUBLIC _gucOmfData
	.PUBLIC _gucReserved
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 34
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 35
	clr1 0xFFF01.7
	clr1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 36
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 37
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 38
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 39
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 40
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 41
	set1 !0x0058.2
	set1 0xFFF08.2
	clr1 0xFFF28.2
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 43
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 44
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 45
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 46
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 52
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 53
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 54
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 55
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 57
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 58
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 60
	call !!_dcdc_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 61
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 62
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 63
	call !!_led_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 64
	call !!_sw_init
	ret
.LFE1:
	.TYPE _user_func_event,function,.LFE2-_user_func_event
_user_func_event:
	.STACK _user_func_event = 10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 67
	subw sp, #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 69
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 71
	mov a, !LOWW(_gPdc+0x00002)
	bf a.0, $.BB@LABEL@2_11
.BB@LABEL@2_1:	; if_then_bb
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 72
	bf [hl].0, $.BB@LABEL@2_3
.BB@LABEL@2_2:	; if_then_bb22
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 76
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 77
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 84
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 85
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_47
.BB@LABEL@2_3:	; if_else_bb37
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 88
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_6
.BB@LABEL@2_4:	; if_then_bb43
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 92
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 93
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 94
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 95
	movw hl, #LOWW(_gPdc)
	bt [hl].1, $.BB@LABEL@2_10
.BB@LABEL@2_5:	; if_then_bb55
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 96
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 97
	set1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 98
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_47
.BB@LABEL@2_6:	; if_else_bb62
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 105
	mov a, #0x03
	call !!_pdc_get_an_volt
	.bt a.7, $!.BB@LABEL@2_47
.BB@LABEL@2_7:	; if_then_bb68
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 107
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@2_9
.BB@LABEL@2_8:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_47
.BB@LABEL@2_9:	; if_then_bb84
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 109
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 110
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 111
	clr1 0xFFF07.1
.BB@LABEL@2_10:	; if_else_bb57
	clr1 !LOWW(_gPdc+0x00002).0
	br $!.BB@LABEL@2_47
.BB@LABEL@2_11:	; if_else_bb93
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 118
	bf a.1, $.BB@LABEL@2_13
.BB@LABEL@2_12:	; if_then_bb101
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 125
	clr1 a.1
	br $.BB@LABEL@2_19
.BB@LABEL@2_13:	; if_else_bb118
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 127
	bf a.2, $.BB@LABEL@2_15
.BB@LABEL@2_14:	; if_then_bb126
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 128
	clr1 a.2
	br $.BB@LABEL@2_19
.BB@LABEL@2_15:	; if_else_bb130
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 130
	bf a.3, $.BB@LABEL@2_17
.BB@LABEL@2_16:	; if_then_bb138
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 136
	clr1 a.3
	br $.BB@LABEL@2_19
.BB@LABEL@2_17:	; if_else_bb142
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 138
	bf a.4, $.BB@LABEL@2_20
.BB@LABEL@2_18:	; if_then_bb150
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 140
	clr1 a.4
.BB@LABEL@2_19:	; if_then_bb150
	mov !LOWW(_gPdc+0x00002), a
	br $!.BB@LABEL@2_47
.BB@LABEL@2_20:	; if_else_bb154
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 142
	bf a.5, $.BB@LABEL@2_22
.BB@LABEL@2_21:	; if_then_bb162
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 143
	clr1 a.5
	br $.BB@LABEL@2_19
.BB@LABEL@2_22:	; if_else_bb166
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 145
	bf a.6, $.BB@LABEL@2_33
.BB@LABEL@2_23:	; if_then_bb174
	mov a, #0xC0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 146
	and a, !LOWW(_gRcvMess+0x00003)
	cmp a, #0x40
	bnz $.BB@LABEL@2_32
.BB@LABEL@2_24:	; if_then_bb181
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 148
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 149
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x04], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 150
	movw ax, sp
	addw ax, #0x0003
	movw hl, ax
	bf [hl].7, $.BB@LABEL@2_30
.BB@LABEL@2_25:	; if_then_bb205
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 151
	mov a, [sp+0x02]
	and a, #0x1F
	cmp a, #0x06
	bnz $.BB@LABEL@2_32
.BB@LABEL@2_26:	; bb215
	movw ax, [sp+0x04]
	cmpw ax, #0x1234
	bnz $.BB@LABEL@2_32
.BB@LABEL@2_27:	; if_then_bb231
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 153
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x04]
	shlw ax, 0x0E
	shrw ax, 0x0E
	or a, x
	bnz $.BB@LABEL@2_29
.BB@LABEL@2_28:	; if_then_bb239
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 154
	clr1 0xFFF08.2
	br $.BB@LABEL@2_32
.BB@LABEL@2_29:	; if_else_bb240
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 157
	set1 0xFFF08.2
	br $.BB@LABEL@2_32
.BB@LABEL@2_30:	; if_else_bb243
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_32
.BB@LABEL@2_31:	; if_then_bb254
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 162
	movw ax, #0x1000
	call !!_pdc_set_cmd
.BB@LABEL@2_32:	; if_break_bb257
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 165
	clr1 !LOWW(_gPdc+0x00002).6
	br $.BB@LABEL@2_47
.BB@LABEL@2_33:	; if_else_bb261
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 167
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@2_38
.BB@LABEL@2_34:	; if_then_bb269
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 168
	bf [hl].1, $.BB@LABEL@2_36
.BB@LABEL@2_35:	; if_then_bb280
	mov a, b
	clr1 a.3
	br $.BB@LABEL@2_46
.BB@LABEL@2_36:	; if_else_bb284
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 172
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_47
.BB@LABEL@2_37:	; if_then_bb289
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 173
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@2_35
.BB@LABEL@2_38:	; if_else_bb298
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 178
	bf a.2, $.BB@LABEL@2_40
.BB@LABEL@2_39:	; if_then_bb306
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 179
	clr1 a.2
	br $.BB@LABEL@2_46
.BB@LABEL@2_40:	; if_else_bb310
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 181
	bf a.4, $.BB@LABEL@2_42
.BB@LABEL@2_41:	; if_then_bb318
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 182
	clr1 a.4
	br $.BB@LABEL@2_46
.BB@LABEL@2_42:	; if_else_bb322
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 184
	bf a.5, $.BB@LABEL@2_44
.BB@LABEL@2_43:	; if_then_bb330
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 185
	clr1 a.5
	br $.BB@LABEL@2_46
.BB@LABEL@2_44:	; if_else_bb334
	bf a.6, $.BB@LABEL@2_47
.BB@LABEL@2_45:	; if_then_bb342
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 188
	clr1 a.6
.BB@LABEL@2_46:	; if_then_bb342
	mov !LOWW(_gPdc+0x00003), a
.BB@LABEL@2_47:	; if_break_bb357
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 191
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@2_49
.BB@LABEL@2_48:	; if_then_bb364
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 192
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 193
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 194
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@2_88
.BB@LABEL@2_49:	; if_else_bb368
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 196
	bf a.6, $.BB@LABEL@2_54
.BB@LABEL@2_50:	; if_then_bb376
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 197
	bf [hl].3, $.BB@LABEL@2_52
.BB@LABEL@2_51:	; if_then_bb387
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 198
	set1 0xFFF01.6
	br $.BB@LABEL@2_53
.BB@LABEL@2_52:	; if_else_bb388
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 201
	set1 0xFFF01.7
.BB@LABEL@2_53:	; if_break_bb389
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 203
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@2_88
.BB@LABEL@2_54:	; if_else_bb393
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 205
	bf a.1, $.BB@LABEL@2_64
.BB@LABEL@2_55:	; if_then_bb401
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 206
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_57
.BB@LABEL@2_56:	; if_then_bb407
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 207
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 208
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_88
.BB@LABEL@2_57:	; if_else_bb411
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 214
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@2_59
.BB@LABEL@2_58:	; if_then_bb419
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 215
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	br $.BB@LABEL@2_61
.BB@LABEL@2_59:	; if_else_bb426
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 221
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@2_88
.BB@LABEL@2_60:	; if_then_bb432
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 223
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@2_62
.BB@LABEL@2_61:	; if_then_bb437
	clr1 0xFFF07.1
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_88
.BB@LABEL@2_62:	; if_else_bb441
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 228
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@2_88
.BB@LABEL@2_63:	; if_then_bb446
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 229
	clr1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 230
	set1 0xFFF07.1
	br $!.BB@LABEL@2_88
.BB@LABEL@2_64:	; if_else_bb452
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 236
	bf a.4, $.BB@LABEL@2_69
.BB@LABEL@2_65:	; if_then_bb460
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_67
.BB@LABEL@2_66:	; if_else_bb475
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 242
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@2_67:	; if_then_bb480
	clr1 0xFFF07.3
.BB@LABEL@2_68:	; if_break_bb485
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 247
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@2_88
.BB@LABEL@2_69:	; if_else_bb489
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 249
	bf a.0, $.BB@LABEL@2_72
.BB@LABEL@2_70:	; if_then_bb497
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 250
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_88
.BB@LABEL@2_71:	; if_then_bb502
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 251
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 252
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 253
	clr1 !LOWW(_gPdc).0
	br $.BB@LABEL@2_88
.BB@LABEL@2_72:	; if_else_bb510
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 256
	bf a.2, $.BB@LABEL@2_76
.BB@LABEL@2_73:	; if_then_bb518
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 260
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_88
.BB@LABEL@2_74:	; if_then_bb523
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 261
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 262
	clr1 a.2
.BB@LABEL@2_75:	; if_then_bb523
	mov !LOWW(_gPdc), a
	br $.BB@LABEL@2_88
.BB@LABEL@2_76:	; if_else_bb531
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 265
	bf a.3, $.BB@LABEL@2_79
.BB@LABEL@2_77:	; if_then_bb539
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 266
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_88
.BB@LABEL@2_78:	; if_then_bb544
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 267
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 268
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 269
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@2_88
.BB@LABEL@2_79:	; if_else_bb552
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 272
	bf a.5, $.BB@LABEL@2_82
.BB@LABEL@2_80:	; if_then_bb560
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 273
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_88
.BB@LABEL@2_81:	; if_then_bb565
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 274
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 275
	clr1 a.5
	br $.BB@LABEL@2_75
.BB@LABEL@2_82:	; if_else_bb573
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 278
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@2_84
.BB@LABEL@2_83:	; if_then_bb581
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 279
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@2_88
.BB@LABEL@2_84:	; if_else_bb585
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 281
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@2_86
.BB@LABEL@2_85:	; if_then_bb593
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 283
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 284
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@2_88
.BB@LABEL@2_86:	; if_else_bb597
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 286
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@2_88
.BB@LABEL@2_87:	; if_then_bb602
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 287
	movw !LOWW(_gDCInfo+0x00002), ax
.BB@LABEL@2_88:	; return
	addw sp, #0x06
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_AltInitiator/PDC/user_main.c", 289
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
