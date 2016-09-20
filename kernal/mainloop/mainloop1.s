; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Main Loop

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _DoUpdateTime
.import _ExecuteProcesses
.import _MainLoop2
.import _DoCheckButtons
.import _DoCheckDelays

.import CallRoutine

.ifdef bsw128
.import __MainLoop
.endif

.global _MainLoop
.global _MNLP

.segment "mainloop1"

_MainLoop:
.ifdef wheels_screensaver
.import RunScreensaver
	bit saverStatus
	bpl @1 ; no time out
	bvs @1 ; blocked
	bit alphaFlag
	bvs @1 ; text input active
	sei
	lda saverStatus
	and #$7F
	ora #$01
	sta saverStatus ; enable
	jsr RunScreensaver
	cli
@1:
.endif
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:	jsr CallRoutine
.ifdef bsw128 ; this is the C128 equivalent of _MainLoop2 inlined
	lda grcntrl1
	and #%01111111
	sta grcntrl1
.endif
	cli
.ifdef wheels ; this is _MainLoop2 inlined
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
.endif
.if .defined(wheels)
	jmp _MainLoop
.elseif .defined(bsw128)
	jmp __MainLoop
.else
	jmp _MainLoop2
.endif

.ifdef bsw128 ; XXX junk
	.byte $88, $88
.endif

