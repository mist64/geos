; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"
.if wheels
.include "jumptab_wheels.inc"
.endif

; conio.s
.import _UseSystemFont

; icon.s
.import CalcIconDescTab

; init.s
.import InitGEOEnv

; menu.s
.import RcvrMnu0

; mouse.s
.import _StartMouseMode

.if wheels_fixes
; mouse.s
.import DoESC_RULER
.endif

; var.s
.import menuOptNumber
.import TimersTab
.import DBGFTableIndex
.import DBGFileSelected
.import DBGFilesFound
.import DBGFNameTable
.import DBGFOffsTop
.import DBGFOffsLeft
.import dlgBoxCallerSP
.import dlgBoxCallerPC
.import defIconTab

.global Dialog_2
.global DlgBoxPrep
.global _DoDlgBox
.global _RstrFrmDialogue

.segment "dlgbox1"

_DoDlgBox:
	MoveW r0, DBoxDesc
	ldx #0
@1:	lda r5L,x
	pha
	inx
	cpx #12
	bne @1
	jsr DlgBoxPrep
	jsr DrawDlgBox
.if wheels_size_and_speed ; duplicate LDA #0
	lda #0
	sta r11H
	sta r11L
.else
	LoadW__ r11, 0
.endif
	jsr _StartMouseMode
	jsr _UseSystemFont
	ldx #11
@2:	pla
	sta r5L,x
	dex
	bpl @2
	ldy #0
	ldx #7
	lda (DBoxDesc),y
	bpl @3
	ldx #1
@3:	txa
	tay
@4:	lda (DBoxDesc),y
	sta r0L
	beq @7
	ldx #0
@5:	lda r5L,x
	pha
	inx
	cpx #12
	bne @5
	iny
	sty r1L
	ldy r0L
	lda DlgBoxProcL-1,y
	ldx DlgBoxProcH-1,y
	jsr CallRoutine
	ldx #11
@6:	pla
	sta r5L,x
	dex
	bpl @6
	ldy r1L
	bra @4
@7:	lda defIconTab
	beq @8
	LoadW r0, defIconTab
	jsr DoIcons
@8:	PopW dlgBoxCallerPC
	tsx
	stx dlgBoxCallerSP
	jmp MainLoop

.define DlgBoxProc1 DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons
.if wheels_fixes ; fix: have commands 7-10 (undefined) point to RTS
.define DlgBoxProc2 DoESC_RULER, DoESC_RULER, DoESC_RULER, DoESC_RULER
.else
.define DlgBoxProc2 DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons
.endif
.define DlgBoxProc3 DBDoTXTSTR, DBDoVARSTR, DBDoGETSTR, DBDoSYSOPV, DBDoGRPHSTR, DBDoGETFILES, DBDoOPVEC, DBDoUSRICON, DBDoUSR_ROUT

DlgBoxProcL:
	.lobytes DlgBoxProc1
	.lobytes DlgBoxProc2 ; not used
	.lobytes DlgBoxProc3
DlgBoxProcH:
	.hibytes DlgBoxProc1
.if wheels_fixes ; fix: correct pointers
	.hibytes DlgBoxProc2
.else
	.lobytes DlgBoxProc2 ; yes, lobytes!! -- not used
.endif
	.hibytes DlgBoxProc3

DlgBoxPrep:
.if wheels_size ; Dialog_2 was folded into this
	sec
	jsr DlgBoxPrep2
	LoadB sysDBData, NULL
	jmp InitGEOEnv

Dialog_2:
	clc
DlgBoxPrep2:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	LoadW r4, dlgBoxRamBuf
	bcc @1
	jsr DialogSave
	LoadB mobenble, 1
	bne @2
@1:	jsr DialogRestore
@2:	pla
	sta CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
.else
ASSERT_NOT_BELOW_IO
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadW r4, dlgBoxRamBuf
	jsr DialogSave
	LoadB mobenble, 1
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	jsr InitGEOEnv
	LoadB sysDBData, NULL
	rts
.endif

DrawDlgBox:
	LoadB dispBufferOn, ST_WR_FORE | ST_WRGS_FORE
	ldy #0
	lda (DBoxDesc),y
	and #%00011111
.if (speedupDlgBox)
	bne DrwDlgSpd0
	jmp @1
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
	beq @1
	jsr SetPattern
	sec
	jsr CalcDialogCoords
	jsr Rectangle
.endif
@1:	lda #0
	jsr SetPattern
	clc
	jsr CalcDialogCoords
	MoveW r4, rightMargin
	jsr Rectangle
.if !wheels_size_and_speed ; redundant
	clc
	jsr CalcDialogCoords
.endif
	lda #$ff
	jsr FrameRectangle
	lda #0
	sta defIconTab
.if !wheels_size_and_speed ; single 0 = no icons
	sta defIconTab+1
	sta defIconTab+2
.endif
	rts

Dialog_1:
	ldy #0
	lda (DBoxDesc),y
	and #%00011111
	beq @1
	sec
	jsr @2
@1:	clc
@2:	jsr CalcDialogCoords
	jmp RcvrMnu0

CalcDialogCoords:
.if (speedupDlgBox)
	LoadB r1H, 0
.else
	lda #0
	bcc @1
	lda #8
@1:	sta r1H
.endif
	PushW DBoxDesc
	ldy #0
	lda (DBoxDesc),y
	bpl @2
	lda #>(DBDefinedPos-1)
	sta DBoxDescH
	lda #<(DBDefinedPos-1)
	sta DBoxDesc
@2:	ldx #0
	ldy #1
@3:	lda (DBoxDesc),y
	clc
	adc r1H
	sta r2L,x
	iny
	inx
	cpx #2
	bne @3
@4:	lda (DBoxDesc),y
	clc
	adc r1H
	sta r2L,x
	iny
	inx
	lda (DBoxDesc),y
	bcc @5
	adc #0
@5:	sta r2L,x
	iny
	inx
	cpx #6
	bne @4
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

.if !wheels_size ; folded into DlgBoxPrep
Dialog_2:
ASSERT_NOT_BELOW_IO
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadW r4, dlgBoxRamBuf
	jsr DialogRestore
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
.endif

DialogSave:
	ldx #0
	ldy #0
@1:	jsr DialogNextSaveRestoreEntry
	beq @3
@2:	lda (r2),y
	sta (r4),y
	iny
	dec r3L
	bne @2
	beq @1
@3:	rts

DialogRestore:
	php
	sei
	ldx #0
	ldy #0
@1:	jsr DialogNextSaveRestoreEntry
	beq @3
@2:	lda (r4),y
	sta (r2),y
	iny
	dec r3L
	bne @2
	beq @1
@3:	plp
	rts

DialogNextSaveRestoreEntry:
	tya
	add r4L
	sta r4L
	bcc @1
	inc r4H
@1:	ldy #0
.if wheels_size_and_speed ; 17 vs. 21 bytes and faster
	lda DialogCopyTab3,x
	beq @2
	sta r3L
	lda DialogCopyTab1,x
	sta r2L
	lda DialogCopyTab2,x
	sta r2H
.else
	lda DialogCopyTab,x
	sta r2L
	inx
	lda DialogCopyTab,x
	sta r2H
	inx
	ora r2L
	beq @2
	lda DialogCopyTab,x
	sta r3L
.endif
	inx
@2:	rts

; pointer & length tuples of memory regions to save and restore
.if wheels_size_and_speed
.define DialogCopyTab curPattern, appMain, IconDescVec, menuOptNumber, TimersTab, obj0Pointer, mob0xpos, mobenble, mobprior, mcmclr0, mob1clr, moby2
DialogCopyTab1:
	.lobytes DialogCopyTab
DialogCopyTab2:
	.hibytes DialogCopyTab
DialogCopyTab3:
	.byte 23
	.byte 38
	.byte 2
	.byte 49
	.byte 227
	.byte 8
	.byte 17
	.byte 1
	.byte 3
	.byte 2
	.byte 7
	.byte 1
	.byte NULL
.else
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
.endif

; handler for commands 1-6
DBDoIcons:
.if wheels_button_shortcuts ; install keyVector for all button types
	lda keyVector+1
.else
	dey ; command-1: "OK"==0
	bne @1 ; not "OK"
	lda keyVector
	ora keyVector+1
.endif
	bne @1
	lda #>DBKeyVector
	sta keyVector+1
	lda #<DBKeyVector
	sta keyVector
@1:
.if wheels_button_shortcuts
	dey
.endif
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
	bcs @4
	txa
	inx
	stx defIconTab
	jsr CalcIconDescTab
	tax
	ldy #0
@1:	lda (r5),y
	cpy #2
	bne @2
	lda r3L
@2:	cpy #3
	bne @3
	lda r2L
@3:	sta defIconTab,x
	inx
	iny
	cpy #8
	bne @1
@4:	rts

DBDefIconsTab:
	.word DBIcPicOK
	.word 0
	.byte 6, 16
DBDefIconsTabRoutine:
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
.if wheels_button_shortcuts
	lda keyData
	ldy #ShortcutKeysEnd - ShortcutKeys - 1
@1:	cmp ShortcutKeys,y
	beq DoKeyboardShortcut
	dey
	bpl @1
	rts

DoKeyboardShortcut:
	tya
	asl
	asl
	asl
	tay
	lda #0
	sta r0L
LF4AC:	tax
	lda defIconTab+4,x
	cmp DBDefIconsTab,y
	bne LF4BD
	lda defIconTab+4+1,x
	cmp DBDefIconsTab+1,y
	beq LF4CC
LF4BD:	inc r0L
	lda r0L
	cmp defIconTab
	bcs LF4CB
	asl
	asl
	asl
	bne LF4AC
LF4CB:	rts
LF4CC:	lda DBDefIconsTabRoutine,y
	ldx DBDefIconsTabRoutine+1,y
	jmp CallRoutine

ShortcutKeys:
	.byte 13, "cynod"; ok, cancel, yes, no, open, disk
ShortcutKeysEnd:
.else
	CmpBI keyData, CR
	beq DBIcOK
	rts
.endif

.if wheels_size
DBIcDISK:
.if wheels_dialog_chdir ; "Disk" button can change directory
; Maurice says: If your application includes a dialogue box
; with the "DISK" icon, that's all you really need to let the
; user select any partition or subdirectory on a CMD device or
; a subdirectory on a native ramdisk.
; ATTN: *requires* wheels_size!!!
.import GetNewKernal
.import RstrKernal
	lda #$40 + 5
	jsr GetNewKernal
	jsr ChDiskDirectory
	jsr RstrKernal
.endif
	lda #DISK
	.byte $2c
DBIcOK:
	lda #OK
	.byte $2c
DBIcCANCEL:
	lda #CANCEL
	.byte $2c
DBIcYES:
	lda #YES
	.byte $2c
DBIcNO:
	lda #NO
	.byte $2c
DBIcOPEN:
	lda #OPEN
	.byte $2c
DBStringFaultVec2:
	lda #DBSYSOPV
	.byte $2c
DBKeyVector2:
	lda #DBGETSTRING
.else
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
	bne DBKeyVec1 ; ???
DBKeyVec1:
.endif
	sta sysDBData
	jmp RstrFrmDialogue

DBDoSYSOPV:
	lda #>DBStringFaultVec
	sta otherPressVec+1
	lda #<DBStringFaultVec
	sta otherPressVec
	rts

DBStringFaultVec:
	bbsf 7, mouseData, DBDoOPVEC_rts
.if wheels_size ; reuse common code
	jmp DBStringFaultVec2
.else
	lda #DBSYSOPV
	sta sysDBData
	jmp RstrFrmDialogue
.endif

DBDoOPVEC:
	ldy r1L
	lda (DBoxDesc),y
	sta otherPressVec
	iny
	lda (DBoxDesc),y
	sta otherPressVec+1
	iny
	sty r1L
DBDoOPVEC_rts:
	rts


DBDoGRPHSTR:
	ldy r1L
.if wheels_size
	jsr StringGetNext
.else
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
.endif
	pha
	jsr GraphicsString
	PopB r1L
	rts

DBDoUSR_ROUT:
	ldy r1L
.if wheels_size_and_speed ; 13->11 bytes, 25->23 cycles
	iny
	iny
	tya
	pha
	dey
	lda (DBoxDesc),y
	tax
	dey
	lda (DBoxDesc),y
.else
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	tax
	iny
	tya
	pha
	lda r0L
.endif
	jsr CallRoutine
	PopB r1L
	rts

DBDoTXTSTR:
	clc
	jsr CalcDialogCoords
	jsr DBTextCoords
.if wheels_size
	jsr StringGetNext
.else
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
.endif
	pha
	jsr PutString
	PopB r1L
	rts

.if wheels_size
StringGetNext:
	lda (DBoxDesc),y
	sta r0L
	iny
	lda (DBoxDesc),y
	sta r0H
	iny
	tya
	rts
.endif

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

.if !wheels_size ; code reuse
DBKeyVector2:
	LoadB sysDBData, DBGETSTRING
	jmp RstrFrmDialogue
.endif

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
.if wheels_enhanced_list_scrolling ; ???
	addv 4
.else
	addv 7
.endif
	pha
	lda r2H
.if wheels_enhanced_list_scrolling ; ???
	subv 12
.else
	subv 14
.endif
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
.if wheels ; xxx
.import extKrnlIn
.import TmpFilename
	lda extKrnlIn
	cmp #5
	beq @B
	PushB r10L ; r10: source string
	sta r5L
	PushB r10H
	sta r5H
	ora r5L
	beq @A ; null ptr
	LoadW r10, TmpFilename
	ldx #r5
	ldy #r10
	jsr CopyString
@A:	lda #$40 + 5
	jsr GetNewKernal
	jsr GetFEntries
	jsr RstrKernal
	PopW r10
	bra @C
@B:	jsr GetFEntries
@C:	PopB r2L
	PopB r3L
	sta DBGFArrowX
	lda #0
	sta DBGFileSelected
	sta DBGFTableIndex
	lda DBGFilesFound
	beq @2
.else
	LoadB r7H, 15
	LoadW r6, fileTrScTab
	jsr FindFTypes
	PopB r2L
	PopB r3L
	sta DBGFilesArrowsIcons+2
	lda #15
	sub r7H
	beq @2
	sta DBGFilesFound
.endif
	cmp #6
	bcc @1
	LoadW r5, DBGFilesArrowsIcons
	jsr DBIconsHelp2
@1:
.if wheels ; xxx
	lda #0
	jsr SetupRAMOpCall
	jsr FetchRAM
.endif
	LoadW otherPressVec, DBGFPressVector
.if !wheels ; xxx
	jsr DBGFilesHelp1
.endif
	jsr DBGFilesHelp5
	jsr DBGFilesHelp2
@2:	PopB r1L
	rts

.if !wheels ; xxx
DBGFilesHelp1:
	PushB DBGFilesFound
@1:	pla
	subv 1
	pha
	beq @3
	jsr DBGFilesHelp3
	ldy #0
@2:	lda (r0),y
	cmp (r1),y
	bne @1
	tax
	beq @3
	iny
	bne @2
@3:	PopB DBGFileSelected
	subv 4
	bpl @4
	lda #0
@4:	sta DBGFTableIndex
@5:	rts
.endif

DBGFilesArrowsIcons:
	.word DBGFArrowPic
DBGFArrowX:
	.word 0
.if wheels_enhanced_list_scrolling
	.byte 8, 8
.else
	.byte 3, 12
.endif
	.word DBGFDoArrow

DBGFArrowPic:
.if wheels_enhanced_list_scrolling
	.byte 10, %11111111 ; repeat 10
	.byte $80+2 ; 2 data bytes
        .byte                     %10000000, %00000001
	.byte 4, %10000001 ; repeat 4
	.byte $80 + 36
	;     %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111
	;     %11111111,%11111111,%10000000,%00000001,%10000001,%10000001,%10000001,%10000001
	.byte %11111111,%11111111,%10000000,%00000001,%10000011,%11000001,%10000001,%10000001
	.byte %10000000,%00000001,%10000000,%00000001,%10000111,%11100001,%10001111,%11110001
	.byte %10000000,%00000001,%10000000,%00000001,%10001111,%11110001,%10000111,%11100001
	.byte %10000000,%00000001,%11111111,%11111111,%10000001,%10000001,%10000011,%11000001
	.byte %10000000,%00000001,%11111111,%11111111;%10000001,%10000001,%10000001,%10000001
	;     %11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111,%11111111
	.byte 4, %10000001 ; repeat 4
	.byte 8, %11111111 ; repeat 8

	.byte 8, $bf ; ??? unused
.else
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
.endif

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
.if wheels ; xxx
	lda dblClickCount
	beq @X
	ldy dblDBData
	dey
	jmp DoKeyboardShortcut
@X:	lda #30
	sta dblClickCount
.endif
@2:	rts

DBGFDoArrow:
.if wheels_enhanced_list_scrolling
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
	lda L885B
	bne @1
	rts
@1:	lda #0
	beq DBGFDoArrowFuncCommon

DBGFDoArrowBottom:
	ldx DBGFilesFound
	dex
	stx r0L
	lda #$00
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
	lda L885B
	clc
	adc #5
	cmp DBGFilesFound
	bcc DBGFDoArrowFuncCommon
	rts

DBGFDoArrowUp:
	lda L885B
	bne @1
	rts
@1:	sec
	sbc #5
DBGFDoArrowFuncCommon:
	sta L885B+1
	sta L885B
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
@1:	ldx DBGFTableIndex
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
.if wheels
	lda     L885B+1                           ; F7D9 AD 5C 88                 .\.
        sec                                     ; F7DC 38                       8
        sbc     L885B                           ; F7DD ED 5B 88                 .[.
        ldx     #$02                            ; F7E0 A2 02                    ..
        jsr     DBGFilesHelp4                           ; F7E2 20 F4 F7                  ..
        lda     L8859+1                           ; F7E5 AD 5A 88                 .Z.
        sta     r5H                             ; F7E8 85 0D                    ..
        lda     L8859                           ; F7EA AD 59 88                 .Y.
        sta     r5L                             ; F7ED 85 0C                    ..
        ldy     #r5L                            ; F7EF A0 0C                    ..
        jmp     CopyString                      ; F7F1 4C 65 C2                 Le.
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
.if wheels
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
.if wheels
	sta 0,x
	.assert <fileTrScTab = 0, error, "fileTrScTab must be page-aligned!"
	lda #>fileTrScTab
.else
	clc
	adc #<fileTrScTab
	sta zpage,x
	lda #>fileTrScTab
	adc #0
.endif
	sta zpage+1,x
	rts

DBGFilesHelp5:
.if wheels
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
	clc
	adc #9
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
.if wheels ; xxx
	adc #13
.else
	adc #14
.endif
	sta r2H
	inc r2L
.if wheels_size ; code reuse
	jsr IncR3
.else
	dec r2H
	inc r3L
	bne @1
	inc r3H
.endif
@1:	ldx #r4
.if wheels_size_and_speed
	jmp Ddec
.else
	jsr Ddec
	rts
.endif

.if wheels_size ; code reuse
.global IncR3
IncR3:	inc r3L
	bne @1
	inc r3H
@1:	rts
.endif

DBIcPicNO:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+12
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00000001, %11001100, %01111100, %00000000, %00000011
	.byte %10000000, %00000001, %11001100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000001, %11101100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	     ;%10000000, %00000001, %11101100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10111100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	     ;%10000000, %00000001, %10111100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10011100, %11000110, %00000000, %00000011, $80+6
	     ;%10000000, %00000001, %10011100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10001100, %01111100, %00000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicYES:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(5*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00001100, %11001111, %11000111, %11000000, %00000011 ;1
	.byte %10000000, %00001100, %11001100, %00001100, %01100000, %00000011 ;2
	.byte %10000000, %00001100, %11001100, %00001100, %00000000, %00000011 ;3
	.byte %10000000, %00000111, %10001100, %00001100, %00000000, %00000011 ;4
	.byte %10000000, %00000111, %10001111, %10000111, %11000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000011, %00001100, %00000000, %01100000, %00000011, $80+12
	     ;%10000000, %00000011, %00001100, %00000000, %01100000, %00000011
	.byte %10000000, %00000011, %00001100, %00001100, %01100000, %00000011
	.byte %10000000, %00000011, %00001111, %11000111, %11000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicOPEN:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(9*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00111110, %00000000, %00000000, %00000000, %00000011 ;1
	.byte %10000000, %01100011, %00000000, %00000000, %00000000, %00000011 ;2
	.byte %10000000, %01100011, %01111100, %01111001, %11110000, %00000011 ;3
	.byte %10000000, %01100011, %01100110, %11001101, %11011000, %00000011 ;4
	.byte %10000000, %01100011, %01100110, %11001101, %10011000, %00000011 ;5
	.byte %10000000, %01100011, %01100110, %11111101, %10011000, %00000011 ;6
	.byte %10000000, %01100011, %01100110, %11000001, %10011000, %00000011 ;7
	.byte %10000000, %01100011, %01100110, %11001101, %10011000, %00000011 ;8
	.byte %10000000, %00111110, %01111100, %01111001, %10011000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %01100000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %01100000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicDISK:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(9*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00011111, %00001100, %00000011, %00000000, %00000011 ;1
	.byte %10000000, %00011001, %10000000, %00000011, %00000000, %00000011 ;2
	.byte %10000000, %00011000, %11011100, %11110011, %00110000, %00000011 ;3
	.byte %10000000, %00011000, %11001101, %10011011, %01100000, %00000011 ;4
	.byte %10000000, %00011000, %11001101, %10000011, %11000000, %00000011 ;5
	.byte %10000000, %00011000, %11001100, %11110011, %10000000, %00000011 ;6
	.byte %10000000, %00011000, %11001100, %00011011, %11000000, %00000011 ;7
	.byte %10000000, %00011001, %10001101, %10011011, %01100000, %00000011 ;8
	.byte %10000000, %00011111, %00001100, %11110011, %00110000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

.segment "dlgbox2"

DBIcPicCANCEL:
	.byte 5, %11111111, $80+2, %11111110
	.byte %10000000, 4, %00000000, $80+2, %00000011
	.byte %10000000, 4, %00000000, $80+(9*6)+2, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000111, %11000000, %00000000, %00000000, %00000000, %11100011 ;1
	.byte %10001100, %01100000, %00000000, %00000000, %00000000, %01100011 ;2
	.byte %10001100, %00000111, %10011111, %00011110, %00111100, %01100011 ;3
	.byte %10001100, %00001100, %11011101, %10110011, %01100110, %01100011 ;4
	.byte %10001100, %00000111, %11011001, %10110000, %01100110, %01100011 ;5
	.byte %10001100, %00001100, %11011001, %10110000, %01111110, %01100011 ;6
	.byte %10001100, %00001100, %11011001, %10110000, %01100000, %01100011 ;7
	.byte %10001100, %01101100, %11011001, %10110011, %01100110, %01100011 ;8
	.byte %10000111, %11000111, %11011001, %10011110, %00111100, %01100011 ;9
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte %10000000, 4, %00000000, $80+2, %00000011
	.byte %10000000, 4, %00000000, $80+1, %00000011
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicOK:
	.byte 5, %11111111, $80+2, %11111110
	.byte %10000000, 4, %00000000, $80+2, %00000011
	.byte %10000000, 4, %00000000, $80+(9*6)+2, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00000000, %11111000, %11000110, %00000000, %00000011 ;1
	.byte %10000000, %00000001, %10001100, %11001100, %00000000, %00000011 ;2
	.byte %10000000, %00000001, %10001100, %11011000, %00000000, %00000011 ;3
	.byte %10000000, %00000001, %10001100, %11110000, %00000000, %00000011 ;4
	.byte %10000000, %00000001, %10001100, %11100000, %00000000, %00000011 ;5
	.byte %10000000, %00000001, %10001100, %11110000, %00000000, %00000011 ;6
	.byte %10000000, %00000001, %10001100, %11011000, %00000000, %00000011 ;7
	.byte %10000000, %00000001, %10001100, %11001100, %00000000, %00000011 ;8
	.byte %10000000, %00000000, %11111000, %11000110, %00000000, %00000011 ;9
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte %10000000, 4, %00000000, $80+2, %00000011
	.byte %10000000, 4, %00000000, $80+1, %00000011
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111
