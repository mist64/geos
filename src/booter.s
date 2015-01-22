;GEOS Kernal - booter code
;reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import ClrScr, EnterDeskTop, FirstInit, GetBlock, GetDirHead, InitGEOEnv, LdApplic, OpenDisk, PutDirHead, _DoFirstInitIO, _EnterDeskTop, _FirstInit, _IRQHandler, _NMIHandler, i_FillRam

.segment "booter"

	sei
	cld
	ldx #$ff
	txs
	LoadB CPU_DATA, RAM_64K
	lda #<_NMIHandler
	sta $fffa
	sta $fffc
	sta $fffe
	lda #>_NMIHandler
	sta $fffb
	sta $fffd
	sta $ffff
	jsr ClrScr
	jsr i_FillRam
	.word $0500
	.word dirEntryBuf
	.byte 0
	jsr FirstInit
	jsr MOUSE_JMP
	LoadB interleave, currentInterleave
	ldy curDevice
.if (use1541)
	lda #DRV_1541
.elseif (use1571)
	lda #DRV_1571
.elseif (use1581)
	lda #DRV_1581
.endif
	sta _driveType,y
	sty curDrive
.if (REUPresent)
	ldx #0
	lda $5f0f
	cmp #$13
	bne Boot2
	ldy #3
Boot1:
	lda $5f06,y
	cmp bootTest,y
	bne Boot2
	dey
	bpl Boot1
.endif
	ldx #$80
Boot2:
	txa
	sta firstBoot
	beq Boot4
.if (REUPresent)
	ldy #2
Boot3:
	lda $5f18,y
	sta year,y
	dey
	bpl Boot3
	MoveB $5f12, sysRAMFlg
	bra Boot6
.endif
Boot4:
	LoadB CPU_DATA, IO_IN
	lda cia1base+15
	and #%01111111
	sta cia1base+15
	LoadB cia1base+11, currentHour | (AMPM << 7)
	LoadB cia1base+10, currentMinute
	LoadW cia1base+8, 0
	LoadB CPU_DATA, $30
	LoadB year, currentYear
	LoadB month, currentMonth
	LoadB day, currentDay
	ldx #7
	lda #$bb
Boot5:
	sta A8FE8,x
	dex
	bpl Boot5
	LoadB A8FF0, $bf
Boot6:
	lda #>_IRQHandler
	sta $ffff
	lda #<_IRQHandler
	sta $fffe
.if (use2MHz)
	LoadB rasreg, $fc
.endif
.if (useRamCart64 | useRamCart128)
	LoadB CPU_DATA, IO_IN
	LoadW RAMC_BASE, 0
	ldx RAMC_WINDOW
	ldy RAMC_WINDOW+$80
	lda #'M'
	sta RAMC_WINDOW
	lda #'W'
	sta RAMC_WINDOW+$80
	cmp RAMC_WINDOW+$80
	bne BootNotRC
	lda RAMC_WINDOW
	cmp #'M'
	bne BootNotRC
	stx RAMC_WINDOW
	sty RAMC_WINDOW
	jmp BootRC_OK
BootNotRC:
	LoadB CPU_DATA, $30
	lda #>ExpFaultDB
	sta r0H
	lda #<ExpFaultDB
	sta r0L
	jsr DoDlgBox
	jmp ToBASIC
BootRC_OK:
	LoadB CPU_DATA, $30
.endif

.if (usePlus60K)
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
	LoadB CPU_DATA, $30
	lda #>ExpFaultDB
	sta r0H
	lda #<ExpFaultDB
	sta r0L
	jsr DoDlgBox
	jmp ToBASIC
BootP6K_OK:
	LoadB CPU_DATA, $30
.endif

BootCont:
	jsr OpenDisk
	jsr GetDirHead
	bnex Boot7
	lda #'K'
	cmp curDirHead+OFF_GS_DTYPE
	beq Boot7
	sta curDirHead+OFF_GS_DTYPE
	jsr PutDirHead
Boot7:
	MoveB curDirHead+0, bootTr2
	MoveB curDirHead+1, bootSec2
	MoveB bootSec, r1H
	MoveB bootTr, r1L
	AddVB 32, bootOffs
	bne Boot10
Boot8:
	MoveB bootSec2, r1H
	MoveB bootTr2, r1L
	bne Boot10
	lda NUMDRV
	bne Boot9
	inc NUMDRV
Boot9:
	lda #>_EnterDeskTop
	sta EnterDeskTop+2
	lda #<_EnterDeskTop
	sta EnterDeskTop+1
.if (useRamExp)
	jsr LoadDeskTop
.endif
	jmp _EnterDeskTop

Boot10:
	MoveB r1H, bootSec
	MoveB r1L, bootTr
	LoadW r4, diskBlkBuf
	jsr GetBlock
	bnex Boot9
	MoveB diskBlkBuf+1, bootSec2
	MoveB diskBlkBuf, bootTr2
Boot101:
	ldy bootOffs
	lda diskBlkBuf+2,y
	beq Boot11
	lda diskBlkBuf+$18,y
	cmp #AUTO_EXEC
	beq Boot12
Boot11:
	AddVB 32, bootOffs
	bne Boot101
	beq Boot8
Boot12:
	ldx #0
Boot13:
	lda diskBlkBuf+2,y
	sta dirEntryBuf,x
	iny
	inx
	cpx #30
	bne Boot13
	LoadW r9, dirEntryBuf
	LoadB r0, 0
	lda #>_BootEnterDeskTop
	sta EnterDeskTop+2
	lda #<_BootEnterDeskTop
	sta EnterDeskTop+1
	lda #>(_EnterDeskTop-1)
	pha
	lda #<(_EnterDeskTop-1)
	pha
	lda #>(_FirstInit-1)
	pha
	lda #<(_FirstInit-1)
	pha
	jmp LdApplic

_BootEnterDeskTop:
	sei
	cld
	ldx #$ff
	txs
	jsr _DoFirstInitIO
	jsr InitGEOEnv
	jmp Boot8

.if (usePlus60K)
Plus60KTest:
	ldx #0
	stx PLUS60K_CR
	ldy $1180
	LoadB $1180, ('M')
	LoadB PLUS60K_CR, $80
	lda $1180
	stx PLUS60K_CR
	sty $1180
	cmp #'M'
	rts
Plus60KTestEnd:
.endif

.if (useRamExp)
LoadDeskTop:
	LoadB a0L, NULL
	LoadB BVChainTab, 1 ;1 - first free
LoadDTLp:
	lda #>DeskTopName
	sta r6H
	lda #<DeskTopName
	sta r6L
	jsr FindFile
	beqx LoadDTCont
	lda #>LoadDT_DB
	sta r0H
	lda #<LoadDT_DB
	sta r0L
	jsr DoDlgBox
	jsr NewDisk
	jmp LoadDTLp
LoadDTCont:
	jsr GetFHdrInfo
	lda fileHeader+O_GHST_ADDR+1
	sta DeskTopStart+1
	lda fileHeader+O_GHST_ADDR
	sta DeskTopStart
	lda fileHeader+O_GHST_VEC+1
	sta DeskTopExec+1
	lda fileHeader+O_GHST_VEC
	sta DeskTopExec

	LoadB DeskTopOpen, $88
	lda #>DeskTopName
	sta r0H
	lda #<DeskTopName
	sta r0L
	jsr OpenRecordFile

BLoadDTop:
	lda a0L
	jsr PointRecord
	bnex BVLast
	LoadW r2, $ffff
	LoadW r7, BVBuff
	jsr ReadRecord

	lda r7H
	subv (>BVBuff)
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

	LoadB CPU_DATA, IO_IN
	inc $d020
	LoadB CPU_DATA, $30
	jmp BLoadDTop

BVLast:
	jsr RamExpGetStat
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

bootTr:
	.byte 0
bootSec:
	.byte 0
bootTr2:
	.byte DIR_TRACK
bootSec2:
	.byte 1
bootOffs:
	.byte $e0

bootTest:
	.byte "GEOS"

.if (useRamExp)
LoadDT_DB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word LoadDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word LoadDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL

LoadDT_Str0:
	.byte BOLDON, "Please insert a disk", NULL
LoadDT_Str1:
	.byte "with deskTop V1.5 or higher", NULL

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
	.byte "This version of GEOS works", NULL
ExpFaultStr2:
.if (useRamCart64 | useRamCart128)
	.byte "only with RamCart expansion.", NULL
.endif
.if (usePlus60K)
	.byte "only with +60K expansion.", NULL
.endif

.endif

BVChainTab:
