#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#include "isl95338.h"
#include "typedefs.h"
#include "r_cg_macrodriver.h"

/******************************************************************************
 Global values
******************************************************************************/
SUBDEV_INFO gSubdevInfo;
SUBDEV_ERR gSubDevErr;

#define SUBDEV_CTRL_FUNC	((UCHAR)8U)

static const UCHAR ucBitMask[SUBDEV_CTRL_FUNC]={
	0x01U,			// subdev0	Priority: Hight
	0x02U,			// subdev1
	0x04U,			// subdev2
	0x08U,			// subdev3
	0x10U,			// subdev4
	0x20U,			// subdev5
	0x40U,			// subdev6
	0x80U			// subdev7	Priority: Low
};

static const  ULONG ulSuvdevInitFunc[SUBDEV_CTRL_FUNC]={
	(ULONG)&init_isl95338,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
};

#define ALERT_FUN_MSK ((UCHAR)0x0A)

// Driver Function Tables
static const ULONG ulSuvdevAlertFunc[SUBDEV_CTRL_FUNC]={
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
};

static const ULONG ulSubdevFunc[SUBDEV_CTRL_FUNC]={
	(ULONG)&isl95338_ctrl,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
};

static const ULONG ulSubdevResetFunc[SUBDEV_CTRL_FUNC]={
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL,
	NULL
};

/******************************************************************************
 Private fanctions
******************************************************************************/
void subdev_handler(void);

/******************************************************************************
 Initialize subdev_ctrl module
******************************************************************************/
void subdev_init(void){

	UCHAR i;

	gSubdevInfo.ucSubdevFlag = 0U;
	gSubdevInfo.ucSubdevHRFlag = 0U;
	gSubdevInfo.ucSubdevAlertFlag = 0U;
	gSubdevInfo.ucReserved = 0U;

	gSubDevErr.ucSubdev = 0U;
	gSubDevErr.ucError = 0U;

	for(i=0; i<SUBDEV_CTRL_FUNC; i++) {
		if( (ulSuvdevInitFunc[i] != NULL) ){
			((void(*)(void))ulSuvdevInitFunc[i])();
		}
	}

	return;
}

/******************************************************************************
 SMBus Master Handler
******************************************************************************/
void subdev_ctrl(void)
{
	UCHAR i;

	if(gSubdevInfo.ucSubdevHRFlag != 0x00)
	{
		for(i=0U; i<SUBDEV_CTRL_FUNC;i++){
			if((gSubdevInfo.ucSubdevHRFlag & ucBitMask[i]) != 0x00)
			{
				if(ulSubdevResetFunc[i] != NULL){
					((void(*)(void))ulSubdevResetFunc[i])();
				}
				gSubdevInfo.ucSubdevHRFlag &= ~ucBitMask[i];
			}
		}
	}
	else{
		// Alert
		if(gSubdevInfo.ucSubdevAlertFlag != 0x00){
			for(i=0U; i<SUBDEV_CTRL_FUNC; i++){
				if((gSubdevInfo.ucSubdevAlertFlag & ucBitMask[i]) != 0x00){
					// Flag Enbale
					if(ulSuvdevAlertFunc[i] != NULL){
						((void(*)(void))ulSuvdevAlertFunc[i])();
					}
					else{
						gSubdevInfo.ucSubdevAlertFlag &= ~ucBitMask[i];
					}
				}
			}
		}

		if(gSubdevInfo.ucSubdevFlag != 0x00){
			for(i=0U; i<SUBDEV_CTRL_FUNC;i++){
				if((gSubdevInfo.ucSubdevFlag & ucBitMask[i]) != 0x00)
				{
					if(ulSubdevFunc[i] != NULL){
						((void(*)(void))ulSubdevFunc[i])();
					}
					else{
						gSubdevInfo.ucSubdevFlag &= ~ucBitMask[i];
					}
				}
			}
		}
	}

	return;
}

UCHAR subdev_get_alerthandler(void)
{
	int i=0;
	for(i=0; i< SUBDEV_CTRL_FUNC; i++){
		if(ulSuvdevAlertFunc[i] != NULL){
			return 1U;
		}
	}

	return 0U;
}

UCHAR subdev_get_alert_signal(void)
{
	return 1U;
}