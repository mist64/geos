; disk and file related functions (maybe I should split VLIR functions?)

.include "const.i"
.include "geossym.i"
.include "geosmac.i"
.include "equ.i"
.include "kernal.i"
.import DkNmTab, FreeBlock, LoKernal, GetFreeDirBlk, BldGDirEntry, WriteBuff, WriteFile, PutBlock, PutDirHead, SetGDirEntry, BlkAlloc, GetDirHead, StartAppl, LdFile, FastDelFile, Dialog_2, GetFile, _MNLP, InitGEOEnv, UseSystemFont, DlgBoxPrep, GetBlock, FetchRAM, ExitTurbo, GetNxtDirEntry, Get1stDirEntry, ClearRam, ReadFile, ReadBuff, GetFHdrInfo, LdApplic, LdDeskAcc, UNK_4, FindFile, UNK_5
.global _AppendRecord, _BldGDirEntry, _CloseRecordFile, _DeleteFile, _DeleteRecord, _FastDelFile, _FindFTypes, _FindFile, _FollowChain, _FreeFile, _GetFHdrInfo, _GetFile, _GetPtrCurDkNm, _InsertRecord, _LdApplic, _LdDeskAcc, _LdFile, _OpenRecordFile, _ReadByte, _ReadRecord, _RenameFile, _RstrAppl, _SaveFile, _SetDevice, _SetGDirEntry, _UpdateRecordFile, _WriteRecord, _NextRecord, _PointRecord, _PreviousRecord

.segment "files"

_GetFile:
	jsr UNK_5
	jsr FindFile
	bnex GFile5
	jsr UNK_4
	LoadW r9, dirEntryBuf
	CmpBI dirEntryBuf + OFF_GFILE_TYPE, DESK_ACC
	bne GFile0
	jmp LdDeskAcc
GFile0:
	cmp #APPLICATION
	beq GFile1
	cmp #AUTO_EXEC
	bne _LdFile
GFile1:
	jmp LdApplic

_LdFile:
	jsr GetFHdrInfo
	bnex GFile5
	CmpBI fileHeader + O_GHSTR_TYPE, VLIR
	bne GFile3
	ldy #OFF_DE_TR_SC
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr ReadBuff
	bnex GFile5
	ldx #INV_RECORD
	lda diskBlkBuf + 2
	sta r1L
	beq GFile5
	lda diskBlkBuf + 3
	sta r1H
GFile3:
	bbrf 0, A885E, GFile4
	MoveW A885F, r7
GFile4:
	LoadW r2, $ffff
	jsr ReadFile
GFile5:
	rts

_FollowChain:
	php
	sei
	PushB r3H
	ldy #0
FChain0:
	lda r1L
	sta (r3),y
	iny
	lda r1H
	sta (r3),y
	iny
	bne FChain1
	inc r3H
FChain1:
	lda r1L
	beq FChain2
	tya
	pha
	jsr ReadBuff
	pla
	tay
	bnex FChain3
	MoveW diskBlkBuf, r1
	bra FChain0
FChain2:
	ldx #0
FChain3:
	PopB r3H
	plp
FChain4:
	rts

_FindFTypes:
.if (useRamExp)
	CmpWI r7, ($0100+SYSTEM)
	bne FFTypesStart
	CmpWI r6, $8b80
	bne FFTypesStart
	LoadB DeskTopOpen, 1
	LoadW r5, DeskTopName
	ldx #r5
	ldy #r6
	jmp CopyString
FFTypesStart:
.endif
	php
	sei
	MoveW r6, r1
	LoadB r0H, 0
	lda r7H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	adc r7H
	sta r0L
	bcc *+4
	inc r0H
	jsr ClearRam
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex FFTypes5
FFTypes1:
	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq FFTypes4
	ldy #OFF_GFILE_TYPE
	lda (r5),y
	cmp r7L
	bne FFTypes4
	jsr GetHeaderFileName
	bnex FFTypes5
	tya
	bne FFTypes4
	ldy #OFF_FNAME
FFTypes2:
	lda (r5),y
	cmp #$a0
	beq FFTypes3
	sta (r6),y
	iny
	cpy #OFF_FNAME + $10
	bne FFTypes2
FFTypes3:
	lda #NULL
	sta (r6),y
	AddVW $11, r6
	dec r7H
	beq FFTypes5
FFTypes4:
	jsr GetNxtDirEntry
	bnex FFTypes5
	tya
	beq FFTypes1
FFTypes5:
	plp
	rts

SetBufTSVector:
	LoadW r6, fileTrScTab
	rts

GetStartHAddy:
	MoveW fileHeader + O_GHST_ADDR, r7
	rts

SetFHeadVector:
	LoadW r4, fileHeader
	rts

_FindFile:
	php
	sei
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex FFile7
FFile1:
	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq FFile4
	ldy #OFF_FNAME
FFile2:
	lda (r6),y
	beq FFile3
	cmp (r5),y
	bne FFile4
	iny
	bne FFile2
FFile3:
	cpy #OFF_FNAME + $10
	beq FFile5
	lda (r5),y
	iny
	cmp #$a0
	beq FFile3
FFile4:
	jsr GetNxtDirEntry
	bnex FFile7
	tya
	beq FFile1
	ldx #FILE_NOT_FOUND
	bne FFile7
FFile5:
	ldy #0
FFile6:
	lda (r5),y
	sta dirEntryBuf,y
	iny
	cpy #$1e
	bne FFile6
	ldx #NULL
FFile7:
	plp
	rts

_SetDevice:
	cmp curDevice
	beq SetDev2
	pha
	CmpBI curDevice, 8
	bcc SetDev1
	cmp #12
	bcs SetDev1
	jsr ExitTurbo
SetDev1:
	pla
	sta curDevice
SetDev2:
	cmp #8
	bcc SetDev3
	cmp #12
	bcs SetDev3
	tay
	lda _driveType,y
	sta curType
	cpy curDrive
	beq SetDev3
	sty curDrive
	bbrf 6, sysRAMFlg, SetDev3
	lda SetDevDrivesTabL - 8,y
	sta SetDevTab + 2
	lda SetDevDrivesTabH - 8,y
	sta SetDevTab + 3
	jsr PrepForFetch
	jsr FetchRAM
	jsr PrepForFetch
SetDev3:
	ldx #NULL
	rts

PrepForFetch:
	ldy #6
PFFet1:
	lda r0,y
	tax
	lda SetDevTab,y
	sta r0,y
	txa
	sta SetDevTab,y
	dey
	bpl PFFet1
	rts

SetDevTab:
	.word DISK_BASE
	.word $0000
	.word DISK_DRV_LGH
	.byte $00

SetDevDrivesTabL:
	.byte <(REUDskDrvSPC+(0*DISK_DRV_LGH))
	.byte <(REUDskDrvSPC+(1*DISK_DRV_LGH))
	.byte <(REUDskDrvSPC+(2*DISK_DRV_LGH))
	.byte <(REUDskDrvSPC+(3*DISK_DRV_LGH))
SetDevDrivesTabH:
	.byte >(REUDskDrvSPC+(0*DISK_DRV_LGH))
	.byte >(REUDskDrvSPC+(1*DISK_DRV_LGH))
	.byte >(REUDskDrvSPC+(2*DISK_DRV_LGH))
	.byte >(REUDskDrvSPC+(3*DISK_DRV_LGH))

_GetFHdrInfo:
	ldy #OFF_GHDR_PTR
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	MoveW r1, fileTrScTab
	jsr SetFHeadVector
	jsr GetBlock
	bnex GFHName4
	ldy #OFF_DE_TR_SC
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jmp GetStartHAddy

GetHeaderFileName:
	ldx #0
	lda r10L
	ora r10H
	beq GFHName2
	ldy #OFF_GHDR_PTR
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	jsr SetFHeadVector
	jsr GetBlock
	bnex GFHName4
	tay
GFHName1:
	lda (r10),y
	beq GFHName2
	cmp fileHeader+O_GHFNAME,y
	bne GFHName3
	iny
	bne GFHName1
GFHName2:
	ldy #0
	rts
GFHName3:
	ldy #$ff
GFHName4:
	rts

_LdDeskAcc:
	MoveB r10L, A885D
	jsr GetFHdrInfo
	bnex LDAcc1
.if (useRamExp)
	PushW r1
	jsr RamExpGetStat
	MoveW fileHeader+O_GHST_ADDR, diskBlkBuf+DACC_ST_ADDR
	lda fileHeader+O_GHEND_ADDR+1
	sub diskBlkBuf+DACC_ST_ADDR+1
	sta diskBlkBuf+DACC_LGH
	jsr RamExpPutStat
	MoveW diskBlkBuf+DACC_ST_ADDR, r0
	MoveB diskBlkBuf+DACC_LGH, r2H
	MoveB diskBlkBuf+RAM_EXP_1STFREE, r1L
	LoadB r1H, 0
	jsr RamExpWrite
	PopW r1
.else
	PushW r1
	jsr SaveSwapFile
	PopW r1
	bnex LDAcc1
.endif
	jsr GetStartHAddy
	LoadW r2, $ffff
	jsr ReadFile
	bnex LDAcc1
	jsr DlgBoxPrep
	jsr UseSystemFont
	jsr InitGEOEnv
	MoveB A885D, r10L
	PopW DeskAccPC
	tsx
	stx DeskAccSP
	ldx fileHeader+O_GHST_VEC+1
	lda fileHeader+O_GHST_VEC
	jmp _MNLP
	PopW r1
LDAcc1:
	rts

_RstrAppl:
.if (useRamExp)
	jsr RamExpGetStat
	MoveW diskBlkBuf+DACC_ST_ADDR, r0
	MoveB diskBlkBuf+DACC_LGH, r2H
	MoveB diskBlkBuf+RAM_EXP_1STFREE, r1L
	LoadB r1H, 0
	jsr RamExpRead
	jsr Dialog_2
	lda #0
.else
	lda #>SwapFileName
	sta r6H
	lda #<SwapFileName
	sta r6L
	LoadB r0L, NULL
	jsr GetFile
	bnex RsApp1
	jsr Dialog_2
	lda #>SwapFileName
	sta r0H
	lda #<SwapFileName
	sta r0L
	LoadW r3, fileTrScTab
	jsr FastDelFile
	txa
.endif
RsApp1:
	ldx DeskAccSP
	txs
	tax
	PushW DeskAccPC
RsApp2:
	rts

_LdApplic:
	jsr UNK_5
	jsr LdFile
	bnex RsApp1
	bbsf 0, A885E, RsApp1
	jsr UNK_4
	MoveW fileHeader+O_GHST_VEC, r7
	jmp StartAppl

.if (useRamExp)
.else
SwapFileName:
	.byte $1b,"Swap File", NULL

SaveSwapFile:
	LoadB fileHeader+O_GHGEOS_TYPE, TEMPORARY
	LoadW fileHeader, SwapFileName
	LoadW r9, fileHeader
	LoadB r10L, NULL
.endif

_SaveFile:
	ldy #0
SSwFile1:
	lda (r9),y
	sta fileHeader,y
	iny
	bne SSwFile1
	jsr GetDirHead
	bnex RsApp2
	jsr GetDAccLength
	jsr SetBufTSVector
	jsr BlkAlloc
	bnex RsApp2
	jsr SetBufTSVector
	jsr SetGDirEntry
	bnex RsApp2
	jsr PutDirHead
	bnex GDAL2
	sta fileHeader+O_GHINFO_TXT
	MoveW dirEntryBuf+OFF_GHDR_PTR, r1
	jsr SetFHeadVector
	jsr PutBlock
	bnex GDAL2
	jsr ClearNWrite
	bnex GDAL2
	jsr GetStartHAddy
	jmp WriteFile

GetDAccLength:
	lda fileHeader+O_GHEND_ADDR
	sub fileHeader+O_GHST_ADDR
	sta r2L
	lda fileHeader+O_GHEND_ADDR+1
	sbc fileHeader+O_GHST_ADDR+1
	sta r2H
	jsr GDAL1
	CmpBI fileHeader+O_GHSTR_TYPE, VLIR
	bne GDAL2
GDAL1:
	AddVW $fe, r2
GDAL2:
	rts

ClearNWrite:
	ldx #0
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne GDAL2
	MoveW dirEntryBuf+OFF_DE_TR_SC, r1
	txa
	tay
CNWri1:
	sta diskBlkBuf,y
	iny
	bne CNWri1
	dey
	sty diskBlkBuf+1
	jmp WriteBuff

_SetGDirEntry:
	jsr BldGDirEntry
	jsr GetFreeDirBlk
	bnex SGDEnt2
	tya
	addv <diskBlkBuf
	sta r5L
	lda #>diskBlkBuf
	adc #0
	sta r5H
	ldy #$1d
SGDEnt1:
	lda dirEntryBuf,y
	sta (r5),y
	dey
	bpl SGDEnt1
	jsr SGDCopyDate
	jmp WriteBuff

SGDCopyDate:
	ldy #$17
SGDCDat1:
	lda dirEntryBuf+$ff,y
	sta (r5),y
	iny
	cpy #$1c
	bne SGDCDat1
SGDEnt2:
	rts

_BldGDirEntry:
	ldy #$1d
	lda #NULL
BGDEnt1:
	sta dirEntryBuf,y
	dey
	bpl BGDEnt1
	tay
	lda (r9),y
	sta r3L
	iny
	lda (r9),y
	sta r3H
	sty r1H
	dey
	ldx #OFF_FNAME
BGDEnt2:
	lda (r3),y
	bne BGDEnt4
	sta r1H
BGDEnt3:
	lda #$a0
BGDEnt4:
	sta dirEntryBuf,x
	inx
	iny
	cpy #16
	beq BGDEnt5
	lda r1H
	bne BGDEnt2
	beq BGDEnt3
BGDEnt5:
	ldy #O_GHCMDR_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_CFILE_TYPE
	ldy #O_GHSTR_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_GSTRUC_TYPE
	ldy #NULL
	sty fileHeader
	dey
	sty fileHeader+1
	MoveW fileTrScTab, dirEntryBuf+OFF_GHDR_PTR
	jsr LoKernal
	MoveW fileTrScTab+2, dirEntryBuf+OFF_DE_TR_SC
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne BGDEnt6
	jsr LoKernal
BGDEnt6:
	ldy #O_GHGEOS_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_GFILE_TYPE
	MoveW r2, dirEntryBuf+OFF_SIZE
BGDEnt7:
	rts

_DeleteFile:
	jsr FindNDelete
	bnex BGDEnt7
DelFile1:
	LoadW r9, dirEntryBuf
_FreeFile:
	php
	sei
	jsr GetDirHead
	bnex DelFile4
	ldy #OFF_GHDR_PTR
	lda (r9),y
	beq DelFile2
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr FreeBlockChain
	bnex DelFile4
DelFile2:
	ldy #OFF_DE_TR_SC
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr FreeBlockChain
	bnex DelFile4
	ldy #OFF_GSTRUC_TYPE
	lda (r9),y
.if (onlyVLIR)
	beq DelFile3
.else
	cmp #VLIR
	bne DelFile3
.endif
	jsr DeleteVlirChains
	bnex DelFile4
DelFile3:
	jsr PutDirHead
DelFile4:
	plp
	rts

DeleteVlirChains:
	ldy #0
DelVlirC1:
	lda diskBlkBuf,y
	sta fileHeader,y
	iny
	bne DelVlirC1
	ldy #2
DelVlirC2:
	tya
	beq DelVlirC3
	lda fileHeader,y
	sta r1L
	iny
	lda fileHeader,y
	sta r1H
	iny
	lda r1L
	beq DelVlirC2
	tya
	pha
	jsr FreeBlockChain
	pla
	tay
	beqx DelVlirC2
DelVlirC3:
	rts

FreeBlockChain:
	MoveW r1, r6
	LoadW r2, 0
FreeBlC1:
	jsr FreeBlock
	bnex FreeBlC4
	inc r2L
	bne FreeBlC2
	inc r2H
FreeBlC2:
	PushW r2
	MoveW r6, r1
	jsr ReadBuff
	PopW r2
	bnex FreeBlC4
	lda diskBlkBuf
	beq FreeBlC3
	sta r6L
	lda diskBlkBuf+1
	sta r6H
	bra FreeBlC1
FreeBlC3:
	ldx #NULL
FreeBlC4:
	rts

FindNDelete:
	MoveW r0, r6
	jsr FindFile
	bnex FreeBlC4
	lda #0
	tay
	sta (r5),y
	jmp WriteBuff

_FastDelFile:
	PushW r3
	jsr FindNDelete
	PopW r3
	bnex FreeBlC4

FreeChainByTab:
	PushW r3
	jsr GetDirHead
	PopW r3
FCByTab1:
	ldy #0
	lda (r3),y
	beq FCByTab2
	sta r6L
	iny
	lda (r3),y
	sta r6H
	jsr FreeBlock
	bnex FreeBlC4
	AddVW 2, r3
	bra FCByTab1
FCByTab2:
	jmp PutDirHead

_RenameFile:
	PushW r0
	jsr FindFile
	PopW r0
	bnex FreeBlC4 ;->RTS
	AddVW OFF_FNAME, r5
	ldy #0
RenFile1:
	lda (r0),y
	beq RenFile2
	sta (r5),y
	iny
	cpy #16
	bcc RenFile1
	bcs RenFile3
RenFile2:
	lda #$a0
	sta (r5),y
	iny
	cpy #16
	bcc RenFile2
RenFile3:
	jmp WriteBuff

_OpenRecordFile:
.if (useRamExp)
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
	bnex OpRecFile4
	ldx #10
	ldy #OFF_CFILE_TYPE
	lda (r5),y
	and #%00111111
	cmp #USR
	bne OpRecFile4
	ldy #OFF_GSTRUC_TYPE
	lda (r5),y
.if (onlyVLIR)
	beq OpRecFile4
.else
	cmp #VLIR
	bne OpRecFile4
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
	bnex OpRecFile4
	sta usedRecords
	ldy #2
OpRecFile1:
	lda fileHeader,y
	ora fileHeader+1,y
	beq OpRecFile2
	inc usedRecords
	iny
	iny
	bne OpRecFile1
OpRecFile2:
	ldy #0
	lda usedRecords
	bne OpRecFile3
	dey
OpRecFile3:
	sty curRecord
	ldx #NULL
	stx fileWritten
	rts

_CloseRecordFile:
	jsr _UpdateRecordFile
OpRecFile4:
	LoadB RecordTableTS, NULL
	rts

_UpdateRecordFile:
	ldx #0
	lda fileWritten
	beq URecFile1
	jsr PutVLIRTab
	bnex URecFile1
	MoveW RecordDirTS, r1
	jsr ReadBuff
	bnex URecFile1
	MoveW RecordDirOffs, r5
	jsr SGDCopyDate
	ldy #OFF_SIZE
	lda fileSize
	sta (r5),y
	iny
	lda fileSize+1
	sta (r5),y
	jsr WriteBuff
	bnex URecFile1
	jsr PutDirHead
	lda #NULL
	sta fileWritten
URecFile1:
	rts

.if (useRamExp)
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
	bmi PoiRecord1
	cmp usedRecords
	bcs PoiRecord1
	sta curRecord
	jsr GetVLIRChainTS
	ldy r1L
	ldx #0
	beq PoiRecord2
PoiRecord1:
	ldx #INV_RECORD
PoiRecord2:
	lda curRecord
	rts

_DeleteRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi DelRecord3
	jsr ReadyForUpdVLIR
	bnex DelRecord3
	jsr GetVLIRChainTS
	MoveB curRecord, r0L
	jsr MoveBackVLIRTab
	bnex DelRecord3
	CmpB curRecord, usedRecords
	bcc DelRecord1
	dec curRecord
DelRecord1:
	ldx #NULL
	lda r1L
	beq DelRecord3
	jsr FreeBlockChain
	bnex DelRecord3
	SubB r2L, fileSize
	bcs DelRecord2
	dec fileSize+1
DelRecord2:
	ldx #NULL
DelRecord3:
	rts

_InsertRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi DelRecord3
	jsr ReadyForUpdVLIR
	bnex DelRecord3
	lda curRecord
	sta r0L
	jmp MoveForwVLIRTab

_AppendRecord:
	jsr ReadyForUpdVLIR
	bnex AppRecord1
	lda curRecord
	addv 1
	sta r0L
	jsr MoveForwVLIRTab
	bnex AppRecord1
	MoveB r0L, curRecord
AppRecord1:
	rts

_ReadRecord:
.if (useRamExp)
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
	bmi ReaRecord1
	jsr GetVLIRChainTS
	lda r1L
	tax
	beq ReaRecord1
	jsr ReadFile
	lda #$ff
ReaRecord1:
	rts

_WriteRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi ReaRecord1
	PushW r2
	jsr ReadyForUpdVLIR
	PopW r2
	bnex ReaRecord1
	jsr GetVLIRChainTS
	lda r1L
	bne WriRecord1
	ldx #0
	lda r2L
	ora r2H
	beq ReaRecord1
	bne WriRecord3
WriRecord1:
	PushW r2
	PushW r7
	jsr FreeBlockChain
	MoveB r2L, r0L
	PopW r7
	PopW r2
	bnex SVLIRTab1
	SubB r0L, fileSize
	bcs WriRecord2
	dec fileSize+1
WriRecord2:
	lda r2L
	ora r2H
	beq WriRecord4
WriRecord3:
	jmp WriteVLIRChain
WriRecord4:
	ldy #$FF
	sty r1H
	iny
	sty r1L
	jmp PutVLIRChainTS

GetVLIRTab:
	jsr SetVLIRTable
	bnex SVLIRTab1
	jmp GetBlock

PutVLIRTab:
	jsr SetVLIRTable
	bnex SVLIRTab1
	jmp PutBlock

SetVLIRTable:
	ldx #UNOPENED_VLIR
	lda RecordTableTS
	beq SVLIRTab1
	sta r1L
	lda RecordTableTS+1
	sta r1H
	jsr SetFHeadVector
	ldx #NULL
SVLIRTab1:
	rts

MoveBackVLIRTab:
	ldx #INV_RECORD
	lda r0L
	bmi MBVLIRTab3
	asl
	tay
	lda #$7e
	sub r0L
	asl
	tax
	beq MBVLIRTab2
MBVLIRTab1:
	lda fileHeader+4,y
	sta fileHeader+2,y
	iny
	dex
	bne MBVLIRTab1
MBVLIRTab2:
	stx fileHeader+$fe
	stx fileHeader+$ff
	dec usedRecords
MBVLIRTab3:
	rts

MoveForwVLIRTab:
	ldx #OUT_OF_RECORDS
	CmpBI usedRecords, $7f
	bcs MFVLIRTab3
	ldx #INV_RECORD
	lda r0L
	bmi MFVLIRTab3
	ldy #$fe
	lda #$7e
	sub r0L
	asl
	tax
	beq MFVLIRTab2
MFVLIRTab1:
	lda fileHeader-1,y
	sta fileHeader+1,y
	dey
	dex
	bne MFVLIRTab1
MFVLIRTab2:
	txa
	sta fileHeader,y
	lda #$ff
	sta fileHeader+1,y
	inc usedRecords
MFVLIRTab3:
	rts

GetVLIRChainTS:
	lda curRecord
	asl
	tay
	lda fileHeader+2,y
	sta r1L
	lda fileHeader+3,y
	sta r1H
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
	bnex WVLIRChain1
	PushB r2L
	jsr SetBufTSVector
	jsr WriteFile
	PopB r2L
	bnex WVLIRChain1
	MoveW fileTrScTab, r1
	jsr PutVLIRChainTS
	bnex WVLIRChain1
	AddB r2L, fileSize
	bcc WVLIRChain1
	inc fileSize+1
WVLIRChain1:
	rts

ReadyForUpdVLIR:
	ldx #NULL
	lda fileWritten
	bne RFUpdVLIR1
	jsr GetDirHead
	bnex RFUpdVLIR1
	lda #$ff
	sta fileWritten
RFUpdVLIR1:
	rts

_ReadByte:
	ldy r5H
	cpy r5L
	beq ReadByt2
	lda (r4),y
	inc r5H
	ldx #NULL
ReadByt1:
	rts
ReadByt2:
	ldx #BFR_OVERFLOW
	lda r1L
	beq ReadByt1
	jsr GetBlock
	bnex ReadByt1
	ldy #2
	sty r5H
	dey
	lda (r4),y
	sta r1H
	tax
	dey
	lda (r4),y
	sta r1L
	beq ReadByt3
	ldx #$ff
ReadByt3:
	inx
	stx r5L
	bra _ReadByte

_GetPtrCurDkNm:
	ldy curDrive
	lda DkNmTab-8,Y
	sta zpage,X
	lda DkNmTab-4,Y
	sta zpage+1,X
	rts
