; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak; Michael Steil
;
; Purgeable start code; first entry

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import InitGEOEnv
.import _DoFirstInitIO
.import LdApplic
.import GetBlock
.import EnterDeskTop
.import _EnterDeskTop
.import SetNewMode
.import PutDirHead
.import GetDirHead
.import OpenDisk
.import _IRQHandler128
.import currentDay
.import currentMonth
.import currentYear
.import currentMinute
.import AMPM
.import currentHour
.import FirstInit
.import ClrScr
.import i_FillRam
.import _NMIHandler

E03E4 = $03e4

E8FE8 = $8fe8
E8FF0 = $8ff0

.global _ResetHandle

.segment "start"

_ResetHandle:
	sei
	cld
	ldx #$ff
	txs
	LoadB config, CIOIN
	LoadB mmu+6, 0
	LDA #<_NMIHandler
	sta $fffa
	sta $fffc
	sta $fffe
	lda #>_NMIHandler
	sta $fffb
	sta $fffd
	sta $ffff
	jsr i_FillRam
	.word $0500
	.word dirEntryBuf
	.byte 0
	lda mmu+5
	and #%10000000
	eor #%10000000
	sta graphMode
	jsr ClrScr
	LoadB mmu+6, %01000000
	jsr FirstInit
	jsr MOUSE_JMP
	LoadB L8890, $ff
	LoadB interleave, currentInterleave
	ldy curDevice
	lda #DRV_TYPE
	sta _driveType,y
	sty curDrive

	ldx #0
	lda $5f0f
	cmp #$13
	bne Boot2
	bbrf 7, $5f13, Boot2
	ldy #3
Boot1:	lda $5f06,y		;506f
	cmp bootTest,y
	bne Boot2
	dey
	bpl Boot1
	ldx #%10000000
Boot2:	txa			;507c
	sta firstBoot
	beq Boot4
	ldy #2
Boot3:	lda $5f18,y		;5084
	sta year,y
	dey
	bpl Boot3
	MoveB $5f12, sysRAMFlg
	MoveB cia1base+8, cia1base+8
	bra Boot6

Boot4:	lda cia1base+15		;509c
	and #%01111111
	sta cia1base+15
;	LoadB cia1base+11, currentHour | (AMPM << 7)
;	LoadB cia1base+10, currentMinute
;	LoadW cia1base+8, 0
;	LoadB year, currentYear
;	LoadB month, currentMonth
;	LoadB day, currentDay
	ldx #7
	lda #$bb
Boot5:	sta E8FE8,x		;50c7
	dex
	bpl Boot5
	LoadB E8FF0, $bf
Boot6:	lda #>_IRQHandler128	;50d2
	sta $ffff
	lda #<_IRQHandler128
	sta $fffe
	ldy #5
Boot6_1:
	lda $fffa,y		;50de
	sta fileTrScTab,y
	dey
	bpl Boot6_1
	PushB mmu+6
	and #%11110000
	ora #%00001110
	sta mmu+6
	ldy #5
Boot6_2:
	lda fileTrScTab,y	;50f4
	sta $fffa,y
	dey
	bpl Boot6_2
	ldy #7
Boot6_3:
	lda E5131,y		;50ff
	sta E03E4,y
	dey
	bpl Boot6_3
	PopB mmu+6
	jsr OpenDisk
	jsr GetDirHead
	bnex Boot6_4
	MoveB curDirHead+0, bootTr2	; this is to get dir t&s from disk
	MoveB curDirHead+1, bootSec2
	lda #'B'
	cmp curDirHead+OFF_GS_DTYPE
	beq Boot6_4
	sta curDirHead+OFF_GS_DTYPE
	jsr PutDirHead

Boot6_4:
	lda mmu+5		;511f ;.!.hint why previous?
	and #%10000000
	eor #%10000000
	sta graphMode
	jsr SetNewMode
	jmp Boot7

E5131:	LoadB config, CIOIN	;5131
	jmp OS_ROM

Boot7:	MoveB bootSec, r1H	;5139
	MoveB bootTr, r1L
	AddVB 32, bootOffs
	bne Boot10
Boot8:	MoveB bootSec2, r1H	;514e
	MoveB bootTr2, r1L
	bne Boot10
Boot8_2:
	lda NUMDRV		;515a
	bne Boot9
	inc NUMDRV
Boot9:	LoadB firstBoot, $ff	;5162
	lda #>_EnterDeskTop
	sta EnterDeskTop+2
	lda #<_EnterDeskTop
	sta EnterDeskTop+1
	jmp EnterDeskTop
Boot10:	MoveB r1H, bootSec	;5174
	MoveB r1L, bootTr
	LoadW r4, diskBlkBuf
	jsr GetBlock
	bnex Boot8_2
	MoveB diskBlkBuf+1, bootSec2
	MoveB diskBlkBuf, bootTr2
Boot101:
 	ldy bootOffs
	lda diskBlkBuf+2,y
	beq Boot11
	lda diskBlkBuf+$18,y
	cmp #AUTO_EXEC
	beq Boot12
Boot11:	AddVB 32, bootOffs	;51a7
	bne Boot101
	beq Boot8
Boot12:	ldx #0			;51b4
Boot13:	lda diskBlkBuf+2,y	;51b6
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
	jsr LdApplic
_BootEnterDeskTop:			;51db
	sei
	cld
	ldx #$ff
	txs
	jsr _DoFirstInitIO
	jsr InitGEOEnv
	jmp Boot7

bootTr:		.byte 0			;51e9
bootSec: 	.byte 0
bootTr2: 	.byte DIR_TRACK
bootSec2:	.byte 1
bootOffs:	.byte $e0

bootTest:	.byte "GEOS"		;51ee
