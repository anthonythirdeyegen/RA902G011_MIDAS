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

	.EXTERN _gSubdevInfo
	.EXTERN _gSubDevErr
	.EXTERN _gSmbmInfo
	.EXTERN _gAmcu
	.EXTERN _gAmcuBuf
	.PUBLIC _gRelamcuInfo
	.PUBLIC _init_relamcu
	.PUBLIC _relamcu_ctrl
	.PUBLIC _relamcu_reset
	.PUBLIC _relamcu_cmd_handler
	.PUBLIC _relamcu_stretch_cmd_handler
	.PUBLIC _relamcu_end_processing
	.PUBLIC _relamcu_reset_err
	.EXTERN _smbm_reset
	.EXTERN _smbm_set_subdev
	.EXTERN _smbm_set_protocol
	.EXTERN _smbm_clr_status
	.EXTERN _amcu_set_err

	.SECTION .textf,TEXTF
	.TYPE _init_relamcu,function,.LFE1-_init_relamcu
_init_relamcu:
	.STACK _init_relamcu = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 26
	clrb !LOWW(_gRelamcuInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 27
	clrb !LOWW(_gRelamcuInfo+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 28
	ret
.LFE1:
	.TYPE _relamcu_ctrl,function,.LFE2-_relamcu_ctrl
_relamcu_ctrl:
	.STACK _relamcu_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 36
	mov a, !LOWW(_gRelamcuInfo)
	add a, #0x7F
	cmp0 a
	bz $.BB@LABEL@2_4
.BB@LABEL@2_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@2_5
.BB@LABEL@2_2:	; entry
	add a, #0xFC
	cmp0 a
	bz $.BB@LABEL@2_9
.BB@LABEL@2_3:	; entry
	cmp a, #0x7A
	bnz $.BB@LABEL@2_10
.BB@LABEL@2_4:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 39
	call $!_relamcu_cmd_handler
	ret
.BB@LABEL@2_5:	; switch_clause_bb2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 42
	mov a, !LOWW(_gSmbmInfo)
	cmp a, #0x06
	bz $.BB@LABEL@2_8
.BB@LABEL@2_6:	; switch_clause_bb2
	cmp a, #0x08
	bz $.BB@LABEL@2_8
.BB@LABEL@2_7:	; switch_clause_bb2
	cmp a, #0x18
	bnz $.BB@LABEL@2_10
.BB@LABEL@2_8:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 45
	call $!_relamcu_end_processing
	ret
.BB@LABEL@2_9:	; switch_clause_bb29
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 49
	call $!_relamcu_stretch_cmd_handler
.BB@LABEL@2_10:	; return
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 56
	ret
.LFE2:
	.TYPE _relamcu_reset,function,.LFE3-_relamcu_reset
_relamcu_reset:
	.STACK _relamcu_reset = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 64
	cmp !LOWW(_gRelamcuInfo), #0x86
	sknz
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 65
	call !!_smbm_reset
.BB@LABEL@3_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 68
	clrb !LOWW(_gRelamcuInfo)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 69
	clr1 !LOWW(_gSubdevInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 70
	clr1 !LOWW(_gAmcu).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 72
	ret
.LFE3:
	.TYPE _relamcu_cmd_handler,function,.LFE4-_relamcu_cmd_handler
_relamcu_cmd_handler:
	.STACK _relamcu_cmd_handler = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 81
	cmp0 !LOWW(_gSmbmInfo)
	bz $.BB@LABEL@4_2
.BB@LABEL@4_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 82
	mov !LOWW(_gRelamcuInfo), #0x81
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 84
	ret
.BB@LABEL@4_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 87
	clrb !LOWW(_gSmbmInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 88
	movw ax, #0x03B8
	call !!_smbm_set_subdev
	movw ax, #0x000A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 90
	push ax
	mov a, !LOWW(_gAmcuBuf+0x00002)
	shrw ax, 8+0x00000
	push ax
	mov b, !LOWW(_gAmcuBuf+0x00001)
	mov x, !LOWW(_gAmcuBuf)
	mov a, !LOWW(_gAmcuBuf+0x00003)
	movw de, #LOWW(_gAmcuBuf+0x00004)
	clrb c
	call !!_smbm_set_protocol
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 99
	mov !LOWW(_gRelamcuInfo), #0x82
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 100
	call $!_relamcu_reset_err
	ret
.LFE4:
	.TYPE _relamcu_stretch_cmd_handler,function,.LFE5-_relamcu_stretch_cmd_handler
_relamcu_stretch_cmd_handler:
	.STACK _relamcu_stretch_cmd_handler = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 109
	movw ax, #0x000A
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 112
	push ax
	mov a, !LOWW(_gAmcuBuf+0x00002)
	shrw ax, 8+0x00000
	push ax
	mov b, !LOWW(_gAmcuBuf+0x00001)
	mov x, !LOWW(_gAmcuBuf)
	mov a, !LOWW(_gAmcuBuf+0x00003)
	movw de, #LOWW(_gAmcuBuf+0x00004)
	clrb c
	call !!_smbm_set_protocol
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 122
	mov !LOWW(_gRelamcuInfo), #0x82
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 124
	ret
.LFE5:
	.TYPE _relamcu_end_processing,function,.LFE6-_relamcu_end_processing
_relamcu_end_processing:
	.STACK _relamcu_end_processing = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 132
	mov a, !LOWW(_gSmbmInfo)
	cmp a, #0x06
	bnz $.BB@LABEL@6_2
.BB@LABEL@6_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 133
	mov !LOWW(_gRelamcuInfo), #0x86
	br $.BB@LABEL@6_6
.BB@LABEL@6_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 135
	cmp a, #0x18
	bnz $.BB@LABEL@6_4
.BB@LABEL@6_3:	; if_then_bb9
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 136
	call !!_smbm_clr_status
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 137
	set1 !LOWW(_gSubDevErr).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 138
	call !!_amcu_set_err
	br $.BB@LABEL@6_5
.BB@LABEL@6_4:	; if_else_bb14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 142
	call !!_smbm_clr_status
.BB@LABEL@6_5:	; if_else_bb14
	clrb !LOWW(_gRelamcuInfo)
.BB@LABEL@6_6:	; if_break_bb15
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 146
	clr1 !LOWW(_gSubdevInfo).1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 147
	clr1 !LOWW(_gAmcu).2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 149
	ret
.LFE6:
	.TYPE _relamcu_reset_err,function,.LFE7-_relamcu_reset_err
_relamcu_reset_err:
	.STACK _relamcu_reset_err = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/subdev/relamcu.c", 154
	clr1 !LOWW(_gSubDevErr).1
	ret
.LFE7:
	.SECTION .bss,BSS
	.TYPE _gRelamcuInfo,object,2
_gRelamcuInfo:
	.DS (2)
