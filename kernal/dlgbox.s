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
.if wheels
.import KbdDBncTab
.endif

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
.if !wheels ; ???
	clc
	jsr CalcDialogCoords
.endif
	lda #$ff
	jsr FrameRectangle
	lda #0
	sta defIconTab
.if !wheels ; ???
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
.if wheels_buttons_shortcuts ; install keyVector for all button types
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
.if wheels_buttons_shortcuts
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
.if wheels_buttons_shortcuts
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
	.byte 13, "cynod"
ShortcutKeysEnd:
.else
	CmpBI keyData, CR
	beq DBIcOK
	rts
.endif

.if wheels_size
DBIcDISK:
.if wheels ; XXX disk swapping + REU? ATTN: *requires* wheels_size!!!
L9D83 = $9D83
L5009 = $5009
L9D80 = $9D80
	lda #$45
	jsr L9D80 ; far call
	jsr L5009
	jsr L9D83 ; REU swap, preserving r registers and x, y
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
.if wheels
	addv 4
.else
	addv 7
.endif
	pha
	lda r2H
.if wheels
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
.if wheels
LF43B = $F43B
LF69A = $F69A
L500C = $500C
L9FF1 = $9FF1
        lda     L9FF1                           ; F61C AD F1 9F                 ...
        cmp     #5                            ; F61F C9 05                    ..
        beq     LF654                           ; F621 F0 31                    .1
        lda     r10L                             ; F623 A5 16                    ..
        pha                                     ; F625 48                       H
        sta     r5L                             ; F626 85 0C                    ..
        lda     r10H                             ; F628 A5 17                    ..
        pha                                     ; F62A 48                       H
        sta     r5H                             ; F62B 85 0D                    ..
        ora     r5L                             ; F62D 05 0C                    ..
        beq     LF640                           ; F62F F0 0F                    ..
        lda     #>KbdDBncTab                            ; F631 A9 87                    ..
        sta     r10H                             ; F633 85 17                    ..
        lda     #<KbdDBncTab                            ; F635 A9 EB                    ..
        sta     r10L                             ; F637 85 16                    ..
        ldx     #r5                            ; F639 A2 0C                    ..
        ldy     #r10                            ; F63B A0 16                    ..
        jsr     CopyString                      ; F63D 20 65 C2                  e.
LF640:  lda     #$45                            ; F640 A9 45                    .E
        jsr     L9D80                           ; F642 20 80 9D                  ..
        jsr     L500C                           ; F645 20 0C 50                  .P
        jsr     L9D83 ; REU swap, preserving r registers and x, y
        pla                                     ; F64B 68                       h
        sta     r10L                             ; F64C 85 16                    ..
        pla                                     ; F64E 68                       h
        sta     r10H                             ; F64F 85 17                    ..
        clv                                     ; F651 B8                       .
        bvc     LF657                           ; F652 50 03                    P.
LF654:  jsr     L500C                           ; F654 20 0C 50                  .P
LF657:  pla                                     ; F657 68                       h
        sta     $06                             ; F658 85 06                    ..
        pla                                     ; F65A 68                       h
        sta     $08                             ; F65B 85 08                    ..
        sta     LF69A                           ; F65D 8D 9A F6                 ...
        lda     #$00                            ; F660 A9 00                    ..
        sta     $885C                           ; F662 8D 5C 88                 .\.
        sta     $885B                           ; F665 8D 5B 88                 .[.
        lda     $8856                           ; F668 AD 56 88                 .V.
        beq     LF694                           ; F66B F0 27                    .'
        cmp     #$06                            ; F66D C9 06                    ..
        bcc     LF67C                           ; F66F 90 0B                    ..
        lda     #$F6                            ; F671 A9 F6                    ..
        sta     r5H                             ; F673 85 0D                    ..
        lda     #$98                            ; F675 A9 98                    ..
        sta     r5L                             ; F677 85 0C                    ..
        jsr     LF43B                           ; F679 20 3B F4                  ;.
LF67C:  lda     #$00                            ; F67C A9 00                    ..
        jsr     LF7A3                           ; F67E 20 A3 F7                  ..
        jsr     FetchRAM                        ; F681 20 CB C2                  ..
        lda     #$F6                            ; F684 A9 F6                    ..
        sta     $84AA                           ; F686 8D AA 84                 ...
        lda     #$D2                            ; F689 A9 D2                    ..
        sta     $84A9                           ; F68B 8D A9 84                 ...
        jsr     LF80F                           ; F68E 20 0F F8                  ..
        jsr     LF7D9                           ; F691 20 D9 F7                  ..
LF694:  pla                                     ; F694 68                       h
        sta     $04                             ; F695 85 04                    ..
        rts                                     ; F697 60                       `
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
	cmp #6
	bcc @1
	lda #>DBGFilesArrowsIcons
	sta r5H
	lda #<DBGFilesArrowsIcons
	sta r5L
	jsr DBIconsHelp2
@1:	lda #>DBGFPressVector
	sta otherPressVec+1
	lda #<DBGFPressVector
	sta otherPressVec
	jsr DBGFilesHelp1
	jsr DBGFilesHelp5
	jsr DBGFilesHelp2
@2:	PopB r1L
	rts

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
.if wheels
	.byte 8, 8
.else
	.byte 3, 12
.endif
	.word DBGFDoArrow

DBGFArrowPic:
.if wheels
	.byte   $0A,$FF
        .byte   $82,$80,$01,$04,$81,$A4,$FF,$FF
        .byte   $80,$01,$83,$C1,$81,$81,$80,$01
        .byte   $80,$01,$87,$E1,$8F,$F1,$80,$01
        .byte   $80,$01,$8F,$F1,$87,$E1,$80,$01
        .byte   $FF,$FF,$81,$81,$83,$C1,$80,$01
        .byte   $FF,$FF,$04,$81,$08,$FF,$08,$BF
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
.if wheels
	lda dblClickCount
	beq @X
	ldy A88A7
	dey
	jmp DoKeyboardShortcut
@X:	lda #30
	sta dblClickCount
.endif
@2:	rts

; xxx F72F
DBGFDoArrow:
.if wheels
L9FF2 = $9FF2
        lda     $3B                             ; F72F A5 3B                    .;
        lsr     a                               ; F731 4A                       J
        lda     $3A                             ; F732 A5 3A                    .:
        ror     a                               ; F734 6A                       j
        lsr     a                               ; F735 4A                       J
        lsr     a                               ; F736 4A                       J
        sec                                     ; F737 38                       8
        sbc     LF69A                           ; F738 ED 9A F6                 ...
        lsr     a                               ; F73B 4A                       J
        tay                                     ; F73C A8                       .
        cpy     #$04                            ; F73D C0 04                    ..
        bcc     LF742                           ; F73F 90 01                    ..
        rts                                     ; F741 60                       `

; ----------------------------------------------------------------------------
LF742:  lda     LF74B,y                         ; F742 B9 4B F7                 .K.
        ldx     LF74F,y                         ; F745 BE 4F F7                 .O.
        jmp     CallRoutine                     ; F748 4C D8 C1                 L..

; ----------------------------------------------------------------------------
LF74B:  .byte   $53,$5D,$88,$7C                 ; F74B 53 5D 88 7C              S].|
LF74F:  .byte   $F7,$F7,$F7,$F7                 ; F74F F7 F7 F7 F7              ....
; ----------------------------------------------------------------------------
; F753
        lda     $885B                           ; F753 AD 5B 88                 .[.
        bne     LF759                           ; F756 D0 01                    ..
        rts                                     ; F758 60                       `

; ----------------------------------------------------------------------------
LF759:  lda     #$00                            ; F759 A9 00                    ..
        beq     LF791                           ; F75B F0 34                    .4
; F75D
        ldx     $8856                           ; F75D AE 56 88                 .V.
        dex                                     ; F760 CA                       .
        stx     r0L                           ; F761 86 02                    ..
        lda     #$00                            ; F763 A9 00                    ..
        sta     r0H                             ; F765 85 03                    ..
        sta     $05                             ; F767 85 05                    ..
        lda     #$05                            ; F769 A9 05                    ..
        sta     $04                             ; F76B 85 04                    ..
        ldx     #$02                            ; F76D A2 02                    ..
        ldy     #$04                            ; F76F A0 04                    ..
        jsr     Ddiv                            ; F771 20 69 C1                  i.
        jsr     BBMult                          ; F774 20 60 C1                  `.
        lda     r0L                           ; F777 A5 02                    ..
        clv                                     ; F779 B8                       .
        bvc     LF791                           ; F77A 50 15                    P.

; F77C
        lda     $885B                           ; F77C AD 5B 88                 .[.
        clc                                     ; F77F 18                       .
        adc     #$05                            ; F780 69 05                    i.
        cmp     $8856                           ; F782 CD 56 88                 .V.
        bcc     LF791                           ; F785 90 0A                    ..
        rts                                     ; F787 60                       `

; ----------------------------------------------------------------------------
; F788
        lda     $885B                           ; F788 AD 5B 88                 .[.
        bne     LF78E                           ; F78B D0 01                    ..
        rts                                     ; F78D 60                       `

; ----------------------------------------------------------------------------
LF78E:  sec                                     ; F78E 38                       8
        sbc     #$05                            ; F78F E9 05                    ..
LF791:  sta     $885C                           ; F791 8D 5C 88                 .\.
        sta     $885B                           ; F794 8D 5B 88                 .[.
        jsr     LF7A3                           ; F797 20 A3 F7                  ..
        jsr     FetchRAM                        ; F79A 20 CB C2                  ..
        jsr     LF7D9                           ; F79D 20 D9 F7                  ..
        jmp     LF80F                           ; F7A0 4C 0F F8                 L..

; ----------------------------------------------------------------------------
LF7A3:  sta     $04                             ; F7A3 85 04                    ..
        lda     #$05                            ; F7A5 A9 05                    ..
        sta     r0L                           ; F7A7 85 02                    ..
        lda     L9FF2                           ; F7A9 AD F2 9F                 ...
        sta     $06                             ; F7AC 85 06                    ..
        ldx     #$06                            ; F7AE A2 06                    ..
        ldy     #$02                            ; F7B0 A0 02                    ..
        jsr     BBMult                          ; F7B2 20 60 C1                  `.
        lda     L9FF2                           ; F7B5 AD F2 9F                 ...
        sta     r0L                           ; F7B8 85 02                    ..
        ldx     #$04                            ; F7BA A2 04                    ..
        ldy     #$02                            ; F7BC A0 02                    ..
        jsr     BBMult                          ; F7BE 20 60 C1                  `.
        clc                                     ; F7C1 18                       .
        lda     $04                             ; F7C2 A5 04                    ..
        adc     #$80                            ; F7C4 69 80                    i.
        sta     $04                             ; F7C6 85 04                    ..
        lda     $05                             ; F7C8 A5 05                    ..
        adc     #$E0                            ; F7CA 69 E0                    i.
        sta     $05                             ; F7CC 85 05                    ..
        lda     #$83                            ; F7CE A9 83                    ..
        sta     r0H                             ; F7D0 85 03                    ..
        lda     #$00                            ; F7D2 A9 00                    ..
        sta     r0L                           ; F7D4 85 02                    ..
        sta     $08                             ; F7D6 85 08                    ..
        rts                                     ; F7D8 60                       `
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
LF7F4 = $F7F4
LF7D9:  lda     $885C                           ; F7D9 AD 5C 88                 .\.
        sec                                     ; F7DC 38                       8
        sbc     $885B                           ; F7DD ED 5B 88                 .[.
        ldx     #$02                            ; F7E0 A2 02                    ..
        jsr     LF7F4                           ; F7E2 20 F4 F7                  ..
        lda     $885A                           ; F7E5 AD 5A 88                 .Z.
        sta     r5H                             ; F7E8 85 0D                    ..
        lda     $8859                           ; F7EA AD 59 88                 .Y.
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
        lda     L9FF2                           ; F7F6 AD F2 9F                 ...
        sta     $04                             ; F7F9 85 04                    ..
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
        sta     $00,x                           ; F808 95 00                    ..
        lda     #$83                            ; F80A A9 83                    ..
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
LF883 = $F883
LF8B8 = $F8B8
LF80F:  lda     $38                             ; F80F A5 38                    .8
        pha                                     ; F811 48                       H
        lda     $37                             ; F812 A5 37                    .7
        pha                                     ; F814 48                       H
        lda     $2E                             ; F815 A5 2E                    ..
        pha                                     ; F817 48                       H
        lda     #$40                            ; F818 A9 40                    .@
        sta     $2E                             ; F81A 85 2E                    ..
        lda     #$00                            ; F81C A9 00                    ..
        jsr     LF8B8                           ; F81E 20 B8 F8                  ..
        clc                                     ; F821 18                       .
        lda     $07                             ; F822 A5 07                    ..
        adc     #$38                            ; F824 69 38                    i8
        sta     $07                             ; F826 85 07                    ..
        lda     #$00                            ; F828 A9 00                    ..
        jsr     SetPattern                      ; F82A 20 39 C1                  9.
        jsr     Rectangle                       ; F82D 20 24 C1                  $.
        lda     #$00                            ; F830 A9 00                    ..
        lda     $0B                             ; F832 A5 0B                    ..
        sta     $38                             ; F834 85 38                    .8
        lda     $0A                             ; F836 A5 0A                    ..
        sta     $37                             ; F838 85 37                    .7
        lda     #$00                            ; F83A A9 00                    ..
        sta     $20                             ; F83C 85 20                    . 
        ldx     #$1E                            ; F83E A2 1E                    ..
        jsr     LF7F4                           ; F840 20 F4 F7                  ..
LF843:  lda     $20                             ; F843 A5 20                    . 
        jsr     LF8B8                           ; F845 20 B8 F8                  ..
        lda     $09                             ; F848 A5 09                    ..
        sta     $19                             ; F84A 85 19                    ..
        lda     $08                             ; F84C A5 08                    ..
        sta     $18                             ; F84E 85 18                    ..
        lda     $06                             ; F850 A5 06                    ..
        clc                                     ; F852 18                       .
        adc     #$09                            ; F853 69 09                    i.
        sta     $05                             ; F855 85 05                    ..
        lda     $1F                             ; F857 A5 1F                    ..
        sta     r0H                             ; F859 85 03                    ..
        lda     $1E                           ; F85B A5 1E                    ..
        sta     r0L                           ; F85D 85 02                    ..
        jsr     PutString                       ; F85F 20 48 C1                  H.
        clc                                     ; F862 18                       .
        lda     L9FF2                           ; F863 AD F2 9F                 ...
        adc     $1E                           ; F866 65 1E                    e.
        sta     $1E                           ; F868 85 1E                    ..
        bcc     LF86E                           ; F86A 90 02                    ..
        inc     $1F                             ; F86C E6 1F                    ..
LF86E:  inc     $20                             ; F86E E6 20                    . 
        lda     $20                             ; F870 A5 20                    . 
        cmp     #$05                            ; F872 C9 05                    ..
        bne     LF843                           ; F874 D0 CD                    ..
        jsr     LF883                           ; F876 20 83 F8                  ..
        pla                                     ; F879 68                       h
        sta     $2E                             ; F87A 85 2E                    ..
        pla                                     ; F87C 68                       h
        sta     $37                             ; F87D 85 37                    .7
        pla                                     ; F87F 68                       h
        sta     $38                             ; F880 85 38                    .8
        rts                                     ; F882 60                       `
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
.if wheels
	adc #13
.else
	adc #14
.endif
	sta r2H
	inc r2L
.if wheels
        jsr     LF8DE                           ; F8D6 20 DE F8                  ..
.else
	dec r2H
	inc r3L
	bne @1
	inc r3H
.endif
@1:	ldx #r4
.if wheels
        jmp     Ddec                            ; F8DB 4C 75 C1                 Lu.
.else
	jsr Ddec
	rts
.endif

.if wheels
LF8DE:  inc     $08                             ; F8DE E6 08                    ..
        bne     LF8E4                           ; F8E0 D0 02                    ..
        inc     $09                             ; F8E2 E6 09                    ..
LF8E4:  rts                                     ; F8E4 60                       `
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
