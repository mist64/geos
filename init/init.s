; GEOS Kernal - init code
; reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.import ClrScr, InitGEOEnv, _DoFirstInitIO, _EnterDeskTop, _FirstInit, _IRQHandler, _NMIHandler

.segment "init"

Init:
	sei
	cld
	ldx #$ff
	jsr _DoFirstInitIO
	jsr InitGEOEnv
	jsr GetDirHead
Init7:
	MoveB bootSec, r1H
	MoveB bootTr, r1L
	AddVB 32, bootOffs
	bne Init10
Init8:
	MoveB bootSec2, r1H
	MoveB bootTr2, r1L
	bne Init10
	lda NUMDRV
	bne Init9
	inc NUMDRV
Init9:
	LoadW EnterDeskTop+1, _EnterDeskTop
	jmp EnterDeskTop

Init10:
	MoveB r1H, bootSec
	MoveB r1L, bootTr
	LoadW r4, diskBlkBuf
	jsr GetBlock
	bnex Init9
	MoveB diskBlkBuf+1, bootSec2
	MoveB diskBlkBuf, bootTr2
Init101:
	ldy bootOffs
	lda diskBlkBuf+2,y
	beq Init11
	lda diskBlkBuf+$18,y
	cmp #AUTO_EXEC
	beq Init12
Init11:
	AddVB 32, bootOffs
	bne Init101
	beq Init8
Init12:
	ldx #0
Init13:
	lda diskBlkBuf+2,y
	sta dirEntryBuf,x
	iny
	inx
	cpx #30
	bne Init13
	LoadW r9, dirEntryBuf
	LoadW EnterDeskTop+1, Init
	LoadB r0L, 0
	jsr LdApplic
bootTr:
	.byte $12
bootSec:
	.byte $01
bootTr2:
	brk
bootSec2:
	brk
bootOffs:
	brk

	.byte $4c, $98, $2c, $90
