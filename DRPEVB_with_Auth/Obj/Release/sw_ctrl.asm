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

	.PUBLIC _gSW
	.PUBLIC _sw_init
	.EXTERN _init_tau0_channel1
	.EXTERN _pdc_set_int_routine
	.PUBLIC _sw_ctrl
	.PUBLIC _sw_func_intr_sw
	.PUBLIC _sw_func_intr_timer_sw
	.EXTERN _tm1_is_start_gtimer
	.EXTERN _pdc_timer_active
	.EXTERN _tm1_start_gtimer
	.EXTERN _tm1_stop_gtimer

	.SECTION .textf,TEXTF
	.TYPE _sw_init,function,.LFE1-_sw_init
_sw_init:
	.STACK _sw_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 20
	call !!_init_tau0_channel1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 21
	mov a, #LOW(HIGHW(_sw_func_intr_sw))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_sw_func_intr_sw)
	mov a, #0x07
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 22
	set1 0xFFF08.1
	set1 0xFFF28.1
	clr1 0xFFFE5.0
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 23
	clrb !LOWW(_gSW)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 24
	clrb !LOWW(_gSW+0x00001)
	ret
.LFE1:
	.TYPE _sw_ctrl,function,.LFE2-_sw_ctrl
_sw_ctrl:
	.STACK _sw_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 29
	cmp !LOWW(_gSW), #0x01
	mov a, !LOWW(_gSW+0x00001)
	bnz $.BB@LABEL@2_3
.BB@LABEL@2_1:	; switch_clause_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 31
	cmp0 a
	bnz $.BB@LABEL@2_5
.BB@LABEL@2_2:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 32
	clrb !LOWW(_gSW)
	br $.BB@LABEL@2_5
.BB@LABEL@2_3:	; switch_clause_bb7
	cmp0 a
	skz
.BB@LABEL@2_4:	; if_then_bb13
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 37
	oneb !LOWW(_gSW)
.BB@LABEL@2_5:	; switch_break_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 42
	call !!_tm1_is_start_gtimer
	cmp0 a
	mov a, #0x03
	sknz
.BB@LABEL@2_6:	; switch_break_bb
	mov a, #0x07
.BB@LABEL@2_7:	; switch_break_bb
	ret
.LFE2:
	.TYPE _sw_func_intr_sw,function,.LFE3-_sw_func_intr_sw
_sw_func_intr_sw:
	.STACK _sw_func_intr_sw = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 52
	call !!_pdc_timer_active
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 53
	mov a, #LOW(HIGHW(_sw_func_intr_timer_sw))
	shrw ax, 8+0x00000
	movw de, ax
	movw bc, #LOWW(_sw_func_intr_timer_sw)
	movw ax, #0x03E8
	call !!_tm1_start_gtimer
	ret
.LFE3:
	.TYPE _sw_func_intr_timer_sw,function,.LFE4-_sw_func_intr_timer_sw
_sw_func_intr_timer_sw:
	.STACK _sw_func_intr_timer_sw = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 58
	bf 0xFFF08.1, $.BB@LABEL@4_2
.BB@LABEL@4_1:	; entry.if_break_bb_crit_edge
	clrb a
	br $.BB@LABEL@4_3
.BB@LABEL@4_2:	; if_else_bb
	oneb a
.BB@LABEL@4_3:	; if_break_bb
	mov !LOWW(_gSW+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Auth/PDC/sw_ctrl.c", 64
	call !!_tm1_stop_gtimer
	ret
.LFE4:
	.SECTION .bss,BSS
	.TYPE _gSW,object,2
_gSW:
	.DS (2)
