; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Menus

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

; mouse.s
.import _MouseOff
.import _StartMouseMode
.import ResetMseRegion

.if (trap)
; serial.s
.import _GetSerialNumber
.endif

; var.s
.import menuOptNumber
.import menuBottom
.import menuTop
.import menuRight
.import menuLeft
.import menuLimitTabH
.import menuLimitTabL
.import menuStackH
.import menuStackL
.import menuOptionTab

; syscalls
.global _DoMenu
.global _DoPreviousMenu
.global _GotoFirstMenu
.global _ReDoMenu
.global _RecoverAllMenus
.global _RecoverMenu

; used by icon.s
.global MenuDoInvert

; used by mouse.s
.global Menu_5

; used by dlgbox.s
.global RcvrMnu0

.segment "menu"

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
	jsr $EE12;xxxGetMenuDesc
	sec
DoMenu1_1:
	php
	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	PushW r11
	jsr $EFAF;xxxCopyMenuCoords
	PushW curPattern
	lda #0
	jsr _SetPattern
	jsr _Rectangle
	PopW curPattern
.if wheels
LC67C = $C67C
LC88D = $C88D
        lda     $07                             ; ED3B A5 07                    ..
        sta     $18                             ; ED3D 85 18                    ..
        lda     #$FF                            ; ED3F A9 FF                    ..
        bit     $86C0                           ; ED41 2C C0 86                 ,..
        bpl     @X                           ; ED44 10 06                    ..
        jsr     LC88D                           ; ED46 20 8D C8                  ..
        clv                                     ; ED49 B8                       .
        bvc     @Y                           ; ED4A 50 0C                    P.
@X:	jsr     LC67C                           ; ED4C 20 7C C6                  |.
        lda     $06                             ; ED4F A5 06                    ..
        sta     $18                             ; ED51 85 18                    ..
.endif
	lda #$ff
	jsr $C67C;xxx_FrameRectangle
@Y:	PopW r11
	jsr $EE4A;xxxMenu_1
.if ((menuVSeparator | menuHSeparator)<>0)
	jsr $EF7C;xxxDrawMenu
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
	ror r11H
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
@3:	sec
@4:	bbrf MOUSEON_BIT, mouseOn, @5
.if wheels
        lda     #$60                            ; EDC8 A9 60                    .`
        .byte   $2C                             ; EDCA 2C                       ,
.else
	smbf ICONSON_BIT, mouseOn
.endif
@5:	smbf MENUON_BIT, mouseOn
	jmp _StartMouseMode

;---------------------------------------------------------------
_ReDoMenu:
	jsr _MouseOff
	jmp $EDF2;xxxDoPrvMn1

;---------------------------------------------------------------
_GotoFirstMenu:
	php
	sei
@1:
.if wheels
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
	jsr $EF68;xxx_RecoverMenu
	dec menuNumber
DoPrvMn1:
	jsr $EE12;xxxGetMenuDesc
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

.if !wheels
.if (trap)
	; If the user has changed where GetSerialNumber points to,
	; this will sabotage the KERNAL call GraphicsString.
	lda GetSerialNumber + 1 - $FF,y
	clc
	adc #<(_GraphicsString - _GetSerialNumber)
	sta GraphicsString + 1 - $FF,y
.endif
.endif

	MoveW menuLeft, r11
	MoveB menuTop, r1H
	bbsf 6, menuOptNumber, @2
	jsr $EC75;xxxResetMseRegion
@2:	rts

Menu_1:
	jsr $F08C;xxxMenuStoreFont
	jsr _UseSystemFont
	LoadB r10H, 0
	sta currentMode
	sec
	jsr $EF35;xxxMenu_4
@1:	jsr $EF20;xxxMenu_3
	clc
	jsr $EF35;xxxMenu_4
	jsr $EE93;xxxMenu_2
	clc
	jsr $EF35;xxxMenu_4
	bbrf 7, menuOptNumber, @2
	lda r1H
	sec
	adc curHeight
	sta r1H
	MoveW menuLeft, r11
	sec
	jsr $EF35;xxxMenu_4
@2:
.if wheels
	inc r10H
.else
	AddVB 1, r10H
.endif
	lda menuOptNumber
	and #%00011111
	cmp r10H
	bne @1
	jsr $F097;xxxMenuRestoreFont
	jmp $EF20;xxxMenu_3

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
.if wheels
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
	lda #>MenuStringFault
	sta StringFaultVec+1
	lda #$15;xxx#<MenuStringFault
	sta StringFaultVec
	PushB r1H
.if wheels
        bit     $86C0                           ; EEDE 2C C0 86                 ,..
        bmi     LEEED                           ; EEE1 30 0A                    0.
        sec                                     ; EEE3 38                       8
        lda     $86C2                           ; EEE4 AD C2 86                 ...
        sbc     $29                             ; EEE7 E5 29                    .)
        sbc     #$01                            ; EEE9 E9 01                    ..
        sta     $05                             ; EEEB 85 05                    ..
LEEED:  clc                                     ; EEED 18                       .
        adc     $26                             ; EEEE 65 26                    e&
        adc     #$01                            ; EEF0 69 01                    i.
        sta     $05                             ; EEF2 85 05                    ..
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

MenuStringFault:
	MoveW mouseRight, r11
	rts

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
.if wheels
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
	jsr $EF68;xxx_RecoverMenu
	dec menuNumber
	bpl _RecoverAllMenus
	lda #0
	sta menuNumber
	rts

;---------------------------------------------------------------
_RecoverMenu:
	jsr $EFAF;xxxCopyMenuCoords
RcvrMnu0:
	lda RecoverVector
	ora RecoverVector+1
	bne @1
.if !wheels
	lda #0
.endif
	jsr SetPattern
	jmp Rectangle
@1:	jmp (RecoverVector)

.if ((menuVSeparator | menuHSeparator)<>0)
DrawMenu:
	lda menuOptNumber
.if wheels
	bpl @5
.else
	and #%00011111
.endif
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

CopyMenuCoords:
	ldx #6
@1:	lda menuTop-1,x
	sta r2-1,x
	dex
	bne @1
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
	bmi @4
@1:	dey
	lda mouseXPos+1
	cmp menuLimitTabH,y
	bne @2
	lda mouseXPos
	cmp menuLimitTabL,y
@2:	bcc @1
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
	bne @3
	inc r3L
	bne @3
	inc r3H
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
	inc r3L
	bne @7
	inc r3H
@7:	MoveW menuRight, r4
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
