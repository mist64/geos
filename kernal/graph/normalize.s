; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: NormalizeX (480px width)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _NormalizeX

.segment "graph5"

_NormalizeX:
	lda zpage+1,x
	bpl @2
	rol
	bmi @4
	ror
	bbrf 7, graphMode, @1
	add #$60
	rol zpage,x
	rol
@1:	and #%00011111
	sta zpage+1,x
	rts
@2:	rol
	bpl @4
	ror
	bbrf 7, graphMode, @3
	sec
	adc #$A0
	rol zpage,x
	rol
@3:	ora #$E0
	sta zpage+1,x
@4:	rts
