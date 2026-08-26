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

	.PUBLIC _R_Systeminit
	.PUBLIC _hdwinit

	.SECTION .textf,TEXTF
	.TYPE _R_Systeminit,function,.LFE1-_R_Systeminit
_R_Systeminit:
	.STACK _R_Systeminit = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/Core/r_systeminit.c", 77
	mov !0x00F0, #0x31
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/Core/r_systeminit.c", 78
	mov !0x00FC, #0x9C
	ret
.LFE1:
	.TYPE _hdwinit,function,.LFE2-_hdwinit
_hdwinit:
	.STACK _hdwinit = 4
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/Core/r_systeminit.c", 98
	di
	.LINE "C:/Users/AnthonyRusso/OneDrive - Banc3 Federal/Documents/Workspace/RA902G011_MIDAS/Core/r_systeminit.c", 99
	call $!_R_Systeminit
	ret
.LFE2:
