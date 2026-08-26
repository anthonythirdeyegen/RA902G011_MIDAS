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

	.EXTERN _gSubdevInfo
	.EXTERN _gSubDevErr
	.EXTERN _gSmbmInfo
	.PUBLIC _gTmuxInfo
	.PUBLIC _init_tmuxhs4446
	.PUBLIC _tmuxhs4446_ctrl
	.EXTERN _smbm_set_subdev
	.EXTERN _smbm_set_protocol
	.EXTERN _smbm_clr_status
	.PUBLIC _tmuxhs4446_alert
	.PUBLIC _tmuxhs4446_request_mode

	.SECTION .textf,TEXTF
	.TYPE _init_tmuxhs4446,function,.LFE1-_init_tmuxhs4446
_init_tmuxhs4446:
	.STACK _init_tmuxhs4446 = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 26
	clrb !LOWW(_gTmuxInfo)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 27
	clrb !LOWW(_gTmuxInfo+0x00001)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 28
	oneb !LOWW(_gTmuxInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 29
	ret
.LFE1:
	.TYPE _tmuxhs4446_ctrl,function,.LFE2-_tmuxhs4446_ctrl
_tmuxhs4446_ctrl:
	.STACK _tmuxhs4446_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 35
	mov a, !LOWW(_gTmuxInfo)
	add a, #0x7F
	cmp0 a
	bz $.BB@LABEL@2_3
.BB@LABEL@2_1:	; entry
	dec a
	cmp0 a
	bz $.BB@LABEL@2_4
.BB@LABEL@2_2:	; entry
	cmp a, #0x7E
	bnz $.BB@LABEL@2_8
.BB@LABEL@2_3:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 38
	call $!_tmux_cmd_handler@1
	ret
.BB@LABEL@2_4:	; switch_clause_bb2
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 42
	mov a, !LOWW(_gSmbmInfo)
	cmp a, #0x06
	bz $.BB@LABEL@2_7
.BB@LABEL@2_5:	; switch_clause_bb2
	cmp a, #0x08
	bz $.BB@LABEL@2_7
.BB@LABEL@2_6:	; switch_clause_bb2
	cmp a, #0x18
	sknz
.BB@LABEL@2_7:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 45
	call $!_tmux_end_processing@1
.BB@LABEL@2_8:	; return
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 53
	ret
.LFE2:
	.TYPE _tmux_cmd_handler@1,function,.LFE3-_tmux_cmd_handler@1
_tmux_cmd_handler@1:
	.STACK _tmux_cmd_handler@1 = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 58
	cmp0 !LOWW(_gSmbmInfo)
	bz $.BB@LABEL@3_2
.BB@LABEL@3_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 59
	mov !LOWW(_gTmuxInfo), #0x81
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 60
	ret
.BB@LABEL@3_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 63
	clrb !LOWW(_gSmbmInfo+0x00002)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 64
	clr1 !LOWW(_gSubDevErr).1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 67
	movw ax, #0x02A8
	call !!_smbm_set_subdev
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 68
	call $!_tmux_cmd@1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 69
	mov !LOWW(_gTmuxInfo), #0x82
	ret
.LFE3:
	.TYPE _tmux_cmd@1,function,.LFE4-_tmux_cmd@1
_tmux_cmd@1:
	.STACK _tmux_cmd@1 = 10
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 74
	push hl
	mov a, #0x07
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 78
	and a, !LOWW(_gTmuxInfo+0x00002)
	mov [sp+0x00], a
	onew ax
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 81
	push ax
	push ax
	movw ax, sp
	addw ax, #0x0004
	movw de, ax
	movw bc, #0x0200
	movw ax, #0x0206
	call !!_smbm_set_protocol
	addw sp, #0x04
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 90
	pop ax
	ret
.LFE4:
	.TYPE _tmux_end_processing@1,function,.LFE5-_tmux_end_processing@1
_tmux_end_processing@1:
	.STACK _tmux_end_processing@1 = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 96
	cmp !LOWW(_gSmbmInfo), #0x18
	bnz $.BB@LABEL@5_2
.BB@LABEL@5_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 97
	set1 !LOWW(_gSubDevErr).1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 98
	mov a, !LOWW(_gSmbmInfo+0x00002)
	mov !LOWW(_gSubDevErr+0x00001), a
.BB@LABEL@5_2:	; if_break_bb
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 100
	call !!_smbm_clr_status
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 102
	clrb !LOWW(_gTmuxInfo)
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 103
	clr1 !LOWW(_gSubdevInfo).1
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 104
	ret
.LFE5:
	.TYPE _tmuxhs4446_alert,function,.LFE6-_tmuxhs4446_alert
_tmuxhs4446_alert:
	.STACK _tmuxhs4446_alert = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 110
	ret
.LFE6:
	.TYPE _tmuxhs4446_request_mode,function,.LFE7-_tmuxhs4446_request_mode
_tmuxhs4446_request_mode:
	.STACK _tmuxhs4446_request_mode = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 114
	and a, #0x07
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 116
	mov !LOWW(_gTmuxInfo+0x00002), a
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/R9A02G011_251_DRPEVB/DRPEVB_with_AltResponder/PDC/subdev/tmuxhs4446.c", 117
	set1 !LOWW(_gSubdevInfo).1
	ret
.LFE7:
	.SECTION .bss,BSS
	.TYPE _gTmuxInfo,object,3
_gTmuxInfo:
	.DS (3)
