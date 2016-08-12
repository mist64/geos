; GEOS Kernal
; disk and file related functions

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; conio.s
.import _UseSystemFont

; dlgbox.s:
.import Dialog_2
.import DlgBoxPrep

; graph.s
.import ClrScr

; main.s
.import _MNLP
.import InitGEOEnv
.import InitGEOS

.global _AppendRecord
.global _BldGDirEntry
.global _CloseRecordFile
.global _DeleteFile
.global _DeleteRecord
.global _EnterDeskTop
.global _FastDelFile
.global _FindFTypes
.global _FindFile
.global _FollowChain
.global _FreeFile
.global _GetFHdrInfo
.global _GetFile
.global _GetPtrCurDkNm
.global _InsertRecord
.global _LdApplic
.global _LdDeskAcc
.global _LdFile
.global _NextRecord
.global _OpenRecordFile
.global _PointRecord
.global _PreviousRecord
.global _ReadByte
.global _ReadFile
.global _ReadRecord
.global _RenameFile
.global _RstrAppl
.global _SaveFile
.global _SetDevice
.global _SetGDirEntry
.global _StartAppl
.global _UpdateRecordFile
.global _WriteFile
.global _WriteRecord
.global UNK_4
.global UNK_5

.if (trap)
.global SerialHiCompare
.endif

.segment "files1"

Add2:
	AddVW 2, r6
return:
	rts

_ReadFile:
	jsr EnterTurbo
	bnex return
	jsr InitForIO
	PushW r0
	LoadW r4, diskBlkBuf
	LoadB r5L, 2
	MoveW r1, fileTrScTab+2
RdFile1:
	jsr ReadBlock
	bnex RdFile6
	ldy #$fe
	lda diskBlkBuf
	bne RdFile2
	ldy diskBlkBuf+1
	dey
	beq RdFile5
RdFile2:
	lda r2H
	bne RdFile3
	cpy r2L
	bcc RdFile3
	beq RdFile3
	ldx #BFR_OVERFLOW
	bne RdFile6
RdFile3:
	sty r1L
	LoadB CPU_DATA, RAM_64K
RdFile4:
	lda diskBlkBuf+1,y
	dey
	sta (r7),y
	bne RdFile4
	LoadB CPU_DATA, KRNL_IO_IN
	AddB r1L, r7L
	bcc *+4
	inc r7H
	SubB r1L, r2L
	bcs *+4
	dec r2H
RdFile5:
	inc r5L
	inc r5L
	ldy r5L
	MoveB diskBlkBuf+1, r1H
	sta fileTrScTab+1,y
	MoveB diskBlkBuf, r1L
	sta fileTrScTab,y
	bne RdFile1
	ldx #0
RdFile6:
	PopW r0
	jmp DoneWithIO

FlaggedPutBlock:
	lda verifyFlag
	beq FlggdPutBl1
	jmp VerWriteBlock
FlggdPutBl1:
	jmp WriteBlock

_WriteFile:
	jsr EnterTurbo
	bnex WrFile2
	sta verifyFlag
	jsr InitForIO
	LoadW r4, diskBlkBuf
	PushW r6
	PushW r7
	jsr DoWriteFile
	PopW r7
	PopW r6
	bnex WrFile1
	dec verifyFlag
	jsr DoWriteFile
WrFile1:
	jsr DoneWithIO
WrFile2:
	rts

DoWriteFile:
	ldy #0
	lda (r6),y
	beq DoWrFile2
	sta r1L
	iny
	lda (r6),y
	sta r1H
	dey
	jsr Add2
	lda (r6),y
	sta (r4),y
	iny
	lda (r6),y
	sta (r4),y
	ldy #$fe
	LoadB CPU_DATA, RAM_64K
DoWrFile1:
	dey
	lda (r7),y
	sta diskBlkBuf+2,y
	tya
	bne DoWrFile1
	LoadB CPU_DATA, KRNL_IO_IN
	jsr FlaggedPutBlock
	bnex DoWrFile3
	AddVW $fe, r7
	bra DoWriteFile
DoWrFile2:
	tax
DoWrFile3:
	rts

.segment "files2"
DkNmTab:
	.byte <DrACurDkNm, <DrBCurDkNm
	.byte <DrCCurDkNm, <DrDCurDkNm
	.byte >DrACurDkNm, >DrBCurDkNm
	.byte >DrCCurDkNm, >DrDCurDkNm

.segment "files3"
_GetPtrCurDkNm:
	ldy curDrive
	lda DkNmTab-8,Y
	sta zpage,X
	lda DkNmTab-4,Y
	sta zpage+1,X
	rts

.segment "main3"

_EnterDeskTop:
	sei
	cld
	ldx #$ff
	stx firstBoot
	txs
	jsr ClrScr
	jsr InitGEOS
.if (useRamExp)
	MoveW DeskTopStart, r0
	MoveB DeskTopLgh, r2H
	LoadW r1, 1
	jsr RamExpRead
	LoadB r0L, NULL
	MoveW DeskTopExec, r7
.else
	MoveB curDrive, TempCurDrive
	eor #1
	tay
	lda _driveType,Y
	php
	lda TempCurDrive
	plp
	bpl EDT1
	tya
EDT1:
	jsr EDT3
	ldy NUMDRV
	cpy #2
	bcc EDT2
	lda curDrive
	eor #1
	jsr EDT3
EDT2:
	LoadW r0, _EnterDT_DB
	jsr DoDlgBox
	lda TempCurDrive
	bne EDT1
EDT3:
	jsr SetDevice
	jsr OpenDisk
	beqx EDT5
EDT4:
	rts
EDT5:
	sta r0L
	LoadW r6, DeskTopName
	jsr GetFile
	bnex EDT4
	lda fileHeader+O_GHFNAME+13
	cmp #'1'
	bcc EDT4
	bne EDT6
	lda fileHeader+O_GHFNAME+15
	cmp #'5'
	bcc EDT4
EDT6:
	lda TempCurDrive
	jsr SetDevice
	LoadB r0L, NULL
	MoveW fileHeader+O_GHST_VEC, r7
.endif

_StartAppl:
	sei
	cld
	ldx #$FF
	txs
	jsr UNK_5
	jsr InitGEOS
	jsr _UseSystemFont
	jsr UNK_4
	ldx r7H
	lda r7L
	jmp _MNLP

.if (!useRamExp)
_EnterDT_DB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word _EnterDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word _EnterDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL
.endif

DeskTopName:
	.byte "DESK TOP", NULL

_EnterDT_Str0:
	.byte BOLDON, "Please insert a disk", NULL
_EnterDT_Str1:
	.byte "with deskTop V1.5 or higher", NULL

.segment "main5c"
UNK_4:
	MoveB A885D, r10L
	MoveB A885E, r0L
	and #1
	beq U_40
	MoveW A885F, r7
U_40:
	LoadW r2, dataDiskName
	LoadW r3, dataFileName
U_41:
	rts

UNK_5:
	MoveW r7, A885F
	MoveB r10L, A885D
	MoveB r0L, A885E
	and #%11000000
	beq U_51
	ldy #>dataDiskName
	lda #<dataDiskName
	ldx #r2
	jsr U_50
	ldy #>dataFileName
	lda #<dataFileName
	ldx #r3
U_50:
	sty r4H
	sta r4L
	ldy #r4
	lda #16
	jsr CopyFString
U_51:
	rts

.segment "files4"

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
	lda #$ff
	sta r2L
	sta r2H
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

.if (trap)
    ; sabotage code: breaks LdDeskAcc if
    ; _UseSystemFont hasn't been called before this
	ldx #>GetSerialNumber
	lda #<GetSerialNumber
	jsr CallRoutine
	lda r0H
	cmp SerialHiCompare
	beq FFTypes1
	inc LdDeskAcc+1
.endif

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
	clc
	lda #$11
	adc r6L
	sta r6L
	bcc j
	inc r6H
j:
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
	nop
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
.ifdef maurice
    ; This should be initialized to 0, and will
    ; be changed at runtime.
    ; Maurice's version was created by dumping
    ; KERNAL from memory after it had been running,
    ; so it has a different value here.
	.word REUDskDrvSPC
.else
	.word 0
.endif
	.word DISK_DRV_LGH
	.byte 0

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
	bnex _GetFHdrInfoEnd
	ldy #OFF_DE_TR_SC
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr GetStartHAddy
_GetFHdrInfoEnd:
	rts

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
	lda #$ff
	sta r2L
	sta r2H
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
	bnex LdApplic1
	bbsf 0, A885E, LdApplic1
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
LdApplic1:
	rts

.if (useRamExp)
.else
SwapFileName:
	.byte $1b,"Swap File", NULL

.if (trap)
SerialHiCompare:
.ifdef maurice
    ; This should be initialized to 0, and will
    ; be changed at runtime.
    ; Maurice's version was created by dumping
    ; KERNAL from memory after it had been running,
    ; so it has a pre-filled value here.
	.byte $58
.else
	.byte 0
.endif
.endif

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
	bnex SSwFile2
	jsr GetDAccLength
	jsr SetBufTSVector
	jsr BlkAlloc
	bnex SSwFile2
	jsr SetBufTSVector
	jsr SetGDirEntry
	bnex SSwFile2
	jsr PutDirHead
	bnex SSwFile2
	sta fileHeader+O_GHINFO_TXT
	MoveW dirEntryBuf+OFF_GHDR_PTR, r1
	jsr SetFHeadVector
	jsr PutBlock
	bnex SSwFile2
	jsr ClearNWrite
	bnex SSwFile2
	jsr GetStartHAddy
	jsr WriteFile
SSwFile2:
	rts

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
	clc
.if 1
	lda #$fe
	adc r2L
	sta r2L
	bcc GDAL2
	inc r2H
.else
	AddVW $fe, r2
.endif
GDAL2:
	rts

ClearNWrite:
	ldx #0
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne CNWri2
	MoveW dirEntryBuf+OFF_DE_TR_SC, r1
	txa
	tay
CNWri1:
	sta diskBlkBuf,y
	iny
	bne CNWri1
	dey
	sty diskBlkBuf+1
	jsr WriteBuff
CNWri2:
	rts

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
	jsr Add2
	MoveW fileTrScTab+2, dirEntryBuf+OFF_DE_TR_SC
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne BGDEnt6
	jsr Add2
BGDEnt6:
	ldy #O_GHGEOS_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_GFILE_TYPE
	MoveW r2, dirEntryBuf+OFF_SIZE
BGDEnt7:
	rts

_DeleteFile:
	jsr FindNDelete
	beqx DelFile1
	rts
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
.if 1
	LoadW_ r2, 0
.else
	LoadW r2, 0
.endif
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
	bnex :+
	lda #0
	tay
	sta (r5),y
	jsr WriteBuff
:
	rts

_FastDelFile:
	PushW r3
	jsr FindNDelete
	PopW r3
	bnex :+
	jsr FreeChainByTab
:
	rts

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
	bnex FCByTab3
	AddVW 2, r3
	bra FCByTab1
FCByTab2:
	jsr PutDirHead
FCByTab3:
	rts

_RenameFile:
	PushW r0
	jsr FindFile
	PopW r0
	bnex RenFile4
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
	jsr WriteBuff
RenFile4:
	rts

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
	bmi :+
	jsr ReadyForUpdVLIR
	bnex :+
	lda curRecord
	sta r0L
	jsr MoveForwVLIRTab
:	rts

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
	bmi WriRecord5
	PushW r2
	jsr ReadyForUpdVLIR
	PopW r2
	bnex WriRecord5
	jsr GetVLIRChainTS
	lda r1L
	bne WriRecord1
	ldx #0
	lda r2L
	ora r2H
	beq WriRecord5
	bne WriRecord3
WriRecord1:
	PushW r2
	PushW r7
	jsr FreeBlockChain
	MoveB r2L, r0L
	PopW r7
	PopW r2
	bnex WriRecord5
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
	jsr PutVLIRChainTS
WriRecord5:
	rts

GetVLIRTab:
	jsr SetVLIRTable
	bnex :+
	jsr GetBlock
:	rts

PutVLIRTab:
	jsr SetVLIRTable
	bnex :+
	jsr PutBlock
:	rts

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
