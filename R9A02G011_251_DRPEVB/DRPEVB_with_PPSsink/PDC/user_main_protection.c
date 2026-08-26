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

#define SINK_PPS_REQ_PERIOD          1000U //1000ms, Range:200ms~8191ms

extern USHORT gusTemp;
extern UCHAR  gucOmfData;
extern UCHAR  gucVdmFlg;

void user_func_start_timer_thermistor(void);
void user_func_stop_timer_thermistor (void);
void user_func_intr_timer_thermistor (void);

UCHAR user_func_chk_device (void)
{
	static const USHORT temp_table_temp[8] = {   3,   20,   30,   40,   80,   90,  100,  120};
	static const USHORT temp_table_volt[8] = { 167,  373,  560,  799, 1997, 2257, 2476, 2796};
	
	PD_STATUS uStatus   = pdc_get_status();
	SHORT     sTempVolt = pdc_get_an_volt(AN_CH09);
	SHORT sVbus = pdc_get_an_volt(AN_CH_VBUS_NO_FILTER);
	UCHAR ucOTP = 0U, ucOCP = 0U, ucOVP = 0U;
	UCHAR ucTempStat = PDC_TEMP_STAT_NORMAL;
	
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

	if (sTempVolt > 0) {
		if (sTempVolt > temp_table_volt[7]) {
			gusTemp = temp_table_volt[7];
		}
		else if (sTempVolt < temp_table_volt[0]) {
			gusTemp = 0U;
		}
		else {
			CHAR i;
			for (i = 6; i >= 0; i--) {
				if (sTempVolt > temp_table_volt[i]) {
					gusTemp =  temp_table_temp[i]
					         + (ULONG)(sTempVolt              - temp_table_volt[i])
					         * (ULONG)(temp_table_temp[i + 1] - temp_table_temp[i])
					         / (ULONG)(temp_table_volt[i + 1] - temp_table_volt[i]);
					break;
				}
			}
		}
	}

	if (gusTemp > 80U) {
		ucTempStat = PDC_TEMP_STAT_OVER_TEMP;
		ucOTP = 1U;
		gucVdmFlg = 0U;
	}
	else if (gusTemp > 60U) {
		ucTempStat = PDC_TEMP_STAT_WARNING;
	}
	
	if ((uStatus.bit.bPlug == 0U) && (ucOTP == 0U)) {
		user_func_stop_timer_thermistor();
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

	if ((uStatus.bit.bPR == 0U) && (pdc_is_pps_mode() != 0U)) {
		if (pd_tm_chk_user_stat(TM_ID_USER2, SINK_PPS_REQ_PERIOD) == TM_ST_OVR) {
			if ((pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) && (uStatus.bit.bRdyIdle != 0U)) {
				user_intrusive_request(IS_PERIOD);
				pd_tm_stop_user_cnt(TM_ID_USER2);
			}
		}
	}

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
	pdc_set_int_routine(intID_INTTM03, (ULONG)&user_func_intr_timer_thermistor);
	
	TDR03  = 11699U;
	TPS0  |= (USHORT)(1U << 12U);
	TMIF03 = 0U;    /* clear INTTM03 interrupt flag */
	TMMK03 = 0U;    /* enable INTTM03 interrupt */
	TS0 |= _0008_TAU_CH3_START_TRG_ON;
}

void user_func_stop_timer_thermistor (void)
{
	TT0 |= _0008_TAU_CH3_STOP_TRG_ON;
	TMIF03 = 0U;
	TMMK03 = 1U;
}

void user_func_intr_timer_thermistor (void)
{
	pdc_req_update_an(AN_CH09);
	pdc_timer_active();
}
