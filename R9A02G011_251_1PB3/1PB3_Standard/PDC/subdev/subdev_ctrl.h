#ifndef ___SUBDEV_CTRL_H
#define ___SUBDEV_CTRL_H

#include "typedefs.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif

/******************************************************************************
 Global values
******************************************************************************/
typedef struct
{
	UCHAR ucSubdevFlag;
	UCHAR ucSubdevHRFlag;
	UCHAR ucSubdevAlertFlag;
	UCHAR ucReserved;
}SUBDEV_INFO;

typedef struct
{
	UCHAR ucSubdev;
	UCHAR ucError;
}SUBDEV_ERR;

extern SUBDEV_INFO gSubdevInfo;
extern SUBDEV_ERR gSubDevErr;

#define SUBDEV_MAX_MESSAGE_DATA    (16)

/******************************************************************************
 Public fanctions
******************************************************************************/
void subdev_init(void);
void subdev_ctrl(void);
UCHAR subdev_get_alerthandler(void);
UCHAR subdev_get_alert_signal(void);

/******************************************************************************
 subdev_ctrl status
******************************************************************************/
#define SUBDEV_CTRL_STATE_IDLE					((UCHAR)0x00U)
#define SUBDEV_CTRL_STATE_SLEEP_READY			((UCHAR)0x01U)
#define SUBDEV_CTRL_STATE_SLEEP					((UCHAR)0x02U)

/******************************************************************************
 subdev driver status
******************************************************************************/
#define SUBDEV_DRV_IDLE							((UCHAR)0x00U)
#define SUBDEV_DRV_READY						((UCHAR)0x01U)
#define SUBDEV_DRV_ACTIVE						((UCHAR)0x02U)
#define SUBDEV_DRV_STRETCH_IDLE					((UCHAR)0x06U)
#define SUBDEV_DRV_STRETCH_READY				((UCHAR)0x07U)
#define SUBDEV_DRV_ACTIVE2						((UCHAR)0x0EU)
#define SUBDEV_DRV_END							((UCHAR)0x08U)

// IDLE state
#define SUBDEV_DRV_STATE_IDLE					(SUBDEV_DRV_IDLE)

// status for PDM
#define SUBDEV_DRV_STATE						((UCHAR)0x80U)
#define SUBDEV_DRV_STATE_READY					(SUBDEV_DRV_STATE | SUBDEV_DRV_READY)
#define SUBDEV_DRV_STATE_ACTIVE					(SUBDEV_DRV_STATE | SUBDEV_DRV_ACTIVE)
#define SUBDEV_DRV_STATE_STRETCH_IDLE			(SUBDEV_DRV_STATE | SUBDEV_DRV_STRETCH_IDLE)
#define SUBDEV_DRV_STATE_STRETCH_READY			(SUBDEV_DRV_STATE | SUBDEV_DRV_STRETCH_READY)
#define SUBDEV_DRV_STATE_ACTIVE2				(SUBDEV_DRV_STATE | SUBDEV_DRV_ACTIVE2)
#define SUBDEV_DRV_STATE_END					(SUBDEV_DRV_STATE | SUBDEV_DRV_END)

// status for ALERT#
#define SUBDEV_DRV_STATE_ALERT					((UCHAR)0x40U)
#define SUBDEV_DRV_STATE_ALERT_READY			(SUBDEV_DRV_STATE_ALERT | SUBDEV_DRV_READY)
#define SUBDEV_DRV_STATE_ALERT_ACTIVE			(SUBDEV_DRV_STATE_ALERT | SUBDEV_DRV_ACTIVE)
#define SUBDEV_DRV_STATE_ALERT_STRETCH_IDLE		(SUBDEV_DRV_STATE_ALERT | SUBDEV_DRV_STRETCH_IDLE)
#define SUBDEV_DRV_STATE_ALERT_STRETCH_READY	(SUBDEV_DRV_STATE_ALERT | SUBDEV_DRV_STRETCH_READY)
#define SUBDEV_DRV_STATE_ALERT_END				(SUBDEV_DRV_STATE_ALERT | SUBDEV_DRV_END)

// status for TIMER
#define SUBDEV_DRV_STATE_TIMER					((UCHAR)0x20U)
#define SUBDEV_DRV_STATE_TIMER_READY			(SUBDEV_DRV_STATE_TIMER | SUBDEV_DRV_READY)
#define SUBDEV_DRV_STATE_TIMER_ACTIVE			(SUBDEV_DRV_STATE_TIMER | SUBDEV_DRV_ACTIVE)
#define SUBDEV_DRV_STATE_TIMER_STRETCH_IDLE		(SUBDEV_DRV_STATE_TIMER | SUBDEV_DRV_STRETCH_IDLE)
#define SUBDEV_DRV_STATE_TIMER_STRETCH_READY	(SUBDEV_DRV_STATE_TIMER | SUBDEV_DRV_STRETCH_READY)
#define SUBDEV_DRV_STATE_TIMER_END				(SUBDEV_DRV_STATE_TIMER | SUBDEV_DRV_END)

/******************************************************************************
 subdev_ctrl process
******************************************************************************/
#define SUBDEV_NO_RUN							((UCHAR)0x00)
#define SUBDEV_RUN_ALERT						((UCHAR)0x01)
#define SUBDEV_RUN								((UCHAR)0x02)
#define SUBDEV_RUN_TIMER						((UCHAR)0x03)

/******************************************************************************
 Mask of Active device
******************************************************************************/
#define SUBDEV_ACTIVE_MASK						((UCHAR)0x00)

#endif // ___SUBDEV_CTRL_H
