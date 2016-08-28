; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse

.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "inputdrv.inc"
.include "jumptab.inc"

; icon.s
.import ProcessClick

; menu.s
.import _DoPreviousMenu
.import Menu_5

; sprite.s
.import _DisablSprite

; keyboard.s
.import KbdScanHelp3

; used by mainloop.s
.global ProcessMouse
.global _DoCheckButtons

; used by hw.s, icon.s, menu.s
.global ResetMseRegion

; used by conio.s
; just a "rts" that is used elsewhere :(
.global DoESC_RULER

; var.s
.import menuOptNumber
.import menuBottom
.import menuTop
.import menuRight
.import menuLeft

; syscalls
.global _ClearMouseMode
.global _IsMseInRegion
.global _MouseOff
.global _MouseUp
.global _StartMouseMode
.global InitMsePic

.segment "mouseptr"

InitMsePic:
	.byte %11111100, %00000000, %00000000
	.byte %11111000, %00000000, %00000000
	.byte %11110000, %00000000, %00000000
	.byte %11111000, %00000000, %00000000
	.byte %11011100, %00000000, %00000000
	.byte %10001110, %00000000, %00000000
	.byte %00000111, %00000000, %00000000
	.byte %00000011, %00000000, %00000000

.segment "mouse1"

_IsMseInRegion:
	lda mouseYPos
	cmp r2L
	bcc @5
	cmp r2H
	beq @1
	bcs @5
@1:	lda mouseXPos+1
	cmp r3H
	bne @2
	lda mouseXPos
	cmp r3L
@2:	bcc @5
	lda mouseXPos+1
	cmp r4H
	bne @3
	lda mouseXPos
	cmp r4L
@3:	beq @4
	bcs @5
@4:	lda #$ff
	rts
@5:	lda #0
	rts

.segment "mouse2"

_StartMouseMode:
	bcc @1
	lda r11L
	ora r11H
	beq @1
	MoveW r11, mouseXPos
	sty mouseYPos
	jsr SlowMouse
@1:	lda #>CheckClickPos
	sta mouseVector+1
	lda #<CheckClickPos
	sta mouseVector
	lda #>DoMouseFault
	sta mouseFaultVec+1
	lda #<DoMouseFault
	sta mouseFaultVec
	LoadB faultData, NULL
	jmp MouseUp

_ClearMouseMode:
	LoadB mouseOn, NULL
CMousMd1:
	LoadB r3L, NULL
	jmp _DisablSprite

_MouseOff:
	rmbf MOUSEON_BIT, mouseOn
	jmp CMousMd1

_MouseUp:
	smbf MOUSEON_BIT, mouseOn
	rts

ProcessMouse:
.if wheels
	bbrf MOUSEON_BIT, mouseOn, @1
	jsr UpdateMouse
.else
	jsr UpdateMouse
	bbrf MOUSEON_BIT, mouseOn, @1
.endif
	jsr CheckMsePos
	LoadB r3L, 0
	MoveW msePicPtr, r4
	jsr DrawSprite
	MoveW mouseXPos, r4
	MoveB mouseYPos, r5L
	jsr PosSprite
	jsr EnablSprite
@1:	rts

CheckMsePos:
	ldy mouseLeft
	ldx mouseLeft+1
	lda mouseXPos+1
	bmi @2
	cpx mouseXPos+1
	bne @1
	cpy mouseXPos
@1:	bcc @3
	beq @3
@2:	smbf OFFLEFT_BIT, faultData
	sty mouseXPos
	stx mouseXPos+1
@3:	ldy mouseRight
	ldx mouseRight+1
	cpx mouseXPos+1
	bne @4
	cpy mouseXPos
@4:	bcs @5
	smbf OFFRIGHT_BIT, faultData
	sty mouseXPos
	stx mouseXPos+1
@5:	ldy mouseTop
	CmpBI mouseYPos, 228
	bcs @6
	cpy mouseYPos
	bcc @7
	beq @7
@6:	smbf OFFTOP_BIT, faultData
	sty mouseYPos
@7:	ldy mouseBottom
	cpy mouseYPos
	bcs @8
	smbf OFFBOTTOM_BIT, faultData
	sty mouseYPos
@8:	bbrf MENUON_BIT, mouseOn, @B
	lda mouseYPos
	cmp menuTop
	bcc @A
	cmp menuBottom
	beq @9
	bcs @A
@9:	CmpW mouseXPos, menuLeft
	bcc @A
	CmpW mouseXPos, menuRight
	bcc @B
	beq @B
@A:	smbf OFFMENU_BIT, faultData
@B:	rts

.if wheels
; this got moved :(
LC4A1 = $C4A1
ResetMseRegion:
LEC75:  ldy     #$05                            ; EC75 A0 05                    ..
LEC77:  lda     LC4A1,y                         ; EC77 B9 A1 C4                 ...
        sta     $84B8,y                         ; EC7A 99 B8 84                 ...
        dey                                     ; EC7D 88                       .
        bpl     LEC77                           ; EC7E 10 F7                    ..
        rts                                     ; EC80 60                       `
.endif

CheckClickPos:
	lda mouseData
	bmi @4
.if wheels
        bit     $30                             ; EC86 24 30                    $0
        bpl     @4
        bvc     @3                           ; EC8A 50 2F                    P/
.else
	lda mouseOn
	and #SET_MSE_ON
	beq @4
	lda mouseOn
	and #SET_MENUON
	beq @3
.endif
	CmpB mouseYPos, menuTop
	bcc @3
	cmp menuBottom
	beq @1
	bcs @3
@1:	CmpW mouseXPos, menuLeft
	bcc @3
	CmpW mouseXPos, menuRight
	beq @2
	bcs @3
@2:	jmp $EFBA;xxxMenu_5
@3:	bbrf ICONSON_BIT, mouseOn, @4
	jmp ProcessClick
@4:	lda otherPressVec
	ldx otherPressVec+1
	jmp CallRoutine

.if !wheels
	rts ; ???
.endif

DoMouseFault:
.if wheels
	bit $30
	bpl @3
	bvc @3
.else
	lda #$c0
	bbrf MOUSEON_BIT, mouseOn, @3
	bvc @3
.endif
	lda menuNumber
	beq @3
	bbsf OFFMENU_BIT, faultData, @2

.if wheels
        lda     #$80                            ; ECDF A9 80                    ..
        bit     $86C0                           ; ECE1 2C C0 86                 ,..
        bmi     @X                           ; ECE4 30 02                    0.
        lda     #$20                            ; ECE6 A9 20                    .
@X:	and     $84B6                           ; ECE8 2D B6 84                 -..
.else
	ldx #SET_OFFTOP
	lda #$C0
	tay
	bbsf 7, menuOptNumber, @1
	ldx #SET_OFFLEFT
@1:	txa
	and faultData
.endif
	bne @2
.if !wheels
	tya
.endif
	bbsf 6, menuOptNumber, @3
@2:	jsr _DoPreviousMenu
@3:	rts

.segment "mouse3"

.if !wheels
; this got moved :(
ResetMseRegion:
	lda #NULL
	sta mouseLeft
	sta mouseLeft+1
	sta mouseTop
	LoadW mouseRight, SC_PIX_WIDTH-1
	LoadB mouseBottom, SC_PIX_HEIGHT-1
	rts
.endif

.segment "mouse4"

_DoCheckButtons:
	bbrf INPUT_BIT, pressFlag, @1
	rmbf INPUT_BIT, pressFlag
	lda inputVector
	ldx inputVector+1
	jsr CallRoutine
@1:	bbrf MOUSE_BIT, pressFlag, @2
	rmbf MOUSE_BIT, pressFlag
	lda mouseVector
	ldx mouseVector+1
	jsr CallRoutine
@2:	bbrf KEYPRESS_BIT, pressFlag, @3
	jsr KbdScanHelp3
	lda keyVector
	ldx keyVector+1
	jsr CallRoutine
@3:	lda faultData
	beq DoESC_RULER
	lda mouseFaultVec
	ldx mouseFaultVec+1
	jsr CallRoutine
	lda #NULL
	sta faultData
DoESC_RULER:
	rts
