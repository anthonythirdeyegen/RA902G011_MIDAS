#include "user_main_battery.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "interrupt.h"
#include "user_timer.h"
#include "dcdc_ctrl.h"
#include "R9A02G011PDC.h"
#include "R9A02G011SMBS.h"
#include "led_ctrl.h"
#include "user_main.h"
#include "mppm_pb_defs.h"

#define WAIT_TIME1		50
#define WAIT_TIME2		20
#define WAIT_TIME3		20
#define WAIT_TIME4		20

#define VAL_BMON_RAP	500

#define VAL_BATTVOLTH0	(2430U)
#define VAL_BATTVOLTH1	(2500U)
#define VAL_BATTVOLTH2	(2600U)
#define VAL_BATTVOLTH3	(2700U)
#define VAL_BATTFULLCHGTH	(2760U)

static void user_func_intr_timer_battery (void);
static void user_func_start_timer_battery (USHORT usPeriod);
static void user_func_stop_timer_battery (void);
void user_func_req_update_an(UCHAR nextStatus);
void user_func_get_an_volt(UCHAR nextStatus, USHORT waitTime);

BATTERY_INFO gBatInfo;

void battery_init(void) {
	gBatInfo.uSt2.bTrickle = 1U;
	gBatInfo.uSt2.bOutLowBatMode = 0U;
	gBatInfo.uSt.bSt = BATTERY_INIT;

}

UCHAR user_func_chk_battery (void)
{
	UCHAR ret = PD_CORE_ACTIVE;
	PD_STATUS uStatus   = pdc_get_status();
	
	switch (gBatInfo.uSt.bSt) {
		case BATTERY_INIT:
			gBatInfo.uSt.bSt = BATTERY_INIT_IDLE;
			gBatInfo.uIntr.bIntrSt  = BATTERY_INTR_IDLE;
			gBatInfo.uReq.bFixedRole = 0U;
			user_func_chk_oneshot_battery();
			gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_INVALID;
			gBatInfo.uSt2.bBatteryLevelBak = BAT_LEVEL_INVALID;
			break;
		case BATTERY_INIT_IDLE:
			if (gBatInfo.uIntr.bIntrSt == BATTERY_INTR_IDLE) {
				gBatInfo.uSt.bSt = BATTERY_IDLE;
				if (gBatInfo.uSt2.bBatteryLevel == BAT_LEVEL_EMP){
					user_func_stop_oneshot_battery();
					gBatInfo.uSt.bSt = BATTERY_EMPTY;
					if(uStatus.bit.bPlug == 0U){
						gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_S2;
					}
					else {
						if (uStatus.bit.bPR != 0U){//ATT.SRC
							gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_S1;
						}
						else {
							gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_S2;
						}
					}
					ret = PD_CORE_ACTIVE;
				}
			}
			break;
		case BATTERY_IDLE:
			if (uStatus.bit.bPlug == 1U) {
				gBatInfo.uSt.bSt = BATTERY_POLLING;
				user_func_start_timer_battery(VAL_BMON_RAP);
				user_func_chk_oneshot_battery();
			}
			break;
		case BATTERY_EMPTY:
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
				switch (gBatInfo.uSt.bSubSt) {
					case BATTERY_EMP_SUB_S1:
						pdc_set_cmd(PDC_CMD_ENA_LOW_BAT_MODE, 0);
						gLed.uReq.bits.bLedOff = 1U;						
						user_func_chk_oneshot_battery();
						gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_S2;
						break;
					case BATTERY_EMP_SUB_S2:
						if (gBatInfo.uIntr.bIntrSt == BATTERY_INTR_IDLE) {
							if ((uStatus.bit.bPlug == 0U)
								|| ((gBatInfo.uSt2.bBatteryLevel > BAT_LEVEL_LOW)
								   && (gMpPb.othPortInfo.bit.bPlugState != 0U) 
								   && (gMpPb.othPortInfo.bit.bPowerRole == 0U))) {
								if (gBatInfo.uSt2.bBatteryLevel == BAT_LEVEL_EMP) {
									pdc_set_port_conf(PDC_ROLE_SNK_DRD, PDC_ACS_VCONN);
									gBatInfo.uReq.bFixedRole = 1U;
									user_func_stop_oneshot_battery();
								}
								if(uStatus.bit.bPlug == 1U){
									gLed.uReq.bits.bLedOn = 1U;
								}					
								pdc_set_cmd(PDC_CMD_ENA_TYPEC_CTRL, 0);
								gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_IDLE;
							}
							else {
								user_func_chk_oneshot_battery();
							}
						}
						break;
					default: //EMP_SUB_IDLE
						gBatInfo.uSt.bSt = BATTERY_IDLE;
						break;
				}
			}
			break;
		case BATTERY_EXIT_EMPTY_MODE:
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
				switch (gBatInfo.uSt.bSubSt) {
					case BATTERY_EEM_SUB_S1:
						if (   (gBatInfo.uReq.bFixedRole != 0U)
							&& (gBatInfo.uSt2.bBatteryLevel  != BAT_LEVEL_EMP)) {
							pdc_set_cmd(PDC_CMD_DIS_TYPEC_CTRL, 0);
							gBatInfo.uReq.bFixedRole = 0U;
							gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_S2;
						}
						else {
							gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_S3;
						}
						break;
					case BATTERY_EEM_SUB_S2:
						pdc_set_port_conf(PDC_ROLE_DRP_DRD_TSRC, PDC_ACS_VCONN);
						pdc_set_cmd(PDC_CMD_ENA_TYPEC_CTRL, 0);
						gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_S3;
						break;
					case BATTERY_EEM_SUB_S3:
						gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_IDLE;
						break;
					default: //EEM_SUB_IDLE
						gBatInfo.uSt.bSt = BATTERY_IDLE;
						break;
				}
			}
			break;
		default://POLLING
			if (gBatInfo.uSt2.bOutLowBatMode != 0U) {
				gBatInfo.uSt2.bOutLowBatMode = 0U;
				smbs_set_usr_status(USER_STATE_RESET_PR);
				smbs_set_usr_alrt();
			}
			if (uStatus.bit.bPlug != 1U) {
				gBatInfo.uSt.bSt = BATTERY_IDLE;
			}
			break;
	}
		
	if (   (gBatInfo.uSt.bSt == BATTERY_IDLE)
		|| (gBatInfo.uSt.bSt == BATTERY_POLLING)) {
		ret = PD_CORE_IDLE;
	}

	if (gBatInfo.uSt2.bBatteryLevel == BAT_LEVEL_EMP && 
		(uStatus.bit.bPR == 1U) &&
		gBatInfo.uSt.bSt == BATTERY_POLLING) {
		user_func_stop_oneshot_battery();
		gBatInfo.uSt.bSt = BATTERY_EMPTY;
		gBatInfo.uSt.bSubSt = BATTERY_EMP_SUB_S1;
		ret = PD_CORE_ACTIVE;
	}
	
	return ret;
}

void user_func_chk_oneshot_battery (void)
{
	if (gBatInfo.uIntr.bIntrSt == BATTERY_INTR_IDLE) {
		P8_bit.no0 = 1U;
		gBatInfo.uIntr.bIntrSt  = BATTERY_INTR_S1;
		gBatInfo.uIntr.bOneShot = 1U;
		user_func_start_timer_battery(WAIT_TIME1);
	}
}

void user_func_stop_oneshot_battery (void)
{
	P8_bit.no0 = 0U;
	user_func_stop_timer_battery();	
	gBatInfo.uIntr.bOneShot = 0U;
	gBatInfo.uIntr.bIntrSt  = BATTERY_INTR_IDLE;
}

USHORT user_func_get_battery_level (void)
{
	return gBatInfo.uSt2.bBatteryLevel;
}

void user_func_start_timer_battery (USHORT usPeriod)
{
	tm2_start_gtimer(usPeriod, (ULONG)&user_func_intr_timer_battery);
}

void user_func_stop_timer_battery (void)
{
	tm2_stop_gtimer();
}

void user_func_intr_timer_battery (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	SHORT battTemp;
	ULONG tmpVolt;
	user_func_stop_timer_battery();
	
	switch (gBatInfo.uIntr.bIntrSt) {
		case BATTERY_INTR_S0:
			P8_bit.no0 = 1;
			gBatInfo.uIntr.bIntrSt = BATTERY_INTR_S1;
			user_func_start_timer_battery(WAIT_TIME1);
			if ( (gDCInfo.uReq.bit.bPoll == 0U) && (pdc_is_pps_mode() == 0U) ){
				gDCInfo.uReq.bit.bPoll = 1U;
			}
			break;
		case BATTERY_INTR_S1:
			user_func_req_update_an(BATTERY_INTR_S2);
			gBatInfo.ulBatteryAd = 0;
			break;
		case BATTERY_INTR_S2:
			user_func_get_an_volt(BATTERY_INTR_S3, WAIT_TIME2);
			break;
		case BATTERY_INTR_S3:
			user_func_req_update_an(BATTERY_INTR_S4);
			break;
		case BATTERY_INTR_S4:
			user_func_get_an_volt(BATTERY_INTR_S5, WAIT_TIME3);
			break;
		case BATTERY_INTR_S5:
			user_func_req_update_an(BATTERY_INTR_S6);
			break;
		case BATTERY_INTR_S6:
			user_func_get_an_volt(BATTERY_INTR_S7, WAIT_TIME4);
			break;
		case BATTERY_INTR_S7:
			user_func_req_update_an(BATTERY_INTR_S8);
			break;
		case BATTERY_INTR_S8:
			battTemp = pdc_get_an_volt(AN_CH10);
			if (battTemp >= 0) { 
				P8_bit.no0 = 0;
				gBatInfo.ulBatteryAd += battTemp;
				tmpVolt =  gBatInfo.ulBatteryAd / 4;
				if (VAL_BATTFULLCHGTH <= tmpVolt) {
					gBatInfo.uReq.bFullyCharge = 1U;
				} else {
					gBatInfo.uReq.bFullyCharge = 0U;
				}
				if (VAL_BATTVOLTH3 < tmpVolt) {
					gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_FULL;
				}
				else if (VAL_BATTVOLTH2 < tmpVolt) {
					gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_HIGH;
				}
				else if (VAL_BATTVOLTH1 < tmpVolt) {
					gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_MID;
				}
				else if (VAL_BATTVOLTH0 < tmpVolt) {
					gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_LOW;
				} 
				else {
					gBatInfo.uSt2.bBatteryLevel = BAT_LEVEL_EMP;
					gBatInfo.uSt2.bBatteryLevelBak = BAT_LEVEL_EMP;
				}
				if ((gBatInfo.uSt2.bBatteryLevel > BAT_LEVEL_LOW) && (gBatInfo.uSt2.bBatteryLevelBak == BAT_LEVEL_EMP)) {
					gBatInfo.uSt2.bOutLowBatMode = 1U;
					gBatInfo.uSt2.bBatteryLevelBak = gBatInfo.uSt2.bBatteryLevel;
				}
				if (gBatInfo.uSt.bSt == BATTERY_POLLING) {
					user_func_start_timer_battery(VAL_BMON_RAP);
					gBatInfo.uIntr.bIntrSt  = BATTERY_INTR_S0;
				} else {
					gBatInfo.uIntr.bIntrSt = BATTERY_INTR_IDLE;
				}
				gBatInfo.uIntr.bOneShot = 0U;
			} else {
				user_func_start_timer_battery(1);
			}
			break;
		default: //BATTERY_INTR_IDLE
			break;
	}
	pdc_timer_active();
	
}

void user_func_req_update_an(UCHAR nextStatus)
{
	if(pdc_req_update_an(AN_CH10) == 0) {
		gBatInfo.uIntr.bIntrSt = nextStatus;
	}
	user_func_start_timer_battery(1);
}

void user_func_get_an_volt(UCHAR nextStatus, USHORT waitTime)
{
	SHORT battTemp;
	battTemp = pdc_get_an_volt(AN_CH10);
	if (battTemp >= 0) { 
		gBatInfo.ulBatteryAd += battTemp;
		user_func_start_timer_battery(waitTime);
		gBatInfo.uIntr.bIntrSt = nextStatus;
	} else {
		user_func_start_timer_battery(1);
	}
}
