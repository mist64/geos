; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
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
	; This matches the serial in the cbmfiles.com GEOS64.D64
	.word $58B5

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
