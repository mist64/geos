; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: GetScanLine syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _GetScanLine

.segment "graph2n"

;---------------------------------------------------------------
; GetScanLine                                             $C13C
;
; Function:  Returns the address of the beginning of a scanline

; Pass:      x   scanline nbr
; Return:    r5  add of 1st byte of foreground scr
;            r6  add of 1st byte of background scr
; Destroyed: a
;---------------------------------------------------------------
_GetScanLine:
.ifdef bsw128
	bbrf 7, graphMode, @X
	jmp GSC80
@X:
.endif
	txa
	pha
.ifndef wheels_size_and_speed
	pha
.endif
	and #%00000111
	sta r6H
.ifdef wheels_size_and_speed
	txa
.else
	pla
.endif
	lsr
	lsr
	lsr
	tax
	bbrf 7, dispBufferOn, @2 ; ST_WR_FORE
.ifdef bsw128
	bvs @1
.else
	bbsf 6, dispBufferOn, @1 ; ST_WR_BACK
.endif
	lda LineTabL,x
	ora r6H
	sta r5L
.ifdef wheels_size_and_speed
	sta r6L
.endif
	lda LineTabH,x
	sta r5H
.ifdef bsw128
	jmp GSC80_6
.else
.ifdef wheels_size_and_speed
	sta r6H
.else
	MoveW r5, r6
.endif
	pla
	tax
	rts
.endif
@1:	lda LineTabL,x
	ora r6H
	sta r5L
	sta r6L
	lda LineTabH,x
	sta r5H
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
	pla
	tax
	rts
@2:
.ifdef bsw128
	bvc @3
.else
	bbrf 6, dispBufferOn, @3 ; ST_WR_BACK
.endif
	lda LineTabL,x
	ora r6H
	sta r6L
.ifdef wheels_size_and_speed
	sta r5L
.endif
	lda LineTabH,x
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
.ifdef bsw128
	jmp GSC80_5
.else
.ifdef wheels_size_and_speed
	sta r5H
.else
	MoveW r6, r5
.endif
	pla
	tax
	rts
.endif
@3:	LoadB r5L, <$AF00
	sta r6L
	LoadB r5H, >$AF00
	sta r6H
	pla
	tax
	rts

.ifdef bsw128
GSC80:
	txa
	pha
	stx r5H
	lda #$00
	lsr r5H
	ror a
	lsr r5H
	ror a
	sta r5L
	ldx r5H
	stx r6L
	lsr r5H
	ror a
	lsr r5H
	ror a
	clc
	adc r5L
	sta r5L
	lda r6L
	adc r5H
	sta r5H
	bbrf 7, dispBufferOn, LF6A6
	bvs @1
	bra GSC80_6
@1:	pla
	tax
LF687:	lda r5H
	add #$60
	sta r6H
	MoveB r5L, r6L
	CmpWI r6, $7f40
	bcc @1
	AddVB $21, r6H
@1:	rts

LF6A6:	bvc GSC80_6
	jsr LF687
GSC80_5:
	lda r6H
	sta r5H
	lda r6L
	sta r5L
	pla
	tax
	rts

GSC80_6:
	lda r5H
	sta r6H
	lda r5L
	sta r6L
	pla
	tax
	rts
.endif

.segment "graph2o"

.define LineTab SCREEN_BASE+0*320, SCREEN_BASE+1*320, SCREEN_BASE+2*320, SCREEN_BASE+3*320, SCREEN_BASE+4*320, SCREEN_BASE+5*320, SCREEN_BASE+6*320, SCREEN_BASE+7*320, SCREEN_BASE+8*320, SCREEN_BASE+9*320, SCREEN_BASE+10*320, SCREEN_BASE+11*320, SCREEN_BASE+12*320, SCREEN_BASE+13*320, SCREEN_BASE+14*320, SCREEN_BASE+15*320, SCREEN_BASE+16*320, SCREEN_BASE+17*320, SCREEN_BASE+18*320, SCREEN_BASE+19*320, SCREEN_BASE+20*320, SCREEN_BASE+21*320, SCREEN_BASE+22*320, SCREEN_BASE+23*320, SCREEN_BASE+24*320
LineTabL:
	.lobytes LineTab
LineTabH:
	.hibytes LineTab

