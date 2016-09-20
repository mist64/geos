; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Loading

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global DeskTopName
.global _EnterDT_Str1
.global _EnterDT_Str0

.segment "load1c"

DeskTopName:
.ifdef bsw128
	.byte "128 DESKTOP", 0
.elseif .defined(gateway)
	.byte "GATEWAY", 0
	.byte 0 ; PADDING
.elseif .defined(wheels)
	.byte "DESKTOP", 0
	.byte 0 ; PADDING
.else
	.byte "DESK TOP", 0
.endif

.segment "load1d"

_EnterDT_Str0:
.ifdef bsw128
	.byte BOLDON, "Please insert a disk with the", 0
.else
	.byte BOLDON, "Please insert a disk", 0
.endif
_EnterDT_Str1:
.ifndef bsw128
	.byte "with "
.endif
.ifdef bsw128
	.byte "128 DESKTOP"
.elseif .defined(gateway)
	.byte "gateWay"
.else
	.byte "deskTop"
.endif
	.byte " V"
.ifdef bsw128
	.byte "2.0"
.elseif .defined(wheels)
	.byte "3.0"
.else
	.byte "1.5"
.endif
	.byte " or higher", 0
