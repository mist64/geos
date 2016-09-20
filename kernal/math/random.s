; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: GetRandom syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _GetRandom

.segment "math1d"

;---------------------------------------------------------------
; GetRandom                                               $C187
;
; Function:  Get 16 bit pseudorandom number.
;
; Pass:      nothing
; Return:    ramdom - contains new 16 bit nbr
; Destroyed: a
;---------------------------------------------------------------
_GetRandom:
	inc random
	bne @1
	inc random+1
@1:	asl random
	rol random+1
	bcc @3
	clc
	lda #$0F
	adc random
	sta random
	bcc @2
	inc random+1
@2:	rts
@3:
.ifdef wheels
	CmpBI random+1, $f1
.else
	CmpBI random+1, $ff
.endif
	bcc @4
	lda random
.ifdef wheels
	sbc #$f1
.else
	subv $f1
.endif
	bcc @4
	sta random
	lda #0
	sta random+1
@4:	rts

