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

.import SetBufTSVector
.import SetFHeadVector
.import SGDCopyDate
.import RecordDirOffs
.import RecordDirTS
.import RecordTableTS

.import WriteFile
.import BlkAlloc
.import PutBlock
.import ReadFile
.import FindFile
.import DoneWithIO
.import FreeBlock
.import InitForIO
.import EnterTurbo
.import GetBlock
.import PutDirHead
.import GetDirHead

.ifdef wheels
.import LoadDiskBlkBuf
.import ReadR9
.endif

.global _AppendRecord
.global _CloseRecordFile
.global _WriteRecord
.global _UpdateRecordFile
.global _RenameFile
.global _ReadRecord
.global _ReadByte
.global _PreviousRecord
.global _PointRecord
.global _OpenRecordFile
.global _NextRecord
.global _InsertRecord
.global _FreeFile
.global _FastDelFile
.global _DeleteFile
.global _DeleteRecord

.segment "files10"

_DeleteFile:
	jsr FindNDelete
	beqx @1
	rts
@1:	LoadW r9, dirEntryBuf
_FreeFile:
	php
	sei
	jsr GetDirHead
.ifdef wheels
	bne @3
.else
	bnex @3
.endif
	ldy #OFF_GHDR_PTR
	lda (r9),y
	beq @1
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr FreeBlockChain
	bnex @3
@1:	ldy #OFF_DE_TR_SC
.ifdef wheels
	jsr ReadR9
	jsr SetFHeadVector
	jsr GetBlock
	bne @3
.else
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
.endif
	jsr FreeBlockChain
	bnex @3
	ldy #OFF_GSTRUC_TYPE
	lda (r9),y
.ifdef onlyVLIR
	beq @2
.else
	cmp #VLIR
	bne @2
.endif
	jsr DeleteVlirChains
	bnex @3
@2:	jsr PutDirHead
@3:	plp
	rts

DeleteVlirChains:
.ifdef wheels
	ldx #2
@1:	lda fileHeader+1,x
	sta r1H
	lda fileHeader,x
	sta r1L
	beq @2
	txa
	pha
	jsr FreeBlockChain
	pla
	cpx #0
	bne @3
	tax
@2:	inx
	inx
	bne @1
@3:	rts
.else
.ifdef bsw128
	LoadW r4, fileHeader
	jsr GetBlock
.else
	ldy #0
@1:	lda diskBlkBuf,y
	sta fileHeader,y
	iny
	bne @1
.endif
	ldy #2
@2:	tya
	beq @3
	lda fileHeader,y
	sta r1L
	iny
	lda fileHeader,y
	sta r1H
	iny
	lda r1L
	beq @2
	tya
	pha
	jsr FreeBlockChain
	pla
	tay
	beqx @2
@3:	rts
.endif

FreeBlockChain:
.ifdef wheels
	php
	sei
	MoveW r1, r6
	jsr LoadDiskBlkBuf
	LoadW_ r2, 0
@1:	jsr FreeBlock
	beqx @2
	cpx #BAD_BAM
	bne @4
@2:	inc r2L
	bne @3
	inc r2H
@3:	jsr GetLink
	bnex @4
	lda diskBlkBuf+1
	sta r6H
	sta r1H
	lda diskBlkBuf
	sta r6L
	sta r1L
	bne @1
@4:	plp
	rts
.elseif .defined(bsw128)
	MoveW r1, r6
	LoadW_ r2, 0
	jsr EnterTurbo
	jsr InitForIO
@1:	jsr FreeBlock
	bnex @4
	IncW r2
	PushW r2
	MoveW r6, r1
	LoadW r4, diskBlkBuf
	jsr ReadLink
	PopW r2
	bnex @4
	lda diskBlkBuf
	beq @3
	sta r6L
	lda diskBlkBuf+1
	sta r6H
	bra @1
@3:	ldx #0
@4:	jmp DoneWithIO
.else
	MoveW r1, r6
	LoadW_ r2, 0
@1:	jsr FreeBlock
	bnex @4
	IncW r2
	PushW r2
	MoveW r6, r1
	jsr ReadBuff
	PopW r2
	bnex @4
	lda diskBlkBuf
	beq @3
	sta r6L
	lda diskBlkBuf+1
	sta r6H
	bra @1
@3:	ldx #NULL
@4:	rts
.endif

FindNDelete:
	MoveW r0, r6
	jsr FindFile
.ifdef wheels
	bnex LDAB8
.else
	bnex @1
	lda #0
.endif
	tay
	sta (r5),y
.ifdef wheels
	jmp WriteBuff
.else
	jsr WriteBuff
@1:	rts
.endif

_FastDelFile:
	PushW r3
	jsr FindNDelete
	PopW r3
.ifdef wheels_size_and_speed ; inlined
	bnex LDAB8
	PushW r3
	jsr GetDirHead
	PopW r3
@X:	ldy #0
	lda (r3),y
	beq @Y
	sta r6L
	iny
	lda (r3),y
	sta r6H
	jsr FreeBlock
	bnex LDAB8
	clc
	lda #2
	adc r3L
	sta r3L
	bcc @X
	inc r3H
	bne @X
@Y:	jmp PutDirHead
LDAB8:	rts
.else
	bnex @1
	jsr FreeChainByTab
@1:	rts

FreeChainByTab:
	PushW r3
	jsr GetDirHead
	PopW r3
@1:	ldy #0
	lda (r3),y
	beq @2
	sta r6L
	iny
	lda (r3),y
	sta r6H
	jsr FreeBlock
	bnex @3
	AddVW 2, r3
	bra @1
@2:
	jsr PutDirHead
@3:
	rts
.endif

_RenameFile:
	PushW r0
	jsr FindFile
	PopW r0
	bnex @4
	AddVW OFF_FNAME, r5
	ldy #0
@1:	lda (r0),y
	beq @2
	sta (r5),y
	iny
	cpy #16
	bcc @1
	bcs @3
@2:	lda #$a0
	sta (r5),y
	iny
	cpy #16
	bcc @2
@3:
.ifdef wheels
	jmp WriteBuff
.else
	jsr WriteBuff
.endif
@4:	rts

_OpenRecordFile:
.ifdef useRamExp
	lda DeskTopOpen
	bmi OpRFile1
	LoadW r6, DeskTopName
	ldx #r0
	ldy #r6
	jsr CmpString
	bne OpRFile1
	LoadB DeskTopOpen,1
	ldx #0
	rts
OpRFile1:
	LoadB DeskTopOpen,0
.endif
	MoveW r0, r6
	jsr FindFile
	bnex ClearRecordTableTS
	ldx #10
	ldy #OFF_CFILE_TYPE
	lda (r5),y
	and #%00111111
	cmp #USR
	bne ClearRecordTableTS
	ldy #OFF_GSTRUC_TYPE
	lda (r5),y
.ifdef onlyVLIR
	beq ClearRecordTableTS
.else
	cmp #VLIR
	bne ClearRecordTableTS
.endif
	ldy #OFF_DE_TR_SC
	lda (r5),y
	sta RecordTableTS
	iny
	lda (r5),y
	sta RecordTableTS+1
	MoveW r1, RecordDirTS
	MoveW r5, RecordDirOffs
	MoveW dirEntryBuf+OFF_SIZE, fileSize
	jsr GetVLIRTab
	bnex ClearRecordTableTS
	sta usedRecords
	ldy #2
@1:	lda fileHeader,y
	ora fileHeader+1,y
	beq @2
	inc usedRecords
	iny
	iny
	bne @1
@2:	ldy #0
	lda usedRecords
	bne @3
	dey
@3:	sty curRecord
	ldx #NULL
	stx fileWritten
	rts

_CloseRecordFile:
	jsr _UpdateRecordFile
ClearRecordTableTS:
	LoadB RecordTableTS, NULL
	rts

_UpdateRecordFile:
	ldx #0
	lda fileWritten
	beq @1
	jsr PutVLIRTab
	bnex @1
	MoveW RecordDirTS, r1
	jsr ReadBuff
.ifdef wheels
	bne @1
.else
	bnex @1
.endif
	MoveW RecordDirOffs, r5
	jsr SGDCopyDate
	ldy #OFF_SIZE
	lda fileSize
	sta (r5),y
	iny
	lda fileSize+1
	sta (r5),y
	jsr WriteBuff
.ifdef wheels
	bne @1
.else
	bnex @1
.endif
	jsr PutDirHead
	lda #NULL
	sta fileWritten
@1:	rts

.ifdef useRamExp
_NextRecord:
	lda curRecord
	addv 1
	bra _PointRcrdSt
_PreviousRecord:
	lda curRecord
	subv 1
	bra _PointRcrdSt

_PointRecord:
	ldx DeskTopOpen
	beq _PointRcrdSt
	sta DeskTopRecord
	ldx #0
	rts
_PointRcrdSt:
.else
_NextRecord:
	lda curRecord
	addv 1
	bra _PointRecord
_PreviousRecord:
	lda curRecord
	subv 1
_PointRecord:
.endif

	tax
	bmi @1
	cmp usedRecords
	bcs @1
	sta curRecord
	jsr GetVLIRChainTS
.ifdef wheels
	tay
.else
	ldy r1L
.endif
	ldx #0
	beq @2
@1:	ldx #INV_RECORD
@2:	lda curRecord
	rts

_DeleteRecord:
.ifdef wheels_size
	jsr ReadyForUpdVLIR2
.else
	ldx #INV_RECORD
	lda curRecord
	bmi return2
	jsr ReadyForUpdVLIR
.endif
	bnex return2
	jsr GetVLIRChainTS
	MoveB curRecord, r0L
	jsr MoveBackVLIRTab
	bnex return2
	CmpB curRecord, usedRecords
	bcc @1
	dec curRecord
@1:	ldx #NULL
	lda r1L
	beq return2
	jsr FreeBlockChain
	bnex return2
	SubB r2L, fileSize
	bcs @2
	dec fileSize+1
@2:
.ifndef wheels
	ldx #NULL
.endif
return2:
	rts

_InsertRecord:
.ifdef wheels_size ; use common code
	jsr ReadyForUpdVLIR2
	bnex return2
	lda curRecord
	sta r0L
	jmp MoveForwVLIRTab
.else
	ldx #INV_RECORD
	lda curRecord
	bmi @1
	jsr ReadyForUpdVLIR
	bnex @1
	lda curRecord
	sta r0L
	jsr MoveForwVLIRTab
@1:	rts
.endif

.ifdef wheels_size ; reused code
ReadyForUpdVLIR2:
	ldx #INV_RECORD
	lda curRecord
	bmi return2
	jmp ReadyForUpdVLIR
.endif

_AppendRecord:
	jsr ReadyForUpdVLIR
	bnex @1
	lda curRecord
	addv 1
	sta r0L
	jsr MoveForwVLIRTab
	bnex @1
	MoveB r0L, curRecord
@1:	rts

_ReadRecord:
.ifdef useRamExp
	ldx DeskTopOpen
	beq ReaRec0
	jsr RamExpGetStat
	ldx DeskTopRecord
	lda diskBlkBuf+DTOP_CHAIN,x
	sta r1L
	lda diskBlkBuf+DTOP_CHAIN+1,x
	sub r1L
	sta r2H
	LoadB r1H, 0
	MoveW r7, r0
	jsr RamExpRead
	ldx #0
	rts
ReaRec0:
.endif
	ldx #INV_RECORD
	lda curRecord
	bmi @1
	jsr GetVLIRChainTS
.ifndef wheels
	lda r1L
.endif
	tax
	beq @1
	jsr ReadFile
	lda #$ff
@1:	rts

_WriteRecord:
.ifndef wheels
	ldx #INV_RECORD
	lda curRecord
	bmi @5
.endif
	PushW r2
.ifdef wheels_size
	jsr ReadyForUpdVLIR2
.else
	jsr ReadyForUpdVLIR
.endif
	PopW r2
	bnex @5
	jsr GetVLIRChainTS
.ifndef wheels
	lda r1L
.endif
	bne @1
	ldx #0
	lda r2L
	ora r2H
.ifdef wheels
	bne @3
@5:	rts
.else
	beq @5
	bne @3
.endif
@1:	PushW r2
	PushW r7
	jsr FreeBlockChain
	MoveB r2L, r0L
	PopW r7
	PopW r2
	bnex @5
	SubB r0L, fileSize
	bcs @2
	dec fileSize+1
@2:	lda r2L
	ora r2H
	beq @4
@3:	jmp WriteVLIRChain
@4:	ldy #$FF
	sty r1H
	iny
	sty r1L
.ifdef wheels
	jmp PutVLIRChainTS
.else
	jsr PutVLIRChainTS
@5:	rts
.endif

GetVLIRTab:
	jsr SetVLIRTable
	bnex @1
	jsr GetBlock
@1:	rts

PutVLIRTab:
	jsr SetVLIRTable
	bnex @1
	jsr PutBlock
@1:	rts

SetVLIRTable:
	ldx #UNOPENED_VLIR
	lda RecordTableTS
	beq @1
	sta r1L
	lda RecordTableTS+1
	sta r1H
	jsr SetFHeadVector
	ldx #NULL
@1:	rts

MoveBackVLIRTab:
	ldx #INV_RECORD
	lda r0L
	bmi @3
	asl
	tay
	lda #$7e
	sub r0L
	asl
	tax
	beq @2
@1:	lda fileHeader+4,y
	sta fileHeader+2,y
	iny
	dex
	bne @1
@2:	stx fileHeader+$fe
	stx fileHeader+$ff
	dec usedRecords
@3:	rts

MoveForwVLIRTab:
	ldx #OUT_OF_RECORDS
	CmpBI usedRecords, $7f
	bcs @3
	ldx #INV_RECORD
	lda r0L
	bmi @3
	ldy #$fe
	lda #$7e
	sub r0L
	asl
	tax
	beq @2
@1:	lda fileHeader-1,y
	sta fileHeader+1,y
	dey
	dex
	bne @1
@2:	txa
	sta fileHeader,y
	lda #$ff
	sta fileHeader+1,y
	inc usedRecords
@3:	rts

GetVLIRChainTS:
	lda curRecord
	asl
	tay
.ifdef wheels
	lda fileHeader+3,y
	sta r1H
	lda fileHeader+2,y
	sta r1L
.else
	lda fileHeader+2,y
	sta r1L
	lda fileHeader+3,y
	sta r1H
.endif
	rts

PutVLIRChainTS:
	lda curRecord
	asl
	tay
	lda r1L
	sta fileHeader+2,y
	lda r1H
	sta fileHeader+3,y
	rts

WriteVLIRChain:
	jsr SetBufTSVector
	PushW r7
	jsr BlkAlloc
	PopW r7
	bnex @1
	PushB r2L
	jsr SetBufTSVector
	jsr WriteFile
	PopB r2L
	bnex @1
	MoveW fileTrScTab, r1
	jsr PutVLIRChainTS
	bnex @1
	AddB r2L, fileSize
	bcc @1
	inc fileSize+1
@1:	rts

ReadyForUpdVLIR:
	ldx #NULL
	lda fileWritten
	bne @1
	jsr GetDirHead
.ifdef wheels
	bne @1
.else
	bnex @1
.endif
	lda #$ff
	sta fileWritten
@1:	rts

_ReadByte:
	ldy r5H
	cpy r5L
	beq @2
	lda (r4),y
	inc r5H
	ldx #NULL
@1:	rts
@2:	ldx #BFR_OVERFLOW
	lda r1L
	beq @1
	jsr GetBlock
.ifdef wheels
	bne @1
.else
	bnex @1
.endif
	ldy #2
	sty r5H
	dey
	lda (r4),y
	sta r1H
	tax
	dey
	lda (r4),y
	sta r1L
	beq @3
	ldx #$ff
@3:	inx
	stx r5L
	bra _ReadByte

