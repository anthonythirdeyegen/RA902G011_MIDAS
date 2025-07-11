#ifndef ___USER_MAIN_H
#define ___USER_MAIN_H

#include "typedefs.h"

#define DSLEEP_IDLE                  (0U)
#define DSLEEP_ST_DIS_TYPEC          (1U)
#define DSLEEP_ST_WAI_DIS_TYPEC      (2U)
#define DSLEEP_ST_ENTER_DEEP         (3U)
#define DSLEEP_ST_EN_TYPEC           (4U)
#define DSLEEP_ST_EXIT_DEEP          (5U)


void  user_func_event(void);
UCHAR user_func_chk_device(void);
UCHAR user_func_snd_mess  (void);
void  user_init(void);

#endif // ___USER_MAIN_H