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

.import CalcIconDescTab
.import defIconTab
.import CalcDialogCoords
.import DBDefIconsTab
.import DBKeyVector
.import TimersTab
.import menuOptNumber
.import L8871

.global DBIconsHelp2
.global DialogRestore
.global DialogSave
.global DBDoIcons
.global DBDoUSRICON

.segment "dlgbox1d"

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
.ifdef wheels_size_and_speed ; 17 vs. 21 bytes and faster
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
.ifdef wheels_size_and_speed
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
.ifdef wheels_button_shortcuts ; install keyVector for all button types
	lda keyVector+1
.else
	dey ; command-1: "OK"==0
	bne @1 ; not "OK"
	lda keyVector
	ora keyVector+1
.endif
	bne @1
	LoadW keyVector, DBKeyVector
@1:
.ifdef wheels_button_shortcuts
	dey
.endif
	tya
	asl
	asl
	asl
	add #<DBDefIconsTab
	sta r5L
	lda #0
	adc #>DBDefIconsTab
	sta r5H
	jsr DBIconsHelp1
.ifdef bsw128
	ldy #4
	lda (r5),y
	and #$FF
	ora L8871
	sta (r5),y
.endif
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
.ifdef bsw128
	ora L8871
.endif
@2:	cpy #3
	bne @3
	lda r2L
@3:	sta defIconTab,x
	inx
	iny
	cpy #8
	bne @1
@4:	rts

