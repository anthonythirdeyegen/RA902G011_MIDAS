#ifndef ___INTERRUPT_H
#define ___INTERRUPT_H

#include "typedefs.h"

/******************************************************************************
 Interrupt Vector setting
******************************************************************************/

// ID of the interrupt routine table
#define intID_INTP0            ((UCHAR)0x01)
#define intID_INTP1            ((UCHAR)0x02)
#define intID_INTP2            ((UCHAR)0x03)
#define intID_INTP3            ((UCHAR)0x04)
#define intID_INTP4            ((UCHAR)0x05)
#define intID_INTP5            ((UCHAR)0x06)
#define intID_INTP6            ((UCHAR)0x07)
#define intID_INTTM00          ((UCHAR)0x08)
#define intID_INTTM01          ((UCHAR)0x0B)
#define intID_INTTM02          ((UCHAR)0x0C)
#define intID_INTTM03          ((UCHAR)0x0D)
#define intID_INTAD            ((UCHAR)0x0E)
#define intID_INTPDCTRL        ((UCHAR)0x0F)
#define intID_INTSMBMST        ((UCHAR)0x10)
#define intID_INTSMBSLV        ((UCHAR)0x11)
#define intID_INTTCSCNT        ((UCHAR)0x12)
#define intID_INTP7            ((UCHAR)0x13)
#define intID_INTIICA0         ((UCHAR)0x14)
#define intID_INTIT            ((UCHAR)0x15)

void pdc_set_int_routine(UCHAR ID, ULONG address);

#endif // ___INTERRUPT_H
