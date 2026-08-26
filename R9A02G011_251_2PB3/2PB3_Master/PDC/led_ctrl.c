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
#include "sw_ctrl.h"

LED_INFO gLed;
void set_battery_level(UCHAR ucBatteryLevel);
void set_led_level(UCHAR level);

void led_init (void)
{
	gLed.uSt.bits.bSysAttRole = SYS_PR_UNPLUG;
#if ROLE_SW_EN
	gLed.uReq.bits.bBatteryLevel = 1U;
#else
	gLed.uReq.bits.bBatteryLevel = 0U;
#endif
}

void led_ctrl (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	if (   (gLed.uReq.bits.bLedOn  == 1U)
	    || (gLed.uReq.bits.bLedOff == 1U)) {
#if ROLE_SW_EN
		if (gLed.uReq.bits.bLedOff == 1U) {
			//OFF
			P8_bit.no2 = 1U;
			gLed.uSt.bits.bTypeCBlink = 0U;
		}
#else
		if (gLed.uReq.bits.bLedOff == 1U) {
			//OFF
			P8_bit.no2 = 1U;
			gLed.uSt.bits.bTypeCBlink = 0U;
			set_led_level(0);
			gLed.uReq.bits.bBatteryLevel = 0U;
		}
		else if(gLed.uReq.bits.bLedOn == 1U){
			gLed.uReq.bits.bBatteryLevel = 1U;
		}
#endif
		gLed.uReq.bits.bLedOn  = 0U;
		gLed.uReq.bits.bLedOff = 0U;
		if (gLed.uSt.bits.bBattlvel == 0U) {
			pd_tm_stop_user_cnt(TM_ID_USER3);
		}
	}
	
	if (gLed.uReq.bits.bPrChg == 1U) {
		if(uStatus.bit.bPR == 1U) {
			//ON
			P8_bit.no2 = 0U;
			gLed.uSt.bits.bTypeCBlink = 0U;
			if (gLed.uSt.bits.bBattlvel == 0U) {
				pd_tm_stop_user_cnt(TM_ID_USER3);
			}
		} else {
			//BLINK
			P8_bit.no2 = 0U;
			gLed.uSt.bits.bTypeCBlink = 1U;
			gLed.ucTypeCBlinkCnt = 0;
			if (gLed.uSt.bits.bBattlvel == 0U) {
				pd_tm_start_user_cnt(TM_ID_USER3);
			}
		}
		gLed.uReq.bits.bPrChg = 0U;
	}
	if (   (gLed.uReq.bits.bBatteryLevel == 1U)
		&& (gBatInfo.uIntr.bOneShot == 0U) ) {
		set_battery_level(gBatInfo.uSt2.bBatteryLevel);
		if(gBatInfo.uSt2.bBatteryLevel != BAT_LEVEL_INVALID) {
#if ROLE_SW_EN
			gLed.uReq.bits.bBatteryLevel = 0U;
			gLed.uSt.bits.bBattlvel = 1U;
#else
			gLed.uSt.bits.bBattlvel = 0U;
#endif
			gLed.ucBattLvlCnt = 0;
			if (gLed.uSt.bits.bTypeCBlink == 0U) {
				pd_tm_start_user_cnt(TM_ID_USER3);
			}
		}
	}

	
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
		}
		if (gLed.uSt.bits.bBattlvel == 1U) {
			set_battery_level(gBatInfo.uSt2.bBatteryLevel);
			gLed.ucBattLvlCnt++;
			if (gLed.ucBattLvlCnt >= 200) {
				set_led_level(0);
				gLed.uSt.bits.bBattlvel = 0U;
				gLed.ucBattLvlCnt = 0;
			}
		}
		if (gLed.uSt.bits.bTypeCBlink == 1U ||
			gLed.uSt.bits.bBattlvel == 1U) {
			pd_tm_start_user_cnt(TM_ID_USER3);
		}
	}
}

void set_battery_level(UCHAR ucBatteryLevel)
{
	PD_STATUS uStatus   = pdc_get_status();
	switch (ucBatteryLevel) {
		case BAT_LEVEL_EMP:
			set_led_level(0);
			break;
		case BAT_LEVEL_LOW:
			if (gLed.uSt.bits.bSysAttRole == SYS_PR_UNPLUG ||
				gLed.uSt.bits.bSysAttRole == SYS_PR_ATT_SRC) {
				set_led_level(1);
			} else {
				set_led_level(0);
			}
			break;
		case BAT_LEVEL_MID:
			P7_bit.no0 = 0U;
			if (gLed.uSt.bits.bSysAttRole == SYS_PR_UNPLUG ||
				gLed.uSt.bits.bSysAttRole == SYS_PR_ATT_SRC) {
				set_led_level(2);
			} else {
				set_led_level(1);
			}
			break;
		case BAT_LEVEL_HIGH:
			if ((gLed.uSt.bits.bSysAttRole == SYS_PR_UNPLUG )||
				(gLed.uSt.bits.bSysAttRole == SYS_PR_ATT_SRC)) {
				set_led_level(3);
			} else {
				set_led_level(2);
			}
			break;
		case BAT_LEVEL_FULL:
			if ((gBatInfo.uReq.bFullyCharge != 0U) ||
				(gLed.uSt.bits.bSysAttRole == SYS_PR_UNPLUG) ||
				(gLed.uSt.bits.bSysAttRole == SYS_PR_ATT_SRC)) {
				set_led_level(4);
			} else {
				set_led_level(3);
			}
			break;
	}

}

void set_led_level(UCHAR level)
{
	switch (level) {
		case 0:
			P7_bit.no0 = 1U;
			P7_bit.no1 = 1U;
			P7_bit.no3 = 1U;
			P8_bit.no1 = 1U;
			break;
		case 1:
			P7_bit.no0 = 0U;
			P7_bit.no1 = 1U;
			P7_bit.no3 = 1U;
			P8_bit.no1 = 1U;
			break;
		case 2:
			P7_bit.no0 = 0U;
			P7_bit.no1 = 0U;
			P7_bit.no3 = 1U;
			P8_bit.no1 = 1U;
			break;
		case 3:
			P7_bit.no0 = 0U;
			P7_bit.no1 = 0U;
			P7_bit.no3 = 0U;
			P8_bit.no1 = 1U;
			break;
		case 4:
			P7_bit.no0 = 0U;
			P7_bit.no1 = 0U;
			P7_bit.no3 = 0U;
			P8_bit.no1 = 0U;
			break;
	}
}

UCHAR chk_led_active (void)
{
	if ( (gLed.uReq.bits.bBatteryLevel != 0U)
	  || (gLed.uSt.bits.bBattlvel != 0U) ) {
		return 1U;
	}
	return 0U;
}