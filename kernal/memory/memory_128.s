; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; Memory utility functions: C128 MoveData

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global MoveDataCore

.segment "memory_128"

; This is the core of MoveData. On the C128, MoveData
; calls into this.
; TODO: dedup
MoveDataCore:
	CmpW r0, r1
	bcs @2 ; XXX redundant
	bcc @6
@2:	ldy #0
	lda r2H
	beq @4
@3:	lda (r0),y
	sta (r1),y
	iny
	bne @3
	inc r0H
	inc r1H
	dec r2H
	bne @3
@4:	cpy r2L
	beq @5
	lda (r0),y
	sta (r1),y
	iny
	bra @4
@5:	rts
@6:	clc
	lda r2H
	adc r0H
	sta r0H
	clc
	lda r2H
	adc r1H
	sta r1H
	ldy r2L
	beq @8
@7:	dey
	lda (r0),y
	sta (r1),y
	tya
	bne @7
@8:	dec r0H
	dec r1H
	lda r2H
	beq @5
@9:	dey
	lda (r0),y
	sta (r1),y
	tya
	bne @9
	dec r2H
	bra @8
