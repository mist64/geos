; GEOS KERNAL
;
; Common bitmasks

.global BitMaskPow2Rev
.global BitMaskPow2
.global BitMaskLeadingSet
.global BitMaskLeadingClear

.segment "bitmask"

BitMaskPow2Rev:
	.byte %10000000
	.byte %01000000
	.byte %00100000
	.byte %00010000
	.byte %00001000
	.byte %00000100
	.byte %00000010
BitMaskPow2:
	.byte %00000001
	.byte %00000010
	.byte %00000100
	.byte %00001000
	.byte %00010000
	.byte %00100000
	.byte %01000000
	.byte %10000000
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
