; GEOS Icons handler

.include "const.i"
.include "geossym.i"
.include "geosmac.i"
.include "kernal.i"
.import Ddec, DShiftLeft, _Sleep, MenuDoInvert, CallRoutine, _BitmapUp, _StartMouseMode, ResetMseRegion
.global CalcIconDescTab, ProcessClick, _DoIcons

.segment "icon"

_DoIcons:
	MoveW r0, IconDescVec
	jsr Icons_1
	jsr ResetMseRegion
	lda mouseOn
	and #SET_MSE_ON
	bne DoIcons1
	lda mouseOn
	and #%10111111
	sta mouseOn
DoIcons1:
	lda mouseOn
	ora #SET_ICONSON
	sta mouseOn
	ldy #1
	lda (IconDescVec),y
	sta r11L
	iny
	lda (IconDescVec),y
	sta r11H
	iny
	lda (IconDescVec),y
	tay
	sec
	jmp _StartMouseMode

CalcIconDescTab:
	asl
	asl
	asl
	clc
	adc #4
	tay
	rts

Icons_1:
	LoadB r10L, NULL
Icons_10:
	lda r10L
	jsr CalcIconDescTab
	ldx #0
Icons_11:
	lda (IconDescVec),y
	sta r0,x
	iny
	inx
	cpx #6
	bne Icons_11
	lda r0L
	ora r0H
	beq Icons_12
	jsr _BitmapUp
Icons_12:
	inc r10L
	lda r10L
	ldy #0
	cmp (IconDescVec),y
	bne Icons_10
Icons_13:
	rts

ProcessClick:
	lda IconDescVecH
	beq ProcClk1
	jsr FindClkIcon
	bcs ProcClk2
ProcClk1:
	lda otherPressVec
	ldx otherPressVec+1
	jmp CallRoutine
ProcClk2:
	lda clkBoxTemp
	bne Icons_13
	lda r0L
	sta clkBoxTemp2
	sty clkBoxTemp
	lda #%11000000
	bit iconSelFlg
	beq ProcClk5
	bmi ProcClk3
	bvs ProcClk4
ProcClk3:
	jsr CalcIconCoords
	jsr MenuDoInvert
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	MoveB clkBoxTemp2, r0L
	ldy clkBoxTemp
ProcClk4:
	jsr CalcIconCoords
	jsr MenuDoInvert
ProcClk5:
	ldy #$1e
	ldx #0
	lda dblClickCount
	beq ProcClk6
	ldx #$ff
	ldy #0
ProcClk6:
	sty dblClickCount
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
	jmp CallRoutine

FindClkIcon:
	LoadB r0L, NULL
FndClkIcn1:
	lda r0L
	jsr CalcIconDescTab
	lda (IconDescVec),y
	iny
	ora (IconDescVec),y
	beq FndClkIcn2
	iny
	lda mouseXPos+1
	lsr
	lda mouseXPos
	ror
	lsr
	lsr
	sec
	sbc (IconDescVec),y
	bcc FndClkIcn2
	iny
	iny
	cmp (IconDescVec),y
	bcs FndClkIcn2
	dey
	lda mouseYPos
	sec
	sbc (IconDescVec),y
	bcc FndClkIcn2
	iny
	iny
	cmp (IconDescVec),y
	bcc FndClkIcn3
FndClkIcn2:
	inc r0L
	lda r0L
	ldy #0
	cmp (IconDescVec),y
	bne FndClkIcn1
	clc
	rts
FndClkIcn3:
	sec
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
	sta r3L
	iny
	iny
	clc
	adc (IconDescVec),y
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
	jmp Ddec
