#include "relamcu.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "R9A02G011AMCU.h"
#include "R9A02G011AUTH.h"

#define VAL_RELAMCU_I2C_CLK			(SMBM_CLOCK_1M)
#define VAL_RELAMCU_I2C_SLAVEADDR	((UCHAR)0x5C<<1)

RELAMCU_INFO gRelamcuInfo;

/******************************************************************************
 Global values
******************************************************************************/


/******************************************************************************
 Private fanctions
******************************************************************************/
void relamcu_cmd_handler(void);
void relamcu_stretch_cmd_handler(void);
void relamcu_end_processing(void);

void init_relamcu(void)
{
	gRelamcuInfo.ucSt  = SUBDEV_DRV_STATE_IDLE;
	gRelamcuInfo.ucReserved = 0U;
	return;
}

/******************************************************************************
 subdev1 Control
******************************************************************************/
void relamcu_ctrl(void)
{
	switch(gRelamcuInfo.ucSt){
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			relamcu_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if( (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH ) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE) ||
				(gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR   ) ){
				relamcu_end_processing();
			}
			break;
		case SUBDEV_DRV_STATE_STRETCH_IDLE:
			relamcu_stretch_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_END:
			break;
	}
	
	return;
}

/******************************************************************************
 reset subdev1 staus
******************************************************************************/
void relamcu_reset(void)
{
	//smbm reset
	if( gRelamcuInfo.ucSt == SUBDEV_DRV_STATE_STRETCH_IDLE){
		smbm_reset();
	}

	gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	gSubdevInfo.ucSubdevFlag &= ~RELAMCU_DEVICE_ID;
	gAmcu.bit.bReqTx = 0U;

	return;
}

/******************************************************************************
 subdev1 Command Handler while SMBus Master is IDLE state
******************************************************************************/
void relamcu_cmd_handler(void)
{
	// set smbm
	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE){
		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_READY;

		return;
	}
	else{
		gSmbmInfo.ucSmbmError = 0x00;
		smbm_set_subdev(VAL_RELAMCU_I2C_CLK, VAL_RELAMCU_I2C_SLAVEADDR);

		smbm_set_protocol(
			gAmcuBuf.stTxMsg.ucCmd,					// CMD
			gAmcuBuf.stTxMsg.ucPrtcl,				// Protocol
			0,										// PEC
			gAmcuBuf.stTxMsg.ucCtrlFlg,				// Option
			(USHORT*)gAmcuBuf.stTxMsg.usData,// Data
			gAmcuBuf.stTxMsg.ucLen,					// len
			10										// TimeOut
			);
		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_ACTIVE;
		relamcu_reset_err();
	}

	return;
}

/******************************************************************************
 subdev1 Command Handler while SMBus Master is STRETCH state
******************************************************************************/
void relamcu_stretch_cmd_handler(void)
{

	smbm_set_protocol(
			gAmcuBuf.stTxMsg.ucCmd,					// CMD
			gAmcuBuf.stTxMsg.ucPrtcl,				// Protocol
			0,										// PEC
			gAmcuBuf.stTxMsg.ucCtrlFlg,				// Option
			(USHORT*)gAmcuBuf.stTxMsg.usData,// Data
			gAmcuBuf.stTxMsg.ucLen,					// len
			10										// TimeOut
		);

		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_ACTIVE;

	return;
}

/******************************************************************************
 subdev1 run end processing
******************************************************************************/
void relamcu_end_processing(void)
{
	if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH){
		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_STRETCH_IDLE;
	}
	else if( gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR){
		smbm_clr_status();
		gSubDevErr.ucSubdev |= RELAMCU_DEVICE_ID;
		amcu_set_err();
		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	}
	else{
		smbm_clr_status();
		gRelamcuInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
	}

	gSubdevInfo.ucSubdevFlag &= ~RELAMCU_DEVICE_ID;
	gAmcu.bit.bReqTx = 0U;

	return;
}

void relamcu_reset_err(void)
{
		gSubDevErr.ucSubdev &= ~ RELAMCU_DEVICE_ID;
}