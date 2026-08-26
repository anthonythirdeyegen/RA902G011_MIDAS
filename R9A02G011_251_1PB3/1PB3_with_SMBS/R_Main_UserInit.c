#include "R_Main_UserInit.h"

USHORT gusRcvMess[14U];
USHORT gusSndMess[14U];

/***********************************************************************************************************************
* Function Name: R_MAIN_UserInit
* Description  : This function adds user code before implementing main function.
* Arguments    : None
* Return Value : None
***********************************************************************************************************************/
void R_MAIN_UserInit(void)
{
    /* Start user code. Do not edit comment generated here */
	
	// set post and source power and sink power before pd_core_init()
	pdc_set_port_conf(PDC_ROLE_DRP_DRD_TSRC, PDC_ACS_VCONN);
	pdc_set_src_conf(45000U, 4, 0, PDC_NOPD_CUR_3_0A);
	pdc_set_snk_conf(63000U, 2, 0);
	pdc_set_sys_conf(PDC_SYS_DR_SWAP_PASSIVE, PDC_SYS_PR_SWAP_ACTIVE_SRC, (PDC_SYS_UNCNST_PWR | PDC_SYS_EXT_PWR_DC | PDC_SYS_INTR_PWR_BAT), 0U);
	pdc_set_dev_stat(0, 0, 0, PDC_TEMP_STAT_NS, 0);
	pdc_set_pwr_stat(0x00U);
	gRcvMess.uspData = gusRcvMess;
	gSndMess.uspData = gusSndMess;
	pd_core_init(1, 1);
	user_init();
	
	EI();
   /* End user code. Do not edit comment generated here */
}


void user_func_set_snk_intrusive_dis (void)
{
	pdc_set_snk_conf(63000U, 2, 0);
}

void user_func_set_snk_intrusive_en (void)
{
	pdc_set_snk_conf(63000U, 2, 1);
}
