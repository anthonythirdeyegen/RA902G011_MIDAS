#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "interrupt.h"
#include "user_timer.h"
#include "R9A02G011PDC.h"
#include "sw_ctrl.h"
#include "led_ctrl.h"
#include "user_main_battery.h"

void sw_func_intr_sw (void);

SW_INFO gSW;

void sw_init(void)
{
#if ROLE_SW_EN
	pdc_set_int_routine(intID_INTP2, (ULONG)&sw_func_intr_sw);
	gSW.status = SW_STATE_IDLE;
	gSW.ucPress = 0U;
#endif
}

void sw_ctrl(void)
{
#if ROLE_SW_EN
	if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
		switch(gSW.status ) {
			default:
				break;
		}
	}
#endif
}

UCHAR sw_chk_active(void)
{
#if ROLE_SW_EN
	return (gSW.status == SW_STATE_IDLE) ? gSW.ucPress :  1U;
#else
	return 0;
#endif
}

void sw_func_intr_sw (void)
{
#if ROLE_SW_EN
	PD_STATUS uStatus = pdc_get_status();

	if (P5_bit.no1 == 1U) {
		// pull
		if (tm1_is_start_gtimer() != 0U) {
			tm1_stop_gtimer();
		}
		if (chk_led_active() == 0U) {
			gLed.uReq.bits.bBatteryLevel = 1U;
		}
		gSW.ucPress = 0U;
	} 
	else if (gSW.ucPress == 0U) {
		// push
		user_func_chk_oneshot_battery();
		gSW.ucPress = 1U;
	}
#endif
}
