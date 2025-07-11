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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_09d777f47a5f4b31a9476c44e920691802qmuapt.k0q
#@  compiled at Tue May 06 10:51:22 2025

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
	.PUBLIC _user_init
	.EXTERN _init_tau0_channel3
	.EXTERN _init_tm_12bit
	.EXTERN _dcdc_init
	.EXTERN _subdev_init
	.EXTERN _smbm_init
	.EXTERN _led_init
	.EXTERN _sw_init
	.PUBLIC _user_func_event
	.PUBLIC _user_intrusive_request
	.PUBLIC _user_make_rdo
	.EXTERN _pdc_get_status
	.EXTERN _user_func_start_timer_thermistor
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pdc_get_an_volt
	.EXTERN _pd_tm_chk_user_stat
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pdc_is_pps_mode
	.EXTERN _pdc_get_cmd_result
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_req_volt
	.EXTERN _pdc_get_rdo
	.EXTERN _pdc_get_num_of_pdos
	.EXTERN _pdc_get_pdo

	.SECTION .textf,TEXTF
	.TYPE _user_init,function,.LFE1-_user_init
_user_init:
	.STACK _user_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 38
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 39
	clr1 0xFFF01.7
	clr1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 40
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 41
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 42
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 43
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 44
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 45
	set1 !0x0058.2
	set1 0xFFF08.2
	clr1 0xFFF28.2
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 47
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 48
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 49
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 50
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 56
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 57
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 58
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 59
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 61
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 62
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 64
	call !!_dcdc_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 65
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 66
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 67
	call !!_led_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 68
	call !!_sw_init
	ret
.LFE1:
	.TYPE _user_func_event,function,.LFE2-_user_func_event
_user_func_event:
	.STACK _user_func_event = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 71
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 73
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 75
	mov a, !LOWW(_gPdc+0x00002)
	mov b, a
	.bf a.0, $!.BB@LABEL@2_17
.BB@LABEL@2_1:	; if_then_bb
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 76
	bf [hl].0, $.BB@LABEL@2_6
.BB@LABEL@2_2:	; if_then_bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 80
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 81
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 82
	mov a, [sp+0x00]
	mov1 CY, a.1
	mov a, !LOWW(_gLed)
	bnc $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb32
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 83
	set1 a.0
	br $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 86
	set1 a.1
.BB@LABEL@2_5:	; if_break_bb
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 88
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 89
	clrb !LOWW(_gucWaiCmp)
	br $.BB@LABEL@2_14
.BB@LABEL@2_6:	; if_else_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 92
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_10
.BB@LABEL@2_7:	; if_then_bb48
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 96
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 97
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 98
	movw hl, #LOWW(_gPdc)
	bt [hl].1, $.BB@LABEL@2_9
.BB@LABEL@2_8:	; if_then_bb59
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 99
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 100
	set1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 101
	oneb !LOWW(_gucWaiCmp)
	br $.BB@LABEL@2_14
.BB@LABEL@2_9:	; if_else_bb61
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 104
	clr1 a.0
	mov !LOWW(_gPdc+0x00002), a
	br $.BB@LABEL@2_14
.BB@LABEL@2_10:	; if_else_bb66
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 108
	mov a, #0x03
	call !!_pdc_get_an_volt
	bt a.7, $.BB@LABEL@2_14
.BB@LABEL@2_11:	; if_then_bb72
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 110
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@2_13
.BB@LABEL@2_12:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	bnz $.BB@LABEL@2_14
.BB@LABEL@2_13:	; if_then_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 112
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 113
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 114
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 115
	clr1 !LOWW(_gPdc+0x00002).0
.BB@LABEL@2_14:	; if_break_bb97
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 120
	movw hl, #LOWW(_gPdc+0x00002)
	.bt [hl].0, $!.BB@LABEL@2_61
.BB@LABEL@2_15:	; bb104
	cmp0 !LOWW(_gucWaiCmp)
	.bnz $!.BB@LABEL@2_61
.BB@LABEL@2_16:	; if_then_bb117
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 121
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	br $!.BB@LABEL@2_61
.BB@LABEL@2_17:	; if_else_bb120
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 124
	bf a.1, $.BB@LABEL@2_22
.BB@LABEL@2_18:	; if_then_bb128
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 125
	mov a, !LOWW(_gLed)
	bf [hl].1, $.BB@LABEL@2_20
.BB@LABEL@2_19:	; if_then_bb139
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 126
	set1 a.0
	br $.BB@LABEL@2_21
.BB@LABEL@2_20:	; if_else_bb143
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 129
	set1 a.1
.BB@LABEL@2_21:	; if_break_bb147
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 131
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 132
	clr1 !LOWW(_gPdc+0x00002).1
	br $!.BB@LABEL@2_61
.BB@LABEL@2_22:	; if_else_bb152
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 134
	bf a.2, $.BB@LABEL@2_24
.BB@LABEL@2_23:	; if_then_bb160
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 135
	clr1 a.2
	br $.BB@LABEL@2_33
.BB@LABEL@2_24:	; if_else_bb164
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 137
	bf a.3, $.BB@LABEL@2_29
.BB@LABEL@2_25:	; if_then_bb172
	movw ax, sp
	movw hl, ax
	bt [hl].1, $.BB@LABEL@2_28
.BB@LABEL@2_26:	; bb182
	call !!_pdc_is_pps_mode
	cmp0 a
	bz $.BB@LABEL@2_28
.BB@LABEL@2_27:	; if_then_bb195
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 144
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
.BB@LABEL@2_28:	; if_break_bb197
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 146
	clr1 !LOWW(_gPdc+0x00002).3
	br $!.BB@LABEL@2_61
.BB@LABEL@2_29:	; if_else_bb201
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 148
	bf a.4, $.BB@LABEL@2_31
.BB@LABEL@2_30:	; if_then_bb209
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 150
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 151
	clrb a
	call $!_user_intrusive_request
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 152
	clr1 !LOWW(_gPdc+0x00002).4
	br $!.BB@LABEL@2_61
.BB@LABEL@2_31:	; if_else_bb214
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 154
	bf a.5, $.BB@LABEL@2_34
.BB@LABEL@2_32:	; if_then_bb222
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 155
	clr1 a.5
.BB@LABEL@2_33:	; if_then_bb222
	mov !LOWW(_gPdc+0x00002), a
	br $!.BB@LABEL@2_61
.BB@LABEL@2_34:	; if_else_bb226
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 157
	bf a.6, $.BB@LABEL@2_47
.BB@LABEL@2_35:	; if_then_bb234
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 158
	mov a, !LOWW(_gRcvMess+0x00003)
	mov x, a
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_46
.BB@LABEL@2_36:	; if_then_bb241
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 159
	mov a, x
	shr a, 0x01
	and a, #0x1F
	cmp a, #0x06
	bnz $.BB@LABEL@2_40
.BB@LABEL@2_37:	; if_then_bb249
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 160
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	shlw ax, 0x04
	bnc $.BB@LABEL@2_46
.BB@LABEL@2_38:	; if_then_bb257
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 161
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	.bz $!.BB@LABEL@2_61
.BB@LABEL@2_39:	; if_then_bb263
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 162
	mov a, #0x14
	br $.BB@LABEL@2_44
.BB@LABEL@2_40:	; if_else_bb273
	mov a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 170
	shr a, 0x01
	and a, #0x1F
	cmp a, #0x0F
	bnz $.BB@LABEL@2_61
.BB@LABEL@2_41:	; if_then_bb281
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_45
.BB@LABEL@2_42:	; bb291
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	addw ax, ax
	bc $.BB@LABEL@2_45
.BB@LABEL@2_43:	; if_then_bb306
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 173
	mov a, #0x10
.BB@LABEL@2_44:	; if_then_bb306
	clrb x
	call !!_pdc_set_cmd
.BB@LABEL@2_45:	; if_break_bb307
	clr1 !LOWW(_gPdc+0x00002).6
	br $.BB@LABEL@2_61
.BB@LABEL@2_46:	; if_else_bb313
	mov a, b
	clr1 a.6
	br $.BB@LABEL@2_33
.BB@LABEL@2_47:	; if_else_bb318
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 182
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@2_52
.BB@LABEL@2_48:	; if_then_bb326
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 183
	bf [hl].1, $.BB@LABEL@2_50
.BB@LABEL@2_49:	; if_then_bb337
	mov a, b
	clr1 a.3
	br $.BB@LABEL@2_54
.BB@LABEL@2_50:	; if_else_bb341
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 187
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_61
.BB@LABEL@2_51:	; if_then_bb346
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 188
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@2_49
.BB@LABEL@2_52:	; if_else_bb355
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 193
	bf a.2, $.BB@LABEL@2_55
.BB@LABEL@2_53:	; if_then_bb363
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 194
	clr1 a.2
.BB@LABEL@2_54:	; if_then_bb363
	mov !LOWW(_gPdc+0x00003), a
	br $.BB@LABEL@2_61
.BB@LABEL@2_55:	; if_else_bb367
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 196
	bf a.4, $.BB@LABEL@2_57
.BB@LABEL@2_56:	; if_then_bb375
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 197
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 198
	clr1 !LOWW(_gPdc+0x00003).4
	br $.BB@LABEL@2_61
.BB@LABEL@2_57:	; if_else_bb380
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 200
	bf a.5, $.BB@LABEL@2_59
.BB@LABEL@2_58:	; if_then_bb388
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 201
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 202
	clr1 !LOWW(_gPdc+0x00003).5
	br $.BB@LABEL@2_61
.BB@LABEL@2_59:	; if_else_bb393
	bf a.6, $.BB@LABEL@2_61
.BB@LABEL@2_60:	; if_then_bb401
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 205
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 206
	clr1 !LOWW(_gPdc+0x00003).6
.BB@LABEL@2_61:	; if_break_bb417
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 209
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@2_63
.BB@LABEL@2_62:	; if_then_bb424
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 210
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 211
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 212
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@2_103
.BB@LABEL@2_63:	; if_else_bb428
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 214
	bf a.6, $.BB@LABEL@2_68
.BB@LABEL@2_64:	; if_then_bb436
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 215
	bf [hl].3, $.BB@LABEL@2_66
.BB@LABEL@2_65:	; if_then_bb447
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 216
	set1 0xFFF01.6
	br $.BB@LABEL@2_67
.BB@LABEL@2_66:	; if_else_bb448
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 219
	set1 0xFFF01.7
.BB@LABEL@2_67:	; if_break_bb449
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 221
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@2_103
.BB@LABEL@2_68:	; if_else_bb453
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 223
	bf a.1, $.BB@LABEL@2_78
.BB@LABEL@2_69:	; if_then_bb461
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 224
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_71
.BB@LABEL@2_70:	; if_then_bb467
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 225
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 226
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_103
.BB@LABEL@2_71:	; if_else_bb471
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 232
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@2_73
.BB@LABEL@2_72:	; if_then_bb479
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 233
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	br $.BB@LABEL@2_75
.BB@LABEL@2_73:	; if_else_bb486
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 239
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@2_103
.BB@LABEL@2_74:	; if_then_bb492
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 241
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@2_76
.BB@LABEL@2_75:	; if_then_bb497
	clr1 0xFFF07.1
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_103
.BB@LABEL@2_76:	; if_else_bb501
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 246
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@2_103
.BB@LABEL@2_77:	; if_then_bb506
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 247
	clr1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 248
	set1 0xFFF07.1
	br $!.BB@LABEL@2_103
.BB@LABEL@2_78:	; if_else_bb512
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 254
	bf a.4, $.BB@LABEL@2_83
.BB@LABEL@2_79:	; if_then_bb520
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_81
.BB@LABEL@2_80:	; if_else_bb535
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 260
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@2_81:	; if_then_bb540
	clr1 0xFFF07.3
.BB@LABEL@2_82:	; if_break_bb545
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 265
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@2_103
.BB@LABEL@2_83:	; if_else_bb549
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 267
	bf a.0, $.BB@LABEL@2_86
.BB@LABEL@2_84:	; if_then_bb557
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 268
	movw ax, !LOWW(_gDCInfo)
	or a, x
	.bnz $!.BB@LABEL@2_103
.BB@LABEL@2_85:	; if_then_bb562
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 269
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 270
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 271
	clr1 !LOWW(_gPdc).0
	br $.BB@LABEL@2_103
.BB@LABEL@2_86:	; if_else_bb570
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 274
	bf a.2, $.BB@LABEL@2_90
.BB@LABEL@2_87:	; if_then_bb578
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 278
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_103
.BB@LABEL@2_88:	; if_then_bb583
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 279
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 280
	clr1 a.2
.BB@LABEL@2_89:	; if_then_bb583
	mov !LOWW(_gPdc), a
	br $.BB@LABEL@2_103
.BB@LABEL@2_90:	; if_else_bb591
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 283
	bf a.3, $.BB@LABEL@2_93
.BB@LABEL@2_91:	; if_then_bb599
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 284
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_103
.BB@LABEL@2_92:	; if_then_bb604
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 285
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 286
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 287
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@2_103
.BB@LABEL@2_93:	; if_else_bb612
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 290
	bf a.5, $.BB@LABEL@2_96
.BB@LABEL@2_94:	; if_then_bb620
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 291
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_103
.BB@LABEL@2_95:	; if_then_bb625
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 292
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 293
	clr1 a.5
	br $.BB@LABEL@2_89
.BB@LABEL@2_96:	; if_else_bb633
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 296
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@2_98
.BB@LABEL@2_97:	; if_then_bb641
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 297
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@2_103
.BB@LABEL@2_98:	; if_else_bb645
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 299
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@2_101
.BB@LABEL@2_99:	; if_then_bb653
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 300
	call !!_pdc_get_cmd_result
	cmp a, #0x08
	bz $.BB@LABEL@2_103
.BB@LABEL@2_100:	; if_then_bb659
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 302
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 303
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@2_103
.BB@LABEL@2_101:	; if_else_bb664
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 306
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@2_103
.BB@LABEL@2_102:	; if_then_bb669
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 307
	movw !LOWW(_gDCInfo+0x00002), ax
.BB@LABEL@2_103:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 309
	ret
.LFE2:
	.TYPE _user_intrusive_request,function,.LFE3-_user_intrusive_request
_user_intrusive_request:
	.STACK _user_intrusive_request = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 311
	subw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 314
	dec a
	bnz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 315
	clrb a
	call !!_pdc_get_rdo
	br $.BB@LABEL@3_3
.BB@LABEL@3_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 318
	call $!_user_make_rdo
.BB@LABEL@3_3:	; if_else_bb
	movw [sp+0x00], ax
	movw ax, bc
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 320
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x00]
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 321
	movw de, !LOWW(_gSndMess)
	movw ax, [sp+0x02]
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 322
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 323
	movw ax, #0x2200
	call !!_pdc_set_cmd
	addw sp, #0x04
	ret
.LFE3:
	.TYPE _user_make_rdo,function,.LFE4-_user_make_rdo
_user_make_rdo:
	.STACK _user_make_rdo = 20
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 326
	subw sp, #0x10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 336
	movw ax, #0x0100
	call !!_pdc_get_num_of_pdos
	mov [sp+0x01], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 337
	onew ax
	call !!_pdc_get_num_of_pdos
	mov [sp+0x06], a
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 338
	movw [sp+0x04], ax
	movw [sp+0x02], ax
	br $!.BB@LABEL@4_19
.BB@LABEL@4_1:	; bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 341
	clrb c
	oneb x
	call !!_pdc_get_pdo
	movw [sp+0x0C], ax
	movw ax, bc
	movw [sp+0x0E], ax
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 342
	dec a
	.bnz $!.BB@LABEL@4_5
.BB@LABEL@4_2:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 343
	oneb c
	movw ax, #0x0100
	call !!_pdc_get_pdo
	movw [sp+0x08], ax
	movw ax, bc
	movw [sp+0x0A], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 344
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	movw ax, [sp+0x02]
	clrb x
	and a, #0xFC
	addw ax, bc
	movw hl, ax
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 345
	movw ax, [sp+0x04]
	xch a, x
	and a, #0xF0
	xch a, x
	movw de, ax
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	shrw ax, 0x06
	addw ax, de
	movw [sp+0x04], ax
	shlw bc, 0x0A
	movw ax, hl
	and a, #0x03
	addw ax, bc
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 346
	mov a, [sp+0x05]
	set1 a.4
	and a, #0x9F
	mov [sp+0x05], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 347
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	movw ax, [sp+0x0C]
	and a, #0x03
	cmpw ax, bc
	bnc $.BB@LABEL@4_4
.BB@LABEL@4_3:	; if_then_bb81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 348
	movw ax, [sp+0x0C]
	and a, #0x03
	movw bc, ax
	movw ax, [sp+0x02]
	clrb x
	and a, #0xFC
	addw ax, bc
	movw hl, ax
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 349
	movw ax, [sp+0x04]
	xch a, x
	and a, #0xF0
	xch a, x
	movw de, ax
	movw ax, [sp+0x0C]
	and a, #0x03
	movw bc, ax
	shrw ax, 0x06
	addw ax, de
	movw [sp+0x04], ax
	shlw bc, 0x0A
	movw ax, hl
	and a, #0x03
	addw ax, bc
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 350
	movw ax, sp
	addw ax, #0x0005
	movw hl, ax
	set1 [hl].2
.BB@LABEL@4_4:	; if_break_bb
	movw ax, [sp+0x04]
	movw bc, ax
	movw ax, [sp+0x02]
	br $!.BB@LABEL@4_21
.BB@LABEL@4_5:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 355
	mov a, [sp+0x0F]
	and a, #0xC0
	cmp a, #0xC0
	bnz $.BB@LABEL@4_11
.BB@LABEL@4_6:	; if_then_bb135
	mov a, [sp+0x06]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 356
	oneb c
	clrb x
	call !!_pdc_get_pdo
	movw [sp+0x08], ax
	movw ax, bc
	movw [sp+0x0A], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 357
	mov a, [sp+0x0C]
	clr1 a.7
	mov x, a
	mov a, [sp+0x08]
	clr1 a.7
	cmp a, x
	.bh $!.BB@LABEL@4_18
.BB@LABEL@4_7:	; bb156
	movw ax, [sp+0x0E]
	shrw ax, 0x01
	clrb a
	movw bc, ax
	movw ax, [sp+0x0A]
	shrw ax, 0x01
	clrb a
	cmpw ax, bc
	.bh $!.BB@LABEL@4_18
.BB@LABEL@4_8:	; bb179
	movw ax, sp
	addw ax, #0x000D
	movw hl, ax
	mov a, [sp+0x09]
	cmp a, [hl]
	.bc $!.BB@LABEL@4_18
.BB@LABEL@4_9:	; if_then_bb200
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 361
	mov a, [sp+0x02]
	or a, #0x14
	and a, #0x94
	mov [sp+0x02], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 362
	movw ax, [sp+0x04]
	xch a, x
	or a, #0x02
	and a, #0xF2
	xch a, x
	movw [sp+0x04], ax
	movw ax, [sp+0x02]
	or a, #0x4E
	and a, #0x4F
.BB@LABEL@4_10:	; if_then_bb200
	movw [sp+0x02], ax
	mov a, [sp+0x01]
	shl a, 0x04
	and a, #0x70
	mov x, a
	mov a, [sp+0x05]
	and a, #0x8F
	add a, x
	mov [sp+0x05], a
	br $.BB@LABEL@4_4
.BB@LABEL@4_11:	; if_else_bb230
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 367
	mov a, [sp+0x0F]
	and a, #0xC0
	cmp0 a
	bnz $.BB@LABEL@4_18
.BB@LABEL@4_12:	; if_else_bb230.bb343_crit_edge
	mov a, [sp+0x06]
	br $.BB@LABEL@4_17
.BB@LABEL@4_13:	; bb242
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 369
	oneb c
	clrb x
	call !!_pdc_get_pdo
	movw de, ax
	movw [sp+0x08], ax
	movw ax, bc
	movw [sp+0x0A], ax
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 370
	shlw bc, 0x06
	movw ax, de
	shrw ax, 0x0A
	addw ax, bc
	movw de, ax
	movw ax, [sp+0x0E]
	movw bc, ax
	shlw bc, 0x06
	movw ax, [sp+0x0C]
	shrw ax, 0x0A
	addw ax, bc
	xor a, d
	xch a, x
	xor a, e
	xch a, x
	and a, #0x03
	or a, x
	bnz $.BB@LABEL@4_16
.BB@LABEL@4_14:	; bb265
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	movw ax, [sp+0x0C]
	and a, #0x03
	cmpw ax, bc
	bc $.BB@LABEL@4_16
.BB@LABEL@4_15:	; if_then_bb290
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 372
	movw ax, [sp+0x04]
	xch a, x
	and a, #0xF0
	xch a, x
	movw de, ax
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	shrw ax, 0x06
	addw ax, de
	movw [sp+0x04], ax
	shlw bc, 0x0A
	movw ax, [sp+0x02]
	and a, #0x03
	addw ax, bc
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 373
	movw ax, [sp+0x08]
	and a, #0x03
	movw bc, ax
	movw ax, [sp+0x02]
	clrb x
	and a, #0xFC
	addw ax, bc
	br $.BB@LABEL@4_10
.BB@LABEL@4_16:	; if_break_bb340
	mov a, [sp+0x00]
	dec a
.BB@LABEL@4_17:	; if_break_bb340
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 368
	cmp a, #0x02
	bnc $.BB@LABEL@4_13
.BB@LABEL@4_18:	; if_break_bb352
	movw hl, sp
	dec [hl+0x01]
.BB@LABEL@4_19:	; bb355
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 340
	cmp0 a
	.bnz $!.BB@LABEL@4_1
.BB@LABEL@4_20:	; bb363
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_PPSsink/PDC/user_main.c", 383
	clrw bc
	clrw ax
.BB@LABEL@4_21:	; bb363
	addw sp, #0x10
	ret
.LFE4:
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
