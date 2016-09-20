; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: Sleep, DoExecDelay, RemoveDelay syscalls

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

.global _Sleep
.global _DoExecDelay
.global _RemoveDelay

.segment "process3c"

.ifndef wheels_size
_DoExecDelay:
	inc r0L
	bne @1
	inc r0H
@1:	jmp (r0)
.endif

_RemoveDelay:
	php
	sei
@1:	inx
	cpx DelaySP
	beq @2
	lda DelayValL,x
	sta DelayValL-1,x
	lda DelayValH,x
	sta DelayValH-1,x
	lda DelayRtnsL,x
	sta DelayRtnsL-1,x
	lda DelayRtnsH,x
	sta DelayRtnsH-1,x
	bra @1
@2:	dec DelaySP
	plp
	rts

;---------------------------------------------------------------
; Sleep                                                   $C199
;
; Pass:      r0  time to sleep in 16th of a second
; Return:    to previous routine
; Destroyed: depends & 20 sleep max will be handle
;---------------------------------------------------------------
_Sleep:
	php
	pla
	tay
	sei
	ldx DelaySP
	lda r0L
	sta DelayValL,x
	lda r0H
	sta DelayValH,x
	pla
	sta DelayRtnsL,x
	pla
	sta DelayRtnsH,x
	inc DelaySP
	tya
	pha
	plp
	rts
