#include "slave_pdc.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "mppm.h"
#include "R9A02G011PDC.h"
#include "R9A02G011AMCU.h"
#include "R9A02G011AUTH.h"

#define VAL_I2C_CLK			(SMBM_CLOCK_400K)
#define VAL_I2C_SLAVEADDR	((UCHAR)0x18<<1)

/******************************************************************************
// const values
******************************************************************************/

/******************************************************************************
 Global values
******************************************************************************/
 SLAVEPDC_INFO gSlavePdcInfo;
 
/******************************************************************************
 Private fanctions
******************************************************************************/
void slavepdc_cmd_handler(void);
void slavepdc_end_processing(void);
void slavepdc_alert_cmd_handler(void);
void slavepdc_alert_end_processing(void);
void slavepdc_cmd(void);

void init_slavepdc(void)
{
	gSlavePdcInfo.ucSt      = SUBDEV_DRV_STATE_IDLE;
	gSlavePdcInfo.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	gSlavePdcInfo.ucAlertReadCnt = 0;
	return;
}

void slavepdc_ctrl(void)
{
	switch(gSlavePdcInfo.ucSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			slavepdc_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				slavepdc_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}

void slavepdc_cmd_handler(void)
{
	// set smbm
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gSlavePdcInfo.ucSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		gSubDevErr.ucSubdev  &= ~SLAVEPDC_DEVICE_ID;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		slavepdc_cmd();
		gSlavePdcInfo.ucSt = SUBDEV_DRV_STATE_ACTIVE;
	}

	return;
}

void slavepdc_cmd(void)
{
	UCHAR  ucCmd  = 0U;
	USHORT usSize = 4U;
	UCHAR  ucProt = SMBM_WORD_WRITE;

	switch(gMppmInfo.ucCmd){
		case MPPM_GET_STATUS1:
			// Status1
			ucCmd = 0x03;
			ucProt = SMBM_WORD_READ;
			break;
		case MPPM_GET_STATUS2:
			// Status2
			ucCmd = 0x04;
			ucProt = SMBM_WORD_READ;
			break;
		case MPPM_SET_COMMAND:
			// Command
			ucCmd = 0x07;
			break;
		case MPPM_SET_CTRLCNF2:
			// Control Configuration 2
			ucCmd = 0x09;
			break;
		case MPPM_SET_OBJDATAMODE:
			// Object Data Mode
			ucCmd = 0x71;
			usSize = 4U;
			ucProt = SMBM_BLOCK_WRITE;
			break;
		case MPPM_GET_RDODATA:
			// Object Data
			ucCmd = 0x91;
			ucProt = SMBM_BLOCK_READ;
			break;
		case MPPM_SET_PORTINFODATA:
			// Object Data
			ucCmd = 0x91;
			usSize = 8U;
			ucProt = SMBM_BLOCK_WRITE_1;
			break;
		case MPPM_GET_SELFPORTDATA:
			// Object Data
			ucCmd = 0x91;
			usSize = 8U;
			ucProt = SMBM_BLOCK_READ_1;
			break;
		case MPPM_GET_TRICKLE_STATE:
			// Object Data
			ucCmd = 0x91;
			usSize = 4U;
			ucProt = SMBM_BLOCK_READ_1;
			break;

		default:
			break;
	}

	if(ucProt == SMBM_WORD_WRITE) {
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_WRITE,		// Protocol
			0,						// PEC
			SMBM_SMB_START,		    // Option
			(USHORT *)&gMppmInfo.usRegData[1],	// Data
			2,						// len
			2						// TimeOut
		);
	}
	else if (ucProt == SMBM_WORD_READ) {
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_READ,	        // Protocol
			0,						// PEC
			SMBM_SMB_START,	    	// Option
			(USHORT *)&gMppmInfo.usRegData[1],	// Data
			2,						// len
			2						// TimeOut
		);			
	}
    else if(ucProt == SMBM_BLOCK_WRITE) {
		smbm_set_protocol(
			ucCmd,					  // CMD
			SMBM_BLOCK_WRITE,	      // Protocol
			0,					      // PEC
			SMBM_SMB_START,	          // Option
			(USHORT *)&gMppmInfo.ulObjDataMode.ulData,  // Data
			usSize,						  // len
			2						  // TimeOut
		);			
    }
    else if(ucProt == SMBM_BLOCK_WRITE_1) {
		smbm_set_protocol(
			ucCmd,					  // CMD
			SMBM_BLOCK_WRITE,	      // Protocol
			0,					      // PEC
			SMBM_SMB_START,	          // Option
			(USHORT *)&gMppmInfo.ulPortData.usData[0],  // Data
			usSize,						  // len
			2						  // TimeOut
		);			
    }
    else if (ucProt == SMBM_BLOCK_READ_1) {
		smbm_set_protocol(
			ucCmd,					  // CMD
			SMBM_BLOCK_READ,	      // Protocol
			0,					      // PEC
			SMBM_SMB_START,	          // Option
			(USHORT *)&gMppmInfo.ulPortData.usData[0],  // Data
			usSize,  			      // len
			2						  // TimeOut
		);			
    }
    else {
		smbm_set_protocol(
			ucCmd,					  // CMD
			SMBM_BLOCK_READ,	      // Protocol
			0,					      // PEC
			SMBM_SMB_START,	          // Option
			(USHORT *)&gMppmInfo.ulRdoInfo[0],  // Data
			4,					      // len
			2						  // TimeOut
		);			
    }
	return;
}


void slavepdc_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gSubDevErr.ucSubdev |= SLAVEPDC_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
	}
	smbm_clr_status();
	
	gSlavePdcInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	gSubdevInfo.ucSubdevFlag &= ~SLAVEPDC_DEVICE_ID;
	if (   (amcu_get_status() == AMCU_STAT_IDLE)
	    && (auth_get_status() == AUTH_STAT_READY)) {
		amcu_set_stdby();
	}

	return;
}


void slavepdc_alert(void)
{
	switch(gSlavePdcInfo.ucAlertSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			slavepdc_alert_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				slavepdc_alert_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}


void slavepdc_alert_cmd_handler(void)
{
	
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gSlavePdcInfo.ucAlertSt = SUBDEV_DRV_STATE_READY;

        return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		gSubDevErr.ucSubdev  &= ~SLAVEPDC_DEVICE_ID;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
        
        // Read Alert# Status
		smbm_set_protocol(
			0x02,				   	// CMD
			SMBM_WORD_READ,	      	// Protocol
			0,				      	// PEC
			SMBM_SMB_START,	        // Option
			&gMppmInfo.usAlertData,	// Data
			2,					    // len
			2   		            // TimeOut
		);

		gSlavePdcInfo.ucAlertSt = SUBDEV_DRV_STATE_ACTIVE;
	}

	return;
}


void slavepdc_alert_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gMppmInfo.usRegData[1].usData = 0U;
		gSlavePdcInfo.ucAlertReadCnt += 1U;
	}
	else {
		gMppmInfo.portInfo[1].ucReqflg |= MPPM_ALERT;
		gSlavePdcInfo.ucAlertReadCnt = 0U;
	}
	smbm_clr_status();

	gSmbmInfo.ucSmbmError = 0x00;
    
	gSubdevInfo.ucSubdevAlertFlag &= ~SLAVEPDC_DEVICE_ID;
    gSlavePdcInfo.ucAlertSt = SUBDEV_DRV_STATE_IDLE;

	return;
}
