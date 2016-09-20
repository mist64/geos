; GEOS KERNAL by Berkeley Softworks
;
; C64 RAM expansion support by Maciej Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "ramexp1"

.ifdef usePlus60K
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

.if .defined(useRamCart64) || .defined(useRamCart128)
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

.ifdef useRamExp
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
.if .defined(useRamCart64) || .defined(useRamCart128)
	.byte "only with a RamCart expansion.", 0
.endif
.ifdef usePlus60K
	.byte "only with a +60K expansion.", 0
.endif

BVChainTab:

.endif

.ifdef useRamExp
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

