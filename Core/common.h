#ifndef ___COMMON_H
#define ___COMMON_H

#include "typedefs.h"

#define MAGIC_CODE1                            (*((UVFSHORT*)(0x2008)))

#define FW_VER                                 (*((UVFSHORT*)(0x200A)))
#define FW_TYPE                                (*((UVFSHORT*)(0x200C)))
#define BOOT_VER                               (*((UVFSHORT*)(0x00FA)))

#endif // ___COMMON_H