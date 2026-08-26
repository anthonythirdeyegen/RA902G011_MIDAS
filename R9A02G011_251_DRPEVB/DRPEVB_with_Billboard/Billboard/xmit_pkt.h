#ifndef ___XMIT_PKT_H
#define ___XMIT_PKT_H

extern void swusb_xmit_handshake_pkt(UCHAR pid);
extern void swusb_xmit_data_pkt(const UCHAR *buf, UCHAR len);

#endif // ___XMIT_PKT_H
