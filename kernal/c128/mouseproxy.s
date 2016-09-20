; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; C128: $FE80 mouse proxy jump table for GEOS64 compatibility

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "inputdrv.inc"

.segment "mouseproxy"


	jmp MouseInit_128
	jmp SlowMouse_128
	jmp UpdateMouse_128
	jmp SetMouse_128
	jmp MouseInit_128 + 12 ; XXX ???
