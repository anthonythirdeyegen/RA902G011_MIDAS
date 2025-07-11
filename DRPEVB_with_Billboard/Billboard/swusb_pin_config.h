#ifndef ___SWUSB_PIN_CONFIG_H
#define ___SWUSB_PIN_CONFIG_H

// Pin configurations for Billboard USB signals
//      1 : (D+,D-)=(P81,P82), PUE=P73
//      2 : (D+,D-)=(P82,P81), PUE=P73
//  other : custom
#define USB_GPIO_CONFIG_SELECT		50  /// originally was 2


#if USB_GPIO_CONFIG_SELECT == 1
	//-------------------------------------------------------------
	// (D+,D-)=(P81,P82), PUE=P73
	//-------------------------------------------------------------
	// D+, D- pin config
	#define USB_PORT_REG		P8
	#define USB_PM_REG			PM8
	#define BITPOS_DPLUS		1
	#define BITPOS_DMINUS		2

	// D- pin interrupt config : INTP7
	#define PIF_DMINUS			PIF7
	#define PMK_DMINUS			PMK7
	#define PPR0_DMINUS			PPR07
	#define PPR1_DMINUS			PPR17
	#define EGP_DMINUS			EGP0_bit.no7
	#define EGN_DMINUS			EGN0_bit.no7
	#define intID_INT_DMINUS	intID_INTP7

	// PUE pin config
	#define PUE_PORT_REG		P7
	#define PUE_PM_REG			PM7
	#define BITPOS_PUE			3

#elif USB_GPIO_CONFIG_SELECT == 2
	//-------------------------------------------------------------
	// (D+,D-)=(P82,P81), PUE=P73
	//-------------------------------------------------------------
	// D+, D- pin config
	#define USB_PORT_REG		P8
	#define USB_PM_REG			PM8
	#define BITPOS_DPLUS		2
	#define BITPOS_DMINUS		1

	// D- pin interrupt config : INTP6
	#define PIF_DMINUS			PIF6
	#define PMK_DMINUS			PMK6
	#define PPR0_DMINUS			PPR06
	#define PPR1_DMINUS			PPR16
	#define EGP_DMINUS			EGP0_bit.no6
	#define EGN_DMINUS			EGN0_bit.no6
	#define intID_INT_DMINUS	intID_INTP6

	// PUE pin config
	#define PUE_PORT_REG		P7
	#define PUE_PM_REG			PM7
	#define BITPOS_PUE			3

#elif USB_GPIO_CONFIG_SELECT == 50
	///-------------------------------------------------------------
	// For APLOS:  (D+, D-)=(P51, P50), PUE=P80
	//    Also use INTP1 from P50
	//--------------------------------------------------------------
	// D+, D- pin config
	#define USB_PORT_REG		P5
	#define USB_PM_REG		PM5	
	#define BITPOS_DPLUS		1
	#define BITPOS_DMINUS		0

	// D- pin interrupt config : 
	#define PIF_DMINUS		PIF1	
	#define PMK_DMINUS		PMK1	
	#define PPR0_DMINUS		PPR01	
	#define PPR1_DMINUS		PPR11	
	#define EGP_DMINUS		EGP0_bit.no1	
	#define EGN_DMINUS		EGN0_bit.no1	
	#define intID_INT_DMINUS	intID_INTP1

	// PUE pin config
	#define PUE_PORT_REG		P8
	#define PUE_PM_REG		PM8	
	#define BITPOS_PUE		0	

#else
	///-------------------------------------------------------------
	// custom:  (D+, D-)=(P72, P70), PUE=P73 -- for use with PDC SDK on DUAL/PDC eval board
	//    Need to use P70 for INTP4
	//-------------------------------------------------------------
	// D+, D- pin config
	#define USB_PORT_REG		P7
	#define USB_PM_REG		PM7	
	#define BITPOS_DPLUS		2
	#define BITPOS_DMINUS		0

	// D- pin interrupt config : 
	#define PIF_DMINUS		PIF4	
	#define PMK_DMINUS		PMK4	
	#define PPR0_DMINUS		PPR00	
	#define PPR1_DMINUS		PPR10	
	#define EGP_DMINUS		EGP0_bit.no4	
	#define EGN_DMINUS		EGN0_bit.no4	
	#define intID_INT_DMINUS	intID_INTP4

	// PUE pin config
	#define PUE_PORT_REG		P7
	#define PUE_PM_REG		PM7	
	#define BITPOS_PUE		3	

#endif

#endif // ___SWUSB_PIN_CONFIG_H
