; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C128 graphics mode switching

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import UseSystemFont
.import SetColorMode

.global _GraphicsString
.global SetNewMode0

.segment "mode"

.import SetVDCRegister
.global _SetNewMode
.global SetRightMargin
_SetNewMode:
	jsr SetRightMargin
SetNewMode0:
	lda grcntrl1
	bbrf 7, graphMode, @1
	and #%01101111
	sta grcntrl1
	lda vdcClrMode
	jmp SetColorMode
@1:	ora #%00010000
	and #%01111111
	sta grcntrl1
	ldx #26
	lda #0
	jsr SetVDCRegister
	dex
	lda #$80
	jmp SetVDCRegister

SetRightMargin:
	lda #0
	ldx #>(SC_PIX_WIDTH-1)
	ldy #<(SC_PIX_WIDTH-1)
	bbrf 7, graphMode, @1
	LoadB L8890, $ff
	lda #1
	ldx #>(SCREENPIXELWIDTH-1)
	ldy #<(SCREENPIXELWIDTH-1)
@1:	sta clkreg
	stx $38
	sty rightMargin
	jmp UseSystemFont
