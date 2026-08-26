#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "R9A02G011PDC.h"
#include "led_ctrl.h"
#include "dcdc_ctrl.h"
#include "user_main_battery.h"

LED_INFO gLed;

void led_init (void)
{
	gLed.uReq.bits.bBatteryLevel = 0U;
}

void led_ctrl (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	if (   (gLed.uReq.bits.bLedOn  == 1U)
	    || (gLed.uReq.bits.bLedOff == 1U)) {
		if (gLed.uReq.bits.bLedOff == 1U) {	
			//OFF
			P8_bit.no2 = 1U;
			gLed.uSt.bits.bTypeCBlink = 0U;
		}
		pd_tm_stop_user_cnt(TM_ID_USER3);
		gLed.uReq.bits.bLedOn  = 0U;
		gLed.uReq.bits.bLedOff = 0U;		
	}
	
	if (gLed.uReq.bits.bPrChg == 1U) {
		if(uStatus.bit.bPR == 1U) {
			//ON
			P8_bit.no2 = 0U;
			gLed.uSt.bits.bTypeCBlink = 0U;
			pd_tm_stop_user_cnt(TM_ID_USER3);
		} else {
			//BLINK
			P8_bit.no2 = 0U;
			gLed.uSt.bits.bTypeCBlink = 1U;
			gLed.ucTypeCBlinkCnt = 0;
			pd_tm_start_user_cnt(TM_ID_USER3);
		}
		gLed.uReq.bits.bPrChg = 0U;
	}
	
	if(uStatus.bit.bPR == 0U) { //ATT.SNK
		if (pd_tm_chk_user_stat(TM_ID_USER3, 10U) == TM_ST_OVR) {
			pd_tm_stop_user_cnt(TM_ID_USER3);
			if (gLed.uSt.bits.bTypeCBlink == 1U) {
				if (gBatInfo.uReq.bFullyCharge != 0U) {
					gLed.uSt.bits.bTypeCBlink = 0;
					P8_bit.no2 = 1;
					gLed.ucTypeCBlinkCnt = 0;
				} else {
					gLed.ucTypeCBlinkCnt++;
					if (gLed.ucTypeCBlinkCnt >= 50) {
						P8_bit.no2 = ~P8_bit.no2;
						gLed.ucTypeCBlinkCnt = 0;
					}
				}
				pd_tm_start_user_cnt(TM_ID_USER3);
			}
		}
	}
}
