.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu0"

	jmp L51B6

	jmp L51D8

	jmp L51E6

	jmp L51F3

	jmp L5208

	jmp L5235

	jmp L5266

	jmp L52C8

	jmp L5325

	jmp L5374

	jmp L52F4

	.byte "MR"
	.byte $22
L5024:	.byte $00
L5025:	.byte $7E,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
L5045:	.byte $7E,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
L5064:	.byte $00,$00,$00,$00,$00,$00,$00,$00
L506C:	.byte $00,$00,$00,$00,$00,$00,$00,$00
L5074:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$42,$51,$7B,$51
L5109:	.byte $59,$17,$35,$1F,$2F,$3D,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$69,$15,$1F,$33,$35,$1B,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$51,$6F,$A5,$9D,$9B,$99
	.byte $9B,$7D,$FF,$61,$11,$23,$35,$1B
	.byte $8B,$BF,$FF,$53,$6D,$63,$8B,$BF
	.byte $FF
	jsr L51A7
	lda r11H
	pha
	lda r11L
	pha
	jsr L5194
	jsr L518B
	lda #$20
	jsr PutChar
	jsr L518E
	pla
	sta r11L
	pla
	sta r11H
	clc
	lda r1H
	adc #$0A
	sta r1H
	jsr L5197
	jsr L5191
L516C:	ldx #$38
L516E:	lda L5109,x
	asl a
	eor #$FF
	sta L5109,x
	dex
	bpl L516E
	rts

	jsr L51A7
	ldy #$2A
L5180:	lda L5109,y
	sta (r0L),y
	dey
	bpl L5180
	jmp L516C

L518B:	lda #$00
	.byte $2C
L518E:	lda #$11
	.byte $2C
L5191:	lda #$22
	.byte $2C
L5194:	lda #$2B
	.byte $2C
L5197:	lda #$33
	clc
	adc #$09
	sta r0L
	lda #$51
	adc #$00
	sta r0H
	jmp PutString

L51A7:	ldx #$38
L51A9:	lda L5109,x
	eor #$FF
	lsr a
	sta L5109,x
	dex
	bpl L51A9
	rts

L51B6:	ldy #$1F
L51B8:	lda L5025,y
	sta L5045,y
	dey
	bpl L51B8
L51C1:	tya
	pha
	ldy #$00
	tya
L51C6:	eor L5025,y
	clc
	adc L5025,y
	iny
	cpy #$E0
	bcc L51C6
	sta L5024
	pla
	tay
	rts

L51D8:	ldy #$1F
L51DA:	lda L5045,y
	sta L5025,y
	dey
	bpl L51DA
	jmp L51C1

L51E6:	ldy #$1F
	lda #$00
L51EA:	sta L5045,y
	dey
	bpl L51EA
	jmp L51C1

L51F3:	jsr L5212
	bcs L520F
	beq L520F
L51FA:	lda L522D,x
	eor L5045,y
	sta L5045,y
	ldx #$00
	jmp L51C1

L5208:	jsr L5212
	bcs L520F
	beq L51FA
L520F:	ldx #$06
	rts

L5212:	sec
	lda r6L
	beq L522C
	cmp $88C3
	bcs L522C
	pha
	lsr a
	lsr a
	lsr a
	tay
	pla
	and #$07
	tax
	lda L522D,x
	and L5045,y
	clc
L522C:	rts

L522D:	.byte $80, $40, $20, $10, $08, $04, 02, $01

L5235:	jsr L51B6
	ldx $88C3
	dex
	stx r2L
	lda #$00
	sta r3L
	jsr L5266
	lda r6H
	sta r2L
	jsr L51B6
	lda #$00
	sta r4L
	sta r4H
	lda #$01
	sta r6L
L5256:	jsr L5212
	bcs L5263
	beq L525F
	inc r4H
L525F:	inc r6L
	bne L5256
L5263:	jmp L51B6

L5266:	ldx r3L
	stx L52C7
	bne L526E
	inx
L526E:	stx r6L
	stx r3L
	stx r9L
	lda #$00
	sta r6H
	lda r2L
	sta r3H
L527C:	lda #$00
	sta r2H
L5280:	jsr L5212
	bcs L52C4
	bne L5293
	lda r2L
	sta r3H
	inc r6L
	lda r6L
	sta r9L
	bne L527C
L5293:	inc r2H
	lda r2H
	cmp r6H
	bcc L52A1
	sta r6H
	lda r9L
	sta r3L
L52A1:	inc r6L
	dec r3H
	bne L5280
	lda r2H
	sta r3H
	lda r9L
	sta r6L
	lda L52C7
	beq L52B8
	cmp r3L
	bne L52C4
L52B8:	jsr L51F3
	inc r6L
	dec r3H
	bne L52B8
	ldx #$00
	rts

L52C4:	ldx #$03
	rts

L52C7:	.byte $01
L52C8:	lda NUMDRV
	cmp #$02
	bcc L52F3
	ldy r4L
	lda $8486,y
	beq L52F3
	tya
	jsr SetDevice
	jsr PurgeTurbo
	lda #$00
	ldy curDrive
	sta $8486,y
	sta $88BF,y
	sta $88C6
	sta curDrive
	sta curDevice
	dec NUMDRV
L52F3:	rts

L52F4:	tya
	pha
	lda L5064,y
	sta r7L
	lda L5074,y
	sta r2L
	lda L506C,y
	sta r3L
	jsr L530B
	pla
	tay
	rts

L530B:	lda #$50
	sta r1H
	lda #$7D
	sta r1L
	dey
	beq L5324
L5316:	clc
	lda #$11
	adc r1L
	sta r1L
	bcc L5321
	inc r1H
L5321:	dey
	bne L5316
L5324:	rts

L5325:	ldx #$04
	tya
	beq L5334
	cpy #$09
	bcs L5372
	lda L506C,y
	beq L5340
	rts

L5334:	iny
L5335:	lda L506C,y
	beq L5340
	iny
	cpy #$09
	bcc L5335
	rts

L5340:	sty L5373
	jsr L51B6
	jsr L5266
	txa
	bne L5372
	ldy L5373
	lda r3L
	sta L506C,y
	lda r2L
	sta L5074,y
	lda r7L
	sta L5064,y
	jsr L530B
	ldy #$10
L5363:	lda (r0L),y
	sta (r1L),y
	dey
	bpl L5363
	jsr L51D8
	ldy L5373
	ldx #$00
L5372:	rts

L5373:	.byte $01
L5374:	ldx #$0D
	tya
	beq L5382
	cpy #$09
	bcs L5382
	lda L506C,y
	bne L5383
L5382:	rts

L5383:	sty L5373
	jsr L51B6
	ldy L5373
	lda L506C,y
	sta r6L
	lda L5074,y
	sta r3H
	beq L53A1
L5398:	jsr L5208
	inc r6L
	dec r3H
	bne L5398
L53A1:	ldy L5373
	lda #$00
	sta L5064,y
	sta L5074,y
	sta L506C,y
	jsr L530B
	ldy #$00
	tya
	sta (r1L),y
	jsr L51D8
	ldx #$00
	rts

