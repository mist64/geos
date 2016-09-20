; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: Dabs, Dnegate syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _Dabs
.global _Dnegate

.segment "math1c1"

;---------------------------------------------------------------
; Dabs                                                    $C16F
;
; Function:  Compute the absolute value of a twos-complement
;            word.
;
; Pass:      x   add. of zpage contaning the nbr
; Return:    x   zpage : contains the absolute value
; Destroyed: a
;---------------------------------------------------------------
_Dabs:
	lda zpage+1,x
	bmi _Dnegate
	rts
;---------------------------------------------------------------
; Dnegate                                                 $C172
;
; Function:  Negate a twos-complement word
;
; Pass:      x   add. of zpage : word
; Return:    destination zpage gets negated
; Destroyed: a, y
;---------------------------------------------------------------
_Dnegate:
	lda zpage+1,x
	eor #$FF
	sta zpage+1,x
	lda zpage,x
	eor #$FF
	sta zpage,x
	inc zpage,x
	bne @1
	inc zpage+1,x
@1:	rts
