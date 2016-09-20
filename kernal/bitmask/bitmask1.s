; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Common bitmasks

.include "config.inc"

.import BitMaskPow2

.global BitMaskPow2Rev

.segment "bitmask1"

BitMaskPow2Rev:
	.byte %10000000
	.byte %01000000
	.byte %00100000
	.byte %00010000
	.byte %00001000
	.byte %00000100
	.byte %00000010
	;     %00000001 shared with below

.assert * = BitMaskPow2, error, "BitMaskPow2Rev must run into BitMaskPow2"

