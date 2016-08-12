; GEOS KERNAL
;
; Main Loop

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; conio.s
.import ProcessCursor

; math.s
.import _GetRandom

; mouse.s
.import _DoCheckButtons
.import ProcessMouse

; process.s
.import _DoCheckDelays
.import _ExecuteProcesses
.import _ProcessDelays
.import _ProcessTimers

; time.s
.import _DoUpdateTime

.global _InterruptMain
.global _MNLP
.global _MainLoop

.segment "mainloop1"

_MainLoop:
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:
	jsr CallRoutine
	cli
	jmp _MainLoop2

.segment "mainloop2"
_MainLoop2:
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
	jmp _MainLoop

.segment "mainloop3"

_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom

