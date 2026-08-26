#ifndef ___USER_MAIN_AUTH_H
#define ___USER_MAIN_AUTH_H

#include "typedefs.h"

#define AUTH_SNK_INITIATOR_DIS						(0)
#define AUTH_SNK_INITIATOR_FARSRC					(1)
#define AUTH_SNK_INITIATOR_CP						(2)
#define AUTH_SNK_INITIATOR_CP_FARSRC				(3)
#define AUTH_TYP	AUTH_SNK_INITIATOR_DIS

UCHAR user_func_auth(void);

#endif // ___USER_MAIN_AUTH_H