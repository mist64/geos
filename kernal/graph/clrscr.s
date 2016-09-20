; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: ClrScr

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "graph1"

.import i_Rectangle
.import SetPattern

.global ClrScr

.ifndef wheels
;---------------------------------------------------------------
; used by EnterDesktop
;---------------------------------------------------------------
ClrScr:
.ifdef bsw128
	LoadB dispBufferOn, ST_WR_FORE | ST_WR_BACK
	bbsf 7, graphMode, @4
	LoadB r0L, 0
	sta r1L
	LoadB r0H, >SCREEN_BASE
	LoadB r1H, >BACK_SCR_BASE
.else
	LoadW r0, SCREEN_BASE
	LoadW r1, BACK_SCR_BASE
.endif
	ldx #$7D
@1:	ldy #$3F
@2:	lda #backPattern1
	sta (r0),Y
	sta (r1),Y
	dey
	lda #backPattern2
	sta (r0),Y
	sta (r1),Y
	dey
	bpl @2
.ifdef bsw128
	AddVB 64, r0L
	sta r1L
	bcc @3
	inc r0H
	inc r1H
@3:
.else
	AddVW 64, r0
	AddVW 64, r1
.endif
	dex
	bne @1
	rts

.ifdef bsw128
@4:	lda #2
	jsr SetPattern
	jsr i_Rectangle
	.byte 0   ; y1
	.byte SC_PIX_HEIGHT-1 ; y2
	.word 0   ; x1
	.word SCREENPIXELWIDTH-1 ; x2
	rts
.endif

.endif
