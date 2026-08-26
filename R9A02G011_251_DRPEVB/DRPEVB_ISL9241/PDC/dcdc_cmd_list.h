/// This file is specifically for ISL9241, "BBCHG"
#ifndef __DCDC_CMD_LIST_H
#define __DCDC_CMD_LIST_H

/******************************************************************************
// BBCHG Command List
******************************************************************************/

#define BBCHG_SET_CTRL0				((UCHAR)0x01)
#define BBCHG_SET_CTRL0_BYPASS_DIS	((UCHAR)0x02)
#define BBCHG_SET_CTRL1				((UCHAR)0x03)
#define BBCHG_SET_CTRL1_OTG			((UCHAR)0x04)
#define BBCHG_SET_CTRL2				((UCHAR)0x05)
#define BBCHG_GET_INFO1				((UCHAR)0x06)
#define BBCHG_GET_INFO2				((UCHAR)0x07)
#define BBCHG_SET_MAXSYSVOLT		((UCHAR)0x08)
#define BBCHG_SET_MAXSYSVOLT_DIS	((UCHAR)0x09)
#define BBCHG_SET_MINSYSVOLT		((UCHAR)0x0A)
#define BBCHG_SET_MINSYSVOLT_DIS	((UCHAR)0x0B)
#define BBCHG_SET_OTGVOLT			((UCHAR)0x0C)
#define BBCHG_SET_OTGCUR			((UCHAR)0x0D)
#define BBCHG_SET_CHRCURLIMIT		((UCHAR)0x0E)
#define BBCHG_SET_ADPCURLIMIT1		((UCHAR)0x0F)

#endif //__DCDC_CMD_LIST_H