#ifndef ___USER_MAIN_BATTERY_H
#define ___USER_MAIN_BATTERY_H

#include "typedefs.h"

#define BAT_LEVEL_EMP		(0U)
#define BAT_LEVEL_LOW		(1U)
#define BAT_LEVEL_MID		(2U)
#define BAT_LEVEL_HIGH		(3U)
#define BAT_LEVEL_FULL		(4U)
#define BAT_LEVEL_INVALID	(0x07U)

// bSt
#define BATTERY_INIT			(0U)
#define BATTERY_INIT_IDLE		(5U)
#define BATTERY_IDLE			(1U)
#define BATTERY_POLLING			(2U)
#define BATTERY_EMPTY			(3U)
#define BATTERY_EXIT_EMPTY_MODE	(4U)

// bSubSt
#define BATTERY_EMP_SUB_IDLE	(9U)
#define BATTERY_EMP_SUB_S1		(10U)
#define BATTERY_EMP_SUB_S2		(11U)
#define BATTERY_EMP_SUB_S3		(12U)

#define BATTERY_EEM_SUB_IDLE	(13U)
#define BATTERY_EEM_SUB_S1		(14U)
#define BATTERY_EEM_SUB_S2		(15U)
#define BATTERY_EEM_SUB_S3		(16U)
#define BATTERY_EEM_SUB_S4		(17U)

// bIntrSt
#define BATTERY_INTR_IDLE		(0U)
#define BATTERY_INTR_S0			(1U)
#define BATTERY_INTR_S1			(2U)
#define BATTERY_INTR_S2			(3U)
#define BATTERY_INTR_S3			(4U)
#define BATTERY_INTR_S4			(5U)
#define BATTERY_INTR_S5			(6U)
#define BATTERY_INTR_S6			(7U)
#define BATTERY_INTR_S7			(8U)
#define BATTERY_INTR_S8			(9U)

typedef struct 
{
	UCHAR bSubSt	: 5U;		// BATTERY operation sub status
	UCHAR bSt		: 3U;		// BATTERY operation main status
}BATTERY_STATUS;

typedef struct
{
	UCHAR bSinkOff	    : 1U;
	UCHAR bFullyCharge  : 1U;
	UCHAR bDSleepExit   : 1U;
	UCHAR               : 1U;
	UCHAR bFixedRole    : 1U;
	UCHAR bReserved     : 3U;
}BATTERY_REQ;

typedef struct
{
	UCHAR bOneShot	: 1U;
	UCHAR bIntrSt	: 4U;
	UCHAR bReserved	: 3U;
}BATTERY_INTR;

typedef struct 
{
	UCHAR bBatteryLevel	    : 3U;
	UCHAR bBatteryLevelBak 	: 3U;
	UCHAR bOutLowBatMode    : 1U;
	UCHAR bTrickle		    : 1U;
}BATTERY_STATUS2;

typedef struct
{
	BATTERY_STATUS 	uSt;
	BATTERY_REQ 	uReq;
	BATTERY_INTR	uIntr;
	BATTERY_STATUS2	uSt2;
	ULONG ulBatteryAd;
}BATTERY_INFO;

extern BATTERY_INFO gBatInfo;
UCHAR user_func_chk_battery (void);
void user_func_chk_oneshot_battery (void);
void user_func_stop_oneshot_battery (void);
USHORT user_func_get_battery_level (void);
void battery_init(void);

#endif //___USER_MAIN_BATTERY_H
