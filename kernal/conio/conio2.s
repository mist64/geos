; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: i_PutString syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _PutString

.global _i_PutString

.segment "conio2"

_i_PutString:
	PopB r0L
	pla
	inc r0L
	bne @1
	addv 1
@1:	sta r0H
	ldy #0
	lda (r0),y
	inc r0L
	bne @2
	inc r0H
@2:	sta r11L
	lda (r0),y
	inc r0L
	bne @3
	inc r0H
@3:	sta r11H
	lda (r0),y
	inc r0L
	bne @4
	inc r0H
@4:	sta r1H
	jsr _PutString
	inc r0L
	bne @5
	inc r0H
@5:	jmp (r0)

