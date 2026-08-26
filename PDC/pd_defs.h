#ifndef __PD_DEFS_H
#define __PD_DEFS_H

#include "typedefs.h"

extern const UCHAR  PD_SPEC_REV;          // 1U:PD2, 2U:PD3
extern const UCHAR  PD_PDM_SPRT_GET_SRCCAP_E;
extern const UCHAR  PD_PDM_SPRT_GET_BAT_CAP;
extern const UCHAR  PD_PDM_SPRT_GET_BAT_STATUS;
extern const UCHAR  PD_PDM_SPRT_GET_PPS_STATUS;
extern const UCHAR  PD_PDM_SPRT_GET_MFI;
extern const UCHAR  PD_PDM_SPRT_GET_SNKCAP_E;

extern const USHORT PD_VID;      // Vender ID assigned by the USB-IF
extern const USHORT PD_PID;      // Prduct ID assigned by the manufacture
extern const ULONG  PD_XID; // Value provided by the USB-IF assigned to the product
extern const USHORT PD_BCD_DEVICE;     // bcdDevice
extern const UCHAR  PD_FW_VER;        // Firmware version number
extern const UCHAR  PD_HW_VER;        // Hardware version number

extern const UCHAR PD_USB_COMM_CAPABLE;
extern const UCHAR PD_IS_USB_HOST;
extern const UCHAR PD_IS_USB_DEVICE;
extern const UCHAR PD_USB_SUSPEND_SUPPORT;
extern const UCHAR PD_NO_USB_SUSPEND;
extern const UCHAR PD_PRODUCT_TYPE_UFP;
extern const UCHAR PD_PRODUCT_TYPE_DFP;
extern const UCHAR PD_MODAL_OPE_SUPPORT;

extern const UCHAR  PD_CONNECTOR_TYPE;
extern const UCHAR  PD_DEVICE_CAP;
extern const UCHAR  PD_HOST_CAP;
extern const UCHAR  PD_PORT_NUM;
extern const ULONG  PD_UFP_VDO;

extern const UCHAR  PD_SRC_PDO1_PEAK_CUR;
extern const UCHAR  PD_SNK_PDO1_FR_SWAP_REQ;
extern const USHORT PD_SRC_PDO1_MAX_CUR; // 3A
extern const USHORT PD_SNK_PDO1_OPE_CUR; // 100mA

extern const ULONG  PD_SRC_PDO2; //  9V,3A
extern const ULONG  PD_SRC_PDO3; // 15V,3A
extern const ULONG  PD_SRC_PDO4; // 20V,3A
extern const ULONG  PD_SRC_PDO5;
extern const ULONG  PD_SRC_PDO6;
extern const ULONG  PD_SRC_PDO7;

extern const ULONG  PD_SNK_PDO2; //  9V,1A
extern const ULONG  PD_SNK_PDO3; // 12V,1A
extern const ULONG  PD_SNK_PDO4; // 15V,1A
extern const ULONG  PD_SNK_PDO5; // 20V,1A
extern const ULONG  PD_SNK_PDO6;
extern const ULONG  PD_SNK_PDO7;

extern const UCHAR  PD_SCEDB_VOLT_REG;
extern const UCHAR  PD_SCEDB_HOLDUP_TIME;
extern const UCHAR  PD_SCEDB_COMPLIANCE;
extern const UCHAR  PD_SCEDB_TOUCH_CUR;
extern const USHORT PD_SCEDB_PEAK_CUR1;
extern const USHORT PD_SCEDB_PEAK_CUR2;
extern const USHORT PD_SCEDB_PEAK_CUR3;
extern const UCHAR  PD_SCEDB_TOUCH_TEMP;
extern const UCHAR  PD_SCEDB_BATTERIES;
extern const UCHAR  PD_SCEDB_SRC_PDP;

extern const UCHAR  PD_SKEDB_VERSION;
extern const UCHAR  PD_SKEDB_LOAD_STEP;
extern const USHORT PD_SKEDB_LOAD_CHARA;
extern const UCHAR  PD_SKEDB_COMPLIANCE;
extern const UCHAR  PD_SKEDB_TOUCH_TEMP;
extern const UCHAR  PD_SKEDB_BAT_INFO;
extern const UCHAR  PD_SKEDB_SNK_MODES;
extern const UCHAR  PD_SKEDB_SNK_MIN_PDP;
extern const UCHAR  PD_SKEDB_SNK_OPE_PDP; 
extern const UCHAR  PD_SKEDB_SNK_MAX_PDP;

extern const UCHAR  PD_NUM_OF_MFI_STR;
extern const UCHAR  PD_MFI_STR01;
extern const UCHAR  PD_MFI_STR02;
extern const UCHAR  PD_MFI_STR03;
extern const UCHAR  PD_MFI_STR04;
extern const UCHAR  PD_MFI_STR05;
extern const UCHAR  PD_MFI_STR06;
extern const UCHAR  PD_MFI_STR07;
extern const UCHAR  PD_MFI_STR08;
extern const UCHAR  PD_MFI_STR09;
extern const UCHAR  PD_MFI_STR10;
extern const UCHAR  PD_MFI_STR11;
extern const UCHAR  PD_MFI_STR12;
extern const UCHAR  PD_MFI_STR13;
extern const UCHAR  PD_MFI_STR14;
extern const UCHAR  PD_MFI_STR15;
extern const UCHAR  PD_MFI_STR16;
extern const UCHAR  PD_MFI_STR17;
extern const UCHAR  PD_MFI_STR18;
extern const UCHAR  PD_MFI_STR19;
extern const UCHAR  PD_MFI_STR20;
extern const UCHAR  PD_MFI_STR21;
extern const UCHAR  PD_MFI_STR22;

extern const USHORT PD_SND_MESS_SIZE;
extern const USHORT PD_RCV_MESS_SIZE;

#endif // __PD_DEFS_H