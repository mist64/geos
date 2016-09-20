; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: misc

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DBGFOffsTop
.import DBGFOffsLeft
.import CalcDialogCoords
.import DBGFNameTable
.import DBGFArrowX
.import DBGFileSelected
.import DBGFilesFound
.import DBGFTableIndex
.import L8871

.import Ddec
.import InvertRectangle
.import PutString
.import Rectangle
.import SetPattern
.import BBMult
.import CopyString
.import NormalizeX
.import Ddiv
.import IsMseInRegion

.ifdef wheels
.import DoKeyboardShortcut
.import FetchRAM
.import CallRoutine
.endif

.global DBGFDoArrow
.global DBGFPressVector
.global DBGFilesHelp2
.global DBGFilesHelp3
.global DBGFilesHelp5
.global DBGFilesHelp7

.ifdef wheels
.global SetupRAMOpCall
.endif

.segment "dlgbox1j"

DBGFPressVector:
	lda mouseData
	bmi @2
	jsr DBGFilesHelp7
	clc
	lda r2L
	adc #$45
	sta r2H
	jsr IsMseInRegion
	beq @2
	jsr DBGFilesHelp6
	jsr DBGFilesHelp7
	lda mouseYPos
	sub r2L
	sta r0L
	LoadB r0H, 0
	sta r1H
	LoadB r1L, 14
	ldx #r0
	ldy #r1
	jsr Ddiv
	lda r0L
	add DBGFTableIndex
	cmp DBGFilesFound
	bcc @1
	ldx DBGFilesFound
	dex
	txa
@1:	sta DBGFileSelected
	jsr DBGFilesHelp6
	jsr DBGFilesHelp2
.ifdef wheels_dlgbox_dblclick
	lda dblClickCount
	beq @X
	ldy dblDBData
	dey
	jmp DoKeyboardShortcut
@X:	lda #CLICK_COUNT
	sta dblClickCount
.endif
@2:	rts

DBGFDoArrow:
.ifdef wheels_dlgbox_features
.import dbFieldWidth
	; which icon inside the top/bot/up/down image was the mouse on?
	lda mouseXPos+1
	lsr
	lda mouseXPos
	ror
	lsr
	lsr ; / 16
	sec
	sbc DBGFArrowX
	lsr
	tay
	cpy #4
	bcc @1
	rts
@1:	lda DoArrowTabL,y
	ldx DoArrowTabH,y
	jmp CallRoutine

.define DoArrowTab DBGFDoArrowTop, DBGFDoArrowBottom, DBGFDoArrowUp, DBGFDoArrowDown

DoArrowTabL:
	.lobytes DoArrowTab
DoArrowTabH:
	.hibytes DoArrowTab

DBGFDoArrowTop:
	lda DBGFTableIndex
	bne @1
	rts
@1:	lda #0
	beq DBGFDoArrowFuncCommon

DBGFDoArrowBottom:
	ldx DBGFilesFound
	dex
	stx r0L
	lda #0
	sta r0H
	sta r1H
	lda #5
	sta r1L
	ldx #r0
	ldy #r1
	jsr Ddiv
	jsr BBMult
	lda r0L
	bra DBGFDoArrowFuncCommon

DBGFDoArrowDown:
	lda DBGFTableIndex
	add #5
	cmp DBGFilesFound
	bcc DBGFDoArrowFuncCommon
	rts

DBGFDoArrowUp:
	lda DBGFTableIndex
	bne @1
	rts
@1:	sec
	sbc #5
DBGFDoArrowFuncCommon:
	sta DBGFTableIndex+1
	sta DBGFTableIndex
	jsr SetupRAMOpCall
	jsr FetchRAM
	jsr DBGFilesHelp2
	jmp DBGFilesHelp5

SetupRAMOpCall:
	sta r1L
	lda #5
	sta r0L
	lda dbFieldWidth
	sta r2L
	ldx #r2
	ldy #r0L
	jsr BBMult ; r2 = 5 * dbFieldWidth (count)
	lda dbFieldWidth
	sta r0L
	ldx #r1
	ldy #r0L
	jsr BBMult ; r1 = arg * dbFieldWidth (REU offset)
	clc
	lda r1L
	adc #<$E080
	sta r1L
	lda r1H
	adc #>$E080 ; REU address
	sta r1H
	LoadW r0, fileTrScTab ; CBM address
	sta r3L ; REU bank 0
	rts
.else
; DBGFDoArrow:
	jsr DBGFilesHelp6
	LoadB r0H, 0
	lda DBGFArrowX
	asl
	asl
	asl
	rol r0H
	addv 12
	sta r0L
	bcc @1
	inc r0H
@1:
.ifdef bsw128
	lda r0H
	ora L8871
	sta r0H
	ldx #r0
	jsr NormalizeX
.endif
	ldx DBGFTableIndex
	CmpW r0, mouseXPos
	bcc @2
	dex
	bpl @3
@2:	inx
	lda DBGFilesFound
	sub DBGFTableIndex
	cmp #6
	bcc @4
@3:	stx DBGFTableIndex
@4:	CmpB DBGFTableIndex, DBGFileSelected
	bcc @5
	sta DBGFileSelected
@5:	addv 4
	cmp DBGFileSelected
	bcs @6
	sta DBGFileSelected
@6:	jsr DBGFilesHelp2
	jmp DBGFilesHelp5
.endif

DBGFilesHelp2:
.ifdef wheels_dlgbox_features
	lda DBGFTableIndex+1
	sec
	sbc DBGFTableIndex
	ldx #r0
	jsr DBGFilesHelp4
	MoveW DBGFNameTable, r5
	ldy #r5
	jmp CopyString
.else
	lda DBGFileSelected
	jsr DBGFilesHelp3
	ldy #r1
	jmp CopyString

DBGFilesHelp3:
	ldx #r0
	jsr DBGFilesHelp4
	MoveW DBGFNameTable, r1
	rts
.endif

DBGFilesHelp4:
	sta r0L
.ifdef wheels_dlgbox_features
	MoveB dbFieldWidth, r1L
.else
	LoadB r1L, 17
.endif
	txa
	pha
	ldy #r0
	ldx #r1
	jsr BBMult
	pla
	tax
	lda r1L
.ifdef wheels_size_and_speed
	sta zpage,x
	.assert <fileTrScTab = 0, error, "fileTrScTab must be page-aligned!"
	lda #>fileTrScTab
.else
	add #<fileTrScTab
	sta zpage,x
	lda #>fileTrScTab
	adc #0
.endif
	sta zpage+1,x
	rts

DBGFilesHelp5:
.ifdef wheels_dlgbox_features
	PushW rightMargin
	PushB currentMode
	LoadB currentMode, $40
	lda #0
	jsr DBGFilesHelp8
	clc
	lda r2H
	adc #$38
	sta r2H
	lda #0
	jsr SetPattern
	jsr Rectangle
	lda #0
	lda r4H
	sta rightMargin+1
	lda r4L
	sta rightMargin
	lda #0
	sta r15L
	ldx #30
	jsr DBGFilesHelp4
LF843:	lda r15L
	jsr DBGFilesHelp8
	lda r3H
	sta r11H
	lda r3L
	sta r11L
	lda r2L
	add #9
	sta r1H
	lda r14H
	sta r0H
	lda r14L
	sta r0L
	jsr PutString
	clc
	lda dbFieldWidth
	adc r14L
	sta r14L
	bcc LF86E
	inc r14H
LF86E:	inc r15L
	lda r15L
	cmp #5
	bne LF843
	jsr DBGFilesHelp6
	PopB currentMode
	PopW rightMargin
	rts
.else
	PushW rightMargin
	lda #0
	jsr DBGFilesHelp8
	MoveW r4, rightMargin
	LoadB r15L, 0
	jsr SetPattern

	lda DBGFTableIndex
	ldx #r14
	jsr DBGFilesHelp4
	LoadB currentMode, SET_BOLD
@1:	lda r15L
	jsr DBGFilesHelp8

	jsr Rectangle
	MoveW r3, r11
	lda r2L
	addv 9
	sta r1H
	MoveW r14, r0
	jsr PutString
	AddVW 17, r14
	inc r15L
	CmpBI r15L, 5
	bne @1
	jsr DBGFilesHelp6
	LoadB currentMode, NULL
	PopW rightMargin
	rts
.endif

DBGFilesHelp6:
	lda DBGFileSelected
	sub DBGFTableIndex
	jsr DBGFilesHelp8
	jmp InvertRectangle

DBGFilesHelp7:
	clc
	jsr CalcDialogCoords
	AddB DBGFOffsLeft, r3L
	bcc @1
	inc r3H
@1:	addv $7c
	sta r4L
	lda #0
	adc r3H
	sta r4H
	AddB DBGFOffsTop, r2L
	adc #$58
	sta r2H
	rts

DBGFilesHelp8:
	sta r0L
	LoadB r1L, 14
	ldy #r1
	ldx #r0
	jsr BBMult
	jsr DBGFilesHelp7
	AddB r0L, r2L
	clc
.ifdef wheels_dlgbox_features
	adc #13
.else
	adc #14
.endif
	sta r2H
	inc r2L
.ifdef wheels_size ; code reuse
	jsr IncR3
.else
	dec r2H
	inc r3L
	bne @1
	inc r3H
.endif
@1:	ldx #r4
.ifdef wheels_size_and_speed
	jmp Ddec
.else
	jsr Ddec
	rts
.endif

.ifdef wheels_size ; code reuse
.global IncR3
IncR3:	inc r3L
	bne @1
	inc r3H
@1:	rts
.endif

