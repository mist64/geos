; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: TestPoint, DrawPoint, DrawLine syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import BitMaskPow2Rev
.import _GetScanLine
.ifdef bsw128
.import _Dabs
.import _TempHideMouse
.import _DShiftLeft
.import _HorizontalLine
.else
.import Dabs
.endif

.import LF4B7
.import LF558
.import StaFrontbuffer80
.import StaBackbuffer80
.import LF4A7
.import GetLeftXAddress
.import _NormalizeX

.global _TestPoint
.global _DrawPoint
.global _DrawLine

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
.ifdef bsw128
	bmi @Y
	lda r11L
	cmp r11H
	bne @Y
	lda #$FF
	plp
	bcs @X
	lda #0
@X:	jmp _HorizontalLine
@Y:	ldx #r3
	jsr _NormalizeX
	ldx #r4
	jsr _NormalizeX
.endif
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
.ifdef bsw128
	jsr _Dabs
.else
	jsr Dabs
.endif
	CmpW r12, r7
	bcs @2
.ifdef bsw128 ; TODO dedup
	jmp @LF140
.else
	jmp @9
.endif
@2:
.ifdef bsw128
	lda r7H
	sta r9H
	lda r7L
	sta r9L
	ldy #1
	ldx #r9
	jsr _DShiftLeft
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
	ldy #1
	ldx #r10
	jsr _DShiftLeft
	LoadB r13L, $ff
	jsr CmpWR3R4
	bcc @LF0F9
	CmpB r11L, r11H
	bcc @LF0DE
	LoadB r13L, 1
@LF0DE:	PushW r3
	MoveW r4, r3
	MoveB r11H, r11L
	PopW r4
	bra @LF103
@LF0F9:	ldy r11H
	cpy r11L
	bcc @LF103
	LoadB r13L, 1
@LF103:	plp
	php
	jsr _DrawPoint
	jsr CmpWR3R4
	bcs @LF13E
	inc r3L
	bne @LF113
	inc r3H
@LF113:	bbrf 7, r8H, @LF127
	AddW r9, r8
	bra @LF103
@LF127:	AddB_ r13L, r11L
	AddW r10, r8
	bra @LF103
@LF13E:	plp
	rts
@LF140:	MoveW r12, r9
	ldy #1
	ldx #r9
	jsr _DShiftLeft
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
	ldy #$01
	ldx #r10
	jsr _DShiftLeft
	lda #$FF
	sta r13H
	lda #$FF
	sta r13L
	CmpB r11L, r11H
	bcc @LF1A0
	jsr CmpWR3R4
	bcc @LF18B
	LoadW r13, 1
@LF18B:	MoveW r4, r3
	PushB r11L
	MoveB r11H, r11L
	PopB r11H
	bra @LF1AD
@LF1A0:	jsr CmpWR3R4
	bcs @LF1AD
	LoadW r13, 1
@LF1AD:	plp
	php
	jsr _DrawPoint
	CmpB r11L, r11H
	bcs @LF1EB
	inc r11L
	bbrf 7, r8H, @LF1CE
	AddW r9, r8
	bra @LF1AD
@LF1CE:	AddW r13, r3
	AddW r10, r8
	bra @LF1AD
@LF1EB:	plp
	rts
.else
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
	bcc @4
	CmpB r11L, r11H
	bcc @3
	LoadB r13L, 1
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
@8:	plp
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
	LoadW r13, 1
@A:	MoveW r4, r3
	ldx r11L
	lda r11H
	sta r11L
	stx r11H
	bra @C
@B:	CmpW r3, r4
	bcs @C
	LoadW r13, 1
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
.endif

;---------------------------------------------------------------
; DrawPoint                                               $C133
;
; Pass:      same as DrawLine with no 2nd point
; Return:    point is drawn or recovered
; Destroyed: a, x, y, r5 - r6
;---------------------------------------------------------------
_DrawPoint:
	php
.ifdef bsw128
	jsr _TempHideMouse
	ldx #r3
	jsr _NormalizeX
.endif
	ldx r11L
	jsr _GetScanLine
.ifdef bsw128
	bbsf 7, graphMode, DrwPoi80
.endif
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

.ifdef bsw128
DrwPoi80:
	jsr GetLeftXAddress
	lda BitMaskPow2Rev,x
	plp
	bmi @3
	bcc @1
	jsr LF4A7
	bra @2
@1:	eor #$FF
	jsr LF4B7
@2:	jsr StaBackbuffer80
	jmp StaFrontbuffer80
@3:	pha
	eor #$FF
	jsr LF558
	sta DrwPointTemp
	pla
	jsr LF4B7
	ora DrwPointTemp
	jmp StaFrontbuffer80

DrwPointTemp:
	.byte 0
.endif

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
.ifdef bsw128
	jsr _TempHideMouse
	ldx #r3
	jsr _NormalizeX
.endif
	ldx r11L
	jsr _GetScanLine
.ifdef bsw128
	bbsf 7, graphMode, TestPoi80
.endif
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

.ifdef bsw128
.global CmpWR3R4
TestPoi80:
	jsr GetLeftXAddress
	lda BitMaskPow2Rev,x
	jsr LF4B7
	beq LF29F
	sec
	rts
LF29F:	clc
	rts

CmpWR3R4:
	lda r3H
	cmp r4H
	bne LF2AB
	lda r3L
	cmp r4L
LF2AB:	rts
.endif
