; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: DShiftLeft syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.ifdef wheels
.import BBMult_ret
.endif

.global _DShiftLeft

.segment "math1a1"

;---------------------------------------------------------------
; DShiftLeft                                              $C15D
;
; Function:  Arithmetically shift operand left n bits. Computes
;            operand * 2^n
;
; Pass:      x   add of zpage Reg
;            y   nbr of bits to shift left
; Return:    (x) Reg pointed by x is shifted
; Destroyed: y
;---------------------------------------------------------------
_DShiftLeft:
	dey
.ifdef wheels
.if 0 ; XXX cc65 issue: branch can't cross segment
	bmi BBMult_ret
.else
	.byte $30, <(BBMult_ret - (* + 1))
.endif
.else
	bmi @1
.endif
	asl zpage,x
	rol zpage+1,x
	jmp _DShiftLeft
.ifndef wheels
@1:	rts
.endif
