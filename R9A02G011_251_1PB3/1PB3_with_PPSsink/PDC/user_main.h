#ifndef ___USER_MAIN_H
#define ___USER_MAIN_H

#include "typedefs.h"

#define DSLEEP_IDLE                  (0U)
#define DSLEEP_ST_DIS_TYPEC          (1U)
#define DSLEEP_ST_WAI_DIS_TYPEC      (2U)
#define DSLEEP_ST_ENTER_DEEP         (3U)
#define DSLEEP_ST_EN_TYPEC           (4U)
#define DSLEEP_ST_EXIT_DEEP          (5U)

#define PDO_SPLY_FIX (0U)
#define PDO_SPLY_BAT (1U)
#define PDO_SPLY_VAR (2U)
#define PDO_SPLY_PPS (3U)

#define NOT_PERIOD (0U)
#define IS_PERIOD  (1U)

typedef union {
	struct {
		ULONG bMinMax    : 10;
		ULONG bOpr       : 10;
		ULONG            : 3;
		ULONG bUnChkSprt : 1;
		ULONG bNoSusp    : 1;
		ULONG bUSBComm   : 1;
		ULONG bMissCap   : 1;
		ULONG bGB        : 1;
		ULONG bObjPos    : 3;
		ULONG            : 1;
	}bit;
	struct {
		ULONG bCur       : 7;
		ULONG            : 2;
		ULONG bVolt      : 11;
		ULONG            : 3;
		ULONG bUnChkSprt : 1;
		ULONG bNoSusp    : 1;
		ULONG bUSBComm   : 1;
		ULONG bMissCap   : 1;
		ULONG            : 1;
		ULONG bObjPos    : 3;
		ULONG            : 1;
	}bit_pps;
	UCHAR  ucData[4];
	USHORT usData[2];
	ULONG  ulData;
}RDO;

typedef union {
	struct {
		ULONG bMaxCur    : 10;
		ULONG bVolt      : 10;
		ULONG bPeakCur   : 2;
		ULONG            : 2;
		ULONG bUnChkSprt : 1;
		ULONG bDrSwap    : 1;
		ULONG bUsbComm   : 1;
		ULONG bExtPwr    : 1;
		ULONG bSuspend   : 1;
		ULONG bDrp       : 1;
		ULONG bSupply    : 2;
	} stFixSrc;

	struct {
		ULONG bOpeCur    : 10;
		ULONG bVolt      : 10;
		ULONG            : 3;
		ULONG bFrSwap    : 2;
		ULONG bDrSwap    : 1;
		ULONG bUsbComm   : 1;
		ULONG bExtPwr    : 1;
		ULONG bHiCap     : 1;
		ULONG bDrp       : 1;
		ULONG bSupply    : 2;
	} stFixSnk;

	struct {
		ULONG bMaxCur    : 10;
		ULONG bMinVolt   : 10;
		ULONG bMaxVolt   : 10;
		ULONG bSupply    : 2;
	} stVarSrc;

	struct {
		ULONG bOpeCur    : 10;
		ULONG bMinVolt   : 10;
		ULONG bMaxVolt   : 10;
		ULONG bSupply    : 2;
	} stVarSnk;

	struct {
		ULONG bMaxPwr    : 10;
		ULONG bMinVolt   : 10;
		ULONG bMaxVolt   : 10;
		ULONG bSupply    : 2;
	} stBatSrc;

	struct {
		ULONG bOpePwr    : 10;
		ULONG bMinVolt   : 10;
		ULONG bMaxVolt   : 10;
		ULONG bSupply    : 2;
	} stBatSnk;

	struct {
		ULONG bMaxCur    : 7;
		ULONG            : 1;
		ULONG bMinVolt   : 8;
		ULONG            : 1;
		ULONG bMaxVolt   : 8;
		ULONG            : 3;
		ULONG bPps       : 2;
		ULONG bSupply    : 2;
	} stPpsSrc;

	UCHAR  ucData[4];
	USHORT usData[2];
	ULONG  ulData;
}PDO;

void  user_func_event(void);
UCHAR user_func_chk_device(void);
UCHAR user_func_snd_mess  (void);
void  user_init(void);
void  user_intrusive_request(UCHAR ucPeriod);

#endif // ___USER_MAIN_H