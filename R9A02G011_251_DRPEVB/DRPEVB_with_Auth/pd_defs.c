#include "typedefs.h"

const UCHAR  PD_SPEC_REV = 2U;          // 1U:PD2, 2U:PD3
const UCHAR  PD_PDM_SPRT_GET_SRCCAP_E   = 1U;
const UCHAR  PD_PDM_SPRT_GET_BAT_CAP    = 0U;
const UCHAR  PD_PDM_SPRT_GET_BAT_STATUS = 0U;
const UCHAR  PD_PDM_SPRT_GET_PPS_STATUS = 0U;
const UCHAR  PD_PDM_SPRT_GET_MFI        = 1U;
const UCHAR  PD_PDM_SPRT_GET_SNKCAP_E   = 1U;

const USHORT PD_VID = 0x045BU;      // Vender ID assigned by the USB-IF
const USHORT PD_PID = 0x0251U;      // Prduct ID assigned by the manufacture
const ULONG  PD_XID = 0x00000000UL; // Value provided by the USB-IF assigned to the product
const USHORT PD_BCD_DEVICE = 0x0200U;     // bcdDevice
const UCHAR  PD_FW_VER     = 0x01;        // Firmware version number
const UCHAR  PD_HW_VER     = 0x01;        // Hardware version number

const UCHAR PD_USB_COMM_CAPABLE    = 0x00U;
const UCHAR PD_IS_USB_HOST         = 0x00U;
const UCHAR PD_IS_USB_DEVICE       = 0x00U;
const UCHAR PD_USB_SUSPEND_SUPPORT = 0x00U;
const UCHAR PD_NO_USB_SUSPEND      = 0x00U;
const UCHAR PD_PRODUCT_TYPE_UFP    = 0x03U;
const UCHAR PD_PRODUCT_TYPE_DFP    = 0x00U;
const UCHAR PD_MODAL_OPE_SUPPORT   = 0x00U;

const UCHAR  PD_CONNECTOR_TYPE     = 0x02U;
const UCHAR  PD_DEVICE_CAP         = 0x00U;
const UCHAR  PD_HOST_CAP           = 0x00U;
const UCHAR  PD_PORT_NUM           = 0x00U;
const USHORT PD_UFP_VDO            = 0x0000U;

const UCHAR  PD_SRC_PDO1_PEAK_CUR  = 0x00U;
const UCHAR  PD_SNK_PDO1_FR_SWAP_REQ = 0x00U;
const USHORT PD_SRC_PDO1_MAX_CUR   = 0x012CU; // 3A
const USHORT PD_SNK_PDO1_OPE_CUR     = 0x000AU; // 100mA

const ULONG  PD_SRC_PDO2   = 0x0002D12CU; //  9V,3A
const ULONG  PD_SRC_PDO3   = 0x0004B12CU; // 15V,3A
const ULONG  PD_SRC_PDO4   = 0x0006412CU; // 20V,3A
const ULONG  PD_SRC_PDO5   = 0x00000000U;
const ULONG  PD_SRC_PDO6   = 0x00000000U;
const ULONG  PD_SRC_PDO7   = 0x00000000U;

const ULONG  PD_SNK_PDO2   = 0x0002D064UL; //  9V,1A
const ULONG  PD_SNK_PDO3   = 0x0003C064UL; // 12V,1A
const ULONG  PD_SNK_PDO4   = 0x0004B064UL; // 15V,1A
const ULONG  PD_SNK_PDO5   = 0x00064064UL; // 20V,1A
const ULONG  PD_SNK_PDO6   = 0x00000000UL;
const ULONG  PD_SNK_PDO7   = 0x00000000UL;

const UCHAR  PD_SCEDB_VOLT_REG    = 0x00U;
const UCHAR  PD_SCEDB_HOLDUP_TIME = 0x00U;
const UCHAR  PD_SCEDB_COMPLIANCE  = 0x00U;
const UCHAR  PD_SCEDB_TOUCH_CUR   = 0x00U;
const USHORT PD_SCEDB_PEAK_CUR1   = 0x0000U;
const USHORT PD_SCEDB_PEAK_CUR2   = 0x0000U;
const USHORT PD_SCEDB_PEAK_CUR3   = 0x0000U;
const UCHAR  PD_SCEDB_TOUCH_TEMP  = 0x00U;
const UCHAR  PD_SCEDB_BATTERIES   = 0x00U;
const UCHAR  PD_SCEDB_SRC_PDP     = 60U;

const UCHAR  PD_SKEDB_VERSION	  = 0x01U;
const UCHAR  PD_SKEDB_LOAD_STEP	  = 0x00U;
const USHORT PD_SKEDB_LOAD_CHARA  = 0x0000U;
const UCHAR  PD_SKEDB_COMPLIANCE  = 0x00U;
const UCHAR  PD_SKEDB_TOUCH_TEMP  = 0x00U;
const UCHAR  PD_SKEDB_BAT_INFO	  = 0x00U;
const UCHAR  PD_SKEDB_SNK_MODES   = 0x06U;
const UCHAR  PD_SKEDB_SNK_MIN_PDP = 0x00U;
const UCHAR  PD_SKEDB_SNK_OPE_PDP = 0x00U;
const UCHAR  PD_SKEDB_SNK_MAX_PDP = 0x01U;


const UCHAR  PD_NUM_OF_MFI_STR = 16U;
const UCHAR  PD_MFI_STR01  = 'R';
const UCHAR  PD_MFI_STR02  = 'e';
const UCHAR  PD_MFI_STR03  = 'n';
const UCHAR  PD_MFI_STR04  = 'e';
const UCHAR  PD_MFI_STR05  = 's';
const UCHAR  PD_MFI_STR06  = 'a';
const UCHAR  PD_MFI_STR07  = 's';
const UCHAR  PD_MFI_STR08  = ' ';
const UCHAR  PD_MFI_STR09  = 'T';
const UCHAR  PD_MFI_STR10  = 'e';
const UCHAR  PD_MFI_STR11  = 's';
const UCHAR  PD_MFI_STR12  = 't';
const UCHAR  PD_MFI_STR13  = ' ';
const UCHAR  PD_MFI_STR14  = 'F';
const UCHAR  PD_MFI_STR15  = 'W';
const UCHAR  PD_MFI_STR16  = '\0';
const UCHAR  PD_MFI_STR17  = '\0';
const UCHAR  PD_MFI_STR18  = '\0';
const UCHAR  PD_MFI_STR19  = '\0';
const UCHAR  PD_MFI_STR20  = '\0';
const UCHAR  PD_MFI_STR21  = '\0';
const UCHAR  PD_MFI_STR22  = '\0';

const USHORT PD_SND_MESS_SIZE = 28U;
const USHORT PD_RCV_MESS_SIZE = 28U;
