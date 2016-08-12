; GEOS KERNAL
;
; Mouse

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

; keyboarddrv.s
.import KbdScanHelp3

.global ProcessMouse
.global ResetMseRegion
.global _ClearMouseMode
.global _DoCheckButtons
.global _IsMseInRegion
.global _MouseOff
.global _MouseUp
.global _StartMouseMode
.global DoESC_RULER

.segment "mouse1"

_IsMseInRegion:
	lda mouseYPos
	cmp r2L
	bcc IMIRl4
	cmp r2H
	beq IMIRl0
	bcs IMIRl4
IMIRl0:
	lda mouseXPos+1
	cmp r3H
	bne IMIRl1
	lda mouseXPos
	cmp r3L
IMIRl1:
	bcc IMIRl4
	lda mouseXPos+1
	cmp r4H
	bne IMIRl2
	lda mouseXPos
	cmp r4L
IMIRl2:
	beq IMIRl3
	bcs IMIRl4
IMIRl3:
	lda #$ff
	rts
IMIRl4:
	lda #0
	rts

.segment "mouse2"

_StartMouseMode:
	bcc SMousMd1
	lda r11L
	ora r11H
	beq SMousMd1
	MoveW r11, mouseXPos
	sty mouseYPos
	jsr SlowMouse
SMousMd1:
	lda #>CheckClickPos
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
MseUp1:
	rts

ProcessMouse:
	jsr UpdateMouse
	bbrf MOUSEON_BIT, mouseOn, ProcessMouse1
	jsr CheckMsePos
	LoadB r3L, 0
	MoveW msePicPtr, r4
	jsr DrawSprite
	MoveW mouseXPos, r4
	MoveB mouseYPos, r5L
	jsr PosSprite
	jsr EnablSprite
ProcessMouse1:
	rts

CheckMsePos:
	ldy mouseLeft
	ldx mouseLeft+1
	lda mouseXPos+1
	bmi ChMsePs2
	cpx mouseXPos+1
	bne ChMsePs1
	cpy mouseXPos
ChMsePs1:
	bcc ChMsePs3
	beq ChMsePs3
ChMsePs2:
	smbf OFFLEFT_BIT, faultData
	sty mouseXPos
	stx mouseXPos+1
ChMsePs3:
	ldy mouseRight
	ldx mouseRight+1
	cpx mouseXPos+1
	bne ChMsePs4
	cpy mouseXPos
ChMsePs4:
	bcs ChMsePs5
	smbf OFFRIGHT_BIT, faultData
	sty mouseXPos
	stx mouseXPos+1
ChMsePs5:
	ldy mouseTop
	CmpBI mouseYPos, 228
	bcs ChMsePs6
	cpy mouseYPos
	bcc ChMsePs7
	beq ChMsePs7
ChMsePs6:
	smbf OFFTOP_BIT, faultData
	sty mouseYPos
ChMsePs7:
	ldy mouseBottom
	cpy mouseYPos
	bcs ChMsePs8
	smbf OFFBOTTOM_BIT, faultData
	sty mouseYPos
ChMsePs8:
	bbrf MENUON_BIT, mouseOn, ChMsePs11
	lda mouseYPos
	cmp menuTop
	bcc ChMsePs10
	cmp menuBottom
	beq ChMsePs9
	bcs ChMsePs10
ChMsePs9:
	CmpW mouseXPos, menuLeft
	bcc ChMsePs10
	CmpW mouseXPos, menuRight
	bcc ChMsePs11
	beq ChMsePs11
ChMsePs10:
	smbf OFFMENU_BIT, faultData
ChMsePs11:
	rts

CheckClickPos:
	lda mouseData
	bmi ChClkPos4
	lda mouseOn
	and #SET_MSE_ON
	beq ChClkPos4
	lda mouseOn
	and #SET_MENUON
	beq ChClkPos3
	CmpB mouseYPos, menuTop
	bcc ChClkPos3
	cmp menuBottom
	beq ChClkPos1
	bcs ChClkPos3
ChClkPos1:
	CmpW mouseXPos, menuLeft
	bcc ChClkPos3
	CmpW mouseXPos, menuRight
	beq ChClkPos2
	bcs ChClkPos3
ChClkPos2:
	jmp Menu_5
ChClkPos3:
	bbrf ICONSON_BIT, mouseOn, ChClkPos4
	jmp ProcessClick
ChClkPos4:
	lda otherPressVec
	ldx otherPressVec+1
	jmp CallRoutine

	rts

DoMouseFault:
	lda #$c0
	bbrf MOUSEON_BIT, mouseOn, DoMseFlt3
	bvc DoMseFlt3
	lda menuNumber
	beq DoMseFlt3
	bbsf OFFMENU_BIT, faultData, DoMseFlt2
	ldx #SET_OFFTOP
	lda #$C0
	tay
	bbsf 7, menuOptNumber, DoMseFlt1
	ldx #SET_OFFLEFT
DoMseFlt1:
	txa
	and faultData
	bne DoMseFlt2
	tya
	bbsf 6, menuOptNumber, DoMseFlt3
DoMseFlt2:
	jsr _DoPreviousMenu
DoMseFlt3:
	rts

.segment "mouse3"

ResetMseRegion:
	lda #NULL
	sta mouseLeft
	sta mouseLeft+1
	sta mouseTop
	LoadW mouseRight, SC_PIX_WIDTH-1
	LoadB mouseBottom, SC_PIX_HEIGHT-1
	rts

.segment "mouse4"

_DoCheckButtons:
	bbrf INPUT_BIT, pressFlag, DoChkBtns1
	rmbf INPUT_BIT, pressFlag
	lda inputVector
	ldx inputVector+1
	jsr CallRoutine
DoChkBtns1:
	bbrf MOUSE_BIT, pressFlag, DoChkBtns2
	rmbf MOUSE_BIT, pressFlag
	lda mouseVector
	ldx mouseVector+1
	jsr CallRoutine
DoChkBtns2:
	bbrf KEYPRESS_BIT, pressFlag, DoChkBtns3
	jsr KbdScanHelp3
	lda keyVector
	ldx keyVector+1
	jsr CallRoutine
DoChkBtns3:
	lda faultData
	beq DoESC_RULER
	lda mouseFaultVec
	ldx mouseFaultVec+1
	jsr CallRoutine
	lda #NULL
	sta faultData
DoESC_RULER:
	rts
