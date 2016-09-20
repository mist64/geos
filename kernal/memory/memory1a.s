; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Memory utility functions: FillRam, ClearRam

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _FillRam
.global _ClearRam

.segment "memory1a"

;---------------------------------------------------------------
; ClearRam                                                $C178
;
; Pass:      r0  nbr of bytes to clear
;            r1  address to start
; Return:    section fill with 0's
; Destroyed: a, y, r0, r1, r2l
;---------------------------------------------------------------
_ClearRam:
	LoadB r2L, NULL
;---------------------------------------------------------------
; FillRam                                                 $C17B
;
; Pass:      r0  nbr of bytes to clear
;            r1  address of first byte
;            r2L value of byte to store in
; Return:    area filled in
; Destroyed: a, y, r0 - r2l
;---------------------------------------------------------------
_FillRam:
	lda r0H
	beq @2
	lda r2L
	ldy #0
@1:	sta (r1),Y
	dey
	bne @1
	inc r1H
	dec r0H
	bne @1
@2:	lda r2L
	ldy r0L
	beq @4
	dey
@3:	sta (r1),Y
	dey
	cpy #$FF
	bne @3
@4:	rts

