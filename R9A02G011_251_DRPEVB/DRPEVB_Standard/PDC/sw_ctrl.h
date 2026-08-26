#ifndef ___SW_CTRL_H
#define ___SW_CTRL_H

#include "typedefs.h"


#define SW_STATE_PULL	(0U)
#define SW_STATE_PUSH	(1U)

typedef struct {
	UCHAR status;
	UCHAR ucPress;
}SW_INFO;

extern SW_INFO gSW;

void sw_init(void);
UCHAR sw_ctrl(void);

#endif // ___SW_CTRL_H
