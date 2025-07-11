#include "user_main.h"
#include "user_timer.h"
#include "dcdc_ctrl.h"
#include "subdev_ctrl.h"
#include "isl9241.h"
#include "smbm_ctrl.h"
#include "dcdc_cmd_list.h"
#include "R9A02G011PDC.h"

/******************************************************************************
// STATUS
******************************************************************************/
// Main Staus
#define DCDC_ST_MAIN_S0		(0U)
#define DCDC_ST_MAIN_S1		(1U)

#define DCDC_ST_SUB_IDLE				(  0U)
#define DCDC_ST_SUB_S0_1				(  1U)
#define DCDC_ST_SUB_S0_2				(  2U)
#define DCDC_ST_SUB_S0_3				(  3U)
#define DCDC_ST_SUB_S0_4				(  4U)
#define DCDC_ST_SUB_S0_5				(  5U)
#define DCDC_ST_SUB_S0_6				(  6U)
#define DCDC_ST_SUB_S0_7				(  7U)
#define DCDC_ST_SUB_S0_8				(  8U)
#define DCDC_ST_SUB_S1_SRC_OFF_1		( 10U)
#define DCDC_ST_SUB_S1_SRC_OFF_2		( 11U)
#define DCDC_ST_SUB_S1_SRC_OFF_3		( 12U)
#define DCDC_ST_SUB_S1_SRC_OFF_4		( 13U)

#define DCDC_ST_SUB_S1_SRC_ON_1			( 20U)
#define DCDC_ST_SUB_S1_SRC_ON_2			( 21U)
#define DCDC_ST_SUB_S1_SRC_ON_3			( 22U)
#define DCDC_ST_SUB_S1_SRC_ON_4			( 23U)
#define DCDC_ST_SUB_S1_SRC_ON_5			( 24U)
#define DCDC_ST_SUB_S1_SRC_ON_6			( 25U)
#define DCDC_ST_SUB_S1_SRC_ON_7			( 26U)
#define DCDC_ST_SUB_S1_SRC_ON_8			( 27U)
#define DCDC_ST_SUB_S1_SRC_ON_9			( 28U)

#define DCDC_ST_SUB_S1_SRC_CHG_1		( 30U)
#define DCDC_ST_SUB_S1_SRC_CHG_2		( 31U)
#define DCDC_ST_SUB_S1_SRC_CHG_3		( 32U)
#define DCDC_ST_SUB_S1_SRC_CHG_4		( 33U)

#define DCDC_ST_SUB_S1_SNK_OFF_1		( 40U)
#define DCDC_ST_SUB_S1_SNK_OFF_2		( 41U)
#define DCDC_ST_SUB_S1_SNK_OFF_3		( 42U)
#define DCDC_ST_SUB_S1_SNK_OFF_4		( 43U)

#define DCDC_ST_SUB_S1_SNK_ON_1			( 50U)
#define DCDC_ST_SUB_S1_SNK_ON_2			( 51U)
#define DCDC_ST_SUB_S1_SNK_ON_3			( 52U)
#define DCDC_ST_SUB_S1_SNK_ON_4			( 53U)
#define DCDC_ST_SUB_S1_SNK_ON_5			( 54U)

#define DCDC_ST_SUB_S1_SNK_CHG_1		( 39U)
#define DCDC_ST_SUB_S1_SNK_CHG_2		( 40U)
#define DCDC_ST_SUB_S1_SNK_CHG_3		( 41U)
#define DCDC_ST_SUB_S1_SNK_CHG_4		( 42U)
#define DCDC_ST_SUB_S1_SNK_CHG_5		( 43U)
#define DCDC_ST_SUB_S1_SNK_CHG_6		( 44U)

#define DCDC_ST_SUB_S1_CLR_ALERT_1		( 50U)
#define DCDC_ST_SUB_S1_POLL_1			( 60U)
#define DCDC_ST_SUB_S1_POLL_2			( 61U)

DCDC_INFO gDCInfo;

#define BBCHG_FLG   (ISL9241_DEVICE_ID)
#define BBCHG_RUN() (gSubdevInfo.ucSubdevFlag |= BBCHG_FLG)
#define BBCHG_CHK() (gSubdevInfo.ucSubdevFlag & BBCHG_FLG)

void isl_s0(void);
void isl_s1(void);
void isl_s1_on_sq(void);
void isl_s1_off_sq(void);
void isl_s1_chg_sq(void);
void isl_s1_snk_off_sq(void);
void isl_s1_snk_on_sq(void);
void isl_s1_snk_chg_sq(void);
void isl_s1_clr_sq(void);
void isl_s1_reset_sq(void);
void isl_s1_get_info(void);

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
	
	return;
}

void isl_s0(void)
{
	if( (gSubDevErr.ucSubdev & BBCHG_FLG) != 0U ){
		gSubDevErr.ucSubdev &= ~BBCHG_FLG;
		//gDCInfo.uNtfy.bit.bUnexpected = 1U;
		//gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		//gDCInfo.uSt.bit.bSt    = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
		case DCDC_ST_SUB_S0_1:
			gDCInfo.ucCmd = BBCHG_SET_CTRL1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_2:
			gDCInfo.ucCmd = BBCHG_SET_CTRL0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_3:
			gDCInfo.ucCmd = BBCHG_SET_MINSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S0_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S0_4:
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
			gDCInfo.ucCmd = BBCHG_SET_CTRL1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_OFF_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_OFF_1:
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
			gDCInfo.ucCmd = BBCHG_SET_CTRL0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_1:
			gDCInfo.ucCmd = BBCHG_SET_MINSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_2:
			gDCInfo.ucCmd = BBCHG_SET_OTGVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_3:
			gDCInfo.ucCmd = BBCHG_SET_OTGCUR;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_4:
			gDCInfo.ucCmd = BBCHG_SET_CTRL1_OTG;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_ON_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_ON_5:
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
			gDCInfo.ucCmd = BBCHG_SET_CTRL0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_CHG_1:
			gDCInfo.ucCmd = BBCHG_SET_OTGVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_CHG_2:
			gDCInfo.ucCmd = BBCHG_SET_OTGCUR;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SRC_CHG_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SRC_CHG_3:
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
			gDCInfo.ucCmd = BBCHG_SET_MINSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_1:
			gDCInfo.ucCmd = BBCHG_SET_CTRL1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_2:
			gDCInfo.ucCmd = BBCHG_SET_CTRL0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_3:
			gDCInfo.ucCmd = BBCHG_SET_MAXSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_OFF_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_OFF_4:
			gDCInfo.uReq.bit.bSnkOff = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
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
			gDCInfo.ucCmd = BBCHG_SET_CTRL1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_1:
			gDCInfo.ucCmd = BBCHG_SET_CTRL0;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_2:
			gDCInfo.ucCmd = BBCHG_SET_MINSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_3:
			gDCInfo.ucCmd = BBCHG_SET_MAXSYSVOLT_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_ON_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_ON_4:
			gDCInfo.uReq.bit.bSnkOn = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bDcSt = DCDC_IDLE;
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
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			gDCInfo.ucCmd = BBCHG_SET_ADPCURLIMIT1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_1:
			gDCInfo.ucCmd = BBCHG_SET_MAXSYSVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_2:
			gDCInfo.ucCmd = BBCHG_SET_CTRL2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_3;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_3:
			gDCInfo.ucCmd = BBCHG_SET_MINSYSVOLT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_4;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_4:
			gDCInfo.ucCmd = BBCHG_SET_CTRL0_BYPASS_DIS;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_5;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_5:
			gDCInfo.ucCmd = BBCHG_SET_CHRCURLIMIT;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_SNK_CHG_6;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_SNK_CHG_6:
			gDCInfo.uReq.bit.bSnkChg = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bDcSt = DCDC_SNK;
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
		gDCInfo.uNtfy.bit.bUnexpected = 1U;
		gDCInfo.uReq.bit.bPoll = 0U;
		gDCInfo.uSt.bit.bDcSt = DCDC_INIT;
		gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S0;
		gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
		return;
	}

	switch(gDCInfo.uSt.bit.bSubSt){
		case DCDC_ST_SUB_IDLE:
			gDCInfo.ucCmd = BBCHG_GET_INFO2;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_POLL_1;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_POLL_1:
			gDCInfo.ucCmd = BBCHG_GET_INFO1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_S1_POLL_2;
			BBCHG_RUN();
			break;
		case DCDC_ST_SUB_S1_POLL_2:
			uStatus = pdc_get_status();
			if((uStatus.bit.bPlug == 1U) &&(uStatus.bit.bPR == 1U)){
				if( (gDCInfo.usRegData & 0x6000) == 0x4000 ){
					gDCInfo.uNtfy.bit.bOcpAlert = 1U;
				}
				else{
					gDCInfo.uNtfy.bit.bOcpAlert = 0U;
				}
			}

			gDCInfo.uReq.bit.bPoll = 0U;
			gDCInfo.uNtfy.bit.bUnexpected = 0U;
			//gDCInfo.uSt.bit.bDcSt = XXX;
			//gDCInfo.uSt.bit.bSt = DCDC_ST_MAIN_S1;
			gDCInfo.uSt.bit.bSubSt = DCDC_ST_SUB_IDLE;
			break;
		default:
			break;
	}

	return;
}

