#ifndef ___BQ25798_CTRL_H
#define ___BQ25798_CTRL_H

#include "typedefs.h"

#define BQ25798_DEVICE_ID              ((UCHAR)0x04U)

#define BQ25798_CMD_NONE               ((UCHAR)0x00U)
#define BQ25798_CMD_SET_IINDPM         ((UCHAR)0x01U)
#define BQ25798_CMD_SET_ICHG           ((UCHAR)0x02U)
#define BQ25798_CMD_SET_CHG_EN         ((UCHAR)0x03U)
#define BQ25798_CMD_USE_IINDPM_REG     ((UCHAR)0x04U)
#define BQ25798_CMD_APPLY_EVM_DEFAULTS ((UCHAR)0x05U)
#define BQ25798_CMD_SET_VINDPM         ((UCHAR)0x06U)

#define BQ25798_REQ_SET_IINDPM         ((UCHAR)0x01U)
#define BQ25798_REQ_SET_ICHG           ((UCHAR)0x02U)
#define BQ25798_REQ_SET_CHG_EN         ((UCHAR)0x04U)
#define BQ25798_REQ_USE_IINDPM_REG     ((UCHAR)0x08U)
#define BQ25798_REQ_APPLY_EVM_DEFAULTS ((UCHAR)0x10U)
#define BQ25798_REQ_SET_VINDPM         ((UCHAR)0x20U)

typedef struct
{
	UCHAR ucSt;
	UCHAR ucAlertSt;
	UCHAR ucCmd;
	UCHAR ucStep;
	UCHAR ucReqFlags;
	UCHAR ucEnable;
	UCHAR ucCfgIndex;
	USHORT usData;
	USHORT usInputVoltageMv;
	USHORT usInputCurrentMa;
	USHORT usChargeCurrentMa;
	USHORT usRegData;
} BQ25798_INFO;

extern BQ25798_INFO gBq25798Info;

void init_bq25798(void);
void bq25798_ctrl(void);
void bq25798_alert(void);

void bq25798_request_input_current(USHORT usCurrentMa);
void bq25798_request_input_voltage(USHORT usVoltageMv);
void bq25798_request_charge_current(USHORT usCurrentMa);
void bq25798_request_charge_enable(UCHAR ucEnable);
void bq25798_request_use_iindpm_register(void);
void bq25798_request_evm_defaults(void);

#endif // ___BQ25798_CTRL_H
