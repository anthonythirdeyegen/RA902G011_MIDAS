#ifndef ___LED_CTRL_H
#define ___LED_CTRL_H

#include "typedefs.h"

#define SYS_PR_UNPLUG      0U
#define SYS_PR_ATT_SRC     1U
#define SYS_PR_ATT_SNK     2U

typedef union{
	struct {
		UCHAR bLedOn			: 1U;		// 
		UCHAR bLedOff           : 1U;       //
		UCHAR bPrChg			: 1U;		// 
		UCHAR bBatteryLevel		: 1U;		// show battery level
		UCHAR bReserved			: 4U;		// 
	}bits;
	UCHAR ucData;
}LED_REQUEST;

typedef union{
	struct {
		UCHAR bTypeCBlink		: 1U;		// 
		UCHAR bBattlvel			: 1U;		// 
		UCHAR bSysAttRole		: 2U;		// 
		UCHAR bReserved			: 4U;		// 
	}bits;
	UCHAR ucData;
}LED_STATUS;

typedef struct
{
	LED_STATUS uSt;
	LED_REQUEST uReq;
	UCHAR ucTypeCBlinkCnt;
	UCHAR ucBattLvlCnt;
}LED_INFO;

extern LED_INFO gLed;
UCHAR chk_led_active(void);
void led_init (void);
void led_ctrl (void);
#endif // ___LED_CTRL_H
