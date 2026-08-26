#include "smbm_ctrl.h"
#include "r_cg_macrodriver.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#endif
#include "user_timer.h"
#include "r_cg_userdefine.h"
#include "R9A02G011PDC.h"
#include "interrupt.h"
#include "subdev_ctrl.h"

#define SMBM_INT_ALERT_EN	(0)	// SMBus Master Alert# interrupt (1: Enable, 0 : Disable)

typedef union
{
	USHORT WD;
	struct{
		unsigned char no0:1;
		unsigned char no1:1;
		unsigned char no2:1;
		unsigned char no3:1;
		unsigned char no4:1;
		unsigned char no5:1;
		unsigned char no6:1;
		unsigned char no7:1;
		unsigned char no8:1;
		unsigned char no9:1;
		unsigned char no10:1;
		unsigned char no11:1;
		unsigned char no12:1;
		unsigned char no13:1;
		unsigned char no14:1;
		unsigned char no15:1;
	}WD_bit;
} __SMBM_WD;

SMBM_INFO gSmbmInfo;

/******************************************************************************
 Private fanctions
******************************************************************************/
// for SMBM Interrupt
void smbm_int_write_routine(void);
void smbm_int_read_routine(void);
void smbm_copy_word(USHORT *src, USHORT *dst, UINT uiLength);

/******************************************************************************
 Initialize smbm_ctrl module
******************************************************************************/
void smbm_init(void)
{
	gSmbmInfo.ucSmbmStatus  = SMBM_CTRL_STATE_IDLE;
	gSmbmInfo.ucSmbmCtrl    = 0U;
	gSmbmInfo.usSmbmTimeOut = 0U;
	gSmbmInfo.pusSmbmData   = 0U;
	gSmbmInfo.usSmbmDataLen = 0U;
	gSmbmInfo.ucSmbmError   = 0U;
	gSmbmInfo.ucAlertFlg    = 0U;

	PER2 |= PER2_SMBM;
	
#if SMBM_INT_ALERT_EN == 1
	SMBMINT = SMBMINT_ALERT_STATUS;
#else
	SMBMINT = SMBMINT_ALL_CLEAR;
#endif
	pdc_set_int_routine(intID_INTSMBMST, (ULONG)NULL);

	SMBMSTMK = 0U;

	return;
}

/******************************************************************************
 SMBus Master Handler
******************************************************************************/
void smbm_ctrl(void)
{
	UCHAR ucCntrl=0;

	if( ((subdev_get_alert_signal() == 0U) || ((SMBMSTA & 0x0100) != 0U)) && 
		(gSubdevInfo.ucSubdevAlertFlag == 0U) &&
		(gSmbmInfo.ucAlertFlg == 0U) ){
		if(subdev_get_alerthandler() != 0U){
			gSubdevInfo.ucSubdevAlertFlag = 0xFF;
		}
	}

	switch(gSmbmInfo.ucSmbmStatus){
		case SMBM_CTRL_STATE_READY:

			// set timer for time out
			// run smbm by req.
			if(gSmbmInfo.ucSmbmCtrl == SMBM_I2C_START){
				// Whithout CLK Stretch
				ucCntrl = SMBMCON_I2C_RUN_STOP | SMBMCON_LAST_PACKET;
			}
			else if(gSmbmInfo.ucSmbmCtrl == SMBM_I2C_CLK_STRETCH_START){
				// Whith CLK Stretch
				ucCntrl = SMBMCON_I2C_RUN_STOP ;
			}
			else{
				// Run as SMBus
				ucCntrl = SMBMCON_SMB_RUN;
			}
			// go to ACTIVE State
			gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_ACTIVE;
			// Start SMBus
			SMBMCON = (USHORT)((gSmbmInfo.usSmbmDataLen - 1)<<8)|(ucCntrl);

			if( gSmbmInfo.usSmbmTimeOut != 0U){
				pd_tm_start_user_cnt(TM_ID_USER1);
			}
			break;
		case SMBM_CTRL_STATE_ACTIVE:
			if( gSmbmInfo.usSmbmTimeOut != 0x00){
				if (pd_tm_chk_user_stat(TM_ID_USER1, gSmbmInfo.usSmbmTimeOut) == TM_ST_OVR) {
					pd_tm_stop_user_cnt(TM_ID_USER1);
					gSmbmInfo.usSmbmTimeOut--;
					if(gSmbmInfo.usSmbmTimeOut == 0x00){
						SMBMCON = (USHORT)(SMBMCON_I2C_STOP);
						gSmbmInfo.ucSmbmError = SMBM_ERROR_TIMEOUT;
						gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_ERROR;
					}
					else{
						pd_tm_start_user_cnt(TM_ID_USER1);
					}
				}
			}
			break;
		case SMBM_CTRL_STATE_STRECH_READY:
			if(gSmbmInfo.ucSmbmCtrl == SMBM_I2C_START){
				// last packet
				ucCntrl = SMBMCON_I2C_RUN_STOP | SMBMCON_LAST_PACKET | SMBMCON_I2C_RESTART;
			}
			else if(gSmbmInfo.ucSmbmCtrl == SMBM_I2C_CLK_STRETCH_START){
				// restart
				ucCntrl = SMBMCON_I2C_RUN_STOP | SMBMCON_I2C_RESTART;
			}
			else{
				ucCntrl = SMBMCON_I2C_STOP;
			}
			// go to ACTIVE State
			gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_ACTIVE;

			SMBMCON = (USHORT)((gSmbmInfo.usSmbmDataLen - 1)<<8)|(ucCntrl);
			if( gSmbmInfo.usSmbmTimeOut != 0x00){
				pd_tm_start_user_cnt(TM_ID_USER1);
			}
			break;
		default:
			break;
	}
	return;
}

/******************************************************************************
 Set subdev info
******************************************************************************/
void smbm_set_subdev(UCHAR ucCLKMode, UCHAR ucSlaveAddr)
{
	// Set subdev info (clock mode & slave addr to SMBMADD)
	if (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_IDLE) {
		SMBMADD = (USHORT)(ucCLKMode << 8) | (USHORT)ucSlaveAddr;
	}

	return;
}

/******************************************************************************
 Set protocol info
******************************************************************************/
void smbm_set_protocol(UCHAR ucCmdCode, UCHAR ucSmbmProtocol, UCHAR ucPEC,
						UCHAR ucOption, USHORT *pusData,
						USHORT usDataLen, USHORT usTimeOut)
{
	__SMBM_WD stSMBMINT;
	stSMBMINT.WD = SMBMINT;

	if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_IDLE) ||
		(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH) ){
		// Set smbm protocol
		SMBMCOM = (USHORT)(ucCmdCode << 8) | (USHORT)(ucPEC << 7) | (USHORT)(ucSmbmProtocol);
		gSmbmInfo.usSmbmDataLen = usDataLen;
		gSmbmInfo.pusSmbmData = pusData;
		gSmbmInfo.ucSmbmCtrl = ucOption;

		if((ucSmbmProtocol & SMBMP_I2C_MASK) == NULL){
			// This Protocol is Write
			UINT i=0 , count= (gSmbmInfo.usSmbmDataLen + 1)/2;
			USHORT usSMBDAT= (USHORT)&SMBMDAT0_LW;
			for (i=0; i<count; i++)
			{
				(*(volatile __near USHORT *)usSMBDAT) = pusData[i];
				usSMBDAT = usSMBDAT + 2;
			}
			pdc_set_int_routine(intID_INTSMBMST, (ULONG)&smbm_int_write_routine);
		}
		else{
			pdc_set_int_routine(intID_INTSMBMST, (ULONG)&smbm_int_read_routine);
		}

		if(gSmbmInfo.ucSmbmCtrl == SMBM_I2C_CLK_STRETCH_START){
			stSMBMINT.WD_bit.no3 = 1U;
			stSMBMINT.WD_bit.no0 = 1U;
		}
		else{
			stSMBMINT.WD_bit.no0 = 1U;
		}
#if SMBM_INT_ALERT_EN == 1
		stSMBMINT.WD_bit.no8 = 0U;
#endif
		SMBMINT = stSMBMINT.WD;

		if(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_IDLE){
			gSmbmInfo.ucSmbmStatus =  SMBM_CTRL_STATE_READY;
		}
		else{
			gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_STRECH_READY;
		}

		gSmbmInfo.usSmbmTimeOut = usTimeOut;
	}
	return;
}

/******************************************************************************
 Clear smbm_ctrl module status
******************************************************************************/
void smbm_clr_status(void)
{
	if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR) ||
			(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH) ){
		// Set smbm req
		SMBMCON = (USHORT)(SMBMCON_I2C_STOP);
	}

	gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_IDLE;

	return;
}

/******************************************************************************
 Reset smbm_ctrl module
******************************************************************************/
void smbm_reset(void)
{
	DI();
	SMBMSTA = SMBMSTA_CLEAR;
#if SMBM_INT_ALERT_EN == 1
	SMBMINT = SMBMINT_ALERT_STATUS;
#else
	SMBMINT = SMBMINT_ALL_CLEAR;
#endif

	pdc_set_int_routine(intID_INTSMBMST, (ULONG)NULL);

	if((gSmbmInfo.ucSmbmStatus & SMBM_CTRL_STATE_ACTIVE) != NULL) {
		SMBMCON = (USHORT)(SMBMCON_I2C_STOP);
	}

	gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_IDLE;

	EI();

	return;
}

/******************************************************************************
 Interrupt Routine for I2C Block Write
******************************************************************************/
void smbm_int_write_routine(void)
{
	__SMBM_WD stSMBMSTA;
	UCHAR ucChkInt = 0U;

	stSMBMSTA.WD = SMBMSTA;

	if((stSMBMSTA.WD_bit.no1 == 1) || (stSMBMSTA.WD_bit.no2 == 1)){
		// Transfer PEC Error
		gSmbmInfo.ucSmbmError = ((UCHAR)(stSMBMSTA.WD_bit.no1) << 2) | ((UCHAR)(stSMBMSTA.WD_bit.no2) << 1);
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_ERROR;
	}
	else if(stSMBMSTA.WD_bit.no3 == 1) {
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_STRETCH;
	}
	else if(stSMBMSTA.WD_bit.no0 == 1){
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_COMPLETE;
	}
	else if(stSMBMSTA.WD_bit.no8 == 1U) {
		ucChkInt = 1U;
	}
	else {
		return;
	}
	if(ucChkInt == 0U) {
		// Clear Timeout
		pd_tm_stop_user_cnt(TM_ID_USER1);

		// SMBMSTA & SMIMINT Clear
		SMBMSTA = SMBMSTA_CLEAR;

#if SMBM_INT_ALERT_EN == 1
		SMBMINT = SMBMINT_ALERT_STATUS;
#else
		SMBMINT = SMBMINT_ALL_CLEAR;
#endif
		pdc_set_int_routine(intID_INTSMBMST, (ULONG)NULL);
		pdc_timer_active();
	}
	return;
}

/******************************************************************************
 Interrupt Routine for I2C Block Read
******************************************************************************/
void smbm_int_read_routine(void)
{
	__SMBM_WD stSMBMSTA;
	UCHAR ucChkInt = 0U;

	stSMBMSTA.WD = SMBMSTA;

	if((stSMBMSTA.WD_bit.no1 == 1) || (stSMBMSTA.WD_bit.no2 == 1)){
		// Transfer PEC Error
		gSmbmInfo.ucSmbmError = ((UCHAR)(stSMBMSTA.WD_bit.no1) << 2) | ((UCHAR)(stSMBMSTA.WD_bit.no2) << 1);
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_ERROR;
	}
	else if(stSMBMSTA.WD_bit.no3 == 1) {
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_STRETCH;
	}
	else if(stSMBMSTA.WD_bit.no0 == 1){
		gSmbmInfo.ucSmbmStatus = SMBM_CTRL_STATE_COMPLETE;
	}
	else if(stSMBMSTA.WD_bit.no8 == 1U) {
		ucChkInt = 1U;
	}
	else {
		return;
	}

	if(ucChkInt == 0U) {
		// Clear Timeout
		pd_tm_stop_user_cnt(TM_ID_USER1);

		if(gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_ERROR){
			smbm_copy_word((USHORT *)&SMBMDAT0_LW, (USHORT *)gSmbmInfo.pusSmbmData, ((gSmbmInfo.usSmbmDataLen+1)>>1));
		}

		// SMBMSTA & SMIMINT Clear
		SMBMSTA = SMBMSTA_CLEAR;
#if SMBM_INT_ALERT_EN == 1
		SMBMINT = SMBMINT_ALERT_STATUS;
#else
		SMBMINT = SMBMINT_ALL_CLEAR;
#endif
		pdc_set_int_routine(intID_INTSMBMST, (ULONG)NULL);
		pdc_timer_active();
	}
	return;
}

void smbm_copy_word(USHORT *src, USHORT *dst, UINT uiLength)
{
	UINT i;

	for(i=0U; i<uiLength; i++){
		*dst = *src;
		dst ++;
		src ++;
	}
	return;
}

