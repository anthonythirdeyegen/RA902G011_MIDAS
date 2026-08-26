;---------------------------------------------------------------------
; USB GPIO terminal settings
;
; Åö Attention Åö
; After changing this file, please be sure to "Rebuild" the project.
; Normal rebuild is not executed in "Build".
;---------------------------------------------------------------------
;
; Selecting the default GPIO terminal configuration 
;     (see also swusb_pin_config.h)
;      1 : (D+,D-)=(P81,P82)
;      2 : (D+,D-)=(P82,P81)
;  other : custom
USB_GPIO_CONFIG_SELECT		.EQU	2



$IF USB_GPIO_CONFIG_SELECT == 1
	;-------------------------------------------------------------
	; (D+,D-)=(P81,P82)
	;-------------------------------------------------------------
	; D+, D- pin config
	USB_PORT_REG		.EQU	P8
	USB_PM_REG		.EQU	PM8
	BITPOS_DPLUS		.EQU	1
	BITPOS_DMINUS		.EQU	2

$ELSEIF USB_GPIO_CONFIG_SELECT == 70 ;; was 2
	;-------------------------------------------------------------
	; (D+,D-)=(P82,P81)
	;-------------------------------------------------------------
	; D+, D- pin config
	USB_PORT_REG		.EQU	P8
	USB_PM_REG		.EQU	PM8
	BITPOS_DPLUS		.EQU	2
	BITPOS_DMINUS		.EQU	1

$ELSE
	;-------------------------------------------------------------
	; custom
	;   D+, D-, PUE = P51, P50, P80  /// for PDC SDK on DRPEVB board
	;      Also using INTP1 from P50
	;-------------------------------------------------------------
	; D+, D- pin config
	USB_PORT_REG		.EQU	P5
	USB_PM_REG		.EQU	PM5
	BITPOS_DPLUS		.EQU	1
	BITPOS_DMINUS		.EQU	0

$ENDIF
