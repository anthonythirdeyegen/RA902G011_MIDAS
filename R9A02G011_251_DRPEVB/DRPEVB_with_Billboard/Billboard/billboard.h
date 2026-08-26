#ifndef __BILLBOARD
#define __BILLBOARD

#include "iodefine.h"

/// Function prototypes to provide links from main() to the key Billboard functions

void bbc_main (void);  // Billboard initialization from main()
void swusb_proc (void);  // Billboard polling from main()

// For possible debug use, but executing this function interferes with led.c.
void led (UCHAR n) {
	P8_bit.no2 = n; // P82 LED ON (0) or OFF (1)
}
/* By default, the Blue LED (controlled by the P82 GPIO on the PDC) indicates "Connected as 
   PD Source" (LED on steadily), or "Connected as PD Sink" (LED blinking, 0.5 sec on/off time).
*/

#endif

