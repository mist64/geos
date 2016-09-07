.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu3"

OReadFile:
	jsr EnterTurbo
	txa
	beq L5007
	rts

L5007:	jsr InitForIO
	PushW r0
	LoadW r4, $8000
	lda #$02
	sta r5L
	lda r1H
	sta $8303
	lda r1L
	sta $8302
L5026:	jsr ReadBlock
	txa
	bne L509B
	ldy #$FE
	lda diskBlkBuf
	bne L503B
	ldy $8001
	beq L5081
	dey
	beq L5081
L503B:	lda r2H
	bne L5049
	cpy r2L
	bcc L5049
	beq L5049
	ldx #$0B
	bne L509B
L5049:	sty r1L
	lda #$30
	sta CPU_DATA
	lda r7H
	cmp #$4F
	bcc L505F
	cmp #$52
	bcs L505F
	jsr L50A4
	clv
	bvc L5067
L505F:	lda $8001,y
	dey
	sta (r7L),y
	bne L505F
L5067:	lda #$36
	sta CPU_DATA
	lda r1L
	clc
	adc r7L
	sta r7L
	bcc L5076
	inc r7H
L5076:	lda r2L
	sec
	sbc r1L
	sta r2L
	bcs L5081
	dec r2H
L5081:	inc r5L
	inc r5L
	ldy r5L
	lda $8001
	sta r1H
	sta $8301,y
	lda diskBlkBuf
	sta r1L
	sta fileTrScTab,y
	bne L5026
	ldx #$00
L509B:	pla
	sta r0L
	pla
	sta r0H
	jmp DoneWithIO

L50A4:	lda r10L
	pha
	lda r9H
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
	ldx #$00
	sty r10L
	lda r7H
	sta r9H
	lda r7L
	sta r9L
L50D1:	lda r9H
	cmp #$50
	bne L50DB
	lda r9L
	cmp #$00
L50DB:	bcc L50E9
	lda r9H
	cmp #$51
	bne L50E7
	lda r9L
	cmp #$C2
L50E7:	bcc L5102
L50E9:	ldy #$00
	lda $8002,x
	sta (r9L),y
	clc
	lda #$01
	adc r9L
	sta r9L
	bcc L50FB
	inc r9H
L50FB:	inx
	cpx r10L
	bcc L50D1
	bcs L512D
L5102:	jsr L514F
	clc
	lda r9L
	adc r2L
	sta r9L
	lda r9H
	adc r2H
	sta r9H
	clc
	lda r0L
	adc r2L
	bcs L512D
	tax
	dex
	dex
	cpx r10L
	bcs L512D
	ldy #$00
L5122:	lda $8002,x
	sta (r9L),y
	iny
	inx
	cpx r10L
	bcc L5122
L512D:	pla
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
	pla
	sta r10L
	rts

L514F:	sec
	lda r9L
	sbc #$00
	sta r1L
	lda r9H
	sbc #$50
	sta r1H
	txa
	clc
	adc #$02
	sta r0L
	lda #$80
	sta r0H
	stx r2L
	sec
	lda r10L
	sbc r2L
	sta r2L
	lda #$00
	sta r2H
	clc
	lda r1L
	adc r2L
	sta r3L
	lda r1H
	adc r2H
	sta r3H
	lda r3H
	cmp #$01
	bne L518A
	lda r3L
	cmp #$C2
L518A:	bcc L51A6
	sec
	lda r3L
	sbc #$C2
	sta r3L
	lda r3H
	sbc #$01
	sta r3H
	sec
	lda r2L
	sbc r3L
	sta r2L
	lda r2H
	sbc r3H
	sta r2H
L51A6:	clc
	lda #$27
	adc r1L
	sta r1L
	lda #$06
	adc r1H
	sta r1H
	lda $88C3
	sta r3L
	inc $88C3
	jsr StashRAM
	dec $88C3
	rts

