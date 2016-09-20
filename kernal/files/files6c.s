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
.ifdef bsw128
.import _SwapDiskDriver
.import CheckAppCompat
.endif

.import GetBlock
.import FetchRAM
.import ExitTurbo

.global GetHeaderFileName
.global _SetDevice
.global _GetFHdrInfo
.global _FindFile

.segment "files6c"

_FindFile:
.ifdef wheels
	sec
	lda r6L
	sbc #3
	sta r6L
	bcs @1
	dec r6H
@1:	jsr Get1stDirEntry
	bnex @8
@2:	ldy #0
	lda (r5),y
	beq @5
	ldy #3
@3:	lda (r6),y
	beq @4
	cmp (r5),y
	bne @5
	iny
	bne @3
@4:	cpy #OFF_FNAME + $10
	beq @6
	lda (r5),y
	iny
	cmp #$A0
	beq @4
@5:	jsr GetNxtDirEntry
	bnex @8
	tya
	beq @2
	ldx #FILE_NOT_FOUND
	rts
@6:	ldy #29
@7:	lda (r5),y
	sta dirEntryBuf,y
	dey
	bpl @7
@8:	rts
.else
	php
	sei
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex @7
@1:	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq @4
	ldy #OFF_FNAME
@2:	lda (r6),y
	beq @3
	cmp (r5),y
	bne @4
	iny
	bne @2
@3:	cpy #OFF_FNAME + $10
	beq @5
	lda (r5),y
	iny
	cmp #$a0
	beq @3
@4:	jsr GetNxtDirEntry
	bnex @7
	tya
	beq @1
	ldx #FILE_NOT_FOUND
	bne @7
@5:	ldy #0
@6:	lda (r5),y
	sta dirEntryBuf,y
	iny
	cpy #$1e
	bne @6
	ldx #NULL
@7:	plp
	rts
.endif

_SetDevice:
.ifdef wheels
	tax
	beq @7
	cmp curDevice
	beq @2
	jsr IsCurDeviceValid
	bcs @1
	lda curDrive
	jsr IsDeviceValid
	bcs @1
	jsr ExitTurbo
@1:	stx curDevice
@2:	jsr IsCurDeviceValid
	bcs @6
	tay
	lda _driveType,y
	sta curType
	beq @7
	cpy curDrive
	beq @6
	sty curDrive
	lda SetDevDrivesTabL-8,y
	sta SetDevTab + 2
	lda SetDevDrivesTabH-8,y
	sta SetDevTab + 3
	ldx #6
@3:	lda r0,x
	pha
	lda SetDevTab,x
	sta r0,x
	dex
	bpl @3
	lda curType
	and #$0F
	cmp #DRV_1581
	bne @4
	dec r2H
@4:	jsr FetchRAM
	ldx #0
@5:	pla
	sta r0,x
	inx
	cpx #7
	bne @5
@6:	ldx #0
	rts
@7:	ldx #DEV_NOT_FOUND
	rts

IsCurDeviceValid:
	lda curDevice
IsDeviceValid:
	cmp #8
	bcc @1
	cmp #12
	rts
@1:	sec
	rts
.else
	nop
	cmp curDevice
	beq @2
	pha
	CmpBI curDevice, 8
	bcc @1
	cmp #12
	bcs @1
	jsr ExitTurbo
@1:	PopB curDevice
@2:	cmp #8
	bcc @3
	cmp #12
	bcs @3
	tay
	lda _driveType,y
	sta curType
.ifdef bsw128
	ldx curDrive
.endif
	cpy curDrive
	beq @3
	sty curDrive
.ifdef bsw128
	bbrf 6, sysRAMFlg, @4
.else
	bbrf 6, sysRAMFlg, @3
.endif
	lda SetDevDrivesTabL - 8,y
	sta SetDevTab + 2
	lda SetDevDrivesTabH - 8,y
	sta SetDevTab + 3
	jsr PrepForFetch
	jsr FetchRAM
	jsr PrepForFetch
@3:	ldx #NULL
	rts
.ifdef bsw128
@4:	txa
	eor curDrive
	and #1
	beq @5
	jsr _SwapDiskDriver
@5:	ldx #$00
	rts
.endif

PrepForFetch:
	ldy #6
@1:	lda r0,y
	tax
	lda SetDevTab,y
	sta r0,y
	txa
	sta SetDevTab,y
	dey
	bpl @1
	rts
.endif

SetDevTab:
	.word DISK_BASE
.if .defined(cbmfiles) || .defined(wheels) || .defined(bsw128)
	; This should be initialized to 0, and will
	; be changed at runtime.
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it has a different value here.
	.word REUDskDrvSPC
.else
	.word 0
.endif
	.word DISK_DRV_LGH
	.byte 0

.define SetDevDrivesTab REUDskDrvSPC+0*DISK_DRV_LGH, REUDskDrvSPC+1*DISK_DRV_LGH, REUDskDrvSPC+2*DISK_DRV_LGH, REUDskDrvSPC+3*DISK_DRV_LGH
SetDevDrivesTabL:
	.lobytes SetDevDrivesTab
SetDevDrivesTabH:
	.hibytes SetDevDrivesTab

_GetFHdrInfo:
	ldy #OFF_GHDR_PTR
	lda (r9),y
	sta r1L
.ifdef wheels
	sta fileTrScTab
.endif
	iny
	lda (r9),y
	sta r1H
.ifdef wheels
	sta fileTrScTab+1
.else
	MoveW r1, fileTrScTab
.endif
	jsr SetFHeadVector
	jsr GetBlock
.ifdef wheels
	bne @1
.else
	bnex @1
.endif
	ldy #OFF_DE_TR_SC
.ifdef wheels
	jsr ReadR9
.else
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
.endif
	jsr GetStartHAddr
@1:	rts

.ifdef wheels
.global ReadR9
ReadR9:	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	rts
.endif

GetHeaderFileName:
	ldx #0
	lda r10L
	ora r10H
.ifdef bsw128
	bne @X
	CmpBI r7L, DESK_ACC
	bne @2
@X:
.else
	beq @2
.endif
	ldy #OFF_GHDR_PTR
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	jsr SetFHeadVector
	jsr GetBlock
.ifdef wheels
        bne @4
.else
	bnex @4
.endif
	tay
.ifdef bsw128
	lda r10L
	ora r10H
	bne @Y
	jsr CheckAppCompat
	beq @2
	ldx #0
	beq @3
@Y:
.endif
@1:	lda (r10),y
	beq @2
	cmp fileHeader+O_GHFNAME,y
	bne @3
	iny
	bne @1
@2:	ldy #0
	rts
@3:	ldy #$ff
@4:	rts

