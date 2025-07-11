#ifndef ___USER_MAIN_H
#define ___USER_MAIN_H

#include "typedefs.h"

#define DSLEEP_IDLE                  (0U)
#define DSLEEP_ST_DIS_TYPEC          (1U)
#define DSLEEP_ST_WAI_DIS_TYPEC      (2U)
#define DSLEEP_ST_ENTER_DEEP         (3U)
#define DSLEEP_ST_EN_TYPEC           (4U)
#define DSLEEP_ST_EXIT_DEEP          (5U)

#define SVDM_VDMH_TYPE_USVDM         (0U)
#define SVDM_VDMH_TYPE_SVDM          (1U)
#define SVDM_VDMH_CMD_INITIATOR      (0U)
#define SVDM_VDMH_CMD_RESP_ACK       (1U)
#define SVDM_VDMH_CMD_RESP_NACK      (2U)
#define SVDM_VDMH_CMD_RESP_BUSY      (3U)
#define SVDM_VDMH_CMD_DIS_IDNT       (1U)
#define SVDM_VDMH_CMD_DIS_SVIDS      (2U)
#define SVDM_VDMH_CMD_DIS_MODES      (3U)
#define SVDM_VDMH_CMD_ENTER_MODE     (4U)
#define SVDM_VDMH_CMD_EXIT_MODE      (5U)
#define SVDM_VDMH_CMD_ATTENTION      (6U)

#define PDSID                        (0xFF00U)
#define DUMMYSID                     (0x1234U)

#define tVDMSenderResp               (27)
#define tVDMWaitMode                 (45)
#define tUserEnterMode               (60000)

typedef union{
struct {
	ULONG bCmd     : 5;
	ULONG          : 1;
	ULONG bCmdType : 2;
	ULONG bObjPos  : 3;
	ULONG          : 2;
	ULONG bVersion : 2;
	ULONG bVdmType : 1;
	ULONG bSVID    : 16;
}bit_s;
USHORT data[2];
}SVDM_HEADER;

void  user_func_event(void);
UCHAR user_func_chk_device(void);
UCHAR user_func_snd_mess  (void);
void  user_init(void);

#endif // ___USER_MAIN_H