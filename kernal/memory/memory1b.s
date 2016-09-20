; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Memory utility functions: InitRam

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _InitRam

.segment "memory1b"

;---------------------------------------------------------------
; InitRam                                                 $C181
;
; Pass:      r0  ptr to initialization table
;                .word location
;                .byte nbr of bytes
;                .byte value1, value2, ... value n
;                .word new location
;                etc. ,0,0
; Return:    memory initialize
; Destroyed: a, x, y, r0 - r1
;---------------------------------------------------------------
_InitRam:
	ldy #0
	lda (r0),Y
	sta r1L
	iny
	ora (r0),Y
	beq @4
	lda (r0),Y
	sta r1H
	iny
	lda (r0),Y
	sta r2L
	iny
@1:	tya
	tax
	lda (r0),Y
	ldy #0
	sta (r1),Y
	inc r1L
	bne @2
	inc r1H
@2:	txa
	tay
	iny
	dec r2L
	bne @1
	tya
	add r0L
	sta r0L
.ifdef wheels
	bcc _InitRam
.else
	bcc @3
.endif
	inc r0H
@3:
.ifdef wheels
	bne _InitRam
.else
	bra _InitRam
.endif
@4:	rts

