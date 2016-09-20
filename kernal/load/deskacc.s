; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Desk Accessories: LdDeskAcc, RstrAppl

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import Dialog_2
.import _MNLP
.import DeskAccSP
.import DeskAccPC
.import InitGEOEnv
.import DlgBoxPrep
.import GetStartHAddr

.import MoveBData
.import UseSystemFont
.import ReadFile
.import GetFHdrInfo

.ifndef bsw128
.import FastDelFile
.import GetFile
.endif
.import A885D

.ifdef wheels
.import ReadR9
.import FetchRAM
.import StashRAM
.endif

.global _LdDeskAcc
.global _RstrAppl

.segment "deskacc1"

_LdDeskAcc:
.ifdef wheels
; swap to REU
.import LD8D3
	jsr GetFHdrInfo
	bnex @1
	lda r7H
	sta r0H
	sta r1H
	sta tmp1
	lda r7L
	sta r0L
	sta r1L
	sta tmp0
	jsr LD8D3
	lda r2H
	sta tmp3
	lda r2L
	sta tmp2
	lda #0
	sta r3L
	jsr StashRAM
	ldy #1
	jsr ReadR9
	jsr ReadFile
	bnex @1
	jsr DlgBoxPrep
	jsr UseSystemFont
	jsr InitGEOEnv
	PopW $8850
	tsx
	stx $8852
	ldx fileHeader+O_GHST_VEC+1
	lda fileHeader+O_GHST_VEC
	jmp _MNLP
@1:	rts

tmp0:	.byte 0
tmp1:	.byte 0
tmp2:	.byte 0
tmp3:	.byte 0
.elseif .defined(bsw128)
; swap to back RAM
.import _InitMachine2
.import CheckAppCompat
	MoveB r10L, A885D
	jsr GetFHdrInfo
	bnex @1
	jsr CheckAppCompat
	bne @1
	PushW r1
	jsr SaveSwapFile
	beqx @2
	pla
	pla
@1:	rts
@2:	jsr DlgBoxPrep
	PopW r1
	PopW DeskAccPC
	tsx
	stx DeskAccSP
	jsr GetStartHAddr
	lda #$FF
	sta r2L
	sta r2H
	jsr ReadFile
	bnex _RstrAppl
	jsr UseSystemFont
	jsr _InitMachine2
	MoveB A885D, r10L
	ldx fileHeader+O_GHST_VEC+1
	lda fileHeader+O_GHST_VEC
	jmp _MNLP
.else
	MoveB r10L, A885D
	jsr GetFHdrInfo
	bnex LDAcc1
.ifdef useRamExp
; swap to other bank
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
; swap to disk
	PushW r1
	jsr SaveSwapFile
	PopW r1
	bnex LDAcc1
.endif
	jsr GetStartHAddr
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
.endif

_RstrAppl:
.ifdef wheels
; restore from REU
	lda tmp1
	sta r0H
	sta r1H
	lda tmp0
	sta r0L
	sta r1L
	lda tmp3
	sta r2H
	lda tmp2
	sta r2L
	lda #$00
	sta r3L
	jsr FetchRAM
	jsr Dialog_2
	ldx DeskAccSP
	txs
	ldx #0
	PushW DeskAccPC
	rts
.else
.ifdef bsw128
; restore from back RAM
	ldy #0
	sty r3L
	sty r0L
	iny
	sty r3H
	LoadB r0H, >$2000
	MoveW dAccStart, r1
	MoveW dAccLength, r2
	jsr MoveBData
	jsr Dialog_2
	lda #0
.elseif .defined(useRamExp)
; restore from other bank
	ldx DeskAccSP
	txs
	tax
	PushW DeskAccPC
	rts
	jsr RamExpGetStat
	MoveW diskBlkBuf+DACC_ST_ADDR, r0
	MoveB diskBlkBuf+DACC_LGH, r2H
	MoveB diskBlkBuf+RAM_EXP_1STFREE, r1L
	LoadB r1H, 0
	jsr RamExpRead
	jsr Dialog_2
	lda #0
.else
; restore from other disk
	LoadW r6, SwapFileName
	LoadB r0L, NULL
	jsr GetFile
	bnex @1
	jsr Dialog_2
	LoadW r0, SwapFileName
	LoadW r3, fileTrScTab
	jsr FastDelFile
	txa
.endif
@1:	ldx DeskAccSP
	txs
	tax
	PushW DeskAccPC
	rts
.endif

.ifdef bsw128
.import _EnterDeskTop
	jmp _EnterDeskTop
.endif

.segment "deskacc2"

.if (!.defined(wheels)) && (!.defined(useRamExp))
; XXX bsw128 includes this but doesn't use it
SwapFileName:
	.byte $1b,"Swap File", NULL
.endif

.segment "deskacc3"

.if (!.defined(wheels)) && (!.defined(useRamExp)) && (!.defined(bsw128))
SaveSwapFile:
	LoadB fileHeader+O_GHGEOS_TYPE, TEMPORARY
	LoadW fileHeader, SwapFileName
	LoadW r9, fileHeader
	LoadB r10L, NULL

;.assert * = _SaveFile, error, "Code must run into _SaveFile"
.elseif .def(bsw128)
.import MoveBData
SaveSwapFile:
	lda fileHeader+O_GHST_ADDR
	sta r0L
	sta dAccStart
	lda fileHeader+O_GHST_ADDR+1
	sta r0H
	sta dAccStart+1
	ldx #$0B
	lda fileHeader+O_GHEND_ADDR
	sec
	sbc r0L
	sta r2L
	sta dAccLength
	lda fileHeader+O_GHEND_ADDR+1
	sbc r0H
	sta r2H
	sta dAccLength+1
	cmp #$60 ; maximum DACC size to swap into RAM
	bcs @1
	ldy #$00
	sty r3H
	sty r1L
	iny
	sty r3L
	lda #$20 ; DACC space start highbyte
	sta r1H
	jsr MoveBData
	ldx #0
@1:	rts

dAccStart:	.word 0
dAccLength:	.word 0
.endif
