; various math routines

.include "geossym.inc"
.include "geosmac.inc"
.include "jumptab.inc"
.global ConvertBCD, _BBMult, _BMult, _CRC, _DMult, _DSDiv, _DShiftLeft, _DShiftRight, _Dabs, _Ddec, _Ddiv, _Dnegate, _GetRandom

.segment "math"

_DShiftLeft:
	dey
	bmi DShLf0
	asl zpage,X
	rol zpage+1,X
	jmp _DShiftLeft
DShLf0:
	rts
_DShiftRight:
	dey
	bmi DShRg0
	lsr zpage+1,X
	ror zpage,X
	jmp _DShiftRight
DShRg0:
	rts

_BBMult:
	lda zpage,Y
	sta r8H
	sty r8L
	ldy #8
	lda #0
BBMul0:
	lsr r8H
	bcc BBMul1
	clc
	adc zpage,X
BBMul1:
	ror
	ror r7L
	dey
	bne BBMul0
	sta zpage+1,X
	lda r7L
	sta zpage,X
	ldy r8L
	rts

_BMult:
	lda #0
	sta zpage+1,Y
_DMult:
	LoadB r8L, 16
	LoadW r7, 0
BMult0:
	lsr zpage+1,X
	ror zpage,X
	bcc BMult1
	lda r7L
	clc
	adc zpage,Y
	sta r7L
	lda r7H
	adc zpage+1,Y
BMult1:
	lsr
	sta r7H
	ror r7L
	ror r6H
	ror r6L
	dec r8L
	bne BMult0
	lda r6L
	sta zpage,X
	lda r6H
	sta zpage+1,X
	rts

_Ddiv:
	LoadW r8, 0
	LoadB r9L, 16
Ddivl0:
	asl zpage,X
	rol zpage+1,X
	rol r8L
	rol r8H
	lda r8L
	sec
	sbc zpage,Y
	sta r9H
	lda r8H
	sbc zpage+1,Y
	bcc Ddivl1
	inc zpage,X
	sta r8H
	lda r9H
	sta r8L
Ddivl1:
	dec r9L
	bne Ddivl0
Ddivl2:
	rts

_DSDiv:
	lda zpage+1,X
	eor zpage+1,Y
	php
	jsr _Dabs
	stx r8L
	tya
	tax
	jsr _Dabs
	ldx r8L
	jsr _Ddiv
	plp
	bpl Ddivl1
	jsr _Dnegate
	rts

_Dabs:
	lda zpage+1,X
	bmi _Dnegate
	rts
_Dnegate:
	lda zpage+1,X
	eor #$FF
	sta zpage+1,X
	lda zpage,X
	eor #$FF
	sta zpage,X
	inc zpage,X
	bne Dnegate1
	inc zpage+1,X
Dnegate1:
	rts

_Ddec:
	lda zpage,X
	bne Ddecl0
	dec zpage+1,X
Ddecl0:
	dec zpage,X
	lda zpage,X
	ora zpage+1,X
	rts

_GetRandom:
	inc random
	bne GRandl0
	inc random+1
GRandl0:
	asl random
	rol random+1
	bcc GRandl2
	clc
	lda #$0F
	adc random
	sta random
	bcc GRandl1
	inc random+1
GRandl1:
	rts
GRandl2:
	CmpBI random+1, $ff
	bcc GRandl3
	lda random
	subv $f1
	bcc GRandl3
	sta random
	lda #0
	sta random+1
GRandl3:
	rts

.segment "math2"

_CRC:
	ldy #$ff
	sty r2L
	sty r2H
	iny
CRC1:
	lda #$80
	sta r3L
CRC2:
	asl r2L
	rol r2H
	lda (r0),y
	and r3L
	bcc CRC3
	eor r3L
CRC3:
	beq CRC4
	lda r2L
	eor #$21
	sta r2L
	lda r2H
	eor #$10
	sta r2H
CRC4:
	lsr r3L
	bcc CRC2
	iny
	bne CRC5
	inc r0H
CRC5:
	ldx #r1
	jsr Ddec
	lda r1L
	ora r1H
	bne CRC1
	rts

.segment "X"

ConvertBCD:
	pha
	and #%11110000
	lsr
	lsr
	lsr
	lsr
	tay
	pla
	and #%00001111
	clc
CvtBCD1:
	dey
	bmi CvtBCD2
	adc #10
	bne CvtBCD1
CvtBCD2:
	rts
