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
	sta $8870,x;xxxKbdDBncTab,x
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

.if wheels
.include "jumptab.inc"
LEC75 = $ec75
LFD2F = $fd2f
LC5E7 = $c5e7

.global DrawCheckeredScreen
DrawCheckeredScreen:
	lda #2
	jsr SetPattern
	jsr i_Rectangle
LC4A1:	.byte 0, 199
	.word 0, 319
	rts

; ----------------------------------------------------------------------------
.global _WheelsSyscall8
_WheelsSyscall8:
	php
	sei
	jsr @3
	ldx r2H
@1:	ldy #$00
	lda r4H
@2:	sta (r5),y
	iny
	cpy r2L
	bcc @2
	jsr @6
	dex
	bne @1
	plp
	rts

@3:	clc
	lda r1L
	adc #0
	sta r5L
	lda #>COLOR_MATRIX
	adc #0
	sta r5H
	ldx r1H
	beq @5
@4:	jsr @6
	dex
	bne @4
@5:	rts

@6:	AddVW 40, r5
	rts

; ----------------------------------------------------------------------------
.global _WheelsSyscall9
; inline version of WheelsSyscall8
_WheelsSyscall9:
	PopB returnAddress
        PopB returnAddress+1
        ldy #5                            ; C4EC A0 05                    ..
        lda (returnAddress),y                       ; C4EE B1 3D                    .=
        sta     r4H                             ; C4F0 85 0B                    ..
        dey                                     ; C4F2 88                       .
        ldx     #$03                            ; C4F3 A2 03                    ..
LC4F5:  lda     (returnAddress),y                       ; C4F5 B1 3D                    .=
        sta     r1L,x                           ; C4F7 95 04                    ..
        dey                                     ; C4F9 88                       .
        dex                                     ; C4FA CA                       .
        bpl     LC4F5                           ; C4FB 10 F8                    ..
        jsr     _WheelsSyscall8                           ; C4FD 20 A8 C4                  ..
        php                                     ; C500 08                       .
        lda     #6                            ; C501 A9 06                    ..
        jmp     DoInlineReturn                  ; C503 4C A4 C2                 L..
.endif

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
