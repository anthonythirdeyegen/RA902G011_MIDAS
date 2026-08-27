#include "user_main.h"
#include "interrupt.h"
#include "R9A02G011PDC.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "r_cg_userdefine.h"
#include "user_timer.h"
#include "led_ctrl.h"
#include "sw_ctrl.h"
#include "tmuxhs4446.h"
#include <stdint.h>

#define DATA_MESSAGE		0x01
#define CMD_DP_STATUS     0x10U   // “Status Update”
#define CMD_DP_CONFIGURE  0x11U   // “Configure”

// DP Alt Mode Discover Modes VDO
// ---- Port capability (bits 1:0)
#define DP_PORT_CAP_UFP_D     0x01u
#define DP_PORT_CAP_DFP_D     0x02u
#define DP_PORT_CAP_BOTH      0x03u

// ---- Signaling for DisplayPort (bits 5:2)
#define DP_SIG_DP13           (1u << 2)   // Supports DP v1.3 signaling
#define DP_SIG_USB_GEN2       (1u << 3)   // Supports USB Gen2 signaling
// 0b0100 = DP1.3 only
// 0b1000 = USB Gen2 only

// ---- Receptacle / Plug indication (bit 6)
#define DP_PLUG               (0u << 6)   // DisplayPort interface on USB-C plug
#define DP_RECEPTACLE         (1u << 6)   // DisplayPort interface on USB-C receptacle

// ---- USB2.0 signaling not used (bit 7)
#define DP_USB2_NOT_USED      (1u << 7)   // USB2 lines not needed in DP mode

// ---- DFP_D pin assignments (bits 15:8)
#define DP_DFP_PIN_A          (1u << (8+0))
#define DP_DFP_PIN_B          (1u << (8+1))
#define DP_DFP_PIN_C          (1u << (8+2))
#define DP_DFP_PIN_D          (1u << (8+3))
#define DP_DFP_PIN_E          (1u << (8+4))
#define DP_DFP_PIN_F          (1u << (8+5))

// ---- UFP_D pin assignments (bits 23:16)
#define DP_UFP_PIN_A          (1u << (16+0))
#define DP_UFP_PIN_B          (1u << (16+1))
#define DP_UFP_PIN_C          (1u << (16+2))
#define DP_UFP_PIN_D          (1u << (16+3))
#define DP_UFP_PIN_E          (1u << (16+4))
#define DP_UFP_PIN_F          (1u << (16+5))

// Role bits (low bits)
#define DP_MODE_UFP_D           (1U << 7)
#define DP_MODE_DFP_D           (1U << 6)

// DisplayPort Status VDO (UFP_D -> DFP_D)
// Bit 0: HPD state (1 = HPD high)
#define DP_STATUS_HPD_HIGH          (1U << 7)
// Bit 0: HPD state (1 = HPD high)
#define DP_STATUS_HPD_LOW          (0U << 7)
// Bit 1: IRQ_HPD (1 = pulse request); must also keep HPD high
#define DP_STATUS_IRQ_HPD           (1U << 1)
// Bit 2: Request Exit from DP Alt Mode (1 = request to exit)
#define DP_STATUS_REQ_EXIT_MODE     (1U << 2)
// Bit 3: Request switch to USB (1 = exit DP and return to USB data)
#define DP_STATUS_REQ_USB           (1U << 3)
// Bit 4: Multi-Function preferred (1 = prefer DP + USB3 if possible)
#define DP_STATUS_MF_PREFERRED      (1U << 4)
// Bit 5: Low power (1 = sink in low-power; source may adapt)
#define DP_STATUS_POWER_LOW         (1U << 5)
#define DP_STATUS_CONN_UFP_D   (2U << 0)  // bits 7:6 = 10b
// DisplayPort Status VDO Typicals
#define DP_STATUS_ENABLED 	(1U << 3)
#define DP_STATUS_READY         (DP_STATUS_HPD_HIGH | DP_STATUS_CONN_UFP_D)
// IRQ HPD pulse (HPD must be high)
#define DP_STATUS_IRQ_PULSE     (DP_STATUS_HPD_HIGH | DP_STATUS_IRQ_HPD)
// Ask source to drop DP Alt Mode and go back to USB
#define DP_STATUS_EXIT_TO_USB   (DP_STATUS_HPD_HIGH | DP_STATUS_REQ_USB)
// Prefer multi-function (2-lane DP + USB3) when feasible
#define DP_STATUS_MF_READY      (DP_STATUS_HPD_HIGH | DP_STATUS_MF_PREFERRED)



USHORT gusTemp;
UCHAR  gucVdmFlg;
UCHAR  gucWaiCmp;
UCHAR  gucOmfData;
UCHAR  gucReserved;
UCHAR  gucEnterModeEnable;
UCHAR  gucLEDStatus;

static UCHAR gGetStatPending = 0;
static UCHAR gGetStatLastResult = 0xFF;
static UCHAR g_alert_pending = 0;
static UCHAR g_hpd_irq_flag = 1U;
static UCHAR g_dp_mode_configured = 0U;
static UCHAR g_hpd_toggled = 0U;
static UCHAR g_hpd_state = 0U;
static UCHAR g_cmd_queued = 0U;

volatile UCHAR r_dbg;
volatile UCHAR enter_dbg;

void user_func_start_timer_thermistor(void);
void user_func_stop_timer_thermistor (void);
void user_func_intr_timer_thermistor (void);

void hpd_int_init(void)
{
    	PM8_bit.no2 = 1U;   // P82 = input
	PM1_bit.no7 = 1U; // P17 = input
	
	#ifdef PMC8
    	PMC8_bit.no2 = 0U;    // Use digital input function
	#endif
/*	Not using interrupt    
   	// 1. Mask INTP7
	MK0L_bit.no7 = 1U;

	// 2. Clear any pending flag
	IF0L_bit.no7 = 0U;

	// 4. Priority = highest
	PR10L_bit.no7 = 0U;
	PR00L_bit.no7 = 0U;

	// 5. Unmask INTP7
	MK0L_bit.no7 = 0U;
*/	
}

static UCHAR hpd_get_level(void)
{
    // Returns 1 if HPD pin is high, 0 if low
    return (P1_bit.no7 ? 1U : 0U); //SXR
    //return (P8_bit.no2 ? 1U : 0U); //Devboard
}

void hpd_poll_task(void)
{
    	static UCHAR prev = 0x00;  
    	UCHAR curr = hpd_get_level();
	
    	if (curr != prev)
    	{
        	g_hpd_toggled = 1U;   // HPD edge occurred
		g_hpd_state = curr;
        	prev = curr;          // update stored value
    	}	
}

void user_init(void)
{
	// NOTE: 
	// Don't change registers as following. They are initialised by pd_core_init().
	// Always
	//    PUX, PIMX, EGP0, EGN0, ADM0, PM4_bit.no0, PM2_bit.no0, PMC2_bit.no0
	// If ucAn9  = 1 at pd_core_init() -> PM2_bit.no1, PMC2_bit.no1
	// If ucAn10 = 1 at pd_core_init() -> PM2_bit.no2, PMC2_bit.no2
	
	// Output Port Setting
	                   //P1_bit.no6 = 0U; PM1_bit.no6 = 0U; // VC_DRV1   :P16
			   PM1_bit.no6 = 1U; // P16 = input, available for user design
			   P1_bit.no6 = 0U; // Clear latch
	PMC2_bit.no2 = 0U; P2_bit.no2 = 0U; PM2_bit.no2 = 0U; // POWER_GOOD: P22
	                   //P1_bit.no7 = 0U; PM1_bit.no7 = 0U; // VC_DRV2   :P17
			   PM1_bit.no7 = 1U; // P17 = input
			   P1_bit.no7 = 0U; // Clear latch
	POM5_bit.no0 = 1U; P5_bit.no0 = 1U; PM5_bit.no0 = 0U; // DM        :P50(OpenDrain)
	POM5_bit.no1 = 1U; P5_bit.no1 = 1U; PM5_bit.no1 = 0U; // DP        :P51(OpenDrain)
			   P7_bit.no0 = 0U; PM7_bit.no0 = 0U; //PD_READY   :P70
	                   P7_bit.no1 = 0U; PM7_bit.no1 = 0U; // DISCHG    :P71
	                   P7_bit.no3 = 0U; PM7_bit.no3 = 0U; // DR_GATE   :P73
	POM8_bit.no0 = 1U; P8_bit.no0 = 1U; PM8_bit.no0 = 0U; // PUE       :P80(OpenDrain)
			   P8_bit.no1 = 0U; PM8_bit.no1 = 0U;
	//POM8_bit.no2 = 1U; P8_bit.no2 = 1U; PM8_bit.no2 = 0U; // LED       :P82(OpenDrain)
	{
		PER2 |= PER2_SMBM;
		POM3_bit.no0 = 1U; P3_bit.no0 = 1U; PM3_bit.no0= 0U; // MSTSCL
		POM3_bit.no1 = 1U; P3_bit.no1 = 1U; PM3_bit.no1= 0U; // MSTSDA
		POM3_bit.no2 = 1U; P3_bit.no2 = 1U; PM3_bit.no2= 0U; // RESET_OUT :P32(OpenDrain)
	}
	// Input Port Setting
	// NOTE:
	// set P81(INTR6) at sw_init()
	
	gusTemp   = 0U;
	gucVdmFlg = 0U;
	gucWaiCmp = 0U;
	gucOmfData = 0U;
	gucEnterModeEnable = 0U;
	gucLEDStatus = 0U;
	
	init_tau0_channel3();
	init_tm_12bit();
	
	//dcdc_init();
	subdev_init();
	smbm_init();
	//led_init();
	sw_init();
	hpd_int_init();
	
	tmuxhs4446_request_mode(TMUX_CONF_OPEN_ON);
}

void user_func_event (void)
{
	PD_STATUS uStatus = pdc_get_status();
	ULONG dp_mode_vdo = 0U;
	
	r_dbg = pdc_get_cmd_result();
	
	g_cmd_queued = 0U;
	
	hpd_poll_task();
	
	//tmuxhs4446_request_mode(TMUX_CONF_OPEN_ON); //for testing
	//g_hpd_toggled =0; //for testing
	P7_bit.no0 = 1U; //We are ready for for device Configuration.
	
    	/* send DP_STATUS VDM, but only when PD core is idle --- */
	/*if (!g_cmd_queued && (g_hpd_toggled && g_dp_mode_configured)) {
        	UCHAR r = pdc_get_cmd_result();
		
        	// Only send if no other PD command is in progress
        	if (r != PDC_CMD_RSLT_PROGRESS && gucEnterModeEnable) {
			
			
            		USHORT *tx = gSndMess.uspData;
            		USHORT dp_status = 0;
			
			g_hpd_toggled = 0U;  //clear toggled
            		g_hpd_irq_flag = 0U; // clear the flag

            		// Always report “UFP_D connected” in bits 7:6
            		dp_status |= DP_STATUS_CONN_UFP_D;

                	dp_status |= g_hpd_state << 7;


            		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA050U : 0x8050U; // DP_STATUS header
            		tx[1] = 0xFF01U;                                            // VESA SVID
            		tx[2] = dp_status;                                          // DP Status VDO
            		tx[3] = 0x0000;                                             // reserved

            		gSndMess.uInfo.bit.bLen = 8U; // 4 halfwords
            		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
			g_cmd_queued = 1U;
        	}
        	
    	}*/
	
	if (gPdc.uPdEvent.bit.bPlugChg != 0U) {
		if (uStatus.bit.bPlug != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
			//P7_bit.no1 = 0U; // DISCHG:OFF
			user_func_start_timer_thermistor();
			if (uStatus.bit.bPR != 0U) { // ATT.SRC
				gLed.uReq.bits.bSrcEn = 1U;
			}
			else {
				gLed.uReq.bits.bSnkEn = 1U;
			}
			gPdc.uPdEvent.bit.bPlugChg = 0U;
			gucWaiCmp = 0U;
		}
		else {
			P2_bit.no2 = 0U; // POWER_GOOD:OFF
			if (gucWaiCmp == 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
				pdc_set_pps_stat(0x02, 0xFF, 0xFFFFU);
#endif
				gucVdmFlg = 0U;
				gLed.uReq.bits.bDis = 1U;
				pd_tm_stop_user_cnt(TM_ID_USER2);
				gucEnterModeEnable = 0U;
				gucLEDStatus = 0U;
				if (gPdc.uPdReq.bit.bSrcOff == 0U) {
					pd_tm_start_user_cnt(TM_ID_USER2);
					//P7_bit.no1 = 1U; // DISCHG:ON
					gucWaiCmp = 1U;
				}
				else {
					gPdc.uPdEvent.bit.bPlugChg = 0U;
				}
			}
			else {
				SHORT sVbus = pdc_get_an_volt(AN_CH_VBUS);
				if (sVbus >= 0) {
					if (   (sVbus < 800)
					    || (pd_tm_chk_user_stat(TM_ID_USER2, 650U) == TM_ST_OVR)) {
						pd_tm_stop_user_cnt(TM_ID_USER2);
						gucWaiCmp = 0U;
						//P7_bit.no1 = 0U; // DISCHG:OFF
						gPdc.uPdEvent.bit.bPlugChg = 0U;
					}
				}
			}
		}
	}
	else if (gPdc.uPdEvent.bit.bPrChg != 0U) {
		if (uStatus.bit.bPR != 0U) { // ATT.SRC
			gLed.uReq.bits.bSrcEn = 1U;
		}
		else {
			gLed.uReq.bits.bSnkEn = 1U;
		}
		gPdc.uPdEvent.bit.bPrChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bDrChg != 0U) {
		gPdc.uPdEvent.bit.bDrChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewContract != 0U) {
		P2_bit.no2 = 1U; // POWER_GOOD:ON
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
		if ((uStatus.bit.bPR   != 0U) && (pdc_is_pps_mode() !=0U)) {
			pd_tm_start_user_cnt(TM_ID_USER2);
		}
#endif
		gPdc.uPdEvent.bit.bNewContract = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewSrcCap != 0U) {
		//Sink intrusive mode
		gPdc.uPdEvent.bit.bNewSrcCap = 0U;
	}
	else if (gPdc.uPdEvent.bit.bNewRequest != 0U) {
		gPdc.uPdEvent.bit.bNewRequest = 0U;
	}
	else if (gPdc.uPdEvent.bit.bChkRcvPDM != 0U) {
		
		if (gRcvMess.uInfo.bit.bClass == DATA_MESSAGE) {
        		SVDM_HEADER uVdmhead;
        		uVdmhead.data[0] = gRcvMess.uspData[0];
        		uVdmhead.data[1] = gRcvMess.uspData[1];

    			if (gRcvMess.uInfo.bit.bType == 0x06U) {   // ALERT data message
        			gGetStatPending = 1;   // mark that we must send Get_Status
    			}
        		
        		else {
			
		
        	if (uVdmhead.bit_s.bVdmType == SVDM_VDMH_TYPE_SVDM) {
            		USHORT *tx = gSndMess.uspData;

            		// ---- Discover SVIDs ----
            		if (uVdmhead.bit_s.bCmd == SVDM_VDMH_CMD_DIS_SVIDS) {
               			// Reply with VESA SVID 0xFF01 + terminator 0x0000
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA042U : 0x8042U;
				tx[1] = 0xFF00U;
				//tx[2] = 0xFF01U; // VESA
				//tx[3] = 0x0000U; // terminator
				tx[2] = 0x0000U;
				tx[3] = 0xFF01U;
                		gSndMess.uInfo.bit.bLen = 8U; // 4 halfwords
                		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				//PDC_CMD_SND_VDM = (0x2FU)  PDC_TARGET_SOP = (0U)
            		}

            		// ---- Discover Modes (for VESA) ----
            		else if ((uVdmhead.bit_s.bCmd == SVDM_VDMH_CMD_DIS_MODES) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
                		// Build a single DP Mode VDO
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA043U : 0x8043U;
                		tx[1] = 0xFF01U;  // VESA SVID
                		
				// DP Mode VDO
				dp_mode_vdo = ( DP_PORT_CAP_UFP_D | 
				DP_SIG_DP13 | 
				DP_PLUG | 
				DP_USB2_NOT_USED | 
				//DP_UFP_PIN_D |
				DP_UFP_PIN_C | 
				DP_UFP_PIN_E );
                		
				//tx[2] = (USHORT)(dp_mode_vdo);                    // low16 of VDO
    				//tx[3] = (USHORT)(dp_mode_vdo >> 16);            // high16 of VDO
				
				//Do not know why the macros dont work
				tx[2] = 0x00C5;
				tx[3] = 0x0004;

                		gSndMess.uInfo.bit.bLen = 8U;
	                	pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
	        	}

            		// ---- Enter Mode (for DP) ----
            		else if ((uVdmhead.bit_s.bCmd == SVDM_VDMH_CMD_ENTER_MODE) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
                		gucEnterModeEnable = 1U;
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA144U : 0x8144U;
                		tx[1] = 0xFF01U;
                		gSndMess.uInfo.bit.bLen = 4U;
                		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
            		}

            		// ---- Exit Mode (for DP) ----
            		else if ((uVdmhead.bit_s.bCmd == SVDM_VDMH_CMD_EXIT_MODE) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
                		gucEnterModeEnable = 0U;
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA045U : 0x8045U;
                		tx[1] = 0xFF01U;
                		gSndMess.uInfo.bit.bLen = 4U;
                		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
				tmuxhs4446_request_mode(TMUX_CONF_OPEN_ON);
				g_dp_mode_configured = 0U;
            		}

           		/*// ---- DP Status Update ----
            		else if ((uVdmhead.bit_s.bCmd == CMD_DP_STATUS) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA050U : 0x8050U;
                		tx[1] = 0xFF01U;
                		// DP Status VDO: HPD=0, IRQ=0, role=UFP_D
                		//tx[2] = DP_STATUS_READY;
				tx[2] = 0x000a;
				tx[3] = 0x0000;
                		gSndMess.uInfo.bit.bLen = 8U;
                		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
            		}
			*/
			else if ((uVdmhead.bit_s.bCmd == CMD_DP_STATUS) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
				USHORT dp_status = 0;
				P7_bit.no0 = 1U; //We are ready for for device Configuration.
    				// Always report “UFP_D connected” in bits 7:6
    				dp_status |= DP_STATUS_CONN_UFP_D;
				dp_status |= DP_STATUS_ENABLED;
    				// If HPD GPIO is high, set HPD bit
    				//if (hpd_get_level()) {
        			//dp_status |= DP_STATUS_HPD_HIGH;
    				//}
				//dp_status |= DP_STATUS_HPD_HIGH;
				
				
    				tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA050U : 0x8050U;
    				tx[1] = 0xFF01U;
    				tx[2] = dp_status; // At this stage this should be Low status
    				tx[3] = 0x0000;
                		gSndMess.uInfo.bit.bLen = 8U;
                		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
            		}

            		// ---- DP Configure ----
            		else if ((uVdmhead.bit_s.bCmd == CMD_DP_CONFIGURE) &&
                     	(uVdmhead.bit_s.bSVID == 0xFF01U)) {
                		// Validate pin assignment and ACK
                		uint8_t  cmd;
    				uint8_t  objPos;
    				UCHAR  ver;
   				USHORT hdr0;
    				USHORT hdr1;
				
				cmd    = uVdmhead.bit_s.bCmd;      /* should be 0x11 (DP_CONFIGURE) */
    				objPos = uVdmhead.bit_s.bObjPos;   /* usually 0 for DP */
				ver    = (UCHAR)uVdmhead.bit_s.bVersion;
				
				if (uStatus.bit.bPlug){
					if (uStatus.bit.bCc == 0U){
                				tmuxhs4446_request_mode(TMUX_CONF_DP4);
						//tmuxhs4446_request_mode(TMUX_CONF_OPEN_ON); //for testing
					}
					else{
						tmuxhs4446_request_mode(TMUX_CONF_DP4_FLIP);
						//tmuxhs4446_request_mode(TMUX_CONF_OPEN_ON); //for testing
					}
					
    				/* Start from received header words */
    				hdr0 = uVdmhead.data[0];   /* low 16 bits */
    				hdr1 = uVdmhead.data[1];   /* high 16 bits (contains SVID high part) */

    				/* Set CMDT = ACK (01b) while keeping other fields the same */
    				hdr0 &= (USHORT)~(0x3U << 6);      /* clear bCmdType bits */
    				hdr0 |= (USHORT)(1U   << 6);       /* bCmdType = 1 (ACK) */

    				/* (Optional) re-stamp command and objpos so we know they’re correct */
    				hdr0 &= (USHORT)~0x1FU;            /* clear bCmd  [4:0]   */
    				hdr0 |= (USHORT)(cmd & 0x1FU);

    				hdr0 &= (USHORT)~(0x7U << 8);      /* clear bObjPos [10:8] */
    				hdr0 |= (USHORT)((USHORT)objPos << 8);

    				tx[0] = hdr0;          /* Structured VDM header low word */
    				tx[1] = hdr1;          /* high word (SVID bits) */
    				//tx[2] = 0x0000U;
    				//tx[3] = 0x0000U;
					
				gSndMess.uInfo.bit.bLen = 4U;	
				pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
				g_dp_mode_configured = 1U;
					
				}
            		}

            		// ---- Default: NACK ----
            		else {
                	uVdmhead.bit_s.bCmdType = SVDM_VDMH_CMD_RESP_NACK;
                		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? uVdmhead.data[0] : uVdmhead.data[1];
                		tx[1] = 0xFF01U;
                		gSndMess.uInfo.bit.bLen = 4U;
               			pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
				g_cmd_queued = 1U;
            		}
        	}
		
		
        	else if (uStatus.bit.bComRevPDC == 1U) { // PD3
            		//pdc_set_cmd(PDC_CMD_SND_NOT_SUPPORTED, PDC_TARGET_SOP);
        	}
    	}
	}
	if (gGetStatPending) {
    		UCHAR r = pdc_get_cmd_result();

    		// Only start a new command if the previous one is not still in progress
    		if (r != PDC_CMD_RSLT_PROGRESS) {
        	pdc_set_cmd(PDC_CMD_SND_GET_STAT, PDC_TARGET_SOP);
		//pdc_set_cmd(PDC_CMD_SND_GET_SRC_CAP, PDC_TARGET_SOP);


        	gGetStatPending = 0;       // clear "need to send" flag
        	gGetStatLastResult = PDC_CMD_RSLT_PROGRESS; // for debugging if you want
    		}
	}
		
    	gPdc.uPdEvent.bit.bChkRcvPDM = 0U;
}	
	else if (gPdc.uPdEvent.bit.bNonPDCon != 0U) {
		if (uStatus.bit.bPR != 0U) { // ATT.SRC
			gPdc.uPdEvent.bit.bNonPDCon = 0U;
		}
		else {
			if(gDCInfo.uReq.usData == 0U){
				gDCInfo.uReq.bit.bSnkChg = 1U;
				gPdc.uPdEvent.bit.bNonPDCon = 0U;
			}
		}
	}
	else if (gPdc.uPdEvent.bit.bVrdChg != 0U) {
		gPdc.uPdEvent.bit.bVrdChg = 0U;
	}
	else if (gPdc.uPdEvent.bit.bHardReset != 0U) {
		gPdc.uPdEvent.bit.bHardReset = 0U;
	}
	else if (gPdc.uPdEvent.bit.bSoftReset != 0U) {
		gPdc.uPdEvent.bit.bSoftReset = 0U;
	}
	else if (gPdc.uPdEvent.bit.bErr != 0U) {
		gPdc.uPdEvent.bit.bErr = 0U;
	}
	
	if (!g_cmd_queued && (g_hpd_toggled && g_dp_mode_configured)) {
        	UCHAR r = pdc_get_cmd_result();
		
        	// Only send if no other PD command is in progress
        	if (r != PDC_CMD_RSLT_PROGRESS && gucEnterModeEnable) {
			
			
            		USHORT *tx = gSndMess.uspData;
            		USHORT dp_status = 0;
			
			//g_hpd_toggled = 0U;  //clear toggled
            		g_hpd_irq_flag = 0U; // clear the flag

            		// Always report “UFP_D connected” in bits 7:6
            		dp_status |= DP_STATUS_CONN_UFP_D;
			dp_status |= DP_STATUS_ENABLED;
                	dp_status |= g_hpd_state << 7;


            		tx[0] = (uStatus.bit.bComRevPDC != 0U) ? 0xA106U : 0x8106U; // DP_STATUS header
            		tx[1] = 0xFF01U;                                            // VESA SVID
            		tx[2] = dp_status;                                          // DP Status VDO
            		tx[3] = 0x0000;                                             // reserved

            		gSndMess.uInfo.bit.bLen = 8U; // 4 halfwords
			
			r_dbg = pdc_get_cmd_result();
			enter_dbg = gucEnterModeEnable;
            		pdc_set_cmd(PDC_CMD_SND_VDM, PDC_TARGET_SOP);
			
			r_dbg = pdc_get_cmd_result();
			
			if ((r_dbg == PDC_CMD_RSLT_PROGRESS) || (r_dbg == PDC_CMD_RSLT_SUCCESS)){
				g_hpd_toggled = 0U;  //clear toggled
				g_cmd_queued = 1U;
			}
			
        	}
        	
    	}
	
	if (gPdc.uPdReq.bit.bVconnDis != 0U) {
		//P1_bit.no6 = 0U; // VC_DRV1:OFF
		P1_bit.no7 = 0U; // VC_DRV2:OFF
		gPdc.uPdReq.bit.bVconnDis = 0U;
	}
	else if (gPdc.uPdReq.bit.bVconnEn != 0U) {
		if (uStatus.bit.bCc != 0U) { // CC2
			//P1_bit.no6 = 1U; // VC_DRV1:ON
		}
		else { // CC1
			//P1_bit.no7 = 1U; // VC_DRV2:ON
		}
		gPdc.uPdReq.bit.bVconnEn = 0U;
	}
	else if (gPdc.uPdReq.bit.bSrcOff != 0U) {
		P2_bit.no2 = 0U; // POWER_GOOD:OFF
		if (gucWaiCmp == 0U) {
			gDCInfo.uReq.bit.bSrcOff = 1U;
			gucWaiCmp = 1U;
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
			pd_tm_stop_user_cnt(TM_ID_USER2);
#endif
		}
		else {
			if(gDCInfo.uNtfy.bit.bUnexpected == 1U){
				gDCInfo.uNtfy.bit.bUnexpected = 0U;
				P7_bit.no1 = 0U; // DISCHG:OFF
				gPdc.uPdReq.bit.bSrcOff    = 0U;
				gucWaiCmp = 0U;
			}
			else{
				SHORT usVbus = pdc_get_an_volt(AN_CH_VBUS);
				if (usVbus >= 0) {
					if (usVbus <= 800) {
						//P7_bit.no1 = 0U; // DISCHG:OFF
						gPdc.uPdReq.bit.bSrcOff    = 0U;
						gucWaiCmp = 0U;
					}
					else if (usVbus <= 5500) {
						P7_bit.no3 = 0U; // DR_GATE:OFF
						//P7_bit.no1 = 1U; // DISCHG:ON
					}
				}
			} 
		}
	}
	else if (gPdc.uPdReq.bit.bSnkOff != 0U) {
		P2_bit.no2 = 0U; // POWER_GOOD:OFF
		if (uStatus.bit.bPlug == 0U) { // Unplug
			P7_bit.no3 = 0U; // DR_GATE:OFF
			gDCInfo.uReq.bit.bSnkOff = 1U;
		}
		else {
			if (pdc_get_req_volt() == 0U) {
				P7_bit.no3 = 0U; // DR_GATE:OFF
			}
			gDCInfo.uReq.bit.bSnkOff = 1U;
		}
		gPdc.uPdReq.bit.bSnkOff = 0U;
	}
	else if (gPdc.uPdReq.bit.bSrcOn != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			P7_bit.no3 = 1U; // DR_GATE:ON
			gDCInfo.uReq.bit.bSrcOn = 1U;
			gPdc.uPdReq.bit.bSrcOn = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bSrcChg != 0U) {
#if PPS_SPRT // If set to 1, need to add APDO to Source PDOs and to enable PD_PDM_SPRT_GET_PPS_STATUS
		pd_tm_stop_user_cnt(TM_ID_USER2);
#endif
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSrcChg = 1U;
			gPdc.uPdReq.bit.bSrcChg = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bSnkOn != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			P7_bit.no3 = 1U; // DR_GATE:ON Repurpose for SXR
			gDCInfo.uReq.bit.bSnkOn = 1U;
			gPdc.uPdReq.bit.bSnkOn = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bSnkChg != 0U) {
		if(gDCInfo.uReq.usData == 0U){
			gDCInfo.uReq.bit.bSnkChg = 1U;
			gPdc.uPdReq.bit.bSnkChg = 0U;
		}
	}
	else if (gPdc.uPdReq.bit.bGotoMin != 0U) {
		gPdc.uPdReq.bit.bGotoMin = 0U;
	}
	else if(gDCInfo.uNtfy.bit.bUnexpected == 1U){
		// disconnet
		pdc_set_cmd(PDC_CMD_ENTR_ERR_RCVR, 0);
		gDCInfo.uNtfy.bit.bUnexpected = 0U;
	}
	else if( gDCInfo.uNtfy.usData != 0U){
		gDCInfo.uNtfy.usData = 0U;
	}
}
/*
#pragma vector = INTP7_vect
__interrupt static void hpd_int_isr(void)
{
    // Clear flag
    IF0L_bit.no7 = 0U;

    // Tell system an HPD edge occurred
    g_hpd_irq_flag = 1U;
}
*/