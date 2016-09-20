; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: DoDlgBox syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _UseSystemFont
.import dlgBoxCallerSP
.import dlgBoxCallerPC
.import defIconTab
.import DlgBoxProcH
.import DlgBoxProcL
.import _StartMouseMode
.import DrawDlgBox
.import DlgBoxPrep

.import MainLoop
.import DoIcons
.import CallRoutine
.import TempHideMouse

.global _DoDlgBox

.segment "dlgbox1a"

_DoDlgBox:
	MoveW r0, DBoxDesc
	ldx #0
@1:	lda r5L,x
	pha
	inx
	cpx #12
	bne @1
.ifdef bsw128
	jsr TempHideMouse
.endif
	jsr DlgBoxPrep
	jsr DrawDlgBox
.ifdef wheels_size_and_speed ; duplicate LDA #0
	lda #0
	sta r11H
	sta r11L
.else
	LoadW__ r11, 0
.endif
	jsr _StartMouseMode
	jsr _UseSystemFont
	ldx #11
@2:	pla
	sta r5L,x
	dex
	bpl @2
	ldy #0
	ldx #7
	lda (DBoxDesc),y
	bpl @3
	ldx #1
@3:	txa
	tay
@4:	lda (DBoxDesc),y
	sta r0L
	beq @7
	ldx #0
@5:	lda r5L,x
	pha
	inx
	cpx #12
	bne @5
	iny
	sty r1L
	ldy r0L
	lda DlgBoxProcL-1,y
	ldx DlgBoxProcH-1,y
	jsr CallRoutine
	ldx #11
@6:	pla
	sta r5L,x
	dex
	bpl @6
	ldy r1L
	bra @4
@7:	lda defIconTab
	beq @8
	LoadW r0, defIconTab
	jsr DoIcons
@8:	PopW dlgBoxCallerPC
	tsx
	stx dlgBoxCallerSP
	jmp MainLoop

