; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse: IsMseInRegion syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import NormalizeX

.global _IsMseInRegion

.segment "mouse1"

_IsMseInRegion:
.ifdef bsw128
	txa
	pha
	ldx #r3
	jsr NormalizeX
	ldx #r4
	jsr NormalizeX
	pla
	tax
.endif
	lda mouseYPos
	cmp r2L
	bcc @5
	cmp r2H
	beq @1
	bcs @5
@1:	lda mouseXPos+1
	cmp r3H
	bne @2
	lda mouseXPos
	cmp r3L
@2:	bcc @5
	lda mouseXPos+1
	cmp r4H
	bne @3
	lda mouseXPos
	cmp r4L
@3:	beq @4
	bcs @5
@4:	lda #$ff
	rts
@5:	lda #0
	rts

