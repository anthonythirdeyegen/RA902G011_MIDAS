#ifndef ___LED_CTRL_H
#define ___LED_CTRL_H

#include "typedefs.h"


typedef union{
	struct {
		UCHAR bSrcEn : 1U;
		UCHAR bSnkEn : 1U;
		UCHAR bDis   : 1U;
		UCHAR        : 5U;
	}bits;
	UCHAR ucData;
}LED_REQUEST;

typedef struct
{
	LED_REQUEST uReq;
	UCHAR ucTypeCBlinkCnt;
}LED_INFO;

extern LED_INFO gLed;

void led_init (void);
UCHAR led_ctrl (void);
#endif // ___LED_CTRL_H
