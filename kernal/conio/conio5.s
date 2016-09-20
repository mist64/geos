; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: PromptOn, PromptOff, InitTextPrompt syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _DisablSprite
.import _EnablSprite
.import _PosSprite
.ifdef bsw128
; XXX back bank, yet var lives on front bank!
L881A = $881A
.endif

.global _PromptOn
.global _PromptOff
.global _InitTextPrompt

.segment "conio5"

.ifdef bsw128
_PromptOn:
	ldx #$80
	lda alphaFlag
	ora #%01000000
	bne PrmptOff1
_PromptOff:
	ldx #$40
	lda alphaFlag
	and #%10111111
PrmptOff1:
	stx L881A
	and #%11000000
	ora #%00111100
	sta alphaFlag
	rts
.else
_PromptOn:
	lda #%01000000
	ora alphaFlag
	sta alphaFlag
	LoadB r3L, 1
	MoveW stringX, r4
	MoveB stringY, r5L
	jsr _PosSprite
	jsr _EnablSprite
	bra PrmptOff1
_PromptOff:
	lda #%10111111
	and alphaFlag
	sta alphaFlag
	LoadB r3L, 1
	jsr _DisablSprite
PrmptOff1:
	lda alphaFlag
	and #%11000000
	ora #%00111100
	sta alphaFlag
	rts
.endif

_InitTextPrompt:
	tay
	START_IO
	MoveB mob0clr, mob1clr
	lda moby2
	and #%11111101
	sta moby2
	tya
	pha
	LoadB alphaFlag, %10000011
	ldx #64
	lda #0
@1:	sta spr1pic-1,x
	dex
	bne @1
	pla
	tay
.ifdef bsw128
	cpy #42
	bcc @X
	ldy #42
@X:
.endif
	cpy #21
	bcc @2
	beq @2
	tya
	lsr
	tay
	lda moby2
	ora #2
	sta moby2
@2:
.ifdef bsw128
	tya
	ora #$80
	sta L8A7F
.endif
	lda #%10000000
@3:	sta spr1pic,x
	inx
	inx
	inx
	dey
.ifdef bsw128 ; fix: copied 1 byte too many
	bne @3
.else
	bpl @3
.endif
	END_IO
	rts

