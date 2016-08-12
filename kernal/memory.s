; memory handling functions (copy, compare, move, fill)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "jumptab.inc"

.global _ClearRam
.global _CmpFString
.global _CmpString
.global _CopyFString
.global _CopyString
.global _FillRam
.global _InitRam
.global _MoveData
.global _i_FillRam
.global _i_MoveData

.segment "memory1"

_ClearRam:
	LoadB r2L, NULL
_FillRam:
	lda r0H
	beq CRam2
	lda r2L
	ldy #0
CRam1:
	sta (r1),Y
	dey
	bne CRam1
	inc r1H
	dec r0H
	bne CRam1
CRam2:
	lda r2L
	ldy r0L
	beq CRam4
	dey
CRam3:
	sta (r1),Y
	dey
	cpy #$FF
	bne CRam3
CRam4:
	rts

_InitRam:
	ldy #0
	lda (r0),Y
	sta r1L
	iny
	ora (r0),Y
	beq IRam3
	lda (r0),Y
	sta r1H
	iny
	lda (r0),Y
	sta r2L
	iny
IRam0:
	tya
	tax
	lda (r0),Y
	ldy #0
	sta (r1),Y
	inc r1L
	bne IRam1
	inc r1H
IRam1:
	txa
	tay
	iny
	dec r2L
	bne IRam0
	tya
	add r0L
	sta r0L
	bcc IRam2
	inc r0H
IRam2:
	bra _InitRam
IRam3:
	rts

.segment "memory2"

_CopyString:
	lda #0
_CopyFString:
	stx CSSource
	sty CSDest
	tax
	ldy #0
CSSource	= *+1
CStril0:
	lda (0),Y
CSDest		= *+1
	sta (0),Y
	bne CStril1
	beqx CStril2
CStril1:
	iny
	beq CStril2
	beqx CStril0
	dex
	bne CStril0
CStril2:
	rts

_i_MoveData:
	PopW returnAddress
	jsr GetMDataDatas
	iny
	lda (returnAddress),Y
	sta r2H
	jsr _MoveData
	php
	lda #7
	jmp DoInlineReturn

GetMDataDatas:
	ldy #1
	lda (returnAddress),Y
	sta r0L
	iny
	lda (returnAddress),Y
	sta r0H
	iny
	lda (returnAddress),Y
	sta r1L
	iny
	lda (returnAddress),Y
	sta r1H
	iny
	lda (returnAddress),Y
	sta r2L
	rts

_MoveData:
	lda r2L
	ora r2H
	beq MData6
	PushW r0
	PushB r1H
	PushB r2H
	PushB r3L
.if (REUPresent)
	lda sysRAMFlg
	bpl MData0
	PushB r1H
	LoadB r1H, 0
	sta r3L
	jsr StashRAM
	PopB r0H
	MoveB r1L, r0L
	jsr FetchRAM
	bra MData5
.endif
MData0:
	CmpW r0, r1
MData1:
	bcs MData2
	bcc MData7
MData2:
	ldy #0
	lda r2H
	beq MData4
MData3:
	lda (r0),Y
	sta (r1),Y
	iny
	bne MData3
	inc r0H
	inc r1H
	dec r2H
	bne MData3
MData4:
	cpy r2L
	beq MData5
	lda (r0),Y
	sta (r1),Y
	iny
	bra MData4
MData5:
	PopB r3L
	PopB r2H
	PopB r1H
	PopW r0
MData6:
	rts

MData7:
	clc
	lda r2H
	adc r0H
	sta r0H
	clc
	lda r2H
	adc r1H
	sta r1H
	ldy r2L
	beq MData9
MData8:
	dey
	lda (r0),Y
	sta (r1),Y
	tya
	bne MData8
MData9:
	dec r0H
	dec r1H
	lda r2H
	beq MData5
MData10:
	dey
	lda (r0),Y
	sta (r1),Y
	tya
	bne MData10
	dec r2H
	bra MData9

_CmpString:
	lda #0
_CmpFString:
	stx CMSSource
	sty CMSDest
	tax
	ldy #0
CMSSource	= *+1
CMStrl0:
	lda (0),Y
CMSDest 	= *+1
	cmp (0),Y
	bne CMStrl2
	cmp #0
	bne CMStrl1
	beqx CMStrl2
CMStrl1:
	iny
	beq CMStrl2
	beqx CMStrl0
	dex
	bne CMStrl0
	lda #0
CMStrl2:
	rts

.segment "memory3"

_i_FillRam:
	PopW returnAddress
	jsr GetMDataDatas
	jsr _FillRam
	php
	lda #6
	jmp DoInlineReturn
