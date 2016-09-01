; GEOS KERNAL
;
; RAM expansion support by Maciej Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

; load.s
.import DeskTopName
.import _EnterDT_DB

.global RamExpRead
.global RamExpWrite
.global RamExpPutStat
.global RamExpGetStat
.global DeskTopStart
.global DeskTopExec
.global DeskTopLgh
.global DeskTopOpen
.global DeskTopRecord

.global DetectPlus60K
.global DetectRamCart
.global LoadDeskTop

.segment "ramexp1"

.if (usePlus60K)
DetectPlus60K:
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	ldx #0
BootP6K_1:
	lda Plus60KTest,x
	sta $0400,x
	inx
	cpx #Plus60KTestEnd-Plus60KTest
	bne BootP6K_1
	jsr $0400
	bne BootP6K_OK
	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	LoadW r0, ExpFaultDB
	jsr DoDlgBox
	jmp ToBASIC
BootP6K_OK:
	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	rts

Plus60KTest:
	ldx #0
	stx PLUS60K_CR
	ldy $1180
	LoadB $1180, 'M'
	LoadB PLUS60K_CR, $80
	lda $1180
	stx PLUS60K_CR
	sty $1180
	cmp #'M'
	rts
Plus60KTestEnd:
.endif

.if (useRamCart64 | useRamCart128)
DetectRamCart:
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	LoadW RAMC_BASE, 0
	ldx RAMC_WINDOW
	ldy RAMC_WINDOW+$80
	lda #'M'
	sta RAMC_WINDOW
	lda #'W'
	sta RAMC_WINDOW+$80
	cmp RAMC_WINDOW+$80
	bne @1
	lda RAMC_WINDOW
	cmp #'M'
	bne @1
	stx RAMC_WINDOW
	sty RAMC_WINDOW
	jmp @2
@1:	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	LoadW r0, ExpFaultDB
	jsr DoDlgBox
	jmp ToBASIC
@2:	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	rts
.endif

.if (useRamExp)
ExpFaultDB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word ExpFaultStr
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y
	.word ExpFaultStr2
	.byte OK, DBI_X_1, DBI_Y_2
	.byte NULL

ExpFaultStr:
	.byte BOLDON
	.byte "This version of GEOS works", 0
ExpFaultStr2:
.if (useRamCart64 | useRamCart128)
	.byte "only with a RamCart expansion.", 0
.endif
.if (usePlus60K)
	.byte "only with a +60K expansion.", 0
.endif

BVChainTab:

.endif

.if (useRamExp)
LoadDeskTop:
	LoadB a0L, 0
	LoadB BVChainTab, 1	;1 - first free
LoadDTLp:
	LoadW r6, DeskTopName
	jsr FindFile
	beqx LoadDTCont
	LoadW r0, _EnterDT_DB
	jsr DoDlgBox
	jsr NewDisk
	jmp LoadDTLp
LoadDTCont:
	jsr GetFHdrInfo
	MoveW fileHeader+O_GHST_ADDR, DeskTopStart
	MoveW fileHeader+O_GHST_VEC, DeskTopExec

	LoadB DeskTopOpen, $88
	LoadW r0, DeskTopName
	jsr OpenRecordFile

BLoadDTop:
	lda a0L
	jsr PointRecord
	bnex BVLast
	LoadW r2, $ffff
	LoadW r7, BVBuff
	jsr ReadRecord

	lda r7H
	subv >BVBuff
	tay
	ldx a0L
	bne BLoadDTop_1
	sty DeskTopLgh
BLoadDTop_1:
	clc
	adc BVChainTab,x
	adc #1
	sta BVChainTab+1,x
	inc a0L

	LoadB r1H, 0
	lda BVChainTab,x
	sta r1L
	LoadW r0, BVBuff
	sty r2H
	jsr RamExpWrite

ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	inc $d020
	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	jmp BLoadDTop

BVLast:	jsr RamExpGetStat
	MoveB a0L, diskBlkBuf+DTOP_CHNUM
	inc a0L
	ldx #0
BVLast_1:
	lda BVChainTab,x
	sta diskBlkBuf+DTOP_CHAIN,x
	inx
	cpx a0L
	bne BVLast_1
	sta diskBlkBuf+RAM_EXP_1STFREE
	LoadB DeskTopOpen, 0
	jmp RamExpPutStat
.endif

.segment "ramexp2"

.if (useRamExp)
RamExpSetStat:
	LoadW r1, 0
	LoadB r0H, >diskBlkBuf
	LoadB r2H, 0
	sta r0L
	rts
RamExpGetStat:
	jsr RamExpSetStat
	jmp RamExpRead
RamExpPutStat:
	jsr RamExpSetStat
	jmp RamExpWrite

DeskTopOpen:
	.byte 0
DeskTopRecord:
	.byte 0

DeskTopStart:
	.word 0
DeskTopExec:
	.word 0
DeskTopLgh:
	.byte 0
.endif

.if (usePlus60K)
; r0   c64 address
; r1   exp page number (byte/word - RamCart 64/128)
; r2H  # of bytes (in pages)

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
