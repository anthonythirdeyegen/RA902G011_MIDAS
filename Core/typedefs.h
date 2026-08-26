#ifndef ___TYPEDEFS_H
#define ___TYPEDEFS_H

#define BOOL  unsigned char
#define TRUE  ((BOOL)1)
#define FALSE ((BOOL)0)
#define NULL  (0)

typedef unsigned long    ULONG;
typedef unsigned short   USHORT;
typedef unsigned int     UINT;
typedef unsigned char    UCHAR;

typedef signed long    LONG;
typedef signed short   SHORT;
typedef signed int     INT;
typedef signed char    CHAR;

typedef volatile __near unsigned long           UVNLONG;
typedef volatile __near unsigned short          UVNSHORT;
typedef volatile __near unsigned int            UVNINT;
typedef volatile __near unsigned char           UVNCHAR;

typedef volatile __far unsigned long           UVFLONG;
typedef volatile __far unsigned short          UVFSHORT;
typedef volatile __far unsigned int            UVFINT;
typedef volatile __far unsigned char           UVFCHAR;



#endif //___TYPEDEFS_H

