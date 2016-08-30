; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; Wheels additions

.include "config.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "wheels1"

.if wheels
.global _GEOSOptimize, _DEFOptimize, _DoOptimize
_GEOSOptimize:
	ldy #0 ; enable GEOS optimization
	.byte $2c
_DEFOptimize:
	ldy #3 ; disable all optimizations
_DoOptimize:
	php
	sei
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, $35
	sta scpu_hwreg_enable
	sta scpu_base,y
	sta scpu_hwreg_disable
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	plp
	rts
.endif

.segment "wheels2"

.if wheels
.global _ReadXYPot
L9FEE = $9FEE
_ReadXYPot:
	php
	sei
	lsr
	ror
	ror
	sta cia1base+0
	PushB cia1base+2 ; DDR A
	LoadB cia1base+2, $C0
	lda cia1base+14
	and #$FE
	sta cia1base+14 ; stop timer A
	MoveW L9FEE, cia1base+4 ; timer A value
	lda #$7F
	sta cia1base+13 ; disabe all interrupts
	lda cia1base+13 ; clear pending interrupts
	lda cia1base+14
	and #$40
	ora #$19
	sta cia1base+14 ; load timer A, one shot, start
	lda #$01
@1:	bit cia1base+13 ; wait for timer A underflow
	beq @1
	ldx sidbase+$19 ; mouse
	ldy sidbase+$1A
	PopB cia1base+2 ; DDR A
	plp
	rts

.global _ConvToCards
; Convert a rectangle in pixel space into a origin/size
; rectangle in card space, i.e. convert it into a
; color matrix rectangle for
; * ColorRectangle_W
; * SaveColorRectangle
; * RestoreColorRectangle
;
; in:  r2L: y1
;      r2H: y2
;      r3:  x1
;      r4:  x2
; out: r1L: x1
;      r1H: y1
;      r2L: width
;      r2H: height
_ConvToCards:
	lda r2L
	lsr
	lsr
	lsr
	sta r1H
	sec
	lda r2H
	sbc r2L
	lsr
	lsr
	lsr
	sta r2H
	inc r2H
	lda r3H
	lsr
	lda r3L
	ror
	lsr
	lsr
	sta r1L
	sec
	lda r4L
	sbc r3L
	pha
	lda r4H
	sbc r3H
	lsr
	pla
	ror
	lsr
	lsr
	sta r2L
	inc r2L
	rts

; ----------------------------------------------------------------------------
        brk                                     ; C0FE 00                       .
        brk                                     ; C0FF 00                       .
.endif

.segment "wheels3"

.if wheels
.include "jumptab.inc"
LEC75 = $ec75
LFD2F = $fd2f
LC5E7 = $c5e7

.global DrawCheckeredScreen
DrawCheckeredScreen:
	lda #2
	jsr SetPattern
	jsr i_Rectangle
LC4A1:	.byte 0, 199
	.word 0, 319
	rts

; ----------------------------------------------------------------------------
.global _ColorRectangle_W
.global GetColorMatrixOffset
.global NextScreenLine
_ColorRectangle_W:
; r1L   x
; r1H   y
; r2L   width
; r2H   height
; r4H   value
	php
	sei
	jsr GetColorMatrixOffset
	ldx r2H
@1:	ldy #0
	lda r4H
@2:	sta (r5),y
	iny
	cpy r2L
	bcc @2
	jsr NextScreenLine
	dex
	bne @1
	plp
	rts

GetColorMatrixOffset:
; in:  r1L: x
;      r1H: y
; out: r5:  color matrix offset
	clc
	lda r1L
	adc #<COLOR_MATRIX
	sta r5L
	lda #>COLOR_MATRIX
	adc #0
	sta r5H
	ldx r1H
	beq @5
@4:	jsr NextScreenLine
	dex
	bne @4
@5:	rts

NextScreenLine:
	AddVW 40, r5
	rts

; ----------------------------------------------------------------------------
.global _i_ColorRectangle
; inline version of ColorRectangle_W
_i_ColorRectangle:
	PopW returnAddress
	ldy #5
	lda (returnAddress),y
	sta r4H
	dey
	ldx #3
@1:	lda (returnAddress),y
	sta r1L,x
	dey
	dex
	bpl @1
	jsr _ColorRectangle_W
	php
	lda #6
	jmp DoInlineReturn
.endif
