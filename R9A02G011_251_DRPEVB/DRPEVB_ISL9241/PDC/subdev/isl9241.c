#include "isl9241.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "dcdc_ctrl.h"
#include "dcdc_cmd_list.h"
#include "R9A02G011PDC.h"

#define VAL_I2C_CLK			(SMBM_CLOCK_400K)
#define VAL_I2C_SLAVEADDR	((UCHAR)0x12)

#define VAL_DCDC_ALERT		((USHORT)0x1800)	// bit 12, 11


#define VAL_POWER_BRICK_VOLT		((USHORT)19000U)
#define VAL_POWER_BRICK_CURR		((USHORT) 4700U)
#define VAL_SYSTEM_CURR				((USHORT) 1000U)

#define VAL_MAXSYSVOLT				((USHORT) 12000U)
#define VAL_CTRL2					((USHORT) 0xE000U)
#define VAL_MINSYSVOLT				((USHORT) 9000U)
#define VAL_MAXCHGCUR				((USHORT) 2000U)

/******************************************************************************
// const values
******************************************************************************/

/******************************************************************************
 Global values
******************************************************************************/
typedef union {
	struct {
		ULONG bMinMax    : 10;
		ULONG bOpr       : 10;
		ULONG            :  3;
		ULONG bUnChkSprt :  1;
		ULONG bNoSusp    :  1;
		ULONG bUSBComm   :  1;
		ULONG bMissCap   :  1;
		ULONG bGB        :  1;
		ULONG bObjPos    :  3;
		ULONG            :  1;
	}bit;

	struct {
		ULONG bCur       :  7;
		ULONG            :  2;
		ULONG bVolt      : 11;
		ULONG            :  3;
		ULONG bUnChkSprt :  1;
		ULONG bNoSusp    :  1;
		ULONG bUSBComm   :  1;
		ULONG bMissCap   :  1;
		ULONG            :  1;
		ULONG bObjPos    :  3;
		ULONG            :  1;
	}bit_pps;

	ULONG data;
}RCVRDO;

ISL9241_INFO gIsl9241Info;
 
/******************************************************************************
 Private functions
******************************************************************************/
void isl9241_cmd_handler(void);
void isl9241_end_processing(void);
#if 0
void isl9241_alert_cmd_handler(void);
void isl9241_alert_end_processing(void);
void isl9241_alert_end_processing2(void);
#endif
void isl9241_cmd(void);

void init_isl9241(void)
{
	gIsl9241Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gIsl9241Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	return;
}

void isl9241_ctrl(void)
{
	switch(gIsl9241Info.ucSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			isl9241_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl9241_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}

void isl9241_cmd_handler(void)
{
	// set smbm
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gIsl9241Info.ucSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		gSubDevErr.ucSubdev &= ~ISL9241_DEVICE_ID;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		isl9241_cmd();
		gIsl9241Info.ucSt = SUBDEV_DRV_STATE_ACTIVE;
	}

	return;
}

void isl9241_cmd(void)
{
	UCHAR ucCmd = 0U;
	USHORT usData = 0U;
	ULONG ulTmp = 0U;
	UCHAR ucProt = SMBM_WORD_WRITE;
	
	switch(gDCInfo.ucCmd){
		case BBCHG_SET_CTRL0:
			// Control0
			ucCmd = 0x39;
			usData = 0x0000;
			break;
		case BBCHG_SET_CTRL0_BYPASS_DIS:
			// Control0
			ucCmd = 0x39;
			usData = 0x0080;
			break;
		case BBCHG_SET_CTRL1:
			// Control1
			ucCmd = 0x3C;
			usData = 0x0103;
			break;
		case BBCHG_SET_CTRL1_OTG:
			// Control 1
			// enable OTG (Adapter Output Power Supply)
			ucCmd = 0x3C;
			usData = 0x0903;
			break;
		case BBCHG_SET_CTRL2:
			// Control2
			ucCmd = 0x3D;
			usData = VAL_CTRL2;
			break;
		case BBCHG_GET_INFO1:
			// Information1 
			ucCmd = 0x3A;
			ucProt = SMBM_WORD_READ;
			break;
		case BBCHG_GET_INFO2:
			// Information2
			ucCmd = 0x4D;
			ucProt = SMBM_WORD_READ;
			break;
		case BBCHG_SET_MAXSYSVOLT:
			// MaxSystemVoltage
			ucCmd = 0x15;
			gDCInfo.usCur = pdc_get_req_cur();
			if( gDCInfo.usCur <= 100U ){
				usData = 0U;
			}
			else{
				usData = VAL_MAXSYSVOLT;
			}
			break;
		case BBCHG_SET_MAXSYSVOLT_DIS:
			//MaxSystemVoltage
			ucCmd = 0x15;
			usData = 0x0000;
			break;
		case BBCHG_SET_MINSYSVOLT:
			// MinSystemVoltage
			ucCmd = 0x3E;
			usData = VAL_MINSYSVOLT;
			break;
		case BBCHG_SET_MINSYSVOLT_DIS:
			// MinSystemVoltage
			ucCmd = 0x3E;
			usData = 0x0000;
			break;
		case BBCHG_SET_OTGVOLT:
			// OTG Voltage
			ucCmd = 0x49;
			ulTmp = (ULONG) pdc_get_req_volt();
			usData = ((ulTmp + 6) / 12) * 0x08;
			break;
		case BBCHG_SET_OTGCUR:
			// OTG Current
			ucCmd = 0x4A;
			ulTmp = pdc_get_req_cur();
			usData = ((ulTmp + 16) / 32) * 0x20;
			break;
		case BBCHG_SET_CHRCURLIMIT:
			// ChargeCurrentLimit
			ucCmd = 0x14;
			usData = VAL_MAXCHGCUR;
			break;
		case BBCHG_SET_ADPCURLIMIT1:
			// AdapterCurrentLimit1
			ucCmd = 0x3F;
			gDCInfo.usCur = pdc_get_req_cur();
			if( gDCInfo.usCur <= 100U ){
				usData = 0U;
			}
			else{
				usData = gDCInfo.usCur - 100U;
			}
			break;
		default:
			break;
	}
	if( ucProt == SMBM_WORD_WRITE){
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_WRITE,				// Protocol
			0,						// PEC
			SMBM_SMB_START,		// Option
			&usData,				// Data
			2,						// len
			1						// TimeOut
		);
	}
	else{
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_READ,	// Protocol
			0,						// PEC
			SMBM_SMB_START,		// Option
			&gDCInfo.usRegData,		// Data
			2,						// len
			1						// TimeOut
		);			
	}
	return;
}


void isl9241_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gSubDevErr.ucSubdev |= ISL9241_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
	}
	smbm_clr_status();
	
	gIsl9241Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gSubdevInfo.ucSubdevFlag &= ~ISL9241_DEVICE_ID;

	return;
}

#if 0
void isl9241_alert(void)
{
	switch(gIsl9241Info.ucAlertSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			isl9241_alert_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl9241_alert_end_processing();
			}
			break;
		case SUBDEV_DRV_STATE_ACTIVE2:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl9241_alert_end_processing2();
			}
			break;
		default:
			break;
	}
	return;
}


void isl9241_alert_cmd_handler(void)
{
	
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gIsl9241Info.ucAlertSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		smbm_set_protocol(
			0x3A,					// CMD information1
			SMBM_WORD_READ,			// Protocol
			0,						// PEC
			SMBM_SMB_START,			// Option
			&gDCInfo.usRegData,	// Data
			2,						// len
			1000						// TimeOut
		);

		gIsl9241Info.ucAlertSt = SUBDEV_DRV_STATE_ACTIVE;
		gSubDevErr.ucSubdev &= ~ISL9241_DEVICE_ID;
	}

	return;
}


void isl9241_alert_end_processing(void)
{
	USHORT usData = 0x0003;
	
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gDCInfo.usIntRegData = 0U;
	}
	smbm_clr_status();

	gSmbmInfo.ucSmbmError = 0x00;
	
	// Control4
	// bit 1 PROCHOT# Clear = 1
	// bit 0 PROCHOT# Latch = 1
	// other default
	smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
	smbm_set_protocol(
		0x4E,				// CMD information1
		SMBM_WORD_WRITE,	// Protocol
		0,					// PEC
		SMBM_SMB_START,		// Option
		&usData,			// Data
		2,					// len
		1					// TimeOut
	);

	gIsl9241Info.ucAlertSt = SUBDEV_DRV_STATE_ACTIVE2;

	return;
}


void isl9241_alert_end_processing2(void)
{
	gDCInfo.uNtfy.bit.bDcdcAlert = ( (gDCInfo.usIntRegData & VAL_DCDC_ALERT) != 0U) ? 1U : 0U;
	
	smbm_clr_status();
	gSubdevInfo.ucSubdevAlertFlag &= ~ISL9241_DEVICE_ID;
	gIsl9241Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;

	return;
}
#endif

