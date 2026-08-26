#ifndef ___MPPM_PB_DEFS_H
#define ___MPPM_PB_DEFS_H

#include "typedefs.h"

#define VAL_PB_BATTVOLMAX			((USHORT)12000U)
#define VAL_PB_BATTVOLMIN			((USHORT) 9000U)
#define VAL_PB_CHARGECURRENT		((USHORT) 2000U)
#define VAL_PB_DISCHGCURRENT		((USHORT) 6000U)
#define VAL_PB_EFFICIENCY			((USHORT)   85U)

#define USER_STATE_RESET_PR         (0x01U)
#define USER_STATE_NONPD_PLUGIN     (0x02U)
#define USER_STATE_SET_TRICKLE      (0x04U)

typedef struct {
	struct {
		UCHAR  bPlugState       : 1;       //0- Unplug 1-Plug
		UCHAR  bPowerRole       : 1;       //0- Sink, 1-Source
		UCHAR  bBatIsTrickle    : 1;       //0- Battery is Not Trickle state, 1-Battery is in Trickle State
		UCHAR  bAttachOrder     : 1;       //0- 1st Attach, 1- 2nd Attach
		UCHAR  bResetDcdcComp   : 1;
		UCHAR  bReserved        : 3;
	} bit;
	UCHAR ucReserved;
	USHORT usNegoCur;     // if bPowerRole =0(Sink), RDO.maxCur;  else RDO.operCur   (mA)
	USHORT usNegoVolt;    // (mV)
} OTH_PORT_INFO;

typedef struct {
	union {
		struct {
			UCHAR  bSrcChg        : 1;
			UCHAR  bSnkChg        : 1;
			UCHAR  bResetDcdcComp : 1;
			UCHAR  bReserved      : 5;
		} bit;
		UCHAR ucData;
	} uEvent;
	union {
		struct {
			UCHAR  bChgEn             : 1;
			UCHAR  bResetDcdcComp     : 1;
			UCHAR  bWaitingSet1stDcdc : 1;
			UCHAR  bReserved          : 5;
		} bit;
		UCHAR ucData;
	} uStat;
	OTH_PORT_INFO othPortInfo;
	ULONG  gulPSRC1;
	ULONG  gulPSRC2;
	ULONG  gulPBATC;
} MULTI_PORT_PB_INFO;

extern MULTI_PORT_PB_INFO gMpPb;


#endif //___MPPM_PB_DEFS_H