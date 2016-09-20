; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Menus: RecoverMenu, RecoverAllMenus syscalls and misc

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import Menu_0
.import DoMenu0
.import _Sleep
.import menuOptionTab
.import _MouseOff
.import menuRight
.import menuLeft
.import menuBottom
.import menuTop
.import GetMenuDesc
.import menuLimitTabL
.import menuLimitTabH
.import menuOptNumber
.import _InvertRectangle
.import _HorizontalLine
.import _VerticalLine

.import Ddec
.import Rectangle
.import SetPattern

.global CopyMenuCoords
.global DrawMenu
.global MenuDoInvert
.global MenuRestoreFont
.global MenuStoreFont
.global Menu_3
.global Menu_4
.global Menu_5
.global RcvrMnu0
.global _RecoverMenu
.global _RecoverAllMenus

.segment "menu3"

Menu_3:
	ldy r10H
	ldx r1H
	bbsf 7, menuOptNumber, @1
	lda r11H
	sta menuLimitTabH,y
	ldx r11L
@1:	txa
	sta menuLimitTabL,y
	rts

Menu_4:
	bcc @1
	bbrf 7, menuOptNumber, @2
.ifdef wheels_size_and_speed
	bmi @3
.else
	bra @3
.endif
@1:	bbrf 7, menuOptNumber, @3
@2:	AddVB 2, r1H
	rts
@3:	AddVW_ 4, r11
	rts

;---------------------------------------------------------------
_RecoverAllMenus:
	jsr GetMenuDesc
	jsr _RecoverMenu
	dec menuNumber
	bpl _RecoverAllMenus
	lda #0
	sta menuNumber
	rts

;---------------------------------------------------------------
_RecoverMenu:
	jsr CopyMenuCoords
RcvrMnu0:
	lda RecoverVector
	ora RecoverVector+1
	bne @1
.ifndef wheels_size_and_speed
	lda #0
.endif
	jsr SetPattern
	jmp Rectangle
@1:	jmp (RecoverVector)

.if ((menuVSeparator | menuHSeparator)<>0)
DrawMenu:
.ifdef wheels
	lda menuOptNumber
	bpl LEFAE
	and #$1F
	subv 1
	beq LEFAE
	sta r2L
	MoveW menuLeft, r3
	MoveW menuRight, r4
LEF9E:	ldx r2L
	lda menuLimitTabL,x
	sta r11L
	lda #$FF
	jsr _HorizontalLine
	dec r2L
	bne LEF9E
LEFAE:	rts
.else
	lda menuOptNumber
	and #%00011111
	subv 1
	beq @5
	sta r2L
	bbsf 7, menuOptNumber, @2
.if (menuVSeparator<>0)
	lda menuTop
	addv 1
	sta r3L
	lda menuBottom
	subv 1
	sta r3H
@1:	ldx r2L
	lda menuLimitTabL,x
	sta r4L
	lda menuLimitTabH,x
	sta r4H
	lda #menuVSeparator
	jsr _VerticalLine
	dec r2L
	bne @1
.endif
.if (menuHSeparator<>0)
	rts
.endif
@2:
.if (menuHSeparator<>0)
	MoveW menuLeft, r3
	inc r3L
	bne @3
	inc r3H
@3:	MoveW menuRight, r4
	ldx #r4
	jsr Ddec
@4:	ldx r2L
	lda menuLimitTabL,x
	sta r11L
	lda #menuHSeparator
	jsr _HorizontalLine
	dec r2L
	bne @4
.endif
@5:	rts
.endif
.endif

CopyMenuCoords:
	ldx #6
@1:	lda menuTop-1,x
	sta r2-1,x
	dex
	bne @1
	rts

Menu_5:
	jsr _MouseOff
	jsr Menu_7
	jsr MenuDoInvert
	lda r9L
	ldx menuNumber
	sta menuOptionTab,x
	jsr Menu_8
	bbsf 7, r1L, Menu_52
.ifdef wheels
	bvc LEFE4
	jsr LEFE4
	lda r0L
	ora r0H
	bne Menu_52
	rts
Menu_52:
	inc menuNumber
	jmp DoMenu0
LEFE4:  ldx menuNumber
	lda menuOptionTab,x
	jmp (r0)
.else
.ifndef newMenu_5
	bvs Menu_51
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	jsr Menu_7
	jsr MenuDoInvert
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	jsr Menu_7
.else
Menu_5Help:
	MoveB selectionFlash, r0L
	LoadB r0H, NULL
	jsr _Sleep
	jmp Menu_7

Menu_5:
	jsr _MouseOff
	jsr Menu_7
	jsr MenuDoInvert
	lda r9L
	ldx menuNumber
	sta menuOptionTab,x
	jsr Menu_8
	bbsf 7, r1L, Menu_52
	bvs Menu_51
	jsr Menu_5Help
	jsr MenuDoInvert
	jsr Menu_5Help
.endif
	jsr MenuDoInvert
	jsr Menu_7
	ldx menuNumber
	lda menuOptionTab,x
	pha
	jsr Menu_8
	pla
	jmp (r0)

Menu_51:
	jsr Menu_6
	lda r0L
	ora r0H
	bne Menu_52
	rts
Menu_52:
	inc menuNumber
	jmp DoMenu0

Menu_6:
	ldx menuNumber
	lda menuOptionTab,x
	pha
	jsr Menu_8
	pla
	jmp (r0)
.endif

.ifdef wheels ; xxx moved
MenuDoInvert:
  	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	jsr _InvertRectangle
	PopB dispBufferOn
	rts

        .byte 0, 0, 0, 0, 0 ; ???
.endif

Menu_7:
	lda menuOptNumber
	and #%00011111
	tay
	lda menuOptNumber
	bmi @4
@1:	dey
	lda mouseXPos+1
	cmp menuLimitTabH,y
.ifdef bsw128
	beq @X
	bcs @Y
.else
	bne @2
.endif
@X:	lda mouseXPos
	cmp menuLimitTabL,y
@2:	bcc @1
@Y:	iny
	lda menuLimitTabL,y
	sta r4L
	lda menuLimitTabH,y
	sta r4H
	dey
	lda menuLimitTabL,y
	sta r3L
	lda menuLimitTabH,y
	sta r3H
	sty r9L
.ifndef wheels
	cpy #0
	bne @3
	inc r3L
	bne @3
	inc r3H
.endif
@3:	ldx menuTop
	inx
	stx r2L
	ldx menuBottom
	dex
	stx r2H
	rts
@4:	lda mouseYPos
@5:	dey
	cmp menuLimitTabL,y
	bcc @5
	iny
	lda menuLimitTabL,y
	sta r2H
	dey
	lda menuLimitTabL,y
	sta r2L
	sty r9L
	cpy #0
	bne @6
	inc r2L
@6:	MoveW menuLeft, r3
.ifdef wheels_size ; code reuse
.import IncR3
	jsr IncR3
.else
	inc r3L
	bne @7
	inc r3H
@7:
.endif
	MoveW menuRight, r4
	ldx #r4
.ifdef wheels_size_and_speed
	jmp Ddec
.else
	jsr Ddec
	rts
.endif

Menu_8:
	jsr Menu_0
	iny
	iny
	lda (r0),y
	sta r1L
	iny
	lda (r0),y
	tax
	iny
	lda (r0),y
	sta r0H
	stx r0L
	rts

.ifndef wheels ; xxx moved
MenuDoInvert:
	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	jsr _InvertRectangle
	PopB dispBufferOn
	rts
.endif

MenuStoreFont:
	ldx #9
@1:	lda baselineOffset-1,x
	sta saveFontTab-1,x
	dex
	bne @1
	rts

MenuRestoreFont:
	ldx #9
@1:	lda saveFontTab-1,x
	sta baselineOffset-1,x
	dex
	bne @1
	rts
