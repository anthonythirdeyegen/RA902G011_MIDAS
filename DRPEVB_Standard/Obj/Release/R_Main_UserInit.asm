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
#@   -exec_time=C:\Users\AnthonyRusso\AppData\Local\Temp\CSPlusBuildTool_f77933be31b343fd93ec8db906f6b563gqip02wt.1wf
#@  compiled at Tue May 06 10:50:36 2025

	.EXTERN _gSndMess
	.EXTERN _gRcvMess
	.PUBLIC _gusRcvMess
	.PUBLIC _gusSndMess
	.PUBLIC _R_MAIN_UserInit
	.EXTERN _pdc_set_port_conf
	.EXTERN _pdc_set_src_conf
	.EXTERN _pdc_set_snk_conf
	.EXTERN _pdc_set_sys_conf
	.EXTERN _pdc_set_dev_stat
	.EXTERN _pdc_set_pwr_stat
	.EXTERN _pd_core_init
	.EXTERN _user_init

	.SECTION .textf,TEXTF
	.TYPE _R_MAIN_UserInit,function,.LFE1-_R_MAIN_UserInit
_R_MAIN_UserInit:
	.STACK _R_MAIN_UserInit = 6
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 17
	movw ax, #0x3C01
	call !!_pdc_set_port_conf
	movw ax, #0x0003
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 18
	push ax
	movw de, #0x0004
	clrw bc
	movw ax, #0xEA60
	call !!_pdc_set_src_conf
	pop ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 19
	movw de, #0x0005
	clrw bc
	movw ax, #0xEA60
	call !!_pdc_set_snk_conf
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 20
	movw bc, #0x0003
	movw ax, #0x0303
	call !!_pdc_set_sys_conf
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 21
	mov e, #0x00
	clrw bc
	clrw ax
	call !!_pdc_set_dev_stat
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 22
	clrb a
	call !!_pdc_set_pwr_stat
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 23
	movw ax, #LOWW(_gusRcvMess)
	movw !LOWW(_gRcvMess), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 24
	movw ax, #LOWW(_gusSndMess)
	movw !LOWW(_gSndMess), ax
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 25
	movw ax, #0x0100
	call !!_pd_core_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 26
	call !!_user_init
	.LINE "C:/Users/AnthonyRusso/Documents/Workspace/R9A02G011PDC_Lib_sample_premium/R9A02G011_251_DRPEVB/DRPEVB_Standard/R_Main_UserInit.c", 28
	ei
	ret
.LFE1:
	.SECTION .bss,BSS
	.ALIGN 2
	.TYPE _gusRcvMess,object,28
_gusRcvMess:
	.DS (28)
	.ALIGN 2
	.TYPE _gusSndMess,object,28
_gusSndMess:
	.DS (28)
