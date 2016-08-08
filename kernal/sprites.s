; sprites-related functions, handles all sprites (including pointer and prompt)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.import BitMask2
.global _DisablSprite, _DrawSprite, _EnablSprite, _PosSprite

.segment "sprites"

_DrawSprite:
	ldy r3L
	lda SprTabL,Y
	sta r5L
	lda SprTabH,Y
	sta r5H
	ldy #63
DSpr0:
	lda (r4),Y
	sta (r5),Y
	dey
	bpl DSpr0
	rts

SprTabL:
	.byte <spr0pic, <spr1pic, <spr2pic, <spr3pic
	.byte <spr4pic, <spr5pic, <spr6pic, <spr7pic
SprTabH:
	.byte >spr0pic, >spr1pic, >spr2pic, >spr3pic
	.byte >spr4pic, >spr5pic, >spr6pic, >spr7pic

_PosSprite:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda r3L
	asl
	tay
	lda r5L
	addv VIC_Y_POS_OFF
	sta mob0ypos,Y
	lda r4L
	addv VIC_X_POS_OFF
	sta r6L
	lda r4H
	adc #0
	sta r6H
	lda r6L
	sta mob0xpos,Y
	ldx r3L
	lda BitMask2,X
	eor #$FF
	and msbxpos
	tay
	lda #1
	and r6H
	beq PSpr0
	tya
	ora BitMask2,X
	tay
PSpr0:
	sty msbxpos
	PopB CPU_DATA
	rts

_EnablSprite:
	ldx r3L
	lda BitMask2,X
	tax
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	txa
	ora mobenble
	sta mobenble
	PopB CPU_DATA
	rts

_DisablSprite:
	ldx r3L
	lda BitMask2,X
	eor #$FF
	pha
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	pla
	and mobenble
	sta mobenble
	stx CPU_DATA
	rts
