#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "R9A02G011PDC.h"
#include "led_ctrl.h"

LED_INFO gLed;

void led_init (void)
{
}

UCHAR led_ctrl (void)
{
	if (gLed.uReq.bits.bSrcEn == 1U) {
		P8_bit.no2 = 0U;
		pd_tm_stop_user_cnt(TM_ID_USER3);
	}
	else if (gLed.uReq.bits.bSnkEn == 1U) {
		P8_bit.no2 = 0U;
		gLed.ucTypeCBlinkCnt = 0U;
		pd_tm_start_user_cnt(TM_ID_USER3);
	}
	else if (gLed.uReq.bits.bDis == 1U) {
		P8_bit.no2 = 1U;
		pd_tm_stop_user_cnt(TM_ID_USER3);
	}
	gLed.uReq.ucData = 0U;
	
	if (pd_tm_chk_user_stat(TM_ID_USER3, 10U) == TM_ST_OVR) {
		gLed.ucTypeCBlinkCnt++;
		if (gLed.ucTypeCBlinkCnt >= 50) {
			P8_bit.no2 = ~P8_bit.no2;
			gLed.ucTypeCBlinkCnt = 0;
		}
		pd_tm_start_user_cnt(TM_ID_USER3);
	}
	
	if (pd_tm_chk_user_stat(TM_ID_USER3, 10U) != TM_ST_STOP) {
		return PD_CORE_LOW;
	}
	else {
		return PD_CORE_STOP;
	}
}
