; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking (processes, sleep, delays)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"

; var.s
.import DelayRtnsL
.import DelayRtnsH
.import DelayValH
.import DelayValL
.import DelaySP
.import TimersTab
.import TimersVals
.import TimersRtns
.import TimersCMDs
.import NumTimers

; called from main loop
.global _DoCheckDelays
.global _ExecuteProcesses
.global _ProcessDelays
.global _ProcessTimers

; syscalls
.global _BlockProcess
.global _EnableProcess
.global _FreezeProcess
.global _InitProcesses
.global _RestartProcess
.global _Sleep
.global _UnBlockProcess
.global _UnFreezeProcess

.segment "process"

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
	jsr @4
	pla
	tax
@2:	dex
	bpl @1
@3:	rts
@4:	jmp (r0)

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
	lda TimersCMDs,x
	ora #SET_RUNABLE
	sta TimersCMDs,x
@3:	iny
	iny
	inx
	cpx NumTimers
	bne @1
@4:	rts

;---------------------------------------------------------------
; RestartProcess                                          $C106
;
; Pass:      x   nbr of the process to restart
; Return:    resets a process timer
; Destroyed: a
;---------------------------------------------------------------
_RestartProcess:
	lda TimersCMDs,x
	and #(SET_BLOCKED | SET_FROZEN) ^ $ff
	sta TimersCMDs,x
RProc0:
	txa
	pha
	asl
	tax
	lda TimersVals,x
	sta TimersTab,x
	lda TimersVals+1,x
	sta TimersTab+1,x
	pla
	tax
	rts

;---------------------------------------------------------------
; EnableProcess                                           $C109
;
; Pass:      x   nbr of the process to have run
; Return:    process routine is run during next Main Loop
; Destroyed: a
;---------------------------------------------------------------
_EnableProcess:
	lda TimersCMDs,x
	ora #SET_RUNABLE
EnProc0:
	sta TimersCMDs,x
	rts

;---------------------------------------------------------------
; BlockProcess                                            $C10C
;
; Pass:      x   nbr of the process to block
; Destroyed: a
;---------------------------------------------------------------
_BlockProcess:
	lda TimersCMDs,x
	ora #SET_BLOCKED
	bra EnProc0
;---------------------------------------------------------------
; UnblockProcess                                          $C10F
;
; Pass:      x   nbr of the process to unblock
; Return:    process's flag reset, timer counting down
; Destroyed: a
;---------------------------------------------------------------
_UnBlockProcess:
	lda TimersCMDs,x
	and #SET_BLOCKED ^ $ff
	bra EnProc0
;---------------------------------------------------------------
; FreezeProcess                                           $C112
;
; Pass:      x   nbr of the process to freeze
; Return:    process freezed
; Destroyed: a
;---------------------------------------------------------------
_FreezeProcess:
	lda TimersCMDs,x
	ora #SET_FROZEN
	bra EnProc0
;---------------------------------------------------------------
; UnfreezeProcess                                         $C115
;
; Pass:      x   nbr of the process to unblock
; Return:    restart the process's timer
; Destroyed: a
;---------------------------------------------------------------
_UnFreezeProcess:
	lda TimersCMDs,x
	and #SET_FROZEN ^ $ff
	bra EnProc0

;---------------------------------------------------------------
; called from main loop
;---------------------------------------------------------------
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
	jsr _DoExecDelay
	pla
	tax
@2:	dex
	bpl @1
@3:	rts

_DoExecDelay:
	inc r0L
	bne @1
	inc r0H
@1:	jmp (r0)

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
