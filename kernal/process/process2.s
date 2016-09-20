; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: ProcessTimers syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import RProc0
.import TimersTab
.import TimersCMDs
.import NumTimers

.ifdef wheels
.import EnableProcess
.endif

.global _ProcessTimers

.segment "process2"

;---------------------------------------------------------------
; called from main loop
;---------------------------------------------------------------
_ProcessTimers:
	lda #0
	tay
	tax
	cmp NumTimers
	beq @4
@1:	lda TimersCMDs,x
	and #SET_FROZEN | SET_NOTIMER
	bne @3
	lda TimersTab,Y
	bne @2
	pha
	lda TimersTab+1,Y
	subv 1
	sta TimersTab+1,Y
	pla
@2:	subv 1
	sta TimersTab,Y
	ora TimersTab+1,Y
	bne @3
	jsr RProc0
.ifdef wheels_size
	jsr EnableProcess
.else
	lda TimersCMDs,x
	ora #SET_RUNABLE
	sta TimersCMDs,x
.endif
@3:	iny
	iny
	inx
	cpx NumTimers
	bne @1

@4:
.ifdef wheels_screensaver
	lda saverStatus
	and #$30
	bne @Y
	jsr @Z
	beq @Y
	lda saverTimer
	bne @X
	dec $88B6
@X:	dec saverTimer
	jsr @Z
	bne @Y
	lda saverStatus
	ora #$80
	sta saverStatus
@Y:	rts

@Z:	lda saverTimer
	ora $88B6
.endif
	rts

