/***********************************************************************/
/*                                                                     */
/*  FILE        :Main.c                                                */
/*  DATE        :                                                      */
/*  DESCRIPTION :Main Program                                          */
/*  CPU TYPE    :                                                      */
/*                                                                     */
/*  NOTE:THIS IS A TYPICAL EXAMPLE.                                    */
/*                                                                     */
/***********************************************************************/
#include "swusb.h"
#include "interrupt.h"
#include "iodefine.h"

///volatile ULONG gulIntRoutine[MAX_INTROUTINE];

/* Note:  The Billboard class was originally developed as a standalone CS+ project, not merged
   with any other SDK.  Various different top-level main_loop functions were created for 
   standalone operation.  When merged with another SDK, however, none of these main_loop
   functions are needed.  They are all unused in this version of the Billboard project.
   Likewise, the gulIntRoutine [] variable (above) is not used in the SDK environment, either.
*/

// Main loop, minimal ordinary case (not used in SDK)
void main_loop_normal(void)
{
	swusb_enable();
	while(1) {
		swusb_proc();
	}
}

// Main loop: Repeat USB connection and disconnection at regular intervals (not used in SDK)
void main_loop_toggle(void)
{
	const ULONG count = 580ul * 2000;   // Actual measurement:  about 2 seconds
	ULONG i;

	while(1) {
		swusb_enable();
		for (i = 0; i < count; i ++) {
			swusb_proc();
		}

		swusb_disable();
		for (i = 0; i < count; i ++) {
			swusb_proc();
		}
	}
}

// Main loop:  request bit rate measurement (not used in SDK)
void main_loop_measure(void)
{
	swusb_enable();
	while(1) {
		swusb_proc();

		// Request bit rate measurement at maximum frequency
		swusb_measure_rate();
	}
}

// Main loop:  HALT CPU (not used in SDK)
void main_loop_halt(void)
{
	swusb_enable();
	while(1) {
		swusb_proc();

		#if 0
		// To avoid HALT during a transfer
		if (!swusb_is_transferring()) {
			__halt();		// Halt CPU
		}
		#else
		__halt();		// Halt CPU
		#endif
	}
}

// Main loop: When each pass of the main loop performs a heavy workload (not used in SDK)
void main_loop_heavy(void)
{
	const ULONG count = 10000;		// Actual measurement: about 18 ms
	ULONG i;

	swusb_enable();
	while(1) {
		swusb_proc();
		for (i = 0; i < count; i ++);
	}
}

void bbc_main(void)
{
	// Initialize USB module
	swusb_init();

	// Enable interrupt
	__EI();

	// Power status setting
	swusb_set_power_supply(1);		// 0=Bus-Powered, 1=Self-Powered

	// Billboard Capability Descriptor, set error information
	swusb_bb_configured(0, 0);
	swusb_bb_configured(1, 0);
	swusb_bb_configured(2, 0);
	swusb_bb_configured(3, 0);
	swusb_bb_set_additional_failure_info(0x01);

	/* For standalone applications, there are various main loops for testing.  Choose
	   whichever version is desired.  However, none of these versions are used in the merged 
	   SDK environment.  Instead, swusb_proc() is polled periodically by main() in r_main.c.
	*/
	swusb_enable();  // enable BB operation
///	main_loop_normal();
//	main_loop_toggle();
//	main_loop_measure();
//	main_loop_halt();
//	main_loop_heavy();
}
