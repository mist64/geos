; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "c64.inc"

.import GetStartHAddr
.import SetFHeadVector
.import SetBufTSVector

.import GetFreeDirBlk
.import BldGDirEntry
.import WriteFile
.import PutBlock
.import PutDirHead
.import SetGDirEntry
.import BlkAlloc
.import GetDirHead

.global SGDCopyDate
.global _SetGDirEntry
.global _SaveFile

.segment "files8"

_SaveFile:
	ldy #0
@1:	lda (r9),y
	sta fileHeader,y
	iny
	bne @1
	jsr GetDirHead
.ifdef wheels
	bne @2
.else
	bnex @2
.endif
	jsr GetDAccLength
	jsr SetBufTSVector
	jsr BlkAlloc
	bnex @2
	jsr SetBufTSVector
	jsr SetGDirEntry
	bnex @2
	jsr PutDirHead
.ifdef wheels
	bne @2
.else
	bnex @2
.endif
	sta fileHeader+O_GHINFO_TXT
.ifdef wheels
	MoveW_ dirEntryBuf+OFF_GHDR_PTR, r1
.else
	MoveW dirEntryBuf+OFF_GHDR_PTR, r1
.endif
	jsr SetFHeadVector
	jsr PutBlock
.ifdef wheels
	bne @2
.else
	bnex @2
.endif
	jsr ClearNWrite
	bnex @2
	jsr GetStartHAddr
	jsr WriteFile
@2:	rts

GetDAccLength:
.ifdef wheels
	jsr LD8D3
	jsr @1
	CmpBI fileHeader+O_GHSTR_TYPE, VLIR
	bne @2
@1:	clc
	lda #$fe
	adc r2L
	sta r2L
	bcc @2
	inc r2H
@2:	rts
.else
	lda fileHeader+O_GHEND_ADDR
	sub fileHeader+O_GHST_ADDR
	sta r2L
	lda fileHeader+O_GHEND_ADDR+1
	sbc fileHeader+O_GHST_ADDR+1
	sta r2H
	jsr @1
	CmpBI fileHeader+O_GHSTR_TYPE, VLIR
	bne @2
@1:	AddVW $fe, r2
@2:	rts
.endif

.ifdef wheels ; reused code
.global LD8D3
LD8D3:	lda fileHeader+O_GHEND_ADDR
	sub fileHeader+O_GHST_ADDR
	sta r2L
	lda fileHeader+O_GHEND_ADDR+1
	sbc fileHeader+O_GHST_ADDR+1
	sta r2H
	rts
.endif

ClearNWrite:
	ldx #0
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne @2
	MoveW dirEntryBuf+OFF_DE_TR_SC, r1
	txa
	tay
@1:	sta diskBlkBuf,y
	iny
	bne @1
	dey
	sty diskBlkBuf+1
	jsr WriteBuff
@2:	rts

_SetGDirEntry:
	jsr BldGDirEntry
	jsr GetFreeDirBlk
.ifdef bsw128
	bnex SetGDirEntry_rts
.else
	bnex SGDCopyDate_rts
.endif
.ifdef wheels
	sty r5L
	.assert <diskBlkBuf = 0, error, "diskBlkBuf must be page-aligned!"
.else
	tya
	addv <diskBlkBuf
	sta r5L
.endif
	lda #>diskBlkBuf
.ifndef wheels
	adc #0
.endif
	sta r5H
	ldy #$1d
@1:	lda dirEntryBuf,y
	sta (r5),y
	dey
	bpl @1
	jsr SGDCopyDate
.ifdef bsw128
	jsr WriteBuff
SetGDirEntry_rts:
	rts
.else
	jmp WriteBuff
.endif

SGDCopyDate:
	ldy #$17
@1:	lda dirEntryBuf+$ff,y
	sta (r5),y
	iny
	cpy #$1c
	bne @1
SGDCopyDate_rts:
	rts
