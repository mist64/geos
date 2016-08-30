; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; Wheels additions

.include "config.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"


.segment "wheels1"

.if wheels
.global _GEOSOptimize, _DEFOptimize, _DoOptimize
_GEOSOptimize:
	ldy #0 ; enable GEOS optimization
	.byte $2c
_DEFOptimize:
	ldy #3 ; disable all optimizations
_DoOptimize:
	php
	sei
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, $35
	sta scpu_hwreg_enable
	sta scpu_base,y
	sta scpu_hwreg_disable
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	plp
	rts
.endif


