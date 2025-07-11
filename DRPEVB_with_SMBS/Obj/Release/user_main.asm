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

	.EXTERN _gPdc
	.EXTERN _gSndMess
	.EXTERN _gRcvMess
	.EXTERN _gDCInfo
	.EXTERN _gLed
	.PUBLIC _gusTemp
	.PUBLIC _gucVdmFlg
	.PUBLIC _gucWaitSmbsCmdComp
	.PUBLIC _gucDrSwapMode_bak
	.PUBLIC _gucPrSwapMode_bak
	.PUBLIC _gucInputPwr_bak
	.PUBLIC _guCtrlCnf1_bak
	.PUBLIC _guCtrlCnf2_bak
	.PUBLIC _usSmbsRdo_bak
	.PUBLIC _gucWaiCmp
	.PUBLIC _gucOmfData
	.PUBLIC _gucReserved
	.PUBLIC _user_init
	.EXTERN _user_smbs_init
	.EXTERN _smbs_get_ctrl_conf1
	.EXTERN _smbs_get_ctrl_conf2
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
	.EXTERN _user_func_smbs_clr_rdo
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
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 49
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 50
	clr1 0xFFF01.7
	clr1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 51
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 52
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 53
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 54
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 55
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 56
	set1 !0x0058.2
	set1 0xFFF08.2
	clr1 0xFFF28.2
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 58
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 59
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 60
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 61
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 67
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 68
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 69
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 70
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 72
	call !!_user_smbs_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 73
	call !!_smbs_get_ctrl_conf1
	movw !LOWW(_guCtrlCnf1_bak), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 74
	call !!_smbs_get_ctrl_conf2
	movw !LOWW(_guCtrlCnf2_bak), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 75
	mov !LOWW(_gucDrSwapMode_bak), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 76
	mov !LOWW(_gucPrSwapMode_bak), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 77
	mov !LOWW(_gucInputPwr_bak), #0x03
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 79
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 80
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 82
	call !!_dcdc_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 83
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 84
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 85
	call !!_led_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 86
	call !!_sw_init
	ret
.LFE1:
	.TYPE _user_func_event,function,.LFE2-_user_func_event
_user_func_event:
	.STACK _user_func_event = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 89
	push hl
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 91
	call !!_pdc_get_status
	movw [sp+0x00], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 93
	mov a, !LOWW(_gPdc+0x00002)
	.bf a.0, $!.BB@LABEL@2_14
.BB@LABEL@2_1:	; if_then_bb
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 94
	bf [hl].0, $.BB@LABEL@2_6
.BB@LABEL@2_2:	; if_then_bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 98
	clr1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 99
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 100
	mov a, [sp+0x00]
	mov1 CY, a.1
	mov a, !LOWW(_gLed)
	bnc $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb32
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 101
	set1 a.0
	br $.BB@LABEL@2_5
.BB@LABEL@2_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 104
	set1 a.1
.BB@LABEL@2_5:	; if_break_bb
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 106
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 107
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_50
.BB@LABEL@2_6:	; if_else_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 110
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_9
.BB@LABEL@2_7:	; if_then_bb48
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 114
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 115
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 116
	call !!_user_func_smbs_clr_rdo
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 117
	movw hl, #LOWW(_gPdc)
	bt [hl].1, $.BB@LABEL@2_13
.BB@LABEL@2_8:	; if_then_bb59
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 118
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 119
	set1 0xFFF07.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 120
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_50
.BB@LABEL@2_9:	; if_else_bb66
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 127
	mov a, #0x03
	call !!_pdc_get_an_volt
	.bt a.7, $!.BB@LABEL@2_50
.BB@LABEL@2_10:	; if_then_bb72
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 129
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@2_12
.BB@LABEL@2_11:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@2_50
.BB@LABEL@2_12:	; if_then_bb89
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 131
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 132
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 133
	clr1 0xFFF07.1
.BB@LABEL@2_13:	; if_else_bb61
	clr1 !LOWW(_gPdc+0x00002).0
	br $!.BB@LABEL@2_50
.BB@LABEL@2_14:	; if_else_bb98
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 140
	bf a.1, $.BB@LABEL@2_19
.BB@LABEL@2_15:	; if_then_bb106
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 141
	bf [hl].1, $.BB@LABEL@2_17
.BB@LABEL@2_16:	; if_then_bb117
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 142
	call !!_user_func_smbs_clr_rdo
	oneb a
	br $.BB@LABEL@2_18
.BB@LABEL@2_17:	; if_else_bb121
	mov a, #0x02
.BB@LABEL@2_18:	; if_else_bb121
	or a, !LOWW(_gLed)
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 148
	clr1 !LOWW(_gPdc+0x00002).1
	br $!.BB@LABEL@2_50
.BB@LABEL@2_19:	; if_else_bb129
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 150
	bf a.2, $.BB@LABEL@2_21
.BB@LABEL@2_20:	; if_then_bb137
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 151
	clr1 a.2
	br $.BB@LABEL@2_23
.BB@LABEL@2_21:	; if_else_bb141
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 153
	bf a.3, $.BB@LABEL@2_24
.BB@LABEL@2_22:	; if_then_bb149
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 159
	clr1 a.3
.BB@LABEL@2_23:	; if_then_bb149
	mov !LOWW(_gPdc+0x00002), a
	br $!.BB@LABEL@2_50
.BB@LABEL@2_24:	; if_else_bb153
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 161
	bf a.4, $.BB@LABEL@2_26
.BB@LABEL@2_25:	; if_then_bb161
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 162
	movw de, !LOWW(_gSndMess)
	movw ax, !LOWW(_usSmbsRdo_bak)
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 163
	movw de, !LOWW(_gSndMess)
	movw ax, !LOWW(_usSmbsRdo_bak+0x00002)
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 164
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 165
	movw ax, #0x2200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 166
	clr1 !LOWW(_gPdc+0x00002).4
	br $.BB@LABEL@2_50
.BB@LABEL@2_26:	; if_else_bb174
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 168
	bf a.5, $.BB@LABEL@2_28
.BB@LABEL@2_27:	; if_then_bb182
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 169
	clr1 a.5
	br $.BB@LABEL@2_23
.BB@LABEL@2_28:	; if_else_bb186
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 171
	bf a.6, $.BB@LABEL@2_35
.BB@LABEL@2_29:	; if_then_bb194
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 172
	mov a, !LOWW(_gRcvMess+0x00003)
	mov x, a
	and a, #0xC0
	cmp a, #0x40
	bnz $.BB@LABEL@2_34
.BB@LABEL@2_30:	; if_then_bb201
	mov a, x
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 173
	shr a, 0x01
	and a, #0x1F
	cmp a, #0x0F
	bnz $.BB@LABEL@2_34
.BB@LABEL@2_31:	; if_then_bb209
	movw ax, sp
	movw hl, ax
	bf [hl].6, $.BB@LABEL@2_34
.BB@LABEL@2_32:	; bb219
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	addw ax, ax
	bc $.BB@LABEL@2_34
.BB@LABEL@2_33:	; if_then_bb234
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 176
	movw ax, #0x1000
	call !!_pdc_set_cmd
.BB@LABEL@2_34:	; if_break_bb237
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 180
	clr1 !LOWW(_gPdc+0x00002).6
	br $.BB@LABEL@2_50
.BB@LABEL@2_35:	; if_else_bb241
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 182
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@2_40
.BB@LABEL@2_36:	; if_then_bb249
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 183
	bf [hl].1, $.BB@LABEL@2_38
.BB@LABEL@2_37:	; if_then_bb260
	mov a, b
	clr1 a.3
	br $.BB@LABEL@2_42
.BB@LABEL@2_38:	; if_else_bb264
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 187
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_50
.BB@LABEL@2_39:	; if_then_bb269
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 188
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@2_37
.BB@LABEL@2_40:	; if_else_bb278
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 193
	bf a.2, $.BB@LABEL@2_43
.BB@LABEL@2_41:	; if_then_bb286
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 194
	clr1 a.2
.BB@LABEL@2_42:	; if_then_bb286
	mov !LOWW(_gPdc+0x00003), a
	br $.BB@LABEL@2_50
.BB@LABEL@2_43:	; if_else_bb290
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 196
	bf a.4, $.BB@LABEL@2_45
.BB@LABEL@2_44:	; if_then_bb298
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 197
	clr1 a.4
	br $.BB@LABEL@2_49
.BB@LABEL@2_45:	; if_else_bb302
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 200
	bf a.5, $.BB@LABEL@2_47
.BB@LABEL@2_46:	; if_then_bb310
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 201
	clr1 a.5
	br $.BB@LABEL@2_42
.BB@LABEL@2_47:	; if_else_bb314
	bf a.6, $.BB@LABEL@2_50
.BB@LABEL@2_48:	; if_then_bb322
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 204
	clr1 a.6
.BB@LABEL@2_49:	; if_then_bb322
	mov !LOWW(_gPdc+0x00003), a
	call !!_user_func_smbs_clr_rdo
.BB@LABEL@2_50:	; if_break_bb337
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 208
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@2_52
.BB@LABEL@2_51:	; if_then_bb344
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 209
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 210
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 211
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@2_91
.BB@LABEL@2_52:	; if_else_bb348
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 213
	bf a.6, $.BB@LABEL@2_57
.BB@LABEL@2_53:	; if_then_bb356
	movw ax, sp
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 214
	bf [hl].3, $.BB@LABEL@2_55
.BB@LABEL@2_54:	; if_then_bb367
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 215
	set1 0xFFF01.6
	br $.BB@LABEL@2_56
.BB@LABEL@2_55:	; if_else_bb368
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 218
	set1 0xFFF01.7
.BB@LABEL@2_56:	; if_break_bb369
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 220
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@2_91
.BB@LABEL@2_57:	; if_else_bb373
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 222
	bf a.1, $.BB@LABEL@2_67
.BB@LABEL@2_58:	; if_then_bb381
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 223
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@2_60
.BB@LABEL@2_59:	; if_then_bb387
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 224
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 225
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_91
.BB@LABEL@2_60:	; if_else_bb391
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 231
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@2_62
.BB@LABEL@2_61:	; if_then_bb399
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 232
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	br $.BB@LABEL@2_64
.BB@LABEL@2_62:	; if_else_bb406
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 238
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@2_91
.BB@LABEL@2_63:	; if_then_bb412
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 240
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@2_65
.BB@LABEL@2_64:	; if_then_bb417
	clr1 0xFFF07.1
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@2_91
.BB@LABEL@2_65:	; if_else_bb421
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 245
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@2_91
.BB@LABEL@2_66:	; if_then_bb426
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 246
	clr1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 247
	set1 0xFFF07.1
	br $!.BB@LABEL@2_91
.BB@LABEL@2_67:	; if_else_bb432
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 253
	bf a.4, $.BB@LABEL@2_72
.BB@LABEL@2_68:	; if_then_bb440
	movw ax, sp
	movw hl, ax
	bf [hl].0, $.BB@LABEL@2_70
.BB@LABEL@2_69:	; if_else_bb455
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 259
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@2_70:	; if_then_bb460
	clr1 0xFFF07.3
.BB@LABEL@2_71:	; if_break_bb465
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 264
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@2_91
.BB@LABEL@2_72:	; if_else_bb469
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 266
	bf a.0, $.BB@LABEL@2_75
.BB@LABEL@2_73:	; if_then_bb477
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 267
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_91
.BB@LABEL@2_74:	; if_then_bb482
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 268
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 269
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 270
	clr1 !LOWW(_gPdc).0
	br $.BB@LABEL@2_91
.BB@LABEL@2_75:	; if_else_bb490
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 273
	bf a.2, $.BB@LABEL@2_79
.BB@LABEL@2_76:	; if_then_bb498
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 277
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_91
.BB@LABEL@2_77:	; if_then_bb503
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 278
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 279
	clr1 a.2
.BB@LABEL@2_78:	; if_then_bb503
	mov !LOWW(_gPdc), a
	br $.BB@LABEL@2_91
.BB@LABEL@2_79:	; if_else_bb511
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 282
	bf a.3, $.BB@LABEL@2_82
.BB@LABEL@2_80:	; if_then_bb519
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 283
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_91
.BB@LABEL@2_81:	; if_then_bb524
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 284
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 285
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 286
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@2_91
.BB@LABEL@2_82:	; if_else_bb532
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 289
	bf a.5, $.BB@LABEL@2_85
.BB@LABEL@2_83:	; if_then_bb540
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 290
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@2_91
.BB@LABEL@2_84:	; if_then_bb545
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 291
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 292
	clr1 a.5
	br $.BB@LABEL@2_78
.BB@LABEL@2_85:	; if_else_bb553
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 295
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@2_87
.BB@LABEL@2_86:	; if_then_bb561
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 296
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@2_91
.BB@LABEL@2_87:	; if_else_bb565
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 298
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@2_89
.BB@LABEL@2_88:	; if_then_bb573
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 300
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 301
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@2_91
.BB@LABEL@2_89:	; if_else_bb577
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 303
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@2_91
.BB@LABEL@2_90:	; if_then_bb582
	clrw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 304
	movw !LOWW(_gDCInfo+0x00002), ax
.BB@LABEL@2_91:	; return
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_SMBS/PDC/user_main.c", 306
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
	.TYPE _gucWaitSmbsCmdComp,object,1
_gucWaitSmbsCmdComp:
	.DS (1)
	.TYPE _gucDrSwapMode_bak,object,1
_gucDrSwapMode_bak:
	.DS (1)
	.TYPE _gucPrSwapMode_bak,object,1
_gucPrSwapMode_bak:
	.DS (1)
	.TYPE _gucInputPwr_bak,object,1
_gucInputPwr_bak:
	.DS (1)
	.ALIGN 2
	.TYPE _guCtrlCnf1_bak,object,2
_guCtrlCnf1_bak:
	.DS (2)
	.ALIGN 2
	.TYPE _guCtrlCnf2_bak,object,2
_guCtrlCnf2_bak:
	.DS (2)
	.ALIGN 2
	.TYPE _usSmbsRdo_bak,object,4
_usSmbsRdo_bak:
	.DS (4)
	.TYPE _gucWaiCmp,object,1
_gucWaiCmp:
	.DS (1)
	.TYPE _gucOmfData,object,1
_gucOmfData:
	.DS (1)
	.TYPE _gucReserved,object,1
_gucReserved:
	.DS (1)
