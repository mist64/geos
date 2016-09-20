; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: ProcessDelays syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DelayValH
.import DelayValL
.import DelaySP

.global _ProcessDelays

.segment "process3aa"

_ProcessDelays:
	ldx DelaySP
	beq @4
	dex
@1:	lda DelayValL,x
	bne @2
	ora DelayValH,x
	beq @3
	dec DelayValH,x
@2:	dec DelayValL,x
@3:	dex
	bpl @1
@4:	rts
