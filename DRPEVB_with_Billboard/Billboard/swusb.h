#ifndef ___SWUSB_H
#define ___SWUSB_H

#include "typedefs.h"

//
// Billboard Specification Version
//
//#define SWUSB_BBC_BCD_VERSION				0x0110		// Revision 1.1
#define SWUSB_BBC_BCD_VERSION				0x0121		// Revision 1.21


void swusb_init(void);
void swusb_proc(void);
BOOL swusb_is_transferring(void);
void swusb_measure_rate(void);

void swusb_enable(void);
void swusb_disable(void);

void swusb_set_power_supply(UCHAR self_powered);
void swusb_bb_configured(UCHAR mode, UCHAR value);
void swusb_bb_set_additional_failure_info(UCHAR value);

#endif // ___SWUSB_H
