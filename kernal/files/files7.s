; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global SerialHiCompare

.segment "files7"

.ifdef trap1
SerialHiCompare:
.ifdef cbmfiles
	; This should be initialized to 0, and will
	; be changed at runtime.
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it has a pre-filled value here.
	.byte $58
.elseif .defined(bsw128)
	.byte $fd
.else
	.byte 0
.endif
.endif

