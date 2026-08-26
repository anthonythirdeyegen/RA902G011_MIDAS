#include "user_main.h"
#include "user_timer.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "isl95538b.h"
#include "smbm_ctrl.h"
#include "dcdc_cmd_list.h"
#include "R9A02G011PDC.h"
#include "mppm_pb_defs.h"

/******************************************************************************
// STATUS
******************************************************************************/
// Main Staus
#define DCDC_ST_MAIN_S0		(0U)
#define DCDC_ST_MAIN_S1		(1U)

#define DCDC_ST_SUB_IDLE				(0x00U)
#define DCDC_ST_SUB_S0_1				(0x01U)
#define DCDC_ST_SUB_S0_2				(0x02U)
#define DCDC_ST_SUB_S0_3				(0x03U)
#define DCDC_ST_SUB_S0_4				(0x04U)
#define DCDC_ST_SUB_S0_5				(0x05U)
#define DCDC_ST_SUB_S0_6				(0x06U)
#define DCDC_ST_SUB_S0_7				(0x07U)
#define DCDC_ST_SUB_S0_8				(0x08U)

#define DCDC_ST_SUB_S1_SRC_OFF_1		(0x10U)
#define DCDC_ST_SUB_S1_SRC_OFF_2		(0x11U)
#define DCDC_ST_SUB_S1_SRC_OFF_3		(0x12U)
#define DCDC_ST_SUB_S1_SRC_OFF_4		(0x13U)

#define DCDC_ST_SUB_S1_SRC_ON_1			(0x20U)
#define DCDC_ST_SUB_S1_SRC_ON_2			(0x21U)
#define DCDC_ST_SUB_S1_SRC_ON_3			(0x22U)
#define DCDC_ST_SUB_S1_SRC_ON_4			(0x23U)
#define DCDC_ST_SUB_S1_SRC_ON_5			(0x24U)
#define DCDC_ST_SUB_S1_SRC_ON_6			(0x25U)
#define DCDC_ST_SUB_S1_SRC_ON_7			(0x26U)
#define DCDC_ST_SUB_S1_SRC_ON_8			(0x27U)
#define DCDC_ST_SUB_S1_SRC_ON_9			(0x28U)
#define DCDC_ST_SUB_S1_SRC_ON_10		(0x29U)
#define DCDC_ST_SUB_S1_SRC_ON_11		(0x2AU)

#define DCDC_ST_SUB_S1_SRC_CHG_1		(0x30U)
#define DCDC_ST_SUB_S1_SRC_CHG_2		(0x31U)
#define DCDC_ST_SUB_S1_SRC_CHG_3		(0x32U)
#define DCDC_ST_SUB_S1_SRC_CHG_4		(0x33U)

#define DCDC_ST_SUB_S1_SNK_OFF_1		(0x40U)
#define DCDC_ST_SUB_S1_SNK_OFF_2		(0x41U)
#define DCDC_ST_SUB_S1_SNK_OFF_3		(0x42U)
#define DCDC_ST_SUB_S1_SNK_OFF_4		(0x43U)
#define DCDC_ST_SUB_S1_SNK_OFF_5		(0x44U)

#define DCDC_ST_SUB_S1_SNK_ON_1			(0x50U)
#define DCDC_ST_SUB_S1_SNK_ON_2			(0x51U)
#define DCDC_ST_SUB_S1_SNK_ON_3			(0x52U)
#define DCDC_ST_SUB_S1_SNK_ON_4			(0x53U)
#define DCDC_ST_SUB_S1_SNK_ON_5			(0x54U)
#define DCDC_ST_SUB_S1_SNK_ON_6			(0x55U)
#define DCDC_ST_SUB_S1_SNK_ON_7			(0x56U)
#define DCDC_ST_SUB_S1_SNK_ON_8			(0x57U)

#define DCDC_ST_SUB_S1_SNK_CHG_1		(0x60U)
#define DCDC_ST_SUB_S1_SNK_CHG_2		(0x61U)
#define DCDC_ST_SUB_S1_SNK_CHG_3		(0x62U)
#define DCDC_ST_SUB_S1_SNK_CHG_4		(0x63U)
#define DCDC_ST_SUB_S1_SNK_CHG_5		(0x64U)
#define DCDC_ST_SUB_S1_SNK_CHG_6		(0x65U)

#define DCDC_ST_SUB_S1_POLL_1			(0x70U)
#define DCDC_ST_SUB_S1_POLL_2			(0x71U)
#define DCDC_ST_SUB_S1_POLL_3			(0x72U)

#define DCDC_ST_SUB_S1_UV_1				(0x80U)
#define DCDC_ST_SUB_S1_UV_2				(0x81U)

DCDC_INFO gDCInfo;

#define BBCHG_FLG   (ISL95538B_DEVICE_ID)
#define BBCHG_RUN() (gSubdevInfo.ucSubdevFlag |= BBCHG_FLG)
#define BBCHG_CHK() (gSubdevInfo.ucSubdevFlag & BBCHG_FLG)
#define BBCHG_IDLE ((UCHAR)0x00)

void isl_s0(void);
void isl_s1(void);
void isl_s1_on_sq(void);
void isl_s1_off_sq(void);
void isl_s1_chg_sq(void);
void isl_s1_snk_off_sq(void);
void isl_s1_snk_on_sq(void);
void isl_s1_snk_chg_sq(void);
void isl_s1_get_info(void);
void isl_s1_en_uv(void);

void dcdc_ctrl(void)
{
	if( (gSubdevInfo.ucSubdevFlag & BBCHG_FLG) != 0U ){
		return;
	}
	
	switch(gDCInfo.uSt.bit.bSt){
		case DCDC_ST_MAIN_S0:
			isl_s0();
			break;
		case DCDC_ST_MAIN_S1:
			isl_s1();
			break;
		default:
			break;
	}
	return;
}

void dcdc_init(void)
{
	gDCInfo.uReq.usData = 0U;
	gDCInfo.uNtfy.usData = 0U;
	gDCInfo.uSt.usData = 0U;
	gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
	gDCInfo.ucTrickeBkp = 1U;
	return;
}

void isl_s0(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		//gDCInfo.uNtfy.bit.bUnexpected = 1U;
		//gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_1;
#else
			gDCInfo.ucCmd = BBCHG_INIT_CTR0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_1;
			BBCHG_RUN();
#endif
			break;
		case DCDC_ST_SUB_S0_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_2:
			gDCInfo.ucCmd = BBCHG_INIT_CTR2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_3:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_4;
#else
			gDCInfo.ucCmd = BBCHG_INIT_CTR4;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_4;
			BBCHG_RUN();
#endif
			break;
		case DCDC_ST_SUB_S0_4:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_5:
			gDCInfo.ucCmd = BBCHG_INIT_INPUTVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_6;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_6:
			gDCInfo.ucCmd = BBCHG_INIT_ADPCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_7;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_7:
			gDCInfo.ucCmd = BBCHG_INIT_CHGCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_8;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_8:
			gSubDevErr.ucSubdev &= ~BBCHG_FLG;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
			break;
		default:
			break;
	}

	return;
}

void isl_s1(void)
{
	if(gDCInfo.uReq.bit.bSrcOff == 1U){
		if(gDCInfo.uReq.usData == DCDC_FLG_SRCOFF){
			isl_s1_off_sq();
		}
		else{
			gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			gDCInfo.uReq.usData = DCDC_FLG_SRCOFF;
		}
	}
	else if(gDCInfo.uReq.bit.bSrcOn == 1U){
		isl_s1_on_sq();
	}
	else if(gDCInfo.uReq.bit.bSrcChg == 1U){
		isl_s1_chg_sq();
	}
	else if(gDCInfo.uReq.bit.bSnkOff == 1U){
		if(gDCInfo.uReq.usData == DCDC_FLG_SNKOFF){
			isl_s1_snk_off_sq();
		}
		else{
			gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			gDCInfo.uReq.usData = DCDC_FLG_SNKOFF;
		}
	}
	else if(gDCInfo.uReq.bit.bSnkOn == 1U){
		isl_s1_snk_on_sq();
	}
	else if(gDCInfo.uReq.bit.bSnkChg == 1U){
		isl_s1_snk_chg_sq();
	}
	else if (gDCInfo.uReq.bit.bNewContract == 1U) {
#if ISL9238C_EN //Set to 1 if using ISL9283C
		isl_s1_en_uv();
#else
		gDCInfo.uReq.bit.bNewContract = 0U;
#endif
	}
	else if(gDCInfo.uReq.bit.bClrAlert == 1U){
		gDCInfo.uReq.bit.bClrAlert = 0U;
	}
	else if(gDCInfo.uReq.bit.bPoll == 1U){
		isl_s1_get_info();
	}
	return;
}

void isl_s1_off_sq(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSrcOff = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.ucCmd = BBCHG_CTR6_DIS_UV;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_1;
			BBCHG_RUN();
#else
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_2;
#endif
			break;
		case DCDC_ST_SUB_S1_SRC_OFF_1:		
			gDCInfo.ucCmd = BBCHG_CTR4_EN_ADPDISCHG;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_OFF_2:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_OFF_3:
			gDCInfo.ucCmd = BBCHG_INIT_CTR1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_OFF_4:
			gDCInfo.uReq.bit.bSrcOff = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}

	return;
}

void isl_s1_on_sq(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSrcOn = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}
	
	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.ucCmd = BBCHG_CTR6_EN_UV;
#else
			gDCInfo.ucCmd = BBCHG_CTR0_EN_LOAD;
#endif
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_2:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_3;
#else
			gDCInfo.ucCmd = BBCHG_INIT_CTR4;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_3;
			BBCHG_RUN();
#endif
			break;
		case DCDC_ST_SUB_S1_SRC_ON_3:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_4;
			BBCHG_RUN();
			break;			
		case DCDC_ST_SUB_S1_SRC_ON_4:
			gDCInfo.ucCmd = BBCHG_INIT_INPUTVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_5:
			gDCInfo.ucCmd = BBCHG_INIT_ADPCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_6;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_6:
			gDCInfo.ucCmd = BBCHG_INIT_CHGCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_7;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_7:
			gDCInfo.ucCmd = BBCHG_SET_OTGVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_8;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_8:
			gDCInfo.ucCmd = BBCHG_SET_OTGCURR;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_9;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_9:
			gDCInfo.ucCmd = BBCHG_SET_CTRL3_BGATE;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_10;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_10:
			gDCInfo.ucCmd = BBCHG_SET_OTG;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_11;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_11:
			gDCInfo.uReq.bit.bSrcOn = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_SRC;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
		}

	return;
}

void isl_s1_chg_sq(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSrcChg = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

		switch(gDCInfo.uSt.bit.bSubSt){
			case DCDC_ST_SUB_IDLE:
#if ISL9238C_EN //Set to 1 if using ISL9283C
				gDCInfo.ucCmd = BBCHG_CTR6_EN_SLEW;
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_1;
				BBCHG_RUN();
#else
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_1;
#endif
				break;
			case DCDC_ST_SUB_S1_SRC_CHG_1:
				gDCInfo.ucCmd = BBCHG_SET_CTRL3_BGATE;
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_2;
				BBCHG_RUN();
				break;
			case DCDC_ST_SUB_S1_SRC_CHG_2:
				gDCInfo.ucCmd = BBCHG_SET_OTGVOLT;
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_3;
				BBCHG_RUN();
				break;
			case DCDC_ST_SUB_S1_SRC_CHG_3:
				gDCInfo.ucCmd = BBCHG_SET_OTGCURR;
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_4;
				BBCHG_RUN();
				break;
			case DCDC_ST_SUB_S1_SRC_CHG_4:
				gDCInfo.uReq.bit.bSrcChg = 0U;
				gDCInfo.uNtfy.bit.bUnexpected = 0U;
				//gDCInfo.uSt.bit.bDcSt = DCDC_SRC;
				//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
				break;
			default:
				break;
		}

	return;
}

void isl_s1_snk_off_sq(void)
{
	USHORT usVolt=0U;
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSnkOff = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			usVolt = pdc_get_req_volt();
#if ISL9238C_EN //Set to 1 if using ISL9283C
			if( usVolt == 0U){
				gDCInfo.ucCmd = BBCHG_CTR4_EN_ADPDISCHG;
			}
			else{
				gDCInfo.ucCmd = BBCHG_INIT_CTR4;
			}
#else
			if( usVolt == 0U){
				gDCInfo.ucCmd = BBCHG_CTR0_EN_LOAD;
			}
			else{
				gDCInfo.ucCmd = BBCHG_CTR0_DIS_LOAD;
			}
#endif
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_2:
			gDCInfo.ucCmd = BBCHG_INIT_ADPCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_3:
			gDCInfo.ucCmd = BBCHG_INIT_CHGCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_4:
			gDCInfo.ucCmd = BBCHG_INIT_CTR1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_5:
			gDCInfo.uReq.bit.bSnkOff = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			break;
		default:
			break;
	}
	
	return;
}

void isl_s1_snk_on_sq(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSnkOn = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
#if ISL9238C_EN //Set to 1 if using ISL9283C
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_1;
#else
			gDCInfo.ucCmd = BBCHG_CTR0_DIS_LOAD;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_1;
			BBCHG_RUN();
#endif
			break;
		case DCDC_ST_SUB_S1_SNK_ON_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_2:
			gDCInfo.ucCmd = BBCHG_INIT_CTR2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_3:
			gDCInfo.ucCmd = BBCHG_INIT_CTR4;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_4:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_5:
			gDCInfo.ucCmd = BBCHG_INIT_INPUTVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_6;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_6:
			gDCInfo.ucCmd = BBCHG_INIT_ADPCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_7;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_7:
			gDCInfo.ucCmd = BBCHG_INIT_CHGCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_8;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_8:
			gDCInfo.uReq.bit.bSnkOn = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}
	
	return;
}

void isl_s1_snk_chg_sq(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bSnkChg = 0U;
		if ((gMpPb.othPortInfo.bit.bPlugState == 1U) && (gMpPb.othPortInfo.bit.bPowerRole == 0U)) {
			gMpPb.uStat.bit.bResetDcdcComp = 1U;
			gMpPb.uEvent.bit.bResetDcdcComp = 1U;
		}
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			gDCInfo.ucCmd = BBCHG_SET_CTRL1_VSYS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR3;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_2:
			gDCInfo.ucCmd = BBCHG_SET_ADPCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_3:
			gDCInfo.ucCmd = BBCHG_INIT_MAXVOL;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_4:
			gDCInfo.ucCmd = BBCHG_INIT_MINVOL;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_5:
			gDCInfo.ucCmd = BBCHG_SET_CHGCURRLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_6;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_6:
			gDCInfo.uReq.bit.bSnkChg = 0U;
			if ((gMpPb.othPortInfo.bit.bPlugState == 1U) && (gMpPb.othPortInfo.bit.bPowerRole == 0U)) {
				gMpPb.uStat.bit.bResetDcdcComp  = 1U;
				gMpPb.uEvent.bit.bResetDcdcComp = 1U;
			}
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_SNK;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}

	return;
}

void isl_s1_get_info(void){
	PD_STATUS uStatus;
	
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		//gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uNtfy.bit.bUnexpected = 0U;
		gDCInfo.uReq.bit.bPoll = 0U;
		//gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			if(gDCInfo.uSt.bit.bDcSt == DCDC_SNK){
				gDCInfo.ucCmd = BBCHG_SET_CHGCURRLIMIT;
				BBCHG_RUN();
				gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_POLL_1;
				break;
			}
			// if gDCInfo.uSt.bit.bDcSt != DCDC_SNK, goto DCDC_ST_SUB_S1_POLL_1.
		case DCDC_ST_SUB_S1_POLL_1:
			gDCInfo.ucCmd = BBCHG_GET_INFO1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_POLL_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_POLL_2:
			uStatus = pdc_get_status();
			if((uStatus.bit.bPlug == 1U) &&(uStatus.bit.bPR == 1U)){
				if (pdc_is_pps_mode() != 0U) { // PPS supply
					gDCInfo.uNtfy.bit.bGetInfo = 1U;
					if( (gDCInfo.usRegData & 0x6000) == 0x4000 ){
						gDCInfo.uNtfy.bit.bOcpAlert = 1U;
					}
					else{
						gDCInfo.uNtfy.bit.bOcpAlert = 0U;
					}
				}
			}
			if ((uStatus.bit.bPlug != 0U) && (uStatus.bit.bPR == 0U)) {
				if (((gDCInfo.usRegData & 0x0010) >> 4) != gDCInfo.ucTrickeBkp) {
					gDCInfo.ucTrickeCnt += 1U;
					if (gDCInfo.ucTrickeCnt >= 3U) {
						gDCInfo.ucTrickeCnt = 0U;
						gDCInfo.uNtfy.bit.bTrickleChange = 1U;
						gDCInfo.ucTrickeBkp = (gDCInfo.usRegData & 0x0010) >> 4;
					}
				}
				else {
					gDCInfo.ucTrickeCnt = 0U;
				}
			}
			else {
				gDCInfo.uNtfy.bit.bTrickleChange = 0U;
				gDCInfo.ucTrickeBkp = 1U;
				gDCInfo.ucTrickeCnt = 0U;
			}
			gDCInfo.ucCmd = BBCHG_GET_INFO2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_POLL_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_POLL_3:
			gDCInfo.uReq.bit.bPoll = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}

	return;
}

void isl_s1_en_uv(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bNewContract = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			if (pdc_is_pps_mode() == 0U) {
				gDCInfo.ucCmd = BBCHG_CTR6_EN_UV;
				BBCHG_RUN();
			}
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_UV_1;
			break;
		case DCDC_ST_SUB_S1_UV_1:
			gDCInfo.ucCmd = BBCHG_INIT_CTR4;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_UV_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_UV_2:
			gDCInfo.uReq.bit.bNewContract = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}

	return;
}
