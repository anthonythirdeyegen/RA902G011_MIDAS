#include "bq25798.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif

#define VAL_I2C_CLK                    (SMBM_CLOCK_400K)
#define VAL_I2C_SLAVEADDR              ((UCHAR)0x6BU << 1)

#define BQ25798_REG_CHG_CURRENT        ((UCHAR)0x03U)
#define BQ25798_REG_INPUT_CURRENT      ((UCHAR)0x06U)
#define BQ25798_REG_CHARGER_CTRL0      ((UCHAR)0x0FU)
#define BQ25798_REG_CHARGER_CTRL5      ((UCHAR)0x14U)

#define BQ25798_EN_CHG                 ((UCHAR)0x20U)
#define BQ25798_EN_IINDPM              ((UCHAR)0x04U)
#define BQ25798_EN_EXTILIM             ((UCHAR)0x02U)

#define BQ25798_IINDPM_MIN_MA          ((USHORT)100U)
#define BQ25798_IINDPM_MAX_MA          ((USHORT)3300U)
#define BQ25798_ICHG_MIN_MA            ((USHORT)50U)
#define BQ25798_ICHG_MAX_MA            ((USHORT)5000U)

#define BQ25798_STEP_IDLE              ((UCHAR)0x00U)
#define BQ25798_STEP_WORD_MSB          ((UCHAR)0x01U)
#define BQ25798_STEP_WORD_LSB          ((UCHAR)0x02U)
#define BQ25798_STEP_RMW_READ          ((UCHAR)0x03U)
#define BQ25798_STEP_RMW_WRITE         ((UCHAR)0x04U)

BQ25798_INFO gBq25798Info;

static void bq25798_cmd_handler(void);
static void bq25798_end_processing(void);
static void bq25798_start_cmd(void);
static void bq25798_start_byte_write(UCHAR ucReg, UCHAR ucData);
static void bq25798_start_byte_read(UCHAR ucReg);
static USHORT bq25798_clamp_ma(USHORT usCurrentMa, USHORT usMinMa, USHORT usMaxMa);
static void bq25798_request_cmd(UCHAR ucCmd);

void init_bq25798(void)
{
	gBq25798Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gBq25798Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	gBq25798Info.ucCmd = BQ25798_CMD_NONE;
	gBq25798Info.ucStep = BQ25798_STEP_IDLE;
	gBq25798Info.ucReqFlags = 0U;
	gBq25798Info.ucEnable = 0U;
	gBq25798Info.usData = 0U;
	gBq25798Info.usInputCurrentMa = 0U;
	gBq25798Info.usChargeCurrentMa = 0U;
	gBq25798Info.usRegData = 0U;
	return;
}

void bq25798_ctrl(void)
{
	switch (gBq25798Info.ucSt) {
		case SUBDEV_DRV_STATE_IDLE:
		case SUBDEV_DRV_STATE_READY:
			bq25798_cmd_handler();
			break;
		case SUBDEV_DRV_STATE_ACTIVE:
			if (   (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH)
				|| (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE)
				|| (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR)) {
				bq25798_end_processing();
			}
			break;
		default:
			break;
	}
	return;
}

static void bq25798_cmd_handler(void)
{
	if (gBq25798Info.ucCmd == BQ25798_CMD_NONE) {
		if ((gBq25798Info.ucReqFlags & BQ25798_REQ_USE_IINDPM_REG) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_USE_IINDPM_REG;
		}
		else if ((gBq25798Info.ucReqFlags & BQ25798_REQ_SET_IINDPM) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_SET_IINDPM;
			gBq25798Info.usData = (USHORT)(gBq25798Info.usInputCurrentMa / 10U);
		}
		else if ((gBq25798Info.ucReqFlags & BQ25798_REQ_SET_ICHG) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_SET_ICHG;
			gBq25798Info.usData = (USHORT)(gBq25798Info.usChargeCurrentMa / 10U);
		}
		else if ((gBq25798Info.ucReqFlags & BQ25798_REQ_SET_CHG_EN) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_SET_CHG_EN;
		}
		else {
			gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
			return;
		}
	}

	if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE) {
		gBq25798Info.ucSt = SUBDEV_DRV_STATE_READY;
		return;
	}

	gSmbmInfo.ucSmbmError = 0x00U;
	gSubDevErr.ucSubdev &= ~BQ25798_DEVICE_ID;
	smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
	bq25798_start_cmd();
	gBq25798Info.ucSt = SUBDEV_DRV_STATE_ACTIVE;
	return;
}

static void bq25798_start_cmd(void)
{
	switch (gBq25798Info.ucCmd) {
		case BQ25798_CMD_SET_IINDPM:
			gBq25798Info.ucStep = BQ25798_STEP_WORD_MSB;
			bq25798_start_byte_write(BQ25798_REG_INPUT_CURRENT, (UCHAR)(gBq25798Info.usData >> 8));
			break;
		case BQ25798_CMD_SET_ICHG:
			gBq25798Info.ucStep = BQ25798_STEP_WORD_MSB;
			bq25798_start_byte_write(BQ25798_REG_CHG_CURRENT, (UCHAR)(gBq25798Info.usData >> 8));
			break;
		case BQ25798_CMD_SET_CHG_EN:
			gBq25798Info.ucStep = BQ25798_STEP_RMW_READ;
			bq25798_start_byte_read(BQ25798_REG_CHARGER_CTRL0);
			break;
		case BQ25798_CMD_USE_IINDPM_REG:
			gBq25798Info.ucStep = BQ25798_STEP_RMW_READ;
			bq25798_start_byte_read(BQ25798_REG_CHARGER_CTRL5);
			break;
		default:
			gBq25798Info.ucCmd = BQ25798_CMD_NONE;
			gBq25798Info.ucStep = BQ25798_STEP_IDLE;
			gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
			break;
	}
	return;
}

static void bq25798_end_processing(void)
{
	if (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR) {
		gSubDevErr.ucSubdev |= BQ25798_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
		smbm_clr_status();
		gBq25798Info.ucSt = SUBDEV_DRV_STATE_IDLE;
		gBq25798Info.ucStep = BQ25798_STEP_IDLE;
		gBq25798Info.ucCmd = BQ25798_CMD_NONE;
		gBq25798Info.ucReqFlags = 0U;
		gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
		return;
	}

	if (gBq25798Info.ucStep == BQ25798_STEP_WORD_MSB) {
		smbm_clr_status();
		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		gBq25798Info.ucStep = BQ25798_STEP_WORD_LSB;
		if (gBq25798Info.ucCmd == BQ25798_CMD_SET_IINDPM) {
			bq25798_start_byte_write((UCHAR)(BQ25798_REG_INPUT_CURRENT + 1U), (UCHAR)gBq25798Info.usData);
		}
		else {
			bq25798_start_byte_write((UCHAR)(BQ25798_REG_CHG_CURRENT + 1U), (UCHAR)gBq25798Info.usData);
		}
		return;
	}

	if (gBq25798Info.ucStep == BQ25798_STEP_RMW_READ) {
		smbm_clr_status();
		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		gBq25798Info.ucStep = BQ25798_STEP_RMW_WRITE;
		if (gBq25798Info.ucCmd == BQ25798_CMD_SET_CHG_EN) {
			if (gBq25798Info.ucEnable != 0U) {
				gBq25798Info.usRegData |= BQ25798_EN_CHG;
			}
			else {
				gBq25798Info.usRegData &= (USHORT)~BQ25798_EN_CHG;
			}
			bq25798_start_byte_write(BQ25798_REG_CHARGER_CTRL0, (UCHAR)gBq25798Info.usRegData);
		}
		else {
			gBq25798Info.usRegData |= BQ25798_EN_IINDPM;
			gBq25798Info.usRegData &= (USHORT)~BQ25798_EN_EXTILIM;
			bq25798_start_byte_write(BQ25798_REG_CHARGER_CTRL5, (UCHAR)gBq25798Info.usRegData);
		}
		return;
	}

	smbm_clr_status();
	if (gBq25798Info.ucCmd == BQ25798_CMD_USE_IINDPM_REG) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_USE_IINDPM_REG;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_IINDPM) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_SET_IINDPM;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_ICHG) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_SET_ICHG;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_CHG_EN) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_SET_CHG_EN;
	}

	gBq25798Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gBq25798Info.ucStep = BQ25798_STEP_IDLE;
	gBq25798Info.ucCmd = BQ25798_CMD_NONE;
	if (gBq25798Info.ucReqFlags == 0U) {
		gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
	}
	return;
}

static void bq25798_start_byte_write(UCHAR ucReg, UCHAR ucData)
{
	gBq25798Info.usRegData = (USHORT)ucData;
	smbm_set_protocol(
		ucReg,
		SMBM_BYTE_WRITE,
		0,
		SMBM_SMB_START,
		&gBq25798Info.usRegData,
		1,
		1
	);
	return;
}

static void bq25798_start_byte_read(UCHAR ucReg)
{
	smbm_set_protocol(
		ucReg,
		SMBM_BYTE_READ,
		0,
		SMBM_SMB_START,
		&gBq25798Info.usRegData,
		1,
		1
	);
	return;
}

static USHORT bq25798_clamp_ma(USHORT usCurrentMa, USHORT usMinMa, USHORT usMaxMa)
{
	if (usCurrentMa < usMinMa) {
		return usMinMa;
	}
	if (usCurrentMa > usMaxMa) {
		return usMaxMa;
	}
	return usCurrentMa;
}

static void bq25798_request_cmd(UCHAR ucCmd)
{
	if (ucCmd == BQ25798_CMD_SET_IINDPM) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_SET_IINDPM;
	}
	else if (ucCmd == BQ25798_CMD_SET_ICHG) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_SET_ICHG;
	}
	else if (ucCmd == BQ25798_CMD_SET_CHG_EN) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_SET_CHG_EN;
	}
	else if (ucCmd == BQ25798_CMD_USE_IINDPM_REG) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_USE_IINDPM_REG;
	}
	gSubdevInfo.ucSubdevFlag |= BQ25798_DEVICE_ID;
	return;
}

void bq25798_request_input_current(USHORT usCurrentMa)
{
	usCurrentMa = bq25798_clamp_ma(usCurrentMa, BQ25798_IINDPM_MIN_MA, BQ25798_IINDPM_MAX_MA);
	gBq25798Info.usInputCurrentMa = usCurrentMa;
	bq25798_request_cmd(BQ25798_CMD_SET_IINDPM);
	return;
}

void bq25798_request_charge_current(USHORT usCurrentMa)
{
	usCurrentMa = bq25798_clamp_ma(usCurrentMa, BQ25798_ICHG_MIN_MA, BQ25798_ICHG_MAX_MA);
	gBq25798Info.usChargeCurrentMa = usCurrentMa;
	bq25798_request_cmd(BQ25798_CMD_SET_ICHG);
	return;
}

void bq25798_request_charge_enable(UCHAR ucEnable)
{
	gBq25798Info.ucEnable = ucEnable;
	bq25798_request_cmd(BQ25798_CMD_SET_CHG_EN);
	return;
}

void bq25798_request_use_iindpm_register(void)
{
	bq25798_request_cmd(BQ25798_CMD_USE_IINDPM_REG);
	return;
}

void bq25798_alert(void)
{
	(void)0;
	return;
}
