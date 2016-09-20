.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import SaveColor
.import StashRAM
.import RstrColor
.import FetchRAM

.segment "reux"

.ifdef wheels

L4000:	jmp L4027

L4003:	jsr L4057
L4006:	jsr FetchRAM
	ldy #0
L400B:	lda (r0),y
	sta (r5),y
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
L402A:	ldy #0
L402C:	lda (r5),y
	sta (r0),y
	iny
	cpy #$D0
	bcc L402C
	jsr StashRAM
	jsr L408F
	dec r3H
	bne L402A
	PushW r1
	jsr L407E
	jsr SaveColor
	PopW r1
	jsr L40A8
	jmp StashRAM

L4057:	LoadW r5, $a538
	LoadW r0, dlgBoxRamBuf
	LoadW r1, $bb00
	lda #>$d000
	sta r2L
	lda #<$d000
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

.endif
