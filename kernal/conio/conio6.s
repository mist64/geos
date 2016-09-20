; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: PutDecimal syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _PutChar
.import _GetRealSize

.import NormalizeX

.global _PutDecimal

.segment "conio6"

CalcDecimal:
	sta r2L
	LoadB r2H, 4
	lda #0
	sta r3L
	sta r3H
@1:	ldy #0
	ldx r2H
@2:	lda r0L
	sec
	sbc DecTabL,x
	sta r0L
	lda r0H
	sbc DecTabH,x
	bcc @3
	sta r0H
	iny
.ifdef wheels_size_and_speed ; Y can't be 0
	bne @2
.else
	bra @2
.endif
@3:	lda r0L
	adc DecTabL,x
	sta r0L
	tya
	bne @4
	cpx #0
	beq @4
	bbsf 6, r2L, @5
@4:	ora #%00110000
	ldx r3L
	sta Z45,x
	ldx currentMode
	jsr _GetRealSize
	tya
	add r3H
	sta r3H
	inc r3L
	lda #%10111111
	and r2L
	sta r2L
@5:	dec r2H
	bpl @1
	rts

.define DecTab 1, 10, 100, 1000, 10000
DecTabL:
	.lobytes DecTab
DecTabH:
	.hibytes DecTab

;---------------------------------------------------------------
; PutDecimal                                              $C184
;
; Pass:     a - format: Bit 7: 1 for left justify
;                              0 for right
;                       Bit 6: 1 supress leading 0's
;                              0 print leading 0's
;                       Bit 0-5: field width 4 right justify
;           r0          16 Bit nbr to print
;           r1H         y position (0-199)
;           r11         x position (0-319)
;Return:    r1H         y position for next char
;           r11         x position for next char
;Destroyed: a, x, y, r0, r2 - r10, r12, r13
;---------------------------------------------------------------
_PutDecimal:
	jsr CalcDecimal
.ifdef wheels_size_and_speed ; duplicate load
	lda r2L
	bmi @1
.else
	bbsf 7, r2L, @1
	lda r2L
.endif
	and #$3f
.ifndef bsw128
	sub r3H
.endif
	add r11L
	sta r11L
	bcc @X
	inc r11H
@X:
.ifdef bsw128
	ldx #r11
	jsr NormalizeX
	SubB r3H, r11L
	bcs @1
	dec r11H
.endif
@1:	ldx r3L
	stx r0L
@2:	lda Z45-1,x
	pha
	dex
	bne @2
@3:	pla
	jsr _PutChar
	dec r0L
	bne @3
	rts
