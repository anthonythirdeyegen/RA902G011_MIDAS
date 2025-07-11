#ifndef __DCDC_CMD_LIST_H
#define __DCDC_CMD_LIST_H

/******************************************************************************
// BBVR Command List
******************************************************************************/
// for BBVR_DUAL_SNK_FRW_SRC_RVS
#define BBVR_INIT_CTR1				((UCHAR)0x01)
#define BBVR_INIT_CTR2				((UCHAR)0x02)
#define BBVR_INIT_CTR3				((UCHAR)0x03)
#define BBVR_INIT_CTR4				((UCHAR)0x04)
#define BBVR_INIT_CTR0				((UCHAR)0x05)
#define BBVR_SET_RESERVED			((UCHAR)0x06)
#define BBVR_SET_RVSRV				((UCHAR)0x07)
#define BBVR_SET_RVCRR				((UCHAR)0x08)
#define BBVR_SET_SYSCRRPROCHOT		((UCHAR)0x09)
#define BBVR_SET_RVSSYSCRRLIMIT		((UCHAR)0x0A)
#define BBVR_SET_FRWRV				((UCHAR)0x0B)
#define BBVR_SET_FRWSYSCRRLIMIT		((UCHAR)0x0C)
#define BBVR_SET_ADPPROCHOT			((UCHAR)0x0D)
#define BBVR_SET_FRWINPUTCURR		((UCHAR)0x0E)
#define BBVR_CLR_PROHOT				((UCHAR)0x0F)
#define BBVR_SET_FRWON				((UCHAR)0x10)
#define BBVR_SET_RVSON				((UCHAR)0x11)
#define BBVR_GET_INFO1				((UCHAR)0x12)
#define BBVR_GET_INFO2				((UCHAR)0x13)
#define BBVR_SET_CTR0_DISCHG_DIS	((UCHAR)0x14)
#define BBVR_SET_CTR0_DISCHG		((UCHAR)0x15)

// for BBVR_DUAL_SRC_FRW
#define BBCHG_INIT_CTR1				((UCHAR)0x01)
#define BBCHG_INIT_CTR2				((UCHAR)0x02)
#define BBCHG_INIT_CTR3				((UCHAR)0x03)
#define BBCHG_INIT_CTR4				((UCHAR)0x04)
#endif //__DCDC_CMD_LIST_H