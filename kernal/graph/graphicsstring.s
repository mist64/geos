; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: GraphicsString

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _PutString
.import _SetPattern
.import GraphPenX
.import GraphPenY
.import __GrStSetCoords
.import _DrawLine
.import _Rectangle
.import _FrameRectangle
.import CallRoutine

GraphPenXL = GraphPenX
GraphPenXH = GraphPenX+1

.global _GraphicsString
.global GetCoords
.global GetR0AndInc

.segment "graph2k"

;---------------------------------------------------------------
; GraphicsString                                          $C136
;
; Pass:      r0 ptr to graphics string,0
;            MOVEPENTO     1  .word x, .byte  y
;            LINETO        2  .word x, .byte  y
;            RECTANGLETO   3  .word x, .byte  y
;            NEWPATTERN    5  .byte pattern No.
;            ESC_PUTSTRING 6  see PutString
;            FRAME_RECTO   7  .word x, .byte  y
;          New:
;            MOVEPENRIGHT  8  .word x
;            MOVEPENDOWN   9  .byte y
;            MOVERIGHTDOWN 10 .word x, .byte  y
; Return:    graphics being drawed
; Destroyed: a, x, y, r0 - r15
;---------------------------------------------------------------
_GraphicsString:
	jsr GetR0AndInc
.ifdef wheels_size_and_speed
	tay
	beq @1
.else
	beq @1
	tay
.endif
	dey
	lda GStrTL,y
	ldx GStrTH,y
	jsr CallRoutine
	bra _GraphicsString
@1:	rts

.define GStrT _DoMovePenTo, _DoLineTo, _DoRectangleTo, _DoNothing, _DoNewPattern, _DoESC_PutString, _DoFrame_RecTo, _DoPenXDelta, _DoPenYDelta, _DoPenXYDelta
GStrTL:
	.lobytes GStrT
GStrTH:
	.hibytes GStrT

_DoMovePenTo:
	jsr GetCoords
	sta GraphPenY
	stx GraphPenXL
	sty GraphPenXH
.if .defined(bsw128) || .defined(wheels_size)
_DoNothing:
.endif
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
	jsr __GrStSetCoords
	jmp _Rectangle

.ifndef bsw128
.ifndef wheels_size
_DoNothing:
	rts
.endif
.endif

_DoNewPattern:
	jsr GetR0AndInc
	jmp _SetPattern

_DoESC_PutString:
	jsr GetR0AndInc
	sta r11L
	jsr GetR0AndInc
	sta r11H
	jsr GetR0AndInc
	sta r1H
.if .defined(bsw128) || .defined(wheels_size_and_speed)
	jmp _PutString
.else
	jsr _PutString
	rts
.endif

_DoFrame_RecTo:
	jsr __GrStSetCoords
	lda #$FF
	jmp _FrameRectangle

_DoPenXYDelta:
	ldx #1
.ifdef wheels_size
	.byte $2c
.else
	bne DPXD0
.endif
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
	bcc @1
	inc r0H
@1:	rts

.segment "graph2m"

GetCoords:
	jsr GetR0AndInc
	tax
	jsr GetR0AndInc
	sta r2L
	jsr GetR0AndInc
	ldy r2L
	rts ;x/y - x, a - y

GetR0AndInc:
	ldy #0
	lda (r0),Y
.ifdef wheels_size
.global IncR0
IncR0:
.endif
	inc r0L
	bne @1
	inc r0H
@1:
.ifndef wheels_size_and_speed ; only one caller needed this
	cmp #0
.endif
	rts

