; multitasking functions (processes, sleep, delays)

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.global _BlockProcess, _DoCheckDelays, _EnableProcess, _ExecuteProcesses, _FreezeProcess, _InitProcesses, _ProcessDelays, _ProcessTimers, _RestartProcess, _Sleep, _UnBlockProcess, _UnFreezeProcess

.segment "process"

_InitProcesses:
	ldx #0
	stx NumTimers
	sta r1L
	sta r1H
	tax
	lda #SET_FROZEN
IProc0:
	sta TimersCMDs-1,X
	dex
	bne IProc0
	ldy #0
IProc1:
	lda (r0),Y
	sta TimersRtns,X
	iny
	lda (r0),Y
	sta TimersRtns+1,X
	iny
	lda (r0),Y
	sta TimersVals,X
	iny
	lda (r0),Y
	sta TimersVals+1,X
	iny
	inx
	inx
	dec r1H
	bne IProc1
	MoveB r1L, NumTimers
	rts

_ExecuteProcesses:
	ldx NumTimers
	beq EProc2
	dex
EProc0:
	lda TimersCMDs,X
	bpl EProc1
	and #SET_BLOCKED
	bne EProc1
	lda TimersCMDs,X
	and #SET_RUNABLE ^ $ff
	sta TimersCMDs,X
	txa
	pha
	asl
	tax
	lda TimersRtns,X
	sta r0L
	lda TimersRtns+1,X
	sta r0H
	jsr _DoExecProcess
	pla
	tax
EProc1:
	dex
	bpl EProc0
EProc2:
	rts
_DoExecProcess:
	jmp (r0)

_ProcessTimers:
	lda #0
	tay
	tax
	cmp NumTimers
	beq PTime3
PTime0:
	lda TimersCMDs,X
	and #SET_FROZEN | SET_NOTIMER
	bne PTime2
	lda TimersTab,Y
	bne PTime1
	pha
	lda TimersTab+1,Y
	subv 1
	sta TimersTab+1,Y
	pla
PTime1:
	subv 1
	sta TimersTab,Y
	ora TimersTab+1,Y
	bne PTime2
	jsr RProc0
	lda TimersCMDs,X
	ora #SET_RUNABLE
	sta TimersCMDs,X
PTime2:
	iny
	iny
	inx
	cpx NumTimers
	bne PTime0
PTime3:
	rts

_RestartProcess:
	lda TimersCMDs,X
	and #(SET_BLOCKED | SET_FROZEN) ^ $ff
	sta TimersCMDs,X
RProc0:
	txa
	pha
	asl
	tax
	lda TimersVals,X
	sta TimersTab,X
	lda TimersVals+1,X
	sta TimersTab+1,X
	pla
	tax
	rts

_EnableProcess:
	lda TimersCMDs,X
	ora #SET_RUNABLE
EnProc0:
	sta TimersCMDs,X
	rts

_BlockProcess:
	lda TimersCMDs,X
	ora #SET_BLOCKED
	bra EnProc0
_UnBlockProcess:
	lda TimersCMDs,X
	and #SET_BLOCKED ^ $ff
	bra EnProc0
_FreezeProcess:
	lda TimersCMDs,X
	ora #SET_FROZEN
	bra EnProc0
_UnFreezeProcess:
	lda TimersCMDs,X
	and #SET_FROZEN ^ $ff
	bra EnProc0

_ProcessDelays:
	ldx DelaySP
	beq ProcDel3
	dex
ProcDel0:
	lda DelayValL,X
	bne ProcDel1
	ora DelayValH,X
	beq ProcDel2
	dec DelayValH,X
ProcDel1:
	dec DelayValL,X
ProcDel2:
	dex
	bpl ProcDel0
ProcDel3:
	rts


_DoCheckDelays:
	ldx DelaySP
	beq DChDl2
	dex
DChDl0:
	lda DelayValL,X
	ora DelayValH,X
	bne DChDl1
	lda DelayRtnsH,X
	sta r0H
	lda DelayRtnsL,X
	sta r0L
	txa
	pha
	jsr _RemoveDelay
	jsr _DoExecDelay
	pla
	tax
DChDl1:
	dex
	bpl DChDl0
DChDl2:
	rts

_DoExecDelay:
	inc r0L
	bne DEDe0
	inc r0H
DEDe0:
	jmp (r0)

_RemoveDelay:
	php
	sei
RDel0:
	inx
	cpx DelaySP
	beq RDel1
	lda DelayValL,X
	sta DelayValL-1,X
	lda DelayValH,X
	sta DelayValH-1,X
	lda DelayRtnsL,X
	sta DelayRtnsL-1,X
	lda DelayRtnsH,X
	sta DelayRtnsH-1,X
	bra RDel0
RDel1:
	dec DelaySP
	plp
	rts

_Sleep:
	php
	pla
	tay
	sei
	ldx DelaySP
	lda r0L
	sta DelayValL,X
	lda r0H
	sta DelayValH,X
	pla
	sta DelayRtnsL,X
	pla
	sta DelayRtnsH,X
	inc DelaySP
	tya
	pha
	plp
	rts
