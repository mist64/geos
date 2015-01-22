; GEOS System KERNAL - lower part, placed after disk driver
; reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import DoneWithIO, EnterTurbo, InitForIO, ReadBlock, VerWriteBlock, WriteBlock
.global _DoRAMOp, _FetchRAM, _ReadFile, _StashRAM, _SwapRAM, _VerifyRAM, _WriteFile, _DoRAMOp, _FetchRAM, _ReadFile, _StashRAM, _SwapRAM, _VerifyRAM, _WriteFile, _DoRAMOp, _FetchRAM, _ReadFile, _StashRAM, _SwapRAM, _VerifyRAM, _WriteFile, _DoRAMOp, _FetchRAM, _ReadFile, _StashRAM, _SwapRAM, _VerifyRAM, _WriteFile, LoKernal

.segment "lokernal"

LoKernal:
	AddVW 2, r6
LoKern0:
	rts

_ReadFile:
	jsr EnterTurbo
	bnex LoKern0
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
	bnex DoWrFile3
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
	jmp DoneWithIO

DoWriteFile:
	ldy #0
	lda (r6),y
	beq DoWrFile2
	sta r1L
	iny
	lda (r6),y
	sta r1H
	dey
	jsr LoKernal
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

.if (REUPresent)
_VerifyRAM:
	ldy #$93
	bne _DoRAMOp
_StashRAM:
	ldy #$90
	bne _DoRAMOp
_SwapRAM:
	ldy #$92
	bne _DoRAMOp
_FetchRAM:
	ldy #$91
_DoRAMOp:
	ldx #DEV_NOT_FOUND
	lda r3L
	cmp ramExpSize
	bcs DRAMOp2
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	MoveW r0, EXP_BASE+2
	MoveW r1, EXP_BASE+4
	MoveB r3L, EXP_BASE+6
	MoveW r2, EXP_BASE+7
	lda #0
	sta EXP_BASE+9
	sta EXP_BASE+10
	sty EXP_BASE+1
DRAMOp1:
	lda EXP_BASE
	and #%01100000
	beq DRAMOp1
	stx CPU_DATA
	ldx #0
DRAMOp2:
	rts
.endif

.if (useRamExp)
RamExpSetStat:
	LoadW r1, $0000
	LoadB r0H, (>diskBlkBuf)
	LoadB r2H, 0
	sta r0L
	rts
RamExpGetStat:
	jsr RamExpSetStat
	jmp RamExpRead
RamExpPutStat:
	jsr RamExpSetStat
	jmp RamExpWrite
.endif

.if (usePlus60K)
;r0 - c64 addy, r1 - exp page number (byte/word - RamCart 64/128), r2H - # of bytes (in pages)

RamExpRead:
	PushB r0H
	PushB r2H
	PushW r1
	php
	sei
	ldy #0
RamExRd_0:
	lda RamExpRdHlp,y
	sta $02a0,y
	iny
	cpy #RamExpRdHlpEnd-RamExpRdHlp
	bne RamExRd_0
	jsr $02a0
RamExpRdEnd:
	plp
	PopW r1
	PopB r2H
	PopB r0H
	rts

RamExpWrite:
	PushB r0H
	PushB r2H
	PushW r1
	php
	sei
	ldy #0
RamExWr_0:
	lda RamExpWrHlp,y
	sta $02a0,y
	iny
	cpy #RamExpWrHlpEnd-RamExpWrHlp
	bne RamExWr_0
	jsr $02a0
	jmp RamExpRdEnd

RamExpRdHlp:
	PushB CPU_DATA
	lda r1L
	addv $10
	sta r1H
	ldy #0
	sty r1L
	ldx #IO_IN
	stx CPU_DATA

RamExRdH_1:
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
	lda (r1),y
	ldx #IO_IN
	stx CPU_DATA
	ldx #0
	stx PLUS60K_CR
	sta (r0),y
	iny
	bne RamExRdH_1
	inc r0H
	inc r1H
	dec r2H
	bpl RamExRdH_1
	PopB CPU_DATA
	rts
RamExpRdHlpEnd:

RamExpWrHlp:
	PushB CPU_DATA
	lda r1L
	addv $10
	sta r1H
	ldy #0
	sty r1L

RamExWrH_1:
	ldx #IO_IN
	stx CPU_DATA
	ldx #0
	stx PLUS60K_CR
	lda (r0),y
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
	sta (r1),y
	iny
	bne RamExWrH_1
	inc r0H
	inc r1H
	dec r2H
	bpl RamExWrH_1
	LoadB CPU_DATA, IO_IN
	LoadB PLUS60K_CR, 0
	PopB CPU_DATA
	rts
RamExpWrHlpEnd:
.endif


.if (useRamCart64)
RamExpRead:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushB r1L
	PushB r0H
	ldx r2H
RamExRd_0:
	MoveB r1L, RAMC_BASE
	ldy #0
RamExRd_1:
	lda RAMC_WINDOW,y
	sta (r0),y
	iny
	bne RamExRd_1
	inc r0H
	inc r1L
	dex
	bpl RamExRd_0
RamExRd_End:
	PopB r0H
	PopB r1L
	PopB CPU_DATA
	rts

RamExpWrite:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushB r1L
	PushB r0H
	ldx r2H
RamExWr_0:
	MoveB r1L, RAMC_BASE
	ldy #0
RamExWr_1:
	lda (r0),y
	sta RAMC_WINDOW,y
	iny
	bne RamExWr_1
	inc r0H
	inc r1L
	dex
	bpl RamExWr_0
	jmp RamExRd_End
.endif

.if (useRamCart128)
RamExpRead:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushW r1
	PushB r0H
	ldx r2H
RamExRd_0:
	MoveW r1, RAMC_BASE
	ldy #0
RamExRd_1:
	lda RAMC_WINDOW,y
	sta (r0),y
	iny
	bne RamExRd_1
	inc r0H
	inc r1L
	bne *+4
	inc r1H
	dex
	bpl RamExRd_0
RamExRd_End:
	PopB r0H
	PopW r1
	PopB CPU_DATA
	rts

RamExpWrite:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushW r1
	PushB r0H
	ldx r2H
RamExWr_0:
	MoveW r1, RAMC_BASE
	ldy #0
RamExWr_1:
	lda (r0),y
	sta RAMC_WINDOW,y
	iny
	bne RamExWr_1
	inc r0H
	inc r1L
	bne *+4
	inc r1H
	dex
	bpl RamExWr_0
	jmp RamExRd_End
.endif

.if (removeToBASIC)
.else
LoKernalBuf:
	!byte 0, 0, 0, 0, 0, 0, 0, 0
	!byte 0, 0, 0, 0, 0, 0, 0, 0
	!byte 0, 0, 0, 0, 0, 0, 0, 0
	!byte 0, 0, 0, 0, 0, 0, 0, 0
	!byte 0, 0, 0, 0, 0, 0, 0, 0
LKIntTimer:
	!byte 0
LKSaveBASIC:
	!byte 0, 0, 0
LKSaveR7:
	!byte 0, 0

LoKernal1:
	sei
	LoadB CPU_DATA, KRNL_IO_IN
	ldy #2
LKernal1:
	lda BASICspace,y
	sta LKSaveBASIC,y
	dey
	bpl LKernal1
	MoveW r7, LKSaveR7
	inc CPU_DATA
	ldx #$ff
	txs
	LoadB grcntrl2, 0
	jsr KERNALCIAInit
	ldx curDevice
	lda #0
	tay
LKernal2:
	sta zpage+2,y
	sta zpage+$0200, y
	sta zpage+$0300, y
	iny
	bne LKernal2
	stx curDevice
	LoadB BASICMemTop, $a0
	LoadW tapeBuffVec, $03c3
	LoadB BASICMemBot, $08
	lsr
	sta scrAddyHi
	jsr Init_KRNLVec
	jsr KERNALVICInit
	lda #>execBASIC
	sta nmivec+1
	lda #<execBASIC
	sta nmivec
	LoadB LKIntTimer, 6
	lda cia2base+13
	LoadB cia2base+4, $ff
	sta cia2base+5
	LoadB cia2base+13, $81
	LoadB cia2base+14, $01
	jmp (BASIC_START)

execBASIC:
	pha
	tya
	pha
	lda cia2base+13
	dec LKIntTimer
	bne exeBAS4
	LoadB cia2base+13, $7f
	LoadW nmivec, OS_ROM
	ldy #2
exeBAS1:
	lda LKSaveBASIC, y
	sta BASICspace, y
	dey
	bpl exeBAS1
	MoveW LKSaveR7, cardDataPntr+1
	iny
exeBAS2:
	lda LoKernalBuf,y
	beq exeBAS3
	sta (curScrLine),y
	lda #14
	sta curScrLineColor,y
	iny
	bne exeBAS2
exeBAS3:
	tya
	beq exeBAS4
	LoadB curPos, $28
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
exeBAS4:
	pla
	tay
	pla
	rti
.endif
