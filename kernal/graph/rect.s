; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: rectangles

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _HorizontalLine
.import _InvertLine
.import _RecoverLine
.import _VerticalLine
.import ImprintLine

.global _Rectangle
.global _InvertRectangle
.global _RecoverRectangle
.global _ImprintRectangle
.global _FrameRectangle

.segment "graph2c"

;---------------------------------------------------------------
; Rectangle                                               $C124
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    draws the rectangle
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_Rectangle:
	MoveB r2L, r11L
@1:	lda r11L
	and #$07
	tay
.ifdef bsw128
	PushB rcr
	and #$F0
	ora #$0A
	sta rcr
.endif
	lda (curPattern),Y
.ifdef bsw128
	tax
	PopB rcr
	txa
.endif
	jsr _HorizontalLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

;---------------------------------------------------------------
; InvertRectangle                                         $C12A
;
; Pass:      r2L top in scanlines (0-199)
;            r2H bottom in scanlines (0-199)
;            r3  left in pixels (0-319)
;            r4  right in pixels (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_InvertRectangle:
	MoveB r2L, r11L
@1:	jsr _InvertLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

.segment "graph2e"

;---------------------------------------------------------------
; RecoverRectangle                                        $C12D
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    rectangle recovered from backscreen
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_RecoverRectangle:
	MoveB r2L, r11L
@1:	jsr _RecoverLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

.segment "graph2g"

;---------------------------------------------------------------
; ImprintRectangle                                        $C250
;
; Pass:      r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_ImprintRectangle:
	MoveB r2L, r11L
@1:	jsr ImprintLine
	lda r11L
	inc r11L
	cmp r2H
	bne @1
	rts

.segment "graph2i1"

;---------------------------------------------------------------
; FrameRectangle                                          $C127
;
; Pass:      a   GEOS pattern
;            r2L top (0-199)
;            r2H bottom (0-199)
;            r3  left (0-319)
;            r4  right (0-319)
; Return:    r2L, r3H unchanged
; Destroyed: a, x, y, r5 - r9, r11
;---------------------------------------------------------------
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
