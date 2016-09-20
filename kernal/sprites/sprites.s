; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/VIC-II sprite driver

.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"

; bitmask.s
.import BitMaskPow2

.import scr_mobx

.import NormalizeX

; syscalls
.global _DisablSprite
.global _DrawSprite
.global _EnablSprite
.global _PosSprite

.segment "sprites"

;---------------------------------------------------------------
; DrawSprite                                              $C1C6
;
; Pass:      r3L sprite nbr (2-7)
;            r4  ptr to picture data
; Return:    graphic data transfer to VIC chip
; Destroyed: a, y, r5
;---------------------------------------------------------------
_DrawSprite:
	ldy r3L
	lda SprTabL,Y
	sta r5L
	lda SprTabH,Y
	sta r5H
	ldy #63
@1:	lda (r4),Y
	sta (r5),Y
	dey
	bpl @1
	rts

.define SprTab spr0pic, spr1pic, spr2pic, spr3pic, spr4pic, spr5pic, spr6pic, spr7pic
SprTabL:
	.lobytes SprTab
SprTabH:
	.hibytes SprTab

;---------------------------------------------------------------
; PosSprite                                               $C1CF
;
; Pass:      r3L sprite nbr (0-7)
;            r4  x pos (0-319)
;            r5L y pos (0-199)
; Return:    r3L unchanged
; Destroyed: a, x, y, r6
;---------------------------------------------------------------
_PosSprite:
.ifdef bsw128
	ldx #r4
	jsr NormalizeX
.endif
	START_IO
	lda r3L
	asl
	tay
	lda r5L
	addv VIC_Y_POS_OFF
	sta mob0ypos,Y
.ifdef bsw128
	lda graphMode
	bpl @X
	lda r4H
	sta scr_mobx+1,y
	lsr a
	sta r4H
	lda r4L
	sta scr_mobx,y
	ror a
	sta r4L
@X:
.endif
	lda r4L
	addv VIC_X_POS_OFF
	sta r6L
	lda r4H
	adc #0
	sta r6H
	lda r6L
	sta mob0xpos,Y
	ldx r3L
	lda BitMaskPow2,x
	eor #$FF
	and msbxpos
	tay
	lda #1
	and r6H
	beq @1
	tya
	ora BitMaskPow2,x
	tay
@1:	sty msbxpos
	END_IO
	rts

;---------------------------------------------------------------
; EnablSprite                                             $C1D2
;
; Pass:      r3L sprite nbr (0-7)
; Return:    sprite activated
; Destroyed: a, x
;---------------------------------------------------------------
.ifdef wheels_size
_EnablSprite:
	sec
	bcs EnablSpriteCommon
_DisablSprite:
	clc
EnablSpriteCommon:
	START_IO
	ldx r3L
	lda BitMaskPow2,x
	bcs @1
	eor #$FF
	and mobenble
	bra @2
@1:	ora mobenble
@2:	sta mobenble
	END_IO
        rts
.else
_EnablSprite:
	ldx r3L
	lda BitMaskPow2,x
	tax
	; XXX On C128, the "tax"/"txa" is a no-op
	START_IO
	txa
	ora mobenble
	sta mobenble
	END_IO
	rts

;---------------------------------------------------------------
; DisablSprite                                            $C1D5
;
; Pass:      r3L sprite nbr (0-7)
; Return:    VIC register set to disable
;            sprite.
; Destroyed: a, x
;---------------------------------------------------------------
_DisablSprite:
	ldx r3L
	lda BitMaskPow2,x
	eor #$FF
	pha ; XXX on C128, the "pha"/"pla" is a no-op
	START_IO_X
	pla
	and mobenble
	sta mobenble
	END_IO_X
	rts
.endif
