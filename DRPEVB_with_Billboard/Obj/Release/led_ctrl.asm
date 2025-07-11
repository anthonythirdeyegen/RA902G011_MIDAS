#CC-RL Compiler RL78 Assembler Source
#@  CC-RL Version : V1.15.00  [06 Dec 2024]
#@  Commmand :
#@   Billboard\bbc_main.c
#@   Billboard\crc16.c
#@   Billboard\swusb.c
#@   Billboard\swusb_io.c
#@   ..\..\Core\r_systeminit.c
#@   ..\..\PDC\smbm_ctrl.c
#@   ..\..\PDC\user_timer.c
#@   PDC\dcdc_ctrl.c
#@   PDC\led_ctrl.c
#@   PDC\sw_ctrl.c
#@   PDC\user_main.c
#@   PDC\user_main_protection.c
#@   pd_defs.c
#@   r_main.c
#@   R_Main_UserInit.c
#@   PDC\subdev\isl95338.c
#@   PDC\subdev\subdev_ctrl.c
#@   -cpu=S3
#@   -obj_path=Obj\Release
#@   -dev=C:\Program Files (x86)\Renesas Electronics\CS+\CC\Device\RL78\Devicefile\DR9A02G011.DVF
#@   -g
#@   -Osame_code
#@   -I Billboard
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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_c0b7818164c94c2192d757ba2474eae6iiaofrot.nwu
#@  compiled at Tue May 06 10:51:15 2025

	.PUBLIC _gLed
	.PUBLIC _led_init
	.PUBLIC _led_ctrl
	.EXTERN _pd_tm_stop_user_cnt
	.EXTERN _pd_tm_start_user_cnt
	.EXTERN _pd_tm_chk_user_stat

	.SECTION .textf,TEXTF
	.TYPE _led_init,function,.LFE1-_led_init
_led_init:
	.STACK _led_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 13
	ret
.LFE1:
	.TYPE _led_ctrl,function,.LFE2-_led_ctrl
_led_ctrl:
	.STACK _led_ctrl = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 19
	mov a, !LOWW(_gLed)
	bf a.0, $.BB@LABEL@2_2
.BB@LABEL@2_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 20
	clr1 0xFFF08.2
	br $.BB@LABEL@2_6
.BB@LABEL@2_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 23
	bf a.1, $.BB@LABEL@2_4
.BB@LABEL@2_3:	; if_then_bb15
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 24
	clr1 0xFFF08.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 25
	clrb !LOWW(_gLed+0x00001)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 26
	mov a, #0x09
	call !!_pd_tm_start_user_cnt
	br $.BB@LABEL@2_7
.BB@LABEL@2_4:	; if_else_bb17
	bf a.2, $.BB@LABEL@2_7
.BB@LABEL@2_5:	; if_then_bb25
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 29
	set1 0xFFF08.2
.BB@LABEL@2_6:	; if_then_bb25
	mov a, #0x09
	call !!_pd_tm_stop_user_cnt
.BB@LABEL@2_7:	; if_break_bb28
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 32
	clrb !LOWW(_gLed)
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 34
	movw bc, #0x000A
	mov a, #0x09
	call !!_pd_tm_chk_user_stat
	cmp a, #0x02
	bnz $.BB@LABEL@2_11
.BB@LABEL@2_8:	; if_then_bb34
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 35
	mov a, !LOWW(_gLed+0x00001)
	inc a
	mov !LOWW(_gLed+0x00001), a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 36
	shrw ax, 8+0x00000
	cmpw ax, #0x0032
	bc $.BB@LABEL@2_10
.BB@LABEL@2_9:	; if_then_bb42
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 37
	mov a, 0xFFF08
	mov1 CY, a.2
	mov a, 0xFFF08
	mov1 a.2, CY
	xor a, #0x04
	mov 0xFFF08, a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 38
	clrb !LOWW(_gLed+0x00001)
.BB@LABEL@2_10:	; if_break_bb53
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 40
	mov a, #0x09
	call !!_pd_tm_start_user_cnt
.BB@LABEL@2_11:	; if_break_bb55
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/PDC/led_ctrl.c", 43
	movw bc, #0x000A
	mov a, #0x09
	call !!_pd_tm_chk_user_stat
	cmp0 a
	oneb a
	sknz
.BB@LABEL@2_12:	; if_break_bb55
	mov a, #0x07
.BB@LABEL@2_13:	; if_break_bb55
	ret
.LFE2:
	.SECTION .bss,BSS
	.TYPE _gLed,object,2
_gLed:
	.DS (2)
