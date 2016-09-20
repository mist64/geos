; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; C128 jump table at $9D80

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _CallNoRAMSharing
.import _MainLoop

.global __MainLoop

.segment "low_jmptab"

CallNoRAMSharing:
	jmp _CallNoRAMSharing

__MainLoop:
	jmp _MainLoop

