#ifndef ___USER_TIMER_H
#define ___USER_TIMER_H

#include "typedefs.h"

typedef enum {
	TIMER_ONESHOT,
	TIMER_PERIODIC,
}TIMER_MODE;
void  init_tau0_channel1(void);
void  init_tau0_channel2(void);
void  init_tau0_channel3(void);
void  init_tm_12bit(void);
void  tm1_start_gtimer (USHORT usPeriod, ULONG address);
void  tm2_start_gtimer (USHORT usPeriod, ULONG address);
void  tm3_start_gtimer (USHORT usPeriod, ULONG address);
UCHAR tm1_is_start_gtimer (void);
void  tm1_stop_gtimer (void);
void  tm2_stop_gtimer (void);
void  tm3_stop_gtimer (void);
void  tm_12bit_start_gtimer(USHORT usPeriod, ULONG address);
void  tm_12tm_stop_gtimer  (void);
void  tm_12bit_intr_hdlr(void);

#endif // ___USER_TIMER_H
