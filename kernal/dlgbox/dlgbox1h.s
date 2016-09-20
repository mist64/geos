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

.import DBGFDoArrow
.import DBGFArrowPic
.import DBGFTableIndex
.import DBGFileSelected
.import DBGFilesHelp3
.import DBGFilesHelp2
.import DBGFilesHelp5
.import DBGFPressVector
.import DBIconsHelp2
.import DBGFilesFound
.import DBGFilesHelp7
.import DBGFNameTable
.import DBGFOffsTop
.import DBGFOffsLeft
.import CalcDialogCoords

.import FindFTypes
.import HorizontalLine
.import FrameRectangle
.import RstrFrmDialogue
.import GetString
.import PutString

.ifdef wheels
.import SetupRAMOpCall
.import RstrKernal
.import GetFEntries
.import GetNewKernal
.import DBKeyVector2
.import FetchRAM
.import CopyString
.endif

.global DBGFArrowX
.global DBDoGETFILES
.global DBDoGETSTR
.global DBDoTXTSTR
.global DBDoVARSTR

.ifdef wheels
.global StringGetNext
.endif

.segment "dlgbox1h"

DBDoTXTSTR:
	clc
	jsr CalcDialogCoords
	jsr DBTextCoords
.ifdef wheels_size
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

.ifdef wheels_size
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
	LoadW keyVector, DBKeyVector2
	LoadB r1L, 0
	tya
	pha
	jsr GetString
	PopB r1L
	rts

.ifndef wheels_size ; code reuse
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
.ifdef wheels_dlgbox_features ; ???
	addv 4
.else
	addv 7
.endif
	pha
	lda r2H
.ifdef wheels_dlgbox_features ; ???
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
.ifdef wheels_dlgbox_features ; ???
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
.ifdef wheels_dlgbox_features ; ???
	lda #0
	jsr SetupRAMOpCall
	jsr FetchRAM
.endif
	LoadW otherPressVec, DBGFPressVector
.ifndef wheels_dlgbox_features ; ???
	jsr DBGFilesHelp1
.endif
	jsr DBGFilesHelp5
	jsr DBGFilesHelp2
@2:	PopB r1L
	rts

.ifndef wheels_dlgbox_features ; xxx
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
.ifdef wheels_dlgbox_features
	.byte 8, 8
.elseif .defined(bsw128)
	.byte DOUBLE_B | 3, 12
.else
	.byte 3, 12
.endif
	.word DBGFDoArrow

