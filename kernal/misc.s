; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Misc 6502 helpers

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"

; syscalls
.global _CallRoutine
.global _DoInlineReturn

.segment "misc"

;---------------------------------------------------------------
;---------------------------------------------------------------
_CallRoutine:
	cmp #0
	bne @1
	cpx #0
	beq @2
@1:	sta CallRLo
	stx CallRHi
	jmp (CallRLo)
@2:	rts

;---------------------------------------------------------------
;---------------------------------------------------------------
_DoInlineReturn:
	add returnAddress
	sta returnAddress
	bcc @1
	inc returnAddress+1
@1:	plp
	jmp (returnAddress)
