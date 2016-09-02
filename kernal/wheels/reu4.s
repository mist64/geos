.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu4"

	jsr EnterTurbo
	txa
	beq L5007
	rts

L5007:	jsr InitForIO
	lda #$80
	sta r4H
	lda #$00
	sta r4L
	lda r6H
	pha
	lda r6L
	pha
	lda r7H
	pha
	lda r7L
	pha
L501E:	ldy #$00
	lda (r6L),y
	beq L5076
	sta r1L
	iny
	lda (r6L),y
	sta r1H
	dey
	clc
	lda #$02
	adc r6L
	sta r6L
	bcc L5037
	inc r6H
L5037:	lda (r6L),y
	sta (r4L),y
	iny
	lda (r6L),y
	sta (r4L),y
	ldy #$FE
	lda #$30
	sta CPU_DATA
	lda r7H
	cmp #$4F
	bcc L5056
	cmp #$52
	bcs L5056
	jsr L5086
	clv
	bvc L505F
L5056:	dey
	lda (r7L),y
	sta $8002,y
	tya
	bne L5056
L505F:	lda #$36
	sta CPU_DATA
	jsr WriteBlock
	txa
	bne L5077
	clc
	lda #$FE
	adc r7L
	sta r7L
	bcc L501E
	inc r7H
	bne L501E
L5076:	tax
L5077:	pla
	sta r7L
	pla
	sta r7H
	pla
	sta r6L
	pla
	sta r6H
	jmp DoneWithIO

L5086:	lda r9H
	pha
	lda r9L
	pha
	lda r3H
	pha
	lda r3L
	pha
	lda r2H
	pha
	lda r2L
	pha
	lda r1H
	pha
	lda r1L
	pha
	lda r0H
	pha
	lda r0L
	pha
	ldx #$02
	lda r7H
	sta r9H
	lda r7L
	sta r9L
L50AE:	lda r9H
	cmp #$50
	bne L50B8
	lda r9L
	cmp #$00
L50B8:	bcc L50C6
	lda r9H
	cmp #$51
	bne L50C4
	lda r9L
	cmp #$5F
L50C4:	bcc L50DD
L50C6:	ldy #$00
	lda (r9L),y
	sta diskBlkBuf,x
	clc
	lda #$01
	adc r9L
	sta r9L
	bcc L50D8
	inc r9H
L50D8:	inx
	bne L50AE
	beq L5107
L50DD:	jsr L5126
	ldx r0L
L50E2:	clc
	lda #$01
	adc r9L
	sta r9L
	bcc L50ED
	inc r9H
L50ED:	inx
	beq L5107
	lda r9H
	cmp #$51
	bne L50FA
	lda r9L
	cmp #$5F
L50FA:	bcc L50E2
	ldy #$00
L50FE:	lda (r9L),y
	sta diskBlkBuf,x
	iny
	inx
	bne L50FE
L5107:	pla
	sta r0L
	pla
	sta r0H
	pla
	sta r1L
	pla
	sta r1H
	pla
	sta r2L
	pla
	sta r2H
	pla
	sta r3L
	pla
	sta r3H
	pla
	sta r9L
	pla
	sta r9H
	rts

L5126:	sec
	lda r9L
	sbc #$00
	sta r1L
	lda r9H
	sbc #$50
	sta r1H
	stx r0L
	lda #$80
	sta r0H
	dex
	txa
	eor #$FF
	sta r2L
	lda #$00
	sta r2H
	clc
	lda #$7B
	adc r1L
	sta r1L
	lda #$0D
	adc r1H
	sta r1H
	lda $88C3
	sta r3L
	inc $88C3
	jsr FetchRAM
	dec $88C3
	rts

