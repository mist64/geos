; GEOS KERNAL
;
; C64 hardware initialization code

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"

; mouse.s
.import ResetMseRegion

.global Init_KRNLVec
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
	LoadB CPU_DATA, KRNL_IO_IN
	ldx #7
	lda #$ff
DFIIO0:
	sta KbdDMltTab,X
	sta KbdDBncTab,X
	dex
	bpl DFIIO0
	stx KbdQueFlag
	stx cia1base+2
	inx
	stx KbdQueHead
	stx KbdQueTail
	stx cia1base+3
	stx cia1base+15
	stx cia2base+15
	lda PALNTSCFLAG
	beq DFIIO1
	ldx #$80
DFIIO1:
	stx cia1base+14
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
	jsr Init_KRNLVec
	LoadB CPU_DATA, RAM_64K
	jmp ResetMseRegion

.segment "hw2"
Init_KRNLVec:
	ldx #32
IKV1:
	lda KERNALVecTab-1,X
	sta irqvec-1,X
	dex
	bne IKV1
	rts

.segment "hw3"
SetVICRegs:
	sty r1L
	ldy #0
SVR0:
	lda (r0),Y
	cmp #$AA
	beq SVR1
	sta vicbase,Y
SVR1:
	iny
	cpy r1L
	bne SVR0
	rts

