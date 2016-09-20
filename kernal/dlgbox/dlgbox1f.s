; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Dialog box: sysopv

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DBStringFaultVec

.global DBDoSYSOPV

.segment "dlgbox1f"

DBDoSYSOPV:
	LoadW otherPressVec, DBStringFaultVec
	rts

