; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil, Maciej Witkowiak
;
; VDC initialization

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "vdc_init1"

.import GetVDCRegister
.import SetVDCRegister

.global InitVDC

InitVDC:
.assert * - VDC_IniTbl_end - VDC_IniTbl < 256, error, "VDC_IniTbl must be < 256 bytes"
	ldx #<(VDC_IniTbl_end - VDC_IniTbl - 1)
@1:	jsr GetVDCRegister
	cmp VDC_IniTbl,x
	beq @2
	lda VDC_IniTbl,x
	cmp #$ff
	beq @2
	jsr SetVDCRegister
@2:	dex
	bpl @1
	rts

.segment "vdc_init2"

VDC_IniTbl:
	.byte $7E,$50,$66,$49,$FF,$E0,$FF,$20,$FC,$FF,$A0,$E7,$00,$00,$00,$00
	.byte $FF,$FF,$FF,$FF,$FF,$FF,$78,$E8,$FF,$FF,$FF,$00,$FF,$F8,$FF,$FF
	.byte $FF,$FF,$7D,$64,$FF
VDC_IniTbl_end:
