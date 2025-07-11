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

	.PUBLIC _main_loop_normal
	.EXTERN _swusb_enable
	.EXTERN _swusb_proc
	.PUBLIC _main_loop_toggle
	.EXTERN _swusb_disable
	.PUBLIC _main_loop_measure
	.EXTERN _swusb_measure_rate
	.PUBLIC _main_loop_halt
	.PUBLIC _main_loop_heavy
	.PUBLIC _bbc_main
	.EXTERN _swusb_init
	.EXTERN _swusb_set_power_supply
	.EXTERN _swusb_bb_configured
	.EXTERN _swusb_bb_set_additional_failure_info

	.SECTION .textf,TEXTF
	.TYPE _main_loop_normal,function,.LFE1-_main_loop_normal
_main_loop_normal:
	.STACK _main_loop_normal = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 27
	call !!_swusb_enable
.BB@LABEL@1_1:	; bb1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 29
	call !!_swusb_proc
	br $.BB@LABEL@1_1
.LFE1:
	.TYPE _main_loop_toggle,function,.LFE2-_main_loop_toggle
_main_loop_toggle:
	.STACK _main_loop_toggle = 8
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 34
	subw sp, #0x04
	br $.BB@LABEL@2_14
.BB@LABEL@2_1:	; bb3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 42
	call !!_swusb_proc
	movw ax, [sp+0x00]
	addw ax, #0x0001
	movw [sp+0x00], ax
	movw ax, [sp+0x02]
	bnc $.BB@LABEL@2_4
.BB@LABEL@2_2:	; bb3
	incw ax
.BB@LABEL@2_3:	; bb3
	movw [sp+0x02], ax
.BB@LABEL@2_4:	; bb5
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 41
	cmpw ax, #0x0011
	movw ax, [sp+0x00]
	sknz
.BB@LABEL@2_5:	; bb5
	cmpw ax, #0xB340
.BB@LABEL@2_6:	; bb5
	bc $.BB@LABEL@2_1
.BB@LABEL@2_7:	; bb10
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 45
	call !!_swusb_disable
	clrw ax
	movw [sp+0x00], ax
	br $.BB@LABEL@2_10
.BB@LABEL@2_8:	; bb11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 47
	call !!_swusb_proc
	movw ax, [sp+0x00]
	addw ax, #0x0001
	movw [sp+0x00], ax
	movw ax, [sp+0x02]
	bnc $.BB@LABEL@2_11
.BB@LABEL@2_9:	; bb11
	incw ax
.BB@LABEL@2_10:	; bb11
	movw [sp+0x02], ax
.BB@LABEL@2_11:	; bb14
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 46
	cmpw ax, #0x0011
	movw ax, [sp+0x00]
	sknz
.BB@LABEL@2_12:	; bb14
	cmpw ax, #0xB340
.BB@LABEL@2_13:	; bb14
	bc $.BB@LABEL@2_8
.BB@LABEL@2_14:	; bb21
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 40
	call !!_swusb_enable
	clrw ax
	movw [sp+0x00], ax
	br $.BB@LABEL@2_3
.LFE2:
	.TYPE _main_loop_measure,function,.LFE3-_main_loop_measure
_main_loop_measure:
	.STACK _main_loop_measure = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 55
	call !!_swusb_enable
.BB@LABEL@3_1:	; bb1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 57
	call !!_swusb_proc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 60
	call !!_swusb_measure_rate
	br $.BB@LABEL@3_1
.LFE3:
	.TYPE _main_loop_halt,function,.LFE4-_main_loop_halt
_main_loop_halt:
	.STACK _main_loop_halt = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 67
	call !!_swusb_enable
.BB@LABEL@4_1:	; bb1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 69
	call !!_swusb_proc
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 77
	halt
	br $.BB@LABEL@4_1
.LFE4:
	.TYPE _main_loop_heavy,function,.LFE5-_main_loop_heavy
_main_loop_heavy:
	.STACK _main_loop_heavy = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 88
	call !!_swusb_enable
	br $.BB@LABEL@5_7
.BB@LABEL@5_1:	; bb3
	addw ax, #0x0001
	movw bc, ax
	sknc
.BB@LABEL@5_2:	; bb3
	incw de
.BB@LABEL@5_3:	; bb3
	movw ax, de
.BB@LABEL@5_4:	; bb5
	cmpw ax, #0x0000
	movw ax, bc
	sknz
.BB@LABEL@5_5:	; bb5
	cmpw ax, #0x2710
.BB@LABEL@5_6:	; bb5
	bc $.BB@LABEL@5_1
.BB@LABEL@5_7:	; bb11
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 90
	call !!_swusb_proc
	clrw ax
	movw bc, ax
	movw de, ax
	br $.BB@LABEL@5_4
.LFE5:
	.TYPE _bbc_main,function,.LFE6-_bbc_main
_bbc_main:
	.STACK _bbc_main = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 98
	call !!_swusb_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 101
	ei
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 104
	oneb a
	call !!_swusb_set_power_supply
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 107
	clrw ax
	call !!_swusb_bb_configured
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 108
	movw ax, #0x0100
	call !!_swusb_bb_configured
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 109
	movw ax, #0x0200
	call !!_swusb_bb_configured
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 110
	movw ax, #0x0300
	call !!_swusb_bb_configured
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 111
	oneb a
	call !!_swusb_bb_set_additional_failure_info
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/bbc_main.c", 117
	call !!_swusb_enable
	ret
.LFE6:
