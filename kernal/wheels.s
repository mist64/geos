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

