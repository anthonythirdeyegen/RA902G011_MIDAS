#include "tmuxhs4446.h"
#include "subdev_ctrl.h"
#include "smbm_ctrl.h"
#ifndef __IAR_C99__
#include "iodefine.h"
#else
#include "ior9a02g011.h"
#include "ior9a02g011_ext.h"
#include "intrinsics.h"
#endif

/* Match your ISL driver style: 400 kHz and 8-bit shifted address. */
#define VAL_I2C_CLK         (SMBM_CLOCK_400K)                 /* like ISL95338 */   /* :contentReference[oaicite:4]{index=4} */
#define VAL_I2C_SLAVEADDR   ((UCHAR)0x48u<<1) /* A1=A0=0 -> 0x48 -> shift */        /* :contentReference[oaicite:5]{index=5} */

/* One global info block, same pattern as ISL95338 */
TMUXHS4446_INFO gTmuxInfo;

/* Forward decls (mirror ISL flow) */
static void tmux_cmd_handler(void);
static void tmux_end_processing(void);
static void tmux_cmd(void);

void init_tmuxhs4446(void)
{
    gTmuxInfo.ucSt      = SUBDEV_DRV_STATE_IDLE;
    gTmuxInfo.ucAlertSt = SUBDEV_DRV_STATE_IDLE;
    gTmuxInfo.desiredConf = TMUX_CONF_OPEN_ON; /* safe default at boot */
    return;
}

/* Same state machine shape as isl95338_ctrl() */
void tmuxhs4446_ctrl(void)
{
    switch (gTmuxInfo.ucSt) {
    case SUBDEV_DRV_STATE_IDLE:
    case SUBDEV_DRV_STATE_READY:
        tmux_cmd_handler();                                                     /* :contentReference[oaicite:6]{index=6} */
        break;

    case SUBDEV_DRV_STATE_ACTIVE:
        if (   (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_STRETCH)
            || (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_COMPLETE)
            || (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR) ) {
            tmux_end_processing();                                              /* :contentReference[oaicite:7]{index=7} */
        }
        break;

    default:
        break;
    }
    return;
}

static void tmux_cmd_handler(void)
{
    /* Follow the “only start when SMBus is idle” rule from ISL driver */
    if (gSmbmInfo.ucSmbmStatus != SMBM_CTRL_STATE_IDLE) {                       /* :contentReference[oaicite:8]{index=8} */
        gTmuxInfo.ucSt = SUBDEV_DRV_STATE_READY;
        return;
    } else {
        /* Clear last error, clear this subdev from error bitmap (same pattern) */
        gSmbmInfo.ucSmbmError = 0x00;
        gSubDevErr.ucSubdev &= ~TMUXHS4446_DEVICE_ID;                           /* :contentReference[oaicite:9]{index=9} */

        /* Select bus/target then enqueue the SMBus transaction */
        smbm_set_subdev(VAL_I2C_CLK, VAL_I2C_SLAVEADDR);                        /* :contentReference[oaicite:10]{index=10} */
        tmux_cmd();
        gTmuxInfo.ucSt = SUBDEV_DRV_STATE_ACTIVE;
    }
    return;
}

static void tmux_cmd(void)
{
    /* For TMUX, write 1 byte to register 0x02 with lower 3 bits = desiredConf */
    UCHAR ucCmd  = TMUX_REG_SELECT;
    UCHAR ucData = (UCHAR)(gTmuxInfo.desiredConf & 0x07u);

    /* Use BYTE write (data length = 1), same API shape as ISL (cmd, proto, PEC, opt, *buf, len, to) */
    smbm_set_protocol(
        ucCmd,                  /* CMD (register)                   */
        SMBM_BYTE_WRITE,        /* Protocol: byte data write        */
        0,                      /* PEC disabled                     */
        SMBM_SMB_START,         /* Option                           */
        &ucData,                /* Data pointer                     */
        1,                      /* len = 1 byte                     */
        1                       /* TimeOut                          */
    );                                                                          /* :contentReference[oaicite:11]{index=11} */
    return;
}

static void tmux_end_processing(void)
{
    /* Mirror ISL: on error, set bitmap + copy error code, then clear SMBM status and our flag */
    if (gSmbmInfo.ucSmbmStatus == SMBM_CTRL_STATE_ERROR) {
        gSubDevErr.ucSubdev |= TMUXHS4446_DEVICE_ID;
        gSubDevErr.ucError   = gSmbmInfo.ucSmbmError;
    }
    smbm_clr_status();                                                          /* :contentReference[oaicite:12]{index=12} */

    gTmuxInfo.ucSt = SUBDEV_DRV_STATE_IDLE;
    gSubdevInfo.ucSubdevFlag &= ~TMUXHS4446_DEVICE_ID;                          /* :contentReference[oaicite:13]{index=13} */
    return;
}

/* No SMBus ALERT for this part; keep stub to satisfy table signature. */
void tmuxhs4446_alert(void)
{
    (void)0;
}

/* Public helper: request a new mode and raise the subdev flag so subdev_ctrl() runs us */
void tmuxhs4446_request_mode(UCHAR conf)
{
    gTmuxInfo.desiredConf = (UCHAR)(conf & 0x07u);
    gSubdevInfo.ucSubdevFlag |= TMUXHS4446_DEVICE_ID; /* let subdev_ctrl dispatch us next tick */
}
