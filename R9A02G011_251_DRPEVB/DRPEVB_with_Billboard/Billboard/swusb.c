#include "swusb.h"
#include "swusb_io.h"
#include "interrupt.h"
#include "recv_pkt.h"
#include "xmit_pkt.h"
#include "measure_pkt.h"
#include "crc16.h"
#include "pd_paramdef.h"
#include "swusb_pin_config.h"
#include <string.h>
#include "R9A02G011PDC.h"
#include "trace_buffer219.h"

#define LOBYTE(w)	((UCHAR)((w) & 0xFF))
#define HIBYTE(w)	((UCHAR)((w) >> 8))

#define USB_PID_OUT		0xE1
#define USB_PID_IN		0x69
#define USB_PID_SETUP	0x2D
#define USB_PID_DATA0	0xC3
#define USB_PID_DATA1	0x4B
#define USB_PID_ACK		0xD2
#define USB_PID_NAK		0x5A
#define USB_PID_STALL	0x1E
#define USB_PID_IS_TOKEN(pid)		(((pid) & 0x33) == 0x21)
#define USB_PID_IS_DATA(pid)		(((pid) & 0x33) == 0x03)
#define USB_PID_IS_HANDSHAKE(pid)	(((pid) & 0x33) == 0x12)

//Inversion of the bit order of generator polynomial 00101B
#define CRC5_POLY 0x14

//
// Chapter 9 USB Device Framework
//

//
// USB 1.1: 9.3 USB Device Requests, Table 9-2. Format of Setup Data
// USB 2.1: 9.3 USB Device Requests, Table 9-2. Format of Setup Data
// USB 3.0: 9.3 USB Device Requests, Table 9-2. Format of Setup Data
//
typedef struct {
    UCHAR bmRequestType;
    UCHAR bRequest;
    UCHAR wValue_loByte;
    UCHAR wValue_hiByte;
    UCHAR wIndex_loByte;
    UCHAR wIndex_hiByte;
    UCHAR wLength_loByte;
    UCHAR wLength_hiByte;
} USB_SETUP_PACKET;

//
// bmRequestType.Dir
//
#define BMREQUEST_HOST_TO_DEVICE        (0<<7)
#define BMREQUEST_DEVICE_TO_HOST        (1<<7)

//
// bmRequestType.Type
#define BMREQUEST_STANDARD              (0<<5)
#define BMREQUEST_CLASS                 (1<<5)
#define BMREQUEST_VENDOR                (2<<5)

//
// bmRequestType.Recipient
//
#define BMREQUEST_TO_DEVICE             (0<<0)
#define BMREQUEST_TO_INTERFACE          (1<<0)
#define BMREQUEST_TO_ENDPOINT           (2<<0)
#define BMREQUEST_TO_OTHER              (3<<0)

//
// USB 1.1: 9.4 Standard Device Requests, Table 9-4. Standard Request Codes
// USB 2.0: 9.4 Standard Device Requests, Table 9-4. Standard Request Codes
//
#define USB_REQUEST_GET_STATUS          0x00
#define USB_REQUEST_CLEAR_FEATURE       0x01
#define USB_REQUEST_SET_FEATURE         0x03
#define USB_REQUEST_SET_ADDRESS         0x05
#define USB_REQUEST_GET_DESCRIPTOR      0x06
#define USB_REQUEST_SET_DESCRIPTOR      0x07
#define USB_REQUEST_GET_CONFIGURATION   0x08
#define USB_REQUEST_SET_CONFIGURATION   0x09
#define USB_REQUEST_GET_INTERFACE       0x0A
#define USB_REQUEST_SET_INTERFACE       0x0B
#define USB_REQUEST_SYNC_FRAME          0x0C

//
// USB 1.1: 9.4 Standard Device Requests, Table 9-5. Descriptor Types
//
#define USB_DEVICE_DESCRIPTOR_TYPE                          0x01
#define USB_CONFIGURATION_DESCRIPTOR_TYPE                   0x02
#define USB_STRING_DESCRIPTOR_TYPE                          0x03
#define USB_INTERFACE_DESCRIPTOR_TYPE                       0x04
#define USB_ENDPOINT_DESCRIPTOR_TYPE                        0x05
#define USB_BOS_DESCRIPTOR_TYPE                             0x0F
#define USB_DEVICE_CAPABILITY_DESCRIPTOR_TYPE				0x10

// Device Capability Type Codes
#define USB_CONTAINER_ID_DEVICE_CAPABILITY_TYPE             0x04
#define USB_BILLBOARD_DEVICE_CAPABILITY_TYPE                0x0D
#if SWUSB_BBC_BCD_VERSION >= 0x0121
 #define USB_BILLBOARD_ALTERNATE_MODE_DEVICE_CAPABILITY_TYPE 0x0F
#endif

//
// Configuration Descriptor bmAttributes bit definitions
//
#define USB_CONFIG_SELF_POWERED                   0x40


#define USB_DEVICE_DESCRIPTOR_LENGTH				18
#define USB_CONFIGURATION_DESCRIPTOR_LENGTH			9
#define USB_INTERFACE_DESCRIPTOR_LENGTH				9
#define USB_CONFIGURATION_DESCRIPTOR_TOTAL_LENGTH	(USB_CONFIGURATION_DESCRIPTOR_LENGTH + USB_INTERFACE_DESCRIPTOR_LENGTH)
#define USB_BOS_DESCRIPTOR_LENGTH					5
#define USB_CONTAINER_ID_DESCRIPTOR_LENGTH			20
#define USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode)	(44 + (num_alt_mode) * 4)
#if SWUSB_BBC_BCD_VERSION >= 0x0121
 #define USB_BILLBOARD_ALTERNATE_MODE_CAPABILITY_DESCRIPTOR_LENGTH	8
 #define USB_BOS_DESCRIPTOR_TOTAL_LENGTH(num_alt_mode) ( \
 													USB_BOS_DESCRIPTOR_LENGTH + \
 													USB_CONTAINER_ID_DESCRIPTOR_LENGTH + \
 													USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode) + \
 													USB_BILLBOARD_ALTERNATE_MODE_CAPABILITY_DESCRIPTOR_LENGTH * (num_alt_mode) \
 													)
 #define USB_BOS_DESCRIPTOR_NUM_DEVICE_CAPS(num_alt_mode)	(2 + (num_alt_mode))
#else
 #define USB_BOS_DESCRIPTOR_TOTAL_LENGTH(num_alt_mode) ( \
 													USB_BOS_DESCRIPTOR_LENGTH + \
 													USB_CONTAINER_ID_DESCRIPTOR_LENGTH + \
 													USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode) \
 													)
 #define USB_BOS_DESCRIPTOR_NUM_DEVICE_CAPS(num_alt_mode)	2
#endif

#define USB_BCD_USB						0x0201
#define USB_DEVICE_BILLBOARD_CLASS		0x11
#define USB_DEVICE_BILLBOARD_SUBCLASS	0x00
#define USB_DEVICE_BILLBOARD_PROTOCOL	0x00
#define USB_LANGID_ENGLISH_US			0x0409
#define USB_CONFIGURATION_VALUE			1
#define USB_INTERFACE_NUMBER			0

// BBC_OPTION, meaning of key bits
#define BBC_OPTION_BIT_SELF_POWERED						0x01	// b0 : 0=Bus-powered, 1=Self-powered
#define BBC_OPTION_BIT_RATE_CALIBRATION_AFTER_RECV_ERR	0x40	//b6: Rate correction trigger. 0 = After Bus Reset, 1 = After packet reception failure (*)
#define BBC_OPTION_BIT_RATE_CALIBRATION_DISABLE			0x80	// b7: Rate correction enabled / disabled.  0 = enabled, 1 = invalid
	// (*) The packet reception failure in this case is subject to the following error:
	//       In the Dev_wait_Odata state, when packet reception processing becomes "EOP detection failure", "CRC16 mismatch" or "bit stuff error".
	//     In addition, the following conditions are not considered errors.
	//       When the packet reception processing becomes "SYNC synchronization failure".
	//          * Keep-alive signal and errors occurring for reasons other than rate deviation when the interrupt was not made in time.
	//       Packet reception error in No_packet state
	//          It is a failure to receive the token packet, but it can happen if the interrupt does not make it in time.
	//            If this happens with an IN token, it will not be good if you enter the rate measurement mode; it will respond three consecutive IN tokens.

enum {
	VALID_BIT_POS_I_MANUFACTURER,
	VALID_BIT_POS_I_PRODUCT,
	VALID_BIT_POS_I_SERIAL_NUMBER,
	VALID_BIT_POS_I_CONFIGURATION,
	VALID_BIT_POS_I_INTERFACE,
	VALID_BIT_POS_I_ADDITIONAL_INFO_URL,
	VALID_BIT_POS_I_ALTERNATE_MODE_STRING_0,
};

// Transaction state (spec 8.5 Transaction Packet Sequences)
enum xact_state {
	E_XACT_STATE_NO_PACKET,					// No_packet state
	E_XACT_STATE_DEV_WAIT_ODATA_SETUP,		// Dev_wait_Odata(SETUP) state
	E_XACT_STATE_DEV_WAIT_ODATA_OUT,		// Dev_wait_Odata(OUT) state
	E_XACT_STATE_DEV_RESP,					// Dev_resp state
};

static enum xact_state g_xact_state;
static			UCHAR g_expected_token[2];	//Expected value of 16 bits (ADDR, ENDP, CRC 5) of token packet
static struct {
    UCHAR bmRequestType;
    UCHAR bRequest;
    UCHAR wValue_loByte;
    UCHAR wValue_hiByte;
    UCHAR wIndex_loByte;
    //UCHAR wIndex_hiByte;		// no need
    UCHAR wLength;				// Reduced to UCHAR at retirement
} g_setup_data;
static volatile	UCHAR g_in_data_pkt_len;		// Number of bytes of DATAx packet in IN transaction (packet is invalid when 0)
static			UCHAR g_in_data_pkt[11];		// DATAx packet of IN transaction
				UCHAR g_swusb_rate_offset;		// Rate correction value

// [API setting value]
static			UCHAR g_bbc_configured;		// Billboard Capability Descriptor.bmConfigured[0]
static			UCHAR g_bbc_additional_failure_info;	// Billboard Capability Descriptor.bAdditonalFailureInfo

static union {
	struct {
		BOOL	measure_req				: 1;	// Bit rate measurement request
		BOOL	measure_disabled		: 1;	// Bit rate measurement prohibited period
		UCHAR	data_toggle				: 1;	//Toggle bit
		BOOL	in_stall				: 1;	// Flag that returns STALL for IN transaction
		BOOL	setup_data_avail		: 1;	//SETUP data avail flag of Transaction control
		BOOL	set_address_requested	: 1;	// Set Address command executing flag
		BOOL	device_configured		: 1;	// Configured state flag
		UCHAR	self_powered			: 1;	// [API setting value] GetStatus(Device).D0: 0=Bus-powered, 1=Self-powered
	} s;
	UCHAR byte;
} g_field;

enum transfer_state {
	E_TSTATE_IDLE,

	E_TSTATE_SET_ADDRESS,
	E_TSTATE_SET_CONFIGURATION,

	E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_0,
	E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_1,
	E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_2,

	E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_0,
	E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_1,
	E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_2,

	E_TSTATE_GET_BOS_DESCRIPTOR_DATA,

	E_TSTATE_GET_STRING_DESCRIPTOR_0_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_1_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_2_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_3_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_4_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_5_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_6_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_7_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_8_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_9_DATA,
	E_TSTATE_GET_STRING_DESCRIPTOR_10_DATA,

	E_TSTATE_GET_CONFIGURATION_DATA,

	E_TSTATE_GET_STATUS_DEVICE_DATA,

	E_TSTATE_GET_STATUS_INTERFACE_DATA,

	E_TSTATE_GET_STATUS_ENDPOINT_DATA,
};
#define E_TSTATE_GET_STRING_DESCRIPTOR_DATA(index)	((enum transfer_state)((UCHAR)E_TSTATE_GET_STRING_DESCRIPTOR_0_DATA + (index)))
#define STRING_INDEX(transfer_state)				((UCHAR)(transfer_state) - (UCHAR)E_TSTATE_GET_STRING_DESCRIPTOR_0_DATA)

static enum transfer_state g_transfer_state;
static UCHAR g_transferred_packet_num;

#define SETUP_DATA	g_setup_data
#define IN_DATA		(g_in_data_pkt + 1)

#define DEVICE_ADDRESS					(g_expected_token[0] & 0x7f)
#define IS_DEVICE_STATE_DEFAULT()		(DEVICE_ADDRESS == 0)
#define IS_DEVICE_STATE_CONFIGURED()	(g_field.s.device_configured)
#define IS_DEVICE_STATE_ADDRESS()		(!IS_DEVICE_STATE_DEFAULT() && !IS_DEVICE_STATE_CONFIGURED())

// Calculate CRC5 for 11 bit data (ADDR, ENDP)
static UCHAR crc5_calc(USHORT data11)
{
	UCHAR crc = 0x1f;	// lower 5 bits are all 1
	UCHAR bits = 11;

	while (bits --) {
		if (((UCHAR)data11 ^ crc) & 1)
			crc ^= (CRC5_POLY << 1);	// Use right shifted pattern as it is before right shift
		crc >>= 1;
		data11 >>= 1;
	}
    return crc ^ 0x1f;
}

// Optionally requests rate measurement if specified to measure rate after Bus Reset.
static void request_measure_on_bus_reset(void)
{
	const UCHAR mask = (BBC_OPTION_BIT_RATE_CALIBRATION_DISABLE |
	                    BBC_OPTION_BIT_RATE_CALIBRATION_AFTER_RECV_ERR);

	if ((BBC_OPTION & mask) == 0) {
		g_field.s.measure_req = TRUE;
	}
}

// Optionally requests rate measurement if specified to measure rate after reception error.
// Call this function when the reception error condition is satisfied.
// Since it is called from within an interrupt, specify inline for speeding up.
static void __inline request_measure_on_recv_err(void)
{
	const UCHAR mask = (BBC_OPTION_BIT_RATE_CALIBRATION_DISABLE |
	                    BBC_OPTION_BIT_RATE_CALIBRATION_AFTER_RECV_ERR);

	if ((BBC_OPTION & mask) == BBC_OPTION_BIT_RATE_CALIBRATION_AFTER_RECV_ERR) {
		g_field.s.measure_req = TRUE;
	}
}

// SET_ADDRESS processing
static void device_set_address(UCHAR addr)
{
	const UCHAR endp = 0;
	USHORT data;
	UCHAR crc5;

	//Recalculate 16-bit expected value of token packet
	data = (USHORT)endp << 7 | addr;		// [    0(5bit) | endp(4bit) | addr(7bit) ]
	crc5 = crc5_calc(data);
	data |= (USHORT)crc5 << 11;				// [ crc5(5bit) | endp(4bit) | addr(7bit) ]
	g_expected_token[0] = LOBYTE(data);
	g_expected_token[1] = HIBYTE(data);
}

// Device reset processing
static void device_reset(void)
{
	g_xact_state = E_XACT_STATE_NO_PACKET;
	device_set_address(0);
	g_in_data_pkt_len = 0;		// IN data not available
	g_field.s.in_stall = FALSE;
	g_field.s.setup_data_avail = FALSE;		// SETUP data not available
	g_field.s.set_address_requested = FALSE;
	g_field.s.device_configured = FALSE;
	g_transfer_state = E_TSTATE_IDLE;
	g_field.s.measure_req = FALSE;
	g_field.s.measure_disabled = FALSE;

	// If specified as an option, measure the bit rate in the first transaction after Bus Reset
	request_measure_on_bus_reset();
}

// Process to enter Configured state (SET_CONFIGURATION(1))
static void device_configure(void)
{
	g_field.s.device_configured = TRUE;
}

// Process to exit Configured state (SET_CONFIGURATION(0))
static void device_deconfigure(void)
{
	g_field.s.device_configured = FALSE;
}

static void calibrate_bitrate(void)
{
	UCHAR bit_count, sts;
	USHORT clk_count;

	sts = swusb_measure_pkt(&bit_count, &clk_count);
	if (sts == MEASURE_STS_OK) {
		if (88 <= bit_count && bit_count < 98) {
			/*Based on the following, we set 88 to 97 bits as a valid measurement result.
			   (1) To be the DATA 0 packet (88 bit) of the SETUP transaction as the measurement
			       target, it is set to 88 or more.
			   (2) In the situation where it cannot be synchronized with the SYNC
			       of the packet, the end of the SETUP packet is erroneously recognized
			       as SYNC (EOP is erroneously recognized as 2 bit K).
			       Sometimes it takes measurement from the end of the SETUP packet to 
			       the CRC 16 of the DATA 0 packet as the measurement target.
			       The minimum value of the number of bits measured at this time is
			       2 (minimum value of packet interval, TIPD min) + 8 (SYNC) + 88 (PID to CRC 16) = 98.
			*/
			/* And updates the rate correction value.
			   bit time error [clk / bit] = (total clk number) / (total number of bits) - 16 [clk / bit]
			   Rate correction value = bit time error [clk / bit] / (1 [clk] / 4 [bit]) * 128 + 128
			     = ((total clk number) / (total number of bits) - 16) * 4 * 128 + 128
			     = 4 * 128 * (Total clk number) / (Total number of bits) - 4 * 128 * 16 + 128
			   To round off and round it up, add 0.5 and truncate it
			     = floor (4 * 128 * (total clk number) / (total number of bits) + 0.5) - 4 * 128 * 16 + 128
			     = floor ((4 * 128 * (total clk number) + (total number of bits) / 2) / (total number of bits)) - 4 * 128 * 16 + 128
			    (= 4 * 128 * 16 - 128) // = floor ((4 * 128 * (total clk number) + (total number of bits) / 2) /
			*/
			short rate_offset = (short)((4UL * 128 * clk_count + bit_count/2) / bit_count) - (4 * 128 * 16 - 128);
			if (0 <= rate_offset && rate_offset <= 255) {
				g_swusb_rate_offset = (UCHAR)rate_offset;

				// Rate measurement complete
				g_field.s.measure_req = FALSE;
				g_field.s.measure_disabled = TRUE;
			}
		} else {
			// The measurement is invalidated from the viewpoint of measurement 
			// accuracy except for the longest packet.
		}
	} else if (sts == MEASURE_STS_RESET) {
		// Reset detection
		device_reset();
	} else if (sts == MEASURE_STS_RESUME) {
		// Resume detection
		// Do nothing
	}
}

// Falling edge interrupt of D- pin
static void int_dminus_handler(void)
{
	UCHAR recvbuf[11];
	UCHAR sts;
	
	if (g_field.s.measure_req && !g_field.s.measure_disabled) {
		calibrate_bitrate();
	} else {
		sts = swusb_recv_pkt(recvbuf);
		if (RECV_STS_PKT(sts)) {
			// Receive packet
			if (USB_PID_IS_TOKEN(recvbuf[0])) {
				// Token Packet
				if (RECV_STS_PKT_LEN(sts) == 3 && recvbuf[1] == g_expected_token[0] && recvbuf[2] == g_expected_token[1]) {
					// Correct token packet of ADDR, ENDP, CRC5
					if (recvbuf[0] == USB_PID_SETUP) {
						// SETUP token
						g_xact_state = E_XACT_STATE_DEV_WAIT_ODATA_SETUP;
					} else if (recvbuf[0] == USB_PID_OUT) {
						// OUT token
						g_xact_state = E_XACT_STATE_DEV_WAIT_ODATA_OUT;
					} else if (recvbuf[0] == USB_PID_IN) {
						// IN token 
						if (g_in_data_pkt_len) {
							// If IN data packet is prepared, return DATAx
							if (g_field.s.data_toggle)
								g_in_data_pkt[0] = USB_PID_DATA1;
							else
								g_in_data_pkt[0] = USB_PID_DATA0;
							swusb_xmit_data_pkt(g_in_data_pkt, g_in_data_pkt_len);
							g_xact_state = E_XACT_STATE_DEV_RESP;
						} else if (g_field.s.in_stall) {
							// If the STALL instruction is specified, STALL is returned
							swusb_xmit_handshake_pkt(USB_PID_STALL);
							g_xact_state = E_XACT_STATE_NO_PACKET;
						} else {
							// Otherwise return NAK
							swusb_xmit_handshake_pkt(USB_PID_NAK);
							g_xact_state = E_XACT_STATE_NO_PACKET;
						}
					} else {
						// Other token packet or illegal PID
						// No reply
						g_xact_state = E_XACT_STATE_NO_PACKET;
					}
				} else {
					// Incorrect token packet of ADDR, ENDP, CRC5
					// No reply
					g_xact_state = E_XACT_STATE_NO_PACKET;
				}
			} else if (g_xact_state == E_XACT_STATE_DEV_WAIT_ODATA_SETUP) {
				// Dev_wait_Odata(SETUP) state

				if (recvbuf[0] == USB_PID_DATA0 && RECV_STS_PKT_LEN(sts) >= 3) {
					// Receive DATA 0 after SETUP token
					if (RECV_STS_PKT_CRC16_OK(sts)) {
						USB_SETUP_PACKET *recv_setup;

						// Return ACK
						swusb_xmit_handshake_pkt(USB_PID_ACK);

						// SETUP Data evacuated
						// wIndex_hiByte: Since it is not seen in the Billboard Device, it is not evacuated
						// wLength: Since the long descriptor returns within the actual IN transfer is within 255 bytes,
						// It is enough to interpret it as 0xff even if wLength is 0x100 or more.
						// Therefore, wLength is evacuated with UCHAR.
						recv_setup = (USB_SETUP_PACKET*)&recvbuf[1];
						SETUP_DATA.bmRequestType	= recv_setup->bmRequestType;
						SETUP_DATA.bRequest			= recv_setup->bRequest;
						SETUP_DATA.wValue_loByte	= recv_setup->wValue_loByte;
						SETUP_DATA.wValue_hiByte	= recv_setup->wValue_hiByte;
						SETUP_DATA.wIndex_loByte	= recv_setup->wIndex_loByte;
						SETUP_DATA.wLength			= recv_setup->wLength_loByte;
						if (recv_setup->wLength_hiByte > 0) {
							SETUP_DATA.wLength = 0xff;
						}
						g_field.s.setup_data_avail = TRUE;

						// Clear various states
						g_field.s.data_toggle = 1;
						g_field.s.in_stall = FALSE;
						g_in_data_pkt_len = 0;
					} else {
						// CRC16 mismatch error						// CRC16 mismatch error
						// Next rate measurement
						request_measure_on_recv_err();
					}
				}

				// Return to No_packet state
				g_xact_state = E_XACT_STATE_NO_PACKET;

			} else if (g_xact_state == E_XACT_STATE_DEV_WAIT_ODATA_OUT) {
				// Dev_wait_Odata (OUT) state
				if (RECV_STS_PKT_LEN(sts) >= 3) {
					if (RECV_STS_PKT_CRC16_OK(sts)) {
						if (recvbuf[0] == USB_PID_DATA1) {
							// Receive DATA 1 after OUT token
							// it is a valid OUT transaction
							// return ACK
							swusb_xmit_handshake_pkt(USB_PID_ACK);
							g_field.s.measure_disabled = FALSE;
						} else if (recvbuf[0] == USB_PID_DATA0) {
							// Receive DATA 0 after OUT token
							// In Billboard it should not exist, but spec returns ACK
							swusb_xmit_handshake_pkt(USB_PID_ACK);
							g_field.s.measure_disabled = FALSE;
						}
					} else {
						// CRC16 mismatch error
						// Next rate measurement
						request_measure_on_recv_err();
					}
				}

				// Return to No_packet state
				g_xact_state = E_XACT_STATE_NO_PACKET;

			} else if (g_xact_state == E_XACT_STATE_DEV_RESP) {
				// Dev_resp state

				if (RECV_STS_PKT_LEN(sts) == 1 && recvbuf[0] == USB_PID_ACK) {
					// Receive ACK after returning DATAx to IN token
					g_field.s.data_toggle ^= 1;  // data toggle
					if (g_in_data_pkt_len < 1+8+2) {	// 1(PID)+8(DATA)+2(CRC16)
						// After returning short packet, return STALL to the next IN token [USB20 8.5.3.1]
						g_field.s.in_stall = TRUE;
					}
					g_in_data_pkt_len = 0;		// IN data not available

					if (g_field.s.set_address_requested) {
						// Since the Status Stage of Set Address has been completed, actually change the address
						UCHAR new_addr = SETUP_DATA.wValue_loByte & 0x7f;
						device_set_address(new_addr);
						g_field.s.set_address_requested = FALSE;
					}
				} else {
					// Other PIDs or ACK packets with incorrect length
					// No reply
				}

				// Return to No_packet state
				g_xact_state = E_XACT_STATE_NO_PACKET;
			} else {
				// In other states (that is, No_packet state), packets other than tokens were received
				// No reply
				g_xact_state = E_XACT_STATE_NO_PACKET;
			}

		} else if (sts == RECV_STS_ERR_OVERRUN || sts == RECV_STS_ERR_STUFF) {
			if (g_xact_state == E_XACT_STATE_DEV_WAIT_ODATA_SETUP ||
				g_xact_state == E_XACT_STATE_DEV_WAIT_ODATA_OUT) {
				// In the Dev_wait_Odata state, "EOP detection failure" or "bit stuff error"
				// Next rate measurement
				request_measure_on_recv_err();
			}
			// Return to No_packet state
			g_xact_state = E_XACT_STATE_NO_PACKET;

		} else if (sts == RECV_STS_RESET) {
			// Reset detection
			device_reset();
		} else if (sts == RECV_STS_RESUME) {
			// Resume detection
			// do nothing
		}
	}
}

static USHORT crc16_calc(const UCHAR *p, UCHAR len)
{
	USHORT reg = 0xffff;
	USHORT tbl;

	while (len --) {
		tbl = g_crc_tbl_swap[(reg & 0xff) ^ *p++];
		tbl = (tbl >> 8) | (tbl << 8);  // Since we are using the byte swapped table, we will byte swap it back again
		reg = (reg >> 8) ^ tbl;
	}
	return reg ^ 0xffff;
}

// Copy len bytes from the (parameter + param_offset) position in the parameter area to dest.
#define MEMCPY_PARAM(dest, param, param_offset, len)	memcpy_param_core((UCHAR*)(dest), (const UVFCHAR*)(param) + (param_offset), len)
static void memcpy_param_core(UCHAR *dest, const UVFCHAR *src, UCHAR len)
{
	while (len --) {
		*dest++ = *src++;
	}
}

// Copy len bytes from the position of (param + param_offset) in the parameter area from ASCII to UTF - 16LE and dest to dest
#define DECODE_STRING_PARAM(dest, param, param_offset, len)	decode_string_param_core((UCHAR*)(dest), (const UVFCHAR*)(param) + (param_offset), len)
static void decode_string_param_core(UCHAR *dest, const UVFCHAR *src, UCHAR len)
{
	while (len --) {
		*dest++ = *src++;		// Lower byte of UTF16-LE
		*dest++ = 0;			// Upper byte of UTF16-LE
	}
}

// Calculate the String Descriptor index.
static UCHAR make_string_index(UCHAR valid_bit_pos)
{
	USHORT valid = BBC_STR_DESCS_VALID;
	UCHAR index = 1;
	UCHAR i;

	for (i = 0; i < valid_bit_pos; i ++) {
		index += (valid & 1);
		valid >>= 1;
	}
	if (valid & 1)
		return index;
	else
		return 0;
}

// Calculate the value of iAlternateModeString [mode]. (mode = 0 to 3)
static UCHAR make_i_alternate_mode_string(UCHAR mode)
{
	return make_string_index(VALID_BIT_POS_I_ALTERNATE_MODE_STRING_0 + mode);
}

// Calculate the maximum value of String Descriptor index.
static UCHAR get_max_string_index(void)
{
	USHORT valid = BBC_STR_DESCS_VALID;
	UCHAR index = 0;

	// Repeat for the number of valid standing bits
	while (valid) {
		valid &= valid - 1;		// Clear the rightmost bit standing
		index ++;
	}
	return index;
}

// Calculate the value of bmAttributes of Configuration Descriptor.
static UCHAR make_bm_attributes(void)
{
	UCHAR option = BBC_OPTION;
	return 0x80 | (option & BBC_OPTION_BIT_SELF_POWERED ? USB_CONFIG_SELF_POWERED : 0);
}

// Calculate the value of VCONN Power
static USHORT make_vconn_power_field(void)
{
	UCHAR param = BBC_VCONN_POWER;
	return ((USHORT)param & 0x80) << 8 | (param & 0x7f);
}

// Create the indexth byte bounded by BOS Descriptor and CONTAINER_ID Descriptor separated by 8 bytes.
// The return value is the number of bytes created.
static UCHAR make_in_data_bos_and_container_id(UCHAR *in_data, UCHAR index)
{
	switch (index) {
		case 0:
		{
			UCHAR num_alt_mode = BBC_NUM_ALT_MODE;
			USHORT total_length = USB_BOS_DESCRIPTOR_TOTAL_LENGTH(num_alt_mode);
																				// ---(BOS Descriptor)---
			in_data[0] = USB_BOS_DESCRIPTOR_LENGTH;								// bLength
			in_data[1] = USB_BOS_DESCRIPTOR_TYPE;								// bDescriptorType
			in_data[2] = LOBYTE(total_length);									// wTotalLength (lo)
			in_data[3] = HIBYTE(total_length);									// wTotalLength (hi)
			in_data[4] = USB_BOS_DESCRIPTOR_NUM_DEVICE_CAPS(num_alt_mode);		// bNumDeviceCaps
																				// ---(Device Capability Descriptor (CONTAINER_ID))---
			in_data[5] = USB_CONTAINER_ID_DESCRIPTOR_LENGTH;					// bLength
			in_data[6] = USB_DEVICE_CAPABILITY_DESCRIPTOR_TYPE;					// bDescriptorType
			in_data[7] = USB_CONTAINER_ID_DEVICE_CAPABILITY_TYPE;				// bDevCapabilityType
			return 8;
		}

		case 1:
			in_data[0] = 0;														// bReserved
			MEMCPY_PARAM(&in_data[1], &BBC_CONTAINER_UUID_0, 0, 7);				// ContainerID[0-6]
			return 8;

		case 2:
			MEMCPY_PARAM(&in_data[0], &BBC_CONTAINER_UUID_0, 7, 8);				// ContainerID[7-14]
			return 8;

		case 3:
			MEMCPY_PARAM(&in_data[0], &BBC_CONTAINER_UUID_0, 15, 1);			// ContainerID[15]
			return 1;

		default:
			return 0;
	}
}

// Create the indexth bit with BILLBOARD_CAPABILITY Descriptor separated by 8 bytes.
// The return value is the number of bytes created.
static UCHAR make_in_data_billboard_capability(UCHAR *in_data, UCHAR index)
{
	switch (index) {
		case 0:
		{
																				// ---(Device Capability Descriptor (BILLBOARD_CAPABILITY))---
			UCHAR num_alt_mode = BBC_NUM_ALT_MODE;
			USHORT vconn_power;
			in_data[0] = USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode);	// bLength
			in_data[1] = USB_DEVICE_CAPABILITY_DESCRIPTOR_TYPE;					// bDescriptorType
			in_data[2] = USB_BILLBOARD_DEVICE_CAPABILITY_TYPE;					// bDevCapabilityType
			in_data[3] = make_string_index(VALID_BIT_POS_I_ADDITIONAL_INFO_URL);	// iAddtionalInfoURL
			in_data[4] = num_alt_mode;											// bNumberOfAlternateModes
			in_data[5] = BBC_PREFERRED_ALT_MODE;								// bPreferredAlternateMode
			vconn_power = make_vconn_power_field();
			in_data[6] = LOBYTE(vconn_power);									// VCONN Power (lo)
			in_data[7] = HIBYTE(vconn_power);									// VCONN Power (hi)
			return 8;
		}

		case 1:
			in_data[0] = g_bbc_configured;										// bmConfigured[0]
			memset(&in_data[1], 0, 7);											// bmConfigured[1-7]
			return 8;

		case 2:
			memset(&in_data[0], 0, 8);											// bmConfigured[8-15]
			return 8;

		case 3:
			memset(&in_data[0], 0, 8);											// bmConfigured[16-23]
			return 8;

		case 4:
			memset(&in_data[0], 0, 8);											// bmConfigured[24-31]
			return 8;

		case 5:
		{
			USHORT svid;
			in_data[0] = LOBYTE(SWUSB_BBC_BCD_VERSION);							// bcdVersion (lo)
			in_data[1] = HIBYTE(SWUSB_BBC_BCD_VERSION);							// bcdVersion (hi)
			in_data[2] = g_bbc_additional_failure_info;							// bAdditonalFailureInfo
			in_data[3] = 0;														// bReserved
			svid = BBC_SVID_0;
			in_data[4] = LOBYTE(svid);											// wSVID[0] (lo)
			in_data[5] = HIBYTE(svid);											// wSVID[0] (hi)
			in_data[6] = BBC_ALT_MODE_0;										// bAlternateMode[0]
			in_data[7] = make_i_alternate_mode_string(0);						// iAlternateModeString[0]
			return 8;
		}

		case 6:
		{
			USHORT svid;
			svid = BBC_SVID_1;
			in_data[0] = LOBYTE(svid);											// wSVID[1] (lo)
			in_data[1] = HIBYTE(svid);											// wSVID[1] (hi)
			in_data[2] = BBC_ALT_MODE_1;										// bAlternateMode[1]
			in_data[3] = make_i_alternate_mode_string(1);						// iAlternateModeString[1]
			if (BBC_NUM_ALT_MODE == 2) {
				return 4;
			}
			svid = BBC_SVID_2;
			in_data[4] = LOBYTE(svid);											// wSVID[2] (lo)
			in_data[5] = HIBYTE(svid);											// wSVID[2] (hi)
			in_data[6] = BBC_ALT_MODE_2;										// bAlternateMode[2]
			in_data[7] = make_i_alternate_mode_string(2);						// iAlternateModeString[2]
			return 8;
		}

		case 7:
		{
			USHORT svid;
			svid = BBC_SVID_3;
			in_data[0] = LOBYTE(svid);											// wSVID[3] (lo)
			in_data[1] = HIBYTE(svid);											// wSVID[3] (hi)
			in_data[2] = BBC_ALT_MODE_3;										// bAlternateMode[3]
			in_data[3] = make_i_alternate_mode_string(3);						// iAlternateModeString[3]
			return 4;
		}

		default:
			return 0;
	}
}

#if SWUSB_BBC_BCD_VERSION >= 0x0121
// BILLBOARD_ALTERNATE_MODE_CAPABILITY. Create an indexth byte with 8 byte separator.
// The return value is the number of bytes created.
static UCHAR make_in_data_billboard_alternate_mode_capability(UCHAR *in_data, UCHAR index)
{
	static const UVFLONG* const vdo_param_ptr[] = {
		&BBC_ALT_MODE_VDO_0,
		&BBC_ALT_MODE_VDO_1,
		&BBC_ALT_MODE_VDO_2,
		&BBC_ALT_MODE_VDO_3,
	};

	in_data[0] = USB_BILLBOARD_ALTERNATE_MODE_CAPABILITY_DESCRIPTOR_LENGTH;		// bLength
	in_data[1] = USB_DEVICE_CAPABILITY_DESCRIPTOR_TYPE;							// bDescriptorType
	in_data[2] = USB_BILLBOARD_ALTERNATE_MODE_DEVICE_CAPABILITY_TYPE;			// bDevCapabilityType
	in_data[3] = index;															// bIndex
	MEMCPY_PARAM(&in_data[4], vdo_param_ptr[index], 0, 4);						// dwAlternateModeVdo
	return 8;
}
#endif

// Create the IN data packet to be transmitted next on the transmission buffer.
// g_transfer_state indicates which Transaction in which IN transfer.
// Return value: TRUE = packet Preparation OK, FALSE = STALL should be sent
static BOOL make_in_data(void)
{
	UCHAR retlen = 0;
	USHORT crc16;

	switch (g_transfer_state) {
		//========== Set Address ==========
		//========== Set Configuration ==========
		case E_TSTATE_SET_ADDRESS:
		case E_TSTATE_SET_CONFIGURATION:
			// This makes IN DATA (0 length) of Status Stage
			retlen = 0;
			break;

		//========== Get Descriptor (Device) ==========
		case E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_0:
			g_transfer_state = E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_1;
														// ---(Device Descriptor)---
			IN_DATA[0] = USB_DEVICE_DESCRIPTOR_LENGTH;	// bLength
			IN_DATA[1] = USB_DEVICE_DESCRIPTOR_TYPE;	// bDescriptorType
			IN_DATA[2] = LOBYTE(USB_BCD_USB);			// bcdUSB (lo)
			IN_DATA[3] = HIBYTE(USB_BCD_USB);			// bcdUSB (hi)
			IN_DATA[4] = USB_DEVICE_BILLBOARD_CLASS;	// bDeviceClass
			IN_DATA[5] = USB_DEVICE_BILLBOARD_SUBCLASS;	// bDeviceSubClass
			IN_DATA[6] = USB_DEVICE_BILLBOARD_PROTOCOL;	// bDeviceProtocl
			IN_DATA[7] = 8;								// bMaxPacketSize0
			retlen = 8;
			break;

		case E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_1:
		{
			USHORT tmpus;
			g_transfer_state = E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_2;
			tmpus = BBC_VENDOR_ID;
			IN_DATA[0] = LOBYTE(tmpus);					// idVendor (lo)
			IN_DATA[1] = HIBYTE(tmpus);					// idVendor (hi)
			tmpus = BBC_PRODUCT_ID;
			IN_DATA[2] = LOBYTE(tmpus);					// idProduct (lo)
			IN_DATA[3] = HIBYTE(tmpus);					// idProduct (hi)
			tmpus = BBC_BCD_DEVICE;
			IN_DATA[4] = LOBYTE(tmpus);					// bcdDevice (lo)
			IN_DATA[5] = HIBYTE(tmpus);					// bcdDevice (hi)
			IN_DATA[6] = make_string_index(VALID_BIT_POS_I_MANUFACTURER);	// iManufacturer
			IN_DATA[7] = make_string_index(VALID_BIT_POS_I_PRODUCT);		// iProduct
			retlen = 8;
			break;
		}

		case E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_2:
			IN_DATA[0] = make_string_index(VALID_BIT_POS_I_SERIAL_NUMBER);	// iSerialNumber
			IN_DATA[1] = 1;								// bNumConfigurations
			retlen = 2;
			break;

		//========== Get Descriptor (Configuration) ==========
		case E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_0:
			g_transfer_state = E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_1;
																				// ---(Configuration Descriptor)---
			IN_DATA[0] = USB_CONFIGURATION_DESCRIPTOR_LENGTH;					// bLength
			IN_DATA[1] = USB_CONFIGURATION_DESCRIPTOR_TYPE;						// bDescriptorType
			IN_DATA[2] = LOBYTE(USB_CONFIGURATION_DESCRIPTOR_TOTAL_LENGTH);		// wTotalLength (lo)
			IN_DATA[3] = HIBYTE(USB_CONFIGURATION_DESCRIPTOR_TOTAL_LENGTH);		// wTotalLength (hi)
			IN_DATA[4] = 1;														// bNumInterfaces
			IN_DATA[5] = USB_CONFIGURATION_VALUE;								// bConfigurationValue
			IN_DATA[6] = make_string_index(VALID_BIT_POS_I_CONFIGURATION);		// iConfiguration
			IN_DATA[7] = make_bm_attributes();									// bmAttributes
			retlen = 8;
			break;

		case E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_1:
			g_transfer_state = E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_2;
			IN_DATA[0] = BBC_MAX_POWER;											// bMaxPower
																				// ---(Interface Descriptor)---
			IN_DATA[1] = USB_INTERFACE_DESCRIPTOR_LENGTH;						// bLength
			IN_DATA[2] = USB_INTERFACE_DESCRIPTOR_TYPE;							// bDescriptorType
			IN_DATA[3] = USB_INTERFACE_NUMBER;									// bInterfaceNumber
			IN_DATA[4] = 0;														// bAlternateSetting
			IN_DATA[5] = 0;														// bNumEndpoints
			IN_DATA[6] = USB_DEVICE_BILLBOARD_CLASS;							// bInterfaceClass
			IN_DATA[7] = USB_DEVICE_BILLBOARD_SUBCLASS;							// bInterfaceSubClass
			retlen = 8;
			break;

		case E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_2:
			IN_DATA[0] = USB_DEVICE_BILLBOARD_PROTOCOL;							// bInterfaceProtocol
			IN_DATA[1] = make_string_index(VALID_BIT_POS_I_INTERFACE);			// iInterface
			retlen = 2;
			break;

		//========== Get Descriptor (BOS) ==========
		case E_TSTATE_GET_BOS_DESCRIPTOR_DATA:
			{
				const UCHAR num_alt_mode = BBC_NUM_ALT_MODE;
				UCHAR offset;

				retlen = 0;
				offset = g_transferred_packet_num * 8;		// Number of bytes sent

				// In the following loop, assemble 8 bytes from position offset in return data on IN_DATA.
				// Since the size of each descriptor making up return data changes according to bNumberOfAlternateModes, we need to devise an assembly.
				// First, determine which position of the descriptor the offset corresponds to,
				// Create a portion of the descriptor on a temporary buffer (partial).
				// Then add only necessary parts of temporary buffer to IN_DATA.
				// This is repeated until IN_DATA (8 bytes) is filled or until the end of the returned data is reached.
				do {
					UCHAR ofs = offset;
					UCHAR len, remain;
					UCHAR partial[8];

					// Create the descriptor at the position pointed to by by 8 bytes
					// len is the created number of bytes (8 bytes or less)
					if (ofs < USB_BOS_DESCRIPTOR_LENGTH + USB_CONTAINER_ID_DESCRIPTOR_LENGTH) {
						// ---(BOS Descriptor + CONTAINER_ID)---
						len = make_in_data_bos_and_container_id(partial, ofs / 8);
					} else if (ofs -= USB_BOS_DESCRIPTOR_LENGTH + USB_CONTAINER_ID_DESCRIPTOR_LENGTH,
					           ofs < USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode)
					) {
						// ---(BILLBOARD_CAPABILITY)---
						len = make_in_data_billboard_capability(partial, ofs / 8);
				#if SWUSB_BBC_BCD_VERSION >= 0x0121
					} else if (ofs -= USB_BILLBOARD_CAPABILITY_DESCRIPTOR_LENGTH(num_alt_mode),
					           ofs < USB_BILLBOARD_ALTERNATE_MODE_CAPABILITY_DESCRIPTOR_LENGTH * num_alt_mode
					) {
						// ---(BILLBOARD_ALTERNATE_MODE_CAPABILITY)---
						len = make_in_data_billboard_alternate_mode_capability(partial, ofs / 8);
				#endif
					} else {
						// Reached the end of return data
						break;
					}

					// Of the temporary buffer (partial), the necessary part is [ofs% 8] or later
					len -= ofs % 8;				// Effective data length after [ofs% 8] on temporary buffer
					remain = 8 - retlen;		// The rest of IN_DATA
					if (len > remain)
						len = remain;			// Make it only fit in IN_DATA
					memcpy(&IN_DATA[retlen], &partial[ofs % 8], len);
					offset += len;
					retlen += len;
				} while (retlen < 8);  // Until IN_DATA (8 bytes) is filled
			}

			// To the next state
			g_transferred_packet_num ++;
			break;

		//========== Get Descriptor (String, index=0) ==========
		case E_TSTATE_GET_STRING_DESCRIPTOR_0_DATA:
			// LANGID codes
			if (BBC_STR_DESCS_VALID) {
				IN_DATA[0] = 4;													// bLength
				IN_DATA[1] = USB_STRING_DESCRIPTOR_TYPE;						// bDescriptorType
				IN_DATA[2] = LOBYTE(USB_LANGID_ENGLISH_US);						// wLANGID[0] (lo)
				IN_DATA[3] = HIBYTE(USB_LANGID_ENGLISH_US);						// wLANGID[0] (hi)
				retlen = 4;
			} else {
				// If there is no String Descriptor, LANGID does not exist either
				IN_DATA[0] = 2;													// bLength
				IN_DATA[1] = USB_STRING_DESCRIPTOR_TYPE;						// bDescriptorType
				retlen = 2;
			}
			break;

		//========== Get Descriptor (String, index!=0) ==========
		case E_TSTATE_GET_STRING_DESCRIPTOR_1_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_2_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_3_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_4_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_5_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_6_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_7_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_8_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_9_DATA:
		case E_TSTATE_GET_STRING_DESCRIPTOR_10_DATA:
			{
				UCHAR string_index = STRING_INDEX(g_transfer_state);
				const UVFCHAR *p = (const UVFCHAR *)&BBC_STR_AREA_00H;  // Start of character string area
				UCHAR si, len, sent;

				// Move to string_indexth character string
				for (si = 1; si < string_index; si ++) {
					p += *p + 1;
				}
				len = *p;	// Word count

				if (g_transferred_packet_num == 0) {
					// First packet (with header of string descriptor)
					IN_DATA[0] = 2 + len * 2;
					IN_DATA[1] = USB_STRING_DESCRIPTOR_TYPE;
					if (len > 3) len = 3;	// Number of characters to be sent this time (3 characters = 6 bytes is the upper limit)
					DECODE_STRING_PARAM(&IN_DATA[2], p, 1, len);
					retlen = 2 + len * 2;
				} else {
					// Second and subsequent packets
					sent = g_transferred_packet_num * 4 - 1;		// Number of sent characters
					len -= sent;	// Number of unsent characters
					if (len > 4) len = 4;	// Number of characters to be sent this time (4 characters = 8 bytes is the upper limit)
					DECODE_STRING_PARAM(&IN_DATA[0], p, 1+sent, len);
					retlen = len * 2;
				}

				// To the next state
				g_transferred_packet_num ++;
			}
			break;

		//========== Get Configuration ==========
		case E_TSTATE_GET_CONFIGURATION_DATA:
			// Get Configuration
			IN_DATA[0] = (IS_DEVICE_STATE_CONFIGURED() ? USB_CONFIGURATION_VALUE : 0);	// Configuration Value
			retlen = 1;
			break;

		//========== Get Status (Device) ==========
		case E_TSTATE_GET_STATUS_DEVICE_DATA:
			// Get Status (Device)
			IN_DATA[0] = g_field.s.self_powered << 0;	// D0:Self Powered
			IN_DATA[1] = 0x00;
			retlen = 2;
			break;

		//========== Get Status (Interface) ==========
		case E_TSTATE_GET_STATUS_INTERFACE_DATA:
			// Get Status (Interface)
			IN_DATA[0] = 0x00;
			IN_DATA[1] = 0x00;
			retlen = 2;
			break;

		//========== Get Status (Endpoint) ==========
		case E_TSTATE_GET_STATUS_ENDPOINT_DATA:
			// Get Status (Endpoint)
			IN_DATA[0] = 0x00;
			IN_DATA[1] = 0x00;
			retlen = 2;
			break;

		default:  // normally never executed
			return FALSE;
	}

	// Limit transmission length to wLength
	if (retlen > SETUP_DATA.wLength)
		retlen = SETUP_DATA.wLength;
	SETUP_DATA.wLength -= retlen;

	// Returning short packet is the end of IN data
	if (retlen < 8) {
		g_transfer_state = E_TSTATE_IDLE;
	}

	// Add CRC16
	crc16 = crc16_calc(IN_DATA, retlen);
	IN_DATA[retlen + 0] = LOBYTE(crc16);
	IN_DATA[retlen + 1] = HIBYTE(crc16);

	// Processing is unnecessary for PID (it is added within an interrupt immediately before transmission)

	// When g_in_data_pkt_len is made non-0, it becomes IN data available
	g_in_data_pkt_len = retlen + 3;		// 1(PID) + retlen(DATA) + 2(CRC16)

	return TRUE;
}

// Set Address
static BOOL request_set_address(void)
{
	g_field.s.set_address_requested = TRUE;
	g_transfer_state = E_TSTATE_SET_ADDRESS;
	return make_in_data();
}

// Set Configuration
static BOOL request_set_configuration(void)
{
	switch (SETUP_DATA.wValue_loByte) {  // Configuration Value
		case 0:
			device_deconfigure();
			g_transfer_state = E_TSTATE_SET_CONFIGURATION;
			return make_in_data();
		case USB_CONFIGURATION_VALUE:
			device_configure();
			g_transfer_state = E_TSTATE_SET_CONFIGURATION;
			return make_in_data();
	}
	return FALSE;
}

// Get Descriptor
static BOOL request_get_descriptor(void)
{
	UCHAR descriptor_index = SETUP_DATA.wValue_loByte;	// Descriptor Index

	switch (SETUP_DATA.wValue_hiByte) {		// Descriptor Type
		case USB_DEVICE_DESCRIPTOR_TYPE:
			// a descriptor index of zero must be used
			g_transfer_state = E_TSTATE_GET_DEVICE_DESCRIPTOR_DATA_0;
			return make_in_data();

		case USB_CONFIGURATION_DESCRIPTOR_TYPE:
			if (descriptor_index == 0) {
				g_transfer_state = E_TSTATE_GET_CONFIG_DESCRIPTOR_DATA_0;
				return make_in_data();
			}
			break;

		case USB_BOS_DESCRIPTOR_TYPE:
			// a descriptor index of zero must be used
			g_transfer_state = E_TSTATE_GET_BOS_DESCRIPTOR_DATA;
			g_transferred_packet_num = 0;
			return make_in_data();

		case USB_STRING_DESCRIPTOR_TYPE:
			if (descriptor_index <= get_max_string_index()) {
				g_transfer_state = E_TSTATE_GET_STRING_DESCRIPTOR_DATA(descriptor_index);
				g_transferred_packet_num = 0;
				return make_in_data();
			}
			break;
	}
	return FALSE;
}

// Get Configuration
static BOOL request_get_configutarion(void)
{
	g_transfer_state = E_TSTATE_GET_CONFIGURATION_DATA;
	return make_in_data();
}

// Get Status (Device)
static BOOL request_get_status_device(void)
{
	g_transfer_state = E_TSTATE_GET_STATUS_DEVICE_DATA;
	return make_in_data();
}

// Get Status (Interface)
static BOOL request_get_status_interface(void)
{
	if (SETUP_DATA.wIndex_loByte == USB_INTERFACE_NUMBER) {		// Interface Number
		g_transfer_state = E_TSTATE_GET_STATUS_INTERFACE_DATA;
		return make_in_data();
	}
	return FALSE;
}

// Get Status (Endpoint)
static BOOL request_get_status_endpoint(void)
{
	if (SETUP_DATA.wIndex_loByte == 0x00) {		// Endpoint address
		g_transfer_state = E_TSTATE_GET_STATUS_ENDPOINT_DATA;
		return make_in_data();
	}
	return FALSE;
}

// Execute the request in SETUP_DATA and create the first IN data packet.
// Returned value: TRUE = success, FALSE = Request Error
static BOOL request_dispatch(void)
{
	switch (SETUP_DATA.bmRequestType) {
		case (BMREQUEST_HOST_TO_DEVICE | BMREQUEST_STANDARD | BMREQUEST_TO_DEVICE):
			switch (SETUP_DATA.bRequest) {
				case USB_REQUEST_SET_ADDRESS:
					return request_set_address();
				case USB_REQUEST_SET_CONFIGURATION:
					return request_set_configuration();
			}
			break;

		case (BMREQUEST_DEVICE_TO_HOST | BMREQUEST_STANDARD | BMREQUEST_TO_DEVICE):
			switch (SETUP_DATA.bRequest) {
				case USB_REQUEST_GET_DESCRIPTOR:
					return request_get_descriptor();
				case USB_REQUEST_GET_CONFIGURATION:
					return request_get_configutarion();
				case USB_REQUEST_GET_STATUS:
					return request_get_status_device();
			}
			break;

		case (BMREQUEST_DEVICE_TO_HOST | BMREQUEST_STANDARD | BMREQUEST_TO_INTERFACE):
			switch (SETUP_DATA.bRequest) {
				case USB_REQUEST_GET_STATUS:
					return request_get_status_interface();
			}
			break;

		case (BMREQUEST_DEVICE_TO_HOST | BMREQUEST_STANDARD | BMREQUEST_TO_ENDPOINT):
			switch (SETUP_DATA.bRequest) {
				case USB_REQUEST_GET_STATUS:
					return request_get_status_endpoint();
			}
			break;
	}
	return FALSE;
}

void swusb_init(void)
{
	// Initialize API settings
	g_field.s.self_powered = 1;			// 1:self-powered
	g_field.s.measure_req = FALSE;
	g_bbc_configured = 0x00;
	g_bbc_additional_failure_info = 0x00;

	// Initialize port
	swusb_io_init();
	pdc_set_int_routine (intID_INT_DMINUS, (ULONG)int_dminus_handler);
}

USHORT swusb_chk (void);

void swusb_proc(void)
{
// Whenever the BB device is enumerated, there is a flurry of activity in both "if" branches
// in this function.
	BOOL good_request;
		
	if (g_field.s.setup_data_avail) {
		msg ('w'); // for debug if needed
		// Since we received SETUP data, we process request.
		good_request = request_dispatch();
		if (!good_request) {
			// Request Error
			g_field.s.in_stall = TRUE;
		}
		g_field.s.setup_data_avail = FALSE;

	} else if (g_in_data_pkt_len == 0 && g_transfer_state != E_TSTATE_IDLE) {
		// IN data not available and if there is a subsequent IN data,
		// Create the next IN data packet.
		msg ('r'); // for debug if needed
		good_request = make_in_data();
		if (!good_request) {
			// Request Error
			g_field.s.in_stall = TRUE;
		}
	}
}

BOOL swusb_is_transferring(void)
{
	return g_transfer_state != E_TSTATE_IDLE;
}

void swusb_measure_rate(void)
{
	g_field.s.measure_req = TRUE;
}

void swusb_enable(void)
{
	if (!swusb_io_is_enabled()) {
		// state reset
		device_reset();

		// Rate correction value is neutral value
		g_swusb_rate_offset = RECV_RATE_OFFSET_NEUTRAL;

		// Enable I/O
		swusb_io_enable();
	}
}

void swusb_disable(void)
{
	// Disable I/O
	swusb_io_disable();

	// State reset
	device_reset();
}

void swusb_set_power_supply(UCHAR self_powered)
{
	g_field.s.self_powered = self_powered;
}

void swusb_bb_configured(UCHAR mode, UCHAR value)
{
	if (mode < BBC_NUM_ALT_MODE) {
		// Processing on the premise of mode <4
		g_bbc_configured &= ~(3 << (mode * 2));
		g_bbc_configured |= (value & 3) << (mode * 2);
	}
}

void swusb_bb_set_additional_failure_info(UCHAR value)
{
	g_bbc_additional_failure_info = value;
} 




