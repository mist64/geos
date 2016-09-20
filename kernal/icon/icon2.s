; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Icons: callback

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _Sleep
.import MenuDoInvert
.import clkBoxTemp2
.import clkBoxTemp
.import _BitmapUp

.import Ddec
.import DShiftLeft
.import CallRoutine

.global CalcIconDescTab
.global Icons_1
.global ProcessClick

.segment "icon2"

CalcIconDescTab:
	asl
	asl
	asl
	add #4
	tay
	rts

Icons_1:
	LoadB r10L, NULL
@1:
.ifndef wheels_size_and_speed
	lda r10L
.endif
	jsr CalcIconDescTab
	ldx #0
@2:	lda (IconDescVec),y
	sta r0,x
	iny
	inx
	cpx #6
	bne @2
	lda r0L
	ora r0H
	beq @3
	jsr _BitmapUp
@3:	inc r10L
	lda r10L
	ldy #0
	cmp (IconDescVec),y
	bne @1
	rts

;---------------------------------------------------------------
; called by mouse
;---------------------------------------------------------------
ProcessClick:
.ifndef bsw128
	lda IconDescVecH
	beq @1
.endif
	jsr FindClkIcon
	bcs @2
@1:	lda otherPressVec
	ldx otherPressVec+1
	jmp CallRoutine
@2:	lda clkBoxTemp
	bne @7
	lda r0L
	sta clkBoxTemp2
	sty clkBoxTemp
	lda #%11000000
	bit iconSelFlg
	beq @5
	bmi @3
	bvs @4
@3:	jsr CalcIconCoords
	jsr MenuDoInvert
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	MoveB clkBoxTemp2, r0L
	ldy clkBoxTemp
@4:	jsr CalcIconCoords
	jsr MenuDoInvert
@5:	ldy #$1e
	ldx #0
	lda dblClickCount
	beq @6
	ldx #$ff
	ldy #0
@6:	sty dblClickCount
	stx r0H
	MoveB clkBoxTemp2, r0L
	ldy clkBoxTemp
	ldx #0
	stx clkBoxTemp
	iny
	iny
	lda (IconDescVec),y
	tax
	dey
	lda (IconDescVec),y
	jsr CallRoutine
@7:	rts

FindClkIcon:
	LoadB r0L, NULL
@1:
.ifndef wheels_size_and_speed
	lda r0L
.endif
	jsr CalcIconDescTab
	lda (IconDescVec),y
	iny
	ora (IconDescVec),y
	beq @2
	iny
	lda mouseXPos+1
	lsr
.ifdef bsw128
	sta L888F
.endif
	lda mouseXPos
	ror
.ifdef bsw128
	lsr L888F
	ror
.else
	lsr
.endif
	lsr
.ifdef bsw128
	pha
	lda (IconDescVec),y
	jsr LFCCC
	sta L888F
	pla
.endif
	sec
.ifdef bsw128
	sbc L888F
.else
	sbc (IconDescVec),y
.endif
	bcc @2
	iny
	iny
.ifdef bsw128
	pha
	lda (IconDescVec),y
	jsr LFCCC
	sta L888F
	pla
	cmp L888F
.else
	cmp (IconDescVec),y
.endif
	bcs @2
	dey
	lda mouseYPos
	sec
	sbc (IconDescVec),y
	bcc @2
	iny
	iny
	cmp (IconDescVec),y
	bcc @3
@2:	inc r0L
	lda r0L
	ldy #0
	cmp (IconDescVec),y
	bne @1
	clc
	rts
@3:	sec
	rts

CalcIconCoords:
	lda (IconDescVec),y
	dey
	dey
	clc
	adc (IconDescVec),y
	subv 1
	sta r2H
	lda (IconDescVec),y
	sta r2L
	dey
	lda (IconDescVec),y
.ifdef bsw128
        jsr LFCCC
.endif
	sta r3L
	iny
	iny
.ifdef bsw128
	lda (IconDescVec),y
        jsr LFCCC
.endif
	clc
.ifdef bsw128
	adc r3L
.else
	adc (IconDescVec),y
.endif
	sta r4L
	LoadB r3H, 0
	sta r4H
	ldy #3
	ldx #r3
	jsr DShiftLeft
	ldy #3
	ldx #r4
	jsr DShiftLeft
	ldx #r4
.ifdef wheels_size_and_speed
	jmp Ddec
.else
	jsr Ddec
	rts
.endif

.ifdef bsw128
LFCCC:	pha
	and #DOUBLE_B
	bpl @1
	pla
	bbsf 7, graphMode, @2
	and #%01111111
	bne @3
@2:	asl
@3:	rts
@1:	pla
	rts
.endif

