; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Back bank vectors

.include "config.inc"

.import _NMIHandler
.import _IRQHandler128

.segment "vectors_back"

	.word _NMIHandler ; NMI
	.word _NMIHandler ; RESET
	.word _IRQHandler128 ; IRQ

