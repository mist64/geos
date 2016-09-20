; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Set CBM KERNAL vectors

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global Init_KRNLVec

.segment "hw2"

.if !.defined(wheels) && (!.defined(removeToBASIC))
Init_KRNLVec:
	ldx #32
@1:	lda KERNALVecTab-1,x
	sta irqvec-1,x
	dex
	bne @1
	rts
.endif

