; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Front bank IRQ and NMI handlers

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "c64.inc"

.segment "irq_front"

.import _IRQHandler

.global _NMIHandler
.global _IRQHandler128

_IRQHandler128:
	cld
	pha
	START_IO_128
	PushB rcr
	and #%11110000
	sta rcr
	jsr _IRQHandler
	PopB rcr
	END_IO_128
	pla
_NMIHandler:
	rti
