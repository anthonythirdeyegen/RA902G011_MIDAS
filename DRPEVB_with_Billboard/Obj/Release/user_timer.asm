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

	.PUBLIC _init_tau0_channel1
	.PUBLIC _init_tau0_channel2
	.PUBLIC _init_tau0_channel3
	.PUBLIC _init_tm_12bit
	.PUBLIC _tm_12bit_start_gtimer
	.EXTERN _pdc_set_int_routine
	.PUBLIC _tm_12tm_stop_gtimer
	.PUBLIC _tm_12bit_intr_hdlr
	.PUBLIC _tm1_start_gtimer
	.PUBLIC _tm2_start_gtimer
	.PUBLIC _tm1_is_start_gtimer
	.PUBLIC _tm3_start_gtimer
	.PUBLIC _tm1_stop_gtimer
	.PUBLIC _tm2_stop_gtimer
	.PUBLIC _tm3_stop_gtimer
	.PUBLIC _tm_calc_counter

	.SECTION .textf,TEXTF
	.TYPE _init_tau0_channel1,function,.LFE1-_init_tau0_channel1
_init_tau0_channel1:
	.STACK _init_tau0_channel1 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 16
	set1 0xFFFEE.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 17
	set1 0xFFFEA.3
	movw de, #0x0192
	movw ax, #0xC000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 19
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 21
	movw ax, [de+0x26]
	xch a, x
	and a, #0xFD
	xch a, x
	movw [de+0x26], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 22
	movw ax, [de+0x28]
	xch a, x
	and a, #0xFD
	xch a, x
	movw [de+0x28], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 24
	movw ax, [de+0x24]
	xch a, x
	or a, #0xF0
	xch a, x
	movw [de+0x24], ax
	ret
.LFE1:
	.TYPE _init_tau0_channel2,function,.LFE2-_init_tau0_channel2
_init_tau0_channel2:
	.STACK _init_tau0_channel2 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 29
	set1 0xFFFEE.4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 30
	set1 0xFFFEA.4
	movw de, #0x0194
	movw ax, #0x8000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 32
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 34
	movw ax, [de+0x24]
	xch a, x
	and a, #0xFB
	xch a, x
	movw [de+0x24], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 35
	movw ax, [de+0x26]
	xch a, x
	and a, #0xFB
	xch a, x
	movw [de+0x26], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 37
	movw ax, [de+0x22]
	or a, #0x02
	movw [de+0x22], ax
	ret
.LFE2:
	.TYPE _init_tau0_channel3,function,.LFE3-_init_tau0_channel3
_init_tau0_channel3:
	.STACK _init_tau0_channel3 = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 43
	set1 0xFFFEE.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 44
	set1 0xFFFEA.5
	movw de, #0x0196
	movw ax, #0xC000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 46
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 48
	movw ax, [de+0x22]
	xch a, x
	and a, #0xF7
	xch a, x
	movw [de+0x22], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 49
	movw ax, [de+0x24]
	xch a, x
	and a, #0xF7
	xch a, x
	movw [de+0x24], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 51
	movw ax, [de+0x20]
	or a, #0x10
	movw [de+0x20], ax
	ret
.LFE3:
	.TYPE _init_tm_12bit,function,.LFE4-_init_tm_12bit
_init_tm_12bit:
	.STACK _init_tm_12bit = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 57
	set1 !0x00F3.4
	ret
.LFE4:
	.TYPE _tm_12bit_start_gtimer,function,.LFE5-_tm_12bit_start_gtimer
_tm_12bit_start_gtimer:
	.STACK _tm_12bit_start_gtimer = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 60
	push ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 62
	clr1 0xFFFE3.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 63
	movw 0xFFF90, #0x0000
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 64
	clr1 0xFFFE7.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 65
	mov a, #0x15
	call !!_pdc_set_int_routine
	movw ax, [sp+0x00]
	movw bc, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 67
	shlw ax, 0x04
	subw ax, bc
	decw ax
	or a, #0x80
	and a, #0x8F
	movw 0xFFF90, ax
	pop ax
	ret
.LFE5:
	.TYPE _tm_12tm_stop_gtimer,function,.LFE6-_tm_12tm_stop_gtimer
_tm_12tm_stop_gtimer:
	.STACK _tm_12tm_stop_gtimer = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 72
	set1 0xFFFE7.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 73
	movw de, #0x0000
	clrw bc
	mov a, #0x15
	call !!_pdc_set_int_routine
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 74
	clr1 0xFFFE3.2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 75
	movw 0xFFF90, #0x0000
	ret
.LFE6:
	.TYPE _tm_12bit_intr_hdlr,function,.LFE7-_tm_12bit_intr_hdlr
_tm_12bit_intr_hdlr:
	.STACK _tm_12bit_intr_hdlr = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 81
	mov 0xFFFAB, #0xAC
	ret
.LFE7:
	.TYPE _tm1_start_gtimer,function,.LFE8-_tm1_start_gtimer
_tm1_start_gtimer:
	.STACK _tm1_start_gtimer = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 84
	push ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 86
	mov a, #0x0B
	call !!_pdc_set_int_routine
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 87
	call $!_tm_calc_counter
	movw 0xFFF1A, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 89
	clr1 0xFFFE2.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 90
	clr1 0xFFFE6.3
	movw de, #0x01B2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 91
	movw ax, [de]
	xch a, x
	or a, #0x02
	xch a, x
	movw [de], ax
	pop ax
	ret
.LFE8:
	.TYPE _tm2_start_gtimer,function,.LFE9-_tm2_start_gtimer
_tm2_start_gtimer:
	.STACK _tm2_start_gtimer = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 94
	push ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 96
	mov a, #0x0C
	call !!_pdc_set_int_routine
	movw de, #0x01B6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 97
	movw ax, [de]
	xch a, x
	and a, #0x0F
	xch a, x
	movw [de], ax
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 98
	cmpw ax, #0x07D1
	bc $.BB@LABEL@9_2
.BB@LABEL@9_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 99
	movw ax, [de]
	xch a, x
	or a, #0xF0
	br $.BB@LABEL@9_5
.BB@LABEL@9_2:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 100
	cmpw ax, #0x0015
	movw ax, [de]
	xch a, x
	bc $.BB@LABEL@9_4
.BB@LABEL@9_3:	; if_then_bb14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 101
	or a, #0xA0
	br $.BB@LABEL@9_5
.BB@LABEL@9_4:	; if_else_bb17
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 103
	or a, #0x40
.BB@LABEL@9_5:	; if_else_bb17
	xch a, x
	movw [de], ax
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 105
	call $!_tm_calc_counter
	movw 0xFFF64, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 106
	clr1 0xFFFE2.4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 107
	clr1 0xFFFE6.4
	movw de, #0x01B2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 108
	movw ax, [de]
	xch a, x
	or a, #0x04
	xch a, x
	movw [de], ax
	pop ax
	ret
.LFE9:
	.TYPE _tm1_is_start_gtimer,function,.LFE10-_tm1_is_start_gtimer
_tm1_is_start_gtimer:
	.STACK _tm1_is_start_gtimer = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 113
	movw ax, !0x01B0
	mov a, x
	shr a, 0x01
	and a, #0x01
	ret
.LFE10:
	.TYPE _tm3_start_gtimer,function,.LFE11-_tm3_start_gtimer
_tm3_start_gtimer:
	.STACK _tm3_start_gtimer = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 119
	push ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 121
	mov a, #0x0D
	call !!_pdc_set_int_routine
	movw ax, [sp+0x00]
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 122
	call $!_tm_calc_counter
	movw 0xFFF66, ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 124
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 125
	clr1 0xFFFE6.5
	movw de, #0x01B2
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 126
	movw ax, [de]
	xch a, x
	or a, #0x08
	xch a, x
	movw [de], ax
	pop ax
	ret
.LFE11:
	.TYPE _tm1_stop_gtimer,function,.LFE12-_tm1_stop_gtimer
_tm1_stop_gtimer:
	.STACK _tm1_stop_gtimer = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 128
	movw de, #0x01B4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 130
	movw ax, [de]
	xch a, x
	or a, #0x02
	xch a, x
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 131
	clr1 0xFFFE2.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 132
	set1 0xFFFE6.3
	ret
.LFE12:
	.TYPE _tm2_stop_gtimer,function,.LFE13-_tm2_stop_gtimer
_tm2_stop_gtimer:
	.STACK _tm2_stop_gtimer = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 135
	movw de, #0x01B4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 137
	movw ax, [de]
	xch a, x
	or a, #0x04
	xch a, x
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 138
	clr1 0xFFFE2.4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 139
	set1 0xFFFE6.4
	ret
.LFE13:
	.TYPE _tm3_stop_gtimer,function,.LFE14-_tm3_stop_gtimer
_tm3_stop_gtimer:
	.STACK _tm3_stop_gtimer = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 142
	movw de, #0x01B4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 144
	movw ax, [de]
	xch a, x
	or a, #0x08
	xch a, x
	movw [de], ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 145
	clr1 0xFFFE2.5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 146
	set1 0xFFFE6.5
	ret
.LFE14:
	.TYPE _tm_calc_counter,function,.LFE15-_tm_calc_counter
_tm_calc_counter:
	.STACK _tm_calc_counter = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 149
	cmpw ax, #0x07D1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 152
	bc $.BB@LABEL@15_3
.BB@LABEL@15_1:	; if_then_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 154
	movw bc, #0x02DC
	movw de, #0x03E8
.BB@LABEL@15_2:	; if_then_bb
	mulhu
	movw hl, #0x0000
	divwu
	decw ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 163
	ret
.BB@LABEL@15_3:	; if_else_bb
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 155
	cmpw ax, #0x0015
	bc $.BB@LABEL@15_5
.BB@LABEL@15_4:	; if_then_bb14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 157
	movw bc, #0x00EA
	movw de, #0x000A
	br $.BB@LABEL@15_2
.BB@LABEL@15_5:	; if_else_bb20
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/PDC/user_timer.c", 160
	movw bc, #0x05DC
	mulh
	decw ax
	ret
.LFE15:
