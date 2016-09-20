; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Core VDC access logic

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global InitVDC
.global GetVDCRegister
.global SetVDCRegister

.segment "vdc_base"

SetVDCRegister:
	stx vdcreg
@1:	bit vdcreg
	bpl @1
	sta vdcdata
	rts

GetVDCRegister:
	stx vdcreg
@1:	bit vdcreg
	bpl @1
	lda vdcdata
	rts
