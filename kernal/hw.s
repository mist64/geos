; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64 hardware initialization code

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

; mouse.s
.import ResetMseRegion

; var.s
.import KbdQueTail
.import KbdQueHead
.import KbdQueFlag
.import KbdDBncTab
.import KbdDMltTab

; used by tobasic.s
.global Init_KRNLVec

; used by init.s
.global _DoFirstInitIO

.segment "hw1"

VIC_IniTbl:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $3b, $fb, $aa, $aa, $01, $08, $00
	.byte $38, $0f, $01, $00, $00, $00
VIC_IniTbl_end:

_DoFirstInitIO:
	LoadB CPU_DDR, $2f
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, KRNL_IO_IN
.if wheels
	sta scpu_turbo
.endif
	ldx #7
	lda #$ff
@1:	sta $887B,x;xxxKbdDMltTab,x
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
	lda PALNTSCFLAG
	beq @2
	ldx #$80
@2:	stx cia1base+14
	stx cia2base+14
	lda cia2base
	and #%00110000
	ora #%00000101
	sta cia2base
	LoadB cia2base+2, $3f
	LoadB cia1base+13, $7f
	sta cia2base+13
	LoadW r0, VIC_IniTbl
	ldy #VIC_IniTbl_end - VIC_IniTbl
	jsr SetVICRegs
.if wheels_size_and_speed ; inlined
	ldx #32
@3:	lda KERNALVecTab-1,x
	sta irqvec-1,x
	dex
	bne @3
.else
	jsr Init_KRNLVec
.endif
	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	jmp ResetMseRegion

.segment "hw2"

.if !wheels_size_and_speed ; inlined instead
Init_KRNLVec:
	ldx #32
@1:	lda KERNALVecTab-1,x
	sta irqvec-1,x
	dex
	bne @1
	rts
.endif

.segment "hw3"

SetVICRegs:
	sty r1L
	ldy #0
@1:	lda (r0),Y
	cmp #$AA
	beq @2
	sta vicbase,Y
@2:	iny
	cpy r1L
	bne @1
	rts
