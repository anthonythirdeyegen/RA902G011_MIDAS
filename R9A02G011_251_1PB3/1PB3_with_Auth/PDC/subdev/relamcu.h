#ifndef ___RELAMCU_CTRL_H
#define ___RELAMCU_CTRL_H

#include "typedefs.h"

/******************************************************************************
 Global values
******************************************************************************/
typedef struct 
{
	UCHAR ucSt;
	UCHAR ucReserved;
}RELAMCU_INFO;

extern RELAMCU_INFO gRelamcuInfo;

/******************************************************************************
 Public fanctions
******************************************************************************/
void init_relamcu(void);
void relamcu_ctrl(void);
void relamcu_reset(void);
void relamcu_reset_err(void);

/******************************************************************************
 subdev_ctrl process
******************************************************************************/
#define RELAMCU_DEVICE_ID			((UCHAR)0x02U)

#endif // ___RELAMCU_CTRL_H
