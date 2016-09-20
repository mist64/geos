.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import SwapRAM
.import EnterTurbo
.import SetDevice
.import DoneWithIO
.import InitForIO
.import PurgeTurbo

.segment "devnum"

.ifdef wheels

LFFA8 = $FFA8
LFF93 = $FF93
LFFB1 = $FFB1
LFFAE = $FFAE

DevNumChange:
	jmp _DevNumChange
SwapDrives:
	jmp _SwapDrives

; x   new device number
_DevNumChange:
	stx L5061
	txa
	ora #$20
	sta L505C
	and #$1F
	ora #$40
	sta L505D
	jsr PurgeTurbo
	jsr InitForIO
	LoadW z8b, L5056
	ldy #L5056_end - L5056
	lda curType
	bmi L503E
	cmp #1
	beq L5039
	LoadW z8b, L505E
	ldy #L505E_end - L505E
L5039:	jsr L5062
	bne L5053
L503E:	ldy L5061
	cpy #$08
	bcc L5053
	cpy #$0C
	bcs L5053
	lda #0
	sta diskOpenFlg,y
	sty curDrive
	sty curDevice
L5053:	jmp DoneWithIO

L5056:	.byte "M-W"
	.byte $77
	.word $0200
L505C:	.byte $28
L505D:	.byte $48
L5056_end:

L505E:	.byte "U0>"
L5061:	.byte 8
L505E_end:

L5062:	sty L5097
	jsr LFFAE
	lda #0
	sta STATUS
	lda curDevice
	jsr LFFB1
	lda STATUS
	bne L5091
	lda #$6F
	jsr LFF93
	lda STATUS
	bne L5091
	ldy #0
L5080:	lda (z8b),y
	jsr LFFA8
	iny
	cpy L5097
	bcc L5080
	jsr LFFAE
	ldx #0
	rts

L5091:	jsr LFFAE
	ldx #$0D
	rts

L5097:	.byte 0

_SwapDrives:
	PushB curDrive
	ldx r5L
	lda _driveType,x
	sta L5168
	beq L50B9
	txa
	jsr SetDevice
	ldx #$19
	jsr _DevNumChange
	ldx r5L
	lda #0
	sta _driveType,x
	sta curType
L50B9:	ldx r5H
	lda _driveType,x
	sta L5169
	beq L50D6
	txa
	jsr SetDevice
	ldx r5L
	jsr _DevNumChange
	ldx r5H
	lda #0
	sta _driveType,x
	sta curType
L50D6:	ldx r5L
	jsr L513F
	ldx r5H
	jsr L513F
	ldx r5L
	jsr L513F
	lda #0
	sta curDrive
	ldx r5L
	lda L5169
	sta _driveType,x
	ldx r5H
	lda $88BF,x
	pha
	lda e88b7,x
	pha
	ldy r5L
	lda $88BF,y
	sta $88BF,x
	lda e88b7,y
	sta e88b7,x
	pla
	sta e88b7,y
	pla
	sta $88BF,y
	lda L5168
	sta _driveType,x
	beq L5127
	txa
	jsr SetDevice
	lda #$19
	sta curDevice
	ldx r5H
	jsr _DevNumChange
L5127:	pla
	cmp r5L
	beq L5131
	cmp r5H
	beq L5134
	.byte $2c
L5131:	lda r5H
	.byte $2c
L5134:	lda r5L
	jsr SetDevice
	bne L513E
	jsr EnterTurbo
L513E:	rts

L513F:	LoadW r0, DISK_BASE
	lda DriverOffsetsL-8,x
	sta r1L
	lda DriverOffsetsH-8,x
	sta r1H
	LoadW r2, DISK_DRV_LGH
	lda #0
	sta r3L
	jmp SwapRAM

DRIVER_BASE_REU = $8300

.define DriverOffsets DRIVER_BASE_REU, DRIVER_BASE_REU + 1 * DISK_DRV_LGH, DRIVER_BASE_REU + 2 * DISK_DRV_LGH, DRIVER_BASE_REU + 3 * DISK_DRV_LGH

DriverOffsetsL:
	.lobytes DriverOffsets
DriverOffsetsH:
	.hibytes DriverOffsets

L5168:	.byte 0
L5169:	.byte 0

.endif
