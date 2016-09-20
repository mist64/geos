; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Serial number

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global SerialNumber

.segment "serial1"

SerialNumber:
.ifdef wheels
	.word $DF96
.else
.ifdef bsw128
	; This matches the serial in the cbmfiles.com GEOS128.D64
	.word $FD8D
.else
	; This matches the serial in the cbmfiles.com GEOS64.D64
	.word $58B5
.endif
.endif

.ifndef wheels_size
	.byte $FF ; ???
.endif

