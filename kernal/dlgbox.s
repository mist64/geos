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
	jsr $F28E;xxxDlgBoxPrep
	jsr $F2BD;xxxDrawDlgBox
.if wheels
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
.define DlgBoxProc2 DBDoIcons, DBDoIcons, DBDoIcons, DBDoIcons
.define DlgBoxProc3 DBDoTXTSTR, DBDoVARSTR, DBDoGETSTR, DBDoSYSOPV, DBDoGRPHSTR, DBDoGETFILES, DBDoOPVEC, DBDoUSRICON, DBDoUSR_ROUT


DlgBoxProcL:
.if wheels
	.byte $DF, $DF,$DF,$DF,$DF,$DF,$72,$72,$72
        .byte   $72,$48,$66,$82,$03,$27,$CA,$16
        .byte   $04
LF27A:  .byte   $34
.else
	.lobytes DlgBoxProc1
	.lobytes DlgBoxProc2 ; not used
	.lobytes DlgBoxProc3
.endif
DlgBoxProcH:
.if wheels
	.byte $F3,$F3,$F3,$F3,$F3,$F3,$FA
        .byte   $FA,$FA,$FA,$F5,$F5,$F5,$F5,$F5
        .byte   $F5,$F5,$F4,$F5
.else
	.hibytes DlgBoxProc1
	.lobytes DlgBoxProc2 ; yes, lobytes!! -- not used
	.hibytes DlgBoxProc3
.endif

DlgBoxPrep:
.if wheels
LF383 = $F383
LF36E = $F36E
LC58F = $C58F
LF28E:  sec                                     ; F28E 38                       8
        jsr     LF29B                           ; F28F 20 9B F2                  ..
        lda     #$00                            ; F292 A9 00                    ..
        sta     $851D                           ; F294 8D 1D 85                 ...
        jmp     LC58F                           ; F297 4C 8F C5                 L..
LF29A:  clc                                     ; F29A 18                       .
LF29B:  lda     $01                             ; F29B A5 01                    ..
        pha                                     ; F29D 48                       H
        lda     #$35                            ; F29E A9 35                    .5
        sta     $01                             ; F2A0 85 01                    ..
        lda     #$85                            ; F2A2 A9 85                    ..
        sta     $0B                             ; F2A4 85 0B                    ..
        lda     #$1F                            ; F2A6 A9 1F                    ..
        sta     $0A                             ; F2A8 85 0A                    ..
        bcc     LF2B6                           ; F2AA 90 0A                    ..
        jsr     LF36E                           ; F2AC 20 6E F3                  n.
        lda     #$01                            ; F2AF A9 01                    ..
        sta     $D015                           ; F2B1 8D 15 D0                 ...
        bne     LF2B9                           ; F2B4 D0 03                    ..
LF2B6:  jsr     LF383                           ; F2B6 20 83 F3                  ..
LF2B9:  pla                                     ; F2B9 68                       h
        sta     $01                             ; F2BA 85 01                    ..
        rts                                     ; F2BC 60                       `
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
	jsr $F305;xxxCalcDialogCoords
	jsr Rectangle
.endif
@1:	lda #0
	jsr SetPattern
	clc
	jsr $F305;xxxCalcDialogCoords
	MoveW r4, rightMargin
	jsr Rectangle
.if !wheels
	clc
	jsr $F305;xxxCalcDialogCoords
.endif
	lda #$ff
	jsr FrameRectangle
	lda #0
	sta defIconTab
.if !wheels
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
@2:	jsr $F305;xxxCalcDialogCoords
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
	jsr $F29A;xxxDialog_2
	jsr Dialog_1
	MoveB sysDBData, r0L
	ldx dlgBoxCallerSP
	txs
	PushW dlgBoxCallerPC
	rts

Dialog_2:
.if !wheels
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
.if wheels
        lda     LF3D2,x                         ; F3A7 BD D2 F3                 ...
        beq     @2                           ; F3AA F0 0D                    ..
        sta     $08                             ; F3AC 85 08                    ..
        lda     LF3BA,x                         ; F3AE BD BA F3                 ...
        sta     $06                             ; F3B1 85 06                    ..
        lda     LF3C6,x                         ; F3B3 BD C6 F3                 ...
        sta     $07                             ; F3B6 85 07                    ..
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
DialogCopyTab:
.if wheels
LF3BA:  .byte   $22,$9B,$3F,$C0,$F1,$F8,$00,$15 ; F3BA 22 9B 3F C0 F1 F8 00 15  ".?.....
        .byte   $1B,$25,$28,$17                 ; F3C2 1B 25 28 17              .%(.
LF3C6:  .byte   $00,$84,$00,$86,$86,$8F,$D0,$D0 ; F3C6 00 84 00 86 86 8F D0 D0  ........
        .byte   $D0,$D0,$D0,$D0                 ; F3CE D0 D0 D0 D0              ....
LF3D2:  .byte   $17,$26,$02,$31,$E3,$08,$11,$01 ; F3D2 17 26 02 31 E3 08 11 01  .&.1....
        .byte   $03,$02,$07,$01,$00             ; F3DA 03 02 07 01 00           .....
.else
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

DBDoIcons:
.if wheels
        lda     $84A4                           ; F3DF AD A4 84                 ...
.else
	dey
	bne @1
	lda keyVector
	ora keyVector+1
.endif
	bne @1
	lda #>DBKeyVector
	sta keyVector+1
	lda #$95;xxx#<DBKeyVector
	sta keyVector
@1:
.if wheels
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
.if wheels
LF465:  .byte   $AC                             ; F465 AC                       .
LF466:  .byte   $BF,$00,$00,$06,$10             ; F466 BF 00 00 06 10           .....
LF46B:  .byte   $E9                             ; F46B E9                       .
LF46C:  .byte   $F4,$58,$BF,$00,$00,$06,$10,$EC ; F46C F4 58 BF 00 00 06 10 EC  .X......
        .byte   $F4,$30,$F9,$00,$00,$06,$10,$EF ; F474 F4 30 F9 00 00 06 10 EF  .0......
        .byte   $F4,$E5,$F8,$00,$00,$06,$10,$F2 ; F47C F4 E5 F8 00 00 06 10 F2  ........
        .byte   $F4,$81,$F9,$00,$00,$06,$10,$F5 ; F484 F4 81 F9 00 00 06 10 F5  ........
        .byte   $F4,$D4,$F9,$00,$00,$06,$10,$DB ; F48C F4 D4 F9 00 00 06 10 DB  ........
        .byte   $F4                             ; F494 F4                       .
.else
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
.endif

DBKeyVector:
.if wheels
L9D83 = $9D83
L5009 = $5009
L9D80 = $9D80
        lda     $8504                           ; F495 AD 04 85                 ...
        ldy     #$05                            ; F498 A0 05                    ..
LF49A:  cmp     LF4D5,y                         ; F49A D9 D5 F4                 ...
        beq     LF4A3                           ; F49D F0 04                    ..
        dey                                     ; F49F 88                       .
        bpl     LF49A                           ; F4A0 10 F8                    ..
        rts                                     ; F4A2 60                       `
LF4A3:  tya                                     ; F4A3 98                       .
        asl     a                               ; F4A4 0A                       .
        asl     a                               ; F4A5 0A                       .
        asl     a                               ; F4A6 0A                       .
        tay                                     ; F4A7 A8                       .
        lda     #$00                            ; F4A8 A9 00                    ..
        sta     r0L                           ; F4AA 85 02                    ..
LF4AC:  tax                                     ; F4AC AA                       .
        lda     $8810,x                         ; F4AD BD 10 88                 ...
        cmp     LF465,y                         ; F4B0 D9 65 F4                 .e.
        bne     LF4BD                           ; F4B3 D0 08                    ..
        lda     $8811,x                         ; F4B5 BD 11 88                 ...
        cmp     LF466,y                         ; F4B8 D9 66 F4                 .f.
        beq     LF4CC                           ; F4BB F0 0F                    ..
LF4BD:  inc     r0L                           ; F4BD E6 02                    ..
        lda     r0L                           ; F4BF A5 02                    ..
        cmp     $880C                           ; F4C1 CD 0C 88                 ...
        bcs     LF4CB                           ; F4C4 B0 05                    ..
        asl     a                               ; F4C6 0A                       .
        asl     a                               ; F4C7 0A                       .
        asl     a                               ; F4C8 0A                       .
        bne     LF4AC                           ; F4C9 D0 E1                    ..
LF4CB:  rts                                     ; F4CB 60                       `
LF4CC:  lda     LF46B,y                         ; F4CC B9 6B F4                 .k.
        ldx     LF46C,y                         ; F4CF BE 6C F4                 .l.
        jmp     CallRoutine                     ; F4D2 4C D8 C1                 L..
LF4D5:  ora     $7963                           ; F4D5 0D 63 79                 .cy
        ror     $646F                           ; F4D8 6E 6F 64                 nod
.else
	CmpBI keyData, CR
	beq DBIcOK
	rts
.endif

.if wheels
        lda     #$45                            ; F4DB A9 45                    .E
        jsr     L9D80                           ; F4DD 20 80 9D                  ..
        jsr     L5009                           ; F4E0 20 09 50                  .P
        jsr     L9D83                           ; F4E3 20 83 9D                  ..
        lda     #$06                            ; F4E6 A9 06                    ..
        bit     $01A9                           ; F4E8 2C A9 01                 ,..
        bit     $02A9                           ; F4EB 2C A9 02                 ,..
        bit     $03A9                           ; F4EE 2C A9 03                 ,..
        bit     $04A9                           ; F4F1 2C A9 04                 ,..
        bit     $05A9                           ; F4F4 2C A9 05                 ,..
        .byte   $2C                             ; F4F7 2C                       ,
LF4F8:  lda     #$0E                            ; F4F8 A9 0E                    ..
        bit     $0DA9                           ; F4FA 2C A9 0D                 ,..
        sta     $851D                           ; F4FD 8D 1D 85                 ...
        jmp     RstrFrmDialogue                 ; F500 4C BF C2                 L..
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
	bne DBKeyVec1
DBKeyVec1:
	sta sysDBData
	jmp RstrFrmDialogue
.endif

DBDoSYSOPV:
	lda #>DBStringFaultVec
	sta otherPressVec+1
	lda #<DBStringFaultVec
	sta otherPressVec
	rts

DBStringFaultVec:
	bbsf 7, mouseData, DBDoOPVEC_rts
.if !wheels
	lda #DBSYSOPV
	sta sysDBData
.endif
	jmp $F4F8;xxxRstrFrmDialogue

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
.if wheels
        jsr     LF55A                           ; F529 20 5A F5                  Z.
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
.if wheels
        iny                                     ; F536 C8                       .
        iny                                     ; F537 C8                       .
        tya                                     ; F538 98                       .
        pha                                     ; F539 48                       H
        dey                                     ; F53A 88                       .
        lda     ($43),y                         ; F53B B1 43                    .C
        tax                                     ; F53D AA                       .
        dey                                     ; F53E 88                       .
        lda     ($43),y                         ; F53F B1 43                    .C
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
	jsr $F5B1;xxxDBTextCoords
.if wheels
        jsr     LF55A                           ; F54F 20 5A F5                  Z.
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

.if wheels
LF55A:  lda     ($43),y                         ; F55A B1 43                    .C
        sta     r0L                           ; F55C 85 02                    ..
        iny                                     ; F55E C8                       .
        lda     ($43),y                         ; F55F B1 43                    .C
        sta     $03                             ; F561 85 03                    ..
        iny                                     ; F563 C8                       .
        tya                                     ; F564 98                       .
        rts                                     ; F565 60                       `
.endif

DBDoVARSTR:
	clc
	jsr CalcDialogCoords
	jsr $F5B1;xxxDBTextCoords
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
	jsr $F5B1;xxxDBTextCoords
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
	lda #$F4;xxx#>DBKeyVector2
	sta keyVector+1
	lda #$FB;xxx#<DBKeyVector2
	sta keyVector
	LoadB r1L, 0
	tya
	pha
	jsr GetString
	PopB r1L
	rts

DBKeyVector2:
.if !wheels
	LoadB sysDBData, DBGETSTRING
	jmp $F4F8;xxxRstrFrmDialogue
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
	jsr $F890;xxxDBGFilesHelp7
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
LF80F = $F80F
LF43B = $F43B
LF69A = $F69A
L500C = $500C
L9FF1 = $9FF1
        lda     L9FF1                           ; F61C AD F1 9F                 ...
        cmp     #$05                            ; F61F C9 05                    ..
        beq     LF654                           ; F621 F0 31                    .1
        lda     $16                             ; F623 A5 16                    ..
        pha                                     ; F625 48                       H
        sta     $0C                             ; F626 85 0C                    ..
        lda     $17                             ; F628 A5 17                    ..
        pha                                     ; F62A 48                       H
        sta     $0D                             ; F62B 85 0D                    ..
        ora     $0C                             ; F62D 05 0C                    ..
        beq     LF640                           ; F62F F0 0F                    ..
        lda     #$87                            ; F631 A9 87                    ..
        sta     $17                             ; F633 85 17                    ..
        lda     #$EB                            ; F635 A9 EB                    ..
        sta     $16                             ; F637 85 16                    ..
        ldx     #$0C                            ; F639 A2 0C                    ..
        ldy     #$16                            ; F63B A0 16                    ..
        jsr     CopyString                      ; F63D 20 65 C2                  e.
LF640:  lda     #$45                            ; F640 A9 45                    .E
        jsr     L9D80                           ; F642 20 80 9D                  ..
        jsr     L500C                           ; F645 20 0C 50                  .P
        jsr     L9D83                           ; F648 20 83 9D                  ..
        pla                                     ; F64B 68                       h
        sta     $16                             ; F64C 85 16                    ..
        pla                                     ; F64E 68                       h
        sta     $17                             ; F64F 85 17                    ..
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
        sta     $0D                             ; F673 85 0D                    ..
        lda     #$98                            ; F675 A9 98                    ..
        sta     $0C                             ; F677 85 0C                    ..
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
	.word $F72F;xxxDBGFDoArrow

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
	jsr $F890;xxxDBGFilesHelp7
	clc
	lda r2L
	adc #$45
	sta r2H
	jsr IsMseInRegion
	beq @2
	jsr $F883;xxxDBGFilesHelp6
	jsr $F890;xxxDBGFilesHelp7
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
	jsr $F883;xxxDBGFilesHelp6
	jsr $F7D9;xxxDBGFilesHelp2
.if wheels
        lda     $8515                           ; F71D AD 15 85                 ...
        beq     @X                           ; F720 F0 07                    ..
        ldy     $88A7                           ; F722 AC A7 88                 ...
        dey                                     ; F725 88                       .
        jmp     LF4A3                           ; F726 4C A3 F4                 L..
@X:	lda     #$1E                            ; F729 A9 1E                    ..
        sta     $8515                           ; F72B 8D 15 85                 ...
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
        sta     $03                             ; F765 85 03                    ..
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
        sta     $03                             ; F7D0 85 03                    ..
        lda     #$00                            ; F7D2 A9 00                    ..
        sta     r0L                           ; F7D4 85 02                    ..
        sta     $08                             ; F7D6 85 08                    ..
        rts                                     ; F7D8 60                       `
.else
	jsr $F883;xxxDBGFilesHelp6
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
@6:	jsr $F7D9;xxxDBGFilesHelp2
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
        sta     $0D                             ; F7E8 85 0D                    ..
        lda     $8859                           ; F7EA AD 59 88                 .Y.
        sta     $0C                             ; F7ED 85 0C                    ..
        ldy     #$0C                            ; F7EF A0 0C                    ..
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
	jsr $F883;xxxDBGFilesHelp6
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
	adc #14
	sta r2H
	inc r2L
	dec r2H
	inc r3L
	bne @1
	inc r3H
@1:	ldx #r4
	jsr Ddec
	rts

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
