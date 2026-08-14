#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif
#include "interrupt.h"
#include "user_timer.h"
#include "R9A02G011PDC.h"
#include "sw_ctrl.h"

void sw_func_intr_sw      (void);
void sw_func_intr_timer_sw(void);

SW_INFO gSW;

void sw_init(void)
{
	init_tau0_channel1();
	pdc_set_int_routine(intID_INTP6, (ULONG)&sw_func_intr_sw);
	//P8_bit.no1 = 1U; PM8_bit.no1 = 1U; PMK6 = 0U; // SW :P81(INTR6) I am using this pin for another purpose
	P8_bit.no1 = 0U; PM8_bit.no1 = 1U; PMK6 = 0U; // SW :P81(INTR6)
	gSW.status = SW_STATE_PULL;
	gSW.ucPress = 0U;
}

UCHAR sw_ctrl(void)
{
	switch (gSW.status) {
		case SW_STATE_PUSH :
			if (gSW.ucPress == 0U) {
				gSW.status = SW_STATE_PULL;
			}
			break;
		default : // SW_STATE_PULL
			if (gSW.ucPress != 0U) {
				gSW.status = SW_STATE_PUSH;
			}
			break;
	}
	
	if (tm1_is_start_gtimer() != 0U) {
		return PD_CORE_IDLE;
	}
	else {
		return PD_CORE_STOP;
	}
}

void sw_func_intr_sw (void)
{
	pdc_timer_active();
	tm1_start_gtimer(1000, (ULONG)&sw_func_intr_timer_sw);
}

void sw_func_intr_timer_sw (void)
{
	if (P8_bit.no1 == 1U) { // pull
		gSW.ucPress = 0U;
	}
	else { // push
		gSW.ucPress = 1U;
	}
	tm1_stop_gtimer();
}