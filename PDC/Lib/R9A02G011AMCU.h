#ifndef ___R9A02G011AMCU_H
#define ___R9A02G011AMCU_H

#include "typedefs.h"

typedef union {
	struct {
		USHORT bResetEn  : 1U;
		USHORT bResetDis : 1U;
		USHORT bReqTx    : 1U;
		USHORT bReqRst   : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
	}bit;
	USHORT usData;
}AMCU_EVENT;

typedef union {
	UCHAR  ucData[36];
	struct {
		UCHAR  ucPrtcl;
		UCHAR  ucCtrlFlg;
		UCHAR  ucLen;
		UCHAR  ucCmd;
		USHORT usData[16];
	}stTxMsg;
	struct{
		UCHAR ucPrtcl;
		UCHAR ucCtrlFlg;
		UCHAR ucLen;
		UCHAR ucCmd;
		UCHAR ucData[32];
	}stStdTxMsg;
	struct{
		UCHAR ucPrtcl;
		UCHAR ucCtrlFlg;
		UCHAR ucLen;
		UCHAR ucCmd;
		USHORT usLen;
		UCHAR ucData[30];
	}stTxRevMsg;
	struct{
		UCHAR ucPrtcl;
		UCHAR ucCtrlFlg;
		UCHAR ucLen;
		UCHAR ucCmd;
		UCHAR ucData[32];
	}stStdRxMsg;
	struct{
		UCHAR ucPrtcl;
		UCHAR ucCtrlFlg;
		UCHAR ucLen;
		UCHAR ucCmd;
		USHORT usRpLen;
		UCHAR ucRpCmd;
		UCHAR ucRpSt1;
		UCHAR ucRpSt2;
		UCHAR ucRpSt3;
		UCHAR ucChkSum;
		UCHAR ucData[25];
	}stRxStMsg;
	struct{
		UCHAR ucPrtcl;
		UCHAR ucCtrlFlg;
		UCHAR ucLen;
		UCHAR ucCmd;
		USHORT usRpLen;
		UCHAR ucRpCmd;
		UCHAR ucData[29];
	}stRxReqMsg;
}AMCU_SQ_BF;

// defines for amcu_get_status()
#define AMCU_STAT_INITIALIZE       (0x00U)
#define AMCU_STAT_IDLE             (0x01U)
#define AMCU_STAT_RUN              (0x02U)

// defines for amcu_init()
#define PDFU_SPRT_RESP             (0x08U)

UCHAR amcu_pd_core(void);
void amcu_init(ULONG address, UCHAR ucMode);
void amcu_set_err(void);
void amcu_set_stdby(void);
UCHAR amcu_get_status(void);
USHORT amcu_get_version(void);

extern AMCU_EVENT gAmcu;
extern AMCU_SQ_BF gAmcuBuf;

#endif // ___R9A02G011AMCU_H