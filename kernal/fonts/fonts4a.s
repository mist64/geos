; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Font drawing: indirect jump helper

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "fonts4a"

.global FntIndirectJMP

FntIndirectJMP:
	ldy #0
	jmp (r13)

