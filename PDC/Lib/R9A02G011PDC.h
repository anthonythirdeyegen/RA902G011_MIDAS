#ifndef ___R9A02G011PDC_H
#define ___R9A02G011PDC_H

#include "typedefs.h"

typedef union {
	struct {
		USHORT bPlug      : 1U; // 0b:Unplug     , 1b:Plug
		USHORT bPR        : 1U; // 0b:Sink       , 1b:Source
		USHORT bDR        : 1U; // 0b:UFP        , 1b:DFP
		USHORT bCc        : 1U; // 0b:CC1        , 1b:CC2
		USHORT bSOPP      : 1U; // 0b:Disable    , 1b:Enable
		USHORT bSOPPP     : 1U; // 0b:Disable    , 1b:Enable
		USHORT bComRevPDC : 1U; // 0b:PD2        , 1b:PD3
		USHORT bComRevCP  : 1U; // 0b:PD2        , 1b:PD3
		USHORT bNonPD     : 1U; // 0b:---        , 1b:Connect to Non-PD Device
		USHORT bMissCap   : 1U; // 0b:---        , 1b:Latest SrcCap is missmatch
		USHORT bRjctNego  : 1U; // 0b:---        , 1b:Latest Request is rejected
		USHORT bPwrAcs    : 1U; // 0b:---        , 1b:Attach powered accessory
		USHORT bDebugAcs  : 1U; // 0b:---        , 1b:Attach debugged accessory
		USHORT bAudioAcs  : 1U; // 0b:---        , 1b:Attach audio accessory
		USHORT bPwrTrans  : 1U;
		USHORT bRdyIdle   : 1U;
	}bit;
	USHORT usData;
}PD_STATUS;

typedef union {
	struct {
		USHORT bPlugChg     : 1U; // Detect attach and detach
		USHORT bPrChg       : 1U; // Complete power role swap (transmit/receive PS_RDY of new source)
		USHORT bDrChg       : 1U; // Complete data role swap (transmit/receive Accept of DR_SWAP)
		USHORT bNewContract : 1U; // Complete negotiation (transmit/receive PS_RDY)
		USHORT bNewSrcCap   : 1U; // Receive SrcCap, if sink intrucive=1
		USHORT bNewRequest  : 1U; // Receive Request, if source intrucive=1
		USHORT bChkRcvPDM   : 1U; // Receive PDM, if 
		USHORT              : 1U;
		USHORT              : 1U;
		USHORT              : 1U;
		USHORT bVrdChg      : 1U; // Detect VRD change (During Non-PD Sink)
		USHORT bNonPDCon    : 1U; // Detect non-PD device
		USHORT bHardReset   : 1U; // Transmit/receive Hard Reset
		USHORT bSoftReset   : 1U; // Complete Soft Reset (transmit/receive Accept of Soft Reset)
		USHORT bErr         : 1U; // Error flag
		USHORT              : 1U; // 
	}bit;
	USHORT usData;
}PD_EVENT;

typedef union {
	struct {
		USHORT bSrcOn    : 1U; // Request to change source power to vSafe5V
		USHORT bSrcOff   : 1U; // Request to change source power to vSafe0V
		USHORT bSrcChg   : 1U; // Request to change source power to new power level
		USHORT bSnkOn    : 1U; // Request to start sink operation
		USHORT bSnkOff   : 1U; // Request to stop sink operation
		USHORT bSnkChg   : 1U; // Request to change sink power to new power level
		USHORT bVconnEn  : 1U; // Request to enable Vconn
		USHORT bVconnDis : 1U; // Request to disable Vconn
		USHORT bGotoMin  : 1U; // Request to change source current to min current
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT           : 1U;
		USHORT bExitMain : 1U; // Request of switching to boot FW
	}bit;
	USHORT usData;
}PD_REQ;

typedef struct {
	PD_REQ      uPdReq;
	PD_EVENT    uPdEvent;
}R9A02G011PDC_INFO;

typedef union {
	struct {
		USHORT bLen      : 9U; // read/write: 0 to 260
		USHORT bType     : 5U; // read only
		USHORT bClass    : 2U; // read only: 00b:Control Mess, 01b:Data Mess, 10b:Extended
	}bit;
	USHORT usData;
}MESS_INFO;

typedef struct {
	USHORT    *uspData;
	MESS_INFO uInfo;
}R9A02G011PDC_PDM;

#define PD_CORE_ACTIVE              (0x00U) // 0b0000
#define PD_CORE_LOW                 (0x01U) // 0b0001
#define PD_CORE_IDLE                (0x03U) // 0b0011
#define PD_CORE_STOP                (0x07U) // 0b0111

// defines for pdc_req_update_an() & pdc_get_an_volt()
#define AN_CH_REF                   (0x00U)
#define AN_CH09                     (0x01U)
#define AN_CH10                     (0x02U)
#define AN_CH_VBUS                  (0x03U)
#define AN_CH_VBUS_NO_FILTER        (0x04U)

// defines for pdc_set_port_conf()
#define PDC_ROLE_SNK_UFP            (0x14U) // 0b0010100
#define PDC_ROLE_SNK_DRD            (0x34U) // 0b0110100
#define PDC_ROLE_SRC_DFP            (0x28U) // 0b0101000
#define PDC_ROLE_SRC_DRD            (0x38U) // 0b0111000
#define PDC_ROLE_DRP_DRD            (0x3CU) // 0b0111100
#define PDC_ROLE_DRP_DRD_TSNK       (0x3FU) // 0b0111111
#define PDC_ROLE_DRP_DRD_TSRC       (0x3EU) // 0b0111110
#define PDC_ROLE_DRP_DRD_DEFSNK     (0x74U) // 0b1110100
#define PDC_ROLE_DRP_DRD_DEFSRC     (0x78U) // 0b1111000

#define PDC_ACS_VCONN               (0x01U) // 0b0001
#define PDC_ACS_PWR                 (0x02U) // 0b0010
#define PDC_ACS_DEBUG               (0x04U) // 0b0100
#define PDC_ACS_AUDIO               (0x08U) // 0b1000

// defines for pdc_set_src_conf()
#define PDC_NOPD_CUR_0_5A           (0x00U) // 0b00
#define PDC_NOPD_CUR_0_9A           (0x01U) // 0b01
#define PDC_NOPD_CUR_1_5A           (0x02U) // 0b10
#define PDC_NOPD_CUR_3_0A           (0x03U) // 0b11

// defines for pdc_set_sys_conf()
#define PDC_SYS_DR_SWAP_DISABLE     (0x00U) // 0b00
#define PDC_SYS_DR_SWAP_ACTIVE_UFP  (0x01U) // 0b01
#define PDC_SYS_DR_SWAP_ACTIVE_DFP  (0x02U) // 0b10
#define PDC_SYS_DR_SWAP_PASSIVE     (0x03U) // 0b11

#define PDC_SYS_PR_SWAP_DISABLE     (0x00U) // 0b00
#define PDC_SYS_PR_SWAP_ACTIVE_SNK  (0x01U) // 0b01
#define PDC_SYS_PR_SWAP_ACTIVE_SRC  (0x02U) // 0b10
#define PDC_SYS_PR_SWAP_PASSIVE     (0x03U) // 0b11

#define PDC_SYS_UNCNST_PWR          (0x01U) // 0b00001
#define PDC_SYS_EXT_PWR_DC          (0x02U) // 0b00010
#define PDC_SYS_EXT_PWR_AC          (0x06U) // 0b00110
#define PDC_SYS_INTR_PWR_BAT        (0x08U) // 0b01000
#define PDC_SYS_INTR_PWR_NONBAT     (0x18U) // 0b11000

// defines for pdc_set_dev_stat()
#define PDC_TEMP_STAT_NS            (0U)
#define PDC_TEMP_STAT_NORMAL        (1U)
#define PDC_TEMP_STAT_WARNING       (2U)
#define PDC_TEMP_STAT_OVER_TEMP     (3U)

// defines for pdc_set_cmd()
#define PDC_CMD_SND_GOTOMIN         (0x02U)
#define PDC_CMD_SND_ACPT            (0x03U)
#define PDC_CMD_SND_RJCT            (0x04U)
#define PDC_CMD_SND_GET_SRC_CAP     (0x07U)
#define PDC_CMD_SND_GET_SNK_CAP     (0x08U)
#define PDC_CMD_SND_DR_SWAP         (0x09U)
#define PDC_CMD_SND_PR_SWAP         (0x0AU)
#define PDC_CMD_SND_VC_SWAP         (0x0BU)
#define PDC_CMD_SND_WAIT            (0x0CU)
#define PDC_CMD_SND_SOFT_RESET      (0x0DU)
#define PDC_CMD_SND_NOT_SUPPORTED   (0x10U)
#define PDC_CMD_SND_GET_SRC_CAP_EXT (0x11U)
#define PDC_CMD_SND_GET_STAT        (0x12U)
#define PDC_CMD_SND_GET_PPS_STAT    (0x14U)
#define PDC_CMD_SND_GET_SNK_CAP_EXT (0x16U)
#define PDC_CMD_SND_SRC_CAP         (0x21U)
#define PDC_CMD_SND_REQUEST         (0x22U)
#define PDC_CMD_SND_BAT_STAT        (0x25U)
#define PDC_CMD_SND_VDM             (0x2FU)
#define PDC_CMD_SND_GET_BAT_CAP     (0x43U)
#define PDC_CMD_SND_GET_BAT_STAT    (0x44U)
#define PDC_CMD_SND_BAT_CAP         (0x45U)
#define PDC_CMD_SND_GET_MFI         (0x46U)
#define PDC_CMD_HARD_RESET          (0x60U)
#define PDC_CMD_CABLE_RESET         (0x61U)
#define PDC_CMD_ENTR_ERR_RCVR       (0x62U)
#define PDC_CMD_ENA_TYPEC_CTRL      (0x81U)
#define PDC_CMD_DIS_TYPEC_CTRL      (0x82U)
#define PDC_CMD_ENA_LOW_BAT_MODE    (0x83U)

#define PDC_TARGET_SOP    (0U)
#define PDC_TARGET_SOPP   (1U)
#define PDC_TARGET_SOPPP  (2U)

// defines for pdc_get_cmd_result()
#define PDC_CMD_RSLT_SUCCESS        (0x00U) // 0b0000
#define PDC_CMD_RSLT_FAILURE        (0x01U) // 0b0001
#define PDC_CMD_RSLT_INVALID        (0x02U) // 0b0010
#define PDC_CMD_RSLT_REJECT         (0x03U) // 0b0011
#define PDC_CMD_RSLT_BUSY           (0x04U) // 0b0100
#define PDC_CMD_RSLT_NO_RESP        (0x05U) // 0b0101
#define PDC_CMD_RSLT_CANCEL         (0x07U) // 0b0111
#define PDC_CMD_RSLT_PROGRESS       (0x08U) // 0b1000

// defines for pdc_set_pps_stat()
#define PDC_PPS_RTF_PTF_NOT_SPRT    (0x00U)
#define PDC_PPS_RTF_PTF_NORMAL      (0x02U)
#define PDC_PPS_RTF_PTF_WARNING     (0x04U)
#define PDC_PPS_RTF_PTF_OVR_TMP     (0x06U)
#define PDC_PPS_RTF_OMF             (0x08U)

// defines for pdc_set_custom_mode()
#define PDC_CM_DIS_AUTO_VC_SWAP     (0x0001U)

// defines for pdc_get_rdo()
#define PDC_RDO_NEGO                (0x00U)
#define PDC_RDO_SND_RCV             (0x01U)

// defines for pdc_get_pdo()
#define PDC_PDO_SNK                 (0x00U)
#define PDC_PDO_SRC                 (0x01U)
#define PDC_PDO_RCV                 (0x00U)
#define PDC_PDO_SND                 (0x01U)

// defines for pd_tm_start_user_cnt()
// Note:
// Timer Counter ID 0-6 are used in lib
#define TM_ID_USER1                 (7U)
#define TM_ID_USER2                 (8U)
#define TM_ID_USER3                 (9U)

// defines for pd_tm_chk_user_stat()
#define TM_ST_STOP                  (0U)
#define TM_ST_CNT                   (1U)
#define TM_ST_OVR                   (2U)
#define TM_ST_ERR                   (3U)

// defines for pdc_set_pwr_stat()
#define PDC_PWR_LMT_SHARED        (0x04U)
#define PDC_PWR_LMT_EXTPWR        (0x08U)
#define PDC_PWR_LMT_FLAGS         (0x10U)
#define PDC_PWR_LMT_TEMP          (0x20U)

void      pd_core_init(UCHAR ucAn9, UCHAR ucAn10);
UCHAR     pd_core(void);

void   pdc_active(void);
void   pdc_run   (void);
void   pdc_stop  (void);
void   pdc_enter_deep(void);
void   pdc_exit_deep(void);
USHORT pdc_get_version(void);

PD_STATUS pdc_get_status(void);

UCHAR     pdc_req_update_an(UCHAR ucCh);
SHORT     pdc_get_an_volt  (UCHAR ucCh);

USHORT    pdc_get_idle_time(void);
void      pdc_timer_active (void);

USHORT    pdc_get_req_volt(void);
USHORT    pdc_get_req_cur (void);
UCHAR     pdc_get_vrd     (void);

void      pdc_set_port_conf(UCHAR ucPort, UCHAR usAcs);
void      pdc_set_src_conf (ULONG ulPwr, UCHAR ucNum, UCHAR ucIntrusive, UCHAR ucNonPdCur);
void      pdc_set_snk_conf (ULONG ulPwr, UCHAR ucNum, UCHAR ucIntrusive);
void      pdc_set_sys_conf (UCHAR ucDrSwapMode, UCHAR ucPrSwapMode, UCHAR ucInputPwr, UCHAR ucInputBat);
void      pdc_set_dev_stat (UCHAR ucOCP, UCHAR ucOTP, UCHAR ucOVP, UCHAR ucTempStat, UCHAR ucIntrTemp);
void      pdc_set_pps_stat (UCHAR ucRTF, UCHAR ucCur, USHORT usVolt);
void      pdc_set_custom_mode (USHORT usMode);
void      pdc_set_pwr_stat (UCHAR ucLimitedPwrStat);


void      pdc_set_cmd(UCHAR ucCmd, UCHAR ucTarget);
UCHAR     pdc_get_cmd_result(void);

void      pdc_req_snd_bat_chg_alert(UCHAR ucBat);

UCHAR     pdc_set_user_ams_mode(UCHAR ucEnDis);
UCHAR     pdc_get_user_ams_mode(void);

ULONG     pdc_get_rdo(UCHAR ucIdx);
ULONG     pdc_get_pdo(UCHAR ucIdx, UCHAR ucSnkSrc, UCHAR ucRcvSnd);
UCHAR     pdc_get_num_of_pdos(UCHAR ucSnkSrc, UCHAR ucRcvSnd);
UCHAR     pdc_is_pps_mode (void);

UCHAR     pd_tm_start_user_cnt(UCHAR ucCntId);
UCHAR     pd_tm_stop_user_cnt (UCHAR ucCntId);
UCHAR     pd_tm_chk_user_stat (UCHAR ucCntId, USHORT usTime);

void      pdc_set_product_info (USHORT usProductInfo);
USHORT    pdc_get_product_info (void);
void      pdc_set_usb_comm (UCHAR ucUsbComm);
UCHAR     pdc_get_usb_comm (void);

extern R9A02G011PDC_INFO gPdc;
extern R9A02G011PDC_PDM  gSndMess;
extern R9A02G011PDC_PDM  gRcvMess;

#endif // ___R9A02G011PDC_H