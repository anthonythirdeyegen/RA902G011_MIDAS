#include "isl95338.h"
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
#include "R9A02G011AMCU.h"
#include "R9A02G011AUTH.h"

#define VAL_I2C_CLK			(SMBM_CLOCK_400K)
#define VAL_I2C_SLAVEADDR	((UCHAR)0x48<<1)

#define VAL_DCDC_ALERT		((USHORT)0x1800)	// bit 12, 11


#define VAL_POWER_BRICK_VOLT		((USHORT)19000U)
#define VAL_POWER_BRICK_VOLT_CRG	((USHORT)17000U)
#define VAL_POWER_BRICK_CURR		((USHORT) 4700U)
#define VAL_SYSTEM_CURR				((USHORT) 1000U)

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

ISL95338_INFO gIsl95338Info;
 
/******************************************************************************
 Private fanctions
******************************************************************************/
void isl95338_cmd_handler(void);
void isl95338_end_processing(void);
#if 0
void isl95338_alert_cmd_handler(void);
void isl95338_alert_end_processing(void);
void isl95338_alert_end_processing2(void);
#endif
void isl95338_cmd(void);

void init_isl95338(void)
{
	gIsl95338Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gIsl95338Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	return;
}

void isl95338_ctrl(void)
{
	switch(gIsl95338Info.ucSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			isl95338_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl95338_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}

void isl95338_cmd_handler(void)
{
	// set smbm
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gIsl95338Info.ucSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		gSubDevErr.ucSubdev &= ~ISL95338_DEVICE_ID;

		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		isl95338_cmd();
		gIsl95338Info.ucSt = SUBDEV_DRV_STATE_ACTIVE;
	}

	return;
}

void isl95338_cmd(void)
{
	UCHAR ucCmd = 0U;
	USHORT usData = 0U;
	ULONG ulVolt = 0U;
	ULONG ulCurr = 0U;
	ULONG ulTmp = 0U;
	ULONG ulCutTmp = 0U;
	ULONG ulUpTmp = 0U;
	UCHAR ucProt = SMBM_WORD_WRITE;
	RCVRDO uRcvRDO;
	
	switch(gDCInfo.ucCmd){
		case BBVR_INIT_CTR1:
			// Control1
			ucCmd = 0x3C;
#if RAA489800
			// bit 14 sinking current during negative DAC transition = 0
			// bit 11 Reverse Mode Function = 0 (default)
			// bit 2 Stop switching in FWD mode = 1
			// bit 1 0V enable or disable during slew-down = 1
			// other default
			usData = 0x0006;
#else
			// bit 14 sinking current during negative DAC transition = 1
			// bit 11 Reverse Mode Function = 0 (default)
			// bit 2 Stop switching in FWD mode = 1
			// bit 1 0V enable or disable during slew-down = 1
			// other default
			usData = 0x4006;
#endif
			break;
		case BBVR_INIT_CTR2:
			// Control2
			// bit14 UV control = 1
			// bit13 Fault Restart debounce for reverse enable = 1
			// bit12 Fault restart debounce = 0
			// bit11 Forward Restart debounce for forward enable = 1
			// other default
			ucCmd = 0x3D;
			usData = 0x6800;
			break;
		case BBVR_INIT_CTR3:
			// Control3
			// bit15 Re-read PROG pin resistor = 1
			// other default
			ucCmd = 0x4C;
			usData = 0x8000; 
			break;
		case BBVR_INIT_CTR4:
			// Control4
			// bit 0 PROCHOT# Latch = 0
			// other default
			ucCmd = 0x4E;
			usData = 0x0000;
			break;
		case BBVR_INIT_CTR0:
			// Control0
			// bit1 ADP side discharge = 1
			// bit0 System side discharge = 1
			// other default
			ucCmd = 0x39;
			usData = 0x0003; 
			break;
		case BBVR_SET_RVSRV:
			// ReverseRegulatingVoltage
			ucCmd = 0x49;
			
			ulVolt = (ULONG)pdc_get_req_volt();
#if RAA489800
			ulVolt = ulVolt;
#else
			ulVolt = ulVolt * 101U / 100U;	// 1% Up
#endif
			ulCutTmp = (USHORT)(ulVolt / 12) * 12 ; // (e.g. ulTmp = 5000mV , ulCutTmp = 4992mV)
			ulUpTmp  = ulVolt;
			if((ulVolt % 12) != 0U){
				ulUpTmp += 12;
			}
			ulUpTmp = (USHORT)(ulUpTmp / 12) * 12; // (e.g. ulTmp = 5000mV , ulUpTmp = 5004mV)
			
			if( (ulVolt - ulCutTmp) > (ulUpTmp - ulVolt)){
				ulVolt += 12;
			}
			usData = (USHORT)((ulVolt / 12) << 3);
			break;
		case BBVR_SET_RVCRR:
			// ReverseCurrentLimit
			ucCmd = 0x4A;
			ulTmp = pdc_get_req_cur() * 10;
			if (pdc_is_pps_mode() == 0U) { // Fixed supply
				ulTmp = ulTmp * 120U / 100U;
			}
			ulCutTmp = (ulTmp / 1024U) * 1024U;
			ulUpTmp  = ulTmp;
			if((ulTmp % 1024) != 0U){
				ulUpTmp += 1024;
			}
			ulUpTmp = (ulUpTmp / 1024U) * 1024U;
			
			if( (ulTmp - ulCutTmp) > (ulUpTmp - ulTmp)){
				ulTmp += 1024U;
			}
			usData = (USHORT)((ulTmp / 1024U) << 7);
			break;
		case BBVR_SET_SYSCRRPROCHOT:
			// System Input Current Prochot#
			ucCmd = 0x48;
			ulTmp = VAL_POWER_BRICK_CURR;	//Power Brick Spec Current
			if((ulTmp % 256) != 0U){
				ulTmp  += 256;
			}
			usData = (USHORT)ulTmp & 0x3F00;
			gDCInfo.usRegData = usData;
			break;
		case BBVR_SET_RVSSYSCRRLIMIT:
			// SystemCurrentLimit for forward mode
			ucCmd = 0x14;
			ulTmp = VAL_POWER_BRICK_CURR;	//Power Brick Spec Current
			if((ulTmp % 4) != 0U){
				ulTmp  += 4;
			}
			usData = (USHORT)ulTmp & 0x1FFC;
			break;
		case BBVR_SET_FRWRV:
			// FowardRegulatingVoltage
			// 19000mV (fix) System Side Output
			ucCmd = 0x15;
			ulVolt = VAL_POWER_BRICK_VOLT_CRG;
			ulCutTmp = (USHORT)(ulVolt / 12) * 12 ; // (e.g. ulTmp = 5000mV , ulCutTmp = 4992mV)
			ulUpTmp  = ulVolt;
			if((ulVolt % 12) != 0U){
				ulUpTmp += 12;
			}
			ulUpTmp = (USHORT)(ulUpTmp / 12) * 12; // (e.g. ulTmp = 5000mV , ulUpTmp = 5004mV)
			
			if( (ulVolt - ulCutTmp) > (ulUpTmp - ulVolt)){
				ulVolt += 12;
			}
			usData = (USHORT)((ulVolt / 12) << 3);
			break;
		case BBVR_SET_FRWSYSCRRLIMIT:
			// SystemCurrentLimit for reverse mode
			ucCmd = 0x14;
			ulTmp  = VAL_SYSTEM_CURR;
			if((ulTmp % 4) != 0U){
				ulTmp  += 4;
			}
			usData = (USHORT)ulTmp & 0x1FFC;
			break;
		case BBVR_SET_ADPPROCHOT:
			// ADPsideProchot#
			ucCmd = 0x47;
			ulTmp = pdc_get_req_cur() * 10;
			if (pdc_is_pps_mode() == 0U) { // Fixed supply
				ulTmp = ulTmp * 120U / 100U;
			}
			ulCutTmp = (ulTmp / 1024U) * 1024U;
			ulUpTmp  = ulTmp;
			if((ulTmp % 1024) != 0U){
				ulUpTmp += 1024;
			}
			ulUpTmp = (ulUpTmp / 1024U) * 1024U;
			
			if( (ulTmp - ulCutTmp) > (ulUpTmp - ulTmp)){
				ulTmp += 1024U;
			}
			usData = (USHORT)((ulTmp / 1024U) << 7);
			break;
		case BBVR_SET_FRWINPUTCURR:
			// Forward Input Current
			ucCmd = 0x3F;
			uRcvRDO.data = (ULONG)pdc_get_rdo(PDC_RDO_NEGO);
			ulCurr =  uRcvRDO.bit.bOpr * 10U;
			// reffer to OperatingCurrent
			if( ulCurr < 100U ){
				ulCurr = 0U;
			}
			else {
				ulCurr = (USHORT)(((ulCurr - 100U) * 10U / 32U) << 2U);
			}
			
			usData = (USHORT)ulCurr & 0x1FFC;	// 4mA resolution
			
			break;
		case BBVR_CLR_PROHOT:
			// Control4
			// bit 1 PROCHOT# Clear = 1
			// bit 0 PROCHOT# Latch = 1
			// other default
			ucCmd =0x4E;
			usData = 0x0003;
			break;
		case BBVR_SET_FRWON:
			// Control1
			ucCmd = 0x3C;
			ulCurr = (ULONG)pdc_get_req_cur();
#if RAA489800
			if( ulCurr == 0U ){
				// Forward Mode Function OFF
				// bit 14 sinking current during negative DAC transition = 0
				// bit 11 Reverse Mode Function = 0 (default)
				// bit 2 Stop switching in FWD mode = 1
				// bit 1 0V enable or disable during slew-down = 1
				// other default
				usData = 0x0006;
			}
			else{
				// Forward Mode Function OFN
				// bit 14 sinking current during negative DAC transition = 0
				// bit 11 Reverse Mode Function = 0 (default)
				// bit 2 Stop switching in FWD mode = 0
				// bit 1 0V enable or disable during slew-down = 1
				// other default
				usData = 0x0002;
			}
#else
			if( ulCurr == 0U ){
				// Forward Mode Function OFF
				// bit 14 sinking current during negative DAC transition = 1
				// bit 11 Reverse Mode Function = 0 (default)
				// bit 2 Stop switching in FWD mode = 1
				// bit 1 0V enable or disable during slew-down = 1
				// other default
				usData = 0x4006;
			}
			else{
				// Forward Mode Function OFN
				// bit 14 sinking current during negative DAC transition = 1
				// bit 11 Reverse Mode Function = 0 (default)
				// bit 2 Stop switching in FWD mode = 0
				// bit 1 0V enable or disable during slew-down = 1
				// other default
				usData = 0x4002;
			}
#endif
			break;
		case BBVR_SET_RVSON:
			// Control1
			ucCmd = 0x3C;
#if RAA489800
			// OTG(Reverse Mode Function) ON
			// bit 14 sinking current during negative DAC transition = 0
			// bit 11 Reverse Mode Function = 1
			// bit 2 Stop switching in FWD mode = 1
			// bit 1 0V enable or disable during slew-down = 1
			// other default
			usData = 0x0806;
#else
			// OTG(Reverse Mode Function) ON
			// bit 14 sinking current during negative DAC transition = 1
			// bit 11 Reverse Mode Function = 1
			// bit 2 Stop switching in FWD mode = 1
			// bit 1 0V enable or disable during slew-down = 1
			// other default
			usData = 0x4806;
#endif
			break;
		case BBVR_GET_INFO1:
			// Information1 
			ucCmd = 0x3A;
			ucProt = SMBM_WORD_READ;
			break;
		case BBVR_GET_INFO2:
			// Information12
			ucCmd = 0x4D;
			ucProt = SMBM_WORD_READ;
			break;
		case BBVR_SET_CTR0_DISCHG_DIS:
			// Control0
			// bit1 ADP side discharge = 0
			// bit0 System side discharge = 0
			// other default
			ucCmd = 0x39;
			usData = 0x0000; 
			break;
		case BBVR_SET_CTR0_DISCHG:
			// Control0
			ucCmd = 0x39;
			ulCurr = (ULONG)pdc_get_req_cur();
			if(ulCurr == 0U){
			// bit1 ADP side discharge = 0
			// bit0 System side discharge = 0
			// other default
				usData = 0x0000; 
			}
			else{
			// bit1 ADP side discharge = 1
			// bit0 System side discharge = 1
			// other default
				usData = 0x0003; 
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


void isl95338_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		gSubDevErr.ucSubdev |= ISL95338_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
	}
	smbm_clr_status();
	
	gIsl95338Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gSubdevInfo.ucSubdevFlag &= ~ISL95338_DEVICE_ID;
	if (   (amcu_get_status() == AMCU_STAT_IDLE)
	    && (auth_get_status() == AUTH_STAT_READY)) {
		amcu_set_stdby();
	}

	return;
}

#if 0
void isl95338_alert(void)
{
	switch(gIsl95338Info.ucAlertSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			isl95338_alert_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl95338_alert_end_processing();
			}
			break;
		case SUBDEV_DRV_STATE_ACTIVE2:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				isl95338_alert_end_processing2();
			}
			break;
		default:
			break;
	}
	return;
}


void isl95338_alert_cmd_handler(void)
{
	
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gIsl95338Info.ucAlertSt = SUBDEV_DRV_STATE_READY;

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

		gIsl95338Info.ucAlertSt = SUBDEV_DRV_STATE_ACTIVE;
		gSubDevErr.ucSubdev &= ~ISL95338_DEVICE_ID;
	}

	return;
}


void isl95338_alert_end_processing(void)
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

	gIsl95338Info.ucAlertSt = SUBDEV_DRV_STATE_ACTIVE2;

	return;
}


void isl95338_alert_end_processing2(void)
{
	gDCInfo.uNtfy.bit.bDcdcAlert = ( (gDCInfo.usIntRegData & VAL_DCDC_ALERT) != 0U) ? 1U : 0U;
	
	smbm_clr_status();
	gSubdevInfo.ucSubdevAlertFlag &= ~ISL95338_DEVICE_ID;
	gIsl95338Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;

	return;
}
#endif