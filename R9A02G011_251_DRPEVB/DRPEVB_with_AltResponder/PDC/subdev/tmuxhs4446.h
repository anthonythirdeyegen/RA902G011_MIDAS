#ifndef ___TMUXHS4446_CTRL_H
#define ___TMUXHS4446_CTRL_H

#include "typedefs.h"

/* Subdev ID bit (next free bit after ISL95338_DEVICE_ID=0x01) */
#define TMUXHS4446_DEVICE_ID       ((UCHAR)0x02U)

/* TMUXHS4446 register map */
#define TMUX_REG_SLAVE_ADDR        0x00u  /* RO (optional) */
#define TMUX_REG_DEVID             0x01u  /* RO (optional) */
#define TMUX_REG_SELECT            0x02u  /* R/W: bits[2:0] = CONF */

/* CONF values (lower 3 bits) */
typedef enum {
    TMUX_CONF_OPEN_PD   = 0x00, /* open + power-down */
    TMUX_CONF_OPEN_ON   = 0x01, /* open (powered)    */
    TMUX_CONF_USB       = 0x04, /* USB SS only       */
    TMUX_CONF_USB_FLIP  = 0x05, /* USB SS flipped    */
    TMUX_CONF_DP4       = 0x02, /* 4-lane DP         */
    TMUX_CONF_DP4_FLIP  = 0x03, /* 4-lane DP flipped */
    TMUX_CONF_DP2_USB   = 0x06, /* 2-lane DP + USB   */
    TMUX_CONF_DP2_USB_F = 0x07  /* 2-lane DP + USB flipped */
} tmux_conf_t;

typedef struct {
    UCHAR ucSt;          /* driver state: IDLE/READY/ACTIVE */
    UCHAR ucAlertSt;     /* unused for this part (no SMBus ALERT) */
    UCHAR desiredConf;   /* pending conf to write (0..7) */
} TMUXHS4446_INFO;

extern TMUXHS4446_INFO gTmuxInfo;

/* subdev_ctrl hooks */
void init_tmuxhs4446(void);
void tmuxhs4446_ctrl(void);
void tmuxhs4446_alert(void); /* stub */

/* helper to request a new mode: sets desiredConf and raises the subdev flag */
void tmuxhs4446_request_mode(UCHAR conf);

#endif /* ___TMUXHS4446_CTRL_H */
