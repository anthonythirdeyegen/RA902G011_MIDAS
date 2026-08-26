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
#include "isl95538b.h"
#include "dcdc_ctrl.h"
#include "mppm_pb_defs.h"
#include "user_main_battery.h"

#define SMBS_TARGET_PR (0) // 0:SNK, 1:SRC
#define SMBS_TARGET_DR (0) // 0:UFP, 1:DFP
#define SMBS_EXTPWR_CTRL  (0) // 0:Disable, 1:Enable
#define SMBS_INTPWR_CTRL  (0) // 0:Disable, 1:Enable

#define SMBS_SYS_EXT_PWR         (0x02U)
#define SMBS_SYS_INTR_PWR        (0x08U)
#define SMBS_SYS_EXT_PWR_AC      (0x04U)
#define SMBS_SYS_INTR_PWR_NOBAT  (0x10U)

extern UCHAR  gucVdmFlg;
extern UCHAR  gucWaitSmbsCmdComp;
extern UCHAR  gucDrSwapMode_bak;
extern UCHAR  gucPrSwapMode_bak;
extern UCHAR  gucInputPwr_bak;
extern SMBS_CCNF1 guCtrlCnf1_bak;
extern SMBS_CCNF2 guCtrlCnf2_bak;
extern USHORT usSmbsRdo_bak[2];
extern USHORT gusSVID;
extern MULTI_PORT_PB_INFO gMpPb;
extern BATTERY_INFO gBatInfo;
extern UCHAR  gucSnkDcdcFlg;
extern USHORT gucI2CCommFailed;

void user_smbs_init (void)
{
	smbs_init(0x18U, SMBS_CLK_0400kH, 1);
	smbs_set_ctrl_conf1(0x0101U, 0U);
	smbs_set_ctrl_conf2(0x0000U ,0U);
	smbs_set_sys_conf1(0x0000U);
	smbs_set_sys_conf2(0x0000U);
	smbs_set_dev_cap  (0x0000U);
	smbs_set_alrt_en  (0x7FFF);
}

UCHAR user_func_smbs (void)
{
	UCHAR  ucActive = 0U;
	USHORT usBuf[14] = {0};
	PD_STATUS uStatus = pdc_get_status();
	
	if (uStatus.bit.bPR != 0U) { // ATT.SRC
		if(pd_tm_chk_user_stat(TM_ID_USER3, 13U) == TM_ST_OVR) {
			pd_tm_stop_user_cnt(TM_ID_USER3);
			pdc_set_src_conf(15000U,1,0,PDC_NOPD_CUR_3_0A);
			guCtrlCnf2_bak.bit.bSrcPdoMax = 1U;
			gucI2CCommFailed = 1U;
		}
	}

	if (gucVdmFlg == 1U) {
		return PD_CORE_STOP;
	}
	else if (gucVdmFlg == 2U) {
		if (       (uStatus.bit.bComRevPDC != 0U)
				|| (   (uStatus.bit.bPR    != 0U)
			 	    && (uStatus.bit.bDR    != 0U))){	// Already Sent DI
			gusSVID = gRcvMess.uspData[2];
			gucVdmFlg = 4U;
		}
		else {
			gucVdmFlg = 3U;
		}
	}
	else if (    (gucVdmFlg       == 3U)
			  && (uStatus.bit.bPR != 0U)
			  && (uStatus.bit.bDR != 0U)) {
	    gucVdmFlg = 0U;
	}

	if (gucVdmFlg == 4U) {
		if(    (uStatus.bit.bPR != 0U)
			&& (uStatus.bit.bRdyIdle != 0U)) {
		    if(gucI2CCommFailed == 1U){
			    pdc_set_src_conf(15000U, 4, 0, PDC_NOPD_CUR_3_0A);			
		    }
		    else {
			    pdc_set_src_conf(30000U, 4, 1, PDC_NOPD_CUR_3_0A);			
		    }
			pdc_set_cmd(PDC_CMD_SND_SRC_CAP, PDC_TARGET_SOP);
			guCtrlCnf2_bak.bit.bSrcPdoMax = 4U;
			gucVdmFlg = 5U;
		}
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
			if (pdc_get_cmd_result() == PDC_CMD_RSLT_PROGRESS) {
				smbs_set_cmd_result(PDC_CMD_RSLT_BUSY);
			}
			else {
				// Undefined command by R9A02G011SMBS.lib
				if (ucCmd == 0xA0) {
					if(gucI2CCommFailed == 0U){
		    			pdc_set_cmd(PDC_CMD_SND_ACPT, ucTarget);
						pd_tm_stop_user_cnt(TM_ID_USER3);
					}
					gucI2CCommFailed = 0U;					
    			}
                else if (ucCmd == 0xA1) {
					if(gucI2CCommFailed == 0U){
		    			pdc_set_cmd(PDC_CMD_SND_RJCT, ucTarget);
						pd_tm_stop_user_cnt(TM_ID_USER3);
					}
					gucI2CCommFailed = 0U;
    			}
                else if (ucCmd == 0xA2) {
					if(gucI2CCommFailed == 0U){
		    			pdc_set_cmd(PDC_CMD_SND_WAIT, ucTarget);
						pd_tm_stop_user_cnt(TM_ID_USER3);
					}
					gucI2CCommFailed = 0U;					
    			}
				else if (ucCmd == 0xA3) {//Return to DRP
					pdc_set_port_conf(PDC_ROLE_DRP_DRD_TSRC, PDC_ACS_VCONN);
					pdc_set_cmd(PDC_CMD_ENA_TYPEC_CTRL, 0);
				}
				else if (ucCmd == 0xA4) {
					gucSnkDcdcFlg = 1U;
					smbs_set_cmd_result(PDC_CMD_RSLT_SUCCESS);
				}
    			else if (ucCmd == 0xA5) {
    				// 0xA5 command is sample of command defined user
					// When it is completed user's function, you should call smbs_set_cmd_result().
					smbs_set_cmd_result(PDC_CMD_RSLT_SUCCESS);
				}
				else {
					smbs_set_cmd_result(PDC_CMD_RSLT_INVALID);
				}
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

		if (pdc_get_cmd_result() != PDC_CMD_RSLT_PROGRESS) {
			uCtrlCnf2.usData = smbs_get_ctrl_conf2();
			if (   (guCtrlCnf2_bak.bit.bSrcMaxPwr != uCtrlCnf2.bit.bSrcMaxPwr)
			    || (guCtrlCnf2_bak.bit.bSrcPdoMax != uCtrlCnf2.bit.bSrcPdoMax)) {
				ULONG ulPwr = 30000U; // Max power
				UCHAR  ucNum = 4U;     // Max num of PDOs
				
				if (   (uCtrlCnf2.bit.bSrcMaxPwr != 0U  )
				    && (uCtrlCnf2.bit.bSrcMaxPwr <= 240U)) {
					ulPwr = (ULONG)uCtrlCnf2.bit.bSrcMaxPwr * 250U;
				}
				
				if (   (uCtrlCnf2.bit.bSrcPdoMax != 0U)
				    && (uCtrlCnf2.bit.bSrcPdoMax <= 4U)) {
					ucNum = uCtrlCnf2.bit.bSrcPdoMax;
				}

				if (gusSVID == 0x05AC) {
					if ((ulPwr / 15000) >= 3U) {
						ucNum = 4U;
					}
					else if ((ulPwr / 12000) >= 3U) {
						ucNum = 3U;
					}
					else if ((ulPwr / 9000) >= 3U) {
						ucNum = 2U;
					}
					else {
						ucNum = 1U;
					}
				}
				if (uStatus.bit.bPlug == 0U) {
					ucNum = 1U;
				}

				pdc_set_src_conf(ulPwr, ucNum, 1, PDC_NOPD_CUR_3_0A);
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
		else if (ucType == 0x81) {//Send Slave's Volt/Curr to Master
			usBuf[0] = pdc_get_req_cur();
			usBuf[1] = pdc_get_req_volt();
			usBuf[2] = gMpPb.uStat.bit.bResetDcdcComp;
			usBuf[3] = 0U;
			ucSize = 8U;
		}
		else if (ucType == 0x82) {
			usBuf[0] = (USHORT)(gBatInfo.uSt2.bTrickle & 0x01U);//Send to master 
			usBuf[1] = 0U;
			ucSize = 4U;
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
		else if (ucType == 0x80) {
			gMpPb.othPortInfo.bit.bPlugState     = (UCHAR)(usBuf[0]        & 0x0001);
			gMpPb.othPortInfo.bit.bPowerRole     = (UCHAR)((usBuf[0] >> 1) & 0x0001);
			gMpPb.othPortInfo.bit.bBatIsTrickle  = (UCHAR)((usBuf[0] >> 2) & 0x0001);
			gMpPb.othPortInfo.bit.bAttachOrder   = (UCHAR)((usBuf[0] >> 3) & 0x0001);
			gMpPb.othPortInfo.bit.bResetDcdcComp = (UCHAR)((usBuf[0] >> 4) & 0x0001);

			gMpPb.othPortInfo.usNegoCur  = (usBuf[1] & 0x00FF) * 256 + ((usBuf[0] >> 8) & 0x00FF);
			gMpPb.othPortInfo.usNegoVolt = (usBuf[2] & 0x00FF) * 256 + ((usBuf[1] >> 8) & 0x00FF);

			if (uStatus.bit.bPlug == 1U) {//Slave is plugin then Note Slave DCDC to update regeister
				if (uStatus.bit.bPR != 0) {//Slave:Att.SRC
					if (gBatInfo.uSt.bSt != BATTERY_EMPTY) {
						gMpPb.uEvent.bit.bSrcChg = 1U;
					}
				}
				else {//Slave:Att.SNK
					if (gMpPb.uStat.bit.bWaitingSet1stDcdc != 0U) {
						if ( (gMpPb.othPortInfo.bit.bResetDcdcComp != 0U)) {
							gMpPb.gulPSRC1 = isl95538b_get_psrc_other();//1st Att.Snk
							gMpPb.gulPSRC2 = isl95538b_get_psrc_local();//2nd Att.Snk
							gMpPb.gulPBATC = isl95538b_get_pdatc();
							if (gMpPb.gulPSRC1 >= gMpPb.gulPBATC) {
								gMpPb.uStat.bit.bChgEn = 0U;
							}
							else {
								gMpPb.uStat.bit.bChgEn = 1U;
								if (gMpPb.othPortInfo.bit.bBatIsTrickle == 1U) {
									gMpPb.uStat.bit.bChgEn = 0U;
								}
							}
							gMpPb.uEvent.bit.bSnkChg  = 1U;
							gMpPb.uStat.bit.bWaitingSet1stDcdc = 0U;
						}
						else {
							gMpPb.uEvent.bit.bSnkChg = 0U;
						}
					}
					else {
						if (   (gMpPb.othPortInfo.bit.bPlugState != 0U)
							&& (gMpPb.othPortInfo.bit.bPowerRole == 0U)) {

							if (gMpPb.othPortInfo.bit.bAttachOrder == 1U) { //Master-2nd, Slave-1st
								gMpPb.gulPSRC1 = isl95538b_get_psrc_local();//1st Att.Snk
								gMpPb.gulPSRC2 = isl95538b_get_psrc_other();//2nd Att.Snk
								gMpPb.gulPBATC = isl95538b_get_pdatc();
								if ((gMpPb.gulPSRC1 < gMpPb.gulPBATC) 
									&& (gMpPb.gulPSRC2 >= gMpPb.gulPBATC)) {
									gMpPb.uStat.bit.bResetDcdcComp = 0U;									
									gMpPb.uEvent.bit.bResetDcdcComp = 0U;
									gMpPb.uEvent.bit.bSnkChg = 1U;
									if(gBatInfo.uSt2.bTrickle == 0U){
										gMpPb.uStat.bit.bChgEn = 0U;
									}
								}
								else {									
									gMpPb.uStat.bit.bChgEn = 1U;
									gMpPb.uStat.bit.bResetDcdcComp = 1U;
									gMpPb.uEvent.bit.bResetDcdcComp = 1U;
									gMpPb.uEvent.bit.bSnkChg = 1U;
								}
							}
							else { //Master-1st, Slave-2nd
								gMpPb.gulPSRC1 = isl95538b_get_psrc_other();//1nd Att.Snk
								gMpPb.gulPSRC2 = isl95538b_get_psrc_local();//2st Att.Snk
								gMpPb.gulPBATC = isl95538b_get_pdatc();
								if ((gMpPb.gulPSRC1 >= gMpPb.gulPBATC)
									&& (gMpPb.gulPSRC2 < gMpPb.gulPBATC)
									&& (gMpPb.othPortInfo.bit.bBatIsTrickle == 0U)) {
									gMpPb.uStat.bit.bChgEn = 0U;
									gMpPb.uStat.bit.bResetDcdcComp = 0U;
									gMpPb.uEvent.bit.bResetDcdcComp = 0U;
									gMpPb.uEvent.bit.bSnkChg = 1U;
								}
								else {
									gMpPb.uStat.bit.bChgEn = 1U;
									gMpPb.uStat.bit.bResetDcdcComp = 1U;
									gMpPb.uEvent.bit.bResetDcdcComp = 1U;
									gMpPb.uEvent.bit.bSnkChg = 1U;
								}
							}
						}
						else {
							gMpPb.uStat.bit.bChgEn = 1U;
							gMpPb.uStat.bit.bResetDcdcComp = 0U;
							gMpPb.uEvent.bit.bResetDcdcComp = 0U;
							gMpPb.uEvent.bit.bSnkChg = 1U;
						}
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
