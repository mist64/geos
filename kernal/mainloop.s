; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Main Loop

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"
.include "c64.inc"

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

; used by filesys.s, load.s
.global _MNLP

; syscall
.global _InterruptMain
.global _MainLoop

.segment "mainloop1"

_MainLoop:
.if wheels_screensaver
LFCBA = $FCBA
LCBDB = $CBDB
LCAFC = $CAFC
LFA27 = $FA27
.import RunScreensaver
	bit     saverStatus
        bpl     LC052 ; no time out
        bvs     LC052 ; blocked
        bit     alphaFlag
        bvs     LC052 ; text input active
        sei
        lda     saverStatus
        and     #$7F
        ora     #$01
        sta     saverStatus ; enable
        jsr     RunScreensaver
        cli
.endif

LC052:
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:	jsr CallRoutine
	cli
.if wheels
        ldx     $01
        lda     #$35
        sta     $01
        lda     grcntrl1
        and     #$7F
LC073:  sta     grcntrl1
        stx $01
LC077:  jmp _MainLoop
.else
	jmp _MainLoop2
.endif

.segment "mainloop2"

.if !wheels
_MainLoop2:
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	jmp _MainLoop
.endif

.segment "mainloop3"

;---------------------------------------------------------------
;---------------------------------------------------------------
_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom
