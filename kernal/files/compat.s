; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Check app compatibility

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global CheckAppCompat

.segment "compat"

CheckAppCompat:
	bbsf 7, graphMode, @2 ; 80 col
	bit fileHeader+O_128_FLAGS
	bpl @3 ; ok
@1:	ldx #INCOMPATIBLE
	rts
@2:	bbrf 6, fileHeader+O_128_FLAGS, @1
@3:	ldx #0
	rts
