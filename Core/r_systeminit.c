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
* File Name    : r_systeminit.c
* Version      : CodeGenerator for RL78/G14 V2.04.01.03 [30 Jan 2015]
* Device(s)    : R5F104LE
* Tool-Chain   : CCRL
* Description  : This file implements system initializing function.
* Creation Date: 2015/06/22
***********************************************************************************************************************/

/***********************************************************************************************************************
Includes
***********************************************************************************************************************/
#include "r_cg_macrodriver.h"
#include "r_cg_timer.h"
/* Start user code for include. Do not edit comment generated here */
/* End user code. Do not edit comment generated here */
#include "r_cg_userdefine.h"

#ifdef __IAR_C99__
/* Set option bytes */
//#include "typedefs.h"
#pragma location = "OPTBYTE"
__root const uint8_t opbyte0 = 0x7FU;
#pragma location = "OPTBYTE"
__root const uint8_t opbyte1 = 0x7BU;
#pragma location = "OPTBYTE"
__root const uint8_t opbyte2 = 0xE0U;
#pragma location = "OPTBYTE"
__root const uint8_t opbyte3 = 0x04U;
/* Set security ID */
#pragma location = "SECUID"
__root const uint8_t secuid[10] =
{0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U, 0x00U};


#endif

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
* Function Name: R_Systeminit
* Description  : This function initializes every macro.
* Arguments    : None
* Return Value : None
***********************************************************************************************************************/
void R_Systeminit(void)
{
	PER0 = (PER0_TAU0 | PER0_ADC | PER0_IICA0);
	PER2 = (PER2_TCSCNT | PER2_PDTICK | PER2_TMKA | PER2_SMBS);
}


/***********************************************************************************************************************
* Function Name: hdwinit
* Description  : This function initializes hardware setting.
* Arguments    : None
* Return Value : None
***********************************************************************************************************************/
#ifdef __IAR_C99__
int __low_level_init()
{
    DI();
    R_Systeminit();
    return 1;
}
#else
void hdwinit(void)
{
    DI();
    R_Systeminit();
}
#endif
/* Start user code for adding. Do not edit comment generated here */
/* End user code. Do not edit comment generated here */
