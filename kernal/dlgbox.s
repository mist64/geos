; dialog box handler

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.import Ddec, InvertRectangle, BBMult, CopyString, Ddiv, IsMseInRegion, FindFTypes, HorizontalLine, GetString, PutString, GraphicsString, RstrFrmDialogue, DBIcPicDISK, DBIcPicOPEN, DBIcPicNO, DBIcPicYES, DBIcPicCANCEL, DBIcPicOK, CalcIconDescTab, RcvrMnu0, FrameRectangle, Rectangle, SetPattern, InitGEOEnv, MainLoop, DoIcons, CallRoutine, _UseSystemFont, _StartMouseMode
.global Dialog_2, DlgBoxPrep, _DoDlgBox, _RstrFrmDialogue

.segment "dlgbox"

_DoDlgBox:
	MoveW r0, DBoxDesc
	ldx #0
DDlgB1:
	lda r5L,x
	pha
	inx
	cpx #12
	bne DDlgB1
	jsr DlgBoxPrep
	jsr DrawDlgBox
	LoadW r11, 0
	jsr _StartMouseMode
	jsr _UseSystemFont
	ldx #11
DDlgB2:
	pla
	sta r5L,x
	dex
	bpl DDlgB2
	ldy #0
	ldx #7
	lda (DBoxDesc),y
	bpl DDlgB3
	ldx #1
DDlgB3:
	txa
	tay
DDlgB31:
	lda (DBoxDesc),y
	sta r0L
	beq DDlgB6
	ldx #0
DDlgB4:
	lda r5L,x
	pha
	inx
	cpx #12
	bne DDlgB4
	iny
	sty r1L
	ldy r0L
	lda DlgBoxProcL-1,y
	ldx DlgBoxProcH-1,y
	jsr CallRoutine
	ldx #11
DDlgB5:
	pla
	sta r5L,x
	dex
	bpl DDlgB5
	ldy r1L
	bra DDlgB31
DDlgB6:
	lda defIconTab
	beq DDlgB7
	LoadW r0, defIconTab
	jsr DoIcons
DDlgB7:
	PopW dlgBoxCallerPC
	tsx
	stx dlgBoxCallerSP
	jmp MainLoop

DlgBoxProcL:
	.byte <DBDoIcons, <DBDoIcons
	.byte <DBDoIcons, <DBDoIcons
	.byte <DBDoIcons, <DBDoIcons
	.byte <DBDoIcons, <DBDoIcons ; not used
	.byte <DBDoIcons, <DBDoIcons ; not used
	.byte <DBDoTXTSTR, <DBDoVARSTR
	.byte <DBDoGETSTR, <DBDoSYSOPV
	.byte <DBDoGRPHSTR, <DBDoGETFILES
	.byte <DBDoOPVEC, <DBDoUSRICON
	.byte <DBDoUSR_ROUT
DlgBoxProcH:
	.byte >DBDoIcons, >DBDoIcons
	.byte >DBDoIcons, >DBDoIcons
	.byte >DBDoIcons, >DBDoIcons
	.byte <DBDoIcons, <DBDoIcons ; not used
	.byte <DBDoIcons, <DBDoIcons ; not used
	.byte >DBDoTXTSTR, >DBDoVARSTR
	.byte >DBDoGETSTR, >DBDoSYSOPV
	.byte >DBDoGRPHSTR, >DBDoGETFILES
	.byte >DBDoOPVEC, >DBDoUSRICON
	.byte >DBDoUSR_ROUT

DlgBoxPrep:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadW r4, dlgBoxRamBuf
	jsr Dialog_3
	LoadB mobenble, 1
	PopB CPU_DATA
	LoadB sysDBData, NULL
	jmp InitGEOEnv

DrawDlgBox:
	LoadB dispBufferOn, ST_WR_FORE | ST_WRGS_FORE
	ldy #0
	lda (DBoxDesc),y
	and #%00011111
.if (speedupDlgBox)
	bne DrwDlgSpd0
	jmp DrwDlgBx1
DrwDlgSpd0:
	;1st: right,right+8,top+8,bottom
	;2nd: left+8,right+8,bottom,bottom+8
	jsr SetPattern
	PushW DBoxDesc
	ldy #0
	lda (DBoxDesc),y
	bpl DrwDlgSpd1
	lda #>(DBDefinedPos-1)
	sta DBoxDescH
	lda #<(DBDefinedPos-1)
	sta DBoxDesc
DrwDlgSpd1:
	ldy #1
	lda (DBoxDesc),y
	addv 8
	sta r2L
	iny
	lda (DBoxDesc),y
	sta r2H
	iny
	iny
	iny
	lda (DBoxDesc),y
	sta r3L
	tax
	iny
	lda (DBoxDesc),y
	sta r3H
	txa
	addv 8
	sta r4L
	lda r3H
	adc #0
	sta r4H
	jsr Rectangle
	MoveB r2H, r2L
	addv 8
	sta r2H
	ldy #1+2
	lda (DBoxDesc),y
	sta r3L
	iny
	lda (DBoxDesc),y
	sta r3H
	AddVW 8, r3
	jsr Rectangle
	PopW DBoxDesc
.else
	beq DrwDlgBx1
	jsr SetPattern
	sec
	jsr CalcDialogCoords
	jsr Rectangle
.endif
DrwDlgBx1:
	lda #0
	jsr SetPattern
	clc
	jsr CalcDialogCoords
	MoveW r4, rightMargin
	jsr Rectangle
	clc
	jsr CalcDialogCoords
	lda #$ff
	jsr FrameRectangle
	lda #0
	sta defIconTab
	sta defIconTab+1
	sta defIconTab+2
	rts

Dialog_1:
	ldy #0
	lda (DBoxDesc),y
	and #%00011111
	beq Dialog_11
	sec
	jsr Dialog_12
Dialog_11:
	clc
Dialog_12:
	jsr CalcDialogCoords
	jmp RcvrMnu0

CalcDialogCoords:
.if (speedupDlgBox)
	LoadB r1H, 0
.else
	lda #0
	bcc ClcDlgCoor1
	lda #8
ClcDlgCoor1:
	sta r1H
.endif
	PushW DBoxDesc
	ldy #0
	lda (DBoxDesc),y
	bpl ClcDlgCoor2
	lda #>(DBDefinedPos-1)
	sta DBoxDescH
	lda #<(DBDefinedPos-1)
	sta DBoxDesc
ClcDlgCoor2:
	ldx #0
	ldy #1
ClcDlgCoor3:
	lda (DBoxDesc),y
	clc
	adc r1H
	sta r2L,x
	iny
	inx
	cpx #2
	bne ClcDlgCoor3
ClcDlgCoor4:
	lda (DBoxDesc),y
	clc
	adc r1H
	sta r2L,x
	iny
	inx
	lda (DBoxDesc),y
	bcc *+4
	adc #0
	sta r2L,x
	iny
	inx
	cpx #6
	bne ClcDlgCoor4
	PopW DBoxDesc
	rts

DBDefinedPos:
	.byte DEF_DB_TOP
	.byte DEF_DB_BOT
	.word DEF_DB_LEFT
	.word DEF_DB_RIGHT

_RstrFrmDialogue:
	jsr Dialog_2
	jsr Dialog_1
	MoveB sysDBData, r0L
	ldx dlgBoxCallerSP
	txs
	PushW dlgBoxCallerPC
	rts

Dialog_2:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadW r4, dlgBoxRamBuf
	jsr Dialog_4
	PopB CPU_DATA
	rts

Dialog_3:
	ldx #0
	ldy #0
Dialog_31:
	jsr Dialog_5
	beq Dialog_33
Dialog_32:
	lda (r2),y
	sta (r4),y
	iny
	dec r3L
	bne Dialog_32
	beq Dialog_31
Dialog_33:
	rts

Dialog_4:
	php
	sei
	ldx #0
	ldy #0
Dialog_41:
	jsr Dialog_5
	beq Dialog_43
Dialog_42:
	lda (r4),y
	sta (r2),y
	iny
	dec r3L
	bne Dialog_42
	beq Dialog_41
Dialog_43:
	plp
	rts

Dialog_5:
	tya
	add r4L
	sta r4L
	bcc *+4
	inc r4H
	ldy #0
	lda DialogCopyTab,x
	sta r2L
	inx
	lda DialogCopyTab,x
	sta r2H
	inx
	ora r2L
	beq Dialog_51
	lda DialogCopyTab,x
	sta r3L
	inx
Dialog_51:
	rts

DialogCopyTab:
	.word curPattern
	.byte 23
	.word appMain
	.byte 38
	.word IconDescVec
	.byte 2
	.word menuOptNumber
	.byte 49
	.word TimersTab
	.byte 227
	.word obj0Pointer
	.byte 8
	.word mob0xpos
	.byte 17
	.word mobenble
	.byte 1
	.word mobprior
	.byte 3
	.word mcmclr0
	.byte 2
	.word mob1clr
	.byte 7
	.word moby2
	.byte 1
	.word NULL

DBDoIcons:
	dey
	bne DBDoIcns1
	lda keyVector
	ora keyVector+1
	bne DBDoIcns1
	lda #>DBKeyVector
	sta keyVector+1
	lda #<DBKeyVector
	sta keyVector
DBDoIcns1:
	tya
	asl
	asl
	asl
	clc
	adc #<DBDefIconsTab
	sta r5L
	lda #0
	adc #>DBDefIconsTab
	sta r5H
	jsr DBIconsHelp1
	jmp DBIconsHelp2

DBDoUSRICON:
	jsr DBIconsHelp1
	lda (DBoxDesc),y
	sta r5L
	iny
	lda (DBoxDesc),y
	sta r5H
	iny
	tya
	pha
	jsr DBIconsHelp2
	PopB r1L
	rts

DBIconsHelp1:
	clc
	jsr CalcDialogCoords
	lsr r3H
	ror r3L
	lsr r3L
	lsr r3L
	ldy r1L
	lda (DBoxDesc),y
	clc
	adc r3L
	sta r3L
	iny
	lda (DBoxDesc),y
	clc
	adc r2L
	sta r2L
	iny
	sty r1L
	rts

DBIconsHelp2:
	ldx defIconTab
	cpx #8
	bcs DBIcHlp_23
	txa
	inx
	stx defIconTab
	jsr CalcIconDescTab
	tax
	ldy #0
DBIcHlp_20:
	lda (r5),y
	cpy #2
	bne DBIcHlp_21
	lda r3L
DBIcHlp_21:
	cpy #3
	bne DBIcHlp_22
	lda r2L
DBIcHlp_22:
	sta defIconTab,x
	inx
	iny
	cpy #8
	bne DBIcHlp_20
DBIcHlp_23:
	rts

DBDefIconsTab:
	.word DBIcPicOK
	.word 0
	.byte 6, 16
	.word DBIcOK

	.word DBIcPicCANCEL
	.word 0
	.byte 6, 16
	.word DBIcCANCEL

	.word DBIcPicYES
	.word 0
	.byte 6, 16
	.word DBIcYES

	.word DBIcPicNO
	.word 0
	.byte 6, 16
	.word DBIcNO

	.word DBIcPicOPEN
	.word 0
	.byte 6, 16
	.word DBIcOPEN

	.word DBIcPicDISK
	.word 0
	.byte 6, 16
	.word DBIcDISK

DBKeyVector:
	CmpBI keyData, CR
	beq DBIcOK
	rts
DBIcOK:
	lda #OK
	bne DBKeyVec1
DBIcCANCEL:
	lda #CANCEL
	bne DBKeyVec1
DBIcYES:
	lda #YES
	bne DBKeyVec1
DBIcNO:
	lda #NO
	bne DBKeyVec1
DBIcOPEN:
	lda #OPEN
	bne DBKeyVec1
DBIcDISK:
	lda #DISK
DBKeyVec1:
	sta sysDBData
	jmp RstrFrmDialogue

DBDoSYSOPV:
	lda #>DBStringFaultVec
	sta otherPressVec+1
	lda #<DBStringFaultVec
	sta otherPressVec
	rts

DBStringFaultVec:
	bbsf 7, mouseData, DBDoOpVec1
	lda #DBSYSOPV
	sta sysDBData
	jmp RstrFrmDialogue

DBDoOPVEC:
	ldy r1L
	lda (DBoxDesc),y
	sta otherPressVec
	iny
	lda (DBoxDesc),y
	sta otherPressVec+1
	iny
	sty r1L
DBDoOpVec1:
	rts


DBDoGRPHSTR:
	ldy r1L
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
	pha
	jsr GraphicsString
	PopB r1L
	rts

DBDoUSR_ROUT:
	ldy r1L
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	tax
	iny
	tya
	pha
	lda r0L
	jsr CallRoutine
	PopB r1L
	rts

DBDoTXTSTR:
	clc
	jsr CalcDialogCoords
	jsr DBTextCoords
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
	pha
	jsr PutString
	PopB r1L
	rts

DBDoVARSTR:
	clc
	jsr CalcDialogCoords
	jsr DBTextCoords
	lda (DBoxDesc),y
	iny
	tax
	lda zpage,x
	sta r0L
	lda zpage+1,x
	sta r0H
	tya
	pha
	jsr PutString
	PopB r1L
	rts

DBDoGETSTR:
	clc
	jsr CalcDialogCoords
	jsr DBTextCoords
	lda (DBoxDesc),y
	iny
	tax
	lda zpage,x
	sta r0L
	lda zpage+1,x
	sta r0H
	lda (DBoxDesc),y
	sta r2L
	iny
	lda #>DBKeyVector2
	sta keyVector+1
	lda #<DBKeyVector2
	sta keyVector
	LoadB r1L, 0
	tya
	pha
	jsr GetString
	PopB r1L
	rts

DBKeyVector2:
	LoadB sysDBData, DBGETSTRING
	jmp RstrFrmDialogue

DBTextCoords:
	ldy r1L
	lda (DBoxDesc),y
	add r3L
	sta r11L
	lda r3H
	adc #0
	sta r11H
	iny
	lda (DBoxDesc),y
	iny
	add r2L
	sta r1H
	rts

DBDoGETFILES:
	ldy r1L
	lda (DBoxDesc),y
	sta DBGFOffsLeft
	iny
	lda (DBoxDesc),y
	sta DBGFOffsTop
	iny
	tya
	pha
	MoveW r5, DBGFNameTable
	jsr DBGFilesHelp7
	lda r3H
	ror
	lda r3L
	ror
	lsr
	lsr
	addv 7
	pha
	lda r2H
	subv 14
	pha
	PushB r7L
	PushW r10
	lda #$ff
	jsr FrameRectangle
	sec
	lda r2H
	sbc #16
	sta r11L
	lda #$ff
	jsr HorizontalLine
	PopW r10
	PopB r7L
	LoadB r7H, 15
	LoadW r6, fileTrScTab
	jsr FindFTypes
	PopB r2L
	PopB r3L
	sta DBGFilesArrowsIcons+2
	lda #15
	sub r7H
	beq DBDGFls2
	sta DBGFilesFound
	cmp #6
	bcc DBDGFls1
	lda #>DBGFilesArrowsIcons
	sta r5H
	lda #<DBGFilesArrowsIcons
	sta r5L
	jsr DBIconsHelp2
DBDGFls1:
	lda #>DBGFPressVector
	sta otherPressVec+1
	lda #<DBGFPressVector
	sta otherPressVec
	jsr DBGFilesHelp1
	jsr DBGFilesHelp5
	jsr DBGFilesHelp2
DBDGFls2:
	PopB r1L
	rts

DBGFilesHelp1:
	PushB DBGFilesFound
DBGFlsHlp_11:
	pla
	subv 1
	pha
	beq DBGFlsHlp_13
	jsr DBGFilesHelp3
	ldy #0
DBGFlsHlp_12:
	lda (r0),y
	cmp (r1),y
	bne DBGFlsHlp_11
	tax
	beq DBGFlsHlp_13
	iny
	bne DBGFlsHlp_12
DBGFlsHlp_13:
	PopB DBGFileSelected
	subv 4
	bpl DBGFlsHlp_14
	lda #0
DBGFlsHlp_14:
	sta DBGFTableIndex
DBGFlsHlp_15:
	rts


DBGFilesArrowsIcons:
	.word DBGFArrowPic
DBGFArrowX:
	.word 0
	.byte 3, 12
	.word DBGFDoArrow

DBGFArrowPic:
	.byte 3, %11111111, $80+(10*3)
	;%11111111, %11111111, %11111111
	.byte %10000000, %00000000, %00000001 ;1
	.byte %10000000, %00000000, %00000001 ;2
	.byte %10000010, %00000000, %11100001 ;3
	.byte %10000111, %00000111, %11111101 ;4
	.byte %10001111, %10000011, %11111001 ;5
	.byte %10011111, %11000001, %11110001 ;6
	.byte %10111111, %11100000, %11100001 ;7
	.byte %10000111, %00000000, %01000001 ;8
	.byte %10000000, %00000000, %00000001 ;9
	.byte %10000000, %00000000, %00000001 ;10
	;%11111111, %11111111, %11111111
	.byte 3, %11111111

DBGFPressVector:
	lda mouseData
	bmi DBGFlsHlp_15
	jsr DBGFilesHelp7
	clc
	lda r2L
	adc #$45
	sta r2H
	jsr IsMseInRegion
	beq DBGFlsHlp_15
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
	bcc DBGFPrVec1
	ldx DBGFilesFound
	dex
	txa
DBGFPrVec1:
	sta DBGFileSelected
	jsr DBGFilesHelp6
	jmp DBGFilesHelp2

DBGFDoArrow:
	jsr DBGFilesHelp6
	LoadB r0H, 0
	lda DBGFArrowX
	asl
	asl
	asl
	rol r0H
	addv 12
	sta r0L
	bcc *+4
	inc r0H
	ldx DBGFTableIndex
	CmpW r0, mouseXPos
	bcc DBDoArrow1
	dex
	bpl DBDoArrow2
DBDoArrow1:
	inx
	lda DBGFilesFound
	sub DBGFTableIndex
	cmp #6
	bcc DBDoArrow3
DBDoArrow2:
	stx DBGFTableIndex
DBDoArrow3:
	CmpB DBGFTableIndex, DBGFileSelected
	bcc DBDoArrow4
	sta DBGFileSelected
DBDoArrow4:
	addv 4
	cmp DBGFileSelected
	bcs DBDoArrow5
	sta DBGFileSelected
DBDoArrow5:
	jsr DBGFilesHelp2
	jmp DBGFilesHelp5

DBGFilesHelp2:
	lda DBGFileSelected
	jsr DBGFilesHelp3
	ldy #r1
	jmp CopyString

DBGFilesHelp3:
	ldx #r0
	jsr DBGFilesHelp4
	MoveW DBGFNameTable, r1
	rts

DBGFilesHelp4:
	sta r0L
	LoadB r1L, 17
	txa
	pha
	ldy #r0
	ldx #r1
	jsr BBMult
	pla
	tax
	lda r1L
	clc
	adc #<fileTrScTab
	sta zpage,x
	lda #>fileTrScTab
	adc #0
	sta zpage+1,x
	rts

DBGFilesHelp5:
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
DBGFlsHlp_51:
	lda r15L
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
	bne DBGFlsHlp_51
	jsr DBGFilesHelp6
	LoadB currentMode, NULL
	PopW rightMargin
	rts

DBGFilesHelp6:
	lda DBGFileSelected
	sub DBGFTableIndex
	jsr DBGFilesHelp8
	jmp InvertRectangle

DBGFilesHelp7:
	clc
	jsr CalcDialogCoords
	AddB DBGFOffsLeft, r3L
	bcc *+4
	inc r3H
	addv $7c
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
	adc #14
	sta r2H
	inc r2L
	dec r2H
	inc r3L
	bne *+4
	inc r3H
	ldx #r4
	jmp Ddec
