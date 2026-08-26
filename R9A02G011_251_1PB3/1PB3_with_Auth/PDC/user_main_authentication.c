#include "user_main_authentication.h"
#include "interrupt.h"
#include "r_cg_timer.h"
#include "R9A02G011PDC.h"
#include "user_timer.h"
#include "dcdc_ctrl.h"
#include "R9A02G011AUTH.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#endif

extern UCHAR  gucVdmFlg;
extern UCHAR  gucAuthFlg;
#define DATA_MESSAGE				0x01

UCHAR user_func_auth (void)
{
#if (AUTH_TYP == AUTH_SNK_INITIATOR_DIS)
	gucAuthFlg = 0xFU;
#elif (AUTH_TYP == AUTH_SNK_INITIATOR_FARSRC)
	PD_STATUS uStatus   = pdc_get_status();
	if (   (uStatus.bit.bRdyIdle != 0U)
		&& (gucAuthFlg           == 0U)
		&& (gucVdmFlg            == 0U)){
		if (   (uStatus.bit.bComRevPDC != 0U)
		    && (uStatus.bit.bPR        == 0U)) {
			if (auth_get_status() == AUTH_STAT_READY) {
				auth_run_initiator(PDC_TARGET_SOP);
			}
			gucAuthFlg = 0x01U;
		}
		else {
			gucAuthFlg = 0x0FU;
		}
	}
	else if (gucAuthFlg == 0x01U) {
		if (auth_get_status() == AUTH_STAT_READY) {
			if (auth_get_result() == AUTH_RSLT_GOOD) {
				gucAuthFlg = 0x02U;
			}
			else if (auth_get_result() == AUTH_RSLT_BAD) {
				gucAuthFlg = 0x03U;
			}
			else {
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x02U) {
		pdc_set_snk_conf(63000U, 2, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x14U;
	}
	else if (gucAuthFlg == 0x03U) {
		pdc_set_snk_conf(15000U, 1, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x04U;
	}
	else if ((gucAuthFlg & 0x0FU) == 0x04U) {
		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			gucAuthFlg |= 0x0FU;
		}
	}
#elif (AUTH_TYP == AUTH_SNK_INITIATOR_CP)
	PD_STATUS uStatus   = pdc_get_status();
	if (   (uStatus.bit.bRdyIdle != 0U)
		&& (gucAuthFlg           == 0U)
		&& (gucVdmFlg            == 0U)){
		if (   (uStatus.bit.bComRevPDC != 0U)
		    && (uStatus.bit.bPR        == 0U)) {
			if (   (P1_bit.no7      == 0U)
			    && (P1_bit.no6      == 0U)) {
				pdc_set_cmd(PDC_CMD_SND_VC_SWAP, PDC_TARGET_SOP);
				gucAuthFlg = 0x01U;
			}
			else if (uStatus.bit.bSOPP != 0U) {
				auth_run_initiator(PDC_TARGET_SOPP);
				gucAuthFlg = 0x04U;
			}
			else {
				gucAuthFlg = 0x02U;
			}
		}
		else {
			gucAuthFlg = 0x0FU;
		}
	}
	else if (gucAuthFlg == 0x01U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
				gucAuthFlg = 0x0FU;
			}
			else if (   (P1_bit.no7 != 0U)
			         || (P1_bit.no6 != 0U)) {
				if (uStatus.bit.bSOPP == 0U) {
					pdc_set_cmd(PDC_CMD_SND_SOFT_RESET, PDC_TARGET_SOPP);
					gucAuthFlg = 0x02U;
				}
				else {
					auth_run_initiator(PDC_TARGET_SOPP);
					gucAuthFlg = 0x04U;
				}
			}
			else{
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x02U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
				gucAuthFlg = 0x0FU;
			}
			else {
				gSndMess.uspData[0] = 0xA001U;
				gSndMess.uspData[1] = 0xFF00U;
				gSndMess.uInfo.bit.bLen = 4U;
				pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOPP);
				gucAuthFlg = 0x03U;
			}
		}
	}
	else if (gucAuthFlg == 0x03U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
				gucAuthFlg = 0x0FU;
			}
			else if (   (gRcvMess.uInfo.bit.bType == 0x0FU)
				     && ((gRcvMess.uspData[0] & 0x00FFU) == 0x0041U)
				     && (uStatus.bit.bComRevCP           == 1U)) {
				auth_run_initiator(PDC_TARGET_SOPP);
				gucAuthFlg = 0x04U;
			}
			else {
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x04U) {
		if (auth_get_status() == AUTH_STAT_READY) {
			if (auth_get_result() == AUTH_RSLT_GOOD) {
				gucAuthFlg = 0x05U;
			}
			else if (auth_get_result() == AUTH_RSLT_BAD) {
				gucAuthFlg = 0x06U;
			}
			else {
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x05U) {
		pdc_set_snk_conf(63000U, 2, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x17U;
	}
	else if (gucAuthFlg == 0x06U) {
		pdc_set_snk_conf(15000U, 1, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x07U;
	}
	else if ((gucAuthFlg & 0x0FU) == 0x07U) {
		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			gucAuthFlg |= 0x0FU;
		}
	}
#elif (AUTH_TYP == AUTH_SNK_INITIATOR_CP_FARSRC)
	PD_STATUS uStatus   = pdc_get_status();
	if (   (uStatus.bit.bRdyIdle != 0U)
		&& (gucAuthFlg           == 0x00U)
		&& (gucVdmFlg            == 0U)){
		if (   (uStatus.bit.bComRevPDC != 0U)
		    && (uStatus.bit.bPR        == 0U)) {
			if (   (P1_bit.no7   == 0U)
			    && (P1_bit.no6   == 0U)) {
				pdc_set_cmd(PDC_CMD_SND_VC_SWAP, PDC_TARGET_SOP);
				gucAuthFlg = 0x01U;
			}
			else if (uStatus.bit.bSOPP != 0U) {
				auth_run_initiator(PDC_TARGET_SOPP);
				gucAuthFlg = 0x04U;
			}
			else {
				gucAuthFlg = 0x02U;
			}
		}
		else {
			gucAuthFlg = 0x0FU;
		}
	}
	else if (gucAuthFlg == 0x01U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
				gucAuthFlg = 0x0FU;
			}
			else if (   (P1_bit.no7 != 0U)
			         || (P1_bit.no6 != 0U)) {
				if (uStatus.bit.bSOPP == 0U) {
					pdc_set_cmd(PDC_CMD_SND_SOFT_RESET, PDC_TARGET_SOPP);
					gucAuthFlg = 0x02U;
				}
				else {
					auth_run_initiator(PDC_TARGET_SOPP);
					gucAuthFlg = 0x04U;
				}
			}
			else{
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x02U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
				gucAuthFlg = 0x0FU;
			}
			else {
				gSndMess.uspData[0] = 0xA001U;
				gSndMess.uspData[1] = 0xFF00U;
				gSndMess.uInfo.bit.bLen = 4U;
				pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOPP);
				gucAuthFlg = 0x03U;
			}
		}
	}
	else if (gucAuthFlg == 0x03U) {
		if (   (uStatus.bit.bRdyIdle != 0U)
		    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
			if (   (uStatus.bit.bRdyIdle != 0U)
			    && (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS)) {
				if (pdc_get_cmd_result() != PDC_CMD_RSLT_SUCCESS) {
					gucAuthFlg = 0x0FU;
				}
				else if (   (gRcvMess.uInfo.bit.bType == 0x0FU)
					     && ((gRcvMess.uspData[0] & 0x00FFU) == 0x0041U)
					     && (uStatus.bit.bComRevCP           == 1U)) {
					auth_run_initiator(PDC_TARGET_SOPP);
					gucAuthFlg = 0x04U;
				}
				else {
					gucAuthFlg= 0x0FU;
				}
			}
		}
	}
	else if (gucAuthFlg == 0x04U) {
		if (auth_get_status() == AUTH_STAT_READY) {
			if (auth_get_result() == AUTH_RSLT_GOOD) {
				gucAuthFlg = 0x05U;
			}
			else if (auth_get_result() == AUTH_RSLT_BAD) {
				gucAuthFlg = 0x08U;
			}
			else {
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x05U) {
		auth_run_initiator(PDC_TARGET_SOP);
		gucAuthFlg = 0x06U;
	}
	else if (gucAuthFlg == 0x06U) {
		if (auth_get_status() == AUTH_STAT_READY) {
			if (auth_get_result() == AUTH_RSLT_GOOD) {
				gucAuthFlg = 0x07U;
			}
			else if (auth_get_result() == AUTH_RSLT_BAD) {
				gucAuthFlg = 0x08U;
			}
			else {
				gucAuthFlg = 0x0FU;
			}
		}
	}
	else if (gucAuthFlg == 0x07U) {
		pdc_set_snk_conf(63000U, 2, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x19U;
	}
	else if (gucAuthFlg == 0x08U) {
		pdc_set_snk_conf(15000U, 1, 0);
		gSndMess.uInfo.bit.bLen = 4U;
		pdc_set_cmd(PDC_CMD_SND_REQUEST, PDC_TARGET_SOP);
		gucAuthFlg = 0x09U;
	}
	else if ((gucAuthFlg & 0x0FU) == 0x09U) {
		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			gucAuthFlg |= 0x0FU;
		}
	}
#endif
	if (((gucAuthFlg & 0x0F) == 0x0FU) || (gucAuthFlg == 0x00U)) {
		return PD_CORE_STOP;
	}
	else {
		return PD_CORE_ACTIVE;
	}
}