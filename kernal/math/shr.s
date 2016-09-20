; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
;

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.ifdef wheels
.import BBMult_ret
.endif

.global _DShiftRight

.segment "math1a2"

;---------------------------------------------------------------
;---------------------------------------------------------------
_DShiftRight:
	dey
.ifdef wheels
.ifdef wheels
.if 0 ; XXX cc65 issue: branch can't cross segment
	bmi BBMult_ret
.else
	.byte $30, <(BBMult_ret - (* + 1))
.endif
.else
	bmi @1
.endif
.else
	bmi @1
.endif
	lsr zpage+1,x
	ror zpage,x
	jmp _DShiftRight
.ifndef wheels
@1:	rts
.endif

