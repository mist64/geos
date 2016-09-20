; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Graphics library: 480px width helper

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "graph2p"

; in:  r3       left X coord
;      r5, r6   line address
; out: r5, r6   card address
;      X        bit number
.global GetLeftXAddress
GetLeftXAddress:
	PushB r3H
	lda r3L
	and #$07
	pha
	lda r3L
	lsr r3H
	ror a
	lsr r3H
	ror a
	lsr r3H
	ror a
	clc
	adc r5L
	sta r5L
	sta r6L
	php
	lda r5H
	adc r3H
	sta r5H
	plp
	lda r6H
	adc r3H
	sta r6H
	pla
	tax
	PopB r3H
	rts
