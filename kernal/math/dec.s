; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: Ddec syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _Ddec

.segment "math1c2"

;---------------------------------------------------------------
; Ddec                                                    $C175
;
; Function:  Decrements an unsigned word
;
; Pass:      x   add. of zpage contaning the nbr
; Return:    x   zpage: contains the decremented nbr
; Destroyed: a
;---------------------------------------------------------------
_Ddec:
	lda zpage,x
	bne @1
	dec zpage+1,x
@1:	dec zpage,x
	lda zpage,x
	ora zpage+1,x
	rts

