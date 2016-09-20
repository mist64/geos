; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Loading: LdFile, GetFile syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "c64.inc"

.import UNK_4
.import UNK_5
.import A885F
.import A885E

.import ReadFile
.import GetFHdrInfo
.import LdApplic
.import LdDeskAcc
.import FindFile
.import MoveBData
.ifdef bsw128
.import _FindFile
.endif

.global _LdFile
.global _GetFile
.ifdef bsw128
.global _LdFile2
.endif

.segment "load3"

.ifdef bsw128
; printer driver cache
PrntDrvMemTab:
	.word prntDrvMemBuff
	.word PRINTBASE
	.word $0640
	.byte 1, 1

; file header for printer driver
FileHeadMemTab:
	.word fileHeadMemBuff
	.word fileHeader
	.word $0100

_GetFile:
	bbrf 4, sysRAMFlg, _GetFileOld
	CmpBI r6H, >PrntFilename
	bne _GetFileOld
	lda r6L
	sub #<PrntFilename
	ora r0L
	bne _GetFileOld
	ldy #7
@1:	lda PrntDrvMemTab,y
	sta r0L,y
	dey
	bpl @1
	jsr MoveBData
	ldy #5
@2:	lda FileHeadMemTab,y
	sta r0L,y
	dey
	bpl @2
	jsr MoveBData
	ldx #0
GetFile_rts2:
	rts
.endif

.if .defined(bsw128) || .defined(wheels)
.global _GetFileOld
_GetFileOld:
.else
_GetFile:
.endif
	jsr UNK_5
	jsr FindFile
.ifdef bsw128
	bnex GetFile_rts2
.else
	bnex GetFile_rts
.endif
	jsr UNK_4
	LoadW r9, dirEntryBuf
	CmpBI dirEntryBuf + OFF_GFILE_TYPE, DESK_ACC
	bne @1
	jmp LdDeskAcc
@1:	cmp #APPLICATION
	beq @2
	cmp #AUTO_EXEC
	bne _LdFile
@2:	jmp LdApplic

_LdFile:
	jsr GetFHdrInfo
.ifdef bsw128
	beqx _LdFile2
	rts
.else
	bnex GetFile_rts
.endif
_LdFile2:
	CmpBI fileHeader + O_GHSTR_TYPE, VLIR
	bne @1
	ldy #OFF_DE_TR_SC
.ifdef wheels
.import ReadR9
	jsr ReadR9
	jsr ReadBuff
	bne GetFile_rts
.else
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr ReadBuff
	bnex GetFile_rts
.endif
	ldx #INV_RECORD
	lda diskBlkBuf + 2
	sta r1L
	beq GetFile_rts
	lda diskBlkBuf + 3
	sta r1H
@1:	bbrf 0, A885E, @2
	MoveW A885F, r7
@2:	lda #$ff
	sta r2L
	sta r2H
	jsr ReadFile
GetFile_rts:
	rts
