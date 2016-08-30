; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; VIC-II graphics library

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; conio.s
.import _PutString

; bitmask.s
.import BitMaskPow2Rev
.import BitMaskLeadingSet
.import BitMaskLeadingClear

; patterns.s
.import PatternTab

; var.s
.import GraphPenX
.import GraphPenY

; used by filesys.s
.global ClrScr

; syscalls
.global _BitOtherClip
.global _BitmapClip
.global _BitmapUp
.global _DrawLine
.global _DrawPoint
.global _FrameRectangle
.global _GetScanLine
.global _GraphicsString
.global _HorizontalLine
.global _ImprintRectangle
.global _InvertLine
.global _InvertRectangle
.global _RecoverLine
.global _RecoverRectangle
.global _Rectangle
.global _SetPattern
.global _TestPoint
.global _VerticalLine
.global _i_BitmapUp
.global _i_FrameRectangle
.global _i_GraphicsString
.global _i_ImprintRectangle
.global _i_RecoverRectangle
.global _i_Rectangle

GraphPenXL = GraphPenX
GraphPenXH = GraphPenX+1

.segment "graph1"

.if !wheels
;---------------------------------------------------------------
; used by EnterDesktop
;---------------------------------------------------------------
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
.endif

.segment "graph2"

PrepareXCoord:
	ldx r11L
	jsr _GetScanLine
	lda r4L
	and #%00000111
	tax
	lda BitMaskLeadingClear,x
	sta r8H
	lda r3L
	and #%00000111
	tax
	lda BitMaskLeadingSet,x
	sta r8L
	lda r3L
	and #%11111000
	sta r3L
	lda r4L
	and #%11111000
	sta r4L
	rts

.if wheels
LC325 = $C325

_HorizontalLine:
	sta r7L
	lda #0
	.byte $2c
_InvertLine:
	lda #$80
	sta LC325
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	lda r3H
	cmp r4H
	bne @2
	lda r3L
	cmp r4L
@2:	beq @7
	jsr LC7A3
	lda $12
	bit LC325
	bmi @3
	jsr LineCommon
	bra @4
@3:	eor (r5),y
@4:	bit LC325
	bpl @5
	eor #$FF
@5:	sta (r6),y
	sta (r5),y
	tya
	clc
	adc #8
	tay
	bcc @6
	inc r5H
	inc r6H
@6:	dec r4L
	beq @8
	lda r7L
	bit LC325
	bpl @4
	lda (r5),y
	bra @4
@7:	lda $12
	ora $13
	bra @9
@8:	lda $13
@9:	bit LC325
	bmi @A
	jsr LineCommon
	jmp @B
@A:	eor #$FF
	eor (r5),y
@B:	sta (r6),y
	sta (r5),y
LineEnd:
	PopW r4
	PopW r3
	rts

LineCommon:
	sta r11H
	and (r6),y
	sta r7H
	lda r11H
	eor #$FF
	and r7L
	ora r7H
	rts
.else
;---------------------------------------------------------------
; HorizontalLine                                          $C118
;
; Pass:      a    pattern byte
;            r11L y position in scanlines (0-199)
;            r3   x in pixel of left end (0-319)
;            r4   x in pixel of right end (0-319)
; Return:    r11L unchanged
; Destroyed: a, x, y, r5 - r8, r11
;---------------------------------------------------------------
_HorizontalLine:
	sta r7L
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr HLineHelp
@2:	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda r7L
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	jsr HLineHelp
HLinEnd1:
	sta (r6),Y
	sta (r5),Y
HLinEnd2:
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

;---------------------------------------------------------------
; InvertLine                                              $C11B
;
; Pass:      r3   x pos of left endpoint (0-319)
;            r4   x pos of right endpoint (0-319)
;            r11L y pos (0-199)
; Return:    r3-r4 unchanged
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_InvertLine:
	PushW r3
	PushW r4
	jsr PrepareXCoord
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	eor (r5),Y
@2:	eor #$FF
	sta (r6),Y
	sta (r5),Y
	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda (r5),Y
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	eor #$FF
	eor (r5),Y
	jmp HLinEnd1

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
.endif

;---------------------------------------------------------------
; RecoverLine                                             $C11E
;
; Pass:      r3   x pos of left endpoint (0-319)
;            r4   x pos of right endpoint (0-319)
;            r11L y pos of line (0-199)
; Return:    copies bits of line from background to
;            foreground sceen
; Destroyed: a, x, y, r5 - r8
;---------------------------------------------------------------
_RecoverLine:
.if wheels
	lda #$18 ; clc
	.byte $2c
ImprintLine:
	lda #$38 ; sec
	sta LC73C
	PushW r3
	PushW r4
	lda $2F
	pha
	ora #$C0
	sta $2F
	jsr PrepareXCoord
	pla
	sta $2F
LC73C:	clc
	bcc LC74F
	lda r5L
	ldy r6L
	sta r6L
	sty r5L
	lda r5H
	ldy r6H
	sta r6H
	sty r5H
LC74F:	ldy r3L
	lda r3H
	beq LC759
	inc r5H
	inc r6H
LC759:	lda r3H
	cmp r4H
	bne LC763
	lda r3L
	cmp r4L
LC763:	beq LC783
	jsr LC7A3
	lda $12
	jsr LC792
LC76D:	tya
	clc
	adc #8
	tay
	bcc LC778
	inc r5H
	inc r6H
LC778:	dec r4L
	beq LC78A
	lda (r6),y
	sta (r5),y
	bra LC76D
LC783:	lda $12
	ora $13
	bra LC78C
LC78A:	lda $13
LC78C:	jsr LC792
	jmp LineEnd

LC792:	sta r7L
	and (r5),y
	sta r7H
	lda r7L
	eor #$FF
	and (r6),y
	ora r7H
	sta (r5),y
	rts

LC7A3:	lda r4L
	sec
	sbc r3L
	sta r4L
	lda r4H
	sbc r3H
	sta r4H
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	rts
.else
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
	beq @1
	inc r5H
	inc r6H
@1:	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
	jsr RecLineHelp
@2:	tya
	addv 8
	tay
	bcc @3
	inc r5H
	inc r6H
@3:	dec r4L
	beq @5
	lda (r6),Y
	sta (r5),Y
	bra @2
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	jsr RecLineHelp
	jmp HLinEnd2

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
.endif

;---------------------------------------------------------------
; VerticalLine                                            $C121
;
; Pass:      a pattern
;            r3L top of line (0-199)
;            r3H bottom of line (0-199)
;            r4  x position of line (0-319)
; Return:    draw the line
; Destroyed: a, x, y, r4 - r8, r11
;---------------------------------------------------------------
_VerticalLine:
	sta r8L
	PushB r4L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	sta r7H
	lda r4L
	and #%11111000
	sta r4L
	ldy #0
	ldx r3L
@1:	stx r7L
	jsr _GetScanLine
	AddW r4, r5
	AddW r4, r6
	lda r7L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	and r8L
	bne @2
	lda r7H
	eor #$FF
	and (r6),Y
	bra @3
@2:	lda r7H
	ora (r6),Y
@3:	sta (r6),Y
	sta (r5),Y
	ldx r7L
	inx
	cpx r3H
	beq @1
	bcc @1
	PopB r4L
	rts

;---------------------------------------------------------------
; i_Rectangle                                             $C19F
;
; Same as Rectangle with data after the jsr
;---------------------------------------------------------------
_i_Rectangle:
	jsr GetInlineDrwParms
	jsr _Rectangle
.if wheels_size
.global DoInlineReturn7
DoInlineReturn7:
.endif
	php
	lda #7
	jmp DoInlineReturn

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
	lda (curPattern),Y
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

;---------------------------------------------------------------
; i_RecoverRectangle                                      $C1A5
;
; Same as RecoverRectangle with data after the jsr
;---------------------------------------------------------------
_i_RecoverRectangle:
	jsr GetInlineDrwParms
	jsr _RecoverRectangle
.if wheels_size
	jmp DoInlineReturn7
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

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

;---------------------------------------------------------------
; i_ImprintRectangle                                      $C253
;
; Same as ImprintRectangle with data after the jsr
;---------------------------------------------------------------
_i_ImprintRectangle:
	jsr GetInlineDrwParms
	jsr _ImprintRectangle
.if wheels_size
	jmp DoInlineReturn7
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

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

;---------------------------------------------------------------
; i_FrameRectangle                                        $C1A2
;
; Same as FrameRectangle with data after the jsr
; with the pattern byte the last
;---------------------------------------------------------------
_i_FrameRectangle:
	jsr GetInlineDrwParms
	iny
	lda (returnAddress),Y
	jsr _FrameRectangle
	php
	lda #8
	jmp DoInlineReturn

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

GetInlineDrwParms:
	PopW r5
	PopW returnAddress
.if wheels_size
	ldy #0
@1:	iny
	lda (returnAddress),y
	sta r1H,y
	cpy #6
	bne @1
.else
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
.endif
	PushW r5
	rts

;---------------------------------------------------------------
; i_GraphicsString                                        $C1A8
;
; Same as GraphicsString with data after the jsr
;---------------------------------------------------------------
_i_GraphicsString:
	PopB r0L
	pla
	inc r0L
	bne @1
	addv 1
@1:	sta r0H
	jsr _GraphicsString
	jmp (r0)

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
	jsr Getr0AndInc
.if wheels_size_and_speed
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
.if wheels_size
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
	jsr GrStSetCoords
	jmp _Rectangle

.if !wheels_size
_DoNothing:
	rts
.endif

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
.if wheels_size_and_speed
	jmp _PutString
.else
	jsr _PutString
	rts
.endif

_DoFrame_RecTo:
	jsr GrStSetCoords
	lda #$FF
	jmp _FrameRectangle

_DoPenXYDelta:
	ldx #1
.if wheels_size
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

GrStSetCoords:
	jsr GetCoords
	cmp GraphPenY
	bcs @1
	sta r2L
	pha
	lda GraphPenY
	sta r2H
	bra @2
@1:	sta r2H
	pha
	lda GraphPenY
	sta r2L
@2:	PopB GraphPenY
	cpy GraphPenXH
	beq @3
	bcs @5
@3:	bcc @4
	cpx GraphPenXL
	bcs @5
@4:	stx r3L
	sty r3H
	MoveW GraphPenX, r4
	bra @6
@5:	stx r4L
	sty r4H
	MoveW GraphPenX, r3
@6:	stx GraphPenXL
	sty GraphPenXH
	rts

;---------------------------------------------------------------
; SetPattern                                              $C139
;
; Pass:      a pattern nbr (0-33)
; Return:    currentPattern - updated
; Destroyed: a
;---------------------------------------------------------------
_SetPattern:
	asl
	asl
	asl
.if wheels
	.assert <PatternTab = 0, error, "PatternTab must be page-aligned!"
.else
	adc #<PatternTab
.endif
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
	bne @1
	inc r0H
@1:
.if !wheels_size_and_speed ; only one caller needed this
	cmp #0
.endif
	rts

;---------------------------------------------------------------
; GetScanLine                                             $C13C
;
; Function:  Returns the address of the beginning of a scanline

; Pass:      x   scanline nbr
; Return:    r5  add of 1st byte of foreground scr
;            r6  add of 1st byte of background scr
; Destroyed: a
;---------------------------------------------------------------
_GetScanLine:
	txa
	pha
.if !wheels
	pha
.endif
	and #%00000111
	sta r6H
.if wheels
	txa
.else
	pla
.endif
	lsr
	lsr
	lsr
	tax
	bbrf 7, dispBufferOn, @2 ; ST_WR_FORE
	bbsf 6, dispBufferOn, @1 ; ST_WR_BACK
	lda LineTabL,x
	ora r6H
	sta r5L
.if wheels
	sta r6L                             ; CA47 85 0E                    ..
.endif
	lda LineTabH,x
	sta r5H
.if wheels
	sta r6H                             ; CA47 85 0E                    ..
.else
	MoveW r5, r6
.endif
	pla
	tax
	rts
@1:	lda LineTabL,x
	ora r6H
	sta r5L
	sta r6L
	lda LineTabH,x
	sta r5H
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
	pla
	tax
	rts
@2:	bbrf 6, dispBufferOn, @3 ; ST_WR_BACK
	lda LineTabL,x
	ora r6H
	sta r6L
.if wheels
	sta r5L
.endif
	lda LineTabH,x
	subv >(SCREEN_BASE-BACK_SCR_BASE)
	sta r6H
.if wheels
	sta r5H
.else
	MoveW r6, r5
.endif
	pla
	tax
	rts
@3:	LoadB r5L, <$AF00
	sta r6L
	LoadB r5H, >$AF00
	sta r6H
	pla
	tax
	rts

.define LineTab SCREEN_BASE+0*320, SCREEN_BASE+1*320, SCREEN_BASE+2*320, SCREEN_BASE+3*320, SCREEN_BASE+4*320, SCREEN_BASE+5*320, SCREEN_BASE+6*320, SCREEN_BASE+7*320, SCREEN_BASE+8*320, SCREEN_BASE+9*320, SCREEN_BASE+10*320, SCREEN_BASE+11*320, SCREEN_BASE+12*320, SCREEN_BASE+13*320, SCREEN_BASE+14*320, SCREEN_BASE+15*320, SCREEN_BASE+16*320, SCREEN_BASE+17*320, SCREEN_BASE+18*320, SCREEN_BASE+19*320, SCREEN_BASE+20*320, SCREEN_BASE+21*320, SCREEN_BASE+22*320, SCREEN_BASE+23*320, SCREEN_BASE+24*320
LineTabL:
	.lobytes LineTab
LineTabH:
	.hibytes LineTab

.segment "graph3"

;---------------------------------------------------------------
; BitOtherClip                                            $C2C5
;
; Pass:      r0   ptr to a 134 bytes buffer
;            r1L  left side of window  in bytes (0-39)
;            r1H  top of window (0-199)
;            r2L  width in bytes of window (0-39)
;            r2H  height in pixels of window (0-199)
;            r11L nbr of bytes to skip from the left side before
;                 printing it
;            r11H the width in pixels of the bitmap to show
;                 within the window
;            r12  nbr of scanline to skip from the top
;            r13  add. of input routine, returns next byte from
;                 bitmap in the accumulator.
;            r14  address of sync routine. Just reload r0 with
;                 buffer address
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r14
;---------------------------------------------------------------
_BitOtherClip:
	ldx #$ff
.if wheels
	.byte $2c
.else
	jmp BitmClp1
.endif

;---------------------------------------------------------------
; BitmapClip                                              $C2AA
;
; Pass:      r0   pointer to bitmap
;            r1L  left side of window in bytes to display the
;                 bitmap (0-39)
;            r1H  top of window in pixels (0-199)
;            r2L  width of window in bytes (0-39)
;            r2H  height of window in pixels (0-39)
;            r11L nbr of bytes to skip from the left side before
;                 printing it
;            r11H the width in pixels of the bitmap to show
;                 within the window
;            r12  nbr of scanline to skip from the top
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r12
;---------------------------------------------------------------
_BitmapClip:
	ldx #0
BitmClp1:
	stx r9H
	lda #0
	sta r3L
	sta r4L
@1:	lda r12L
	ora r12H
	beq @3
	lda r11L
	jsr BitmHelpClp
	lda r2L
	jsr BitmHelpClp
	lda r11H
	jsr BitmHelpClp
	lda r12L
	bne @2
	dec r12H
@2:	dec r12L
	bra @1
@3:	lda r11L
	jsr BitmHelpClp
	jsr BitmapUpHelp
	lda r11H
	jsr BitmHelpClp
	inc r1H
	dec r2H
	bne @3
	rts

BitmHelpClp:
	cmp #0
	beq @1
	pha
	jsr BitmapDecode
	pla
	subv 1
	bne BitmHelpClp
@1:	rts

;---------------------------------------------------------------
; i_BitmapUp                                              $C1AB
;
; Same as BitmapUp with data after the jsr
;---------------------------------------------------------------
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

;---------------------------------------------------------------
; BitmapUp                                                $C142
;
; Pass:      r0  ptr of bitmap
;            r1L x pos. in bytes (0-39)
;            r1H y pos. in scanlines (0-199)
;            r2L width in bytes (0-39)
;            r2H height in pixels (0-199)
; Return:    display the bitmap
; Destroyed: a, x, y, r0 - r9l
;---------------------------------------------------------------
_BitmapUp:
	PushB r9H
	LoadB r9H, NULL
.if !wheels
	lda #0
.endif
	sta r3L
	sta r4L
@1:	jsr BitmapUpHelp
	inc r1H
	dec r2H
	bne @1
	PopB r9H
	rts

BitmapUpHelp:
	ldx r1H
	jsr _GetScanLine
	MoveB r2L, r3H
	CmpBI r1L, $20
	bcc @1
	inc r5H
	inc r6H
@1:	asl
	asl
	asl
	tay
@2:	sty r9L
	jsr BitmapDecode
	ldy r9L
	sta (r5),y
	sta (r6),y
	tya
	addv 8
	bcc @3
	inc r5H
	inc r6H
@3:	tay
	dec r3H
	bne @2
	rts

BitmapDecode:
	lda r3L
	and #%01111111
	beq @2
	bbrf 7, r3L, @1
	jsr BitmapDecode2
	dec r3L
	rts
@1:	lda r7H
	dec r3L
	rts
@2:	lda r4L
	bne @3
	bbrf 7, r9H, @3
	jsr IndirectR14
@3:	jsr BitmapDecode2
	sta r3L
	cmp #$dc
	bcc @4
	sbc #$dc
	sta r7L
	sta r4H
	jsr BitmapDecode2
	subv 1
	sta r4L
	MoveW r0, r8
	bra @2
@4:	cmp #$80
	bcs BitmapDecode
	jsr BitmapDecode2
	sta r7H
	bra BitmapDecode

.if wheels
IndirectR13:
	jmp (r13)

IndirectR14:
	jmp (r14)
.endif

BitmapDecode2:
	bit r9H
	bpl @1
	jsr IndirectR13
@1:
	ldy #0
	lda (r0),y
	inc r0L
	bne @2
	inc r0H
@2:	ldx r4L
	beq @3
	dec r4H
	bne @3
	ldx r8H
	stx r0H
	ldx r8L
	stx r0L
	ldx r7L
	stx r4H
	dec r4L
@3:	rts

.if !wheels
IndirectR13:
	jmp (r13)

IndirectR14:
	jmp (r14)
.endif

.segment "graph4"

;---------------------------------------------------------------
; DrawLine                                                $C130
;
; Pass:      signFlg  set to recover from back screen
;                     reset for drawing
;            carryFlg set for drawing in forground color
;                     reset for background color
;            r3       x pos of 1st point (0-319)
;            r11L     y pos of 1st point (0-199)
;            r4       x pos of 2nd point (0-319)
;            r11H     y pos of 2nd point (0-199)
; Return:    line is drawn or recover
; Destroyed: a, x, y, r4 - r8, r11
;---------------------------------------------------------------
_DrawLine:
	php
	LoadB r7H, 0
	lda r11H
	sub r11L
	sta r7L
	bcs @1
	lda #0
	sub r7L
	sta r7L
@1:	lda r4L
	sub r3L
	sta r12L
	lda r4H
	sbc r3H
	sta r12H
	ldx #r12
	jsr Dabs
	CmpW r12, r7
	bcs @2
	jmp @9
@2:	lda r7L
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
	bcc @4
	CmpB r11L, r11H
	bcc @3
	LoadB r13L, $01
@3:	ldy r3H
	ldx r3L
	MoveW r4, r3
	sty r4H
	stx r4L
	MoveB r11H, r11L
	bra @5
@4:	ldy r11H
	cpy r11L
	bcc @5
	LoadB r13L, 1
@5:	plp
	php
	jsr _DrawPoint
	CmpW r3, r4
	bcs @8
	inc r3L
	bne @6
	inc r3H
@6:	bbrf 7, r8H, @7
	AddW r9, r8
	bra @5
@7:	AddB_ r13L, r11L
	AddW r10, r8
	bra @5
@8:
	plp
	rts

@9:	lda r12L
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
	bcc @B
	CmpW r3, r4
	bcc @A
	LoadW r13, $0001
@A:	MoveW r4, r3
	ldx r11L
	lda r11H
	sta r11L
	stx r11H
	bra @C
@B:	CmpW r3, r4
	bcs @C
	LoadW r13, $0001
@C:	plp
	php
	jsr _DrawPoint
	CmpB r11L, r11H
	bcs @E
	inc r11L
	bbrf 7, r8H, @D
	AddW r9, r8
	bra @C
@D:	AddW r13, r3
	AddW r10, r8
	bra @C
@E:	plp
	rts

;---------------------------------------------------------------
; DrawPoint                                               $C133
;
; Pass:      same as DrawLine with no 2nd point
; Return:    point is drawn or recovered
; Destroyed: a, x, y, r5 - r6
;---------------------------------------------------------------
_DrawPoint:
	php
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:	lda r3L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	plp
	bmi @4
	bcc @2
	ora (r6),y
	bra @3
@2:	eor #$ff
	and (r6),y
@3:	sta (r6),y
	sta (r5),y
	rts
@4:	pha
	eor #$ff
	and (r5),y
	sta (r5),y
	pla
	and (r6),y
	ora (r5),y
	sta (r5),y
	rts

;---------------------------------------------------------------
; TestPoint                                               $C13F
;
; Pass:      a    pattern
;            r3   x position of pixel (0-319)
;            r11L y position of pixel (0-199)
; Return:    carry set if bit is set
; Destroyed: a, x, y, r5, r6
;---------------------------------------------------------------
_TestPoint:
	ldx r11L
	jsr _GetScanLine
	lda r3L
	and #%11111000
	tay
	lda r3H
	beq @1
	inc r6H
@1:	lda r3L
	and #%00000111
	tax
	lda BitMaskPow2Rev,x
	and (r6),y
	beq @2
	sec
	rts
@2:	clc
	rts
