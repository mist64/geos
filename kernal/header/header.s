; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; KERNAL header and reboot from BASIC

.include "const.inc"
.include "config.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"

; start.s
.import _ResetHandle

.import systemVectorMagic

.global BootGEOS
.global dateCopy
.global sysFlgCopy

.segment "header"

.assert * = $C000, error, "Header not at $C000"

BootGEOS:
.ifdef wheels_remove_BootGEOS
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
.ifdef bsw128
	.byte $80
.else
	.byte 0
.endif

.ifdef wheels
	.byte 0
.elseif .defined(bsw128)
	.byte 4
.else
	.byte 5
.endif
	.byte 0, 0, 0 ; ???

dateCopy:
.ifdef wheels
	.byte 99,1,1
.elseif .defined(cbmfiles) || .defined(gateway) || .defined(bsw128)
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it a different date here.
	.byte 92,3,23
.else
	.byte 88,4,20
.endif

.ifndef wheels_remove_BootGEOS
_BootGEOS:
.ifdef bsw128
	sei
	cld
	ldx #$FF
	txs
	LoadB config, CIOIN
	LoadB rcr, $40
	bbsf 5, sysFlgCopy, @1
	sta systemVectorMagic ; destroy magic
	ldx #zpCode_end - zpCode
@X:	lda zpCode-1,x
	sta r0L-1,x
	dex
	bne @X
	jmp r0L
.else
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
.endif
@1:	ldy #8
@2:	lda BootREUTab,Y
	sta EXP_BASE+1,Y
	dey
	bpl @2
@3:	dey
	bne @3
_RunREU:
	jmp RunREU
.ifdef bsw128
zpCode:	LoadB config, 0
	jmp $FF3D ; C128 RESET code
zpCode_end:
.endif
BootREUTab:
	.word $0091
	.word $0060
	.word $007e
	.word $0500
	.word $0000
.endif
