#ifndef ___R9A02G011AUTH_H
#define ___R9A02G011AUTH_H

void auth_init(ULONG address, UCHAR ucMode);
void auth_run_initiator(UCHAR ucTarget);
void auth_cnsl_sequence(void);
UCHAR auth_pd_core(void);
UCHAR auth_get_status(void);
UCHAR auth_get_result(void);
USHORT auth_get_pid(void);
USHORT auth_get_vid(void);
ULONG auth_get_xid(void);
USHORT auth_get_version (void);
void auth_set_conf(UCHAR ucSearchSlots, UCHAR ucOpt);

// defines for auth_init()
#define AUTH_SPRT_INIT           (0x01U)
#define AUTH_SPRT_RESP_SNK       (0x02U)
#define AUTH_SPRT_RESP_SRC       (0x04U)

// defines for auth_get_status()
#define AUTH_STAT_BUSY           (0x00U)
#define AUTH_STAT_READY          (0x01U)
#define AUTH_STAT_RESP_RUN       (0x02U)
#define AUTH_STAT_INIT_RUN       (0x03U)

// defines for auth_get_result()
#define AUTH_RSLT_GOOD          (0x00U)
#define AUTH_RSLT_FAILURE       (0x01U)
#define AUTH_RSLT_INVALID       (0x02U)
#define AUTH_RSLT_NS            (0x03U)
#define AUTH_RSLT_NO_RESULT     (0x04U)
#define AUTH_RSLT_NO_RESP       (0x05U)
#define AUTH_RSLT_BAD           (0x06U)
#define AUTH_RSLT_CANCEL        (0x07U)

// defines for auth_set_conf()
#define AUTH_SRCH_SLOT0         (0x01U)
#define AUTH_SRCH_SLOT1         (0x02U)
#define AUTH_SRCH_SLOT2         (0x04U)
#define AUTH_SRCH_SLOT3         (0x08U)
#define AUTH_SRCH_SLOT4         (0x10U)
#define AUTH_SRCH_SLOT5         (0x20U)
#define AUTH_SRCH_SLOT6         (0x40U)
#define AUTH_SRCH_SLOT7         (0x80U)

#define AUTH_OPT_CACHE_EN       (0x00U)
#define AUTH_OPT_CACHE_DIS      (0x01U)

#endif // ___R9A02G011AUTH_H