; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Menus: DoMenu, ReDoMenu, DoPreviousMenu, GotoFirstMenu syscalls


.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _PutString
.import MenuStringFault
.import MenuRestoreFont
.import Menu_3
.import Menu_4
.import MenuStoreFont
.import ResetMseRegion
.import _GetSerialNumber
.import _GraphicsString
.import _RecoverMenu
.import _MouseOff
.import _StartMouseMode
.import menuRight
.import menuLeft
.import menuBottom
.import menuTop
.import menuLimitTabH
.import menuLimitTabL
.import menuOptNumber
.import DrawMenu
.import _SetPattern
.import CopyMenuCoords
.import menuStackH
.import menuStackL
.import menuOptionTab
.import _UseSystemFont
.import _FrameRectangle
.import _Rectangle

.import GraphicsString
.import GetSerialNumber

.ifdef wheels
.import _HorizontalLine
.endif

.global DoMenu0
.global GetMenuDesc
.global Menu_0
.global _DoPreviousMenu
.global _ReDoMenu
.global _GotoFirstMenu
.global _DoMenu

.segment "menu1"

;---------------------------------------------------------------
; DoMenu                                                  $C151
;
; Function:  Display and activate the menu structure pointed to
;            by r0

; Pass:      a   nbr of menu to place mouse on
;            r0  address of menu table
; Destroyed: a, x, y, r0 - r13
;            ex: .byte top,bottom
;                .word left,right
;                .byte nbr_menu|type
;
;                .word text1
;                .byte type
;                .word subMenu1 .etc...
;      subMenu1: .byte top,bottom
;                .word left,right
;                .byte nbr_items|type
;
;                .word text1a
;                .byte type
;                .word domenu1 .etc...
;---------------------------------------------------------------
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
.ifdef wheels
	lda r2H
	sta r11L
	lda #$ff
	bit menuOptNumber
	bpl @X
	jsr _FrameRectangle
	bra @Y
@X:	jsr _HorizontalLine
	lda r2L
	sta r11L
	lda #$ff
	jsr _HorizontalLine
.else
	lda #$ff
	jsr _FrameRectangle
.endif
@Y:	PopW r11
	jsr Menu_1
.if ((menuVSeparator | menuHSeparator)<>0)
	jsr DrawMenu
.endif
	PopB dispBufferOn
	plp
	bbsf 6, menuOptNumber, @1
	bcc @4
@1:	ldx menuNumber
	ldy menuOptionTab,x
	bbsf 7, menuOptNumber, @2
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
.ifdef bsw128
	lsr r11H
.else
	ror r11H
.endif
	ror r11L
	lda menuTop
	add menuBottom
	ror
	tay
	bra @3
@2:	lda menuLimitTabL,y
	iny
	clc
	adc menuLimitTabL,y
.ifdef bsw128
	ror
.else
	lsr
.endif
	tay
	lda menuLeft
	add menuRight
	sta r11L
	lda menuLeft+1
	adc menuRight+1
	sta r11H
	lsr r11H
	ror r11L
@3:	sec
@4:	bbrf MOUSEON_BIT, mouseOn, @5
.ifdef wheels_size_and_speed
	lda #1 << ICONSON_BIT | 1 << MENUON_BIT
	.byte $2c ; skip the "LDA #" part of "smbf"
.else
	smbf ICONSON_BIT, mouseOn
.endif
@5:	smbf MENUON_BIT, mouseOn
	jmp _StartMouseMode

;---------------------------------------------------------------
_ReDoMenu:
	jsr _MouseOff
	jmp DoPrvMn1

;---------------------------------------------------------------
_GotoFirstMenu:
	php
	sei
@1:
.ifdef wheels
	lda menuNumber
.else
	CmpBI menuNumber, 0
.endif
	beq @2
	jsr _DoPreviousMenu
	bra @1
@2:	plp
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
@1:	lda (r0),y
	sta mouseTop,y
	sta menuTop,y
	dey
	bpl @1

.ifdef trap1
	; If the user has changed where GetSerialNumber points to,
	; this will sabotage the KERNAL call GraphicsString.
	lda GetSerialNumber + 1 - $FF,y
	add #<(_GraphicsString - _GetSerialNumber)
	sta GraphicsString + 1 - $FF,y
.endif

	MoveW menuLeft, r11
	MoveB menuTop, r1H
	bbsf 6, menuOptNumber, @2
	jsr ResetMseRegion
@2:	rts

Menu_1:
	jsr MenuStoreFont
	jsr _UseSystemFont
	LoadB r10H, 0
	sta currentMode
	sec
	jsr Menu_4
@1:	jsr Menu_3
	clc
	jsr Menu_4
	jsr Menu_2
	clc
	jsr Menu_4
	bbrf 7, menuOptNumber, @2
	lda r1H
	sec
	adc curHeight
	sta r1H
	MoveW menuLeft, r11
	sec
	jsr Menu_4
@2:
.ifdef wheels_size_and_speed
	inc r10H
.else
	AddVB 1, r10H
.endif
	lda menuOptNumber
	and #%00011111
	cmp r10H
	bne @1
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
.ifdef wheels_size_and_speed
	lda #$00
	sta leftMargin+1
	sta leftMargin
.else
	LoadW__ leftMargin, 0
.endif
	sec
	lda menuRight
	sbc #1
	sta rightMargin
	lda menuRight+1
	sbc #0
	sta rightMargin+1
	LoadW StringFaultVec, MenuStringFault
	PushB r1H
.ifdef wheels
	bit menuOptNumber
	bmi @1
	sec
	lda menuBottom
	sbc curHeight
	sbc #1
	sta r1H
@1:	clc
	adc baselineOffset
	adc #1
	sta r1H
.else
	AddB_ baselineOffset, r1H
	inc r1H
.endif
	jsr _PutString
	PopB r1H
	PopW StringFaultVec
	PopW rightMargin
	PopW leftMargin
	PopW r10
	rts

