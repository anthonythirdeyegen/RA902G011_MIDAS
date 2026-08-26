#include "user_main.h"
#include "user_main_battery.h"
#include "interrupt.h"
#include "R9A02G011PDC.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "sw_ctrl.h"
#include "r_cg_userdefine.h"
#include "user_timer.h"
#include "pd_defs.h"
#include "led_ctrl.h"
#include "R9A02G011AMCU.h"
#include "relamcu.h"
#include "R9A02G011AUTH.h"
#include "user_main_authentication.h"

#define DATA_MESSAGE		0x01
#define EXTENDED_MESSAGE	0x02
#define GET_BATTERY_CAP		0x03
#define GET_BATTERY_STATUS	0x04

#define VAL_PB_BATTCAP	377
#define VAL_VID_BAT		0xF9D3
#define VAL_PID_BAT		0xF9D5

USHORT gusTemp;
UCHAR  gucVdmFlg;
UCHAR  gucWaiCmp;
UCHAR  gucOmfData;
UCHAR  gucAuthFlg;

void user_func_start_timer_thermistor(void);
void user_func_stop_timer_thermistor (void);
void user_func_intr_timer_thermistor (void);
void user_func_intr_sw (void);
void user_func_intr_timer_sw (void);

void intr_hdlr (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	if ( (P5_bit.no0 == 0U) 
	  && (uStatus.bit.bPlug == 0U) ) {
		pdc_exit_deep();
		tm_12tm_stop_gtimer();
		gLed.uReq.bits.bBatteryLevel = 1U;
		pdc_timer_active();
	}
}

void user_init(void)
{
	// NOTE: 
	// Don't change registers as following. They are initialised by pd_core_init().
	// Always
	//    PUX, PIMX, EGP0, EGN0, ADM0, PM4_bit.no0, PM2_bit.no0, PMC2_bit.no0
	// If ucAn9  = 1 at pd_core_init() -> PM2_bit.no1, PMC2_bit.no1
	// If ucAn10 = 1 at pd_core_init() -> PM2_bit.no2, PMC2_bit.no2
	
	// Output Port Setting
	P1_bit.no6 = 0U; PM1_bit.no6 = 0U; // VC_DRV1 :P16
	P1_bit.no7 = 0U; PM1_bit.no7 = 0U; // VC_DRV2 :P17
	P6_bit.no2 = 0U; PM6_bit.no2 = 0U; // GATE :P62
	P7_bit.no0 = 1U; PM7_bit.no0 = 0U; POM7_bit.no0 = 1U; // LED1 :P70
	P7_bit.no2 = 0U; PM7_bit.no2 = 0U; // DISCHG  :P72
	P7_bit.no1 = 1U; PM7_bit.no1 = 0U; POM7_bit.no1 = 1U; // LED2 :P71
	P7_bit.no3 = 1U; PM7_bit.no3 = 0U; POM7_bit.no3 = 1U; // LED3 :P73
	P8_bit.no0 = 0U; PM8_bit.no0 = 0U; // MON_EN :P80
	P8_bit.no1 = 1U; PM8_bit.no1 = 0U; POM8_bit.no1 = 1U; // LED4 :P81
	P8_bit.no2 = 1U; PM8_bit.no2 = 0U; POM8_bit.no2 = 1U; // LED_TypeC :P82

	{
		PER2 |= PER2_SMBM;
		POM3_bit.no0 = 1U; P3_bit.no0 = 1U; PM3_bit.no0= 0U; // MSTSCL
		POM3_bit.no1 = 1U; P3_bit.no1 = 1U; PM3_bit.no1= 0U; // MSTSDA
		POM3_bit.no2 = 1U; P3_bit.no2 = 1U; PM3_bit.no2= 0U; // RESET_OUT :P32(OpenDrain)
	}
	// Input Port Setting
	// NOTE:
	// If you use interrupt handler without SMBS, you shold call pdc_timer_active() in your interrupt handler.
	// If you use interrupt handler with SMBS, you shold call smbs_intr_hdlr() in your interrupt handler.
	P5_bit.no0 = 0U; PM5_bit.no0 = 1U; PMK1 = 0U; // WAKEUP :P50(INTR1)
	pdc_set_int_routine(intID_INTP1, (ULONG)&intr_hdlr);
	// sw
	P5_bit.no1 = 0U; PM5_bit.no1 = 1U; PMK2 = 0U; // SW :P51(INTR2)
	EGP0 |= 0x04;
	EGN0 |= 0x04;
	
	gusTemp   = 0U;
	gucVdmFlg = 0U;
	gucWaiCmp = 0U;
	gucOmfData = 0U;
	gucAuthFlg = 0U;
	
	init_tau0_channel1();
	init_tau0_channel2();
	init_tau0_channel3();
	init_tm_12bit();
	
	dcdc_init();
	subdev_init();
	smbm_init();
#if (AUTH_TYP == AUTH_SNK_INITIATOR_DIS)
	auth_init((ULONG)&relamcu_reset_err, AUTH_SPRT_RESP_SRC);
#else
	auth_init((ULONG)&relamcu_reset_err, AUTH_SPRT_INIT|AUTH_SPRT_RESP_SRC);
#endif
	sw_init();
	led_init();
	
	gBatInfo.uSt.bSt = BATTERY_INIT;
}

void user_func_event (void)
{
	PD_STATUS uStatus = pdc_get_status();
	
	if (gPdc.uPdEvent.bit.bPlugChg != 0U) {
		if (uStatus.bit.bPlug != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
			P7_bit.no2 = 0U; // DISCHG:OFF
			user_func_start_timer_thermistor();
			gLed.uReq.bits.bPrChg = 1U;
			gLed.uReq.bits.bLedOn = 1U;
			gPdc.uPdEvent.bit.bPlugChg = 0U;
			gucWaiCmp = 0U;
		}
		else {
			if (gucWaiCmp == 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
				pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
				gucVdmFlg = 0U;
				gucAuthFlg = 0U;
#if (AUTH_TYP == AUTH_SNK_INITIATOR_DIS)
				pdc_set_snk_conf(63000U, 2, 0);
#else
				pdc_set_snk_conf(15000U, 1, 0);
#endif
				gLed.uReq.bits.bLedOff = 1U;
				if (gPdc.uPdReq.bit.bSrcOff == 0U) {
					pd_tm_start_user_cnt(TM_ID_USER2);
					P7_bit.no2 = 1U; // DISCHG:ON
					gucWaiCmp = 1U;
				}
				else {
					gPdc.uPdEvent.bit.bPlugChg = 0U;
				}
			}
			else {
				SHORT sVbus = pdc_get_an_volt(AN_CH_VBUS);
				if (sVbus >= 0) {
					if (   (sVbus < 800)
					    || (pd_tm_chk_user_stat(TM_ID_USER2, 650U) == TM_ST_OVR)) {
						pd_tm_stop_user_cnt(TM_ID_USER2);
						gucWaiCmp = 0U;
						P7_bit.no2 = 0U; // DISCHG:OFF
						gPdc.uPdEvent.bit.bPlugChg = 0U;
					}
				}
			}
		}
	}
	else if (gPdc.uPdEvent.bit.bPrChg != 0U) {
		gLed.uReq.bits.bPrChg = 1U;
		gPdc.uPdEvent.bit.bPrChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bDrChg != 0U) {
		gPdc.uPdEvent.bit.bDrChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewContract != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
		if ((uStatus.bit.bPR   != 0U) && (pdc_is_pps_mode() !=0U)) {
			pd_tm_start_user_cnt(TM_ID_USER2);
		}
#endif
		if (uStatus.bit.bPR != 0U) {
			gDCInfo.uReq.bit.bNewContract = 1U;
		}
		gPdc.uPdEvent.bit.bNewContract = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewSrcCap != 0U) {
		//Sink intrusive mode
		gPdc.uPdEvent.bit.bNewSrcCap = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewRequest != 0U) {
		gPdc.uPdEvent.bit.bNewRequest = 0U;
	}
	else if (gPdc.uPdEvent.bit.bChkRcvPDM != 0U) {
		if (gRcvMess.uInfo.bit.bClass == EXTENDED_MESSAGE) {
			switch(gRcvMess.uInfo.bit.bType) {
			case GET_BATTERY_CAP:
				gSndMess.uspData[0] = VAL_VID_BAT;
				gSndMess.uspData[1] = VAL_PID_BAT;
				if ((gRcvMess.uspData[0] & 0x00FF) == 0x0000) {
					gSndMess.uspData[2] = VAL_PB_BATTCAP;
					gSndMess.uspData[3] = 0xFFFF;
					gSndMess.uspData[4] = 0x0000;
				} else {
					gSndMess.uspData[2] = 0x0000;
					gSndMess.uspData[3] = 0x0000;
					gSndMess.uspData[4] = 0x0001;
				}
				gSndMess.uInfo.bit.bLen = 9U;
				pdc_set_cmd(PDC_CMD_SND_BAT_CAP, PDC_TARGET_SOP);
				break;
			case GET_BATTERY_STATUS:
				gSndMess.uspData[1] = 0xFFFF;
				if ((gRcvMess.uspData[0] & 0x00FF) == 0x0000) {
					if (uStatus.bit.bPR == 1U) {
						gSndMess.uspData[0] = 0x0400 + 0x0200;	// Battery is Charging and Battery is present
					} else {
						if (gBatInfo.uReq.bFullyCharge != 0U) {
							// Battery is Idle and Battery is present
							gSndMess.uspData[0] = 0x0800 + 0x0200;
						} else {
							// Battery is Discharging and Battery is present
							gSndMess.uspData[0] = 0x0000 + 0x0200;
						}
					}
				} else {
					gSndMess.uspData[0] = 0x0100;	// Invalid Battery reference
				}
				gSndMess.uInfo.bit.bLen = 3U;
				pdc_set_cmd(PDC_CMD_SND_BAT_STAT, 0);
				break;
			default:
				break;
			}
		}
		else if (gRcvMess.uInfo.bit.bClass == DATA_MESSAGE) {
			if (gRcvMess.uInfo.bit.bType == 0x0FU) { // VDM
				if (   (uStatus.bit.bComRevPDC == 1U)  // PD3
				    && ((gRcvMess.uspData[0] & 0x8000U) == 0U)) { // UVDM
					pdc_set_cmd(PDC_CMD_SND_NOT_SUPPORTED, 0);
				}
			}
		}
		gPdc.uPdEvent.bit.bChkRcvPDM = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNonPDCon != 0U) {
		if (uStatus.bit.bPR != 0U) { // ATT.SRC
			gPdc.uPdEvent.bit.bNonPDCon = 0U;
		}
		else {
			if(gDCInfo.uReq.usData == 0U){
				gDCInfo.uReq.bit.bSnkChg = 1U;
				gPdc.uPdEvent.bit.bNonPDCon = 0U;
			}
		}
		user_func_chk_oneshot_battery();
	}
	else if (gPdc.uPdEvent.bit.bVrdChg != 0U) {
		gPdc.uPdEvent.bit.bVrdChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bHardReset != 0U) {
		gPdc.uPdEvent.bit.bHardReset = 0U;
	}
	else if (gPdc.uPdEvent.bit.bSoftReset != 0U) {
		gPdc.uPdEvent.bit.bSoftReset = 0U;
	}
	else if (gPdc.uPdEvent.bit.bErr != 0U) {
		gPdc.uPdEvent.bit.bErr = 0U;
	}
	
	if (gPdc.uPdReq.bit.bVconnDis != 0U) {
		P1_bit.no6 = 0U; // VC_DRV1:OFF
		P1_bit.no7 = 0U; // VC_DRV2:OFF
		gPdc.uPdReq.bit.bVconnDis = 0U;
	}
	else if (gPdc.uPdReq.bit.bVconnEn != 0U) {
		if (uStatus.bit.bCc != 0U) { // CC2
			P1_bit.no6 = 1U; // VC_DRV1:ON
		}
		else { // CC1
			P1_bit.no7 = 1U; // VC_DRV2:ON
		}
		gPdc.uPdReq.bit.bVconnEn = 0U;
	}
	else if (gPdc.uPdReq.bit.bSrcOff != 0U) {
		if (gucWaiCmp == 0U) {
			PD_STATUS uStatus = pdc_get_status();
			gDCInfo.uReq.bit.bSrcOff = 1U;
			gucWaiCmp = 1U;
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pd_tm_stop_user_cnt(TM_ID_USER2);
#endif
			// Connect status is Unplug
			if ( (uStatus.bit.bPlug == 0U) && (gSW.status == SW_STATE_IDLE) 
			  && (gBatInfo.uSt.bSt != BATTERY_EMPTY) ) {
				gBatInfo.uSt.bSt = BATTERY_EXIT_EMPTY_MODE;
				gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_S1;
			}
		}
		else {
			if(gDCInfo.uNtfy.bit.bUnexpected == 1U){
				gDCInfo.uNtfy.bit.bUnexpected = 0U;
				P7_bit.no2 = 0U; // DISCHG:OFF
				gPdc.uPdReq.bit.bSrcOff    = 0U;
				gucWaiCmp = 0U;
			}
			else{
				SHORT sVbus = pdc_get_an_volt(AN_CH_VBUS);
				if (sVbus >= 0) {
					if (sVbus <= 800) {
						P7_bit.no2 = 0U; // DISCHG:OFF
						gPdc.uPdReq.bit.bSrcOff    = 0U;
						gucWaiCmp = 0U;
					}
					else if (sVbus <= 5500) {
						P7_bit.no2 = 1U; // DISCHG:ON
						P6_bit.no2 = 0U; // GATE:OFF
					}
				}
			} 
		}
	}
	else if (gPdc.uPdReq.bit.bSnkOff != 0U) {
		if (uStatus.bit.bPlug == 0U) {// Unplug
			gDCInfo.uReq.bit.bSnkOff = 1U;
			gBatInfo.uReq.bSinkOff = 1U;
			P6_bit.no2 = 0U; // GATE:OFF
			
			if (gBatInfo.uReq.bSinkOff != 0U) {
				gBatInfo.uSt.bSt = BATTERY_EXIT_EMPTY_MODE;
				gBatInfo.uSt.bSubSt = BATTERY_EEM_SUB_S1;
				gBatInfo.uReq.bSinkOff = 0U;
				user_func_stop_oneshot_battery();
			}	
		}
		else {
			if (pdc_get_req_volt() == 0U) {
				P6_bit.no2 = 0U; // GATE:OFF
			}
			gDCInfo.uReq.bit.bSnkOff = 1U;
		}
		gPdc.uPdReq.bit.bSnkOff = 0U;
	}
	else if (gPdc.uPdReq.bit.bSrcOn != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSrcOn = 1U;
			gPdc.uPdReq.bit.bSrcOn = 0U;
			P6_bit.no2 = 1U; // GATE:ON
		}
	}
	else if (gPdc.uPdReq.bit.bSrcChg != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
		pd_tm_stop_user_cnt(TM_ID_USER2);
#endif
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSrcChg = 1U;
			gPdc.uPdReq.bit.bSrcChg = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bSnkOn != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSnkOn = 1U;
			gPdc.uPdReq.bit.bSnkOn = 0U;
		}
		P6_bit.no2 = 1U; // GATE:ON
	}
	else if (gPdc.uPdReq.bit.bSnkChg != 0U) {
		SHORT sVbusTmp = pdc_get_an_volt(AN_CH_VBUS);
		if (sVbusTmp >= 4000) {
			if(gDCInfo.uReq.usData == 0U){
				gDCInfo.uReq.bit.bSnkChg = 1U;
				gPdc.uPdReq.bit.bSnkChg = 0U;
				user_func_chk_oneshot_battery();
			}
		}
		else if (sVbusTmp == -1) {
			//Wait
		}
		else {
			gPdc.uPdReq.bit.bSnkChg = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bGotoMin != 0U) {
		gPdc.uPdReq.bit.bGotoMin = 0U;
	}
	else if(gDCInfo.uNtfy.bit.bUnexpected == 1U){
		// disconnet
		pdc_set_cmd(PDC_CMD_ENTR_ERR_RCVR, 0);
		gDCInfo.uNtfy.bit.bUnexpected = 0U;
	}
	else if( (gDCInfo.uNtfy.usData & DCDC_NOTIFY_MASK) != 0U){
		gDCInfo.uNtfy.usData &= ~DCDC_NOTIFY_MASK;
	}
	else if (gAmcu.bit.bResetEn != 0) {
		P3_bit.no2 = 0;
		gAmcu.bit.bResetEn = 0U;
	}
	else if (gAmcu.bit.bResetDis != 0U) {
		P3_bit.no2 = 1;
		gAmcu.bit.bResetDis = 0U;
	}
	else if (   (gAmcu.bit.bReqTx != 0U)
	         && (gSubdevInfo.ucSubdevFlag & RELAMCU_DEVICE_ID) == 0U) {
		//Clear bReqTx at relamcu.c
		gSubdevInfo.ucSubdevFlag |= RELAMCU_DEVICE_ID;
	}
	else if (gAmcu.bit.bReqRst != 0U) {
		gSubdevInfo.ucSubdevHRFlag |= RELAMCU_DEVICE_ID;
		gAmcu.bit.bReqRst = 0U;
	}
}
