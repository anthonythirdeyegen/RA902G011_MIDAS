#include "user_timer.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#endif
#include "r_cg_timer.h"
#include "interrupt.h"

USHORT tm_calc_counter(USHORT usPeriod);// Note:
// TAU0 Channel 0 is used by PDC library.

void init_tau0_channel1 (void)
{
	TMPR101 = 1U;
	TMPR001 = 1U;
	// Channel 1 used as interval timer
	TMR01 = _C000_TAU_CLOCK_SELECT_CKM3 | _0000_TAU_CLOCK_MODE_CKS | _0000_TAU_16BITS_MODE |
		_0000_TAU_TRIGGER_SOFTWARE | _0000_TAU_MODE_INTERVAL_TIMER | _0000_TAU_START_INT_UNUSED;
	TO0 &= ~_0002_TAU_CH1_OUTPUT_VALUE_1;
	TOE0 &= ~_0002_TAU_CH1_OUTPUT_ENABLE;

	TPS0 |= (USHORT)(0xFU << 4);
}

void init_tau0_channel2 (void)
{
	TMPR102 = 1U;
	TMPR002 = 1U;
	// Channel 2 used as interval timer
	TMR02 = _8000_TAU_CLOCK_SELECT_CKM1 | _0000_TAU_CLOCK_MODE_CKS | _0000_TAU_16BITS_MODE |
		_0000_TAU_TRIGGER_SOFTWARE | _0000_TAU_MODE_INTERVAL_TIMER | _0000_TAU_START_INT_UNUSED;
	TO0 &= ~_0004_TAU_CH2_OUTPUT_VALUE_1;
	TOE0 &= ~_0004_TAU_CH2_OUTPUT_ENABLE;

	TPS0 |= (USHORT)(2U << 8);

}

void init_tau0_channel3 (void)
{
	TMPR103 = 1U;
	TMPR003 = 1U;
	// Channel 3 used as interval timer
	TMR03 = _C000_TAU_CLOCK_SELECT_CKM3 | _0000_TAU_CLOCK_MODE_CKS | _0000_TAU_16BITS_MODE |
	        _0000_TAU_TRIGGER_SOFTWARE | _0000_TAU_MODE_INTERVAL_TIMER | _0000_TAU_START_INT_UNUSED;
	TO0 &= ~_0008_TAU_CH3_OUTPUT_VALUE_1;
	TOE0 &= ~_0008_TAU_CH3_OUTPUT_ENABLE;

	TPS0 |= (USHORT)(1U << 12U);
}

void init_tm_12bit(void)
{
	/*Set 12-bit timer clock*/
	WUTMMCK0 = 1U;
}

void tm_12bit_start_gtimer (USHORT usPeriod, ULONG address)
{
	IF1H_bit.no2 = 0U;
	ITMC = 0x0000U;
	MK1H_bit.no2 = 0U;
	pdc_set_int_routine(intID_INTIT, address);
	
	ITMC = 0x8000U | (((usPeriod*15U)-1U) & 0x0FFFU);
}

void tm_12tm_stop_gtimer (void)
{
	MK1H_bit.no2 = 1U;
	pdc_set_int_routine(intID_INTIT, 0U);
	IF1H_bit.no2 = 0U;
	ITMC = 0x0000U;
}

void tm_12bit_intr_hdlr (void)
{
	// Watchdog Timer Refresh
	WDTE = 0xACU;
}

void tm1_start_gtimer (USHORT usPeriod, ULONG address)
{
	pdc_set_int_routine(intID_INTTM01, address);
	TDR01 = tm_calc_counter(usPeriod);
	
	TMIF01 = 0U;    /* clear INTTM01 interrupt flag */
	TMMK01 = 0U;    /* enable INTTM01 interrupt */
	TS0 |= _0002_TAU_CH1_START_TRG_ON;
}

void tm2_start_gtimer (USHORT usPeriod, ULONG address)
{
	pdc_set_int_routine(intID_INTTM02, address);
	TPS0 &= ~0x00F0;
	if (usPeriod > 2000) {
		TPS0 |= (0xFU << 4);
	} else if (usPeriod > 20) {
		TPS0 |= (0xAU << 4);
	} else {
		TPS0 |= (0x4U << 4);
	}
	TDR02 = tm_calc_counter(usPeriod);
	TMIF02 = 0U;    /* clear INTTM02 interrupt flag */
	TMMK02 = 0U;    /* enable INTTM02 interrupt */
	TS0 |= _0004_TAU_CH2_START_TRG_ON;
}

UCHAR tm1_is_start_gtimer (void)
{
	if ((TE0 & _0002_TAU_CH1_START_TRG_ON) != 0U) {
		return 1U;
	}
	return 0U;
}

void tm3_start_gtimer (USHORT usPeriod, ULONG address)
{
	pdc_set_int_routine(intID_INTTM03, address);
	TDR03 = tm_calc_counter(usPeriod);
	
	TMIF03 = 0U;    /* clear INTTM03 interrupt flag */
	TMMK03 = 0U;    /* enable INTTM03 interrupt */
	TS0 |= _0008_TAU_CH3_START_TRG_ON;}

void tm1_stop_gtimer (void)
{
	TT0 |= _0002_TAU_CH1_STOP_TRG_ON;
	TMIF01 = 0U;
	TMMK01 = 1U;
}

void tm2_stop_gtimer (void)
{
	TT0 |= _0004_TAU_CH2_STOP_TRG_ON;
	TMIF02 = 0U;
	TMMK02 = 1U;
}

void tm3_stop_gtimer (void)
{
	TT0 |= _0008_TAU_CH3_STOP_TRG_ON;
	TMIF03 = 0U;
	TMMK03 = 1U;
}

USHORT tm_calc_counter(USHORT usPeriod)
{
	ULONG ulCount = 0;
	if (usPeriod > 2000) {
		// 732 Hz
		ulCount = 732UL * usPeriod / 1000UL - 1UL;
	} else if (usPeriod > 20) {
		//23.4 kHz
		ulCount = 234UL * usPeriod / 10UL - 1UL;
	} else {
		//1.5 MHz
		ulCount = 1500UL * usPeriod - 1UL;
	}
	return ulCount;
}
