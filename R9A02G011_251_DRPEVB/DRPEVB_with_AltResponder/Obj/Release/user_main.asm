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
#@   PDC\subdev\tmuxhs4446.c
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_ecc9417ec240495db11f2574a45372a1ol0f4dbw.oia
#@  compiled at Wed Aug 26 14:31:31 2026

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
	.PUBLIC _r_dbg
	.PUBLIC _enter_dbg
	.PUBLIC _hpd_int_init
	.PUBLIC _hpd_poll_task
	.PUBLIC _user_init
	.EXTERN _init_tau0_channel3
	.EXTERN _init_tm_12bit
	.EXTERN _subdev_init
	.EXTERN _smbm_init
	.EXTERN _sw_init
	.EXTERN _tmuxhs4446_request_mode
	.PUBLIC _user_func_event
	.EXTERN _pdc_get_status
	.EXTERN _pdc_get_cmd_result
	.EXTERN _user_func_start_timer_thermistor
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pdc_get_an_volt
	.EXTERN _pd_tm_chk_user_stat
	.EXTERN _pdc_set_cmd
	.EXTERN _pdc_get_req_volt

	.SECTION .textf,TEXTF
	.TYPE _hpd_int_init,function,.LFE1-_hpd_int_init
_hpd_int_init:
	.STACK _hpd_int_init = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 111
	set1 0xFFF28.2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 112
	set1 0xFFF21.7
	ret
.LFE1:
	.TYPE _hpd_get_level@1,function,.LFE2-_hpd_get_level@1
_hpd_get_level@1:
	.STACK _hpd_get_level@1 = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 136
	mov a, 0xFFF01
	shr a, 0x07
	ret
.LFE2:
	.TYPE _hpd_poll_task,function,.LFE3-_hpd_poll_task
_hpd_poll_task:
	.STACK _hpd_poll_task = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 143
	call $!_hpd_get_level@1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 145
	cmp a, !LOWW(_prev@8@hpd_poll_task)
	bz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 147
	oneb !LOWW(_g_hpd_toggled@5)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 148
	mov !LOWW(_g_hpd_state@6), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 149
	mov !LOWW(_prev@8@hpd_poll_task), a
.BB@LABEL@3_2:	; return
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 151
	ret
.LFE3:
	.TYPE _user_init,function,.LFE4-_user_init
_user_init:
	.STACK _user_init = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 163
	clr1 0xFFF01.6
	clr1 0xFFF21.6
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 164
	clr1 !0x0062.2
	clr1 0xFFF02.2
	clr1 0xFFF22.2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 166
	set1 0xFFF21.7
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 167
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 168
	set1 !0x0055.0
	set1 0xFFF05.0
	clr1 0xFFF25.0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 169
	set1 !0x0055.1
	set1 0xFFF05.1
	clr1 0xFFF25.1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 170
	clr1 0xFFF07.0
	clr1 0xFFF27.0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 171
	clr1 0xFFF07.1
	clr1 0xFFF27.1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 172
	clr1 0xFFF07.3
	clr1 0xFFF27.3
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 173
	set1 !0x0058.0
	set1 0xFFF08.0
	clr1 0xFFF28.0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 174
	clr1 0xFFF08.1
	clr1 0xFFF28.1
	movw hl, #0x0053
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 177
	mov a, [hl+0xA9]
	set1 a.1
	mov [hl+0xA9], a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 178
	set1 [hl].0
	set1 0xFFF03.0
	clr1 0xFFF23.0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 179
	set1 [hl].1
	set1 0xFFF03.1
	clr1 0xFFF23.1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 180
	set1 [hl].2
	set1 0xFFF03.2
	clr1 0xFFF23.2
	clrw ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 186
	movw !LOWW(_gusTemp), ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 187
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 188
	clrb !LOWW(_gucWaiCmp)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 189
	clrb !LOWW(_gucOmfData)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 190
	clrb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 191
	clrb !LOWW(_gucLEDStatus)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 193
	call !!_init_tau0_channel3
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 194
	call !!_init_tm_12bit
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 197
	call !!_subdev_init
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 198
	call !!_smbm_init
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 200
	call !!_sw_init
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 201
	call $!_hpd_int_init
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 203
	oneb a
	call !!_tmuxhs4446_request_mode
	ret
.LFE4:
	.TYPE _user_func_event,function,.LFE5-_user_func_event
_user_func_event:
	.STACK _user_func_event = 14
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 206
	subw sp, #0x0A
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 208
	call !!_pdc_get_status
	movw [sp+0x04], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 211
	call !!_pdc_get_cmd_result
	mov !LOWW(_r_dbg), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 213
	clrb !LOWW(_g_cmd_queued@7)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 215
	call $!_hpd_poll_task
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 219
	set1 0xFFF07.0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 253
	mov a, !LOWW(_gPdc+0x00002)
	.bf a.0, $!.BB@LABEL@5_14
.BB@LABEL@5_1:	; if_then_bb
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 254
	bf [hl].0, $.BB@LABEL@5_6
.BB@LABEL@5_2:	; if_then_bb38
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 259
	call !!_user_func_start_timer_thermistor
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 260
	mov a, [sp+0x04]
	mov1 CY, a.1
	mov a, !LOWW(_gLed)
	bnc $.BB@LABEL@5_4
.BB@LABEL@5_3:	; if_then_bb49
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 261
	set1 a.0
	br $.BB@LABEL@5_5
.BB@LABEL@5_4:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 264
	set1 a.1
.BB@LABEL@5_5:	; if_break_bb
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 266
	clr1 !LOWW(_gPdc+0x00002).0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 267
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@5_96
.BB@LABEL@5_6:	; if_else_bb59
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 270
	clr1 0xFFF02.2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 271
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@5_9
.BB@LABEL@5_7:	; if_then_bb65
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 275
	clrb !LOWW(_gucVdmFlg)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 276
	set1 !LOWW(_gLed).2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 277
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 278
	clrb !LOWW(_gucEnterModeEnable)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 279
	clrb !LOWW(_gucLEDStatus)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 280
	mov a, !LOWW(_gPdc)
	bt a.1, $.BB@LABEL@5_13
.BB@LABEL@5_8:	; if_then_bb77
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 281
	mov a, #0x08
	call !!_pd_tm_start_user_cnt
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 283
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@5_96
.BB@LABEL@5_9:	; if_else_bb84
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 290
	mov a, #0x03
	call !!_pdc_get_an_volt
	.bt a.7, $!.BB@LABEL@5_96
.BB@LABEL@5_10:	; if_then_bb90
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 292
	xor a, #0x80
	cmpw ax, #0x8320
	bc $.BB@LABEL@5_12
.BB@LABEL@5_11:	; bb
	movw bc, #0x028A
	mov a, #0x08
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	.bnz $!.BB@LABEL@5_96
.BB@LABEL@5_12:	; if_then_bb106
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 294
	mov a, #0x08
	call !!_pd_tm_stop_user_cnt
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 295
	clrb !LOWW(_gucWaiCmp)
.BB@LABEL@5_13:	; if_else_bb79
	clr1 !LOWW(_gPdc+0x00002).0
	br $!.BB@LABEL@5_96
.BB@LABEL@5_14:	; if_else_bb115
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 303
	bf a.1, $.BB@LABEL@5_19
.BB@LABEL@5_15:	; if_then_bb123
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 304
	mov a, !LOWW(_gLed)
	bf [hl].1, $.BB@LABEL@5_17
.BB@LABEL@5_16:	; if_then_bb134
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 305
	set1 a.0
	br $.BB@LABEL@5_18
.BB@LABEL@5_17:	; if_else_bb138
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 308
	set1 a.1
.BB@LABEL@5_18:	; if_break_bb142
	mov !LOWW(_gLed), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 310
	clr1 !LOWW(_gPdc+0x00002).1
	br $!.BB@LABEL@5_96
.BB@LABEL@5_19:	; if_else_bb146
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 312
	bf a.2, $.BB@LABEL@5_21
.BB@LABEL@5_20:	; if_then_bb154
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 313
	clr1 a.2
	br $.BB@LABEL@5_25
.BB@LABEL@5_21:	; if_else_bb158
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 315
	bf a.3, $.BB@LABEL@5_23
.BB@LABEL@5_22:	; if_then_bb166
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 316
	set1 0xFFF02.2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 322
	clr1 !LOWW(_gPdc+0x00002).3
	br $!.BB@LABEL@5_96
.BB@LABEL@5_23:	; if_else_bb170
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 324
	bf a.4, $.BB@LABEL@5_26
.BB@LABEL@5_24:	; if_then_bb178
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 326
	clr1 a.4
.BB@LABEL@5_25:	; if_then_bb178
	mov !LOWW(_gPdc+0x00002), a
	br $!.BB@LABEL@5_96
.BB@LABEL@5_26:	; if_else_bb182
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 328
	bf a.5, $.BB@LABEL@5_28
.BB@LABEL@5_27:	; if_then_bb190
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 329
	clr1 a.5
	br $.BB@LABEL@5_25
.BB@LABEL@5_28:	; if_else_bb194
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 331
	.bf a.6, $!.BB@LABEL@5_82
.BB@LABEL@5_29:	; if_then_bb202
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 333
	mov a, !LOWW(_gRcvMess+0x00003)
	mov b, a
	and a, #0xC0
	cmp a, #0x40
	.bnz $!.BB@LABEL@5_58
.BB@LABEL@5_30:	; if_then_bb209
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 335
	movw de, !LOWW(_gRcvMess)
	movw ax, [de]
	movw [sp+0x06], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 336
	movw de, !LOWW(_gRcvMess)
	movw ax, [de+0x02]
	movw [sp+0x08], ax
	mov a, b
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 338
	shr a, 0x01
	and a, #0x1F
	cmp a, #0x06
	bnz $.BB@LABEL@5_32
.BB@LABEL@5_31:	; if_then_bb231
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 339
	oneb !LOWW(_gGetStatPending@1)
	br $!.BB@LABEL@5_58
.BB@LABEL@5_32:	; if_else_bb232
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 345
	movw ax, sp
	addw ax, #0x0007
	movw hl, ax
	.bf [hl].7, $!.BB@LABEL@5_58
.BB@LABEL@5_33:	; if_then_bb242
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 349
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x02
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 346
	movw ax, !LOWW(_gSndMess)
	movw [sp+0x02], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 349
	bnz $.BB@LABEL@5_38
.BB@LABEL@5_34:	; if_then_bb254
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 351
	bf [hl].6, $.BB@LABEL@5_36
.BB@LABEL@5_35:	; if_then_bb254.bb269_crit_edge
	movw bc, #0xA042
	br $.BB@LABEL@5_37
.BB@LABEL@5_36:	; bb267
	movw bc, #0x8042
.BB@LABEL@5_37:	; bb269
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, bc
	movw [de], ax
	movw ax, #0xFF00
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 352
	movw [de+0x02], ax
	clrw ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 355
	movw [de+0x04], ax
	movw ax, #0xFF01
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 356
	movw [de+0x06], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 357
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x08
	and a, #0x08
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 358
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	br $!.BB@LABEL@5_58
.BB@LABEL@5_38:	; if_else_bb281
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 363
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x03
	bnz $.BB@LABEL@5_46
.BB@LABEL@5_39:	; bb291
	movw ax, [sp+0x08]
	cmpw ax, #0xFF01
	bnz $.BB@LABEL@5_46
.BB@LABEL@5_40:	; if_then_bb307
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 366
	bf [hl].6, $.BB@LABEL@5_42
.BB@LABEL@5_41:	; if_then_bb307.bb322_crit_edge
	movw bc, #0xA043
	br $.BB@LABEL@5_43
.BB@LABEL@5_42:	; bb320
	movw bc, #0x8043
.BB@LABEL@5_43:	; bb322
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, bc
	movw [de], ax
	movw ax, #0xFF01
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 367
	movw [de+0x02], ax
	movw ax, #0x00C5
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 382
	movw [de+0x04], ax
	movw ax, #0x0004
.BB@LABEL@5_44:	; bb322
	movw [de+0x06], ax
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x08
	and a, #0x08
.BB@LABEL@5_45:	; bb322
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	oneb !LOWW(_g_cmd_queued@7)
	br $!.BB@LABEL@5_58
.BB@LABEL@5_46:	; if_else_bb339
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 391
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x04
	bnz $.BB@LABEL@5_52
.BB@LABEL@5_47:	; bb349
	movw ax, [sp+0x08]
	cmpw ax, #0xFF01
	bnz $.BB@LABEL@5_52
.BB@LABEL@5_48:	; if_then_bb365
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 393
	oneb !LOWW(_gucEnterModeEnable)
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 394
	bf [hl].6, $.BB@LABEL@5_50
.BB@LABEL@5_49:	; if_then_bb365.bb380_crit_edge
	movw bc, #0xA144
	br $.BB@LABEL@5_51
.BB@LABEL@5_50:	; bb378
	movw bc, #0x8144
.BB@LABEL@5_51:	; bb380
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, bc
	movw [de], ax
	movw ax, #0xFF01
	movw [de+0x02], ax
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	br $.BB@LABEL@5_45
.BB@LABEL@5_52:	; if_else_bb388
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 402
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x05
	bnz $.BB@LABEL@5_62
.BB@LABEL@5_53:	; bb398
	movw ax, [sp+0x08]
	cmpw ax, #0xFF01
	bnz $.BB@LABEL@5_62
.BB@LABEL@5_54:	; if_then_bb414
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 404
	clrb !LOWW(_gucEnterModeEnable)
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 405
	bf [hl].6, $.BB@LABEL@5_56
.BB@LABEL@5_55:	; if_then_bb414.bb429_crit_edge
	movw bc, #0xA045
	br $.BB@LABEL@5_57
.BB@LABEL@5_56:	; bb427
	movw bc, #0x8045
.BB@LABEL@5_57:	; bb429
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, bc
	movw [de], ax
	movw ax, #0xFF01
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 406
	movw [de+0x02], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 407
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 408
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 409
	oneb !LOWW(_g_cmd_queued@7)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 410
	oneb a
	call !!_tmuxhs4446_request_mode
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 411
	clrb !LOWW(_g_dp_mode_configured@4)
.BB@LABEL@5_58:	; if_break_bb662
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 519
	cmp0 !LOWW(_gGetStatPending@1)
	bz $.BB@LABEL@5_61
.BB@LABEL@5_59:	; if_then_bb668
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 520
	call !!_pdc_get_cmd_result
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 523
	cmp a, #0x08
	bz $.BB@LABEL@5_61
.BB@LABEL@5_60:	; if_then_bb675
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 524
	movw ax, #0x1200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 528
	clrb !LOWW(_gGetStatPending@1)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 529
	mov !LOWW(_gGetStatLastResult@2), #0x08
.BB@LABEL@5_61:	; if_break_bb677
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 533
	clr1 !LOWW(_gPdc+0x00002).6
	br $!.BB@LABEL@5_96
.BB@LABEL@5_62:	; if_else_bb437
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 427
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x10
	bnz $.BB@LABEL@5_68
.BB@LABEL@5_63:	; bb447
	movw ax, [sp+0x08]
	cmpw ax, #0xFF01
	bnz $.BB@LABEL@5_68
.BB@LABEL@5_64:	; if_then_bb463
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 430
	set1 0xFFF07.0
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 441
	bf [hl].6, $.BB@LABEL@5_66
.BB@LABEL@5_65:	; if_then_bb463.bb482_crit_edge
	movw bc, #0xA050
	br $.BB@LABEL@5_67
.BB@LABEL@5_66:	; bb480
	movw bc, #0x8050
.BB@LABEL@5_67:	; bb482
	movw ax, [sp+0x02]
	movw de, ax
	movw ax, bc
	movw [de], ax
	movw ax, #0xFF01
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 442
	movw [de+0x02], ax
	movw ax, #0x000A
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 443
	movw [de+0x04], ax
	clrw ax
	br $!.BB@LABEL@5_44
.BB@LABEL@5_68:	; if_else_bb495
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 451
	mov a, [sp+0x06]
	and a, #0x1F
	cmp a, #0x11
	bnz $.BB@LABEL@5_71
.BB@LABEL@5_69:	; bb505
	movw ax, [sp+0x08]
	cmpw ax, #0xFF01
	bnz $.BB@LABEL@5_71
.BB@LABEL@5_70:	; bb505.bb516_crit_edge
	clrb a
	br $.BB@LABEL@5_72
.BB@LABEL@5_71:	; bb515
	oneb a
.BB@LABEL@5_72:	; bb516
	cmp0 a
	mov a, [sp+0x06]
	mov x, a
	bnz $.BB@LABEL@5_78
.BB@LABEL@5_73:	; if_then_bb521
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 461
	mov a, [sp+0x07]
	and a, #0x07
	mov [sp+0x01], a
	mov a, x
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 460
	and a, #0x1F
	mov [sp+0x00], a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 464
	mov a, [sp+0x04]
	.bf a.0, $!.BB@LABEL@5_58
.BB@LABEL@5_74:	; if_then_bb550
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 465
	bt [hl].3, $.BB@LABEL@5_76
.BB@LABEL@5_75:	; if_then_bb561
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 466
	mov a, #0x02
	br $.BB@LABEL@5_77
.BB@LABEL@5_76:	; if_else_bb562
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 470
	mov a, #0x03
.BB@LABEL@5_77:	; if_else_bb562
	call !!_tmuxhs4446_request_mode
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 475
	movw ax, [sp+0x06]
	movw hl, ax
	mov a, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 484
	shrw ax, 8+0x00000
	movw bc, ax
	mov a, [sp+0x01]
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 487
	clrb x
	movw [sp+0x00], ax
	movw ax, [sp+0x02]
	movw de, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 476
	movw ax, [sp+0x08]
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 490
	movw [de+0x02], ax
	movw ax, hl
	movw hl, sp
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 480
	xch a, x
	or a, #0x40
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 483
	and a, #0x60
	xch a, x
	and a, #0xF8
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 486
	or a, b
	xch a, x
	or a, c
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 487
	or a, [hl]
	xch a, x
	or a, [hl+0x01]
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 489
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 494
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x04
	and a, #0x04
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 495
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 496
	oneb !LOWW(_g_cmd_queued@7)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 497
	oneb !LOWW(_g_dp_mode_configured@4)
	br $!.BB@LABEL@5_58
.BB@LABEL@5_78:	; if_else_bb602
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 504
	set1 a.7
	clr1 a.6
	mov [sp+0x06], a
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	movw ax, sp
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 505
	bf [hl].6, $.BB@LABEL@5_80
.BB@LABEL@5_79:	; if_else_bb602.bb633_crit_edge
	addw ax, #0x0006
	br $.BB@LABEL@5_81
.BB@LABEL@5_80:	; bb626
	addw ax, #0x0008
.BB@LABEL@5_81:	; bb633
	movw de, ax
	movw ax, [de]
	movw bc, ax
	br $!.BB@LABEL@5_51
.BB@LABEL@5_82:	; if_else_bb681
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 535
	mov a, !LOWW(_gPdc+0x00003)
	mov b, a
	bf a.3, $.BB@LABEL@5_87
.BB@LABEL@5_83:	; if_then_bb689
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 536
	bf [hl].1, $.BB@LABEL@5_85
.BB@LABEL@5_84:	; if_then_bb700
	mov a, b
	clr1 a.3
	br $.BB@LABEL@5_95
.BB@LABEL@5_85:	; if_else_bb704
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 540
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@5_96
.BB@LABEL@5_86:	; if_then_bb709
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 541
	set1 !LOWW(_gDCInfo).6
	br $.BB@LABEL@5_84
.BB@LABEL@5_87:	; if_else_bb718
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 546
	bf a.2, $.BB@LABEL@5_89
.BB@LABEL@5_88:	; if_then_bb726
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 547
	clr1 a.2
	br $.BB@LABEL@5_95
.BB@LABEL@5_89:	; if_else_bb730
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 549
	bf a.4, $.BB@LABEL@5_91
.BB@LABEL@5_90:	; if_then_bb738
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 550
	clr1 a.4
	br $.BB@LABEL@5_95
.BB@LABEL@5_91:	; if_else_bb742
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 552
	bf a.5, $.BB@LABEL@5_93
.BB@LABEL@5_92:	; if_then_bb750
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 553
	clr1 a.5
	br $.BB@LABEL@5_95
.BB@LABEL@5_93:	; if_else_bb754
	bf a.6, $.BB@LABEL@5_96
.BB@LABEL@5_94:	; if_then_bb762
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 556
	clr1 a.6
.BB@LABEL@5_95:	; if_then_bb762
	mov !LOWW(_gPdc+0x00003), a
.BB@LABEL@5_96:	; if_break_bb777
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 559
	cmp0 !LOWW(_g_cmd_queued@7)
	bnz $.BB@LABEL@5_107
.BB@LABEL@5_97:	; bb788
	cmp0 !LOWW(_g_hpd_toggled@5)
	bz $.BB@LABEL@5_107
.BB@LABEL@5_98:	; bb793
	cmp0 !LOWW(_g_dp_mode_configured@4)
	bz $.BB@LABEL@5_107
.BB@LABEL@5_99:	; if_then_bb813
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 560
	call !!_pdc_get_cmd_result
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 563
	cmp a, #0x08
	bz $.BB@LABEL@5_107
.BB@LABEL@5_100:	; bb819
	cmp0 !LOWW(_gucEnterModeEnable)
	bz $.BB@LABEL@5_107
.BB@LABEL@5_101:	; if_then_bb832
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 566
	movw de, !LOWW(_gSndMess)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 570
	clrb !LOWW(_g_hpd_irq_flag@3)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 575
	mov a, !LOWW(_g_hpd_state@6)
	mov x, #0x80
	mulu x
	addw ax, #0x000A
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 578
	mov a, [sp+0x04]
	bf a.6, $.BB@LABEL@5_103
.BB@LABEL@5_102:	; if_then_bb832.bb857_crit_edge
	movw ax, #0xA106
	br $.BB@LABEL@5_104
.BB@LABEL@5_103:	; bb855
	movw ax, #0x8106
.BB@LABEL@5_104:	; bb857
	movw [de], ax
	movw ax, #0xFF01
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 579
	movw [de+0x02], ax
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 580
	movw [de+0x04], ax
	clrw ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 581
	movw [de+0x06], ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 583
	movw ax, !LOWW(_gSndMess+0x00002)
	xch a, x
	or a, #0x08
	and a, #0x08
	xch a, x
	and a, #0xFE
	movw !LOWW(_gSndMess+0x00002), ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 585
	call !!_pdc_get_cmd_result
	mov !LOWW(_r_dbg), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 586
	mov a, !LOWW(_gucEnterModeEnable)
	mov !LOWW(_enter_dbg), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 587
	movw ax, #0x2F00
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 589
	call !!_pdc_get_cmd_result
	mov !LOWW(_r_dbg), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 591
	cmp !LOWW(_r_dbg), #0x08
	bz $.BB@LABEL@5_106
.BB@LABEL@5_105:	; bb877
	cmp0 !LOWW(_r_dbg)
	bnz $.BB@LABEL@5_107
.BB@LABEL@5_106:	; if_then_bb890
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 592
	clrb !LOWW(_g_hpd_toggled@5)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 593
	oneb !LOWW(_g_cmd_queued@7)
.BB@LABEL@5_107:	; if_break_bb893
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 600
	mov a, !LOWW(_gPdc)
	mov b, a
	bf a.7, $.BB@LABEL@5_109
.BB@LABEL@5_108:	; if_then_bb900
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 601
	clr1 0xFFF01.6
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 602
	clr1 0xFFF01.7
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 603
	clr1 !LOWW(_gPdc).7
	br $!.BB@LABEL@5_147
.BB@LABEL@5_109:	; if_else_bb904
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 605
	bf a.6, $.BB@LABEL@5_113
.BB@LABEL@5_110:	; if_then_bb912
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	bf [hl].3, $.BB@LABEL@5_112
.BB@LABEL@5_111:	; if_then_bb923
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 607
	set1 0xFFF01.6
.BB@LABEL@5_112:	; if_break_bb925
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 612
	clr1 !LOWW(_gPdc).6
	br $!.BB@LABEL@5_147
.BB@LABEL@5_113:	; if_else_bb929
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 614
	bf a.1, $.BB@LABEL@5_123
.BB@LABEL@5_114:	; if_then_bb937
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 615
	clr1 0xFFF02.2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 616
	cmp0 !LOWW(_gucWaiCmp)
	bnz $.BB@LABEL@5_116
.BB@LABEL@5_115:	; if_then_bb943
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 617
	set1 !LOWW(_gDCInfo).0
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 618
	oneb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@5_147
.BB@LABEL@5_116:	; if_else_bb947
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 624
	mov a, !LOWW(_gDCInfo+0x00003)
	bf a.3, $.BB@LABEL@5_118
.BB@LABEL@5_117:	; if_then_bb955
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 625
	clr1 a.3
	mov !LOWW(_gDCInfo+0x00003), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 626
	clr1 0xFFF07.1
	br $.BB@LABEL@5_120
.BB@LABEL@5_118:	; if_else_bb962
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 631
	mov a, #0x03
	call !!_pdc_get_an_volt
	movw bc, ax
	.bt a.7, $!.BB@LABEL@5_147
.BB@LABEL@5_119:	; if_then_bb968
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 633
	xor a, #0x80
	cmpw ax, #0x8321
	bnc $.BB@LABEL@5_121
.BB@LABEL@5_120:	; if_then_bb973
	clr1 !LOWW(_gPdc).1
	clrb !LOWW(_gucWaiCmp)
	br $!.BB@LABEL@5_147
.BB@LABEL@5_121:	; if_else_bb977
	movw ax, bc
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 638
	xor a, #0x80
	cmpw ax, #0x957D
	.bnc $!.BB@LABEL@5_147
.BB@LABEL@5_122:	; if_then_bb982
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 639
	clr1 0xFFF07.3
	br $!.BB@LABEL@5_147
.BB@LABEL@5_123:	; if_else_bb988
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 646
	bf a.4, $.BB@LABEL@5_128
.BB@LABEL@5_124:	; if_then_bb996
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 647
	clr1 0xFFF02.2
	movw ax, sp
	addw ax, #0x0004
	movw hl, ax
	bf [hl].0, $.BB@LABEL@5_126
.BB@LABEL@5_125:	; if_else_bb1011
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 653
	call !!_pdc_get_req_volt
	or a, x
	sknz
.BB@LABEL@5_126:	; if_then_bb1016
	clr1 0xFFF07.3
.BB@LABEL@5_127:	; if_break_bb1021
	set1 !LOWW(_gDCInfo).3
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 658
	clr1 !LOWW(_gPdc).4
	br $!.BB@LABEL@5_147
.BB@LABEL@5_128:	; if_else_bb1025
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 660
	bf a.0, $.BB@LABEL@5_131
.BB@LABEL@5_129:	; if_then_bb1033
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 661
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@5_147
.BB@LABEL@5_130:	; if_then_bb1038
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 662
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 663
	set1 !LOWW(_gDCInfo).1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 664
	clr1 !LOWW(_gPdc).0
	br $.BB@LABEL@5_147
.BB@LABEL@5_131:	; if_else_bb1046
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 667
	bf a.2, $.BB@LABEL@5_135
.BB@LABEL@5_132:	; if_then_bb1054
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 671
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@5_147
.BB@LABEL@5_133:	; if_then_bb1059
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 672
	set1 !LOWW(_gDCInfo).2
	mov a, b
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 673
	clr1 a.2
.BB@LABEL@5_134:	; if_then_bb1059
	mov !LOWW(_gPdc), a
	br $.BB@LABEL@5_147
.BB@LABEL@5_135:	; if_else_bb1067
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 676
	bf a.3, $.BB@LABEL@5_138
.BB@LABEL@5_136:	; if_then_bb1075
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 677
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@5_147
.BB@LABEL@5_137:	; if_then_bb1080
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 678
	set1 0xFFF07.3
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 679
	set1 !LOWW(_gDCInfo).5
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 680
	clr1 !LOWW(_gPdc).3
	br $.BB@LABEL@5_147
.BB@LABEL@5_138:	; if_else_bb1088
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 683
	bf a.5, $.BB@LABEL@5_141
.BB@LABEL@5_139:	; if_then_bb1096
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 684
	movw ax, !LOWW(_gDCInfo)
	or a, x
	bnz $.BB@LABEL@5_147
.BB@LABEL@5_140:	; if_then_bb1101
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 685
	set1 !LOWW(_gDCInfo).6
	mov a, b
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 686
	clr1 a.5
	br $.BB@LABEL@5_134
.BB@LABEL@5_141:	; if_else_bb1109
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 689
	mov a, !LOWW(_gPdc+0x00001)
	bf a.0, $.BB@LABEL@5_143
.BB@LABEL@5_142:	; if_then_bb1117
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 690
	clr1 a.0
	mov !LOWW(_gPdc+0x00001), a
	br $.BB@LABEL@5_147
.BB@LABEL@5_143:	; if_else_bb1121
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 692
	movw hl, #LOWW(_gDCInfo+0x00003)
	bf [hl].3, $.BB@LABEL@5_145
.BB@LABEL@5_144:	; if_then_bb1129
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 694
	movw ax, #0x6200
	call !!_pdc_set_cmd
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 695
	clr1 !LOWW(_gDCInfo+0x00003).3
	br $.BB@LABEL@5_147
.BB@LABEL@5_145:	; if_else_bb1133
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 697
	movw ax, !LOWW(_gDCInfo+0x00002)
	or a, x
	bz $.BB@LABEL@5_147
.BB@LABEL@5_146:	; if_then_bb1138
	clrw ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 698
	movw !LOWW(_gDCInfo+0x00002), ax
.BB@LABEL@5_147:	; return
	addw sp, #0x0A
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/user_main.c", 700
	ret
.LFE5:
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
	.TYPE _r_dbg,object,1
_r_dbg:
	.DS (1)
	.TYPE _enter_dbg,object,1
_enter_dbg:
	.DS (1)
	.SECTION .data,DATA
	.TYPE _gGetStatPending@1,object,1
_gGetStatPending@1:
	.DS (1)
	.TYPE _gGetStatLastResult@2,object,1
_gGetStatLastResult@2:
	.DB 0xFF
	.TYPE _g_hpd_irq_flag@3,object,1
_g_hpd_irq_flag@3:
	.DB 0x01
	.TYPE _g_dp_mode_configured@4,object,1
_g_dp_mode_configured@4:
	.DS (1)
	.TYPE _g_hpd_toggled@5,object,1
_g_hpd_toggled@5:
	.DS (1)
	.TYPE _g_hpd_state@6,object,1
_g_hpd_state@6:
	.DS (1)
	.TYPE _g_cmd_queued@7,object,1
_g_cmd_queued@7:
	.DS (1)
	.TYPE _prev@8@hpd_poll_task,object,1
_prev@8@hpd_poll_task:
	.DS (1)
