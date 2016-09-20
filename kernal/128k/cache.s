; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Disk track cache for 128K+ systems

.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"

.import _DoBOp

.global _AccessCache

.segment "cache"

;---------------------------------------------------------------
; AccessCache                                             $C2EF
;
; Pass: r4   Source address in bank 1
;       r1h  Dir. sector (0-20)
;       y    DoBOp code  0 - save
; 	 	         1 - read
; 	 	         2 - swap
; 	 	         3 - verify
;                        or $FF to reset all pointers
; Return:    access dir. cache buffer in bank 00
; Destroyed: a, x, y +
;---------------------------------------------------------------
_AccessCache:
	ldx #8
@1:	lda r0-1,x
	sta AccCacheSv0p-1,x
	dex
	bne @1
	tya
	cmp #$FF
	beq @2
	pha
	lda #>TRACK_CACHE
	clc
	adc r1H
	sta r1H
	ldy #$00
	sty r1L
	sty r2L
	sty r3H
	iny
	sty r2H
	sty r3L
	MoveW r4, r0
	pla
	tay
	jsr _DoBOp
	tay
	jsr @4
	tya
	rts
@2:	PushB config
	LoadB config, $3F
	LoadW r1, TRACK_CACHE
@3:	lda #0
	tay
	sta (r1),y
	iny
	sta (r1),y
	inc r1H
	CmpBI r1H, (>TRACK_CACHE)+$14
	bcc @3
	PopB config
@4:	ldx #8
@5:	lda AccCacheSv0p-1,x
	sta r0L-1,x
	dex
	bne @5
	rts

.byte 0, 0 ; ???

AccCacheSv0p:
	.byte $7b, $06, $12, $01, $57, $00, $ce, $05
