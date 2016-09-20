; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; CBM KERNAL jump table at $FF81
;
; This allows GEOS code on the front bank to call
; CBM KERNAL functions at their usual addresses.

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import CallCBMKERNAL

.segment "cbm_jmptab"

	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL
	jsr CallCBMKERNAL

; XXX ??? junk
	.byte $60, $EA
