; graphical functions (lines, rectangles, points, bitmaps)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.import PatternTab, _PutString, BitMask1, BitMask3, BitMask4
.global _BitOtherClip, _BitmapClip, _BitmapUp, _DrawPoint, _FrameRectangle, _GetScanLine, _GraphicsString, _HorizontalLine, _ImprintRectangle, _InvertLine, _InvertRectangle, _RecoverLine, _RecoverRectangle, _Rectangle, _SetPattern, _TestPoint, _VerticalLine, _i_BitmapUp, _i_FrameRectangle, _i_GraphicsString, _i_ImprintRectangle, _i_RecoverRectangle, _i_Rectangle, ClrScr, _DrawLine

.segment "graph1"

ClrScr:
	LoadW r0, SCREEN_BASE
	LoadW r1, BACK_SCR_BASE
	ldx #$7D
ClrScr1:
	ldy #$3F
ClrScr2:
	lda #backPattern1
	sta (r0),Y
	sta (r1),Y
	dey
	lda #backPattern2
	sta (r0),Y
	sta (r1),Y
	dey
	bpl ClrScr2
	AddVW 64, r0
	AddVW 64, r1
	dex
	bne ClrScr1
	rts

.segment "graph2"

PrepareXCoord:
	ldx r11L
	jsr _GetScanLine
	lda r4L
	and #%00000111
	tax
	lda BitMask4,X
	sta r8H
	lda r3L
	and #%00000111
	tax
	lda BitMask3,X
	sta r8L
	lda r3L
	and #%11111000
	sta r3L
	lda r4L
	and #%11111000
	sta r4L
	rts

_HorizontalLine:
	sta r7L
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq HLin0
	inc r5H
	inc r6H
HLin0:
	CmpW r3, r4
HLin1:
	beq HLin4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr HLineHelp
HLin2:
	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc HLin3
	inc r5H
	inc r6H
HLin3:
	dec r4L
	beq HLin5
	lda r7L
	bra HLin2
HLin4:
	lda r8L
	ora r8H
	bra HLin6
HLin5:
	lda r8H
HLin6:
	jsr HLineHelp
HLin7:
	sta (r6),Y
	sta (r5),Y
HLin8:
	PopW r4
	PopW r3
	rts

HLineHelp:
	sta r11H
	and (r6),Y
	sta r7H
	lda r11H
	eor #$FF
	and r7L
	ora r7H
	rts
_InvertLine:
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq ILin0
	inc r5H
	inc r6H
ILin0:
	CmpW r3, r4
ILin1:
	beq ILin4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	eor (r5),Y
ILin2:
	eor #$FF
	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc ILin3
	inc r5H
	inc r6H
ILin3:
	dec r4L
	beq ILin5
	lda (r5),Y
	bra ILin2
ILin4:
	lda r8L
	ora r8H
	bra ILin6
ILin5:
	lda r8H
ILin6:
	eor #$FF
	eor (r5),Y
	jmp HLin7

ImprintLine:
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
	PopB dispBufferOn
	lda r5L
	ldy r6L
	sta r6L
	sty r5L
	lda r5H
	ldy r6H
	sta r6H
	sty r5H
	bra RLin0

_RecoverLine:
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
	PopB dispBufferOn

RLin0:
	ldy r3L
	lda r3H
	beq RLin1
	inc r5H
	inc r6H
RLin1:
	CmpW r3, r4
RLin2:
	beq RLin5
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr RecLineHelp
RLin3:
	tya
	addv 8
	tay
	bcc RLin4
	inc r5H
	inc r6H
RLin4:
	dec r4L
	beq RLin6
	lda (r6),Y
	sta (r5),Y
	bra RLin3
RLin5:
	lda r8L
	ora r8H
	bra RLin7
RLin6:
	lda r8H
RLin7:
	jsr RecLineHelp
	jmp HLin8

RecLineHelp:
	sta r7L
	and (r5),Y
	sta r7H
	lda r7L
	eor #$FF
	and (r6),Y
	ora r7H
	sta (r5),Y
	rts

_VerticalLine:
	sta r8L
	PushB r4L
	and #%00000111
	tax
	lda BitMask1,X
	sta r7H
	lda r4L
	and #%11111000
	sta r4L
	ldy #0
	ldx r3L
VLin0:
	stx r7L
	jsr _GetScanLine
	AddW r4, r5
	AddW r4, r6
	lda r7L
	and #%00000111
	tax
	lda BitMask1,X
	and r8L
	bne VLin1
	lda r7H
	eor #$FF
	and (r6),Y
	bra VLin2
VLin1:
	lda r7H
	ora (r6),Y
VLin2:
	sta (r6),Y
	sta (r5),Y
	ldx r7L
	inx
	cpx r3H
	beq VLin0
	bcc VLin0
	PopB r4L
	rts

_i_Rectangle:
	jsr GetInlineDrwParms
	jsr _Rectangle
	php
	lda #7
	jmp DoInlineReturn

_Rectangle:
	MoveB r2L, r11L
Rect1:
	lda r11L
	and #$07
	tay
	lda (curPattern),Y
	jsr _HorizontalLine
	lda r11L
	inc r11L
	cmp r2H
	bne Rect1
	rts

_InvertRectangle:
	MoveB r2L, r11L
IRect1:
	jsr _InvertLine
	lda r11L
	inc r11L
	cmp r2H
	bne IRect1
	rts

_i_RecoverRectangle:
	jsr GetInlineDrwParms
	jsr _RecoverRectangle
	php
	lda #7
	jmp DoInlineReturn

_RecoverRectangle:
	MoveB r2L, r11L
RRect1:
	jsr _RecoverLine
	lda r11L
	inc r11L
	cmp r2H
	bne RRect1
	rts

_i_ImprintRectangle:
	jsr GetInlineDrwParms
	jsr _ImprintRectangle
	php
	lda #7
	jmp DoInlineReturn

_ImprintRectangle:
	MoveB r2L, r11L
ImRec1:
	jsr ImprintLine
	lda r11L
	inc r11L
	cmp r2H
	bne ImRec1
	rts

_i_FrameRectangle:
	jsr GetInlineDrwParms
	iny
	lda (returnAddress),Y
	jsr _FrameRectangle
	php
	lda #8
	jmp DoInlineReturn

_FrameRectangle:
	sta r9H
	ldy r2L
	sty r11L
	jsr _HorizontalLine
	MoveB r2H, r11L
	lda r9H
	jsr _HorizontalLine
	PushW r3
	PushW r4
	MoveW r3, r4
	MoveW r2, r3
	lda r9H
	jsr _VerticalLine
	PopW r4
	lda r9H
	jsr _VerticalLine
	PopW r3
	rts

GetInlineDrwParms:
	PopW r5
	PopW returnAddress
	ldy #1
	lda (returnAddress),Y
	sta r2L
	iny
	lda (returnAddress),Y
	sta r2H
	iny
	lda (returnAddress),Y
	sta r3L
	iny
	lda (returnAddress),Y
	sta r3H
	iny
	lda (returnAddress),Y
	sta r4L
	iny
	lda (returnAddress),Y
	sta r4H
	PushW r5
GtDrwPrmsEnd:
	rts

_i_GraphicsString:
	PopB r0L
	pla
	inc r0L
	bne i_GStr0
	addv 1
i_GStr0:
	sta r0H
	jsr _GraphicsString
	jmp (r0)

_GraphicsString:
	jsr Getr0AndInc
	beq _GraphicsStringEnd
	tay
	dey
	lda GStrTL,Y
	ldx GStrTH,Y
	jsr CallRoutine
	bra _GraphicsString
_GraphicsStringEnd:
	rts

GStrTL:
	.byte <_DoMovePenTo, <_DoLineTo
	.byte <_DoRectangleTo, <_DoNothing
	.byte <_DoNewPattern, <_DoESC_PutString
	.byte <_DoFrame_RecTo, <_DoPenXDelta
	.byte <_DoPenYDelta, <_DoPenXYDelta

GStrTH:
	.byte >_DoMovePenTo, >_DoLineTo
	.byte >_DoRectangleTo, >_DoNothing
	.byte >_DoNewPattern, >_DoESC_PutString
	.byte >_DoFrame_RecTo, >_DoPenXDelta
	.byte >_DoPenYDelta, >_DoPenXYDelta

_DoMovePenTo:
	jsr GetCoords
	sta GraphPenY
	stx GraphPenXL
	sty GraphPenXH
	rts

_DoLineTo:
	MoveW GraphPenX, r3
	MoveB GraphPenY, r11L
	jsr _DoMovePenTo
	sta r11H
	stx r4L
	sty r4H
	sec
	lda #0
	jmp _DrawLine

_DoRectangleTo:
	jsr GrStSetCoords
	jmp _Rectangle

_DoNothing:
	rts

_DoNewPattern:
	jsr Getr0AndInc
	jmp _SetPattern

_DoESC_PutString:
	jsr Getr0AndInc
	sta r11L
	jsr Getr0AndInc
	sta r11H
	jsr Getr0AndInc
	sta r1H
	jsr _PutString
	rts

_DoFrame_RecTo:
	jsr GrStSetCoords
	lda #$FF
	jmp _FrameRectangle

_DoPenXYDelta:
	ldx #1
	bne DPXD0
_DoPenXDelta:
	ldx #0
DPXD0:
	ldy #0
	lda (r0),Y
	iny
	add GraphPenXL
	sta GraphPenXL
	lda (r0),Y
	iny
	adc GraphPenXH
	sta GraphPenXH
	beqx DPYD1
	bne DPYD0
_DoPenYDelta:
	ldy #0
DPYD0:
	lda (r0),Y
	iny
	add GraphPenY
	sta GraphPenY
	iny
DPYD1:
	tya
	add r0L
	sta r0L
	bcc DPYD2
	inc r0H
DPYD2:
	rts

GrStSetCoords:
	jsr GetCoords
	cmp GraphPenY
	bcs GSSC0
	sta r2L
	pha
	lda GraphPenY
	sta r2H
	bra GSSC1
GSSC0:
	sta r2H
	pha
	lda GraphPenY
	sta r2L
GSSC1:
	PopB GraphPenY
	cpy GraphPenXH
	beq GSSC2
	bcs GSSC4
GSSC2:
	bcc GSSC3
	cpx GraphPenXL
	bcs GSSC4
GSSC3:
	stx r3L
	sty r3H
	MoveW GraphPenX, r4
	bra GSSC5
GSSC4:
	stx r4L
	sty r4H
	MoveW GraphPenX, r3
GSSC5:
	stx GraphPenXL
	sty GraphPenXH
	rts
_SetPattern:
	asl
	asl
	asl
	adc #<PatternTab
	sta curPattern
	lda #0
	adc #>PatternTab
	sta curPattern+1
	rts

GetCoords:
	jsr Getr0AndInc
	tax
	jsr Getr0AndInc
	sta r2L
	jsr Getr0AndInc
	ldy r2L
	rts ;x/y - x, a - y

Getr0AndInc:
	ldy #0
	lda (r0),Y
	inc r0L
	bne Gr0AI0
	inc r0H
Gr0AI0:
	cmp #0
	rts

_GetScanLine:
	txa
	pha
	pha
	and #%00000111
	sta r6H
	pla
	lsr
	lsr
	lsr
	tax
	bbrf 7, dispBufferOn, GSC2
	bit dispBufferOn
	bvs GSC1
	lda LineTabL,X
	ora r6H
	sta r5L
	lda LineTabH,X
	sta r5H
	MoveW r5, r6
	pla
	tax
	rts

GSC1:
	lda LineTabL,X
	ora r6H
	sta r5L
	sta r6L
	lda LineTabH,X
	sta r5H
	subv 64
	sta r6H
	pla
	tax
	rts

GSC2:
	bbrf 6, dispBufferOn, GSC3
	lda LineTabL,X
	ora r6H
	sta r6L
	lda LineTabH,X
	subv 64
	sta r6H
	MoveW r6, r5
	pla
	tax
	rts

GSC3:
	LoadB r5L, 0
	sta r6L
	LoadB r5H, $AF
	sta r6H
	pla
	tax
	rts

LineTabL:
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00
LineTabH:
	.byte $a0, $a1, $a2, $a3, $a5, $a6, $a7, $a8
	.byte $aa, $ab, $ac, $ad, $af, $b0, $b1, $b2
	.byte $b4, $b5, $b6, $b7, $b9, $ba, $bb, $bc
	.byte $be

.segment "graph3"

_BitOtherClip:
	ldx #$ff
	jmp BitmClp1
_BitmapClip:
	ldx #0
BitmClp1:
	stx r9H
	lda #0
	sta r3L
	sta r4L
BitmClp2:
	lda r12L
	ora r12H
	beq BitmClp4
	lda r11L
	jsr BitmHelpClp
	lda r2L
	jsr BitmHelpClp
	lda r11H
	jsr BitmHelpClp
	lda r12L
	bne BitmClp3
	dec r12H
BitmClp3:
	dec r12L
	bra BitmClp2
BitmClp4:
	lda r11L
	jsr BitmHelpClp
	jsr BitmapUpHelp
	lda r11H
	jsr BitmHelpClp
	inc r1H
	dec r2H
	bne BitmClp4
	rts

BitmHelpClp:
	cmp #0
	beq BitmHClp1
	pha
	jsr BitmapDecode
	pla
	subv 1
	bne BitmHelpClp
BitmHClp1:
	rts

_i_BitmapUp:
	PopW returnAddress
	ldy #1
	lda (returnAddress),y
	sta r0L
	iny
	lda (returnAddress),y
	sta r0H
	iny
	lda (returnAddress),y
	sta r1L
	iny
	lda (returnAddress),y
	sta r1H
	iny
	lda (returnAddress),y
	sta r2L
	iny
	lda (returnAddress),y
	sta r2H
	jsr _BitmapUp
	php
	lda #7
	jmp DoInlineReturn

_BitmapUp:
	PushB r9H
	LoadB r9H, NULL
	lda #0
	sta r3L
	sta r4L
BitmUp1:
	jsr BitmapUpHelp
	inc r1H
	dec r2H
	bne BitmUp1
	PopB r9H
	rts

BitmapUpHelp:
	ldx r1H
	jsr _GetScanLine
	MoveB r2L, r3H
	CmpBI r1L, $20
	bcc BitmUpH1
	inc r5H
	inc r6H
BitmUpH1:
	asl
	asl
	asl
	tay
BitmUpH2:
	sty r9L
	jsr BitmapDecode
	ldy r9L
	sta (r5),y
	sta (r6),y
	tya
	addv 8
	bcc BitmUpH3
	inc r5H
	inc r6H
BitmUpH3:
	tay
	dec r3H
	bne BitmUpH2
	rts

BitmapDecode:
	lda r3L
	and #%01111111
	beq BitmDe2
	bbrf 7, r3L, BitmDe1
	jsr BitmapDecode2
	dec r3L
	rts
BitmDe1:
	lda r7H
	dec r3L
	rts
BitmDe2:
	lda r4L
	bne BitmDe3
	bbrf 7, r9H, BitmDe3
	jsr IndirectR14
BitmDe3:
	jsr BitmapDecode2
	sta r3L
	cmp #$dc
	bcc BitmDe4
	sbc #$dc
	sta r7L
	sta r4H
	jsr BitmapDecode2
	subv 1
	sta r4L
	MoveW r0, r8
	bra BitmDe2
BitmDe4:
	cmp #$80
	bcs BitmapDecode
	jsr BitmapDecode2
	sta r7H
	bra BitmapDecode

BitmapDecode2:
	bit r9H
	bpl BitmDe21
	jsr IndirectR13
BitmDe21:
	ldy #0
	lda (r0),y
	inc r0L
	bne *+4
	inc r0H
	ldx r4L
	beq BitmDe22
	dec r4H
	bne BitmDe22
	ldx r8H
	stx r0H
	ldx r8L
	stx r0L
	ldx r7L
	stx r4H
	dec r4L
BitmDe22:
	rts

IndirectR13:
	jmp (r13)

IndirectR14:
	jmp (r14)

.segment "graph4"

_DrawLine:
	php
	LoadB r7H, 0
	lda r11H
	sub r11L
	sta r7L
	bcs DrwLin1
	lda #0
	sub r7L
	sta r7L
DrwLin1:
	lda r4L
	sub r3L
	sta r12L
	lda r4H
	sbc r3H
	sta r12H
	ldx #r12
	jsr Dabs
	CmpW r12, r7
	bcs DrwLin2
	jmp DrawLine2
DrwLin2:
	lda r7L
	asl
	sta r9L
	lda r7H
	rol
	sta r9H
	lda r9L
	sub r12L
	sta r8L
	lda r9H
	sbc r12H
	sta r8H
	lda r7L
	sub r12L
	sta r10L
	lda r7H
	sbc r12H
	sta r10H
	asl r10L
	rol r10H
	LoadB r13L, $ff
	CmpW r3, r4
	bcc DrwLin4
	CmpB r11L, r11H
	bcc DrwLin3
	LoadB r13L, $01
DrwLin3:
	ldy r3H
	ldx r3L
	MoveW r4, r3
	sty r4H
	stx r4L
	MoveB r11H, r11L
	bra DrwLin5
DrwLin4:
	ldy r11H
	cpy r11L
	bcc DrwLin5
	LoadB r13L, 1
DrwLin5:
	plp
	php
	jsr _DrawPoint
	CmpW r3, r4
	bcs DrwLin7
	inc r3L
	bne *+4
	inc r3H
	bbrf 7, r8H, DrwLin6
	AddW r9, r8
	bra DrwLin5
DrwLin6:
.if 1
	AddB_ r13L, r11L
.else
	AddB r13L, r11L
.endif
	AddW r10, r8
	bra DrwLin5
DrwLin7:
	plp
	rts

DrawLine2:
	lda r12L
	asl
	sta r9L
	lda r12H
	rol
	sta r9H
	lda r9L
	sub r7L
	sta r8L
	lda r9H
	sbc r7H
	sta r8H
	lda r12L
	sub r7L
	sta r10L
	lda r12H
	sbc r7H
	sta r10H
	asl r10L
	rol r10H
	LoadW r13, $ffff
	CmpB r11L, r11H
	bcc Drw2Lin2
	CmpW r3, r4
	bcc Drw2Lin1
	LoadW r13, $0001
Drw2Lin1:
	MoveW r4, r3
	ldx r11L
	lda r11H
	sta r11L
	stx r11H
	bra Drw2Lin3
Drw2Lin2:
	CmpW r3, r4
	bcs Drw2Lin3
	LoadW r13, $0001
Drw2Lin3:
	plp
	php
	jsr _DrawPoint
	CmpB r11L, r11H
	bcs Drw2Lin5
	inc r11L
	bbrf 7, r8H, Drw2Lin4
	AddW r9, r8
	bra Drw2Lin3
Drw2Lin4:
	AddW r13, r3
	AddW r10, r8
	bra Drw2Lin3
Drw2Lin5:
	plp
	rts

_DrawPoint:
	php
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq DrwPoi1
	inc r5H
	inc r6H
DrwPoi1:
	lda r3L
	and #%00000111
	tax
	lda BitMask1, x
	plp
	bmi DrwPoi4
	bcc DrwPoi2
	ora (r6),y
	bra DrwPoi3
DrwPoi2:
	eor #$ff
	and (r6),y
DrwPoi3:
	sta (r6),y
	sta (r5),y
	rts
DrwPoi4:
	pha
	eor #$ff
	and (r5),y
	sta (r5),y
	pla
	and (r6),y
	ora (r5),y
	sta (r5),y
	rts

_TestPoint:
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq *+4
	inc r6H
	lda r3L
	and #%00000111
	tax
	lda BitMask1,x
	and (r6),y
	beq TestPoi1
	sec
	rts
TestPoi1:
	clc
	rts
