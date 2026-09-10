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

#define BQ25798_REG_MIN_SYS_VOLTAGE    ((UCHAR)0x00U)
#define BQ25798_REG_CHG_VOLTAGE        ((UCHAR)0x01U)
#define BQ25798_REG_CHG_CURRENT        ((UCHAR)0x03U)
#define BQ25798_REG_INPUT_VOLTAGE      ((UCHAR)0x05U)
#define BQ25798_REG_INPUT_CURRENT      ((UCHAR)0x06U)
#define BQ25798_REG_PRECHG_CTRL        ((UCHAR)0x08U)
#define BQ25798_REG_TERMINATION_CTRL   ((UCHAR)0x09U)
#define BQ25798_REG_CHARGER_CTRL0      ((UCHAR)0x0FU)
#define BQ25798_REG_CHARGER_CTRL1      ((UCHAR)0x10U)
#define BQ25798_REG_CHARGER_CTRL2      ((UCHAR)0x11U)
#define BQ25798_REG_CHARGER_CTRL5      ((UCHAR)0x14U)

#define BQ25798_EN_CHG                 ((UCHAR)0x20U)
#define BQ25798_WATCHDOG_MASK          ((UCHAR)0x07U)
#define BQ25798_WD_RST                 ((UCHAR)0x08U)
#define BQ25798_VAC_OVP_MASK           ((UCHAR)0x30U)
#define BQ25798_VAC_OVP_12V            ((UCHAR)0x20U)
#define BQ25798_FORCE_INDET            ((UCHAR)0x80U)
#define BQ25798_AUTO_INDET_EN          ((UCHAR)0x40U)
#define BQ25798_EN_12V                 ((UCHAR)0x20U)
#define BQ25798_EN_9V                  ((UCHAR)0x10U)
#define BQ25798_HVDCP_EN               ((UCHAR)0x08U)
#define BQ25798_SFET_PRESENT           ((UCHAR)0x80U)
#define BQ25798_EN_IINDPM              ((UCHAR)0x04U)
#define BQ25798_EN_EXTILIM             ((UCHAR)0x02U)
#define BQ25798_ITERM_MASK             ((UCHAR)0x1FU)

#define BQ25798_EVM_VSYSMIN_MV         ((USHORT)7000U)
#define BQ25798_EVM_VREG_MV            ((USHORT)8400U)
#define BQ25798_EVM_PRECHG_MA          ((USHORT)240U)
#define BQ25798_EVM_VINDPM_MV          ((USHORT)4000U)
#define BQ25798_STARTUP_IINDPM_MA      ((USHORT)500U)
#define BQ25798_EVM_ICHG_MA            ((USHORT)500U)
#define BQ25798_EVM_ITERM_MA           ((USHORT)200U)

#define BQ25798_IINDPM_MIN_MA          ((USHORT)100U)
#define BQ25798_IINDPM_MAX_MA          ((USHORT)3300U)
#define BQ25798_ICHG_MIN_MA            ((USHORT)50U)
#define BQ25798_ICHG_MAX_MA            ((USHORT)5000U)
#define BQ25798_VINDPM_MIN_MV          ((USHORT)3600U)
#define BQ25798_VINDPM_MAX_MV          ((USHORT)22000U)

#define BQ25798_STEP_IDLE              ((UCHAR)0x00U)
#define BQ25798_STEP_WORD_MSB          ((UCHAR)0x01U)
#define BQ25798_STEP_WORD_LSB          ((UCHAR)0x02U)
#define BQ25798_STEP_RMW_READ          ((UCHAR)0x03U)
#define BQ25798_STEP_RMW_WRITE         ((UCHAR)0x04U)
#define BQ25798_STEP_BYTE              ((UCHAR)0x05U)

#define BQ25798_CFG_BYTE               ((UCHAR)0x00U)
#define BQ25798_CFG_WORD               ((UCHAR)0x01U)
#define BQ25798_CFG_RMW                ((UCHAR)0x02U)

typedef struct
{
	UCHAR ucReg;
	UCHAR ucType;
	UCHAR ucMask;
	USHORT usData;
} BQ25798_CFG;

static const BQ25798_CFG gBq25798EvmDefaults[] = {
	/* TI SLUUCB5E section 2.4.2/2.4.3 charge-mode setup:
	   watchdog disabled, ShipFET present, VSYSMIN 7V, VREG 8.4V,
	   BC1.2/HVDCP detection disabled, precharge 240mA,
	   termination 200mA, VINDPM 4.0V, startup IINDPM 500mA, ICHG 500mA.
	   REG10 VAC_OVP is set to 12V per SLUUCB5E's >8V input-voltage hint. */
	{ BQ25798_REG_CHARGER_CTRL0,   BQ25798_CFG_RMW,  BQ25798_EN_CHG, 0U },
	{ BQ25798_REG_CHARGER_CTRL1,   BQ25798_CFG_RMW,  (UCHAR)(BQ25798_WATCHDOG_MASK | BQ25798_WD_RST | BQ25798_VAC_OVP_MASK), BQ25798_VAC_OVP_12V },
	{ BQ25798_REG_CHARGER_CTRL2,   BQ25798_CFG_RMW,  (UCHAR)(BQ25798_FORCE_INDET | BQ25798_AUTO_INDET_EN | BQ25798_EN_12V | BQ25798_EN_9V | BQ25798_HVDCP_EN), 0U },
	{ BQ25798_REG_MIN_SYS_VOLTAGE, BQ25798_CFG_BYTE, 0U, (USHORT)((BQ25798_EVM_VSYSMIN_MV - 2500U) / 250U) },
	{ BQ25798_REG_CHG_VOLTAGE,     BQ25798_CFG_WORD, 0U, (USHORT)(BQ25798_EVM_VREG_MV / 10U) },
	{ BQ25798_REG_PRECHG_CTRL,     BQ25798_CFG_RMW,  (UCHAR)0x3FU, (USHORT)(BQ25798_EVM_PRECHG_MA / 40U) },
	{ BQ25798_REG_TERMINATION_CTRL, BQ25798_CFG_RMW, BQ25798_ITERM_MASK, (USHORT)(BQ25798_EVM_ITERM_MA / 40U) },
	{ BQ25798_REG_INPUT_VOLTAGE,   BQ25798_CFG_BYTE, 0U, (USHORT)(BQ25798_EVM_VINDPM_MV / 100U) },
	{ BQ25798_REG_INPUT_CURRENT,   BQ25798_CFG_WORD, 0U, (USHORT)(BQ25798_STARTUP_IINDPM_MA / 10U) },
	{ BQ25798_REG_CHG_CURRENT,     BQ25798_CFG_WORD, 0U, (USHORT)(BQ25798_EVM_ICHG_MA / 10U) },
	{ BQ25798_REG_CHARGER_CTRL5,   BQ25798_CFG_RMW,  (UCHAR)(BQ25798_SFET_PRESENT | BQ25798_EN_IINDPM | BQ25798_EN_EXTILIM), (USHORT)(BQ25798_SFET_PRESENT | BQ25798_EN_IINDPM) }
};

#define BQ25798_EVM_DEFAULTS_COUNT     ((UCHAR)(sizeof(gBq25798EvmDefaults) / sizeof(gBq25798EvmDefaults[0])))

BQ25798_INFO gBq25798Info;

static void bq25798_cmd_handler(void);
static void bq25798_end_processing(void);
static void bq25798_start_cmd(void);
static void bq25798_start_cfg_entry(void);
static void bq25798_start_byte_write(UCHAR ucReg, UCHAR ucData);
static void bq25798_start_byte_read(UCHAR ucReg);
static USHORT bq25798_clamp_ma(USHORT usCurrentMa, USHORT usMinMa, USHORT usMaxMa);
static USHORT bq25798_clamp_mv(USHORT usVoltageMv, USHORT usMinMv, USHORT usMaxMv);
static void bq25798_request_cmd(UCHAR ucCmd);

void init_bq25798(void)
{
	gBq25798Info.ucSt = SUBDEV_DRV_STATE_IDLE;
	gBq25798Info.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
	gBq25798Info.ucCmd = BQ25798_CMD_NONE;
	gBq25798Info.ucStep = BQ25798_STEP_IDLE;
	gBq25798Info.ucReqFlags = 0U;
	gBq25798Info.ucEnable = 0U;
	gBq25798Info.ucCfgIndex = 0U;
	gBq25798Info.usData = 0U;
	gBq25798Info.usInputVoltageMv = 0U;
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
		if ((gBq25798Info.ucReqFlags & BQ25798_REQ_APPLY_EVM_DEFAULTS) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_APPLY_EVM_DEFAULTS;
		}
		else if ((gBq25798Info.ucReqFlags & BQ25798_REQ_USE_IINDPM_REG) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_USE_IINDPM_REG;
		}
		else if ((gBq25798Info.ucReqFlags & BQ25798_REQ_SET_VINDPM) != 0U) {
			gBq25798Info.ucCmd = BQ25798_CMD_SET_VINDPM;
			gBq25798Info.usData = (USHORT)(gBq25798Info.usInputVoltageMv / 100U);
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
		case BQ25798_CMD_SET_VINDPM:
			gBq25798Info.ucStep = BQ25798_STEP_BYTE;
			bq25798_start_byte_write(BQ25798_REG_INPUT_VOLTAGE, (UCHAR)gBq25798Info.usData);
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
		case BQ25798_CMD_APPLY_EVM_DEFAULTS:
			gBq25798Info.ucCfgIndex = 0U;
			bq25798_start_cfg_entry();
			break;
		default:
			gBq25798Info.ucCmd = BQ25798_CMD_NONE;
			gBq25798Info.ucStep = BQ25798_STEP_IDLE;
			gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
			break;
	}
	return;
}

static void bq25798_start_cfg_entry(void)
{
	const BQ25798_CFG *pCfg = &gBq25798EvmDefaults[gBq25798Info.ucCfgIndex];

	gBq25798Info.usData = pCfg->usData;
	if (pCfg->ucType == BQ25798_CFG_WORD) {
		gBq25798Info.ucStep = BQ25798_STEP_WORD_MSB;
		bq25798_start_byte_write(pCfg->ucReg, (UCHAR)(gBq25798Info.usData >> 8));
	}
	else if (pCfg->ucType == BQ25798_CFG_RMW) {
		gBq25798Info.ucStep = BQ25798_STEP_RMW_READ;
		bq25798_start_byte_read(pCfg->ucReg);
	}
	else {
		gBq25798Info.ucStep = BQ25798_STEP_BYTE;
		bq25798_start_byte_write(pCfg->ucReg, (UCHAR)gBq25798Info.usData);
	}
	return;
}

static void bq25798_end_processing(void)
{
	const BQ25798_CFG *pCfg = (const BQ25798_CFG *)0;

	if (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR) {
		gSubDevErr.ucSubdev |= BQ25798_DEVICE_ID;
		gSubDevErr.ucError = gSmbmInfo.ucSmbmError;
		smbm_clr_status();
		gBq25798Info.ucSt = SUBDEV_DRV_STATE_IDLE;
		gBq25798Info.ucStep = BQ25798_STEP_IDLE;
		gBq25798Info.ucCmd = BQ25798_CMD_NONE;
		gBq25798Info.ucCfgIndex = 0U;
		gBq25798Info.ucReqFlags = 0U;
		gSubdevInfo.ucSubdevFlag &= ~BQ25798_DEVICE_ID;
		return;
	}

	if (gBq25798Info.ucStep == BQ25798_STEP_WORD_MSB) {
		smbm_clr_status();
		smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
		gBq25798Info.ucStep = BQ25798_STEP_WORD_LSB;
		if (gBq25798Info.ucCmd == BQ25798_CMD_APPLY_EVM_DEFAULTS) {
			pCfg = &gBq25798EvmDefaults[gBq25798Info.ucCfgIndex];
			bq25798_start_byte_write((UCHAR)(pCfg->ucReg + 1U), (UCHAR)gBq25798Info.usData);
		}
		else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_IINDPM) {
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
		if (gBq25798Info.ucCmd == BQ25798_CMD_APPLY_EVM_DEFAULTS) {
			pCfg = &gBq25798EvmDefaults[gBq25798Info.ucCfgIndex];
			gBq25798Info.usRegData &= (USHORT)~pCfg->ucMask;
			gBq25798Info.usRegData |= (USHORT)(pCfg->usData & pCfg->ucMask);
			bq25798_start_byte_write(pCfg->ucReg, (UCHAR)gBq25798Info.usRegData);
		}
		else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_CHG_EN) {
			if (gBq25798Info.ucEnable != 0U) {
				gBq25798Info.usRegData |= BQ25798_EN_CHG;
			}
			else {
				gBq25798Info.usRegData &= (USHORT)~BQ25798_EN_CHG;
			}
			bq25798_start_byte_write(BQ25798_REG_CHARGER_CTRL0, (UCHAR)gBq25798Info.usRegData);
		}
		else {
			gBq25798Info.usRegData |= BQ25798_SFET_PRESENT;
			gBq25798Info.usRegData |= BQ25798_EN_IINDPM;
			gBq25798Info.usRegData &= (USHORT)~BQ25798_EN_EXTILIM;
			bq25798_start_byte_write(BQ25798_REG_CHARGER_CTRL5, (UCHAR)gBq25798Info.usRegData);
		}
		return;
	}

	smbm_clr_status();
	if (gBq25798Info.ucCmd == BQ25798_CMD_APPLY_EVM_DEFAULTS) {
		gBq25798Info.ucCfgIndex++;
		if (gBq25798Info.ucCfgIndex < BQ25798_EVM_DEFAULTS_COUNT) {
			smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);
			bq25798_start_cfg_entry();
			return;
		}
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_APPLY_EVM_DEFAULTS;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_USE_IINDPM_REG) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_USE_IINDPM_REG;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_IINDPM) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_SET_IINDPM;
	}
	else if (gBq25798Info.ucCmd == BQ25798_CMD_SET_VINDPM) {
		gBq25798Info.ucReqFlags &= (UCHAR)~BQ25798_REQ_SET_VINDPM;
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
	gBq25798Info.ucCfgIndex = 0U;
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

static USHORT bq25798_clamp_mv(USHORT usVoltageMv, USHORT usMinMv, USHORT usMaxMv)
{
	if (usVoltageMv < usMinMv) {
		return usMinMv;
	}
	if (usVoltageMv > usMaxMv) {
		return usMaxMv;
	}
	return usVoltageMv;
}

static void bq25798_request_cmd(UCHAR ucCmd)
{
	if (ucCmd == BQ25798_CMD_SET_IINDPM) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_SET_IINDPM;
	}
	else if (ucCmd == BQ25798_CMD_SET_VINDPM) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_SET_VINDPM;
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
	else if (ucCmd == BQ25798_CMD_APPLY_EVM_DEFAULTS) {
		gBq25798Info.ucReqFlags |= BQ25798_REQ_APPLY_EVM_DEFAULTS;
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

void bq25798_request_input_voltage(USHORT usVoltageMv)
{
	usVoltageMv = bq25798_clamp_mv(usVoltageMv, BQ25798_VINDPM_MIN_MV, BQ25798_VINDPM_MAX_MV);
	gBq25798Info.usInputVoltageMv = usVoltageMv;
	bq25798_request_cmd(BQ25798_CMD_SET_VINDPM);
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

void bq25798_request_evm_defaults(void)
{
	bq25798_request_cmd(BQ25798_CMD_APPLY_EVM_DEFAULTS);
	return;
}

void bq25798_alert(void)
{
	(void)0;
	return;
}
