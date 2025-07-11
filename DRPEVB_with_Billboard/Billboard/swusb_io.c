#include "swusb_io.h"
#include "iodefine.h"
#include "swusb_pin_config.h"

#define INT_PRIORITY	0		// D- pin interrupt priority (0:highest - 3:lowest)

void swusb_io_init(void)
{
	// PUE : OUT, Low
	PUE_PORT_REG &= ~(1 << BITPOS_PUE);
	PUE_PM_REG &= ~(1 << BITPOS_PUE);

	// D+ : IN
	USB_PM_REG |= (1 << BITPOS_DPLUS);

	// D- : IN
	USB_PM_REG |= (1 << BITPOS_DMINUS);

	// D- pin interrupt
	PPR1_DMINUS = (INT_PRIORITY >> 1) & 1;	
	PPR0_DMINUS = (INT_PRIORITY >> 0) & 1;	
	EGP_DMINUS = 0;		
	EGN_DMINUS = 1;		
}

BOOL swusb_io_is_enabled(void)
{
	return (PUE_PORT_REG & (1 << BITPOS_PUE)) != 0;
}

void swusb_io_enable(void)
{
	// D-
	PMK_DMINUS = 0;

	// Pull-up enable
	PUE_PORT_REG |= (1 << BITPOS_PUE);
}

void swusb_io_disable(void)
{
	// D-
	PMK_DMINUS = 0;

	// Pull-up disable
	PUE_PORT_REG &= ~(1 << BITPOS_PUE);
}

void swusb_io_clear_irq(void)
{
	PIF_DMINUS = 0;
}
