; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: BitmapClip, BitOtherClip syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import BitmapUpHelp
.import BitmapDecode
.ifdef bsw128
.import _TempHideMouse
.endif

.global _BitOtherClip
.global _BitmapClip

.segment "graph3a"

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
.ifdef wheels_size
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
.ifdef bsw128
	jsr _TempHideMouse
	PushB rcr
	and #%11110000
	ora #%00001010
	sta rcr
.endif
	lda #0
	sta r3L
	sta r4L
@1:	lda r12L
	ora r12H
	beq @3
	lda r11L
	jsr BitmHelpClp
	lda r2L
.ifdef bsw128
	bpl @X
	asl a
@X:	bbsf 7, graphMode, @Y
	lda r2L
	and #$7F
@Y:
.endif
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
.ifdef bsw128
	PopB rcr
.endif
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

