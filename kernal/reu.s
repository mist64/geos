; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/REU driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

; syscalls
.global _DoRAMOp
.global _FetchRAM
.global _StashRAM
.global _SwapRAM
.global _VerifyRAM

.segment "reu"

.if (REUPresent)
_VerifyRAM:
	ldy #$93
.if wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_StashRAM:
	ldy #$90
.if wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_SwapRAM:
	ldy #$92
.if wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_FetchRAM:
	ldy #$91
_DoRAMOp:
	ldx #DEV_NOT_FOUND
	lda r3L
	cmp ramExpSize
	bcs @3 ; beyond end of REU
	php
	sei
	PushB CPU_DATA
.if wheels
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN

	PushB clkreg
	LoadB clkreg, 0
	ldx #4
@1:	lda r0L-1,x
	sta EXP_BASE+1,x
	dex
	bne @1
	MoveW r2, EXP_BASE+7
	lda r3L
	sta EXP_BASE+6
	stx EXP_BASE+9
	stx EXP_BASE+10
	sty EXP_BASE+1
	ldx EXP_BASE+1
	PopB clkreg
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	plp
	txa
	and #%01100000
	cmp #%01100000
	beq @2
	ldx #0
	.byte $2c
@2:	ldx #WR_VER_ERR
.else
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	MoveW r0, EXP_BASE+2
	MoveW r1, EXP_BASE+4
	MoveB r3L, EXP_BASE+6
	MoveW r2, EXP_BASE+7
	lda #0
	sta EXP_BASE+9
	sta EXP_BASE+10
	sty EXP_BASE+1
@1:	lda EXP_BASE
	and #%01100000
	beq @1
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	ldx #0
.endif
@3:	rts
.endif ; REUPresent

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
ASSERT_NOT_BELOW_IO
	stx CPU_DATA

RamExRdH_1:
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	lda (r1),y
	ldx #IO_IN
ASSERT_NOT_BELOW_IO
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
ASSERT_NOT_BELOW_IO
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
ASSERT_NOT_BELOW_IO
	stx CPU_DATA
	ldx #0
	stx PLUS60K_CR
	lda (r0),y
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	sta (r1),y
	iny
	bne RamExWrH_1
	inc r0H
	inc r1H
	dec r2H
	bpl RamExWrH_1
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	LoadB PLUS60K_CR, 0
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
RamExpWrHlpEnd:
.endif


.if (useRamCart64)
RamExpRead:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
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
ASSERT_NOT_BELOW_IO
	rts

RamExpWrite:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
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
ASSERT_NOT_BELOW_IO
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
	bne @X
	inc r1H
@X:	dex
	bpl RamExRd_0
RamExRd_End:
	PopB r0H
	PopW r1
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

RamExpWrite:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
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
	bne @X
	inc r1H
@X:	dex
	bpl RamExWr_0
	jmp RamExRd_End
.endif
