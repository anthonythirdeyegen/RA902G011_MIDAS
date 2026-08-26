#include "user_main.h"
#include "interrupt.h"
#include "R9A02G011PDC.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "r_cg_userdefine.h"
#include "user_timer.h"
#include "led_ctrl.h"
#include "sw_ctrl.h"

#define DATA_MESSAGE		0x01

USHORT gusTemp;
UCHAR  gucVdmFlg;
UCHAR  gucWaiCmp;
UCHAR  gucOmfData;
UCHAR  gucReserved;

void user_func_start_timer_thermistor(void);
void user_func_stop_timer_thermistor (void);
void user_func_intr_timer_thermistor (void);

void user_init(void)
{
	// NOTE: 
	// Don't change registers as following. They are initialised by pd_core_init().
	// Always
	//    PUX, PIMX, EGP0, EGN0, ADM0, PM4_bit.no0, PM2_bit.no0, PMC2_bit.no0
	// If ucAn9  = 1 at pd_core_init() -> PM2_bit.no1, PMC2_bit.no1
	// If ucAn10 = 1 at pd_core_init() -> PM2_bit.no2, PMC2_bit.no2
	
	// Output Port Setting
	                   P1_bit.no6 = 0U; PM1_bit.no6 = 0U; // VC_DRV1   :P16
	                   P1_bit.no7 = 0U; PM1_bit.no7 = 0U; // VC_DRV2   :P17
	POM5_bit.no0 = 1U; P5_bit.no0 = 1U; PM5_bit.no0 = 0U; // DM        :P50(OpenDrain)
	POM5_bit.no1 = 1U; P5_bit.no1 = 1U; PM5_bit.no1 = 0U; // DP        :P51(OpenDrain)
	                   P7_bit.no1 = 0U; PM7_bit.no1 = 0U; // DISCHG    :P71
	                   P7_bit.no3 = 0U; PM7_bit.no3 = 0U; // DR_GATE   :P73
	POM8_bit.no0 = 1U; P8_bit.no0 = 1U; PM8_bit.no0 = 0U; // PUE       :P80(OpenDrain)
	POM8_bit.no2 = 1U; P8_bit.no2 = 1U; PM8_bit.no2 = 0U; // LED       :P82(OpenDrain)
	{
		PER2 |= PER2_SMBM;
		POM3_bit.no0 = 1U; P3_bit.no0 = 1U; PM3_bit.no0= 0U; // MSTSCL
		POM3_bit.no1 = 1U; P3_bit.no1 = 1U; PM3_bit.no1= 0U; // MSTSDA
		POM3_bit.no2 = 1U; P3_bit.no2 = 1U; PM3_bit.no2= 0U; // RESET_OUT :P32(OpenDrain)
	}
	// Input Port Setting
	// NOTE:
	// set P81(INTR6) at sw_init()
	
	gusTemp   = 0U;
	gucVdmFlg = 0U;
	gucWaiCmp = 0U;
	gucOmfData = 0U;
	
	init_tau0_channel3();
	init_tm_12bit();
	
	dcdc_init();
	subdev_init();
	smbm_init();
	led_init();
	sw_init();
}

void user_func_event (void)
{
	PD_STATUS uStatus = pdc_get_status();
	
	if (gPdc.uPdEvent.bit.bPlugChg != 0U) {
		if (uStatus.bit.bPlug != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
			P7_bit.no1 = 0U; // DISCHG:OFF
			user_func_start_timer_thermistor();
			if (uStatus.bit.bPR != 0U) { // ATT.SRC
				gLed.uReq.bits.bSrcEn = 1U;
			}
			else {
				gLed.uReq.bits.bSnkEn = 1U;
			}
			gPdc.uPdEvent.bit.bPlugChg = 0U;
			gucWaiCmp = 0U;
		}
		else {
			if (gucWaiCmp == 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
				pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
				gucVdmFlg = 0U;
				gLed.uReq.bits.bDis = 1U;
				if (gPdc.uPdReq.bit.bSrcOff == 0U) {
					pd_tm_start_user_cnt(TM_ID_USER2);
					P7_bit.no1 = 1U; // DISCHG:ON
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
						P7_bit.no1 = 0U; // DISCHG:OFF
						gPdc.uPdEvent.bit.bPlugChg = 0U;
					}
				}
			}
		}
	}
	else if (gPdc.uPdEvent.bit.bPrChg != 0U) {
		if (uStatus.bit.bPR != 0U) { // ATT.SRC
			gLed.uReq.bits.bSrcEn = 1U;
		}
		else {
			gLed.uReq.bits.bSnkEn = 1U;
		}
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
		if (gRcvMess.uInfo.bit.bClass == DATA_MESSAGE) {
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
			gDCInfo.uReq.bit.bSrcOff = 1U;
			gucWaiCmp = 1U;
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pd_tm_stop_user_cnt(TM_ID_USER2);
#endif
		}
		else {
			if(gDCInfo.uNtfy.bit.bUnexpected == 1U){
				gDCInfo.uNtfy.bit.bUnexpected = 0U;
				P7_bit.no1 = 0U; // DISCHG:OFF
				gPdc.uPdReq.bit.bSrcOff    = 0U;
				gucWaiCmp = 0U;
			}
			else{
				SHORT usVbus = pdc_get_an_volt(AN_CH_VBUS);
				if (usVbus >= 0) {
					if (usVbus <= 800) {
						P7_bit.no1 = 0U; // DISCHG:OFF
						gPdc.uPdReq.bit.bSrcOff    = 0U;
						gucWaiCmp = 0U;
					}
					else if (usVbus <= 5500) {
						P7_bit.no3 = 0U; // DR_GATE:OFF
						P7_bit.no1 = 1U; // DISCHG:ON
					}
				}
			} 
		}
	}
	else if (gPdc.uPdReq.bit.bSnkOff != 0U) {
		if (uStatus.bit.bPlug == 0U) { // Unplug
			P7_bit.no3 = 0U; // DR_GATE:OFF
			gDCInfo.uReq.bit.bSnkOff = 1U;
		}
		else {
			if (pdc_get_req_volt() == 0U) {
				P7_bit.no3 = 0U; // DR_GATE:OFF
			}
			gDCInfo.uReq.bit.bSnkOff = 1U;
		}
		gPdc.uPdReq.bit.bSnkOff = 0U;
	}
	else if (gPdc.uPdReq.bit.bSrcOn != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			P7_bit.no3 = 1U; // DR_GATE:ON
			gDCInfo.uReq.bit.bSrcOn = 1U;
			gPdc.uPdReq.bit.bSrcOn = 0U;
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
			P7_bit.no3 = 1U; // DR_GATE:ON
			gDCInfo.uReq.bit.bSnkOn = 1U;
			gPdc.uPdReq.bit.bSnkOn = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bSnkChg != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSnkChg = 1U;
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
	else if( gDCInfo.uNtfy.usData != 0U){
		gDCInfo.uNtfy.usData = 0U;
	}
}
