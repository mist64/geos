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

.import _MainLoop

.global _MainLoop2

.segment "mainloop2"

.if (!.defined(wheels)) && (!.defined(bsw128))
_MainLoop2:
	START_IO_X
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	END_IO_X
	jmp _MainLoop
.endif

