.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu1"

LFFA8 = $FFA8
LFF93 = $FF93
LFFB1 = $FFB1
LFFAE = $FFAE

	jmp L5006

	jmp L5098

L5006:	stx L5061
	txa
	ora #$20
	sta L505C
	and #$1F
	ora #$40
	sta L505D
	jsr PurgeTurbo
	jsr InitForIO
	lda #$50
	sta z8c
	lda #$56
	sta z8b
	ldy #$08
	lda $88C6
	bmi L503E
	cmp #$01
	beq L5039
	lda #$50
	sta z8c
	lda #$5E
	sta z8b
	ldy #$04
L5039:	jsr L5062
	bne L5053
L503E:	ldy L5061
	cpy #$08
	bcc L5053
	cpy #$0C
	bcs L5053
	lda #$00
	sta diskOpenFlg,y
	sty curDrive
	sty curDevice
L5053:	jmp DoneWithIO

	.byte "M-W"
	.byte $77
	.word $0200
L505C:	plp
L505D:	pha
	eor mouseOn,x
	.byte $3E
L5061:	php
L5062:	sty L5097
	jsr LFFAE
	lda #$00
	sta STATUS
	lda curDevice
	jsr LFFB1
	lda STATUS
	bne L5091
	lda #$6F
	jsr LFF93
	lda STATUS
	bne L5091
	ldy #$00
L5080:	lda (z8b),y
	jsr LFFA8
	iny
	cpy L5097
	bcc L5080
	jsr LFFAE
	ldx #$00
	rts

L5091:	jsr LFFAE
	ldx #$0D
	rts

L5097:	brk
L5098:	lda curDrive
	pha
	ldx r5L
	lda $8486,x
	sta L5168
	beq L50B9
	txa
	jsr SetDevice
	ldx #$19
	jsr L5006
	ldx r5L
	lda #$00
	sta $8486,x
	sta $88C6
L50B9:	ldx r5H
	lda $8486,x
	sta L5169
	beq L50D6
	txa
	jsr SetDevice
	ldx r5L
	jsr L5006
	ldx r5H
	lda #$00
	sta $8486,x
	sta $88C6
L50D6:	ldx r5L
	jsr L513F
	ldx r5H
	jsr L513F
	ldx r5L
	jsr L513F
	lda #$00
	sta curDrive
	ldx r5L
	lda L5169
	sta $8486,x
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
	sta $8486,x
	beq L5127
	txa
	jsr SetDevice
	lda #$19
	sta curDevice
	ldx r5H
	jsr L5006
L5127:	pla
	cmp r5L
	beq L5131
	cmp r5H
	beq L5134
	.byte $2C
L5131:	lda r5H
	.byte $2C
L5134:	lda r5L
	jsr SetDevice
	bne L513E
	jsr EnterTurbo
L513E:	rts

L513F:	lda #$90
	sta r0H
	lda #$00
	sta r0L
	lda L5158,x
	sta r1L
	lda L515C,x
	sta r1H
	lda #$0D
	sta r2H
	lda #$80
	.byte $85
L5158:	asl $A9
	brk
	.byte $85
L515C:	php
	jmp SwapRAM

	.byte $00,$80,$00,$80,$83,$90,$9E,$AB
L5168:	.byte $00
L5169:	.byte $00
