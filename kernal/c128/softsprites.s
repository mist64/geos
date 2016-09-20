; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; VDC soft sprites (VIC-II emulation)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _GetScanLine
.import StaFrontbuffer80
.import ILin80_Help
.import LF522
.import BitMaskPow2

; XXX back bank, yet var lives on front bank!
scr_mobx = $887D

.global ShareTop
.global ShareTopBot
.global _BackBankFunc_23
.global _HideOnlyMouse
.global _SetMsePic
.global _TempHideMouse

.segment "softsprites"

; this is some kind of flag
LC817:	.byte 0

.define addr spr1pic, spr2pic, spr3pic, spr4pic, spr5pic, spr6pic, spr7pic
LC818:	.lobytes addr
LC81F:	.hibytes addr

.define SsprBackTab sspr1back, sspr2back, sspr3back, sspr4back, sspr5back, sspr6back, sspr7back
SsprBackTabL:	.lobytes SsprBackTab
SsprBackTabH:	.hibytes SsprBackTab

LC834:	.byte %00000000, %00000011, %00001100, %00001111
	.byte %00110000, %00110011, %00111100, %00111111
	.byte %11000000, %11000011, %11001100, %11001111
	.byte %11110000, %11110011, %11111100, %11111111

LC844:	.byte %00000000, %00001111, %01111111, %11101111
	.byte %01111111, %10011111, %01111111, %10011111
	.byte %01100111, %11100111, %00011001, %11111001
	.byte %11111110, %01111110, %11111111, %10000000

	.byte %00000000, %00000000, %01111111, %11100000
	.byte %01111111, %10000000, %01111111, %10000000
	.byte %01100111, %11100000, %00000001, %11111000
	.byte %00000000, %01111110, %00000000, %00000000

LC864:	lda LC817
	bne @3
	ldx #7
	ldy #14
@1:	stx r0L
	sty r0H
	lda BitMaskPow2,x
	and curEnble
	beq @2
	jsr LCB68
@2:	dey
	dey
	dex
	bne @1
	stx curEnble
@3:	jsr ShareTop
	rts

;---------------------------------------------------------------
; HideOnlyMouse                                           $C139
;
; Destroyed: a, x, y, rl-r6
;---------------------------------------------------------------
_HideOnlyMouse:
	bbrf 7, graphMode, @3
	ldx #0
@1:	lda r0,x
	pha
	inx
	cpx #r5H+1
	bne @1
	jsr LC8A5
	ldx #r5H
@2:	pla
	sta r0,x
	dex
	bpl @2
	jsr ShareTop
@3:	rts

LC8A5:	bbsf 7, L8890, @1
	LoadB L8890, $FF
	jsr LCCF8
@1:	jsr ShareTopBot
	ldx r0L
	ldy r0H
	rts

;!!!something? - mobenble and ~mobenble copies?
LC8BA:	.byte 0
LC8BB:	.byte 0

;---------------------------------------------------------------
; update software sprites status?
_BackBankFunc_23:
	jsr ShareTopBot
	lda LC817
	beq @2
	lda #0
	ldx #26
@1:	sta curEnble,x
	dex
	bpl @1
	sta LC817
@2:	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	jsr @14
	lda mobenble
	eor #$FF
	ora LC8BA
	and curEnble
	sta LC8BB
	beq @5
	jsr LC8A5
	ldy #14
	ldx #7
@3:	stx r0L
	sty r0H
	lda BitMaskPow2,x
	sta r9H
	and LC8BB
	beq @4
	jsr LCB68
	lda scr_mobx,y
	sta curXpos0,y
	lda scr_mobx+1,y
	sta curXpos0+1,y
	lda mob0ypos,y
	sta curYpos0,x
@4:	dey
	dey
	dex
	bne @3
@5:	MoveB moby2, curmoby2
	MoveB mobx2, curmobx2
	MoveB mobenble, curEnble
	jsr LCA6B
	PopB dispBufferOn
	jsr ShareTop
	bbsf 0, mobenble, @6
	rts
@6:	bit L8890
	bmi @8
	sei
	lda mouseXPos
	ldx mouseXPos+1
	ldy mouseYPos
	cli
	cmp L8891
	bne @7
	cpx L8892
	bne @7
	cpy L8893
	bne @7
	rts
@7:	jsr LCCF8
@8:	LoadB L8890, 0
	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	sei
	MoveB mouseYPos, L8893
	sta r2L
	MoveB mouseXPos+1, L8892
	sta r1H
	lda mouseXPos
	cli
	sta L8891
	sta r1L
	jsr ShareTopBot
	lda r1L
	and #$07
	asl a
	asl a
	asl a
	sta r3H
	asl a
	adc r3H
	sta r3H
	lsr r1H
	ror r1L
	lsr r1H
	ror r1L
	lsr r1H
	ror r1L
	LoadB r2H, 8
	LoadB r3L, 0
@9:	ldx r2L
	cpx #SC_PIX_HEIGHT
	beq @13
	jsr LCCD1
	jsr LF522
	bra @11
@10:	jsr ILin80_Help
@11:	ldy r3L
	sta mouseSave,y
	inc r3L
	ldy r3H
	and softZeros,y
	ora softOnes,y
	jsr StaFrontbuffer80
	inc r3H
	inc r5L
	bne @12
	inc r5H
@12:	dec r4L
	bne @10
	clc
	lda r4H
	adc r3H
	sta r3H
	inc r2L
	dec r2H
	bne @9
@13:	PopB dispBufferOn
	jmp ShareTop

; check if all sprites are untouched?
@14:	ldx #0
	stx doRestFlag
	stx LC8BA
	ldy #14
	ldx #7
@15:	stx r0L
	sty r0H
	lda BitMaskPow2,x
	sta r9H
	and mobenble
	beq @16
	jsr @17
	bcc @16
	lda r9H
	ora LC8BA
	sta LC8BA
@16:	dey
	dey
	dex
	bne @15
	rts

; compare real status to own copy (last drawn?)
@17:	lda doRestFlag
	bne @20
	lda scr_mobx+1,y
	bpl @18
	lda #0
	sta scr_mobx,y
	sta scr_mobx+1,y
@18:	lda scr_mobx,y
	cmp curXpos0,y
	bne @19
	lda scr_mobx+1,y
	cmp curXpos0+1,y
	bne @19
	lda mob0ypos,y
	cmp curYpos0,x
	bne @19
	CmpB mobx2, curmobx2
	bne @19
	CmpB moby2, curmoby2
	bne @19
	lda r9H
	and curEnble
	beq @19
	clc
	rts
@19:	inc doRestFlag
@20:	sec
	rts

VDCNextLine:
	lda #SCREENPIXELWIDTH/8
	add r5L
	sta r5L
	lda r5H
	adc #0
	sta r5H
	rts

LCA6B:	lda LC8BA
	beq @3
	LoadB r0L, 1
	asl a
	sta r0H
	lsr LC8BA
@1:	lsr LC8BA
	bcc @2
	ldy r0H
	ldx r0L
	lda BitMaskPow2,x
	sta r9H
	jsr LCA98
@2:	inc r0H
	inc r0H
	inc r0L
	CmpB r0L, #8
	bne @1
@3:	rts

LCA98:	jsr LCAB3
@1:	jsr LCBB9
	jsr LCC45
	jsr VDCNextLine
	lda r10H
	beq @2
	jsr LCC45
	jsr VDCNextLine
@2:	dec r11L
	bne @1
	rts

;this one does something with flags setup
LCAB3:	lda LC818-1,x
	sta r4L
	lda LC81F-1,x
	sta r4H
	lda SsprBackTabL-1,x
	sta r12L
	lda SsprBackTabH-1,x
	sta r12H
	lda mob0ypos,y
	sub #50
	tax
	stx r9L
	jsr _GetScanLine
	ldx r0L
	ldy #63
	lda (r4),y
	sta r11H
	and #$7F
	sta r11L
	sta backYBufNum,x
	ldy r0H
	lda moby2
	and r9H
	sta r10H
	beq @1
	lda r11L
	asl a
	sta backYBufNum,x
@1:	lda #4
	sta backXBufNum,x
	lda r11H
	and #$80
	beq @2
	lda #2
	sta backXBufNum,x
@2:	lda mobx2
	and r9H
	sta r10L
	beq @3
	lda backXBufNum,x
	asl a
	sta backXBufNum,x
	cmp #4
	beq @3
	dec backXBufNum,x
@3:	lda scr_mobx,y
	sta r8L
	and #$07
	sta r8H
	lda scr_mobx+1,y
	ror a
	ror r8L
	ror a
	ror r8L
	lsr r8L
	lda r8L
	add r5L
	sta r5L
	sta backBufPtr,y
	lda r5H
	adc #0
	sta r5H
	sta backBufPtr+1,y
	lda #SCREENPIXELWIDTH/8
	sub r8L
	bcs @4
	lda #0
@4:	cmp backXBufNum,x
	bcs @5
	sta backXBufNum,x
@5:	lda #SC_PIX_HEIGHT
	sub r9L
	cmp backYBufNum,x
	bcs @6
	sta backYBufNum,x
	sta r11L
	lda r10H
	beq @6
	lsr r11L
@6:	rts

; this one seems to draw a sprite on screen
LCB68:	lda SsprBackTabL-1,x
	sta r3L
	lda SsprBackTabH-1,x
	sta r3H
	lda backBufPtr,y
	sta r5L
	lda backBufPtr+1,y
	sta r5H
	lda backXBufNum,x
	sta r1L
	lda backYBufNum,x
	sta r1H
@1:	ldx r1L
	ldy #0
	lda (r3),y
	jsr StaFrontbuffer80
	iny
	dex
	beq @3
@2:	bit vdcreg
	bpl @2
	lda (r3),y
	sta vdcdata
	iny
	dex
	bne @2
@3:	tya
	add r3L
	sta r3L
	lda r3H
	adc #0
	sta r3H
	jsr VDCNextLine
	dec r1H
	bne @1
	ldx r0L
	ldy r0H
	rts

LCBB9:	ldy #0
	sty shiftBuf+3
	sty shiftBuf+6
@1:	lda (r4),y
	sta shiftBuf,y
	iny
	cpy #3
	bne @1
	tya
	add r4L
	sta r4L
	lda r4H
	adc #0
	sta r4H
	lda r10L
	beq @2
	jsr LCC13
@2:	lda r8H
	beq @5
	tax
	bbrf 7, r11H, @4
	lda r10L
	bne @4
@3:	lsr shiftBuf
	ror shiftBuf+1
	dex
	bne @3
	beq @5
@4:	lsr shiftBuf
	ror shiftBuf+1
	ror shiftBuf+2
	ror shiftBuf+3
	ror shiftBuf+4
	ror shiftBuf+5
	ror shiftBuf+6
	dex
	bne @4
@5:	ldx r0L
	ldy r0H
	rts

LCC13:	bbsf 7, r11H, @1
	ldx #4
	lda shiftBuf+2
	jsr @2
@1:	ldx #2
	lda shiftBuf+1
	jsr @2
	ldx #0
	lda shiftBuf
@2:	sta r2L
	and #$0F
	tay
	lda LC834,y
	sta shiftBuf+1,x
	lda r2L
	lsr a
	lsr a
	lsr a
	lsr a
	tay
	lda LC834,y
	sta shiftBuf,x
	rts

LCC45:	lda backXBufNum,x
	beq LCCA1
	tax
	ldy #0
	jsr LF522
	sta (r12),y
	ora shiftBuf,y
	sta shiftOutBuf,y
	iny
	dex
	beq @2
@1:	lda vdcreg
	bpl @1
	lda vdcdata
	sta (r12),y
	ora shiftBuf,y
	sta shiftOutBuf,y
	iny
	dex
	bne @1
@2:	ldx r0L
	lda backXBufNum,x
	add r12L
	sta r12L
	bcc @3
	inc r12H
@3:	lda backXBufNum,x
	tax
	ldy #0
	lda shiftOutBuf,y
	jsr StaFrontbuffer80
	iny
	dex
	beq @5
@4:	bit vdcreg
	bpl @4
	lda shiftOutBuf,y
	sta vdcdata
	iny
	dex
	bne @4
@5:	ldx r0L
	ldy r0H
LCCA1:	rts

;---------------------------------------------------------------
; TempHideMouse                                           $C2D7
;
; Destroyed: a, x
;---------------------------------------------------------------
_TempHideMouse:
	bbrf 7, graphMode, @4
	jsr ShareTopBot
	bit L8890
	php
	jsr ShareTop
	plp
	bpl @1
	lda curEnble
	beq @4
@1:	ldx #0
@2:	lda r0,x
	pha
	inx
	cpx #14
	bne @2
	jsr LC8A5
	jsr LC864
	ldx #13
@3:	pla
	sta r0,x
	dex
	bpl @3
@4:	rts


LCCD1:	jsr _GetScanLine
	lda r1L
	add r5L
	sta r5L
	bcc @1
	inc r5H
@1:	LoadB r4H, 0
	lda #SCREENPIXELWIDTH/8
	sub r1L
	cmp #3
	bcc @2
	lda #3
	sta r4L
	rts
@2:	sta r4L
	eor #3
	sta r4H
	rts

LCCF8:	PushB dispBufferOn
	LoadB dispBufferOn, ST_WR_FORE
	MoveB L8893, r2L
	MoveB L8891, r1L
	lda L8892
	lsr a
	ror r1L
	lsr a
	ror r1L
	lsr a
	ror r1L
	sta r1H
	jsr ShareTopBot
	LoadB r2H, 8
	LoadB r3L, 0
@1:	ldx r2L
	cpx #SC_PIX_HEIGHT
	beq @4
	jsr LCCD1
@2:	ldy r3L
	lda mouseSave,y
	jsr StaFrontbuffer80
	inc r3L
	inc r5L
	bne @3
	inc r5H
@3:	dec r4L
	bne @2
	inc r2L
	dec r2H
	bne @1
@4:	PopB dispBufferOn
ShareTop:
	lda #$08
	.byte $2c
ShareTopBot:
	lda #$0C
	sta @1+1
	lda rcr
	and #$F3
@1:	ora #8
	sta rcr
	rts

;---------------------------------------------------------------
; SetMsePic                                               $C2DA
;
; Pass:      r0   MSEPIC
; Destroyed: a, x, y, r0-r15
;---------------------------------------------------------------
_SetMsePic:
	lda r0H
	bne @2
	lda r0L
	cmp #1
	bcs @2
	ldx #4
@1:	asl r0L
	rol r0H
	dex
	bpl @1
	lda r0L
	add #<LC844
	sta r0L
	lda r0H
	adc #>LC844
	sta r0H
@2:	LoadW r1, softZeros
	ldx #0
@3:	LoadB r4L, 8
@4:	ldy #0
	lda (r0),y
	sta r2H
	iny
	lda (r0),y
	sta r3L
	ldy #0
	cpx #8
	bcs @5
	dey
@5:	sty r3H
	sty r2L
	clc
	lda #2
	adc r0L
	sta r0L
	bcc @6
	inc r0H
@6:	txa
	and #$07
	tay
	beq @8
@7:	lsr r2L
	ror r2H
	ror r3L
	ror r3H
	dey
	bne @7
@8:	jsr ShareTopBot
	ldy #2
@9:	lda r2H,y
	sta (r1),y
	dey
	bpl @9
	jsr ShareTop
	clc
	lda #3
	adc r1L
	sta r1L
	bcc @10
	inc r1H
@10:	dec r4L
	bne @4
	inx
	cpx #8
	beq @11
	sec
	lda r0L
	sbc #$10
	sta r0L
	lda r0H
	sbc #0
	sta r0H
@11:	cpx #$10
	bne @3
	rts

