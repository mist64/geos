; GEOS KERNAL
;
; Serial number

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"

.global SerialNumber
.global _GetSerialNumber
.global _GetSerialNumber2

.segment "serial1"

SerialNumber:
.ifdef maurice
	.word $58B5
.else
	.word $8F5E
.endif

    .byte $FF ; ???

.segment "serial2"

;---------------------------------------------------------------
; GetSerialNumber                                         $C196
;
; Pass:      nothing
; Return:    r0  serial nbr of your kernal
; Destroyed: a
;---------------------------------------------------------------
_GetSerialNumber:
	lda SerialNumber
	sta r0L
_GetSerialNumber2:
	lda SerialNumber+1
	sta r0H
	rts

	.byte 1, $60 ; ???
