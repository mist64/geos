; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Font drawing

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import FontTab

.global FntShJump
.ifndef bsw128
.global noop
.endif

.segment "fonts4"

FntShJump:
	sta Z45
.ifdef bsw128
	bbsf BOLD_BIT, currentMode, @X
	rts
@X:
.else
	bbrf BOLD_BIT, currentMode, noop
.endif
	lda #0
	pha
	ldy #$ff
@5:
	iny
	ldx Z45,y
	pla
	ora FontTab,x
	sta Z45,y
	txa
	lsr
	lda #0
	ror
	pha
	cpy r8L
	bne @5
	pla
.ifndef bsw128
noop:
.endif
	rts
