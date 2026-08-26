#include "isl95538b.h"
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
#define VAL_I2C_SLAVEADDR	((UCHAR)0x09<<1)


#define VAL_PB_BATTVOLMAX			((USHORT)12000U)
#define VAL_PB_BATTVOLMIN			((USHORT) 9000U)
#define VAL_PB_CHARGECURRENTLIMIT	((USHORT) 2000U)
#define VAL_PB_MULTIPLY				((USHORT)  102U)
#define VAL_PB_OFFSET				((USHORT)    0U)

#if ISL9238C_EN //Set to 1 if using ISL9283C
#define VAL_PB_OTGCURSTEP				( 256U)
#else
#define VAL_PB_OTGCURSTEP				(1024U)
#endif
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

ISL95538B_INFO gIsl95538BInfo;
 
/******************************************************************************
 Private fanctions
******************************************************************************/
void isl95538b_cmd_handler(void);
void isl95538b_end_processing(void);
void isl95538b_cmd(void);
USHORT isl95538b_get_oparatingcurr(void);

void init_isl95538b(void)
{
	gIsl95538BInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	gIsl95538BInfo.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	return;
}

void isl95538b_ctrl(void)
{
	switch(gIsl95538BInfo.ucSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			isl95538b_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl95538b_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}

void isl95538b_cmd_handler(void)
{
	// set smbm
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gIsl95538BInfo.ucSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		gSubDevErr.ucSubdev &= ~ISL95538B_DEVICE_ID;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		isl95538b_cmd();
		gIsl95538BInfo.ucSt = SUBDEV_DRV_STATE_ACTIVE;
	}

	return;
}

void isl95538b_cmd(void)
{
	UCHAR ucCmd = 0U;
	USHORT usData = 0U;
	ULONG ulTmp = 0U;
	ULONG ulCutTmp = 0U;
	ULONG ulUpTmp = 0U;
	UCHAR ucProt = SMBM_WORD_WRITE;
	
	switch(gDCInfo.ucCmd){
		case BBCHG_INIT_CTR0:
			// Control0
			ucCmd = 0x39;
			usData = 0x0003;
			break;
		case BBCHG_INIT_CTR1:
			// Control1
			ucCmd = 0x3C;
			usData = 0x0004;
			break;
		case BBCHG_INIT_CTR2:
			// Control2
			ucCmd = 0x3D;
			usData = 0x2800;
			break;
		case BBCHG_INIT_CTR3:
			// Control3
			ucCmd = 0x4C;
			usData = 0x8081;
			break;
		case BBCHG_INIT_CTR4:
			// Control4
			ucCmd = 0x4E;
			usData = 0x0000;
			break;
		case BBCHG_INIT_MAXVOL:
			// MaxSystemVoltage
			ucCmd = 0x15;
			usData = VAL_PB_BATTVOLMAX & 0x7FF8;
			break;
		case BBCHG_INIT_MINVOL:
			// MinSystemVoltage
			ucCmd = 0x3E;
			usData = VAL_PB_BATTVOLMIN;
			
			if( (usData % 256) != 0U){
				usData += 256;
			}
			usData = usData & 0x3F00;
			break;
		case BBCHG_SET_OTG:
			// Control1
			ucCmd = 0x3C;
			usData = 0x0804;
			break;
		case BBCHG_SET_OTGVOLT:
			// OTG Voltage
			ucCmd = 0x49;
			ulTmp = (ULONG)pdc_get_req_volt() * VAL_PB_MULTIPLY / 100U + VAL_PB_OFFSET;

			ulCutTmp = (ulTmp / 12U) * 12U ; // (e.g. ulTmp = 5000mV , ulCutTmp = 4992mV)
			ulUpTmp  = ulTmp;
			if((ulTmp % 12) != 0U){
				ulUpTmp += 12;
			}
			ulUpTmp = (ulUpTmp / 12U) * 12U; // (e.g. ulTmp = 5000mV , ulUpTmp = 5004mV)
			
			if( (ulTmp - ulCutTmp) > (ulUpTmp - ulTmp)){
				ulTmp += 12U;
			}
			usData = (ulTmp / 12U) << 3U;
			break;
		case BBCHG_SET_OTGCURR:
			// OTG Current
			ucCmd = 0x4A;
			ulTmp = pdc_get_req_cur() * 10;
			if (pdc_is_pps_mode() == 0U) { // Fixed supply
				ulTmp = ulTmp * 120U / 100U;
			}
			ulCutTmp = (ulTmp / VAL_PB_OTGCURSTEP) * VAL_PB_OTGCURSTEP ;
			ulUpTmp  = ulTmp;
			if((ulTmp % VAL_PB_OTGCURSTEP) != 0U){
				ulUpTmp += VAL_PB_OTGCURSTEP;
			}
			ulUpTmp = (ulUpTmp / VAL_PB_OTGCURSTEP) * VAL_PB_OTGCURSTEP;
			
			if( (ulTmp - ulCutTmp) > (ulUpTmp - ulTmp)){
				ulTmp += VAL_PB_OTGCURSTEP;
			}
#if ISL9238C_EN //Set to 1 if using ISL9283C
			usData = (USHORT)((ulTmp / VAL_PB_OTGCURSTEP) << 5U);
#else
			usData = (USHORT)((ulTmp / VAL_PB_OTGCURSTEP) << 7U);
#endif
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
		case BBCHG_SET_ADPCURRLIMIT:
			// AdapterCurrentLimit1
			ucCmd = 0x3F;
			gDCInfo.usCur = pdc_get_req_cur();
			gDCInfo.usVolt = pdc_get_req_volt();
			if( gDCInfo.usCur <= 100U ){
				usData = 0U;
			}
			else{
				ulTmp = isl95538b_get_oparatingcurr() - 100U;

				usData = (USHORT)((ulTmp * 10U / 32U) << 2U);
			}
			break;
		case BBCHG_INIT_INPUTVOLT:
			// Input Voltage 
			ucCmd = 0x4B;
			usData = 0x0B00;	// 3.7543V
			break;
		case BBCHG_INIT_ADPCURRLIMIT:
			// AdapterCurrentLimit1
			ucCmd = 0x3F;
			usData = 0x0000;
			break;
		case BBCHG_INIT_CHGCURRLIMIT:
			// ChargeCurrentLimit
			ucCmd = 0x14;
			usData = 0x0000;
			break;
		case BBCHG_SET_CHGCURRLIMIT:
			// ChargeCurrentLimit
			ucCmd = 0x14;
			if( gDCInfo.usCur == 0U ){
				usData = 0U;
			}
			else{
				usData = VAL_PB_CHARGECURRENTLIMIT;
			}
			break;
		case BBCHG_CTR0_EN_LOAD:
			// Control0
			ucCmd = 0x39;
			usData = 0x0003;
			break;
		case BBCHG_CTR0_DIS_LOAD:
			// Control0
			ucCmd = 0x39;
			usData = 0x0002;
			break;
		case BBCHG_SET_CTRL1_VSYS:
			// Control1
			ucCmd = 0x3C;
			ulTmp = pdc_get_req_cur();
			if( ulTmp == 0U){
				usData = 0x0004; // VSYS Disable
			}
			else{
				usData = 0x0000; // VSYS Enable
			}
			break;
#if ISL9238C_EN  //Set to 1 if using ISL9283C
		case BBCHG_CTR6_DIS_UV:
			// Control6
			ucCmd = 0x37;
			usData = 0x0020; // Disable OTG Undervoltage
			break;
		case BBCHG_CTR6_EN_UV:
			// Control6
			ucCmd = 0x37;
			usData = 0x0040; // Enable OTG Undervoltage, Disable Slew Rate
			break;
		case BBCHG_CTR6_EN_SLEW:
			// Control6
			ucCmd = 0x37;
			usData = 0x0060; // Disable OTG Undervoltage, Enable Slew Rate
			break;
		case BBCHG_CTR4_EN_ADPDISCHG:
			ucCmd = 0x4E;
			usData = 0x2000;
			break;
#endif
		default:
			break;
	}
	if( ucProt == SMBM_WORD_WRITE){
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_WRITE,		// Protocol
			0,						// PEC
			SMBM_SMB_START,			// Option
			&usData,				// Data
			2,						// len
			1						// TimeOut
		);
	}
	else{
		smbm_set_protocol(
			ucCmd,					// CMD
			SMBM_WORD_READ,			// Protocol
			0,						// PEC
			SMBM_SMB_START,			// Option
			&gDCInfo.usRegData,		// Data
			2,						// len
			1						// TimeOut
		);			
	}
	return;
}


void isl95538b_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gSubDevErr.ucSubdev |= ISL95538B_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
	}
	smbm_clr_status();
	
	gIsl95538BInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	gSubdevInfo.ucSubdevFlag &= ~ISL95538B_DEVICE_ID;

	return;
}

USHORT isl95538b_get_oparatingcurr(void)
{
	RCVRDO uRcvRDO;
	USHORT usCurr = 0U;
	PD_STATUS uStatus = pdc_get_status();

	if (uStatus.bit.bNonPD == 1U) { //Non-PD
		usCurr = pdc_get_req_cur();
	}
	else {
		uRcvRDO.data = (ULONG)pdc_get_rdo(PDC_RDO_NEGO);
		usCurr = (USHORT)uRcvRDO.bit.bOpr * 10U;
	}
	return usCurr;
}