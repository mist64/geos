; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Back bank IRQ and NMI handlers

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "c64.inc"

.segment "irq_back"

.global _NMIHandler
.global _IRQHandler128

_IRQHandler128:
	cld
	pha
	START_IO_128
	PushB rcr
	and #$F0
	sta rcr
	nop ; front version says "jsr _IRQHandler" here
	nop
	nop
	PopB rcr
	END_IO_128
	pla
_NMIHandler:
	rti
