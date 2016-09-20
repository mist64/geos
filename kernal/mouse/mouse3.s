; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global RcvrMnu0
.global ResetMseRegion

.segment "mouse3"

.ifndef wheels
ResetMseRegion:
	lda #NULL
	sta mouseLeft
	sta mouseLeft+1
	sta mouseTop
.ifdef bsw128
	LoadB mouseBottom, SC_PIX_HEIGHT-1
	bbsf 7, graphMode, @2
	LoadW mouseRight, SC_PIX_WIDTH-1
	bbrf 7, graphMode, @1
	LoadW mouseRight, SCREENPIXELWIDTH-1
@1:	rts
@2:	LoadW mouseRight, SCREENPIXELWIDTH-1
.else
	LoadW mouseRight, SC_PIX_WIDTH-1
	LoadB mouseBottom, SC_PIX_HEIGHT-1
.endif
	rts
.endif

