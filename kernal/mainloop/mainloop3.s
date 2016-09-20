; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Main Loop

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import __GetRandom
.import ProcessCursor
.import __ProcessDelays
.import __ProcessTimers
.import ProcessMouse


.global _InterruptMain

.segment "mainloop3"

;---------------------------------------------------------------
;---------------------------------------------------------------
_InterruptMain:
.ifndef bsw128
	jsr ProcessMouse
.endif
	jsr __ProcessTimers
	jsr __ProcessDelays
	jsr ProcessCursor
	jmp __GetRandom
