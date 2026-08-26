#ifndef __MPPM_H__
#define __MPPM_H__

#include "typedefs.h"

/* PDC NAME */
#define MPPM_MAX_SYSTEM_PWR					(45U * 4U)		// 250mW unit
#define MPPM_PORT_NUM_MAX					(2U)

#define MPPM_PORT_MASTER                    (0U)
#define MPPM_PORT_SLAVE1                    (1U)

/* <Mppm Control> */ 
/* Request Response */
//#define MPPM_CNT_REQRES_RESERVED            (0U)
#define MPPM_CNT_REQRES_ACCEPT              (1U)
#define MPPM_CNT_REQRES_REJECT              (2U)
#define MPPM_CNT_REQRES_WAIT                (3U)
//#define MPPM_CNT_REQRES_MASK                (0x0003U)

/* Rp Mode */
#define MPPM_CNT_RPMODE_MASK				(0x000CU)
/* Rp setting (SCNT_MODE1_HW) */
#define MPPM_RP_BIT_MASK                 	(0x18U)
#define MPPM_RP_HIGHC_BIT                   (0U)
#define MPPM_RP_MIDC_BIT                    (1U)
#define MPPM_RP_DEFC_BIT                    (2U)

#define MPPM_RP_HIGHC_BIT_SET				(0x18U)
#define MPPM_RP_MIDC_BIT_SET				(0x08U)
#define MPPM_RP_DEFC_BIT_SET				(0x00U)

/* ucStPort */
/* State Transition (bGstatus) */
#define	MPPM_PORT_ST_INIT_GETSTAT			(0U)
#define	MPPM_PORT_ST_EXCUTE_RD_STATUS		(1U)
#define	MPPM_PORT_ST_END_GETSTAT			(3U)

#define	MPPM_PORT_ID_RD_STATUS1				(1U)
#define	MPPM_PORT_ID_RD_STATUS2				(2U)

/* State Transition (bFuncStatus) */
#define MPPM_PORT_ST_INIT_ETC_FUNCTION      (0U)

#define	MPPM_PORT_ST_EXCUTE_VENCOM_CHGSRC	(1U)
#define	MPPM_PORT_ST_END_VENCOM_CHGSRC		(2U)

#define MPPM_PORT_ST_WAI_VENCOM_NEWREQ      (3U)
#define MPPM_PORT_ST_RD_VENCOM_NEWREQ       (4U)
#define MPPM_PORT_ST_END_VENCOM_NEWREQ		(5U)

#define MPPM_PORT_ST_WAI_VENCOM_UPDPWR      (6U)
#define MPPM_PORT_ST_WAI_VENCOM_UPDPWR_X    (7U)

#define MPPM_PORT_ST_WAI_VENCOM_SET_PORTINFO (8U)

#define MPPM_PORT_ST_WAI_VENCOM_CHGPWR      (0x0AU)
#define MPPM_PORT_ST_INIT_VENCOM_CHGPWR     (0x0BU)
#define MPPM_PORT_ST_END_VENCOM_CHGPWR		(0x0CU)



#define MPPM_PORT_ST_PORTINFO_SET_OBJMODE1  (0U)
#define MPPM_PORT_ST_PORTINFO_WAI_OBJMODE1  (1U)
#define MPPM_PORT_ST_PORTINFO_WAI_OBJDATA1  (2U)
#define MPPM_PORT_ST_PORTINFO_SET_OBJMODE2  (3U)
#define MPPM_PORT_ST_PORTINFO_WAI_OBJMODE2  (4U)
#define MPPM_PORT_ST_PORTINFO_WAI_OBJDATA2  (5U)

/* State For Check Trickle */
#define CHK_TRICKLE_IDLE                    (0U)
#define CHK_TRICKLE_MST_WAI_POLL            (1U)
#define CHK_TRICKLE_MST_WAI_RSLT            (2U)
#define CHK_TRICKLE_MST_WAI_DCDC_CHG_COMP   (3U)
#define CHK_TRICKLE_SLV_WAI_POLL            (4U)
#define CHK_TRICKLE_SLV_SET_OBJMOD          (5U)
#define CHK_TRICKLE_SLV_WAI_OBJMOD          (6U)
#define CHK_TRICKLE_SLV_WAI_OBJDATA         (7U)
#define CHK_TRICKLE_SLV_GET_OBJDATA         (8U)
#define CHK_TRICKLE_SLV_WAI_DCDC_CHG_COMP   (9U)

/* State For Check slave resetting dcdc */
#define CHK_SLV_RESET_DCDC_SET_OBJMODE1     (0U)
#define CHK_SLV_RESET_DCDC_WAI_OBJMODE1     (1U)
#define CHK_SLV_RESET_DCDC_WAI_OBJDATA1     (2U)


/* PORT_STAT Mask */
#define MPPM_PORT_ST_FLAG_NUM				(0x06U)

#define MPPM_PORT_ST_MASK_ALL_LOW			(0x0FU)
#define MPPM_PORT_ST_MASK_ALL_HIGH			(0xF0U)

#define MPPM_PORT_ST_FLAG_MASK				(0x11U)

/* Alert Mask */
#define MPPM_SMBS_AL_MSK_ERROR              (0x0001U)
#define MPPM_SMBS_AL_MSK_CMD_COMP           (0x0004U)
#define MPPM_SMBS_AL_MSK_PLG_CHG            (0x0008U)
#define MPPM_SMBS_AL_MSK_PWR_ROLE_CHG       (0x0010U)
#define MPPM_SMBS_AL_MSK_NEW_REQUEST        (0x2000U)	// bit13:bNewRequest(rev780~)
#define MPPM_SMBS_AL_MSK_OBJ_DAT_RDY        (0x0400U)
#define MPPM_SMBS_AL_MSK_NEW_CONT           (0x1000U)
#define MPPM_SMBS_AL_MSK_CLEAR              (0xFFFFU)

/* Power */
#define MPPM_SYS_PWR_P250_DIVUNIT             (250U)
#define MPPM_SYS_PWR_P05_DIVUNIT              (500U)
#define MPPM_INIT_PWR_MAX_P250                (15000U / MPPM_SYS_PWR_P250_DIVUNIT)    /* 15.0W[250mW UNIT] */
#define MPPM_INIT_PWR_MIN_P250                ( 4500U / MPPM_SYS_PWR_P250_DIVUNIT)    /*  4.5W[250mW UNIT] */
#define MPPM_INIT_CONSUM_PWR_P250             ( 7000U / MPPM_SYS_PWR_P250_DIVUNIT)    /*  7.0W[250mW UNIT] */

/* For ALERT_INFO */
#define MPPM_MASK_ALERT_INFO_MS                 (0x0000003FU)
#define MPPM_MASK_ALERT_INFO_S1                 (0x00000FC0U)
#define MPPM_MASK_ALERT_INFO_S2                 (0x0003F000U)
#define MPPM_MASK_ALERT_INFO_S3                 (0x00FC0000U)
#define MPPM_MASK_ALERT_INFO_BASE               (MPPM_MASK_ALERT_INFO_MS)
#define MPPM_SHIFT_ALERT_INFO_MS                (0U)
#define MPPM_SHIFT_ALERT_INFO_S1                (6U)
#define MPPM_SHIFT_ALERT_INFO_S2                (12U)
#define MPPM_SHIFT_ALERT_INFO_S3                (18U)
#define MPPM_SHIFT_ALERT_INFO_BASE              (6U)

#define MASTER_DEVICE_ID       ((UCHAR)0x00U)

// subdev command
#define	MPPM_GET_STATUS1						(1U)
#define	MPPM_GET_STATUS2						(2U)
#define	MPPM_SET_COMMAND						(3U)
#define	MPPM_SET_CTRLCNF2						(4U)
#define	MPPM_SET_OBJDATAMODE     				(5U)
#define	MPPM_GET_RDODATA						(6U)
#define MPPM_SET_PORTINFODATA                   (7U)
#define MPPM_GET_SELFPORTDATA                   (8U)
#define MPPM_GET_TRICKLE_STATE                  (9U)

#define	MPPM_ALERT								(0x80U)

#define	MAX_NUM_OF_PDO							(7)

#define	SMBS_SYS_EXT_PWR						(0x02U)
#define	SMBS_SYS_INTR_PWR						(0x08U)
#define	SMBS_SYS_EXT_PWR_AC						(0x04U)
#define	SMBS_SYS_INTR_PWR_NOBAT					(0x10U)

#define	SMBS_OBJDATA_NUM						(1U)

#define	SMBM_CMD_SND_ACPT						(0xA0U)
#define	SMBM_CMD_SND_RJCT						(0xA1U)
#define	SMBM_CMD_SND_WAIT						(0xA2U)
#define	SMBM_CMD_RESET_PR        				(0xA3U)
#define	SMBM_CMD_SET_DCDC        				(0xA4U)

typedef union {
	struct {
		ULONG bMaxCur    : 10;
		ULONG bVolt      : 10;
		ULONG bPeakCur   :  2;
		ULONG            :  2;
		ULONG bUnChkSprt :  1;
		ULONG bDrSwap    :  1;
		ULONG bUsbComm   :  1;
		ULONG bExtPwr    :  1;
		ULONG bSuspend   :  1;
		ULONG bDrp       :  1;
		ULONG bSupply    :  2;
	} stFixSrc;

	struct {
		ULONG bOpeCur   : 10;
		ULONG bVolt     : 10;
		ULONG           :  3;
		ULONG bFrSwap   :  2;
		ULONG bDrSwap   :  1;
		ULONG bUsbComm  :  1;
		ULONG bExtPwr   :  1;
		ULONG bHiCap    :  1;
		ULONG bDrp      :  1;
		ULONG bSupply   :  2;
	} stFixSnk;

	struct {
		ULONG bMaxCur   : 10;
		ULONG bMinVolt  : 10;
		ULONG bMaxVolt  : 10;
		ULONG bSupply   :  2;
	} stVarSrc;

	struct {
		ULONG bOpeCur   : 10;
		ULONG bMinVolt  : 10;
		ULONG bMaxVolt  : 10;
		ULONG bSupply   :  2;
	} stVarSnk;

	struct {
		ULONG bMaxPwr   : 10;
		ULONG bMinVolt  : 10;
		ULONG bMaxVolt  : 10;
		ULONG bSupply   :  2;
	} stBatSrc;

	struct {
		ULONG bOpePwr   : 10;
		ULONG bMinVolt  : 10;
		ULONG bMaxVolt  : 10;
		ULONG bSupply   :  2;
	} stBatSnk;

	struct {
		ULONG bMaxCur   :  7;
		ULONG           :  1;
		ULONG bMinVolt  :  8;
		ULONG           :  1;
		ULONG bMaxVolt  :  8;
		ULONG           :  3;
		ULONG bPps      :  2;
		ULONG bSupply   :  2;
	} stPpsSrc;

	UCHAR  ucData[4];
	USHORT usData[2];
	ULONG  ulData;
}PDO;

typedef union {
		struct {
			USHORT bErr         : 1U;
			USHORT bHardReset   : 1U;
			USHORT bCmdComp     : 1U;
			USHORT bPlugChg     : 1U;
			USHORT bPrChg       : 1U;
			USHORT bDrChg       : 1U;
			USHORT bSoftReset   : 1U;
			USHORT bWakeup      : 1U;
			USHORT bUsrEvt      : 1U;
			USHORT bExtPwr      : 1U;
			USHORT bObjDataRdy  : 1U;
			USHORT bRcvVDM      : 1U;
			USHORT bNewContract : 1U;
			USHORT bNewRequest  : 1U;
			USHORT bChkRcvPDM   : 1U;
			USHORT bSndAlert    : 1U;
		}bit;
		USHORT usData;
}SMBS_ALT;

typedef union {
    struct {
		USHORT usLowerData;
		USHORT usUpperData;
    } us;
    struct {
        ULONG  bObjDataSlct : 8;
        ULONG  bRecipient   : 2;
        ULONG               : 5;
        ULONG  bObjDataMode : 1;
        ULONG  bDataSize    : 8;
        ULONG  bDataPos     : 8;
    } bit;
    ULONG ulData;
} SMBS_OBJDTMD;

typedef union {
    struct {
        USHORT     usData;
    } us;
    struct {
        USHORT     *pucArray;
    } puc;
	USHORT   usData;
} SUBDEV_IF;

typedef union {
    struct {
        USHORT bRemaingPwr    : 10;
        USHORT 				  : 6;
    } bit;
    USHORT   usData;
} SYS_INFO;

#if 1
typedef struct {
	SMBS_ALT  usAlert[MPPM_PORT_NUM_MAX];
} ALERT_INFO;
#else
typedef union {
    struct {
        ULONG bMsErr          : 1;
        ULONG bMsCmdComp      : 1;
        ULONG bMsPlugChg      : 1;
        ULONG bMsRoleChg      : 1;
		ULONG bMsNewReq       : 1;
		ULONG bMsObjDtRdy     : 1;

        ULONG bSv1Err         : 1;
        ULONG bSv1CmdComp     : 1;
        ULONG bSv1PlugChg     : 1;
        ULONG bSv1RoleChg     : 1;
        ULONG bSv1NewReq      : 1;
        ULONG bSv1ObjDtRdy    : 1;

        ULONG bSv2Err         : 1;
        ULONG bSv2CmdComp     : 1;
        ULONG bSv2PlugChg     : 1;
        ULONG bSv2RoleChg     : 1;
        ULONG bSv2NewReq      : 1;
        ULONG bSv2ObjDtRdy    : 1;

        ULONG bSv3Err         : 1;
        ULONG bSv3CmdComp     : 1;
        ULONG bSv3PlugChg     : 1;
        ULONG bSv3RoleChg     : 1;
        ULONG bSv3NewReq      : 1;
        ULONG bSv3ObjDtRdy    : 1;

        ULONG bMsTccDis       : 1;
        ULONG bSv1TccDis      : 1;
        ULONG bSv2TccDis      : 1;
        ULONG bSv3TccDis      : 1;
       
		ULONG                 : 4;
    } bit;
    ULONG   ulData;
} ALERT_INFO;
#endif

typedef union {
	struct {
		UCHAR				: 1;
		UCHAR	bGetStatus	: 2;
		UCHAR	bFuncStatus	: 4;
		UCHAR				: 1;
	} bit;
	UCHAR ucData;
} STATE_TRANS;

typedef union {
	struct {
		USHORT bChgSrc		 : 1;
		USHORT bNewReq		 : 1;
		USHORT bChgPwr		 : 1;
		USHORT bSetComp		 : 1;
		USHORT bSrcEn		 : 1;
		USHORT bReSetting	 : 1;
		USHORT bPortWait	 : 1;
		USHORT bPwrSave		 : 1;
		USHORT bReReq		 : 1;
		USHORT bUnPlug		 : 1;
		USHORT bCompStatus	 : 1;
		USHORT bCmdComp		 : 2;
		USHORT bChgDcdc		 : 1;
		USHORT bChkTrickle 	 : 1;
		USHORT bChkResetDcdc : 1;
		
	} bit;
	USHORT usData;
} PORT_EVENT;

typedef union {
		struct {
			USHORT	bCmdStat	: 1U;
			USHORT	bLastCmd	: 3U; // 000b:ok, 001b:abort, 010b:invalid, 011b:rjct or not supported, 100b:wait, 111b:Cancel
			USHORT	bCurPDO		: 3U;
			USHORT				: 1U;
			USHORT	bSOPP		: 1U;
			USHORT	bSOPPP		: 1U;
			USHORT				: 1U;
			USHORT	bPlugDet	: 1U;
			USHORT	bVC			: 1U;
			USHORT	bBrl		: 1U;
			USHORT	bDR			: 1U;
			USHORT	bPR			: 1U;
		}bit_st1;
		struct {
			USHORT	bSmbsErr	: 2U;
			USHORT	bConfErr	: 1U;
			USHORT	bRjctNego	: 1U;
			USHORT	bObjSelErr	: 1U;
			USHORT	bOverVolt	: 1U;
			USHORT	bOverCur	: 1U;
			USHORT	bOverTemp	: 1U;
			USHORT	bNonPD		: 1U;
			USHORT	bMisCap		: 1U;
			USHORT	bRstPr		: 1U; 
			USHORT	bNonPDPlugIn : 1U;
			USHORT	bSetTrickle : 1U;
			USHORT	            : 1U;
			USHORT	bComRevPDC	: 1U;
			USHORT	bComRevCP	: 1U;
		}bit_st2;
		USHORT usData;
}SMBS_DATA;

typedef union {
	struct {
		USHORT bReqResp     : 2U;
		USHORT bRpMode      : 2U;
		USHORT bMaxPwr      : 10U;
		USHORT 			    : 1U;
		USHORT bIntrusive   : 1U;
	} bit;
	USHORT data;
} SMBS_VENCOM;

typedef union {
	struct {
		UCHAR bGetSnkData       : 1;
		UCHAR bSetPortInfoComp  : 1;
		UCHAR bChkInit          : 1;
		UCHAR bAttSnk           : 1;
		UCHAR bTrickle          : 1;
		UCHAR bResetDcdcComp    : 1;
		UCHAR bUsrEvtEn         : 1;
		UCHAR                   : 1;
	}bit;
	UCHAR data;
} PORT_FLAG;

typedef struct {
	STATE_TRANS ucStPort;			// Master & Slave Port Status
	UCHAR       ucReqflg;			// Master & Slave request flg
	UCHAR		ucPortResult;
	UCHAR		ucSetPortInfoStatus;
	PORT_FLAG   portFlag;
	USHORT		usPortPwr;
	USHORT		usNegoCurr;
	USHORT		usNegoVolt;
} PORT_INFO;

typedef union {
	struct {
		UCHAR bPortNego		: 4U;
		UCHAR bActive		: 1U;
		UCHAR				: 1U;
		UCHAR bChkAlert		: 1U;
		UCHAR bReChkAlert	: 1U;
	} bit;
	UCHAR data;
} MPPM_STATE;

typedef union {
	struct {
		ULONG	bMinMax		: 10;
		ULONG	bOpr		: 10;
		ULONG				:  3;
		ULONG	bUnChkSprt	:  1;
		ULONG	bNoSusp		:  1;
		ULONG	bUSBComm	:  1;
		ULONG	bMissCap	:  1;
		ULONG	bGB			:  1;
		ULONG	bObjPos		:  3;
		ULONG				:  1;
	}bit;
	struct {
		ULONG	bCur		:  7;
		ULONG				:  2;
		ULONG	bVolt		: 11;
		ULONG				:  3;
		ULONG	bUnChkSprt	:  1;
		ULONG	bNoSusp		:  1;
		ULONG	bUSBComm	:  1;
		ULONG	bMissCap	:  1;
		ULONG				:  1;
		ULONG	bObjPos		:  3;
		ULONG				:  1;
	}bit_pps;
	UCHAR	ucData[4];
	USHORT	usData[2];
	ULONG	ulData;
}RDO;

typedef union {
	UCHAR  ucData[8];
	USHORT usData[4];
	ULONG  ulData[2];
}PORT_DATA;

/* global variable */
typedef struct {
	PORT_INFO	portInfo[MPPM_PORT_NUM_MAX];		// Port Info (Master / Slave)
	PORT_EVENT	portEvent[MPPM_PORT_NUM_MAX];		// PORT Event (Master / Slave)
	USHORT		usRemaingPwr;						// (250mW unit)
	RDO			ulRdoInfo[MPPM_PORT_NUM_MAX];		// Master & Slave RDO data
	SMBS_OBJDTMD    ulObjDataMode;
	PORT_DATA   ulPortData;
	MPPM_STATE	ucStateFlag;
	UCHAR       ucChkTrickleState;
	// SMBS i/f
	UCHAR		ucCmd;								// subdev command
	USHORT		usAlertData;						// SMBS alert# status
	SMBS_DATA	usRegData[MPPM_PORT_NUM_MAX];		// read/write data
	USHORT      usChkSlvDcdcState;
	UCHAR       ucCommErrCnt[2];


} MPPM_INFO;

void init_mppm(void);
UCHAR mppm(void);
void mppm_snd_smbs_command(UCHAR dev_id, UCHAR command, USHORT reg_data);

extern	MPPM_INFO		gMppmInfo;
extern	ALERT_INFO		gMppmAlert;

#endif