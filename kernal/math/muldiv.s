; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: BBMult, BMult, DMult, Ddiv, DSdiv syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _Dnegate
.import _Dabs

.global _BBMult
.global _BMult
.global _DMult
.global _Ddiv
.global _DSdiv

.ifdef wheels
.global BBMult_ret
.endif

.segment "math1b"

;---------------------------------------------------------------
; BBMult                                                  $C160
;
; Function:  Multiply two unsigned byte operands and store
;            product in word addressed by x.
;
; Pass:      x   address of destination zpage
;            y   address of source zpage
; Return:    x,y unchanged
; Destroyed: a, r7, r8
;---------------------------------------------------------------
_BBMult:
	lda zpage,Y
	sta r8H
	sty r8L
	ldy #8
	lda #0
@1:	lsr r8H
	bcc @2
	clc
	adc zpage,x
@2:	ror
	ror r7L
	dey
	bne @1
	sta zpage+1,x
	lda r7L
	sta zpage,x
	ldy r8L
BBMult_ret:
	rts

;---------------------------------------------------------------
;---------------------------------------------------------------
_BMult:
	lda #0
	sta zpage+1,Y
;---------------------------------------------------------------
;---------------------------------------------------------------
_DMult:
	LoadB r8L, 16
	LoadW_ r7, 0
@1:	lsr zpage+1,x
	ror zpage,x
	bcc @2
	lda r7L
	clc
	adc zpage,Y
	sta r7L
	lda r7H
	adc zpage+1,Y
@2:	lsr
	sta r7H
	ror r7L
	ror r6H
	ror r6L
	dec r8L
	bne @1
	lda r6L
	sta zpage,x
	lda r6H
	sta zpage+1,x
	rts

;---------------------------------------------------------------
; Ddiv                                                    $C169
;
; Function:  Divide unsigned destination word by source word,
;            and store quotient in destination. Store remainder
;            in r8.
;
; Pass:      x   add. of zpage: destination
;            y   add. of zpage: source
; Return:    destination zpage: 16 bit result
;            r8 remainder
; Destroyed: a, r9
;---------------------------------------------------------------
_Ddiv:
	LoadW_ r8, 0
	LoadB r9L, 16
@1:	asl zpage,x
	rol zpage+1,x
	rol r8L
	rol r8H
	lda r8L
	sec
	sbc zpage,Y
	sta r9H
	lda r8H
	sbc zpage+1,Y
	bcc @2
	inc zpage,x
	sta r8H
	lda r9H
	sta r8L
@2:	dec r9L
	bne @1
	rts

;---------------------------------------------------------------
; DSdiv                                                   $C16C
;
; Function:  Divide signed source word by signed destination
;            word. Store quotient in destination. Store
;            remainder in r8.
;
; Pass:      x   add of destination zpage Reg
;            y   add of source zpage Reg
; Return:    r8  the remainder
; Destroyed: a, r9
;---------------------------------------------------------------
_DSdiv:
	lda zpage+1,x
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
	bpl @1
	jsr _Dnegate
@1:	rts

