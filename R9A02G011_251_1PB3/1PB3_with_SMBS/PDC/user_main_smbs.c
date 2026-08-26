#include "user_main.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "R9A02G011PDC.h"
#include "R9A02G011SMBS.h"
#include "R_Main_UserInit.h"

#define SMBS_TARGET_PR (0) // 0:SNK, 1:SRC
#define SMBS_TARGET_DR (0) // 0:UFP, 1:DFP
#define SMBS_EXTPWR_CTRL  (0) // 0:Disable, 1:Enable
#define SMBS_INTPWR_CTRL  (0) // 0:Disable, 1:Enable

#define SMBS_SYS_EXT_PWR         (0x02U) // 0b00010
#define SMBS_SYS_INTR_PWR        (0x08U) // 0b01000
#define SMBS_SYS_EXT_PWR_AC      (0x04U) // 0b00100
#define SMBS_SYS_INTR_PWR_NOBAT  (0x10U) // 0b10000

extern UCHAR  gucVdmFlg;
extern UCHAR  gucWaitSmbsCmdComp;
extern UCHAR  gucDrSwapMode_bak;
extern UCHAR  gucPrSwapMode_bak;
extern UCHAR  gucInputPwr_bak;
extern SMBS_CCNF1 guCtrlCnf1_bak;
extern SMBS_CCNF2 guCtrlCnf2_bak;
extern USHORT usSmbsRdo_bak[2];

void user_smbs_init (void)
{
	smbs_init(0x18U, SMBS_CLK_0400kH, 0);
	smbs_set_ctrl_conf1(0x0101U, 0U);
	smbs_set_ctrl_conf2(0x0000U ,0U);
	smbs_set_sys_conf1(0x0000U);
	smbs_set_sys_conf2(0x0000U);
	smbs_set_dev_cap  (0x0000U);
}

UCHAR user_func_smbs (void)
{
	UCHAR  ucActive = 0U;
	USHORT usBuf[14] = {0};

	if (gucVdmFlg == 1U) {
		return PD_CORE_STOP;
	}
	
	if (gSmbsEvent.bit.bRcvCmd != 0U) {
		UCHAR ucCmd, ucTarget;
		UCHAR ucMode = smbs_get_cmd(&ucCmd, &ucTarget);
		if (ucMode == SMBS_CMD_TYPE_DEF) {
			if (pdc_get_cmd_result() == PDC_CMD_RSLT_PROGRESS) {
				smbs_set_cmd_result(PDC_CMD_RSLT_BUSY);
			}
			else {
				pdc_set_cmd(ucCmd, ucTarget);
			}
			ucActive = 1U;
		}
		else if (ucMode == SMBS_CMD_TYPE_UNDEF) {
			// Undefined command by R9A02G011SMBS.lib
			if (ucCmd == 0xA0) {
				// 0xA0 command is sample of command defined user
				// When it is completed user's function, you should call smbs_set_cmd_result().
				smbs_set_cmd_result(PDC_CMD_RSLT_SUCCESS);
			}
			else {
				smbs_set_cmd_result(PDC_CMD_RSLT_INVALID);
			}
			ucActive = 1U;
		}
		else { // ucMode == SMBS_CMD_TYPE_NOT_RCV
		}
		gSmbsEvent.bit.bRcvCmd = 0U;
		gucWaitSmbsCmdComp = 1U;
	}
	else if (gSmbsEvent.bit.bChgCtrlCnf1 != 0U) {
		PD_STATUS uStatus   = pdc_get_status();
		SMBS_CCNF1 uCtrlCnf1;
		UCHAR  ucDrSwapMode = 0U, ucPrSwapMode = 0U, ucInputPwr = 0U;
		UCHAR ucErr = 0U;
		uCtrlCnf1.usData = smbs_get_ctrl_conf1();
		
		if (uStatus.bit.bPlug != 0U) {
			if (uStatus.bit.bPR != 0U) { // SRC
				if ((uCtrlCnf1.bit.bDisableSrc != 0U) || (uCtrlCnf1.bit.bDisableDFP != 0U)) {
					uCtrlCnf1.bit.bDisableSrc = 0U;
					uCtrlCnf1.bit.bDisableDFP = 0U;
					ucErr = 1U;
				}
				if (uStatus.bit.bPR == 0U) { // UFP
					if ((uCtrlCnf1.bit.bDisableSnk != 0U) || (uCtrlCnf1.bit.bDisableUFP != 0U)) {
						uCtrlCnf1.bit.bDisableSnk = 0U;
						uCtrlCnf1.bit.bDisableUFP = 0U;
						ucErr = 1U;
					}
				}
			}
			if (uStatus.bit.bPR == 0U) { // SNK
				if ((uCtrlCnf1.bit.bDisableSnk != 0U) || (uCtrlCnf1.bit.bDisableUFP != 0U)) {
					uCtrlCnf1.bit.bDisableSnk = 0U;
					uCtrlCnf1.bit.bDisableUFP = 0U;
					ucErr = 1U;
				}
				if (uStatus.bit.bPR != 0U) { // DFP
					if ((uCtrlCnf1.bit.bDisableSrc != 0U) || (uCtrlCnf1.bit.bDisableDFP != 0U)) {
						uCtrlCnf1.bit.bDisableSrc = 0U;
						uCtrlCnf1.bit.bDisableDFP = 0U;
						ucErr = 1U;
					}
				}
			}
		}
		
		if (   ((uCtrlCnf1.bit.bDisableSnk != 0U) && (uCtrlCnf1.bit.bDisableSrc != 0U))
		    || ((uCtrlCnf1.bit.bDisableUFP != 0U) && (uCtrlCnf1.bit.bDisableDFP != 0U))) {
			uCtrlCnf1.usData &= ~SMBS_CCNF1_DISABLE_MASK;
			ucErr = 1U;
		}
		
		if (((uCtrlCnf1.usData ^ guCtrlCnf1_bak.usData) & SMBS_CCNF1_DISABLE_MASK) != 0U) {
			UCHAR ucbasePort = PDC_ROLE_DRP_DRD;
			if (uCtrlCnf1.bit.bDisableSrc != 0U) {
				if (uCtrlCnf1.bit.bDisableDFP != 0U) {
					ucbasePort = PDC_ROLE_SNK_UFP;
				}
				else {
					ucbasePort = PDC_ROLE_SNK_DRD;
				}
			}
			else if (uCtrlCnf1.bit.bDisableSnk != 0U) {
				if (uCtrlCnf1.bit.bDisableUFP != 0U) {
					ucbasePort = PDC_ROLE_SRC_DFP;
				}
				else {
					ucbasePort = PDC_ROLE_SRC_DRD;
				}
			}
			pdc_set_port_conf(ucbasePort, PDC_ACS_VCONN);
			ucActive = 1U;
		}
		
		if (   (guCtrlCnf1_bak.bit.bAutoAcptSwap_PR != uCtrlCnf1.bit.bAutoAcptSwap_PR)
		    || (guCtrlCnf1_bak.bit.bAutoReqSwap_PR  != uCtrlCnf1.bit.bAutoReqSwap_PR )) {
			if (uCtrlCnf1.bit.bAutoReqSwap_PR != 0U) {
				if (SMBS_TARGET_PR == 0U) {
					ucPrSwapMode = PDC_SYS_PR_SWAP_ACTIVE_SNK;
				}
				else {
					ucPrSwapMode = PDC_SYS_PR_SWAP_ACTIVE_SRC;
				}
			}
			else if (uCtrlCnf1.bit.bAutoAcptSwap_PR != 0U) {
				ucPrSwapMode = PDC_SYS_PR_SWAP_PASSIVE;
			}
		}
		else {
			ucPrSwapMode = gucPrSwapMode_bak;
		}
		
		if (   (guCtrlCnf1_bak.bit.bAutoAcptSwap_DR != uCtrlCnf1.bit.bAutoAcptSwap_DR)
		    || (guCtrlCnf1_bak.bit.bAutoReqSwap_DR  != uCtrlCnf1.bit.bAutoReqSwap_DR )) {
			if (uCtrlCnf1.bit.bAutoReqSwap_DR != 0U) {
				if (SMBS_TARGET_DR == 0U) {
					ucDrSwapMode = PDC_SYS_DR_SWAP_ACTIVE_UFP;
				}
				else {
					ucDrSwapMode = PDC_SYS_DR_SWAP_ACTIVE_DFP;
				}
			}
			else if (uCtrlCnf1.bit.bAutoAcptSwap_DR != 0U) {
				ucDrSwapMode = PDC_SYS_DR_SWAP_PASSIVE;
			}
		}
		else {
			ucDrSwapMode = gucDrSwapMode_bak;
		}
		
		if (guCtrlCnf1_bak.bit.bIntrPwr != uCtrlCnf1.bit.bIntrPwr) {
			if (SMBS_INTPWR_CTRL != 0U) { // Control by SMBS
				if (uCtrlCnf1.bit.bIntrPwr != 0U) {
					if (guCtrlCnf2_bak.bit.bIntrPwrType == 0U) {
						ucInputPwr |= PDC_SYS_INTR_PWR_BAT;
					}
					else {
						ucInputPwr |= PDC_SYS_INTR_PWR_NONBAT;
					}
				}
				else {
					ucInputPwr |= gucInputPwr_bak & (~(PDC_SYS_INTR_PWR_BAT | PDC_SYS_INTR_PWR_NONBAT));
				}
			}
			else {
				uCtrlCnf1.bit.bIntrPwr = guCtrlCnf1_bak.bit.bIntrPwr;
				ucErr = 1U;
			}
		}
		else {
			ucInputPwr |= gucInputPwr_bak & (PDC_SYS_INTR_PWR_BAT | PDC_SYS_INTR_PWR_NONBAT);
		}
		
		if (guCtrlCnf1_bak.bit.bExtPwr != uCtrlCnf1.bit.bExtPwr) {
			if (SMBS_EXTPWR_CTRL != 0U) { // Control by SMBS
				if (guCtrlCnf2_bak.bit.bExtPwrCnst != 0U) {
					ucInputPwr |= PDC_SYS_UNCNST_PWR;
				}
				
				if (uCtrlCnf1.bit.bExtPwr != 0U) {
					if (guCtrlCnf2_bak.bit.bExtPwrACDC == 0U) {
						ucInputPwr |= PDC_SYS_EXT_PWR_DC;
					}
					else {
						ucInputPwr |= PDC_SYS_EXT_PWR_AC;
					}
				}
				else {
					ucInputPwr &= (~(PDC_SYS_EXT_PWR_DC | PDC_SYS_EXT_PWR_AC));
				}
			}
			else {
				uCtrlCnf1.bit.bExtPwr = guCtrlCnf1_bak.bit.bExtPwr;
				ucErr = 1U;
			}
		}
		else {
			ucInputPwr |= gucInputPwr_bak & (PDC_SYS_UNCNST_PWR | PDC_SYS_EXT_PWR_DC | PDC_SYS_EXT_PWR_AC);
		}
		
		if (   (gucPrSwapMode_bak != ucPrSwapMode)
		    || (gucDrSwapMode_bak != ucDrSwapMode)
		    || (gucInputPwr_bak   != ucInputPwr  )) {
			gucPrSwapMode_bak = ucPrSwapMode;
			gucDrSwapMode_bak = ucDrSwapMode;
			if ((SMBS_INTPWR_CTRL | SMBS_EXTPWR_CTRL) != 0U) {
				gucInputPwr_bak   = ucInputPwr;
			}
			pdc_set_sys_conf(gucDrSwapMode_bak, gucPrSwapMode_bak, gucInputPwr_bak, 0U);
			ucActive = 1U;
		}
		
		if (guCtrlCnf1_bak.bit.bSnkPdoMax != uCtrlCnf1.bit.bSnkPdoMax) {
			UCHAR  ucNum = 4U;     // Max num of PDOs
			if (   (uCtrlCnf1.bit.bSnkPdoMax != 0U)
			    && (uCtrlCnf1.bit.bSnkPdoMax <= 4U)) {
				ucNum = uCtrlCnf1.bit.bSnkPdoMax;
			}
			pdc_set_snk_conf(60000U, ucNum, 0);
			usSmbsRdo_bak[0] = 0;
			usSmbsRdo_bak[1] = 0;
			ucActive = 1U;
		}
		
		if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR != 0U) && (ucErr == 0U)) { // ATT.SRC
			if (   (guCtrlCnf1_bak.bit.bExtPwr != uCtrlCnf1.bit.bExtPwr)
			    && (guCtrlCnf2_bak.bit.bExtPwrCnst != 0U)) {
				pdc_set_cmd(PDC_CMD_SND_SRC_CAP, PDC_TARGET_SOP);
				ucActive = 1U;
			}
		}
		
		guCtrlCnf1_bak.usData = uCtrlCnf1.usData;
		if (ucErr != 0U) {
			smbs_set_ctrl_conf1(guCtrlCnf1_bak.usData, ucErr);
			ucActive = 1U;
		}
		gSmbsEvent.bit.bChgCtrlCnf1 = 0U;
	}
	else if (gSmbsEvent.bit.bChgCtrlCnf2 != 0U) {
		PD_STATUS uStatus   = pdc_get_status();
		UCHAR ucInputPwr = 0U;
		SMBS_CCNF2 uCtrlCnf2;
		UCHAR ucErr = 0U;
		uCtrlCnf2.usData = smbs_get_ctrl_conf2();
		if (   (guCtrlCnf2_bak.bit.bSrcMaxPwr != uCtrlCnf2.bit.bSrcMaxPwr)
		    || (guCtrlCnf2_bak.bit.bSrcPdoMax != uCtrlCnf2.bit.bSrcPdoMax)) {
			ULONG ulPwr = 60000U; // Max power
			UCHAR  ucNum = 4U;     // Max num of PDOs
			
			if (   (uCtrlCnf2.bit.bSrcMaxPwr != 0U  )
			    && (uCtrlCnf2.bit.bSrcMaxPwr <= 240U)) {
				ulPwr = (ULONG)uCtrlCnf2.bit.bSrcMaxPwr * 250U;
			}
			
			if (   (uCtrlCnf2.bit.bSrcPdoMax != 0U)
			    && (uCtrlCnf2.bit.bSrcPdoMax <= 4U)) {
				ucNum = uCtrlCnf2.bit.bSrcPdoMax;
			}
			pdc_set_src_conf(ulPwr, ucNum, 0, PDC_NOPD_CUR_3_0A);
			ucActive = 1U;
		}
		
		if (guCtrlCnf2_bak.bit.bIntrPwrType != uCtrlCnf2.bit.bIntrPwrType) {
			if (SMBS_INTPWR_CTRL != 0U) { // Control by SMBS
				ucInputPwr |= gucInputPwr_bak & SMBS_SYS_INTR_PWR;
				if (uCtrlCnf2.bit.bIntrPwrType != 0U) {
					ucInputPwr |= SMBS_SYS_INTR_PWR_NOBAT;
				}
			}
			else {
				uCtrlCnf2.bit.bIntrPwrType = guCtrlCnf2_bak.bit.bIntrPwrType;
				ucErr = 1U;
			}
		}
		else {
			ucInputPwr |= gucInputPwr_bak & (PDC_SYS_INTR_PWR_BAT | PDC_SYS_INTR_PWR_NONBAT);
		}
		
		if (   (guCtrlCnf2_bak.bit.bExtPwrACDC != uCtrlCnf2.bit.bExtPwrACDC)
		    || (guCtrlCnf2_bak.bit.bExtPwrCnst != uCtrlCnf2.bit.bExtPwrCnst)) {
			if (SMBS_EXTPWR_CTRL != 0U) {  // Control by SMBS
				if (guCtrlCnf2_bak.bit.bExtPwrCnst != uCtrlCnf2.bit.bExtPwrCnst) {
					if (uCtrlCnf2.bit.bExtPwrCnst != 0U) {
						ucInputPwr |= PDC_SYS_UNCNST_PWR;
					}
				}
				else {
					ucInputPwr |= gucInputPwr_bak & PDC_SYS_UNCNST_PWR;
				}
				
				if (guCtrlCnf2_bak.bit.bExtPwrACDC != uCtrlCnf2.bit.bExtPwrACDC) {
					ucInputPwr |= gucInputPwr_bak & SMBS_SYS_EXT_PWR;
					if (uCtrlCnf2.bit.bExtPwrACDC != 0U) {
						ucInputPwr |= SMBS_SYS_EXT_PWR_AC;
					}
				}
				else {
					ucInputPwr |= gucInputPwr_bak & (PDC_SYS_EXT_PWR_DC | PDC_SYS_EXT_PWR_AC);
				}
			}
			else {
				uCtrlCnf2.bit.bExtPwrACDC = guCtrlCnf2_bak.bit.bExtPwrACDC;
				uCtrlCnf2.bit.bExtPwrCnst = guCtrlCnf2_bak.bit.bExtPwrCnst;
				ucErr = 1U;
			}
		}
		else {
			ucInputPwr |= gucInputPwr_bak & (PDC_SYS_UNCNST_PWR | PDC_SYS_EXT_PWR_DC | PDC_SYS_EXT_PWR_AC);
		}
		
		if ((gucInputPwr_bak != ucInputPwr) && ((SMBS_INTPWR_CTRL | SMBS_EXTPWR_CTRL) != 0U)) {
			gucInputPwr_bak = ucInputPwr;
			pdc_set_sys_conf(gucDrSwapMode_bak, gucPrSwapMode_bak, gucInputPwr_bak, 0U);
			ucActive = 1U;
		}

		if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR != 0U) && (ucErr == 0U)) { // ATT.SRC
			if (   (guCtrlCnf2_bak.bit.bSrcMaxPwr  != uCtrlCnf2.bit.bSrcMaxPwr)
			    || (guCtrlCnf2_bak.bit.bSrcPdoMax  != uCtrlCnf2.bit.bSrcPdoMax)
			    || (   (guCtrlCnf1_bak.bit.bExtPwr     != 0U)
			        && (guCtrlCnf2_bak.bit.bExtPwrCnst != uCtrlCnf2.bit.bExtPwrCnst))) {
				pdc_set_cmd(PDC_CMD_SND_SRC_CAP, PDC_TARGET_SOP);
				ucActive = 1U;
			}
		}
		guCtrlCnf2_bak.usData = uCtrlCnf2.usData;
		if (ucErr != 0U) {
			smbs_set_ctrl_conf2(guCtrlCnf2_bak.usData, ucErr);
			ucActive = 1U;
		}
		gSmbsEvent.bit.bChgCtrlCnf2 = 0U;
	}
	else if (gSmbsEvent.bit.bReqSetObjData != 0U) {
		UCHAR ucType = smbs_get_obj_data_sel();
		UCHAR  ucSize = 0U, ucErr = 0U;
		if (ucType == SMBS_OBJ_SEL_SRCPDO_MAX) {
			// same as pd_defs.h setting
			usBuf[0] = 0x0001U;
			usBuf[1] = 0x912CU;
			usBuf[2] = 0x0002U;
			usBuf[3] = 0xD12CU;
			usBuf[4] = 0x0004U;
			usBuf[5] = 0xB12CU;
			usBuf[6] = 0x0006U;
			usBuf[7] = 0x412CU;
			ucSize = 4U * 4U;
		}
		smbs_set_obj_data(usBuf, ucSize, ucErr);
		ucActive = 1U;
		gSmbsEvent.bit.bReqSetObjData = 0U;
	}
	else if (gSmbsEvent.bit.bChgObjData != 0U) {
		PD_STATUS uStatus = pdc_get_status();
		UCHAR ucType = smbs_get_obj_data_sel();
		UCHAR  ucSize = 0U, ucErr = 0U, ucPos;
		
		smbs_get_obj_data(usBuf, &ucSize, &ucPos);
		
		if (ucType == SMBS_OBJ_SEL_RDO) {
			if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR == 0U) && (uStatus.bit.bRdyIdle == 1)) { // ATT.SNK
				usSmbsRdo_bak[0] = usBuf[0];
				usSmbsRdo_bak[1] = usBuf[1];
				gSndMess.uspData[0] = usBuf[0];
				gSndMess.uspData[1] = usBuf[1];
				gSndMess.uInfo.bit.bLen = 4U;
				user_func_set_snk_intrusive_en();
				ucActive = 1U;
			}
			else {
				ucErr = 1U;
			}
		}
		else if (ucType == SMBS_OBJ_SEL_VDM) {
			UCHAR i;
			gSndMess.uInfo.bit.bLen = ((ucSize + 3U) >> 2U) << 2U;
			for (i = 0; i < (gSndMess.uInfo.bit.bLen >> 1U); i++) {
				gSndMess.uspData[i] = usBuf[i];
			}
		}
		else if (ucType == SMBS_OBJ_SEL_BSDO) {
			gSndMess.uInfo.bit.bLen = 0U;
			gSndMess.uspData[0] = usBuf[0];
			gSndMess.uspData[1] = usBuf[1];
		}
		else if (ucType == SMBS_OBJ_SEL_EDB) {
			if (ucPos == 0U) {
				if ((usBuf[0] == 0U) || (ucSize < 2U)) {
					ucErr = 1U;
				}
				else {
					UCHAR i;
					gSndMess.uInfo.bit.bLen = usBuf[0];
					for (i = 0; i < ((ucSize - 1U) >> 1U); i++) {
						gSndMess.uspData[i] = usBuf[i + 1];
					}
				}
			}
			else {
				if (ucSize < 2U) {
					ucErr = 1U;
				}
				else {
					UCHAR i;
					UCHAR addr  = (ucPos * ucSize - 2U) >> 1U;
					for (i = 0; i < ((ucSize + 1U) >> 1U); i++) {
						gSndMess.uspData[addr] = usBuf[i];
					}
				}
			}
		}
		else {
			ucErr = 1U;
		}
		
		if (ucErr != 0U) {
			smbs_set_obj_data(usBuf, ucSize, ucErr);
			ucActive = 1U;
		}
		
		gSmbsEvent.bit.bChgObjData = 0U;
	}
	
	if (gucWaitSmbsCmdComp != 0U) {
		UCHAR ucResult = pdc_get_cmd_result();
		if (ucResult != PDC_CMD_RSLT_PROGRESS) {
			smbs_set_cmd_result(ucResult);
			ucActive = 1U;
			gucWaitSmbsCmdComp = 0U;
		}
	}
	
	if ((gucWaitSmbsCmdComp != 0U) || (ucActive != 0U)) {
		return PD_CORE_ACTIVE;
	}
	else {
		return PD_CORE_STOP;
	}
}

void user_func_smbs_clr_rdo (void)
{
	user_func_set_snk_intrusive_dis();
	usSmbsRdo_bak[0] = 0;
	usSmbsRdo_bak[1] = 0;
}
