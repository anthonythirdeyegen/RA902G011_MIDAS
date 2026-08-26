#ifndef ___SWUSB_IO_H
#define ___SWUSB_IO_H

#include "typedefs.h"

void swusb_io_init(void);
BOOL swusb_io_is_enabled(void);
void swusb_io_enable(void);
void swusb_io_disable(void);
void swusb_io_clear_irq(void);

#endif // ___SWUSB_IO_H
