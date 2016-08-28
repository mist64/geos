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

.if !wheels
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
	jsr Init_KRNLVec
	LoadB CPU_DATA, RAM_64K
ASSERT_NOT_BELOW_IO
	jmp ResetMseRegion
.endif

.segment "hw2"

.if !wheels
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

.if wheels
.include "jumptab.inc"
LC5FA:  lda     $885D                           ; C5FA AD 5D 88                 .].
        sta     $16                             ; C5FD 85 16                    ..
        lda     $885E                           ; C5FF AD 5E 88                 .^.
        sta     r0L                           ; C602 85 02                    ..
        and     #$01                            ; C604 29 01                    ).
        beq     LC612                           ; C606 F0 0A                    ..
        lda     $8860                           ; C608 AD 60 88                 .`.
        sta     $11                             ; C60B 85 11                    ..
        lda     $885F                           ; C60D AD 5F 88                 ._.
        sta     $10                             ; C610 85 10                    ..
LC612:  lda     #$84                            ; C612 A9 84                    ..
        sta     $07                             ; C614 85 07                    ..
        lda     #$53                            ; C616 A9 53                    .S
        sta     $06                             ; C618 85 06                    ..
        lda     #$84                            ; C61A A9 84                    ..
        sta     $09                             ; C61C 85 09                    ..
        lda     #$42                            ; C61E A9 42                    .B
        sta     $08                             ; C620 85 08                    ..
        rts                                     ; C622 60                       `


LC623:  lda     $11                             ; C623 A5 11                    ..
        sta     $8860                           ; C625 8D 60 88                 .`.
        lda     $10                             ; C628 A5 10                    ..
        sta     $885F                           ; C62A 8D 5F 88                 ._.
        lda     $16                             ; C62D A5 16                    ..
        sta     $885D                           ; C62F 8D 5D 88                 .].
        lda     r0L                           ; C632 A5 02                    ..
        sta     $885E                           ; C634 8D 5E 88                 .^.
        and     #$C0                            ; C637 29 C0                    ).
        beq     LC655                           ; C639 F0 1A                    ..
        ldy     #$84                            ; C63B A0 84                    ..
        lda     #$53                            ; C63D A9 53                    .S
        ldx     #$06                            ; C63F A2 06                    ..
        jsr     LC64A                           ; C641 20 4A C6                  J.
        ldy     #$84                            ; C644 A0 84                    ..
        lda     #$42                            ; C646 A9 42                    .B
        ldx     #$08                            ; C648 A2 08                    ..
LC64A:  sty     $0B                             ; C64A 84 0B                    ..
        sta     $0A                             ; C64C 85 0A                    ..
        ldy     #$0A                            ; C64E A0 0A                    ..
        lda     #$10                            ; C650 A9 10                    ..
        jsr     CopyFString                     ; C652 20 68 C2                  h.
LC655:  rts                                     ; C655 60                       `
.endif