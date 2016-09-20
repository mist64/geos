; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: DoExecDelay, RemoveDelay syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DelayRtnsL
.import DelayRtnsH
.import DelayValH
.import DelayValL
.import DelaySP
.import _DoExecDelay
.import _RemoveDelay

.global _DoCheckDelays

.segment "process3b"

_DoCheckDelays:
	ldx DelaySP
	beq @3
	dex
@1:	lda DelayValL,x
	ora DelayValH,x
	bne @2
	lda DelayRtnsH,x
	sta r0H
	lda DelayRtnsL,x
	sta r0L
	txa
	pha
	jsr _RemoveDelay
.ifdef wheels_size ; code reuse
.import IncR0JmpInd
	jsr IncR0JmpInd
.else
	jsr _DoExecDelay
.endif
	pla
	tax
@2:	dex
	bpl @1
@3:	rts
