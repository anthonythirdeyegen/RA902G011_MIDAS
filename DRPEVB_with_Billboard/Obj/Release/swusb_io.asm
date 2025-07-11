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

	.PUBLIC _swusb_io_init
	.PUBLIC _swusb_io_is_enabled
	.PUBLIC _swusb_io_enable
	.PUBLIC _swusb_io_disable
	.PUBLIC _swusb_io_clear_irq

	.SECTION .textf,TEXTF
	.TYPE _swusb_io_init,function,.LFE1-_swusb_io_init
_swusb_io_init:
	.STACK _swusb_io_init = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 10
	and 0xFFF08, #0xFE
	mov a, #0xFE
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 11
	and a, !0xFF28
	mov 0xFFF28, a
	movw de, #0xFF25
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 14
	mov a, [de]
	set1 a.1
	mov [de], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 17
	mov a, [de]
	set1 a.0
	mov [de], a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 20
	clr1 0xFFFEC.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 21
	clr1 0xFFFE8.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 22
	clr1 0xFFF38.1
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 23
	set1 0xFFF39.1
	ret
.LFE1:
	.TYPE _swusb_io_is_enabled,function,.LFE2-_swusb_io_is_enabled
_swusb_io_is_enabled:
	.STACK _swusb_io_is_enabled = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 26
	oneb a
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 28
	and a, 0xFFF08
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 29
	ret
.LFE2:
	.TYPE _swusb_io_enable,function,.LFE3-_swusb_io_enable
_swusb_io_enable:
	.STACK _swusb_io_enable = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 34
	clr1 0xFFFE4.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 37
	or 0xFFF08, #0x01
	ret
.LFE3:
	.TYPE _swusb_io_disable,function,.LFE4-_swusb_io_disable
_swusb_io_disable:
	.STACK _swusb_io_disable = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 43
	clr1 0xFFFE4.3
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 46
	and 0xFFF08, #0xFE
	ret
.LFE4:
	.TYPE _swusb_io_clear_irq,function,.LFE5-_swusb_io_clear_irq
_swusb_io_clear_irq:
	.STACK _swusb_io_clear_irq = 4
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_with_Billboard/Billboard/swusb_io.c", 51
	clr1 0xFFFE0.3
	ret
.LFE5:
