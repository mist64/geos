; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Machine initialization

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global UNK_6

.segment "init3"

.ifndef wheels
UNK_6:
	lda #$bf
	sta A8FF0
	ldx #7
	lda #$bb
@1:	sta A8FE8,x
	dex
	bpl @1
	rts
.endif

