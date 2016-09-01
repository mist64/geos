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
.if wheels
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
.if wheels_size_and_speed
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
.if wheels_size_and_speed
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
.if wheels_size_and_speed
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
	lda #<MenuStringFault
	sta StringFaultVec
	PushB r1H
.if wheels
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
.if wheels_size_and_speed
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
.if !wheels_size_and_speed
	lda #0
.endif
	jsr SetPattern
	jmp Rectangle
@1:	jmp (RecoverVector)

.if ((menuVSeparator | menuHSeparator)<>0)
DrawMenu:
.if wheels
	lda menuOptNumber
	bpl LEFAE
	and #$1F
	sec
	sbc #1
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

.if wheels
LC83C = $C83C
LED00 = $ED00
LF077 = $F077
LF000 = $F000
LEB9C = $EB9C

LEFBA:  jsr     LEB9C                           ; EFBA 20 9C EB                  ..
        jsr     LF000                           ; EFBD 20 00 F0                  ..
        jsr     MenuDoInvert
        lda     $14                             ; EFC3 A5 14                    ..
        ldx     $84B7                           ; EFC5 AE B7 84                 ...
        sta     $86CF,x                         ; EFC8 9D CF 86                 ...
        jsr     LF077                           ; EFCB 20 77 F0                  w.
        bit     $04                             ; EFCE 24 04                    $.
        bmi     LEFDE                           ; EFD0 30 0C                    0.
        bvc     LEFE4                           ; EFD2 50 10                    P.
        jsr     LEFE4                           ; EFD4 20 E4 EF                  ..
        lda     r0L                           ; EFD7 A5 02                    ..
        ora     $03                             ; EFD9 05 03                    ..
        bne     LEFDE                           ; EFDB D0 01                    ..
        rts                                     ; EFDD 60                       `

; ----------------------------------------------------------------------------
LEFDE:  inc     $84B7                           ; EFDE EE B7 84                 ...
        jmp     LED00                           ; EFE1 4C 00 ED                 L..

; ----------------------------------------------------------------------------
LEFE4:  ldx     $84B7                           ; EFE4 AE B7 84                 ...
        lda     $86CF,x                         ; EFE7 BD CF 86                 ...
        jmp     (r0L)                         ; EFEA 6C 02 00                 l..

; xxx moved
MenuDoInvert:
  	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	jsr _InvertRectangle
	PopB dispBufferOn
	rts

        .byte   $00,$00,$00,$00,$00             ; EFFB 00 00 00 00 00           .....

.else
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
.if !wheels
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
.if wheels_size ; code reuse
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
.if wheels_size_and_speed
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

.if !wheels
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
