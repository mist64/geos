; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; VDC access helpers and syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import GetVDCRegister
.import SetVDCRegister

.global _SetColorMode
.global _ColorCard
.global LF3B1
.global _ColorRectangle
.global LF4CA
.global ILin80_Help
.global LF510
.global LF522
.global StaFrontbuffer80
.global VDCFillr4LA
.global VDCGetFromBGFG
.global LF497
.global LF5AE
.global LF5BF
.global StaBackbuffer80
.global LF56A
.global LF4B7
.global LF558
.global LF4A7

.segment "vdc1"

_SetColorMode:
	cmp #5
	bcc @1
	rts
@1:	sta vdcClrMode
	bbsf 7, graphMode, @2
	rts
@2:	tay
	lda SetColorModeTabL,y
	sta r0L
	lda SetColorModeTabH,y
	sta r0H
	ldy #0
@3:	lda (r0),y
	iny
	cmp #$FF
	beq @6
	tax
	cpx #$19
	bne @4
	lda vdcreg
	and #$07
	beq @4
	lda (r0),y
	ora #$07
	sta (r0),y
@4:	jsr GetVDCRegister
	cmp (r0),y
	beq @5
	lda (r0),y
	jsr SetVDCRegister
@5:	iny
	bra @3
@6:	ldx #28
	jsr GetVDCRegister
	and #%11101111
	tay
	CmpBI vdcClrMode, 2
	bcc @7
	tya
	ora #$10
	tay
@7:	tya
	jsr SetVDCRegister
	ldx #26
	lda scr80colors
	jsr SetVDCRegister
	ldx #24
	lda scr80polar
	jmp SetVDCRegister

.define addr ColorModeTab0, ColorModeTab1, ColorModeTab2, ColorModeTab3, ColorModeTab4
SetColorModeTabH:
	.hibytes addr
SetColorModeTabL:
	.lobytes addr

ColorModeTab0:
	.byte $04,$20,  $06,$19,  $07,$1c,  $09,$e7
	.byte $14,$38,  $15,$80,  $19,$87,  $24,$f5
	.byte $ff
ColorModeTab1:
	.byte $04,$20,  $06,$16,  $07,$1c,  $09,$e7
	.byte $14,$38,  $15,$80,  $19,$c0,  $24,$f5
	.byte $ff
ColorModeTab2:
	.byte $04,$20,  $06,$19,  $07,$1c,  $09,$e7
	.byte $14,$40,  $15,$00,  $19,$c0,  $24,$f5
	.byte $ff
ColorModeTab3:
	.byte $04,$40,  $06,$32,  $07,$38,  $09,$e3
	.byte $14,$40,  $15,$00,  $19,$c0,  $24,$f4
	.byte $ff
ColorModeTab4:
	.byte $04,$80,  $06,$64,  $07,$70,  $09,$e1
	.byte $14,$40,  $15,$00,  $19,$c0,  $24,$f2
	.byte $ff

_ColorCard:
	php
	pha
	PushW r3
	ldy r11L
	jsr GetColorAddr
	PopB r3L
	PopB r3H
	ldy #0
	pla
	plp
	bcc @2
	bbsf 7, graphMode, @1
	sta (r5),y
	rts
@1:	jmp StaFBuff_0
@2:	bbsf 7, graphMode, @3
	lda (r5),y
	rts
@3:	jmp LF52D

ColorModeTabl1:
	.byte $F8, $F8, $F8, $FC, $FE

GetColorAddr:
	tya
	ldy vdcClrMode
	and ColorModeTabl1,y
	pha
	sta r5L
	lda #$00
	asl r5L
	rol a
	asl r5L
	rol a
	sta r5H
	pla
	add r5L
	sta r5L
	bcc @1
	inc r5H
@1:	bbsf 7, graphMode, @2
	AddVW COLOR_MATRIX, r5
	bra @6
@2:	asl r5L
	rol r5H
	ldy vdcClrMode
	cpy #2
	bcc @5
	dey
@3:	dey
	beq @4
	asl r5L
	rol r5H
	bra @3
@4:	AddVB $40, r5H ;!!! >COLOR_MATRIX_80_2
	bne @6
@5:	AddVW $3880, r5 ;!!! COLOR_MATRIX_80_1
@6:	lsr r3H
	ror r3L
	lsr r3H
	ror r3L
	lsr r3L
	lda r3L
	add r5L
	sta r5L
	bcc @7
	inc r5H
@7:	rts


ColorModeTabl2:
	.byte 8, 8, 8, 4, 2

_ColorRectangle:
	tax
	PushW r3
@1:	MoveB r2L, r11L
	CmpW r3, r4
	beq @3
	bcs @7
@3:	CmpB r11L, r2H
	beq @4
	bcs @5
@4:	txa
	pha
	sec
	jsr _ColorCard
	pla
	tax
	ldy vdcClrMode
	lda ColorModeTabl2,y
	add r11L
	sta r11L
	bne @3
@5:	AddVW 8, r3
	bra @1
@7:	PopB r3L
	PopB r3H
	rts


VDCFillr4LA:
	bbrf 7, dispBufferOn, @2
	jsr StaFBuff_0
	lda r4L
	subv $01
	beq @2
	ldx #30
	stx vdcreg
@1:	bit vdcreg
	bpl @1
	sta vdcdata
@2:	rts


VDCGetFromBGFG:
	bbrf 6, dispBufferOn, @1
	lda (r6),y
	rts
@1:	bit vdcreg
	bpl @1
	lda vdcdata
	rts


; load data (80 col. or backbuffer)
; called from seems-to-be-never-called-function
LF497:	bbrf 6, dispBufferOn, @1
	ldy #0
	lda (r6),y
	rts
@1:	stx LF4EB+1
	ldx #$AD ; LDA absolute
	bne LF4C5

; data || visual (80 col. or backbuffer)
LF4A7:	bbrf 6, dispBufferOn, @1
	ldy #0
	ora (r6),y
	rts
@1:	stx LF4EB+1
	ldx #$0D ; ORA absolute
	bne LF4C5

; data && visual (80 col. or backbuffer)
LF4B7:	bbrf 6, dispBufferOn, @1
	ldy #0
	and (r6),y
	rts
@1:	stx LF4EB+1
	ldx #$2D ; AND absolute
LF4C5:	stx LF4F2
	ldx #$12
LF4CA:	stx vdcreg
	ldx r6H
@1:	bit vdcreg
	bpl @1
	stx vdcdata
	ldx #$13
	stx vdcreg
	ldx r6L
@2:	bit vdcreg
	bpl @2
	stx vdcdata
	ldx #$1F
	stx vdcreg
LF4EB:	ldx #0
@1:	bit vdcreg
	bpl @1
LF4F2:	lda vdcdata
	rts

.segment "vdc2"

ILin80_Help:
	bit dispBufferOn
LF510:	bmi @1
	bvc @1
	ldy #0
	lda (r5),y
	rts
@1:	bit vdcreg
	bpl @1
	lda vdcdata
	rts


;called from invertline
LF522:	bbsf 7, dispBufferOn, LF52D
	bvc LF52D
	ldy #0
	lda (r5),y
	rts
LF52D:	stx LF5A4
	ldx #$AD
	bne LF57D

;f534 - this is never refereneced
unused_1:
	bbsf 7, dispBufferOn, @1
	bvc @1
	ldy #0
	ora (r5),y
	rts
@1:	stx LF5A4
	ldx #$0D
	bne LF57D

;f53f - this is never referenced
unused_2:
	bbsf 7, dispBufferOn, @1
	bvc @1
	ldy #0
	eor (r5),y
	rts
@1:	stx LF5A4
	ldx #$4D
	bne LF57D

;called from Read/Write80Help
LF558:	bbsf 7, dispBufferOn, @1
	bvc @1
	ldy #0
	and (r5),y
	rts
@1:	stx LF5A4
	ldx #$2D
	bne LF57D

;called from seems-to-be-never-called function
LF56A:	bbrf 6, dispBufferOn, @1
	sta (r6),y
@1:	bmi StaFBuff_0
	rts


;this is called as one of the last functions in draw
StaFrontbuffer80:
	bbsf 7, dispBufferOn, StaFBuff_0
	rts
StaFBuff_0:
	stx LF5A4
	ldx #$8D
LF57D:	stx LF5AA
	ldx #$12
	stx vdcreg
	ldx r5H
@1:	bit vdcreg
	bpl @1
	stx vdcdata
	ldx #$13
	stx vdcreg
	ldx r5L
@2:	bit vdcreg
	bpl @2
	stx vdcdata
	ldx #$1F
	stx vdcreg
LF5A4 = * + 1
	ldx #$1E
@1:	bit vdcreg
	bpl @1
LF5AA:	sta vdcdata
	rts

;another one called only from that one that seems-to-be-never-called
;this one stores to 80col.||backbuffer if needed
LF5AE:	bbrf 6, dispBufferOn, @1
	sta (r6),y
@1:	bpl @3
@2:	bit vdcreg
	bpl @2
	sta vdcdata
@3:	rts

;called from ILine80, stores only to 80col. if needed
LF5BF:	bbrf 7, dispBufferOn, @2
@1:	bit vdcreg
	bpl @1
	sta vdcdata
@2:	rts

;called many times, stores only to backbuffer if needed
StaBackbuffer80:
	bbrf 6, dispBufferOn, @1
	ldy #0
	sta (r6),y
@1:	rts
