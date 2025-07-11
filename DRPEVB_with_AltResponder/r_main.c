/***********************************************************************************************************************
* DISCLAIMER
* This software is supplied by Renesas Electronics Corporation and is only intended for use with Renesas products.
* No other uses are authorized. This software is owned by Renesas Electronics Corporation and is protected under all
* applicable laws, including copyright laws.
* THIS SOFTWARE IS PROVIDED "AS IS" AND RENESAS MAKES NO WARRANTIESREGARDING THIS SOFTWARE, WHETHER EXPRESS, IMPLIED
* OR STATUTORY, INCLUDING BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NON-INFRINGEMENT.  ALL SUCH WARRANTIES ARE EXPRESSLY DISCLAIMED.TO THE MAXIMUM EXTENT PERMITTED NOT PROHIBITED BY
* LAW, NEITHER RENESAS ELECTRONICS CORPORATION NOR ANY OF ITS AFFILIATED COMPANIES SHALL BE LIABLE FOR ANY DIRECT,
* INDIRECT, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES FOR ANY REASON RELATED TO THIS SOFTWARE, EVEN IF RENESAS OR
* ITS AFFILIATES HAVE BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
* Renesas reserves the right, without notice, to make changes to this software and to discontinue the availability
* of this software. By using this software, you agree to the additional terms and conditions found by accessing the
* following link:
* http://www.renesas.com/disclaimer
*
* Copyright (C) 2011, 2015 Renesas Electronics Corporation. All rights reserved.
***********************************************************************************************************************/

/***********************************************************************************************************************
* File Name    : r_main.c
* Version      : CodeGenerator for RL78/G14 V2.04.01.03 [30 Jan 2015]
* Device(s)    : R5F104LE
* Tool-Chain   : CCRL
* Description  : This file implements main function.
* Creation Date: 2015/06/22
***********************************************************************************************************************/

/***********************************************************************************************************************
Includes
***********************************************************************************************************************/
#include "r_cg_macrodriver.h"
#include "r_cg_timer.h"
/* Start user code for include. Do not edit comment generated here */
#include "typedefs.h"
#include "common.h"
#include "interrupt.h"
#include "R9A02G011PDC.h"
#include "R_Main_UserInit.h"
#include "user_main.h"
#include "user_timer.h"
#include "pd_defs.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "led_ctrl.h"
#include "sw_ctrl.h"
/* End user code. Do not edit comment generated here */
#include "r_cg_userdefine.h"

/***********************************************************************************************************************
Pragma directive
***********************************************************************************************************************/
/* Start user code for pragma. Do not edit comment generated here */
/* End user code. Do not edit comment generated here */

/***********************************************************************************************************************
Global variables and functions
***********************************************************************************************************************/
/* Start user code for global. Do not edit comment generated here */
/* End user code. Do not edit comment generated here */

/***********************************************************************************************************************
* Function Name: main
* Description  : This function implements main function.
* Arguments    : None
* Return Value : None
***********************************************************************************************************************/
void main(void)
{
	UCHAR ucMode = 0U;
	R_MAIN_UserInit();
    /* Start user code. Do not edit comment generated here */
	
	pdc_active();
	while (1U) {
		ucMode = pd_core();
		
		ucMode &= led_ctrl();
		ucMode &= sw_ctrl();
		
		if (gPdc.uPdReq.bit.bExitMain != 0U) {
			break;
		}
		
		if (   (gPdc.uPdReq.usData   != 0U)
		    || (gPdc.uPdEvent.usData != 0U)
		    || (gDCInfo.uReq.usData  != 0U)
		    || ((gDCInfo.uNtfy.usData & DCDC_NOTIFY_MASK) != 0U)
		    || (gDCInfo.uSt.bit.bDcSt == DCDC_INIT)
			|| (gSubdevInfo.ucSubdevAlertFlag != 0U)) {
			user_func_event();
		}
		else {
			ucMode &= user_func_chk_device();
#if 0		//Sample code of sending Discovery Identity message after power negotiation
			ucMode &= user_func_snd_mess();
#endif
			ucMode &= user_func_snd_attention();
			switch (ucMode) {
				case PD_CORE_LOW  :
					HALT();
					break;
				case PD_CORE_IDLE :
					tm_12bit_start_gtimer(pdc_get_idle_time(), (ULONG)&tm_12bit_intr_hdlr);
					HALT();
					tm_12tm_stop_gtimer();
					break;
				case PD_CORE_STOP :
					pdc_stop();
					tm_12bit_start_gtimer(pdc_get_idle_time(), (ULONG)&tm_12bit_intr_hdlr);
					STOP();
					pdc_run();
					tm_12tm_stop_gtimer();
					break;
				default : // PD_CORE_ACTIVE
					break;
			}
		}
		dcdc_ctrl();
		subdev_ctrl();
		smbm_ctrl();
	}

    /* End user code. Do not edit comment generated here */
}

/* Start user code for adding. Do not edit comment generated here */
/* End user code. Do not edit comment generated here */
