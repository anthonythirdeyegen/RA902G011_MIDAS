#ifndef ___RECV_PKT_H
#define ___RECV_PKT_H

// swusb_recv_pkt()
#define RECV_STS_PKT(sts)			(!((sts) & 0x80))	
#define RECV_STS_PKT_LEN(sts)		((sts) & 0x0f)		
#define RECV_STS_PKT_CRC16_OK(sts)	((sts) & 0x10)		
#define RECV_STS_RESET				0xFF				
#define RECV_STS_RESUME				0xFE				
#define RECV_STS_ERR_SYNC			0x80				
#define RECV_STS_ERR_SYNC2			0x81			
#define RECV_STS_ERR_OVERRUN		0x82				
#define RECV_STS_ERR_STUFF			0x83				

extern UCHAR swusb_recv_pkt(UCHAR recv_buf[11]);

#define RECV_RATE_OFFSET_NEUTRAL	128					
extern UCHAR g_swusb_rate_offset;		

#endif // ___RECV_PKT_H
