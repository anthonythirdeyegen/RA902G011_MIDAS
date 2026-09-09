#include "user_main.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#endif
#include "interrupt.h"
#include "r_cg_timer.h"
#include "R9A02G011PDC.h"
#include "user_timer.h"
#include "dcdc_ctrl.h"

extern USHORT gusTemp;
extern UCHAR  gucOmfData;
extern UCHAR  gucVdmFlg;
extern UCHAR gucEnterModeEnable;
extern UCHAR gucLEDStatus;

void user_func_start_timer_thermistor(void);
void user_func_stop_timer_thermistor (void);
void user_func_intr_timer_thermistor (void);

UCHAR user_func_chk_device (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	SHORT sVbus = pdc_get_an_volt(AN_CH_VBUS_NO_FILTER);
	UCHAR ucOTP = 0U, ucOCP = 0U, ucOVP = 0U;
	UCHAR ucTempStat = PDC_TEMP_STAT_NORMAL;
	gusTemp = 0U;
	
	if ( (uStatus.bit.bPR != 0U) && (pdc_is_pps_mode()==0U) ) { // SRC and Fixed supply
		if (uStatus.bit.bRdyIdle != 0U) {
			if (sVbus < ((ULONG)pdc_get_req_volt() * 85U / 100U)) {
				ucOCP = 1U;
				gucVdmFlg = 0U;
			}
		}
	}
	
	if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR == 0U)) { // SNK
		if (sVbus > ((ULONG)20000U * 115U / 100U)) {
			ucOVP = 1U;
			gucVdmFlg = 0U;
		}
	}

	pdc_set_dev_stat(ucOCP, ucOTP, ucOVP, ucTempStat, gusTemp);

#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
	if ((uStatus.bit.bPR   != 0U) && (pdc_is_pps_mode() !=0U)) {
		if (pd_tm_chk_user_stat(TM_ID_USER2, 10U) == TM_ST_OVR) {
			if (gDCInfo.uReq.usData == 0U) {
				gDCInfo.uReq.bit.bPoll = 1U;
				pd_tm_stop_user_cnt(TM_ID_USER2);
			}
		}
		else if (gDCInfo.uNtfy.bit.bGetInfo != 0U) {
			gDCInfo.uNtfy.bit.bGetInfo = 0U;
			gucOmfData <<= 1U;
			if (gDCInfo.uNtfy.bit.bOcpAlert != 0U) {
				gucOmfData++;
			}
			
			if (gucOmfData == 0U) {
				pdc_set_pps_stat((ucTempStat << 1U), 0xFF, 0xFFFFU);
			}
			else {
				pdc_set_pps_stat((0x08 | (ucTempStat << 1U)), 0xFF, 0xFFFFU);
			}
			pd_tm_start_user_cnt(TM_ID_USER2);
		}
	}
	else {
		gucOmfData = 0U;
		gDCInfo.uNtfy.bit.bGetInfo = 0U;
		pdc_set_pps_stat((ucTempStat << 1U), 0xFF, 0xFFFFU);
	}
#endif

	if ((uStatus.bit.bPR != 0U) && (uStatus.bit.bRdyIdle != 0U)) {
		return PD_CORE_ACTIVE; // everytime monitoring VBUS for OCP 
	}
	else {
		return (((ucOCP + ucOTP + ucOVP) != 0U) ? PD_CORE_ACTIVE : PD_CORE_STOP);
	}
}

UCHAR user_func_snd_mess (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	
	if (uStatus.bit.bRdyIdle != 0U) {
		if (gucVdmFlg == 0U) {
			// send Discover Identiry
			if (uStatus.bit.bComRevPDC != 0U) {
				gSndMess.uspData[0] = 0xA001U;
			}
			else {
				gSndMess.uspData[0] = 0x8001U;
			}
			
			if (   (uStatus.bit.bComRevPDC != 0U)
			    || (   (uStatus.bit.bPR    != 0U)
			        && (uStatus.bit.bDR    != 0U))) {
				gSndMess.uspData[1] = 0xFF00U;
				gSndMess.uInfo.bit.bLen = 4U;
				pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				gucVdmFlg = 1U;
			}
			else {
				gucVdmFlg = 2U;
			}
		}
	}
	else if (gucVdmFlg == 1U) {
		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			// command complete
			// you can check pdc_get_cmd_result() and gRcvMess
			gucVdmFlg = 2U;
		}
	}
	
	if (gucVdmFlg == 1U) {
		return PD_CORE_ACTIVE;
	}
	else {
		return PD_CORE_STOP;
	}
}

void user_func_start_timer_thermistor (void)
{
	/* AN9/P21 thermistor polling disabled; P21 is repurposed as FPGA_POWER_READY. */
}

void user_func_stop_timer_thermistor (void)
{
	/* AN9/P21 thermistor polling disabled; P21 is repurposed as FPGA_POWER_READY. */
}

void user_func_intr_timer_thermistor (void)
{
	/* AN9/P21 thermistor polling disabled; P21 is repurposed as FPGA_POWER_READY. */
}

UCHAR user_func_snd_attention (void)
{
	PD_STATUS uStatus   = pdc_get_status();
	if (gucVdmFlg == 0U) {
		if (gucEnterModeEnable == 1) {
			if (pd_tm_chk_user_stat(TM_ID_USER2, tUserReq) == TM_ST_OVR) {
				pd_tm_stop_user_cnt(TM_ID_USER2);
				if (uStatus.bit.bRdyIdle != 0U) {
					if (uStatus.bit.bComRevPDC != 0U) {
						gSndMess.uspData[0] = 0xA006U;
					}
					else {
						gSndMess.uspData[0] = 0x8006U;
					}
					gSndMess.uspData[1] = DUMMYSID;
					gucLEDStatus ^= 0x0001U;
					gSndMess.uspData[2] = gucLEDStatus;
					gSndMess.uspData[3] = 0x0000U;
					gSndMess.uInfo.bit.bLen = 8U;
					pdc_set_cmd(PDC_CMD_SND_VDM, 0);
					gucVdmFlg = 1U;
				}
			}
		}
	}
	else if (gucVdmFlg == 1U) {
		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			// command complete
			// you can check pdc_get_cmd_result() and gRcvMess
			pd_tm_start_user_cnt(TM_ID_USER2);
			gucVdmFlg = 0U;
		}
	}
	
	if (gucVdmFlg == 0U) {
		return PD_CORE_STOP;
	}
	else {
		return PD_CORE_ACTIVE;
	}
}
