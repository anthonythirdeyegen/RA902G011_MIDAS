#ifndef ___SLAVEPDC_CTRL_H
#define ___SLAVEPDC_CTRL_H

#include "typedefs.h"

/******************************************************************************
 Global values
******************************************************************************/

/******************************************************************************
 Public fanctions
******************************************************************************/
void init_slavepdc(void);
void slavepdc_ctrl(void);
void slavepdc_alert(void);

typedef struct
{
	UCHAR ucSt;
	UCHAR ucAlertSt;
	UCHAR ucAlertReadCnt;
	UCHAR reserved;
}SLAVEPDC_INFO;

extern SLAVEPDC_INFO gSlavePdcInfo;
/******************************************************************************
 subdev_ctrl process
******************************************************************************/
#define SLAVEPDC_DEVICE_ID			((UCHAR)0x02U)

/******************************************************************************
// UVS MASK Flags
******************************************************************************/

#endif // ___SLAVEPDC_CTRL_H
