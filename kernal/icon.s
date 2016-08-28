; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Icons

.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "jumptab.inc"

; graph.s
.import _BitmapUp

; menu.s
.import MenuDoInvert

; mouse.s
.import _StartMouseMode
.import ResetMseRegion

; process.s
.import _Sleep

; var.s
.import clkBoxTemp2
.import clkBoxTemp

; used by dlgbox
.global CalcIconDescTab

; used by mouse
.global ProcessClick

; syscall
.global _DoIcons

.segment "icon1"

;---------------------------------------------------------------
; DoIcons                                                 $C15A
;
; Function:  Draw and turn on icons as defined in an Icon Table.
;
; Pass:      r0 ptr to icon table
; Return:    nothing
; Destroyed: a, x, y, r0 - r11
;    ex: .byte nbr_icons
;        .word x mouse
;        .byte y mouse
;
;        .word icon1Pic
;        .byte x,y,w,h
;        .word DoIcon1 .etc...
;---------------------------------------------------------------
_DoIcons:
	MoveW r0, IconDescVec
	jsr Icons_1
	jsr ResetMseRegion
	lda mouseOn
.if wheels
	bmi @1
.else
	and #SET_MSE_ON
	bne @1
	lda mouseOn
.endif
	and #%10111111
	sta mouseOn
@1:
.if !wheels
	lda mouseOn
.endif
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

.segment "icon2"

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
@1:
.if !wheels
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
	lda IconDescVecH
	beq @1
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
	jsr $EFED;xxxMenuDoInvert
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	MoveB clkBoxTemp2, r0L
	ldy clkBoxTemp
@4:	jsr CalcIconCoords
	jsr $EFED;xxxMenuDoInvert
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
.if !wheels
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
	lda mouseXPos
	ror
	lsr
	lsr
	sec
	sbc (IconDescVec),y
	bcc @2
	iny
	iny
	cmp (IconDescVec),y
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
.if wheels
	jmp Ddec
.else
	jsr Ddec
	rts
.endif
