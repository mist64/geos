; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej 'YTM/Elysium' Witkowiak; Michael Steil
;
; Serial number

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"

.global SerialNumber
.global _GetSerialNumber
.global GetSerialNumber2

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
GetSerialNumber2:
	lda SerialNumber+1
	sta r0H
	rts

	.byte 1, $60 ; ???
