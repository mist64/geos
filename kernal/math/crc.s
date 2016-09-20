; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Math library: CRC syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import Ddec

.global _CRC

.segment "math2"

;---------------------------------------------------------------
; CRC                                                     $C20E
;
; Function:  CRC performs a checksum on specified data
;
; Pass:      r0  ptr to data
;            r1  nbr of bytes to check
; Return:    r2  checksum
; Destroyed: a, x, y, r0, r1, r3l
;---------------------------------------------------------------
_CRC:
	ldy #$ff
	sty r2L
	sty r2H
	iny
@1:	lda #$80
	sta r3L
@2:	asl r2L
	rol r2H
	lda (r0),y
	and r3L
	bcc @3
	eor r3L
@3:	beq @4
	lda r2L
	eor #$21
	sta r2L
	lda r2H
	eor #$10
	sta r2H
@4:	lsr r3L
	bcc @2
	iny
	bne @5
	inc r0H
@5:	ldx #r1
	jsr Ddec
	lda r1L
	ora r1H
	bne @1
	rts
