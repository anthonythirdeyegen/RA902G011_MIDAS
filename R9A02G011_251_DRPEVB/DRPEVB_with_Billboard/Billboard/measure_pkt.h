#ifndef ___MEASURE_PKT_H
#define ___MEASURE_PKT_H

// swusb_measure_pkt()
#define MEASURE_STS_OK				0
#define MEASURE_STS_RESET			0xFF
#define MEASURE_STS_RESUME			0xFE
#define MEASURE_STS_ERR_SYNC		0x80
#define MEASURE_STS_ERR_BIT_SUTFF	0x81

extern UCHAR swusb_measure_pkt(UCHAR *bit_count, USHORT *clk_count);

#endif // ___MEASURE_PKT_H
