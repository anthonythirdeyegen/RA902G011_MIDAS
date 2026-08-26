#ifndef ___SW_CTRL_H
#define ___SW_CTRL_H

#include "typedefs.h"


#define SW_STATE_IDLE	0
#define SW_STATE_S1	1
#define SW_STATE_S2	2
#define SW_STATE_S3	3
#define SW_STATE_S4	4

typedef struct {
	UCHAR status;
	UCHAR ucPress;
}SW_INFO;

extern SW_INFO gSW;

void sw_init(void);
void sw_ctrl(void);
UCHAR sw_chk_active(void);
#endif // ___SW_CTRL_H
