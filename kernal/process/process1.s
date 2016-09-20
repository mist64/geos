; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: InitProcesses, ExecuteProcesses syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import TimersVals
.import TimersRtns
.import TimersCMDs
.import NumTimers

.global _InitProcesses
.global _ExecuteProcesses

.segment "process1"

;---------------------------------------------------------------
; InitProcesses                                           $C103
;
; Pass:      a   nbr of process to initialize. 20 max
;            r0  ptr to process table
; Return:    process initialized
; Destroyed: a, x, y
;            ex: .word  processRout1
;                .word  time/60th sec
;                .word  processRout2 etc...
;---------------------------------------------------------------
_InitProcesses:
	ldx #0
	stx NumTimers
	sta r1L
	sta r1H
	tax
	lda #SET_FROZEN
@1:	sta TimersCMDs-1,x
	dex
	bne @1
	ldy #0
@2:	lda (r0),Y
	sta TimersRtns,x
	iny
	lda (r0),Y
	sta TimersRtns+1,x
	iny
	lda (r0),Y
	sta TimersVals,x
	iny
	lda (r0),Y
	sta TimersVals+1,x
	iny
	inx
	inx
	dec r1H
	bne @2
	MoveB r1L, NumTimers
	rts

;---------------------------------------------------------------
; called from main loop
;---------------------------------------------------------------
_ExecuteProcesses:
	ldx NumTimers
	beq @3
	dex
@1:	lda TimersCMDs,x
	bpl @2
	and #SET_BLOCKED
	bne @2
	lda TimersCMDs,x
	and #SET_RUNABLE ^ $ff
	sta TimersCMDs,x
	txa
	pha
	asl
	tax
	lda TimersRtns,x
	sta r0L
	lda TimersRtns+1,x
	sta r0H
.ifdef wheels_size ; code reuse
.import JmpR0Ind
	jsr JmpR0Ind
.else
	jsr @4
.endif
	pla
	tax
@2:	dex
	bpl @1
@3:	rts
.ifndef wheels_size ; code reuse
@4:	jmp (r0)
.endif

