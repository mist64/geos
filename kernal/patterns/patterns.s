; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Patterns

.global PatternTab

.segment "patterns"

; There are 34 patterns. Only the first 32 are
; accessible from geoPaint.
PatternTab:
	; 0
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000
	.byte %00000000

	; 1
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111
	.byte %11111111

	; 2
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101
	.byte %10101010
	.byte %01010101

	; 3
	.byte %10011001
	.byte %01000010
	.byte %00100100
	.byte %10011001
	.byte %10011001
	.byte %00100100
	.byte %01000010
	.byte %10011001

	; 4
	.byte %11111011
	.byte %11110101
	.byte %11111011
	.byte %11110101
	.byte %11111011
	.byte %11110101
	.byte %11111011
	.byte %11110101

	; 5
	.byte %10001000
	.byte %00100010
	.byte %10001000
	.byte %00100010
	.byte %10001000
	.byte %00100010
	.byte %10001000
	.byte %00100010

	; 6
	.byte %01110111
	.byte %11011101
	.byte %01110111
	.byte %11011101
	.byte %01110111
	.byte %11011101
	.byte %01110111
	.byte %11011101

	; 7
	.byte %10001000
	.byte %00000000
	.byte %00100010
	.byte %00000000
	.byte %10001000
	.byte %00000000
	.byte %00100010
	.byte %00000000

	; 8
	.byte %01110111
	.byte %11111111
	.byte %11011101
	.byte %11111111
	.byte %01110111
	.byte %11111111
	.byte %11011101
	.byte %11111111

	; 9
	.byte %11111111
	.byte %00000000
	.byte %11111111
	.byte %00000000
	.byte %11111111
	.byte %00000000
	.byte %11111111
	.byte %00000000

	; 10
	.byte %01010101
	.byte %01010101
	.byte %01010101
	.byte %01010101
	.byte %01010101
	.byte %01010101
	.byte %01010101
	.byte %01010101

	; 11
	.byte %00000001
	.byte %00000010
	.byte %00000100
	.byte %00001000
	.byte %00010000
	.byte %00100000
	.byte %01000000
	.byte %10000000

	; 12
	.byte %10000000
	.byte %01000000
	.byte %00100000
	.byte %00010000
	.byte %00001000
	.byte %00000100
	.byte %00000010
	.byte %00000001

	; 13
	.byte %11111110
	.byte %11111101
	.byte %11111011
	.byte %11110111
	.byte %11101111
	.byte %11011111
	.byte %10111111
	.byte %01111111

	; 14
	.byte %01111111
	.byte %10111111
	.byte %11011111
	.byte %11101111
	.byte %11110111
	.byte %11111011
	.byte %11111101
	.byte %11111110

	; 15
	.byte %11111111
	.byte %10001000
	.byte %10001000
	.byte %10001000
	.byte %11111111
	.byte %10001000
	.byte %10001000
	.byte %10001000

	; 16
	.byte %11111111
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %10000000

	; 17
	.byte %11111111
	.byte %10000000
	.byte %10000000
	.byte %10000000
	.byte %11111111
	.byte %00001000
	.byte %00001000
	.byte %00001000

	; 18
	.byte %00001000
	.byte %00011100
	.byte %00100010
	.byte %11000001
	.byte %10000000
	.byte %00000001
	.byte %00000010
	.byte %00000100

	; 19
	.byte %10001000
	.byte %00010100
	.byte %00100010
	.byte %01000001
	.byte %10001000
	.byte %00000000
	.byte %10101010
	.byte %00000000

	; 20
	.byte %10000000
	.byte %01000000
	.byte %00100000
	.byte %00000000
	.byte %00000010
	.byte %00000100
	.byte %00001000
	.byte %00000000

	; 21
	.byte %01000000
	.byte %10100000
	.byte %00000000
	.byte %00000000
	.byte %00000100
	.byte %00001010
	.byte %00000000
	.byte %00000000

	; 22
	.byte %10000010
	.byte %01000100
	.byte %00111001
	.byte %01000100
	.byte %10000010
	.byte %00000001
	.byte %00000001
	.byte %00000001

	; 23
	.byte %00000011
	.byte %10000100
	.byte %01001000
	.byte %00110000
	.byte %00001100
	.byte %00000010
	.byte %00000001
	.byte %00000001

	; 24
	.byte %11111000
	.byte %01110100
	.byte %00100010
	.byte %01000111
	.byte %10001111
	.byte %00010111
	.byte %00100010
	.byte %01110001

	; 25
	.byte %10000000
	.byte %10000000
	.byte %01000001
	.byte %00111110
	.byte %00001000
	.byte %00001000
	.byte %00010100
	.byte %11100011

	; 26
	.byte %01010101
	.byte %10100000
	.byte %01000000
	.byte %01000000
	.byte %01010101
	.byte %00001010
	.byte %00000100
	.byte %00000100

	; 27
	.byte %00010000
	.byte %00100000
	.byte %01010100
	.byte %10101010
	.byte %11111111
	.byte %00000010
	.byte %00000100
	.byte %00001000

	; 28
	.byte %00100000
	.byte %01010000
	.byte %10001000
	.byte %10001000
	.byte %10001000
	.byte %10001000
	.byte %00000101
	.byte %00000010

	; 29
	.byte %01110111
	.byte %10001001
	.byte %10001111
	.byte %10001111
	.byte %01110111
	.byte %10011000
	.byte %11111000
	.byte %11111000

	; 30
	.byte %10111111
	.byte %00000000
	.byte %10111111
	.byte %10111111
	.byte %10110000
	.byte %10110000
	.byte %10110000
	.byte %10110000

	; 31
	.byte %00000000
	.byte %00001000
	.byte %00010100
	.byte %00101010
	.byte %01010101
	.byte %00101010
	.byte %00010100
	.byte %00001000

	; 32
	.byte %10110001
	.byte %00110000
	.byte %00000011
	.byte %00011011
	.byte %11011000
	.byte %11000000
	.byte %00001100
	.byte %10001101

	; 33
	.byte %10000000
	.byte %00010000
	.byte %00000010
	.byte %00100000
	.byte %00000001
	.byte %00001000
	.byte %01000000
	.byte %00000100
