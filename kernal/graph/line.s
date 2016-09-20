; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: line functions

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import BitMaskPow2Rev
.import BitMaskLeadingSet
.import BitMaskLeadingClear
.import _GetScanLine
.ifdef bsw128
.import _TempHideMouse
.import _NormalizeX
.import VDCFillr4LA
.import LF4B7
.import ShareTop
.import LF5BF
.import ILin80_Help
.import LF522
.import ShareTopBot
.import LF558
.import LF4A7
.import CmpWR3R4
.import StaFrontbuffer80
.import StaBackbuffer80
.import GetLeftXAddress
.endif

.global ImprintLine
.global _HorizontalLine
.global _InvertLine
.global _RecoverLine
.global _VerticalLine
.ifdef bsw128
.global HLinEnd2
.endif

.segment "graph2a"

PrepareXCoord:
.ifdef bsw128
	jsr _TempHideMouse
	ldx #r3
	jsr _NormalizeX
	ldx #r4
	jsr _NormalizeX
	lda r4L
	ldx r4H
	cpx r3H
	bne @1
	cmp r3L
@1:	bcs @2
	ldy r3H
	sty r4H
	ldy r3L
	sty r4L
	sta r3L
	stx r3H
@2:
.endif
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
.ifdef bsw128
	bbrf 7, graphMode, @3
	jsr GetLeftXAddress
@3:
.endif
	lda r3L
	and #%11111000
	sta r3L
	lda r4L
	and #%11111000
	sta r4L
.ifdef bsw128
	cmp r3L
	bne @4
	lda r4H
	cmp r3H
@4:
.endif
	rts

.ifdef wheels_size
.import WheelsTemp
_HorizontalLine:
	sta r7L
	lda #0
	.byte $2c
_InvertLine:
	lda #$80
	sta WheelsTemp
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
	jsr LineHelp2
	lda r8L
	bit WheelsTemp
	bmi @3
	jsr LineCommon
	bra @4
@3:	eor (r5),y
@4:	bit WheelsTemp
	bpl @5
	eor #$FF
@5:	sta (r6),y
	sta (r5),y
	tya
	add #8
	tay
	bcc @6
	inc r5H
	inc r6H
@6:	dec r4L
	beq @8
	lda r7L
	bit WheelsTemp
	bpl @4
	lda (r5),y
	bra @4
@7:	lda r8L
	ora r8H
	bra @9
@8:	lda r8H
@9:	bit WheelsTemp
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
.ifdef bsw128
	php
	bbsf 7, graphMode, HLin80
.endif
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:
.ifdef bsw128
	plp
	beq @4
	jsr GetCardsDistance
.else
	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
.endif
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

.ifdef bsw128
HLin80:	plp
	beq @4
	jsr GetCardsDistance
	jsr HLineHelp3
	jsr StaLeftByte80
	beq @5
	bbrf 6, dispBufferOn, @2
	ldy r4L
	lda r7L
@1:	dey
	sta (r6),y
	cpy #0
	bne @1
@2:	lda r7L
	jsr VDCFillr4LA
	lda r5L
	clc
	adc r4L
	sta r5L
	sta r6L
	bcc @3
	inc r5H
	inc r6H
@3:	bra @5
@4:	lda r8L
	ora r8H
	bra @6
@5:	lda r8H
@6:	jsr HLineHelp3
	jsr StaBackbuffer80
	jsr StaFrontbuffer80
	jmp HLinEnd2

;!!! used only once
StaLeftByte80:
	jsr StaBackbuffer80
	jsr StaFrontbuffer80
	inc r6L
	inc r5L
	bne @1
	inc r5H
	inc r6H
@1:	dec r4L
	rts

; in:  r3, r4   X coords
; out: r4       distance in cards
GetCardsDistance:
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4H
	ror r4L
	lsr r4L
	lda r8L
	rts
.endif

HLineHelp:
	sta r11H
	and (r6),Y
HLineHelp2:
	sta r7H
	lda r11H
	eor #$FF
	and r7L
	ora r7H
	rts

.ifdef bsw128
HLineHelp3:
	sta r11H
	jsr LF4B7
	bra HLineHelp2
.endif

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
.ifdef bsw128
	php
	bbsf 7, graphMode, ILin80
.endif
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:
.ifdef bsw128
	plp
	beq @4
	jsr GetCardsDistance
.else
	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
.endif
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

.ifdef bsw128
ILin80:	plp
	jsr GetCardsDistance
	inc r4L
	jsr ShareTopBot
	PushW r5
	ldx r4L
	dex
	bmi @4
	jsr LF522
	bra @2
@1:	dex
	bmi @4
	jsr ILin80_Help
@2:	eor #$FF
	sta invertBuffer,x
	inc r5L
	bne @3
	inc r5H
@3:	bra @1
@4:	PopW r5
	lda invertBuffer
	eor r8H
	sta invertBuffer
	ldx r4L
	dex
	bmi @8
	lda invertBuffer,x
	eor r8L
	jsr StaFrontbuffer80
	bra @6
@5:	dex
	bmi @8
	lda invertBuffer,x
	jsr LF5BF
@6:	jsr StaBackbuffer80
	inc r6L
	inc r5L
	bne @7
	inc r6H
	inc r5H
@7:	bra @5
@8:	jsr ShareTop
	jmp HLinEnd2
.endif

ImprintLine:
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
.ifdef bsw128
	bbrf 7, graphMode, @1
	jmp Read80Line
@1:
.else
	PopB dispBufferOn
.endif
	lda r5L
	ldy r6L
	sta r6L
	sty r5L
	lda r5H
	ldy r6H
	sta r6H
	sty r5H
.ifdef bsw128
	bra RLin0a
.else
	bra RLin0
.endif
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
.ifdef wheels_size
	lda #$18 ; clc
	.byte $2c
ImprintLine:
	lda #$38 ; sec
	sta @1
	PushW r3
	PushW r4
	PushB dispBufferOn
	ora #ST_WR_FORE | ST_WR_BACK
	sta dispBufferOn
	jsr PrepareXCoord
	PopB dispBufferOn
@1:	clc
	bcc @2
	lda r5L
	ldy r6L
	sta r6L
	sty r5L
	lda r5H
	ldy r6H
	sta r6H
	sty r5H
@2:	ldy r3L
	lda r3H
	beq @3
	inc r5H
	inc r6H
@3:	CmpW r3, r4
	beq @6
	jsr LineHelp2
	lda r8L
	jsr LineHelp1
@4:	tya
	add #8
	tay
	bcc @5
	inc r5H
	inc r6H
@5:	dec r4L
	beq @7
	lda (r6),y
	sta (r5),y
	bra @4
@6:	lda r8L
	ora r8H
	bra @8
@7:	lda r8H
@8:	jsr LineHelp1
	jmp LineEnd

LineHelp1:
	sta r7L
	and (r5),y
	sta r7H
	lda r7L
	eor #$FF
	and (r6),y
	ora r7H
	sta (r5),y
	rts

LineHelp2:
	SubW r3, r4
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
.ifdef bsw128
	bbrf 7, graphMode, @X
	jmp Write80Line
@X:
.endif
RLin0a:
	PopB dispBufferOn
RLin0:
	ldy r3L
	lda r3H
	beq @1
	inc r5H
	inc r6H
@1:
.ifdef bsw128
	jsr CmpWR3R4
	beq @4
	jsr GetCardsDistance
.else
	CmpW r3, r4
	beq @4
	SubW r3, r4
	lsr r4H
	ror r4L
	lsr r4L
	lsr r4L
	lda r8L
.endif
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

.ifdef bsw128
Read80Line:
	jsr CmpWR3R4
	beq @3
	jsr GetCardsDistance
	jsr Read80Help
	iny
@1:	dec r4L
	beq @4
@2:	bit vdcreg
	bpl @2
	lda vdcdata
	sta (r6),y
	iny
	bne @1
@3:	lda r8L
	ora r8H
	bra @6
@4:	tya
	clc
	adc r5L
	sta r5L
	sta r6L
	bcc @5
	inc r5H
	inc r6H
@5:	lda r8H
@6:	jsr Read80Help
	PopB dispBufferOn
	jmp HLinEnd2

Write80Line:
	jsr CmpWR3R4
	beq @3
	jsr GetCardsDistance
	jsr Write80Help
	iny
@1:	dec r4L
	beq @4
	lda (r6),y
@2:	bit vdcreg
	bpl @2
	sta vdcdata
	iny
	bne @1
@3:	lda r8L
	ora r8H
	bra @6
@4:	tya
	clc
	adc r5L
	sta r5L
	sta r6L
	bcc @5
	inc r5H
	inc r6H
@5:	lda r8H
@6:	jsr Write80Help
	PopB dispBufferOn
	jmp HLinEnd2
.endif

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

.ifdef bsw128
Write80Help:
	sta r7L
	jsr LF558
	sta r7H
	lda r7L
	eor #$FF
	ldy #0
	and (r6),y
	ora r7H
	jmp StaFrontbuffer80

Read80Help:
	sta r7L
	ldy #0
	and (r6),y
	sta r7H
	lda r7L
	eor #$FF
	jsr LF558
	ora r7H
	sta (r6),y
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
.ifdef bsw128
	jsr _TempHideMouse
	ldx #r4
	jsr _NormalizeX
	bbsf 7, graphMode, VLin80
.endif
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

.ifdef bsw128
VLin80:
	PushW r3
	ldx r3L
	stx r7L
	jsr _GetScanLine
	MoveW r4, r3
	jsr GetLeftXAddress
	lda BitMaskPow2Rev,x
	sta r7H
	PopW r3
	ldx r3L
@1:	stx r7L
	txa
	and #$07
	tax
	lda BitMaskPow2Rev,x
	and r8L
	bne @2
	lda r7H
	eor #$FF
	jsr LF4B7
	bra @3
@2:	lda r7H
	jsr LF4A7
@3:	jsr StaBackbuffer80
	jsr StaFrontbuffer80
	ldx r7L
	jsr @4
	cpx r3H
	beq @1
	bcc @1
	rts
@4:	AddVB SCREENPIXELWIDTH/8, r5L
	sta r6L
	bcc @5
	inc r5H
	inc r6H
@5:	inx
	cpx #100
	beq @6
	rts
@6:	bbrf 6, dispBufferOn, @7
	AddVB 33, r6H
	bbsf 7, dispBufferOn, @7
	sta r5H
@7:	rts
.endif
