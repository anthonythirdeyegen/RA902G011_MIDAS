#ifndef __DCDC_CMD_LIST_H
#define __DCDC_CMD_LIST_H

/******************************************************************************
// PowerBank Command List
******************************************************************************/
// for BB POWER BANK
#define BBCHG_INIT_CTR0				((UCHAR)0x01)
#define BBCHG_INIT_CTR1				((UCHAR)0x02)
#define BBCHG_INIT_CTR2				((UCHAR)0x03)
#define BBCHG_INIT_CTR3				((UCHAR)0x04)
#define BBCHG_INIT_CTR4				((UCHAR)0x05)
#define BBCHG_INIT_MAXVOL			((UCHAR)0x06)
#define BBCHG_INIT_MINVOL			((UCHAR)0x07)
#define BBCHG_SET_OTG				((UCHAR)0x08)
#define BBCHG_SET_OTGVOLT			((UCHAR)0x09)
#define BBCHG_SET_OTGCURR			((UCHAR)0x0A)
#define BBCHG_GET_INFO1				((UCHAR)0x0B)
#define BBCHG_GET_INFO2				((UCHAR)0x0C)
#define BBCHG_SET_ADPCURRLIMIT		((UCHAR)0x0D)
#define BBCHG_INIT_INPUTVOLT		((UCHAR)0x0F)
#define BBCHG_INIT_ADPCURRLIMIT		((UCHAR)0x10)
#define BBCHG_INIT_CHGCURRLIMIT		((UCHAR)0x11)
#define BBCHG_SET_CHGCURRLIMIT		((UCHAR)0x12)
#define BBCHG_CTR0_EN_LOAD			((UCHAR)0x13)
#define BBCHG_CTR0_DIS_LOAD			((UCHAR)0x14)
#define BBCHG_SET_CTRL1_VSYS		((UCHAR)0x15)

//Addtional register for ISL9238C
#define BBCHG_CTR6_DIS_UV			((UCHAR)0x16)
#define BBCHG_CTR6_EN_UV			((UCHAR)0x17)
#define BBCHG_CTR6_EN_SLEW			((UCHAR)0x18)
#define BBCHG_CTR4_EN_ADPDISCHG		((UCHAR)0x19)


#endif //__DCDC_CMD_LIST_H