;****************************************************************************
; FILE NAME:    pd_param.asm
;
; Please generate this file automatically from EXCEL.
; Please do not edit.
;****************************************************************************/
;-----------------------------------------------------------------------------
;Parameter Table
;-----------------------------------------------------------------------------
PARAM_TABLE .EQU    0xF700
; Start address was 0xF800.  Manually edited.  All addresses listed below are now listed_value-0x0100.
; This is necessary to avoid conflict with PD addresses starting at 0xFBFC (flash table area in cstart.asm and ftable.inc).
.jtext  .CSEG AT PARAM_TABLE

    .DB2    0x0251        ; F800h PRM_BL_MC1
    .DB2    0x0001        ; F802h PAR_VER
    .DB2    0x045B        ; F804h BBC_VENDOR_ID
    .DB2    0x0251        ; F806h BBC_PRODUCT_ID
    .DB2    0x0100        ; F808h BBC_BCD_DEVICE
    .DB     0x01          ; F80Ah BBC_OPTION
    .DB     0x32          ; F80Bh BBC_MAX_POWER
    .DB4    0xFD5D326C    ; F80Ch BBC_CONTAINER_UUID_0
    .DB4    0x3744CC7A    ; F810h BBC_CONTAINER_UUID_1
    .DB4    0x5B150CBA    ; F814h BBC_CONTAINER_UUID_2
    .DB4    0x3EBAB9E2    ; F818h BBC_CONTAINER_UUID_3
    .DB     0x04          ; F81Ch BBC_NUM_ALT_MODE
    .DB     0x03          ; F81Dh BBC_PREFERRED_ALT_MODE
    .DB     0x80          ; F81Eh BBC_VCONN_POWER
    .DB     0x00          ; F81Fh 
    .DB2    0xFF01        ; F820h BBC_SVID_0
    .DB2    0x4507        ; F822h BBC_SVID_1
    .DB2    0xFDF5        ; F824h BBC_SVID_2
    .DB2    0xBF14        ; F826h BBC_SVID_3
    .DB     0x01          ; F828h BBC_ALT_MODE_0
    .DB     0x02          ; F829h BBC_ALT_MODE_1
    .DB     0x03          ; F82Ah BBC_ALT_MODE_2
    .DB     0x04          ; F82Bh BBC_ALT_MODE_3
    .DB4    0x3782CCD7    ; F82Ch BBC_ALT_MODE_VDO_0
    .DB4    0x7B4E7EE9    ; F830h BBC_ALT_MODE_VDO_1
    .DB4    0x1CE7D8DA    ; F834h BBC_ALT_MODE_VDO_2
    .DB4    0x93247858    ; F838h BBC_ALT_MODE_VDO_3
    .DB2    0x03FF        ; F83Ch BBC_STR_DESCS_VALID
    .DB4    0x6E655213    ; F83Eh BBC_STR_AREA_00H
    .DB4    0x73617365    ; F842h BBC_STR_AREA_04H
    .DB4    0x656C4520    ; F846h BBC_STR_AREA_08H
    .DB4    0x6F727463    ; F84Ah BBC_STR_AREA_0CH
    .DB4    0x7363696E    ; F84Eh BBC_STR_AREA_10H
    .DB4    0x6E65521C    ; F852h BBC_STR_AREA_14H
    .DB4    0x73617365    ; F856h BBC_STR_AREA_18H
    .DB4    0x42535520    ; F85Ah BBC_STR_AREA_1CH
    .DB4    0x6C694220    ; F85Eh BBC_STR_AREA_20H
    .DB4    0x616F626C    ; F862h BBC_STR_AREA_24H
    .DB4    0x44206472    ; F866h BBC_STR_AREA_28H
    .DB4    0x63697665    ; F86Ah BBC_STR_AREA_2CH
    .DB4    0x30301065    ; F86Eh BBC_STR_AREA_30H
    .DB4    0x30303030    ; F872h BBC_STR_AREA_34H
    .DB4    0x30303030    ; F876h BBC_STR_AREA_38H
    .DB4    0x30303030    ; F87Ah BBC_STR_AREA_3CH
    .DB4    0x42173030    ; F87Eh BBC_STR_AREA_40H
    .DB4    0x626C6C69    ; F882h BBC_STR_AREA_44H
    .DB4    0x6472616F    ; F886h BBC_STR_AREA_48H
    .DB4    0x6E6F6320    ; F88Ah BBC_STR_AREA_4CH
    .DB4    0x75676966    ; F88Eh BBC_STR_AREA_50H
    .DB4    0x69746172    ; F892h BBC_STR_AREA_54H
    .DB4    0x42136E6F    ; F896h BBC_STR_AREA_58H
    .DB4    0x626C6C69    ; F89Ah BBC_STR_AREA_5CH
    .DB4    0x6472616F    ; F89Eh BBC_STR_AREA_60H
    .DB4    0x746E6920    ; F8A2h BBC_STR_AREA_64H
    .DB4    0x61667265    ; F8A6h BBC_STR_AREA_68H
    .DB4    0x68226563    ; F8AAh BBC_STR_AREA_6CH
    .DB4    0x3A707474    ; F8AEh BBC_STR_AREA_70H
    .DB4    0x77772F2F    ; F8B2h BBC_STR_AREA_74H
    .DB4    0x65762E77    ; F8B6h BBC_STR_AREA_78H
    .DB4    0x6F2E6173    ; F8BAh BBC_STR_AREA_7CH
    .DB4    0x642F6772    ; F8BEh BBC_STR_AREA_80H
    .DB4    0x73752D70    ; F8C2h BBC_STR_AREA_84H
    .DB4    0x79742D62    ; F8C6h BBC_STR_AREA_88H
    .DB4    0x632D6570    ; F8CAh BBC_STR_AREA_8CH
    .DB4    0x69440C2F    ; F8CEh BBC_STR_AREA_90H
    .DB4    0x616C7073    ; F8D2h BBC_STR_AREA_94H
    .DB4    0x6F502079    ; F8D6h BBC_STR_AREA_98H
    .DB4    0x41087472    ; F8DAh BBC_STR_AREA_9CH
    .DB4    0x6F4D746C    ; F8DEh BBC_STR_AREA_A0H
    .DB4    0x08316564    ; F8E2h BBC_STR_AREA_A4H
    .DB4    0x4D746C41    ; F8E6h BBC_STR_AREA_A8H
    .DB4    0x3265646F    ; F8EAh BBC_STR_AREA_ACH
    .DB4    0x746C4108    ; F8EEh BBC_STR_AREA_B0H
    .DB4    0x65646F4D    ; F8F2h BBC_STR_AREA_B4H
    .DB4    0x00000033    ; F8F6h BBC_STR_AREA_B8H
    .DB4    0x00000000    ; F8FAh BBC_STR_AREA_BCH
    .DB4    0x00000000    ; F8FEh BBC_STR_AREA_C0H
    .DB4    0x00000000    ; F902h BBC_STR_AREA_C4H
    .DB4    0x00000000    ; F906h BBC_STR_AREA_C8H
    .DB4    0x00000000    ; F90Ah BBC_STR_AREA_CCH
    .DB4    0x00000000    ; F90Eh BBC_STR_AREA_D0H
    .DB4    0x00000000    ; F912h BBC_STR_AREA_D4H
    .DB4    0x00000000    ; F916h BBC_STR_AREA_D8H
    .DB4    0x00000000    ; F91Ah BBC_STR_AREA_DCH
    .DB4    0x00000000    ; F91Eh BBC_STR_AREA_E0H
    .DB4    0x00000000    ; F922h BBC_STR_AREA_E4H
    .DB4    0x00000000    ; F926h BBC_STR_AREA_E8H
    .DB4    0x00000000    ; F92Ah BBC_STR_AREA_ECH
    .DB4    0x00000000    ; F92Eh BBC_STR_AREA_F0H
    .DB4    0x00000000    ; F932h BBC_STR_AREA_F4H
    .DB4    0x00000000    ; F936h BBC_STR_AREA_F8H
    .DB4    0x00000000    ; F93Ah BBC_STR_AREA_FCH
    .DB2    0x0000        ; F93Eh 
    .DB4    0x00000000    ; F940h 
    .DB4    0x00000000    ; F944h 
    .DB4    0x00000000    ; F948h 
    .DB4    0x00000000    ; F94Ch 
    .DB4    0x00000000    ; F950h 
    .DB4    0x00000000    ; F954h 
    .DB4    0x00000000    ; F958h 
    .DB4    0x00000000    ; F95Ch 
    .DB4    0x00000000    ; F960h 
    .DB4    0x00000000    ; F964h 
    .DB4    0x00000000    ; F968h 
    .DB4    0x00000000    ; F96Ch 
    .DB4    0x00000000    ; F970h 
    .DB4    0x00000000    ; F974h 
    .DB4    0x00000000    ; F978h 
    .DB4    0x00000000    ; F97Ch 
    .DB4    0x00000000    ; F980h 
    .DB4    0x00000000    ; F984h 
    .DB4    0x00000000    ; F988h 
    .DB4    0x00000000    ; F98Ch 
    .DB4    0x00000000    ; F990h 
    .DB4    0x00000000    ; F994h 
    .DB4    0x00000000    ; F998h 
    .DB4    0x00000000    ; F99Ch 
    .DB4    0x00000000    ; F9A0h 
    .DB4    0x00000000    ; F9A4h 
    .DB4    0x00000000    ; F9A8h 
    .DB4    0x00000000    ; F9ACh 
    .DB4    0x00000000    ; F9B0h 
    .DB4    0x00000000    ; F9B4h 
    .DB4    0x00000000    ; F9B8h 
    .DB4    0x00000000    ; F9BCh 
    .DB4    0x00000000    ; F9C0h 
    .DB4    0x00000000    ; F9C4h 
    .DB4    0x00000000    ; F9C8h 
    .DB4    0x00000000    ; F9CCh 
    .DB4    0x00000000    ; F9D0h 
    .DB4    0x00000000    ; F9D4h 
    .DB4    0x00000000    ; F9D8h 
    .DB4    0x00000000    ; F9DCh 
    .DB4    0x00000000    ; F9E0h 
    .DB4    0x00000000    ; F9E4h 
    .DB4    0x00000000    ; F9E8h 
    .DB4    0x00000000    ; F9ECh 
    .DB4    0x00000000    ; F9F0h 
    .DB4    0x00000000    ; F9F4h 
    .DB4    0x00000000    ; F9F8h 
    .DB4    0x00000000    ; F9FCh 
    .DB4    0x00000000    ; FA00h 
    .DB4    0x00000000    ; FA04h 
    .DB4    0x00000000    ; FA08h 
    .DB4    0x00000000    ; FA0Ch 
    .DB4    0x00000000    ; FA10h 
    .DB4    0x00000000    ; FA14h 
    .DB4    0x00000000    ; FA18h 
    .DB4    0x00000000    ; FA1Ch 
    .DB4    0x00000000    ; FA20h 
    .DB4    0x00000000    ; FA24h 
    .DB4    0x00000000    ; FA28h 
    .DB4    0x00000000    ; FA2Ch 
    .DB4    0x00000000    ; FA30h 
    .DB4    0x00000000    ; FA34h 
    .DB4    0x00000000    ; FA38h 
    .DB4    0x00000000    ; FA3Ch 
    .DB4    0x00000000    ; FA40h 
    .DB4    0x00000000    ; FA44h 
    .DB4    0x00000000    ; FA48h 
    .DB4    0x00000000    ; FA4Ch 
    .DB4    0x00000000    ; FA50h 
    .DB4    0x00000000    ; FA54h 
    .DB4    0x00000000    ; FA58h 
    .DB4    0x00000000    ; FA5Ch 
    .DB4    0x00000000    ; FA60h 
    .DB4    0x00000000    ; FA64h 
    .DB4    0x00000000    ; FA68h 
    .DB4    0x00000000    ; FA6Ch 
    .DB4    0x00000000    ; FA70h 
    .DB4    0x00000000    ; FA74h 
    .DB4    0x00000000    ; FA78h 
    .DB4    0x00000000    ; FA7Ch 
    .DB4    0x00000000    ; FA80h 
    .DB4    0x00000000    ; FA84h 
    .DB4    0x00000000    ; FA88h 
    .DB4    0x00000000    ; FA8Ch 
    .DB4    0x00000000    ; FA90h 
    .DB4    0x00000000    ; FA94h 
    .DB4    0x00000000    ; FA98h 
    .DB4    0x00000000    ; FA9Ch 
    .DB4    0x00000000    ; FAA0h 
    .DB4    0x00000000    ; FAA4h 
    .DB4    0x00000000    ; FAA8h 
    .DB4    0x00000000    ; FAACh 
    .DB4    0x00000000    ; FAB0h 
    .DB4    0x00000000    ; FAB4h 
    .DB4    0x00000000    ; FAB8h 
    .DB4    0x00000000    ; FABCh 
    .DB4    0x00000000    ; FAC0h 
    .DB4    0x00000000    ; FAC4h 
    .DB4    0x00000000    ; FAC8h 
    .DB4    0x00000000    ; FACCh 
    .DB4    0x00000000    ; FAD0h 
    .DB4    0x00000000    ; FAD4h 
    .DB4    0x00000000    ; FAD8h 
    .DB4    0x00000000    ; FADCh 
    .DB4    0x00000000    ; FAE0h 
    .DB4    0x00000000    ; FAE4h 
    .DB4    0x00000000    ; FAE8h 
    .DB4    0x00000000    ; FAECh 
    .DB4    0x00000000    ; FAF0h 
    .DB4    0x00000000    ; FAF4h 
    .DB4    0x00000000    ; FAF8h 
    .DB4    0x00000000    ; FAFCh 
    .DB4    0x00000000    ; FB00h 
    .DB4    0x00000000    ; FB04h 
    .DB4    0x00000000    ; FB08h 
    .DB4    0x00000000    ; FB0Ch 
    .DB4    0x00000000    ; FB10h 
    .DB4    0x00000000    ; FB14h 
    .DB4    0x00000000    ; FB18h 
    .DB4    0x00000000    ; FB1Ch 
    .DB4    0x00000000    ; FB20h 
    .DB4    0x00000000    ; FB24h 
    .DB4    0x00000000    ; FB28h 
    .DB4    0x00000000    ; FB2Ch 
    .DB4    0x00000000    ; FB30h 
    .DB4    0x00000000    ; FB34h 
    .DB4    0x00000000    ; FB38h 
    .DB4    0x00000000    ; FB3Ch 
    .DB4    0x00000000    ; FB40h 
    .DB4    0x00000000    ; FB44h 
    .DB4    0x00000000    ; FB48h 
    .DB4    0x00000000    ; FB4Ch 
    .DB4    0x00000000    ; FB50h 
    .DB4    0x00000000    ; FB54h 
    .DB4    0x00000000    ; FB58h 
    .DB4    0x00000000    ; FB5Ch 
    .DB4    0x00000000    ; FB60h 
    .DB4    0x00000000    ; FB64h 
    .DB4    0x00000000    ; FB68h 
    .DB4    0x00000000    ; FB6Ch 
    .DB4    0x00000000    ; FB70h 
    .DB4    0x00000000    ; FB74h 
    .DB4    0x00000000    ; FB78h 
    .DB4    0x00000000    ; FB7Ch 
    .DB4    0x00000000    ; FB80h 
    .DB4    0x00000000    ; FB84h 
    .DB4    0x00000000    ; FB88h 
    .DB4    0x00000000    ; FB8Ch 
    .DB4    0x00000000    ; FB90h 
    .DB4    0x00000000    ; FB94h 
    .DB4    0x00000000    ; FB98h 
    .DB4    0x00000000    ; FB9Ch 
    .DB4    0x00000000    ; FBA0h 
    .DB4    0x00000000    ; FBA4h 
    .DB4    0x00000000    ; FBA8h 
    .DB4    0x00000000    ; FBACh 
    .DB4    0x00000000    ; FBB0h 
    .DB4    0x00000000    ; FBB4h 
    .DB4    0x00000000    ; FBB8h 
    .DB4    0x00000000    ; FBBCh 
    .DB4    0x00000000    ; FBC0h 
    .DB4    0x00000000    ; FBC4h 
    .DB4    0x00000000    ; FBC8h 
    .DB4    0x00000000    ; FBCCh 
    .DB4    0x00000000    ; FBD0h 
    .DB4    0x00000000    ; FBD4h 
    .DB4    0x00000000    ; FBD8h 
    .DB4    0x00000000    ; FBDCh 
    .DB4    0x00000000    ; FBE0h 
    .DB4    0x00000000    ; FBE4h 
    .DB4    0x00000000    ; FBE8h 
    .DB4    0x00000000    ; FBECh 
    .DB4    0x00000000    ; FBF0h 
    .DB4    0x00000000    ; FBF4h 
    .DB4    0x00000000    ; FBF8h 
    .DB2    0x0251        ; FBFCh PRM_BL_MC2
    .DB2    0xDE52        ; FBFEh PARAM_CRC

;****************************************************************************
; FILE NAME:    pd_param.asm
;***************************************************************************/

