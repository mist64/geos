; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Koala pad input driver

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
SetMouse:

dat0:
	.byte 0
dat1:
	.byte 0
dat2:
	.byte 0
dat3:
	.byte 0
dat4:
	.byte 0
dat5:
	.byte 0
dat6:
	.byte 0
dat7:
	.byte 0

_MouseInit:
	lda #$00
	sta $3b
	lda #$08
	sta $3a
	sta $3c
	rts

_SlowMouse:
	bit $30
	bmi _UpdateMouse
	jmp $ff36

_08a2:
_UpdateMouse:
	lda $01
	pha
	lda #$35
	sta $01
	lda $dc02
	pha
	lda $dc03
	pha
	lda $dc00
	pha
	jsr $ff37
	lda $fe8e
	eor #$ff
	sta $fe8e
	bne _0927
	jsr $ff5b
	lda $d419
	sec
	sbc #$1f
	bcs _08cf
	lda #$00
_08cf:
	sta $02
	lsr $02
	lsr $02
	lsr $02
	sec
	sbc $02
	cmp #$0c
	bcc _0927
	cmp #$ab
	beq _08e4
	bcs _0927
_08e4:
	sta $02
	lda $d41a
	cmp #$32
	bcc _0927
	cmp #$f9
	beq _08f3
	bcs _0927
_08f3:
	sta $03
	lda $84b7
	beq _08fd
	jsr $ff6d
_08fd:
	lda #$00
	sta $fe8f
	lda $02
	ldx $fe8a
	ldy $fe8c
	jsr $ffb1
	sty $fe8c
	stx $fe8a
	lda $03
	ldx $fe8b
	ldy $fe8d
	jsr $ffb1
	sty $fe8d
	stx $fe8b
	jsr $ff85
_0927:
	pla
	sta $dc00
	pla
	sta $dc03
	pla
	sta $dc02
	pla
	sta $01
	rts

_0937:
	lda #$00
	sta $dc02
	sta $dc03
	lda $dc01
	and #$04
	cmp $fe89
	beq _095a
	sta $fe89
	asl a
	asl a
	asl a
	asl a
	asl a
	sta $8505
	lda $39
	ora #$20
	sta $39
_095a:
	rts

_095b:
	lda #$ff
	sta $dc02
	lda #$40
	sta $dc00
	ldx #$6e
_0967:
	nop
	nop
	dex
	bne _0967
	rts

_096d:
	lda $3b
	sta $04
	lda $3a
	ror $04
	ror a
	clc
	adc #$0c
	sta $fe8a
	lda $3c
	clc
	adc #$32
	sta $fe8b
	rts

_0985:
	bit $fe8f
	bmi _09b0
	ldx #$00
	lda $fe8a
	asl a
	bcc _0993
	inx
_0993:
	stx $3b
	and #$fe
	sta $3a
	sec
	lda $3a
	sbc #$18
	sta $3a
	lda $3b
	sbc #$00
	sta $3b
	lda $fe8b
	sec
	sbc #$32
	and #$fe
	sta $3c
_09b0:
	rts

_09b1:
	stx $02
	tax
	sec
	sbc $02
	sta $02
	bpl _09c0
	eor #$ff
	clc
	adc #$01
_09c0:
	cmp #$06
	bcc _09cd
	lda #$80
	ora $fe8f
	sta $fe8f
	rts
_09cd:
	rts

_09ce:
	tya
	ldy $02
	bmi _09db
	beq _09e7
	cmp #$00
	bpl _09e7
	bmi _09df
	cmp #$00
_09db:
	bmi _09e7
_09df:
	lda #$80
	ora $fe8f
	sta $fe8f
_09e7:
	rts

