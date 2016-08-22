; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library

.include "config.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "jumptab.inc"

; syscalls
.global _BBMult
.global _BMult
.global _CRC
.global _DMult
.global _DSDiv
.global _DShiftLeft
.global _DShiftRight
.global _Dabs
.global _Ddec
.global _Ddiv
.global _Dnegate
.global _GetRandom

.segment "math1"

;---------------------------------------------------------------
; DShiftLeft                                              $C15D
;
; Function:  Arithmetically shift operand left n bits. Computes
;            operand * 2^n
;
; Pass:      x   add of zpage Reg
;            y   nbr of bits to shift left
; Return:    (x) Reg pointed by x is shifted
; Destroyed: y
;---------------------------------------------------------------
_DShiftLeft:
	dey
.if wheels
	bmi BBMult_ret
.else
	bmi @1
.endif
	asl zpage,x
	rol zpage+1,x
	jmp _DShiftLeft
.if !wheels
@1:	rts
.endif

;---------------------------------------------------------------
;---------------------------------------------------------------
_DShiftRight:
	dey
.if wheels
	bmi BBMult_ret
.else
	bmi @1
.endif
	lsr zpage+1,x
	ror zpage,x
	jmp _DShiftRight
.if !wheels
@1:	rts
.endif

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
_DSDiv:
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

;---------------------------------------------------------------
; Dabs                                                    $C16F
;
; Function:  Compute the absolute value of a twos-complement
;            word.
;
; Pass:      x   add. of zpage contaning the nbr
; Return:    x   zpage : contains the absolute value
; Destroyed: a
;---------------------------------------------------------------
_Dabs:
	lda zpage+1,x
	bmi _Dnegate
	rts
;---------------------------------------------------------------
; Dnegate                                                 $C172
;
; Function:  Negate a twos-complement word
;
; Pass:      x   add. of zpage : word
; Return:    destination zpage gets negated
; Destroyed: a, y
;---------------------------------------------------------------
_Dnegate:
	lda zpage+1,x
	eor #$FF
	sta zpage+1,x
	lda zpage,x
	eor #$FF
	sta zpage,x
	inc zpage,x
	bne @1
	inc zpage+1,x
@1:	rts

;---------------------------------------------------------------
; Ddec                                                    $C175
;
; Function:  Decrements an unsigned word
;
; Pass:      x   add. of zpage contaning the nbr
; Return:    x   zpage: contains the decremented nbr
; Destroyed: a
;---------------------------------------------------------------
_Ddec:
	lda zpage,x
	bne @1
	dec zpage+1,x
@1:	dec zpage,x
	lda zpage,x
	ora zpage+1,x
	rts

;---------------------------------------------------------------
; GetRandom                                               $C187
;
; Function:  Get 16 bit pseudorandom number.
;
; Pass:      nothing
; Return:    ramdom - contains new 16 bit nbr
; Destroyed: a
;---------------------------------------------------------------
_GetRandom:
	inc random
	bne @1
	inc random+1
@1:	asl random
	rol random+1
	bcc @3
	clc
	lda #$0F
	adc random
	sta random
	bcc @2
	inc random+1
@2:	rts
@3:
.if wheels
	CmpBI random+1, $f1
.else
	CmpBI random+1, $ff
.endif
	bcc @4
	lda random
.if wheels
	sbc #$f1
.else
	subv $f1
.endif
	bcc @4
	sta random
	lda #0
	sta random+1
@4:	rts

.segment "math2"

;---------------------------------------------------------------
; CRC                                                     $C20E
;
; Function:  CRC performs a checksum on specified data
;
; Pass:      r0  ptr to data
;            r1  nbr of bytes to check
; Return:    r2  checksum
; Destroyed: a, x, y, r0, r1, r3l
;---------------------------------------------------------------
_CRC:
	ldy #$ff
	sty r2L
	sty r2H
	iny
@1:	lda #$80
	sta r3L
@2:	asl r2L
	rol r2H
	lda (r0),y
	and r3L
	bcc @3
	eor r3L
@3:	beq @4
	lda r2L
	eor #$21
	sta r2L
	lda r2H
	eor #$10
	sta r2H
@4:	lsr r3L
	bcc @2
	iny
	bne @5
	inc r0H
@5:	ldx #r1
	jsr Ddec
	lda r1L
	ora r1H
	bne @1
	rts
