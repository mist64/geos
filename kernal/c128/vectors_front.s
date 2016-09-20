; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; Back bank vectors

.include "config.inc"

.import _NMIHandler
.import _IRQHandler128

.global systemVectorMagic

.segment "vectors_front"

systemVectorMagic:
	.byte "CBM"

; The following code is located there:
; .,03E4 A9 7E     LDA #$7E
; .,03E6 8D 00 FF  STA $FF00
; .,03E9 4C 00 C0  JMP $C000 ; reboot GEOS
	.word $03E4

.word _NMIHandler ; NMI
.word _NMIHandler ; RESET
.word _IRQHandler128 ; IRQ
