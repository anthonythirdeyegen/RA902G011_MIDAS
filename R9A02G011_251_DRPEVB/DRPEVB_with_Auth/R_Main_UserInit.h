#ifndef __R_MAIN_USERINIT_H
#define __R_MAIN_USERINIT_H

#include "R9A02G011PDC.h"
#include "user_main.h"
#include "r_cg_macrodriver.h"

extern USHORT gusRcvMess[];
extern USHORT gusSndMess[];

void R_MAIN_UserInit(void);

#endif // __R_MAIN_USERINIT_H