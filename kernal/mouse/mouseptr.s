; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Mouse pointer image

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global InitMsePic

.segment "mouseptr"

InitMsePic:
	.byte %11111100, %00000000, %00000000
	.byte %11111000, %00000000, %00000000
	.byte %11110000, %00000000, %00000000
	.byte %11111000, %00000000, %00000000
	.byte %11011100, %00000000, %00000000
	.byte %10001110, %00000000, %00000000
	.byte %00000111, %00000000, %00000000
	.byte %00000011, %00000000, %00000000

