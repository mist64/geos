; GEOS KERNAL
;
; Misc 6502 helpers

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
;.include "jumptab.inc"

.global _CallRoutine
.global _DoInlineReturn

.segment "misc"
_CallRoutine:
	cmp #0
	bne CRou1
	cpx #0
	beq CRou2
CRou1:
	sta CallRLo
	stx CallRHi
	jmp (CallRLo)
CRou2:
	rts

_DoInlineReturn:
	add returnAddress
	sta returnAddress
	bcc DILR1
	inc returnAddress+1
DILR1:
	plp
	jmp (returnAddress)
