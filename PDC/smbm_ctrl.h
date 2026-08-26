#ifndef ___SMBM_CTRL_H
#define ___SMBM_CTRL_H

#include "typedefs.h"

/******************************************************************************
 Global values
******************************************************************************/
typedef struct {
	UCHAR ucSmbmStatus;
	UCHAR ucSmbmCtrl;
	UCHAR ucSmbmError;
	UCHAR ucAlertFlg;
	USHORT usSmbmTimeOut;
	USHORT usSmbmDataLen;
	__far USHORT *pusSmbmData;
}SMBM_INFO;

extern SMBM_INFO gSmbmInfo;

/******************************************************************************
 Public fanctions
******************************************************************************/
void smbm_init(void);
void smbm_ctrl(void);
void smbm_set_subdev(UCHAR ucCLKMode, UCHAR ucSlaveAddr);
void smbm_set_protocol(UCHAR ucCmdCode, UCHAR ucSmbmProtocol, UCHAR ucPEC, UCHAR ucOption, USHORT *pusData, USHORT usDataLen, USHORT usTimeOut);
void smbm_clr_status(void);
void smbm_reset(void);

void smbm_int_write_routine(void);
void smbm_int_read_routine(void);
/******************************************************************************
 smbm_ctrl status
******************************************************************************/
#define SMBM_CTRL_STATE_IDLE			((UCHAR)0x00U)
#define SMBM_CTRL_STATE_READY			((UCHAR)0x01U)
#define SMBM_CTRL_STATE_ACTIVE			((UCHAR)0x02U)
#define SMBM_CTRL_STATE_STRETCH			((UCHAR)0x06U)
#define SMBM_CTRL_STATE_STRECH_READY	((UCHAR)0x07U)
#define SMBM_CTRL_STATE_COMPLETE		((UCHAR)0x08U)
#define SMBM_CTRL_STATE_ERROR			((UCHAR)0x18U)

#define SMBM_ERROR_STATUS				((UCHAR)0x0001)
#define SMBM_ERROR_PEC					((UCHAR)0x0002)
#define SMBM_ERROR_TRANSFER				((UCHAR)0x0004)
#define SMBM_ERROR_TIMEOUT				((UCHAR)0x0008)

/******************************************************************************
 SMBus Master Status Register(SMBMCON)
******************************************************************************/
#define SMBMCON_SMB_RUN					((UCHAR)0x01U)
#define SMBMCON_I2C_RUN_STOP			((UCHAR)0x02U)
#define SMBMCON_LAST_PACKET				((UCHAR)0x04U)
#define SMBMCON_I2C_RESTART				((UCHAR)0x08U)
#define SMBMCON_I2C_STOP				((USHORT)0x0000U)

#define SMBM_I2C_START				((UCHAR)0x00)
#define SMBM_I2C_CLK_STRETCH_START	((UCHAR)0x01)
#define SMBM_SMB_START				((UCHAR)0x02)


/******************************************************************************
 SMBus Master Status Register(SMBMSTA)
******************************************************************************/
#define SMBMSTA_TRANSFERING				((UCHAR)0x00)

#define SMBMSTA_TRANSFER_COMP			((USHORT)0x01U)
#define SMBMSTA_TRANSFER_ERROR			((USHORT)0x02U)
#define SMBMSTA_PEC_ERROR				((USHORT)0x04U)
#define SMBMSTA_I2C_STRETCH				((USHORT)0x08U)
#define SMBMSTA_CLEAR					((USHORT)0x000FU)

#define SMBMSTA_ALERT_ON				((UCHAR)0x01)
#define SMBMSTA_ALERT_OFF				((UCHAR)0x00)

/******************************************************************************
 SMBus Master Interrupt Enable(SMBMINT)
******************************************************************************/
#define SMBMINT_ALL_CLEAR				((USHORT)0x0000)
#define SMBMINT_CLEAR_MASK				((USHORT)0xFF00)
#define SMBMINT_TRANSFER_COMPLETE		((USHORT)0x0001)
#define SMBMINT_I2C_STRETCH				((USHORT)0x0008)
#define SMBMINT_ALERT_STATUS			((USHORT)0x0100)
#define SMBMINT_VALUE_ALL				(SMBMINT_TRANSFER_COMPLETE | SMBMINT_I2C_STRETCH | SMBMINT_ALERT_STATUS)
#define SMBMINT_VALUE_TRANSFER			(SMBMINT_TRANSFER_COMPLETE | SMBMINT_I2C_STRETCH )

/******************************************************************************
 SMBus  Master Slave Address Register(SMBMADD)
******************************************************************************/
#define SMBM_CLOCK_100K				((UCHAR)0x00)
#define SMBM_CLOCK_400K				((UCHAR)0x02)
#define SMBM_CLOCK_1M				((UCHAR)0x03)

/******************************************************************************
 SMBus Master Command Register(SMBMCOM)
******************************************************************************/
#define SMBMP_I2C_MASK					((UCHAR)0x01)

#define SMBM_BYTE_WRITE					((UCHAR)0x06)
#define SMBM_BYTE_READ					((UCHAR)0x07)
#define SMBM_WORD_WRITE					((UCHAR)0x08)
#define SMBM_WORD_READ					((UCHAR)0x09)
#define SMBM_BLOCK_WRITE				((UCHAR)0x0A)
#define SMBM_BLOCK_WRITE_1				((UCHAR)0x1A)
#define SMBM_BLOCK_READ					((UCHAR)0x0B)
#define SMBM_BLOCK_READ_1				((UCHAR)0x1B)

#define SMBM_PEC_ENABLE					((UCHAR)0x80)
#define SMBM_PEC_DISABLE				((UCHAR)0x00)


#endif // ___SMBM_CTRL_H
