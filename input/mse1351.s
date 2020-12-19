; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Commodore 1351 mouse input driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "c64.inc"

.segment "inputdrv"

MouseInit:
	jmp _MouseInit
SlowMouse:
	jmp _SlowMouse
UpdateMouse:
	jmp _UpdateMouse
.ifdef bsw128
SetMouse:
	rts
.endif

tmpFire:
	.byte 0
mseX:
	.byte 0
mseY:
	.byte 0

_MouseInit:
	LoadW mouseXPos, 8
	LoadB mouseYPos, 8
_SlowMouse:
	rts

_UpdateMouse:
	bbsf MOUSEON_BIT, mouseOn, UM_1
	jmp UM_END

UM_1:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushW cia1base+2
	PushB cia1base+0
	LoadW cia1base+2, 0

	lda cia1base+1
	and #$10
	cmp tmpFire
	beq UM_2
	sta tmpFire
	asl
	asl
	asl
	sta mouseData
	smbf MOUSE_BIT, pressFlag

UM_2:
	LoadB cia1base+2, $ff
	LoadB cia1base+0, $40
	ldx #$66
UM_3:
	nop
	nop
	nop
	dex
	bne UM_3
	stx r1L

	lda sidbase+$19
	ldy mseX
	jsr CountDelta
	sty mseX
	cmp #0
	beq UM_5
	pha
	and #$80
	bne UM_4
	lda #$40
UM_4:
	ora r1L
	sta r1L
	pla
UM_5:
	add mouseXPos+0
	sta mouseXPos+0
	txa
	adc mouseXPos+1
	sta mouseXPos+1

	lda sidbase+$1a
	ldy mseY
	jsr CountDelta
	sty mseY
	cmp #0
	beq UM_7
	pha
	and #$80
	lsr
	lsr
	lsr
	bne UM_6
	lda #$20
UM_6:
	ora r1L
	sta r1L
	pla
UM_7:
	sec
	eor #$ff
	adc mouseYPos
	sta mouseYPos
	php
	CmpBI mouseYPos, 199
	bcc UM_8
	LoadB mouseYPos, 199
UM_8:
	plp
	txa
	eor #$ff
	adc #0
	cmp #$ff
	bne UM_9
	LoadB mouseYPos, 0
UM_9:
	lda r1L
	lsr
	lsr
	lsr
	lsr
	tax
	lda mseDirTab,x
	sta inputData
	PopB cia1base
	PopW cia1base+2
	PopB CPU_DATA
UM_END:
	rts

mseDirTab:
	.byte $ff, $06, $02, $ff, $00, $07, $01, $ff
	.byte $04, $05, $03, $ff, $ff, $ff, $ff, $ff

CountDelta:
	sty r0L
	sta r0H
	ldx #0
	sec
	sbc r0L
	and #$7f
	cmp #$40
	bcs deltaNegative
	lsr
	beq deltaZero
	tay
	lda deltaTab-1,y
	ldy r0H
	rts
deltaNegative:
	ora #$c0
	cmp #$ff
	beq deltaZero
	sec
	ror
	eor #$ff
	tay
	lda deltaTab,y
	eor #$ff
	clc
	adc #1
	ldx #$ff
	ldy r0H
	rts
deltaZero:
	lda #0
	rts

deltaTab:
	.byte $01, $01, $02, $02, $03, $04, $06, $08
	.byte $09, $0b, $0d, $0f, $11, $13, $15, $19
	.byte $1d, $20, $23, $26, $29, $2c, $2f, $32
	.byte $35, $38, $3c, $41, $4b, $50, $5a, $64
