; GEOS KERNAL
;
; File, application and desk accessory launching

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; dlgbox.s:
.import Dialog_2
.import DlgBoxPrep

; filesys.s
.import GetStartHAddy
.import UNK_4
.import UNK_5
.import _SaveFile

; init.s
.import InitGEOEnv

; main.s
.import _MNLP

; syscalls
.global _GetFile
.global _LdFile
.global _LdApplic
.global _LdDeskAcc
.global _RstrAppl

.segment "file1"

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

.segment "file2"

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

.if (!useRamExp)
SwapFileName:
	.byte $1b,"Swap File", NULL
.endif

.segment "file3"

SaveSwapFile:
	LoadB fileHeader+O_GHGEOS_TYPE, TEMPORARY
	LoadW fileHeader, SwapFileName
	LoadW r9, fileHeader
	LoadB r10L, NULL

.assert * = _SaveFile, error, "Code must run into _SaveFile"
