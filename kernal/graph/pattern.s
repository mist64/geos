; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: SetPattern syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import PatternTab

.global _SetPattern

.segment "graph2l2"

;---------------------------------------------------------------
; SetPattern                                              $C139
;
; Pass:      a pattern nbr (0-33)
; Return:    currentPattern - updated
; Destroyed: a
;---------------------------------------------------------------
_SetPattern:
	asl
	asl
	asl
.ifdef wheels
	.assert <PatternTab = 0, error, "PatternTab must be page-aligned!"
.else
	adc #<PatternTab
.endif
	sta curPattern
	lda #0
	adc #>PatternTab
	sta curPattern+1
	rts

