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
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	lda r3L
	asl
	tay
	lda r5L
	addv VIC_Y_POS_OFF
	sta mob0ypos,Y
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
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

;---------------------------------------------------------------
; EnablSprite                                             $C1D2
;
; Pass:      r3L sprite nbr (0-7)
; Return:    sprite activated
; Destroyed: a, x
;---------------------------------------------------------------
.if wheels
LC359 = $C359
_EnablSprite:
	sec                                     ; CCB1 38                       8
        bcs     LCCB5                           ; CCB2 B0 01                    ..
_DisablSprite:
	clc                                     ; CCB4 18                       .
LCCB5:  lda     $01                             ; CCB5 A5 01                    ..
        pha                                     ; CCB7 48                       H
        lda     #$35                            ; CCB8 A9 35                    .5
        sta     $01                             ; CCBA 85 01                    ..
        ldx     $08                             ; CCBC A6 08                    ..
        lda     LC359,x                         ; CCBE BD 59 C3                 .Y.
        bcs     LCCCB                           ; CCC1 B0 08                    ..
        eor     #$FF                            ; CCC3 49 FF                    I.
        and     $D015                           ; CCC5 2D 15 D0                 -..
        clv                                     ; CCC8 B8                       .
        bvc     LCCCE                           ; CCC9 50 03                    P.
LCCCB:  ora     $D015                           ; CCCB 0D 15 D0                 ...
LCCCE:  sta     $D015                           ; CCCE 8D 15 D0                 ...
        pla                                     ; CCD1 68                       h
        sta     $01                             ; CCD2 85 01                    ..
        rts                                     ; CCD4 60                       `
.else
_EnablSprite:
	ldx r3L
	lda BitMaskPow2,x
	tax
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	txa
	ora mobenble
	sta mobenble
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
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
	pha
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	pla
	and mobenble
	sta mobenble
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
.endif
