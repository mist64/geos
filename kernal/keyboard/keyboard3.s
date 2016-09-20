; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/C128 keyboard driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import KbdQueHead
.import KbdQueue
.import KbdQueTail

.global KbdScanHelp2
.global KbdScanHelp3
.global KbdScanHelp5
.global KbdScanHelp6
.global _GetNextChar

.segment "keyboard3"

KbdScanHelp2:
	php
	sei
	pha
	smbf KEYPRESS_BIT, pressFlag
	ldx KbdQueTail
	pla
	sta KbdQueue,x
	jsr KbdScanHelp4
	cpx KbdQueHead
	beq @1
	stx KbdQueTail
@1:	plp
	rts

KbdScanHelp3:
	php
	sei
	ldx KbdQueHead
	lda KbdQueue,x
	sta keyData
	jsr KbdScanHelp4
	stx KbdQueHead
	cpx KbdQueTail
	bne @2
	rmb KEYPRESS_BIT, pressFlag
@2:	plp
	rts

KbdScanHelp4:
	inx
	cpx #16
	bne @1
	ldx #0
@1:	rts

;---------------------------------------------------------------
;---------------------------------------------------------------
_GetNextChar:
	bbrf KEYPRESS_BIT, pressFlag, @1
	jmp KbdScanHelp3
@1:	lda #0
	rts

KbdScanHelp5:
	LoadB cia1base+0, %11111101
	lda cia1base+1
.ifdef wheels_size_and_speed
	and #%10000000
	beq @1
.else
	eor #$ff
	and #%10000000
	bne @1
.endif
	LoadB cia1base+0, %10111111
	lda cia1base+1
.ifdef wheels_size_and_speed
	and #%00010000
	bne @2
.else
	eor #$ff
	and #%00010000
	beq @2
.endif
.ifdef wheels_size
@1:	lda #$80
	.byte $2c
@2:	lda #$00
	sta r1H
.else
@1:	smbf 7, r1H
@2:
.endif
	LoadB cia1base+0, %01111111

	lda cia1base+1
.ifdef wheels_size_and_speed
	and #%00100000
	bne @3
.else
	eor #$ff
	and #%00100000
	beq @3
.endif
	smbf 6, r1H
@3:
.ifndef wheels
	LoadB cia1base+0, %01111111
.endif
	lda cia1base+1
.ifdef wheels_size_and_speed
	and #%00000100
	bne @4
.else
	eor #$ff
	and #%00000100
	beq @4
.endif
	smbf 5, r1H
@4:
.ifdef wheels_expose_mod_keys
.import modKeyCopy
	lda r1H
	sta modKeyCopy
.endif
	rts

KbdScanHelp6:
	pha
	and #%01111111
	cmp #'a'
	bcc @1
	cmp #'z'+1
	bcs @1
	pla
.ifdef wheels_size_and_speed
	and #$DF
	rts
.else
	subv $20
	pha
.endif
@1:	pla
	rts
