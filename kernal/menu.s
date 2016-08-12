; GEOS menu handler

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; graph.s
.import _FrameRectangle
.import _GraphicsString
.import _HorizontalLine
.import _InvertRectangle
.import _Rectangle
.import _SetPattern
.import _VerticalLine

; process.s
.import _Sleep

; conio.s
.import _PutString
.import _UseSystemFont

; mouseio.s
.import _MouseOff
.import _StartMouseMode
.import ResetMseRegion

.if (trap)
; serial.s
.import _GetSerialNumber
.endif

.global MenuDoInvert
.global Menu_5
.global RcvrMnu0
.global _DoMenu
.global _DoPreviousMenu
.global _GotoFirstMenu
.global _ReDoMenu
.global _RecoverAllMenus
.global _RecoverMenu

.segment "menu"

_DoMenu:
	sta menuOptionTab
	ldx #0
	stx menuNumber
	beq DoMenu1
DoMenu0:
	ldx menuNumber
	lda #NULL
	sta menuOptionTab,x
DoMenu1:
	lda r0L
	sta menuStackL,x
	lda r0H
	sta menuStackH,x
	jsr GetMenuDesc
	sec
DoMenu1_1:
	php
	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	PushW r11
	jsr CopyMenuCoords
	PushW curPattern
	lda #0
	jsr _SetPattern
	jsr _Rectangle
	PopW curPattern
	lda #$ff
	jsr _FrameRectangle
	PopW r11
	jsr Menu_1
.if ((menuVSeparator | menuHSeparator)<>0)
	jsr DrawMenu
.endif
	PopB dispBufferOn
	plp
	bbsf 6, menuOptNumber, DoMenu2
	bcc DoMenu5
DoMenu2:
	ldx menuNumber
	ldy menuOptionTab,x
	bbsf 7, menuOptNumber, DoMenu3
	lda menuLimitTabL,y
	sta r11L
	lda menuLimitTabH,y
	sta r11H
	iny
	lda menuLimitTabL,y
	clc
	adc r11L
	sta r11L
	lda menuLimitTabH,y
	adc r11H
	sta r11H
	ror r11H
	ror r11L
	lda menuTop
	add menuBottom
	ror
	tay
	bra DoMenu4
DoMenu3:
	lda menuLimitTabL,y
	iny
	clc
	adc menuLimitTabL,y
	lsr
	tay
	lda menuLeft
	add menuRight
	sta r11L
	lda menuLeft+1
	adc menuRight+1
	sta r11H
	lsr r11H
	ror r11L
DoMenu4:
	sec
DoMenu5:
	bbrf MOUSEON_BIT, mouseOn, DoMenu6
	smbf ICONSON_BIT, mouseOn
DoMenu6:
	smbf MENUON_BIT, mouseOn
	jmp _StartMouseMode

_ReDoMenu:
	jsr _MouseOff
	jmp DoPrvMn1

_GotoFirstMenu:
	php
	sei
GFrstMenu1:
	CmpBI menuNumber, 0
	beq GFrstMenu2
	jsr _DoPreviousMenu
	bra GFrstMenu1
GFrstMenu2:
	plp
	rts

_DoPreviousMenu:
	jsr _MouseOff
	jsr _RecoverMenu
	dec menuNumber
DoPrvMn1:
	jsr GetMenuDesc
	clc
	jmp DoMenu1_1

Menu_0:
	pha
	ldy menuNumber
	lda menuStackL,y
	sta r0L
	lda menuStackH,y
	sta r0H
	PopB r8L
	asl
	asl
	adc r8L
	adc #7
	tay
Menu_01:
	rts

GetMenuDesc:
	ldx menuNumber
	lda menuStackL,x
	sta r0L
	lda menuStackH,x
	sta r0H
	ldy #6
	lda (r0),y
	sta menuOptNumber
	dey
GetMnuDsc1:
	lda (r0),y
	sta mouseTop,y
	sta menuTop,y
	dey
	bpl GetMnuDsc1

.if (trap)
    ; If the user has changed where GetSerialNumber points to,
    ; this will sabotage the KERNAL call GraphicsString.
	lda GetSerialNumber + 1 - $FF,y
	clc
	adc #<(_GraphicsString - _GetSerialNumber)
	sta GraphicsString + 1 - $FF,y
.endif

	MoveW menuLeft, r11
	MoveB menuTop, r1H
	bbsf 6, menuOptNumber, GetMnuDsc2
	jsr ResetMseRegion
GetMnuDsc2:
	rts

Menu_1:
	jsr MenuStoreFont
	jsr _UseSystemFont
	LoadB r10H, 0
	sta currentMode
	sec
	jsr Menu_4
Menu_11:
	jsr Menu_3
	clc
	jsr Menu_4
	jsr Menu_2
	clc
	jsr Menu_4
	bbrf 7, menuOptNumber, Menu_12
	lda r1H
	sec
	adc curHeight
	sta r1H
	MoveW menuLeft, r11
	sec
	jsr Menu_4
Menu_12:
	AddVB 1, r10H
	lda menuOptNumber
	and #%00011111
	cmp r10H
	bne Menu_11
	jsr MenuRestoreFont
	jmp Menu_3

Menu_2:
	PushW r10
	lda r10H
	jsr Menu_0
	lda (r0),y
	tax
	iny
	lda (r0),y
	sta r0H
	stx r0L
	PushW leftMargin
	PushW rightMargin
	PushW StringFaultVec
	LoadW__ leftMargin, 0
	sec
	lda menuRight
	sbc #1
	sta rightMargin
	lda menuRight+1
	sbc #0
	sta rightMargin+1
	lda #>MenuStringFault
	sta StringFaultVec+1
	lda #<MenuStringFault
	sta StringFaultVec
	PushB r1H
	AddB_ baselineOffset, r1H
	inc r1H
	jsr _PutString
	PopB r1H
	PopW StringFaultVec
	PopW rightMargin
	PopW leftMargin
	PopW r10
	rts

MenuStringFault:
	MoveW mouseRight, r11
	rts

Menu_3:
	ldy r10H
	ldx r1H
	bbsf 7, menuOptNumber, Menu_31
	lda r11H
	sta menuLimitTabH,y
	ldx r11L
Menu_31:
	txa
	sta menuLimitTabL,y
	rts

Menu_4:
	bcc Menu_41
	bbrf 7, menuOptNumber, Menu_42
	bra Menu_43
Menu_41:
	bbrf 7, menuOptNumber, Menu_43
Menu_42:
	AddVB 2, r1H
	rts
Menu_43:
	AddVW_ 4, r11
	rts

_RecoverAllMenus:
RcvrAllMns1:
	jsr GetMenuDesc
	jsr _RecoverMenu
	dec menuNumber
	bpl RcvrAllMns1
	lda #0
	sta menuNumber
	rts

_RecoverMenu:
	jsr CopyMenuCoords
RcvrMnu0:
	lda RecoverVector
	ora RecoverVector+1
	bne RcvrMnu1
	lda #0
	jsr SetPattern
	jmp Rectangle
RcvrMnu1:
	jmp (RecoverVector)

.if ((menuVSeparator | menuHSeparator)<>0)
DrawMenu:
	lda menuOptNumber
	and #%00011111
	subv 1
	beq DrawMenu4
	sta r2L
	bbsf 7, menuOptNumber, DrawMenu2
.if (menuVSeparator<>0)
	lda menuTop
	addv 1
	sta r3L
	lda menuBottom
	subv 1
	sta r3H
DrawMenu1:
	ldx r2L
	lda menuLimitTabL,x
	sta r4L
	lda menuLimitTabH,x
	sta r4H
	lda #menuVSeparator
	jsr _VerticalLine
	dec r2L
	bne DrawMenu1
.endif
.if (menuHSeparator<>0)
	rts
.endif
DrawMenu2:
.if (menuHSeparator<>0)
	MoveW menuLeft, r3
	inc r3L
	bne *+4
	inc r3H
	MoveW menuRight, r4
	ldx #r4
	jsr Ddec
DrawMenu3:
	ldx r2L
	lda menuLimitTabL,x
	sta r11L
	lda #menuHSeparator
	jsr _HorizontalLine
	dec r2L
	bne DrawMenu3
.endif
DrawMenu4:
	rts
.endif

CopyMenuCoords:
	ldx #6
CpyMnuCrds1:
	lda menuTop-1,x
	sta r2-1,x
	dex
	bne CpyMnuCrds1
	rts

.if (oldMenu_5)
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

Menu_7:
	lda menuOptNumber
	and #%00011111
	tay
	lda menuOptNumber
	bmi Menu_74
Menu_71:
	dey
	lda mouseXPos+1
	cmp menuLimitTabH,y
	bne Menu_72
	lda mouseXPos
	cmp menuLimitTabL,y
Menu_72:
	bcc Menu_71
	iny
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
	cpy #0
	bne Menu_73
	inc r3L
	bne *+4
	inc r3H
Menu_73:
	ldx menuTop
	inx
	stx r2L
	ldx menuBottom
	dex
	stx r2H
	rts
Menu_74:
	lda mouseYPos
Menu_75:
	dey
	cmp menuLimitTabL,y
	bcc Menu_75
	iny
	lda menuLimitTabL,y
	sta r2H
	dey
	lda menuLimitTabL,y
	sta r2L
	sty r9L
	cpy #0
	bne Menu_76
	inc r2L
Menu_76:
	MoveW menuLeft, r3
	inc r3L
	bne *+4
	inc r3H
	MoveW menuRight, r4
	ldx #r4
	jsr Ddec
	rts

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

MenuDoInvert:
	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	jsr _InvertRectangle
	PopB dispBufferOn
	rts

MenuStoreFont:
	ldx #9
MnuDStrFnt1:
	lda baselineOffset-1,x
	sta saveFontTab-1,x
	dex
	bne MnuDStrFnt1
	rts

MenuRestoreFont:
	ldx #9
MnuDRstrFnt1:
	lda saveFontTab-1,x
	sta baselineOffset-1,x
	dex
	bne MnuDRstrFnt1
	rts
