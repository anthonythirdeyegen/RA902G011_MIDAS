#include "user_main_battery.h"
#include "interrupt.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "r_cg_userdefine.h"
#include "R9A02G011PDC.h"
#include "mppm.h"
#include "subdev_ctrl.h"
#include "R9A02G011SMBS.h"
#include "slave_pdc.h"
#include "user_timer.h"
#include "mppm_pb_defs.h"
#include "dcdc_ctrl.h"
#include "user_main.h"
#include "led_ctrl.h"
#include "pd_defs.h"
#include "mppm_pb_defs.h"

MPPM_INFO		gMppmInfo;
ALERT_INFO		gMppmAlert;
OTH_PORT_INFO   tmpPortInfo;

extern	UCHAR		gucDrSwapMode_bak;
extern	UCHAR		gucPrSwapMode_bak;
extern	UCHAR		gucInputPwr_bak;
extern	SMBS_CCNF1	guCtrlCnf1_bak;
extern	SMBS_CCNF2	guCtrlCnf2_bak;
extern USHORT gusSVID;

void mppm_initialize_port(UCHAR targetport);
void mppm_get_alert(void);
void mppm_chk_trickle(void);
void mppm_chk_slv_reset_dcdc(void);
//	void mppm_get_alert(ALERT_INFO *alertInfo);
UCHAR mppm_chk_dev_en_chkStart(UCHAR id);
UCHAR mppm_chk_dev_en_chkError(UCHAR id);
UCHAR mppm_chk_dev_en_chkDone(UCHAR id);
void mppm_get_status(const UCHAR mppm_dev[]);
void mppm_plug_change(void);

void set_other_port_info(void);
void mppm_nego_func(void);
void mppm_update_newpwr(UCHAR targetport);
void mppm_update_portPwr(void);
void mppm_set_subdev(UCHAR dev_id, UCHAR **rflg, void **data);
UCHAR mppm_get_remainAmp(USHORT portPwr);

/******************************************************************************
// const values
******************************************************************************/
const UCHAR mppm_dev[MPPM_PORT_NUM_MAX] = { 0U, SLAVEPDC_DEVICE_ID};

/* Mppm initialization */
void init_mppm (void)
{
	/* global variable initialization */

	/* Set Master Status */
	gMppmInfo.portInfo[MPPM_PORT_MASTER].ucStPort.bit.bGetStatus = MPPM_PORT_ST_INIT_GETSTAT;
	gMppmInfo.portInfo[MPPM_PORT_MASTER].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_ETC_FUNCTION;
	gMppmInfo.portInfo[MPPM_PORT_MASTER].ucReqflg   = 0U;
	gMppmInfo.portInfo[MPPM_PORT_MASTER].usPortPwr  = MPPM_INIT_PWR_MAX_P250;
	gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle  = 1U;

	/* Set Slave Status */
	gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucStPort.bit.bGetStatus  = MPPM_PORT_ST_INIT_GETSTAT;
	gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_ETC_FUNCTION;
	gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucReqflg     = 0U;
	gMppmInfo.portInfo[MPPM_PORT_SLAVE1].usPortPwr    = MPPM_INIT_PWR_MAX_P250;		// 250mW units
	gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle  = 1U;
	
	gMppmAlert.usAlert[MPPM_PORT_MASTER].usData = 0U;
	gMppmAlert.usAlert[MPPM_PORT_SLAVE1].usData = 0U;
	
	gMppmAlert.usAlert[MPPM_PORT_MASTER].usData = 0U;
	gMppmAlert.usAlert[MPPM_PORT_SLAVE1].usData = 0U;

	/* SPM_CONF: bit0-1 Internal SPM Mode, bit2-3 Slave PDC num, bit4-15 System power(250mW Unit) */
	gMppmInfo.usRemaingPwr  = MPPM_MAX_SYSTEM_PWR - (MPPM_INIT_PWR_MAX_P250 * MPPM_PORT_NUM_MAX);	// (250mW unit) 

	gMppmInfo.ucChkTrickleState = CHK_TRICKLE_IDLE;
	gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_SET_OBJMODE1;
	
	gMppmInfo.ucCommErrCnt[MPPM_PORT_MASTER] = 0U;
	gMppmInfo.ucCommErrCnt[MPPM_PORT_SLAVE1] = 0U;
}

UCHAR mppm(void)
{

	/* Get Alert */
	mppm_get_alert();

	if (gMppmInfo.ucStateFlag.bit.bChkAlert == 1U) {
		/* Get Status */
		mppm_get_status(mppm_dev);
	}
	else if (	(gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgSrc != 0U)
			 ||	(gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgSrc != 0U)) {
		mppm_plug_change();
	}
	else if ((gDCInfo.uReq.usData == 0U)
			&& (   (gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgDcdc != 0U) 
				|| (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgDcdc != 0U))) {
		set_other_port_info();
	}
	else if (	(gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bNewReq != 0U)
			 ||	(gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bNewReq != 0U)) {
		mppm_nego_func();
	}
	else if (	(gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgPwr != 0U)
			 ||	(gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgPwr != 0U)
			 ||	(gMppmInfo.portInfo[MPPM_PORT_MASTER].ucStPort.bit.bFuncStatus == MPPM_PORT_ST_WAI_VENCOM_CHGPWR)
			 ||	(gMppmInfo.portInfo[MPPM_PORT_MASTER].ucStPort.bit.bFuncStatus == MPPM_PORT_ST_INIT_VENCOM_CHGPWR)
			 ||	(gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucStPort.bit.bFuncStatus == MPPM_PORT_ST_WAI_VENCOM_CHGPWR)
			 ||	(gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucStPort.bit.bFuncStatus == MPPM_PORT_ST_INIT_VENCOM_CHGPWR)) {
		mppm_update_portPwr();
	}
	else if (   (gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChkTrickle != 0U)
	         || (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChkTrickle != 0U)) {
		mppm_chk_trickle();
	}
	else if (gMpPb.uStat.bit.bWaitingSet1stDcdc != 0U) {
		mppm_chk_slv_reset_dcdc();
	}
	else {
		/* do nothing */
	}

	return PD_CORE_ACTIVE;
}

void mppm_initialize_port(UCHAR targetport)
{
	// Init Port Status 
	gMppmInfo.portInfo[targetport].ucStPort.bit.bGetStatus = MPPM_PORT_ST_INIT_GETSTAT;
	gMppmInfo.portInfo[targetport].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_ETC_FUNCTION;
	gMppmInfo.portInfo[targetport].ucReqflg = 0U;

	gMppmAlert.usAlert[targetport].usData = 0U;
}

void mppm_get_alert(void)
{
	/* Get Alert value */
	if (   (gPdc.uPdEvent.usData != 0U)
	    || ((gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucReqflg & MPPM_ALERT) != 0U) ) {

		if (gPdc.uPdEvent.usData != 0U) {
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bPlugChg		|= gPdc.uPdEvent.bit.bPlugChg;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bPrChg			|= gPdc.uPdEvent.bit.bPrChg;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bDrChg			|= gPdc.uPdEvent.bit.bDrChg;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bNewContract   |= gPdc.uPdEvent.bit.bNewContract;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bNewRequest	|= gPdc.uPdEvent.bit.bNewRequest;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bChkRcvPDM		|= gPdc.uPdEvent.bit.bChkRcvPDM;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bHardReset		|= gPdc.uPdEvent.bit.bHardReset;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bSoftReset		|= gPdc.uPdEvent.bit.bSoftReset;
			gMppmAlert.usAlert[MPPM_PORT_MASTER].bit.bErr			|= gPdc.uPdEvent.bit.bErr;

			gMppmInfo.portInfo[MPPM_PORT_MASTER].ucReqflg |= MPPM_ALERT;
		}

		if ((gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucReqflg & MPPM_ALERT) != 0U) {
			/* Store alert into global variable   */
			gMppmAlert.usAlert[MPPM_PORT_SLAVE1].usData |= gMppmInfo.usAlertData;
		}

		// Not go into interrupt again
		if (gMppmInfo.ucStateFlag.bit.bChkAlert == 1U) {
			gMppmInfo.ucStateFlag.bit.bReChkAlert = 1U;
		}
		else {
			gMppmInfo.ucStateFlag.bit.bChkAlert = 1U;
		}
	}
}

void mppm_chk_slv_reset_dcdc(void) {
	switch (gMppmInfo.usChkSlvDcdcState) {
		case CHK_SLV_RESET_DCDC_WAI_OBJMODE1:
			if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
				if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {
					if (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp != 0U) {											// chk SetComp
						gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp = 0U;
						// Read ObjectData
						mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_GET_SELFPORTDATA, 0);								// Read Object Mode(Self Volt/Curr)
						gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_WAI_OBJDATA1;
					}
					else {
						if (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bReSetting != 0U) {											// chk ReSetting
							gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bReSetting = 0U;												// clr ReSetting	
							gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_WAI_OBJMODE1;		// reGet ObjDataMode
						}
					}
				}
				else {//Error
					gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_WAI_OBJMODE1;
				}
			}
			break;
		case CHK_SLV_RESET_DCDC_WAI_OBJDATA1:
			if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
				if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {
					gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp = 0U;													// clr SetComp
					gMpPb.othPortInfo.bit.bResetDcdcComp = gMppmInfo.ulPortData.usData[2];

					if ((gMpPb.othPortInfo.bit.bResetDcdcComp != 0U)) {
						gMpPb.uStat.bit.bWaitingSet1stDcdc = 0U;
						gMpPb.uEvent.bit.bSnkChg = 1U;
					}
					gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_SET_OBJMODE1;
				}
				else { /* Error */
					// Read ObjectData
					mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_GET_SELFPORTDATA, 0);									// Read Object Mode
					gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_WAI_OBJDATA1;
				}
			}
			break;
		default: //CHK_SLV_RESET_DCDC_SET_OBJMODE1
			// Write ObjectDataMode
			// Data Position=0, Object Data Size= 8, Object Data Mode=0(read), Recipient=1(SOP), Object Data Select=0x81(Read portData Volt and Curr)
			gMppmInfo.ulObjDataMode.ulData = 0x00080181U;
			mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_SET_OBJDATAMODE, 0);						// ObjectDataMode
			gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_WAI_OBJMODE1;
			break;

	}
}
void mppm_chk_trickle(void)
{
	PD_STATUS	uStatus;

	uStatus = pdc_get_status();

	switch (gMppmInfo.ucChkTrickleState) {
		case CHK_TRICKLE_MST_WAI_POLL:
			if (pd_tm_chk_user_stat(TM_ID_USER2, 300U) == TM_ST_OVR) {
				pd_tm_stop_user_cnt(TM_ID_USER2);
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_MST_WAI_RSLT;
			}
			break;
		case CHK_TRICKLE_MST_WAI_RSLT:
			if (uStatus.bit.bPlug != 0U && gBatInfo.uSt2.bTrickle != 0) {
				gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle = 1U;
				gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle = 1U;
				pd_tm_start_user_cnt(TM_ID_USER2);
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_MST_WAI_POLL;
			}
			else {
				gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle = 0U;
				gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle = 0U;
				//Slave ATT.SNK, update Master otherPortInfo first
				gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChkTrickle = 0U;
				gMpPb.othPortInfo.bit.bBatIsTrickle = 0U;

				if (gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bAttSnk != 0) {
					gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bGetSnkData = 1U;
					gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgDcdc = 1U;
				}
				else {
					gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bGetSnkData = 0U;
					gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgDcdc = 1U;
				}
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_IDLE;
			}
			break;
		case CHK_TRICKLE_SLV_WAI_POLL:
			if (pd_tm_chk_user_stat(TM_ID_USER2, 300U) == TM_ST_OVR) {
				pd_tm_stop_user_cnt(TM_ID_USER2);
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_SET_OBJMOD;
			}
			break;
		case CHK_TRICKLE_SLV_SET_OBJMOD:
			// Write ObjectDataMode
			// Data Position=0, Object Data Size= 4, Object Data Mode=0(read), Recipient=1(SOP), Object Data Select=0x82(Read trickle status)
			gMppmInfo.ulObjDataMode.ulData = 0x00040182U;
			mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_SET_OBJDATAMODE, 0);						// ObjectDataMode
			gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_WAI_OBJMOD;
			break;
		case CHK_TRICKLE_SLV_WAI_OBJMOD:
			if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
				if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {
					if (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp != 0U) {							// chk SetComp
						gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp = 0U;
						// Read ObjectData
						mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_GET_TRICKLE_STATE, 0);		// Read Object Mode(Self Volt/Curr)
						gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_WAI_OBJDATA;
					}
					else {
						if (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bReSetting != 0U) {					// chk ReSetting
							gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bReSetting = 0U;						// clr ReSetting	
							gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_SET_OBJMOD;						// reGet ObjDataMode
						}
					}
				}
				else {//Error
					gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_SET_OBJMOD;
				}
			}
			break;
		case CHK_TRICKLE_SLV_WAI_OBJDATA:
			if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
				if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {
					gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bSetComp = 0U;									// clr SetComp
					gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_GET_OBJDATA;
				}
				else { /* Error */
					   // Read ObjectData
					mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_GET_TRICKLE_STATE, 0);						// Read Object Mode(RDO)
					gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_WAI_OBJDATA;
				}
			}
			break;
		case CHK_TRICKLE_SLV_GET_OBJDATA:
			if ((gMppmInfo.ulPortData.usData[0] & 0x0001) != 0) {
				gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle = 1U;
				gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle = 1U;

				if (gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bAttSnk == 0) {
					gMppmInfo.ucChkTrickleState = CHK_TRICKLE_IDLE;
				}
				else {
					pd_tm_start_user_cnt(TM_ID_USER2);
					gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_WAI_POLL;
				}
			}
			else{
				gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle = 0U;
				gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle = 0U;
				//Master ATT.SNK, send Master portInfo to Slave
				gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChkTrickle = 0U;
				gMpPb.othPortInfo.bit.bBatIsTrickle = 0U;

				if (gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bAttSnk != 0) {
					gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bGetSnkData = 1U;
					gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgDcdc = 1U;
					gMpPb.uEvent.bit.bSnkChg = 1U;
				}
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_IDLE;
			}
			break;
		default://CHK_TRICKLE_IDLE
			pd_tm_start_user_cnt(TM_ID_USER2);

			if (gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChkTrickle != 0) {
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_MST_WAI_POLL;
			}
			else {
				gMppmInfo.ucChkTrickleState = CHK_TRICKLE_SLV_WAI_POLL;
			}
			break;
	}
}

UCHAR mppm_chk_dev_en_chkDone(UCHAR id)
{
	return ((id == MPPM_PORT_MASTER) || (gSubdevInfo.ucSubdevFlag & mppm_dev[id]) == 0U) ? 1U :0U;
}

UCHAR mppm_chk_dev_en_chkError(UCHAR id)
{
	return ((id == MPPM_PORT_MASTER) || (gSubDevErr.ucSubdev & mppm_dev[id]) == 0U) ? 1U :0U;
}

void mppm_get_status(const UCHAR mppm_dev[])
{
	UCHAR i;
	PD_STATUS uStatus;
	
	for (i = 0U; i < MPPM_PORT_NUM_MAX; i++) {
		switch (gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus) {
	        case MPPM_PORT_ST_EXCUTE_RD_STATUS :
				/* Wait Getting Slave port's Status1 & 2 */
				if (mppm_chk_dev_en_chkDone(i) == 1U) {
					if (mppm_chk_dev_en_chkError(i) == 1U) {
						if ((gMppmInfo.portInfo[i].ucReqflg & ~MPPM_ALERT) == MPPM_GET_STATUS1) {

							if (i != 0) {
								if (gMppmAlert.usAlert[i].bit.bCmdComp != 0U) {	
									gMppmAlert.usAlert[i].bit.bCmdComp = 0U;
									if (gMppmInfo.usRegData[i].bit_st1.bLastCmd ==0U) {				// chk OK
										gMppmInfo.portEvent[i].bit.bCmdComp = 1U;
									}
									else if (gMppmInfo.usRegData[i].bit_st1.bLastCmd ==4U)	{			// chk WAIT
										gMppmInfo.portEvent[i].bit.bCmdComp = 2U;
									}
									else {
										gMppmInfo.portEvent[i].bit.bCmdComp = 3U;
									}
								}
							}
							if (gMppmAlert.usAlert[i].bit.bPlugChg != 0U) {
								gMppmAlert.usAlert[i].bit.bPlugChg = 0U;

								// Plug In/Out Check
								if (gMppmInfo.usRegData[i].bit_st1.bPlugDet == 1U) {
									// PlugIn
									if (gMppmInfo.usRegData[i].bit_st1.bPR == 1U) {
										gMppmInfo.portEvent[i].bit.bChgSrc = 1U;				// set ChgSrc
										gMppmInfo.portEvent[i].bit.bSrcEn = 1U;					// set SrcEn
									}
									if (i == MPPM_PORT_MASTER) {
										tmpPortInfo.bit.bPlugState = 1U;
										tmpPortInfo.bit.bAttachOrder = gMpPb.othPortInfo.bit.bPlugState;
									}
									else { //slave Plugin
										gMpPb.othPortInfo.bit.bPlugState = 1U;
										gMpPb.othPortInfo.bit.bAttachOrder = tmpPortInfo.bit.bPlugState;
										gMpPb.othPortInfo.bit.bPowerRole = gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st1.bPR;

										if (gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st1.bPR == 0U) {//slave ATT.SNK
											mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SET_DCDC);
										}
									}
								}
								else {
									// UnPlug
									gMppmInfo.portEvent[i].bit.bChgSrc = 1U;				// set ChgSrc
									gMppmInfo.portEvent[i].bit.bSrcEn = 0U;					// clr SrcEn
									gMppmInfo.portInfo[i].portFlag.bit.bAttSnk = 0U;
									gMppmInfo.portInfo[i].portFlag.bit.bGetSnkData = 1U;
									gMppmInfo.portEvent[i].bit.bChgDcdc = 1U;
									tmpPortInfo.bit.bAttachOrder = 0U;       
									gMpPb.othPortInfo.bit.bAttachOrder = 0U; 

									if (gMppmInfo.portInfo[1 - i].portFlag.bit.bAttSnk == 1U) {
										gMppmInfo.portInfo[i].portFlag.bit.bTrickle = gMppmInfo.portInfo[1-i].portFlag.bit.bTrickle;
									}
									else {
										gMppmInfo.portInfo[i].portFlag.bit.bTrickle = 1U;
										gMppmInfo.portInfo[1-i].portFlag.bit.bTrickle = 1U;
									}

									if (i == MPPM_PORT_MASTER) {
										tmpPortInfo.bit.bPlugState = 0U;
										gMpPb.uStat.bit.bWaitingSet1stDcdc = 0U;
										gMppmInfo.usChkSlvDcdcState = CHK_SLV_RESET_DCDC_SET_OBJMODE1;
									}
									else { //slave unplug
										gMpPb.othPortInfo.bit.bPlugState = 0U;   
									}

									if ((gMppmInfo.portInfo[i].portFlag.bit.bAttSnk == 0U) && (gMppmInfo.portInfo[1 - i].portFlag.bit.bAttSnk == 0U)) {
										gMppmInfo.portEvent[i].bit.bChkTrickle = 0U;
										gMppmInfo.portEvent[1-i].bit.bChkTrickle = 0U;
										gMppmInfo.ucChkTrickleState = CHK_TRICKLE_IDLE;
									}
								}
								/* Set 2PB System PowerRole for LLED */
								if ((gMppmInfo.usRegData[i].bit_st1.bPlugDet == 0U) && (gMppmInfo.usRegData[1-i].bit_st1.bPlugDet == 0U)) {
										gLed.uSt.bits.bSysAttRole = SYS_PR_UNPLUG;
								}
								else {
									if (   ((gMppmInfo.usRegData[i].bit_st1.bPlugDet   != 0U) && (gMppmInfo.usRegData[i].bit_st1.bPR   == 1U))
										|| ((gMppmInfo.usRegData[1-i].bit_st1.bPlugDet != 0U) && (gMppmInfo.usRegData[1-i].bit_st1.bPR == 1U))) {
										gLed.uSt.bits.bSysAttRole = SYS_PR_ATT_SRC;
									}
									else {
										gLed.uSt.bits.bSysAttRole = SYS_PR_ATT_SNK;
									}
								}
							}
							else if (gMppmAlert.usAlert[i].bit.bPrChg != 0U) {
								gMppmAlert.usAlert[i].bit.bPrChg = 0U;
								gMppmInfo.portEvent[i].bit.bChgSrc = 1U;					// set ChgSrc
								if (i == MPPM_PORT_SLAVE1) {
									gMpPb.othPortInfo.bit.bPowerRole = gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st1.bPR;
								}
								// Power Role Check
								if (gMppmInfo.usRegData[i].bit_st1.bPR == 1U) {
									// sink -> source
									gMppmInfo.portEvent[i].bit.bSrcEn = 1U;					// set SrcEn
								}
								else {
									// source -> sink
									gMppmInfo.portEvent[i].bit.bSrcEn = 0U;					// clr SrcEn
									gMppmInfo.portInfo[i].portFlag.bit.bTrickle = 1U;
								}

								if (i == MPPM_PORT_MASTER) {
									gMpPb.othPortInfo.bit.bAttachOrder = 0U; //Force Slave attach order to 1st
									tmpPortInfo.bit.bAttachOrder = gMpPb.othPortInfo.bit.bPlugState;
								}
								else { //slave Plugin
									tmpPortInfo.bit.bAttachOrder = 0U;      //Force Master attach order to 1st
									gMpPb.othPortInfo.bit.bAttachOrder = tmpPortInfo.bit.bPlugState;
								}
							}
							else if (gMppmAlert.usAlert[i].bit.bNewContract != 0U) {
								gMppmAlert.usAlert[i].bit.bNewContract = 0U;
								if (gMppmInfo.usRegData[i].bit_st1.bPR == 0) {//Att.Sink
									gMppmInfo.portInfo[i].portFlag.bit.bAttSnk = 1U;
									gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_ETC_FUNCTION;									
									gMppmInfo.portInfo[i].portFlag.bit.bGetSnkData = 1U;
									gMppmInfo.portEvent[i].bit.bChgDcdc = 1U;

									if ((gMppmInfo.portInfo[1-i].portFlag.bit.bAttSnk == 0U) && (gMppmInfo.portInfo[i].portFlag.bit.bTrickle != 0U)) {
										gMppmInfo.portEvent[i].bit.bChkTrickle = 1U;
									}
									
									if ((i == MPPM_PORT_MASTER) 
										&& (gMpPb.othPortInfo.bit.bPlugState != 0U)
										&& (gMpPb.othPortInfo.bit.bPowerRole == 0U)
										&& (gMpPb.othPortInfo.bit.bAttachOrder == 0U)
										&& (gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChkTrickle == 0U)){
										gMpPb.uStat.bit.bWaitingSet1stDcdc = 1U;
									}
								}
							}
							/* Check New Request */
							else if (gMppmAlert.usAlert[i].bit.bNewRequest != 0U) {
								gMppmAlert.usAlert[i].bit.bNewRequest = 0U;
								gMppmInfo.portEvent[i].bit.bNewReq = 1U;					// set NewReq
								gMppmInfo.portEvent[i].bit.bSrcEn = 1U;						// set SrcEn
							}
							else if (gMppmAlert.usAlert[i].bit.bHardReset != 0) {
								gMppmAlert.usAlert[i].bit.bHardReset = 0U;
							}

						}
						else if ((gMppmInfo.portInfo[i].ucReqflg & ~MPPM_ALERT) == MPPM_GET_STATUS2) {
								 	
							if (gMppmInfo.usRegData[i].bit_st2.bObjSelErr == 1U) {
								gMppmInfo.portEvent[i].bit.bReSetting = 1U;					// set ReSetting
								gMppmInfo.portEvent[i].bit.bSetComp = 0U;					// clr SetComp
							}
							if (i == MPPM_PORT_SLAVE1) {
								if (gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bUsrEvtEn != 0U) {
									gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bUsrEvtEn = 0U;
									//check user status:status2 bit10-13 
									if (gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st2.bRstPr != 0U) {
										pdc_set_port_conf(PDC_ROLE_DRP_DRD_TSRC, PDC_ACS_VCONN);
										pdc_set_cmd(PDC_CMD_ENA_TYPEC_CTRL, 0);
									}
									if (gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st2.bNonPDPlugIn != 0U) {
										gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bGetSnkData = 1U;
										gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgDcdc = 1U;
										if (   (gMpPb.othPortInfo.bit.bPlugState == 1U)
											&& (gMpPb.othPortInfo.bit.bPowerRole == 0U)) { //NonPD-SNK
											gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bAttSnk = 1U;
											gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_ETC_FUNCTION;
											uStatus = pdc_get_status();
											if (   (uStatus.bit.bPlug == 0U)
												|| ((uStatus.bit.bPlug == 1U) && (uStatus.bit.bPR == 1U))
												&& (gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle != 0U)) {
												gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChkTrickle = 1U;
											}
										}
									}

									if (gMppmInfo.usRegData[MPPM_PORT_SLAVE1].bit_st2.bSetTrickle != 0U) {
										gMpPb.othPortInfo.bit.bBatIsTrickle = 1U;
										gMpPb.uEvent.bit.bSnkChg = 1U;
										gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChkTrickle = 1U;
									}
								}
							}

							if ((gMppmInfo.usRegData[i].bit_st2.bOverCur == 1U) ||
								(gMppmInfo.usRegData[i].bit_st2.bOverTemp == 1U)) {
								// Over Current or Over Temperature
								gMppmInfo.portEvent[i].bit.bSrcEn = 0U;						// clr SrcEn
								gMppmInfo.portEvent[i].bit.bSetComp = 0U;					// clr SetComp
							} 
							else {
								// Get Status1
								mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_STATUS1, 0);
								gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_EXCUTE_RD_STATUS;
								gMppmInfo.portEvent[i].bit.bCompStatus = 1U;				// set CompStatus
								break;
							}
						}
						gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_END_GETSTAT;
						gMppmInfo.portEvent[i].bit.bCompStatus = 0U;					// clr CompStatus
						gMppmInfo.ucCommErrCnt[i] = 0U;
					}
					else { /* Error */					
						gMppmInfo.ucCommErrCnt[i] += 1;
						if (gMppmInfo.ucCommErrCnt[i] >= 3) {         //Resend Completed because of 3 times error
							gMppmInfo.ucCommErrCnt[i] = 0U;
							gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_END_GETSTAT;
							gMppmInfo.portEvent[i].bit.bCompStatus = 0U;					// clr CompStatus							
						}
						else {										
							if ((gMppmInfo.portInfo[i].ucReqflg & ~MPPM_ALERT) == MPPM_GET_STATUS1) {
								// Get Status1
								mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_STATUS1, 0);
								gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_EXCUTE_RD_STATUS;
								gMppmInfo.portEvent[i].bit.bCompStatus = 1U;					// set CompStatus
							}
							else if ((gMppmInfo.portInfo[i].ucReqflg & ~MPPM_ALERT) == MPPM_GET_STATUS2) {
								// Get Status2
								mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_STATUS2, 0);
								gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_EXCUTE_RD_STATUS;
								gMppmInfo.portEvent[i].bit.bCompStatus = 1U;					// set CompStatus
							}							
						}									
					}
				}
				break;
			case MPPM_PORT_ST_END_GETSTAT :
			default :
				if ((gMppmInfo.portInfo[i].ucReqflg & MPPM_ALERT) != 0U) {
					// Clear Alert Interrupt Flag
					gMppmInfo.portInfo[i].ucReqflg &= ~MPPM_ALERT;

					if ((gMppmAlert.usAlert[i].bit.bErr != 0) || (gMppmAlert.usAlert[i].bit.bUsrEvt != 0)) {
						gMppmAlert.usAlert[i].bit.bErr = 0U;
						if (gMppmAlert.usAlert[i].bit.bUsrEvt != 0) {
							gMppmAlert.usAlert[i].bit.bUsrEvt = 0U;
							if (i == MPPM_PORT_SLAVE1) {
								gMppmInfo.portInfo[i].portFlag.bit.bUsrEvtEn = 1U;
							}
						}
						/* Get Status2 flag */
						mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_STATUS2, 0);
					}
					else {
						/* Get Status1 flag */
						mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_STATUS1, 0);
					}

					if (gMppmAlert.usAlert[i].bit.bObjDataRdy != 0U) {
						gMppmAlert.usAlert[i].bit.bObjDataRdy = 0U;
						gMppmInfo.portEvent[i].bit.bSetComp = 1U;					// set SetComp
					}
					
					gMppmInfo.portEvent[i].bit.bCompStatus = 1U;					// set CompStatus
					gMppmInfo.portInfo[i].ucStPort.bit.bGetStatus = MPPM_PORT_ST_EXCUTE_RD_STATUS;
				}
				break;
		}
	}
	if (	(gMppmInfo.portEvent[0].bit.bCompStatus == 0U)
		&&	(gMppmInfo.portEvent[1].bit.bCompStatus == 0U)) {
		// get Status over
		if (gMppmInfo.ucStateFlag.bit.bReChkAlert == 1) {
			gMppmInfo.ucStateFlag.bit.bReChkAlert = 0U;
		}
		else {
			gMppmInfo.ucStateFlag.bit.bChkAlert = 0U;
		}
	}
}

void mppm_plug_change(void)
{
	UCHAR i;
	UCHAR ucRp;
	SMBS_VENCOM regVenCom;
	
	regVenCom.data = 0U;
	for (i = 0U; i < MPPM_PORT_NUM_MAX; i++) {

		switch (gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus) {
			case MPPM_PORT_ST_EXCUTE_VENCOM_CHGSRC:
				gMppmInfo.usRemaingPwr += gMppmInfo.portInfo[i].usPortPwr;
				// Check Rp Mode
				switch (regVenCom.bit.bRpMode) {
					case 0:		// 00b:HIGH_C
						ucRp = 30U;	// 3A
						break;
					case 1:		// 01b:MID_C
						ucRp = 15U;	// 1.5A
						break;
					case 2:		// 10b:DEF_C
					default:
						ucRp = 9U;	// 0.9A
						break;
				}
				gMppmInfo.portInfo[i].usPortPwr = ucRp * 2U;		// 250mW units (((ucRp * 5U) / 10U) * 4U)
				gMppmInfo.usRemaingPwr -= gMppmInfo.portInfo[i].usPortPwr;
			
				if ((i+1) == gMppmInfo.ucStateFlag.bit.bPortNego) {
					gMppmInfo.ucStateFlag.bit.bPortNego = 0U;
				}
				gMppmInfo.portEvent[i].bit.bPortWait = 0U;													// clr PortWait
				gMppmInfo.portEvent[i].bit.bPwrSave = 0U;													// clr PwrSave
				gMppmInfo.portEvent[i].bit.bReReq = 0U;														// clr ReReq

				gMppmInfo.portEvent[i].bit.bChgPwr = 1U;													// set ChgPwr
				gMppmInfo.portEvent[i].bit.bChgSrc = 0U;													// clr ChgSrc
				break;

			case MPPM_PORT_ST_END_VENCOM_CHGSRC:
			default:
				if (gMppmInfo.portEvent[i].bit.bChgSrc != 0U) {												// chk ChgSrc
					if (gMppmInfo.portEvent[i].bit.bSrcEn != 0U) {											// chk SrcEn
						gMppmInfo.portEvent[i].bit.bChgPwr = 1U;											// set ChgPwr
						gMppmInfo.portEvent[i].bit.bChgSrc = 0U;											// clr ChgSrc
					}
					else { /* UnPlug */
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_EXCUTE_VENCOM_CHGSRC;
					}
				}
				break;
		}
	}
}

void set_other_port_info(void)
{
	UCHAR  i;
	USHORT usOperCurTmp;
	USHORT usNegoVoltTmp;
	PD_STATUS uStatus;
	
	for (i = 0; i < MPPM_PORT_NUM_MAX; i++) {
		if (gMppmInfo.portEvent[i].bit.bChgDcdc != 0U) {	

			if(gMppmInfo.portInfo[i].portFlag.bit.bChkInit == 0) {
				if (gMppmInfo.portInfo[i].portFlag.bit.bGetSnkData != 0) {
					switch (gMppmInfo.portInfo[i].ucSetPortInfoStatus) {
						case MPPM_PORT_ST_PORTINFO_SET_OBJMODE1:
							// Write ObjectDataMode
							// Data Position=0, Object Data Size= 8, Object Data Mode=0(read), Recipient=1(SOP), Object Data Select=0x81(Read portData Volt and Curr)
							gMppmInfo.ulObjDataMode.ulData = 0x00080181U;
							mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_OBJDATAMODE, 0);						// ObjectDataMode
							gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_WAI_OBJMODE1;
							break;
						case MPPM_PORT_ST_PORTINFO_WAI_OBJMODE1:
							if (mppm_chk_dev_en_chkDone(i) == 1U) {
								if (mppm_chk_dev_en_chkError(i) == 1U) {
									if (gMppmInfo.portEvent[i].bit.bSetComp != 0U) {											// chk SetComp
										gMppmInfo.portEvent[i].bit.bSetComp = 0U;
										// Read ObjectData
										mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_SELFPORTDATA, 0);								// Read Object Mode(Self Volt/Curr)
										gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_WAI_OBJDATA1;
									}
									else {
										if (gMppmInfo.portEvent[i].bit.bReSetting != 0U) {											// chk ReSetting
											gMppmInfo.portEvent[i].bit.bReSetting = 0U;												// clr ReSetting	
											gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE1;		// reGet ObjDataMode
										}
									}
									gMppmInfo.ucCommErrCnt[i] = 0U;
								}
								else {//Error
									gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE1;
									gMppmInfo.ucCommErrCnt[i] += 1;
									if (gMppmInfo.ucCommErrCnt[i] >= 3) {         //Resend Completed because of 3 times error
										gMppmInfo.portEvent[i].bit.bChgDcdc = 0U; //Stop Resending Message
										gMppmInfo.portInfo[i].portFlag.bit.bChkInit = 0;
										gMppmInfo.ucCommErrCnt[i] = 0U;
									}
									else {
										gMppmInfo.portEvent[i].bit.bChgDcdc = 1U; //Continue to Send Message
									}
								}
							}
							break;
						case MPPM_PORT_ST_PORTINFO_WAI_OBJDATA1:
							if (mppm_chk_dev_en_chkDone(i) == 1U) {
								if (mppm_chk_dev_en_chkError(i) == 1U) {
									gMppmInfo.portEvent[i].bit.bSetComp = 0U;													// clr SetComp
									gMppmInfo.portInfo[i].portFlag.bit.bGetSnkData = 0;
									gMppmInfo.portInfo[i].usNegoCurr = gMppmInfo.ulPortData.usData[0];
									gMppmInfo.portInfo[i].usNegoVolt = gMppmInfo.ulPortData.usData[1];
									gMppmInfo.portInfo[i].portFlag.bit.bResetDcdcComp = gMppmInfo.ulPortData.usData[2];
									gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE2;
									gMppmInfo.portInfo[i].portFlag.bit.bChkInit = 1;
								}
								else { /* Error */
									   // Read ObjectData
									mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_SELFPORTDATA, 0);									// Read Object Mode
									gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_WAI_OBJDATA1;
								}
							}
							break;
						default :
							gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE1;
							break;
					}
				}
				else {
					gMppmInfo.portInfo[i].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE2;
					gMppmInfo.portInfo[i].portFlag.bit.bChkInit = 1;
				}
			}
		
			if(gMppmInfo.portInfo[i].portFlag.bit.bChkInit != 0) {
				if (i == MPPM_PORT_MASTER) {//Send Master's PortInfo to Slave
					switch (gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus) {
						case MPPM_PORT_ST_PORTINFO_SET_OBJMODE2:
							// Write ObjectDataMode
							// Data Position=0, Object Data Size= 8, Object Data Mode=1(write), Recipient=1(SOP), Object Data Select=80(Send PortInfo to Slave)
							gMppmInfo.ulObjDataMode.ulData = 0x00088180U;
							mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_SET_OBJDATAMODE, 0);
							gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_WAI_OBJMODE2;
							break;
						case MPPM_PORT_ST_PORTINFO_WAI_OBJMODE2:
							if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
								if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {
									if (tmpPortInfo.bit.bPlugState == 1U) {
										tmpPortInfo.bit.bPowerRole = gMppmInfo.usRegData[MPPM_PORT_MASTER].bit_st1.bPR;
										tmpPortInfo.bit.bBatIsTrickle = gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle;
										tmpPortInfo.bit.bResetDcdcComp = gMpPb.uStat.bit.bResetDcdcComp;
									}
									else {
										tmpPortInfo.bit.bPowerRole = 0U;
										tmpPortInfo.bit.bBatIsTrickle = gMppmInfo.portInfo[MPPM_PORT_MASTER].portFlag.bit.bTrickle;
										tmpPortInfo.bit.bResetDcdcComp = 0U;
									}

									gMppmInfo.ulPortData.ucData[0] =    (tmpPortInfo.bit.bPlugState              & 0x01)
																		| ((tmpPortInfo.bit.bPowerRole     << 1) & 0x02) 
																		| ((tmpPortInfo.bit.bBatIsTrickle  << 2) & 0x04) 
																		| ((tmpPortInfo.bit.bAttachOrder   << 3) & 0x08)
																		| ((tmpPortInfo.bit.bResetDcdcComp << 4) & 0x10);

									if (tmpPortInfo.bit.bPlugState == 1U) {
										usOperCurTmp = gMppmInfo.portInfo[MPPM_PORT_MASTER].usNegoCurr;
										gMppmInfo.ulPortData.ucData[1] = (UCHAR)(usOperCurTmp & 0x00FF);
										gMppmInfo.ulPortData.ucData[2] = (UCHAR)((usOperCurTmp >> 8) & 0x00FF);

										usNegoVoltTmp = gMppmInfo.portInfo[MPPM_PORT_MASTER].usNegoVolt;
										gMppmInfo.ulPortData.ucData[3] = (UCHAR)(usNegoVoltTmp & 0x00FF);
										gMppmInfo.ulPortData.ucData[4] = (UCHAR)((usNegoVoltTmp >> 8) & 0x00FF);
									}
									else {
										gMppmInfo.ulPortData.ucData[1] = 0U;
										gMppmInfo.ulPortData.ucData[2] = 0U;
										gMppmInfo.ulPortData.ucData[3] = 0U;
										gMppmInfo.ulPortData.ucData[4] = 0U;
									}

									mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_SET_PORTINFODATA, 0);
									gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_WAI_OBJDATA2;
									gMppmInfo.ucCommErrCnt[i] = 0U;
								}
								else { //Error
									gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE2;
									gMppmInfo.ucCommErrCnt[i] += 1;
									if (gMppmInfo.ucCommErrCnt[i] >= 3) {         //Resend Completed because of 3 times error
										gMppmInfo.portEvent[i].bit.bChgDcdc = 0U; //Stop Resending Message
										gMppmInfo.portInfo[i].portFlag.bit.bChkInit = 0;
										gMppmInfo.ucCommErrCnt[i] = 0U;
									}
									else {
										gMppmInfo.portEvent[i].bit.bChgDcdc = 1U; //Continue to Send Message
									}
								}
							}
							break;
						case MPPM_PORT_ST_PORTINFO_WAI_OBJDATA2:
							if (mppm_chk_dev_en_chkDone(MPPM_PORT_SLAVE1) == 1U) {
								if (mppm_chk_dev_en_chkError(MPPM_PORT_SLAVE1) == 1U) {//send otherPortInfo to slave success
									gMppmInfo.portEvent[MPPM_PORT_MASTER].bit.bChgDcdc       = 0U;
									gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE1;
									gMppmInfo.portInfo[i].portFlag.bit.bChkInit              = 0;
								}
								else {//Error
									//Resend object data to slave
									mppm_snd_smbs_command(mppm_dev[MPPM_PORT_SLAVE1], MPPM_SET_PORTINFODATA, 0);
								}
							}
							break;
						default:
							gMppmInfo.portInfo[MPPM_PORT_MASTER].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE2;
							break;
					}
				}
				else {//MPPM_PORT_SLAVE1
					gMppmInfo.portEvent[MPPM_PORT_SLAVE1].bit.bChgDcdc = 0U;
					uStatus = pdc_get_status();
					if (gMpPb.othPortInfo.bit.bPlugState == 1U) {
						gMpPb.othPortInfo.bit.bBatIsTrickle  = gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle;
						gMpPb.othPortInfo.bit.bResetDcdcComp = gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bResetDcdcComp;
						gMpPb.othPortInfo.usNegoVolt         = gMppmInfo.portInfo[MPPM_PORT_SLAVE1].usNegoVolt;
						gMpPb.othPortInfo.usNegoCur          = gMppmInfo.portInfo[MPPM_PORT_SLAVE1].usNegoCurr;
					}
					else {
						gMpPb.othPortInfo.bit.bPowerRole = 0U;
						gMpPb.othPortInfo.bit.bBatIsTrickle  = gMppmInfo.portInfo[MPPM_PORT_SLAVE1].portFlag.bit.bTrickle;
						gMpPb.othPortInfo.bit.bResetDcdcComp = 0U;
						gMpPb.othPortInfo.usNegoVolt         = 0U;
						gMpPb.othPortInfo.usNegoCur          = 0U;
					}

					if ((gMpPb.othPortInfo.bit.bAttachOrder != 0) || (gMpPb.othPortInfo.bit.bPlugState == 0U)) {//Slave Port 2nd attached, Note Master DCDC to update regeister
						if (uStatus.bit.bPR != 0) {//Master:Att.SRC
							if (gBatInfo.uSt.bSt != BATTERY_EMPTY) {
								gMpPb.uEvent.bit.bSrcChg = 1U;
							}
						}
						else {//Master:Att.SNK
							gMpPb.uEvent.bit.bSnkChg = 1U;
						}
					}
					gMppmInfo.portInfo[MPPM_PORT_SLAVE1].ucSetPortInfoStatus = MPPM_PORT_ST_PORTINFO_SET_OBJMODE1;
					gMppmInfo.portInfo[i].portFlag.bit.bChkInit = 0;
				}
			}
		}
	}
	
}

void mppm_nego_func(void)
{
	UCHAR i, j;
	SMBS_CCNF2 uCtrlCnf2;
	UCHAR		masterCmdRlt;
	
	uCtrlCnf2.usData = 0U;

	for (i = 0U; i < MPPM_PORT_NUM_MAX; i++) {

		switch (gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus) {
			case MPPM_PORT_ST_WAI_VENCOM_NEWREQ:
				if (mppm_chk_dev_en_chkDone(i) == 1U) {
					if (mppm_chk_dev_en_chkError(i) == 1U) {
						if (gMppmInfo.portEvent[i].bit.bSetComp != 0U) {											// chk SetComp
							gMppmInfo.portEvent[i].bit.bSetComp = 0U;
							// Read ObjectData
							mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_RDODATA, 0);								// Read Object Mode(RDO)
							gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_RD_VENCOM_NEWREQ;
						}
						else {
							if (gMppmInfo.portEvent[i].bit.bReSetting != 0U) {											// chk ReSetting
								gMppmInfo.portEvent[i].bit.bReSetting = 0U;												// clr ReSetting	
								gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;		// reGet ObjDataMode
							}
						}
					}
					else { /* Error */
						gMppmInfo.portEvent[i].bit.bNewReq = 0U;														// clr NewReq
						gMppmInfo.ucStateFlag.bit.bPortNego = 0U;
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;
					}
				}
				break;

			case MPPM_PORT_ST_RD_VENCOM_NEWREQ:
				if (mppm_chk_dev_en_chkDone(i) == 1U) {
					if (mppm_chk_dev_en_chkError(i) == 1U) {
						gMppmInfo.portEvent[i].bit.bSetComp = 0U;														// clr SetComp
						mppm_update_newpwr(i);
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_UPDPWR;
					}
					else { /* Error */
						// Read ObjectData
						mppm_snd_smbs_command(mppm_dev[i], MPPM_GET_RDODATA, 0);									// Read Object Mode(RDO)
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_RD_VENCOM_NEWREQ;
					}
				}
				break;

			case MPPM_PORT_ST_WAI_VENCOM_UPDPWR:
				if (mppm_chk_dev_en_chkDone(i) == 1U) {
					if (mppm_chk_dev_en_chkError(i) == 1U) {
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_UPDPWR_X;
					}
					else { /* Error */
						switch (gMppmInfo.portInfo[i].ucPortResult) {
							case MPPM_CNT_REQRES_ACCEPT:
								if (i == 0) {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_ACPT);
								}
								else {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_ACPT);
								}
								break;
							case MPPM_CNT_REQRES_REJECT:
								if (i == 0) {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_RJCT);
								}
								else {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_RJCT);
								}
								break;
							case MPPM_CNT_REQRES_WAIT:
								if (i == 0) {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_WAIT);
								}
								else {
									mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_WAIT);
								}
								break;
						}
					}
				}
				break;
			case MPPM_PORT_ST_WAI_VENCOM_UPDPWR_X:
				if (i == MASTER_DEVICE_ID) {
					masterCmdRlt = pdc_get_cmd_result();
					
					gMppmInfo.portEvent[i].bit.bCmdComp = 0U;
					if (masterCmdRlt == PDC_CMD_RSLT_PROGRESS) {
						break;
					}
					else if (masterCmdRlt == PDC_CMD_RSLT_SUCCESS) {
						gMppmInfo.portEvent[i].bit.bCmdComp = 1U;
					}
					else if (masterCmdRlt == PDC_CMD_RSLT_BUSY) {
						gMppmInfo.portEvent[i].bit.bCmdComp = 2U;
					}
					else {
						gMppmInfo.portEvent[i].bit.bCmdComp = 3U;
					}					
				}
					
				if (gMppmInfo.portEvent[i].bit.bCmdComp == 1U) {													// chk OK
					if (   (gMppmInfo.portInfo[i].ucPortResult == MPPM_CNT_REQRES_ACCEPT)
					    && (gMppmInfo.portInfo[i].portFlag.bit.bSetPortInfoComp == 0)){
						//Start to set otherPort info
						gMppmInfo.portEvent[i].bit.bChgDcdc = 1U;
						gMppmInfo.portInfo[i].portFlag.bit.bGetSnkData = 0;
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_SET_PORTINFO;
						break;
					}
					gMppmInfo.portInfo[i].portFlag.bit.bSetPortInfoComp = 0;
					gMppmInfo.portEvent[i].bit.bCmdComp = 0U;
					gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;
					gMppmInfo.portEvent[i].bit.bNewReq = 0U;														// clr NewReq
					if (	(gMppmInfo.portInfo[i].ucPortResult == MPPM_CNT_REQRES_ACCEPT)
						||	(gMppmInfo.portInfo[i].ucPortResult == MPPM_CNT_REQRES_REJECT)) {
						gMppmInfo.ucStateFlag.bit.bPortNego = 0U;						
						for (j = 0U; j < MPPM_PORT_NUM_MAX; j++) {
							if (gMppmInfo.portEvent[i].bit.bPortWait != 0U) {										// chk PortWait
								gMppmInfo.portEvent[i].bit.bPortWait = 0U;											// clr PortWait
								gMppmInfo.ucStateFlag.bit.bPortNego = (j + 1);										// next nego
								gMppmInfo.portInfo[j].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;
								break;
							}
						}
					}
					else if (gMppmInfo.portInfo[i].ucPortResult == MPPM_CNT_REQRES_WAIT) {
						// bSrcMaxPwr=00, bExtPwrCnst=0, bExtPwrACDC=0, bIntrPwrType=0, bSrcPdoMax=0
						uCtrlCnf2.usData = 0U;
						uCtrlCnf2.bit.bSrcMaxPwr = gMppmInfo.portInfo[i].usPortPwr;
						mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_CTRLCNF2, uCtrlCnf2.usData);
						gMppmInfo.portInfo[j].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;
					}
					else {
						;
					}
				}
				else if (gMppmInfo.portEvent[i].bit.bCmdComp == 2U) {							// chk WAIT
					gMppmInfo.portEvent[i].bit.bCmdComp = 0U;
					gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_UPDPWR;
					switch (gMppmInfo.portInfo[i].ucPortResult) {
						case MPPM_CNT_REQRES_ACCEPT:
							if (i == 0) {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_ACPT);
							}
							else {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_ACPT);
							}
							break;
						case MPPM_CNT_REQRES_REJECT:
							if (i == 0) {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_RJCT);
							}
							else {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_RJCT);
							}
							break;
						case MPPM_CNT_REQRES_WAIT:
							if (i == 0) {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, PDC_CMD_SND_WAIT);
							}
							else {
								mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_COMMAND, SMBM_CMD_SND_WAIT);
							}
							break;
					}
				}
				else if (gMppmInfo.portEvent[i].bit.bCmdComp == 3U) {
					gMppmInfo.portEvent[i].bit.bCmdComp = 0U;
					gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_NEWREQ;
				}
				else {
					;
				}
				break;
			case MPPM_PORT_ST_WAI_VENCOM_SET_PORTINFO:
				if(gMppmInfo.portEvent[i].bit.bChgDcdc == 0U){
					gMppmInfo.portInfo[i].portFlag.bit.bSetPortInfoComp = 1;
					gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_UPDPWR_X;
				}
				break;
			case MPPM_PORT_ST_END_VENCOM_NEWREQ:
			default:
				if (gMppmInfo.portEvent[i].bit.bNewReq != 0U) {										// chk NewReq
					if ((gMppmInfo.ucStateFlag.bit.bPortNego == 0U) ||
					    (gMppmInfo.ucStateFlag.bit.bPortNego == (i + 1))) {
						gMppmInfo.ucStateFlag.bit.bPortNego = (i + 1);
					    gMppmInfo.portEvent[i].bit.bPortWait = 0U;												// clr PortWait
						// Write ObjectDataMode
						// Data Position=0, Object Data Size= 4, Object Data Mode=0(read), Recipient=1(SOP), Object Data Select=9(SMBS_OBJ_SEL_RDO_TMP)
						gMppmInfo.ulObjDataMode.ulData = 0x00040109U;
						mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_OBJDATAMODE, 0);
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_NEWREQ;
					}
					else {
						gMppmInfo.portEvent[i].bit.bPortWait = 1U;												// set PortWait
					}
				}
				break;
		}
	}
}

void mppm_update_newpwr(UCHAR targetport)
{
	USHORT rdoPwr;
	UCHAR objPosition;
	ULONG calcTemp;
	USHORT reg_data;
	PDO   uPdoTmp;

	uPdoTmp.ulData = pdc_get_pdo(gMppmInfo.ulRdoInfo[0].bit_pps.bObjPos,PDC_PDO_SRC, PDC_PDO_SND);
	if ((targetport == MPPM_PORT_SLAVE1) && (uPdoTmp.ulData == 0)) {
		switch (gMppmInfo.ulRdoInfo[0].bit_pps.bObjPos) {
			case 2  : uPdoTmp.ulData = PD_SRC_PDO2; break;
			case 3  : uPdoTmp.ulData = PD_SRC_PDO3; break;
			case 4  : uPdoTmp.ulData = PD_SRC_PDO4; break;
			case 5  : uPdoTmp.ulData = PD_SRC_PDO5; break;
			case 6  : uPdoTmp.ulData = PD_SRC_PDO6; break;
			case 7  : uPdoTmp.ulData = PD_SRC_PDO7; break;
			default : uPdoTmp.ulData = 0x2B01912CU; break;
		}
	}
	
	reg_data = 0U;
	gMppmInfo.usRemaingPwr += gMppmInfo.portInfo[targetport].usPortPwr;
	gMppmInfo.portEvent[targetport].bit.bPwrSave = 0U;													// clr PwrSave

	// calc remainPower
	objPosition = gMppmInfo.ulRdoInfo[0].bit_pps.bObjPos - 1U;

	if (objPosition < 4) {
		// APDO
		// Curr(10mA units) * B19-B10,Volt(50mV units)
		objPosition = gMppmInfo.ulRdoInfo[0].bit.bObjPos - 1U;
		calcTemp = (ULONG)gMppmInfo.ulRdoInfo[0].bit.bMinMax * uPdoTmp.stFixSrc.bVolt;

	}
	else {
		// PPS (APDO)
		if (gMppmInfo.portEvent[targetport].bit.bReReq == 0U) {					// chk ReReq
			/* First time */
			// Curr(50mA units) * B24-B17,APDO's MaxVolt(100mV units)
			objPosition = gMppmInfo.ulRdoInfo[0].bit_pps.bObjPos - 1U;
			calcTemp = (ULONG)(uPdoTmp.stPpsSrc.bMaxCur * 5U) * (uPdoTmp.stPpsSrc.bMaxVolt * 2U);
		}
		else {
			// Curr(50mA units) * B24-B17,APDO's MaxVolt(100mV units)
			calcTemp = (ULONG)(gMppmInfo.ulRdoInfo[0].bit_pps.bCur * 5U) * (uPdoTmp.stPpsSrc.bMaxVolt * 2U);
		}
	}
	rdoPwr = (USHORT)(calcTemp / (ULONG)MPPM_SYS_PWR_P05_DIVUNIT);

	if (rdoPwr <= gMppmInfo.usRemaingPwr) {
		gMppmInfo.portInfo[targetport].usPortPwr = rdoPwr;
		gMppmInfo.usRemaingPwr -= rdoPwr;
		gMppmInfo.portInfo[targetport].ucPortResult = MPPM_CNT_REQRES_ACCEPT;

		if (gMppmInfo.portEvent[targetport].bit.bReReq != 0U) {											// chk ReReq
			gMppmInfo.portEvent[targetport].bit.bPwrSave = 1U;											// set PwrSave
		}
		gMppmInfo.portEvent[targetport].bit.bReReq = 0U;												// clr ReReq
		reg_data = PDC_CMD_SND_ACPT;
		if (targetport == 1) {
			reg_data = SMBM_CMD_SND_ACPT;
		}
		// Temporary
		gMppmInfo.portInfo[targetport].usNegoVolt = uPdoTmp.stFixSrc.bVolt * 50U;
		gMppmInfo.portInfo[targetport].usNegoCurr = gMppmInfo.ulRdoInfo[0].bit.bMinMax * 10U;
	}
	else {
		if (gMppmInfo.portEvent[targetport].bit.bReReq != 0U) {											// chk ReReq
			gMppmInfo.portInfo[targetport].usPortPwr    = MPPM_INIT_PWR_MAX_P250;						// 15.0W[250mW UNIT]
			gMppmInfo.portInfo[targetport].ucPortResult = MPPM_CNT_REQRES_REJECT;
			reg_data = PDC_CMD_SND_RJCT;
			if (targetport == 1) {
				reg_data = SMBM_CMD_SND_RJCT;
			}
		}
		else {
			gMppmInfo.portInfo[targetport].usPortPwr    = gMppmInfo.usRemaingPwr;
			gMppmInfo.portInfo[targetport].ucPortResult = MPPM_CNT_REQRES_WAIT;
			gMppmInfo.portEvent[targetport].bit.bReReq  = 1U;											// set ReReq
			reg_data = PDC_CMD_SND_WAIT;
			if (targetport == 1) {
				reg_data = SMBM_CMD_SND_WAIT;
			}
		}
		gMppmInfo.usRemaingPwr -= gMppmInfo.portInfo[targetport].usPortPwr;
	}
	mppm_snd_smbs_command(mppm_dev[targetport], MPPM_SET_COMMAND, reg_data);

}

void mppm_update_portPwr(void)
{
	UCHAR i;
	SMBS_CCNF2 uCtrlCnf2;

	uCtrlCnf2.usData = 0U;
	for (i = 0U; i < MPPM_PORT_NUM_MAX; i++) {
		switch (gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus) {
			case MPPM_PORT_ST_WAI_VENCOM_CHGPWR:
				if (mppm_chk_dev_en_chkDone(i) == 1U) {
					if (mppm_chk_dev_en_chkError(i) == 1U) {
						gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_INIT_VENCOM_CHGPWR;
					}
					else { /* Error */
						// bSrcMaxPwr=00, bExtPwrCnst=0, bExtPwrACDC=0, bIntrPwrType=0, bSrcPdoMax=0
						uCtrlCnf2.usData = 0U;
						mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_CTRLCNF2, uCtrlCnf2.usData);
					}
				}
				break;
			case MPPM_PORT_ST_INIT_VENCOM_CHGPWR:
				/* UnPlug */
				if (gMppmInfo.portEvent[i].bit.bUnPlug != 0U) {													// chk UnPlug
					gMppmInfo.portEvent[i].bit.bUnPlug = 0U;													// clr UnPlug					
					// Init Port Status
					mppm_initialize_port(i);
				}
				gMppmInfo.portEvent[i].bit.bChgPwr = 0U;														// clr ChgPwr
				gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_END_VENCOM_CHGPWR;
				break;
			case MPPM_PORT_ST_END_VENCOM_CHGPWR:
			default:
				if (gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus != MPPM_PORT_ST_END_VENCOM_CHGPWR) {
					if (gMppmInfo.portEvent[i].bit.bChgPwr != 0U) {													// chk ChgPwr
						if (gMppmInfo.portEvent[i].bit.bSrcEn != 0U) {												// chk SrcEn
							gMppmInfo.portEvent[i].bit.bChgPwr = 0U;												// clr ChgPwr
						}
						else {
							/* UnPlug */
							gMppmInfo.portEvent[i].bit.bUnPlug = 1U;												// set UnPlug
							// bSrcMaxPwr=00, bExtPwrCnst=0, bExtPwrACDC=0, bIntrPwrType=0, bSrcPdoMax=0
							uCtrlCnf2.usData = 0U;
							mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_CTRLCNF2, uCtrlCnf2.usData);
							gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_CHGPWR;
						}
					}
					else {
						if (gMppmInfo.portEvent[i].bit.bPwrSave != 0U) {											// chk PwrSave
							gMppmInfo.portEvent[i].bit.bPwrSave = 0U;												// clr PwrSave
							// bSrcMaxPwr=00, bExtPwrCnst=0, bExtPwrACDC=0, bIntrPwrType=0, bSrcPdoMax=0
							uCtrlCnf2.usData = 0U;
							mppm_snd_smbs_command(mppm_dev[i], MPPM_SET_CTRLCNF2, uCtrlCnf2.usData);
							gMppmInfo.portInfo[i].ucStPort.bit.bFuncStatus = MPPM_PORT_ST_WAI_VENCOM_CHGPWR;
						}
					}
				}
				break;
		}
	}
}

void mppm_snd_smbs_command(UCHAR dev_id, UCHAR command, USHORT reg_data)
{
	SMBS_CCNF2 uCtrlCnf2;
	PD_STATUS	uStatus;

	if(dev_id == MASTER_DEVICE_ID) {

		gMppmInfo.portInfo[0].ucReqflg &= MPPM_ALERT;
		gMppmInfo.portInfo[0].ucReqflg |= command;
		
		switch (command) {
			case MPPM_SET_COMMAND:
				pdc_set_cmd(reg_data, PDC_TARGET_SOP);
				break;
			case MPPM_SET_CTRLCNF2:
				{
					PD_STATUS uStatus   = pdc_get_status();
					UCHAR ucInputPwr = 0U;
					UCHAR ucErr = 0U;
					uCtrlCnf2.usData = reg_data;

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

						// Intrusive = 1 (Valid)
						pdc_set_src_conf(ulPwr, ucNum, 1, PDC_NOPD_CUR_3_0A);
					}

					ucInputPwr |= gucInputPwr_bak & (PDC_SYS_INTR_PWR_BAT | PDC_SYS_INTR_PWR_NONBAT);
					ucInputPwr |= gucInputPwr_bak & (PDC_SYS_UNCNST_PWR | PDC_SYS_EXT_PWR_DC | PDC_SYS_EXT_PWR_AC);

					if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR != 0U) && (ucErr == 0U)) { // ATT.SRC
						if (   (guCtrlCnf2_bak.bit.bSrcMaxPwr  != uCtrlCnf2.bit.bSrcMaxPwr)
						    || (guCtrlCnf2_bak.bit.bSrcPdoMax  != uCtrlCnf2.bit.bSrcPdoMax)) {
							pdc_set_cmd(PDC_CMD_SND_SRC_CAP, PDC_TARGET_SOP);
						}
					}
					guCtrlCnf2_bak.usData = uCtrlCnf2.usData;
				}
				break;
			case MPPM_GET_RDODATA:
				gMppmInfo.ulRdoInfo[0].ulData = pdc_get_rdo(PDC_RDO_SND_RCV);
				break;
			case MPPM_GET_SELFPORTDATA:
				gMppmInfo.ulPortData.usData[0] = pdc_get_req_cur();
				gMppmInfo.ulPortData.usData[1] = pdc_get_req_volt();
				gMppmInfo.ulPortData.usData[2] = gMpPb.uStat.bit.bResetDcdcComp;

				break;
			case MPPM_GET_TRICKLE_STATE:
				gMppmInfo.ulPortData.ucData[0] = (UCHAR)(gBatInfo.uSt2.bTrickle & 0x01U);
				break;
			case MPPM_GET_STATUS1:
				uStatus = pdc_get_status();
				gMppmInfo.usRegData[0].usData = 0;	
				gMppmInfo.usRegData[0].bit_st1.bSOPP	= uStatus.bit.bSOPP;
				gMppmInfo.usRegData[0].bit_st1.bSOPPP	= uStatus.bit.bSOPPP;
				gMppmInfo.usRegData[0].bit_st1.bPlugDet	= uStatus.bit.bPlug;
				gMppmInfo.usRegData[0].bit_st1.bDR		= uStatus.bit.bDR;
				gMppmInfo.usRegData[0].bit_st1.bPR		= uStatus.bit.bPR;
				break;
			case MPPM_GET_STATUS2:
				uStatus = pdc_get_status();
				gMppmInfo.usRegData[0].usData = 0;			
				gMppmInfo.usRegData[0].bit_st2.bRjctNego	= uStatus.bit.bRjctNego;
				gMppmInfo.usRegData[0].bit_st2.bNonPD		= uStatus.bit.bNonPD;
				gMppmInfo.usRegData[0].bit_st2.bMisCap		= uStatus.bit.bMissCap;
				gMppmInfo.usRegData[0].bit_st2.bComRevPDC	= uStatus.bit.bComRevPDC;
				gMppmInfo.usRegData[0].bit_st2.bComRevCP	= uStatus.bit.bComRevCP;
				break;
			case MPPM_SET_OBJDATAMODE:
				gMppmInfo.portEvent[0].bit.bSetComp = 1U;
			default:
				break;
		}
	}
	else {
		/* For Slave PDC */
		gMppmInfo.portInfo[1].ucReqflg &= MPPM_ALERT;
		gMppmInfo.portInfo[1].ucReqflg |= command;

		switch (command) {
			case MPPM_SET_OBJDATAMODE:
			case MPPM_SET_COMMAND:
			case MPPM_SET_CTRLCNF2:
				gMppmInfo.usRegData[1].usData = reg_data;
			case MPPM_GET_STATUS1:
			case MPPM_GET_STATUS2:
				gMppmInfo.ucCmd = command;
				break;
			case MPPM_GET_RDODATA:
				gMppmInfo.ucCmd = command;
				gMppmInfo.ulRdoInfo[0].ulData = 0U;
				break;
			case MPPM_SET_PORTINFODATA:
				gMppmInfo.ucCmd = command;
				break;
			case MPPM_GET_SELFPORTDATA:
				gMppmInfo.ucCmd = command;
				gMppmInfo.ulPortData.ulData[0] = 0U;
				break;
			case MPPM_GET_TRICKLE_STATE:
				gMppmInfo.ucCmd = command;
				gMppmInfo.ulPortData.usData[0] = 0U;
				break;
			default:
				break;
		}
		gSubdevInfo.ucSubdevFlag |= SLAVEPDC_DEVICE_ID;
	}
}

UCHAR mppm_get_remainAmp(USHORT portPwr)
{
	UCHAR ucRemaingAmp;
	UCHAR ucRp;

	// ucRemaingAmp = Empty Port/5V
	ucRemaingAmp = (((portPwr / 4U) / 5) * 10U);
	if (ucRemaingAmp > 15U) {
		ucRp = 0U;			// 00b:HIGH_C // 3A 
	}
	else if (ucRemaingAmp > 9U) {
		ucRp = 1U;			// 01b:MID_C // 1.5A 
	}
	else {
		ucRp = 2U;			// 11b:DEF_C // 0.9A 
	}
	return ucRp;
}

