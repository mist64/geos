; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse: MouseUp, MouseOff, StartMouseMode, ClearMouseMode syscalls


.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "inputdrv.inc"

.import _DoPreviousMenu
.import menuOptNumber
.import ProcessClick
.import Menu_5
.import menuRight
.import menuLeft
.import menuBottom
.import menuTop
.import _DisablSprite

.import CallRoutine
.import PosSprite
.import DrawSprite
.import MouseUp
.import NormalizeX
.ifndef bsw128
.import EnablSprite
.endif

.global _MouseOff
.global _StartMouseMode
.global ProcessMouse
.global _ClearMouseMode
.global _MouseUp

.ifdef wheels
.global ResetMseRegion
.endif

.segment "mouse2"

_StartMouseMode:
	bcc @1
	lda r11L
	ora r11H
	beq @1
.ifdef bsw128
	ldx #r11
	jsr NormalizeX
.endif
	MoveW r11, mouseXPos
	sty mouseYPos
	jsr SlowMouse
@1:	LoadW mouseVector, CheckClickPos
	LoadW mouseFaultVec, DoMouseFault
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
.ifdef bsw128
	smbf_ 0, mobenble
.endif
	rts

ProcessMouse:
.ifdef wheels_bad_ideas
	; While the mouse pointer is not showing,
	; Wheels doesn't call the mouse driver.
	; For a joystick, this means that the 
	; pointer can't be moved while it's
	; invisible, and for a 1531 mouse, it means
	; the input registers may overflow in the
	; worst case, causing the pointer to jump.
	;
	; This is probably not a good idea.
	bbrf MOUSEON_BIT, mouseOn, @1
	jsr UpdateMouse
.else
	jsr UpdateMouse
	bbrf MOUSEON_BIT, mouseOn, @1
.endif
	jsr CheckMsePos
	LoadB r3L, 0
.ifdef bsw128
	bbsf 7, graphMode, @X
.endif
	MoveW msePicPtr, r4
	jsr DrawSprite
@X:	MoveW mouseXPos, r4
	MoveB mouseYPos, r5L
	jsr PosSprite
.ifndef bsw128
	jsr EnablSprite
.endif
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

.ifdef wheels ; this got moved :(
.import ScreenDimensions
ResetMseRegion:
	ldy #5
@1:	lda ScreenDimensions,y
	sta mouseTop,y
	dey
	bpl @1
	rts
.endif

CheckClickPos:
	lda mouseData
	bmi @4
.ifdef wheels_size_and_speed
	bit mouseOn
	bpl @4
	bvc @3
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
@2:	jmp Menu_5
@3:	bbrf ICONSON_BIT, mouseOn, @4
	jmp ProcessClick
@4:	lda otherPressVec
	ldx otherPressVec+1
	jmp CallRoutine

.ifndef wheels_size
	rts ; ???
.endif

DoMouseFault:
.ifdef wheels_size_and_speed
	bit mouseOn
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

.ifdef wheels_size_and_speed
	lda #SET_OFFTOP
	bit menuOptNumber
	bmi @X
	lda #SET_OFFLEFT
@X:	and faultData
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
.ifndef wheels_size_and_speed ; seems unnecessary?
	tya
.endif
	bbsf 6, menuOptNumber, @3
@2:	jsr _DoPreviousMenu
@3:	rts

