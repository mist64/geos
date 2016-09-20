; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Multitasking: process control syscalls

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
.import TimersTab
.import TimersVals
.import TimersCMDs

.import _DoExecDelay
.import _RemoveDelay

.ifdef wheels
.import UnfreezeProcess
.import UnblockProcess
.endif

.global RProc0
.global _BlockProcess
.global _UnfreezeProcess
.global _UnblockProcess
.global _RestartProcess
.global _FreezeProcess
.global _EnableProcess

.segment "process3a"

;---------------------------------------------------------------
; RestartProcess                                          $C106
;
; Pass:      x   nbr of the process to restart
; Return:    resets a process timer
; Destroyed: a
;---------------------------------------------------------------
_RestartProcess:
.ifdef wheels_size
	jsr UnblockProcess
	jsr UnfreezeProcess
.else
	lda TimersCMDs,x
	and #(SET_BLOCKED | SET_FROZEN) ^ $ff
	sta TimersCMDs,x
.endif
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

.ifdef wheels_size
_FreezeProcess:
	lda #$20
	.byte $2c
_BlockProcess:
	lda #$40
	.byte $2c
_EnableProcess:
	lda #$80
	ora TimersCMDs,x
	bne LCBBD
_UnblockProcess:
	lda #$BF
	.byte $2c
_UnfreezeProcess:
	lda #$DF
	and TimersCMDs,x
LCBBD:  sta TimersCMDs,x
	rts
.else
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
_UnblockProcess:
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
_UnfreezeProcess:
	lda TimersCMDs,x
	and #SET_FROZEN ^ $ff
	bra EnProc0
.endif
