.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reux"

	jmp L4027

	jsr L4057
L4006:	jsr FetchRAM
	ldy #$00
L400B:	lda (r0L),y
	sta (r5L),y
	iny
	cpy #$D0
	bcc L400B
	jsr L408F
	dec r3H
	bne L4006
	jsr L40A8
	jsr FetchRAM
	jsr L407E
	jmp RstrColor

L4027:	jsr L4057
L402A:	ldy #$00
L402C:	lda (r5L),y
	sta (r0L),y
	iny
	cpy #$D0
	bcc L402C
	jsr StashRAM
	jsr L408F
	dec r3H
	bne L402A
	lda r1H
	pha
	lda r1L
	pha
	jsr L407E
	jsr SaveColor
	pla
	sta r1L
	pla
	sta r1H
	jsr L40A8
	jmp StashRAM

L4057:	lda #$A5
	sta r5H
	lda #$38
	sta r5L
	lda #$85
	sta r0H
	lda #$1F
	sta r0L
	lda #$BB
	sta r1H
	lda #$00
	sta r1L
	lda #$D0
	sta r2L
	lda #$00
	sta r2H
	sta r3L
	lda #$0F
	sta r3H
	rts

L407E:	lda #$07
	sta r1L
	lda #$04
	sta r1H
	lda #$1A
	sta r2L
	lda #$0F
	sta r2H
	rts

L408F:	clc
	lda #$D0
	adc r1L
	sta r1L
	bcc L409A
	inc r1H
L409A:	clc
	lda #$40
	adc r5L
	sta r5L
	lda #$01
	adc r5H
	sta r5H
	rts

L40A8:	lda #$01
	sta r2H
	lda #$86
	sta r2L
	rts

	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$FF
