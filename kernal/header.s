; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; KERNAL header and reboot from BASIC

.include "config.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"

; start.s
.import _ResetHandle

.global BootGEOS
.global dateCopy
.global sysFlgCopy

.segment "header"

.assert * = $C000, error, "Header not at $C000"

BootGEOS:
.ifdef wheels
	rts
	nop
	nop
.else
	jmp _BootGEOS
.endif
ResetHandle:
.ifdef wheels
	rts
	nop
	nop
.else
	jmp _ResetHandle
.endif

bootName:
.ifdef gateway
	.byte "GATEWAY "
	.byte 5 ; PADDING
.else
	.byte "GEOS BOOT"
.endif
version:
.ifdef wheels
	.byte $41
.else
	.byte $20
.endif
nationality:
.ifdef wheels
	.word 1 ; GERMAN
.else
	.word 0
.endif
sysFlgCopy:
	.byte 0
c128Flag:
	.byte 0

.ifdef wheels
	.byte 0
.else
	.byte 5
.endif
	.byte 0, 0, 0 ; ???

dateCopy:
.ifdef wheels
	.byte 99,1,1
.elseif .defined(cbmfiles) || .defined(gateway)
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it a different date here.
	.byte 92,3,23
.else
	.byte 88,4,20
.endif

.ifndef wheels
_BootGEOS:
	bbsf 5, sysFlgCopy, @1
	jsr KERNALSETMSG
	lda #version-bootName
	ldx #<bootName
	ldy #>bootName
	jsr $FFBD
	lda #$50
	ldx #8
	ldy #1
	jsr $FFBA
	lda #0
	jsr $FFD5
	bcc _RunREU
	jmp ($0302)
@1:	ldy #8
@2:	lda BootREUTab,Y
	sta EXP_BASE+1,Y
	dey
	bpl @2
@3:	dey
	bne @3
_RunREU:
	jmp RunREU
BootREUTab:
	.word $0091
	.word $0060
	.word $007e
	.word $0500
	.word $0000
.endif
