#ifndef ___DCDC_CTRL_H
#define ___DCDC_CTRL_H

#include "typedefs.h"

typedef union {
	struct {
		USHORT bSrcOff			: 1U;		// End Srouce Request
		USHORT bSrcOn			: 1U;		// Start Source Request
		USHORT bSrcChg			: 1U;		// Change Source Requeset
		USHORT bSnkOff			: 1U;		// End Sink Request 
		USHORT bReserved1		: 1U;		// 
		USHORT bSnkOn			: 1U;		// Start Sink Request
		USHORT bSnkChg			: 1U;		// Change Source Requeset
		USHORT bPoll			: 1U;		// Polling Requeset
		USHORT bClrAlert		: 1U;		// Clear #Alert
		USHORT bReserved		: 7U;		// 
	}bit;
	USHORT usData;
}DCDC_REQUEST;

typedef union {
	struct {
		USHORT bOtpAlert		: 1U;		// OTP Alert
		USHORT bOcpAlert		: 1U;		// OCP Alert
		USHORT bOvpAlert		: 1U;		// OVP Alert
		USHORT bGetInfo			: 1U;		// 
		USHORT bBatteryAlert	: 1U;		// Battery Alert
		USHORT bDcdcAlert		: 1U;		// DCDC Alert
		USHORT bReserved2		: 5U;		// 
		USHORT bUnexpected		: 1U;		// Unexpected Error
		USHORT bReserved3		: 1U;		// 
		USHORT bTrickleChange   : 1U;		// Trickle state changed
		USHORT bFullyCharge		: 1U;		// Fully_Charge
		USHORT bFullyDischarge	: 1U;		// Fully_Discharge
	}bit;
	USHORT usData;
}DCDC_NOTIFY;

typedef union {
	struct {
		USHORT bSubSt	: 8U;		// DCDC operation sub status
		USHORT bSt		: 4U;		// DCDC operation main status
		USHORT bDcSt	: 4U;		// Change Source Requeset
	}bit;
	USHORT usData;
}DCDC_STATUS;

typedef struct
{
	DCDC_REQUEST uReq;
	DCDC_NOTIFY uNtfy;
	DCDC_STATUS uSt;
	USHORT usRegData;
	USHORT usIntRegData;
	USHORT usVolt;
	USHORT usCur;
	UCHAR ucCmd;
	UCHAR ucInfo;
	UCHAR ucTrickeBkp;
	UCHAR ucTrickeCnt;
}DCDC_INFO;

extern DCDC_INFO gDCInfo;
void dcdc_ctrl(void);
void dcdc_init(void);

// Requeset Flag
#define DCDC_FLG_SRCOFF	((USHORT)0x0001)
#define DCDC_FLG_SNKOFF	((USHORT)0x0008)

#define DCDC_INIT	(0U)
#define DCDC_IDLE	(1U)
#define DCDC_SRC	(2U)
#define DCDC_SNK	(3U)

#define DCDC_NOTIFY_MASK	((USHORT)0xFFF0)

#define DCDC_MASK_REG_INFO1     (0x02U)  // bit 0-1
#define DCDC_MASK_REG_INFO2     (0x3CU)  // bit 2-5
#define DCDC_REG_INFO2_VSYS     (0x10U)

#endif // ___DCDC_CTRL_H