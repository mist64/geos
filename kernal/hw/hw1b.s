; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Hardware initialization

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import ResetMseRegion
.import Init_KRNLVec
.import SetVICRegs
.import VIC_IniTbl_end
.import VIC_IniTbl
.import KbdQueTail
.import KbdQueHead
.import KbdQueFlag
.import KbdDBncTab
.import KbdDMltTab
.import InitVDC

.import SetColorMode

.global _DoFirstInitIO

.segment "hw1b"

_DoFirstInitIO:
	LoadB CPU_DDR, $2f
.ifdef bsw128
	LoadB config, CIOIN
.else
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, KRNL_IO_IN
.ifdef wheels
	sta scpu_turbo
.endif
.endif
	ldx #7
	lda #$ff
@1:	sta KbdDMltTab,x
	sta KbdDBncTab,x
	dex
	bpl @1
	stx KbdQueFlag
	stx cia1base+2
	inx
	stx KbdQueHead
	stx KbdQueTail
	stx cia1base+3
	stx cia1base+15
	stx cia2base+15
.ifdef bsw128
	PushB rcr
	and #%11110000
	ora #%00000111
	sta rcr
.endif
	lda PALNTSCFLAG
	beq @2
	ldx #$80
@2:
.ifdef bsw128
	PopB rcr
.endif
	stx cia1base+14
	stx cia2base+14
	lda cia2base
	and #%00110000
	ora #%00000101
	sta cia2base
	LoadB cia2base+2, $3f
	LoadB cia1base+13, $7f
	sta cia2base+13
.ifdef bsw128
	lda cia1base+13
	lda cia2base+13
.endif
	LoadW r0, VIC_IniTbl
.assert * - VIC_IniTbl_end - VIC_IniTbl < 256, error, "VIC_IniTbl must be < 256 bytes"
	ldy #<(VIC_IniTbl_end - VIC_IniTbl)
	jsr SetVICRegs
.ifdef bsw128
	jsr InitVDC
	lda #0 ; monochrome mode
	jsr SetColorMode
.endif
.if .defined(wheels) || .defined(removeToBASIC)
	ldx #32
@3:	lda KERNALVecTab-1,x
	sta irqvec-1,x
	dex
	bne @3
.elseif .defined(bsw128)
	jsr $FF8A ; "RESTOR" CBM KERNAL call
.else
	jsr Init_KRNLVec
.endif
.ifndef bsw128
	LoadB CPU_DATA, RAM_64K
.endif
ASSERT_NOT_BELOW_IO
	jmp ResetMseRegion

