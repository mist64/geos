; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Common bitmasks

.include "config.inc"

.global BitMaskLeadingSet
.global BitMaskLeadingClear

.segment "bitmask3"

BitMaskLeadingSet:
	.byte %00000000
	.byte %10000000
	.byte %11000000
	.byte %11100000
	.byte %11110000
	.byte %11111000
	.byte %11111100
	.byte %11111110
BitMaskLeadingClear:
	.byte %01111111
	.byte %00111111
	.byte %00011111
	.byte %00001111
	.byte %00000111
	.byte %00000011
	.byte %00000001
	.byte %00000000
