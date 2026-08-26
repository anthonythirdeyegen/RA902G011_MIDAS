#ifndef ___R9A02G011SMBS_H
#define ___R9A02G011SMBS_H

#include "typedefs.h"

#define SMBS_ALERT_SPRT (1U)
#define SMBS_12BIT_MAX_PERIOD (273U)

#define SMBS_CLK_0100kH (0x00U) // 0b00U
#define SMBS_CLK_0400kH (0x02U) // 0b10U
#define SMBS_CLK_1000kH (0x03U) // 0b11U

#define SMBS_CMD_TYPE_NOT_RCV  (0U)
#define SMBS_CMD_TYPE_DEF      (1U)
#define SMBS_CMD_TYPE_UNDEF    (2U)

#define SMBS_OBJ_SEL_SRCPDO_MAX (0x01U)
#define SMBS_OBJ_SEL_SRCPDO_SYS (0x02U)
#define SMBS_OBJ_SEL_SRCPDO_CUR (0x03U)
#define SMBS_OBJ_SEL_SNKPDO     (0x04U)
#define SMBS_OBJ_SEL_SRCPDO_FAR (0x05U)
#define SMBS_OBJ_SEL_SNKPDO_FAR (0x06U)
#define SMBS_OBJ_SEL_CURPDO     (0x07U)
#define SMBS_OBJ_SEL_RDO        (0x08U)
#define SMBS_OBJ_SEL_RDO_TMP    (0x09U)
#define SMBS_OBJ_SEL_VDM        (0x11U)
#define SMBS_OBJ_SEL_DI         (0x12U)
#define SMBS_OBJ_SEL_PRODUCT    (0x13U)
#define SMBS_OBJ_SEL_RCV_ADO    (0x21U)
#define SMBS_OBJ_SEL_SND_ADO    (0x22U)
#define SMBS_OBJ_SEL_EDB        (0x31U)
#define SMBS_OBJ_SEL_BSDO       (0x32U)
#define SMBS_OBJ_SEL_VBUSM      (0xF1U)

typedef union {
	struct {
		USHORT bRcvCmd        : 1U;
		USHORT bChgCtrlCnf1   : 1U;
		USHORT bChgCtrlCnf2   : 1U;
		USHORT bReqSetObjData : 1U;
		USHORT                : 1U;
		USHORT bChgObjData    : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
		USHORT                : 1U;
	}bit;
	USHORT usData;
}SMBS_EVENT;

typedef union {
	struct {
		USHORT bAutoAcptSwap_PR : 1U;
		USHORT bAutoReqSwap_PR  : 1U;
		USHORT                  : 2U;
		USHORT bIntrPwr         : 1U;
		USHORT bSnkPdoMax       : 3U;
		USHORT bAutoAcptSwap_DR : 1U;
		USHORT bAutoReqSwap_DR  : 1U;
		USHORT bExtPwr          : 1U;
		USHORT                  : 1U;
		USHORT bDisableSrc      : 1U;
		USHORT bDisableSnk      : 1U;
		USHORT bDisableDFP      : 1U;
		USHORT bDisableUFP      : 1U;
	}bit;
	USHORT usData;
}SMBS_CCNF1;
#define SMBS_CCNF1_DISABLE_MASK (0xF000U)

typedef union {
	struct {
		USHORT bSrcMaxPwr    : 10U;
		USHORT bExtPwrCnst   : 1U;
		USHORT bExtPwrACDC   : 1U;
		USHORT bIntrPwrType  : 1U;
		USHORT bSrcPdoMax    : 3U;
	}bit;
	USHORT usData;
}SMBS_CCNF2;

void  smbs_init (UCHAR ucAddr, UCHAR ucClk, UCHAR ucAltEn);
UCHAR smbs_core(void);
USHORT smbs_get_version (void);

UCHAR smbs_get_cmd(UCHAR *ucCmd, UCHAR *ucTarget);
void  smbs_set_cmd_result(UCHAR ucResult);

USHORT smbs_get_ctrl_conf1(void);
void   smbs_set_ctrl_conf1(USHORT usData, UCHAR ucErr);

USHORT smbs_get_ctrl_conf2(void);
void   smbs_set_ctrl_conf2(USHORT usData, UCHAR ucErr);

UCHAR  smbs_get_obj_data_sel(void);
UCHAR  smbs_get_obj_data(USHORT *usData, UCHAR *ucSize, UCHAR *ucPos);
void   smbs_set_obj_data(USHORT *usData, UCHAR ucSize, UCHAR ucErr);

void   smbs_set_sys_conf1(USHORT usData);
void   smbs_set_sys_conf2(USHORT usData);
void   smbs_set_dev_cap  (USHORT usData);
void   smbs_set_usr_alrt  (void);
void   smbs_set_usr_status(UCHAR ucStat);
USHORT smbs_get_alrt_en(void);
void   smbs_set_alrt_en(USHORT usAlrtEn);

UCHAR smbs_is_deep_sleep(void);
void  smbs_intr_hdlr    (void);

extern SMBS_EVENT gSmbsEvent;

#endif // ___R9A02G011SMBS_H