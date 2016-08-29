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
LEC75 = $ec75
LFD2F = $fd2f
LC5E7 = $c5e7
LD07B = $D07B
L003D = $003D

; ----------------------------------------------------------------------------
LC499:  lda     #$02                            ; C499 A9 02                    ..
        jsr     SetPattern                      ; C49B 20 39 C1                  9.
        jsr     i_Rectangle                     ; C49E 20 9F C1                  ..
LC4A1:  .byte   $00,$C7,$00,$00,$3F,$01         ; C4A1 00 C7 00 00 3F 01        ....?.
; ----------------------------------------------------------------------------
        rts                                     ; C4A7 60                       `

; ----------------------------------------------------------------------------
.global _WheelsSyscall8
_WheelsSyscall8:
	php                                     ; C4A8 08                       .
        sei                                     ; C4A9 78                       x
        jsr     LC4C2                           ; C4AA 20 C2 C4                  ..
        ldx     $07                             ; C4AD A6 07                    ..
LC4AF:  ldy     #$00                            ; C4AF A0 00                    ..
        lda     $0B                             ; C4B1 A5 0B                    ..
LC4B3:  sta     ($0C),y                         ; C4B3 91 0C                    ..
        iny                                     ; C4B5 C8                       .
        cpy     $06                             ; C4B6 C4 06                    ..
        bcc     LC4B3                           ; C4B8 90 F9                    ..
        jsr     LC4DA                           ; C4BA 20 DA C4                  ..
        dex                                     ; C4BD CA                       .
        bne     LC4AF                           ; C4BE D0 EF                    ..
        plp                                     ; C4C0 28                       (
        rts                                     ; C4C1 60                       `

; ----------------------------------------------------------------------------
LC4C2:  clc                                     ; C4C2 18                       .
        lda     $04                             ; C4C3 A5 04                    ..
        adc     #$00                            ; C4C5 69 00                    i.
        sta     $0C                             ; C4C7 85 0C                    ..
        lda     #$8C                            ; C4C9 A9 8C                    ..
        adc     #$00                            ; C4CB 69 00                    i.
        sta     $0D                             ; C4CD 85 0D                    ..
        ldx     $05                             ; C4CF A6 05                    ..
        beq     LC4D9                           ; C4D1 F0 06                    ..
LC4D3:  jsr     LC4DA                           ; C4D3 20 DA C4                  ..
        dex                                     ; C4D6 CA                       .
        bne     LC4D3                           ; C4D7 D0 FA                    ..
LC4D9:  rts                                     ; C4D9 60                       `

; ----------------------------------------------------------------------------
LC4DA:  clc                                     ; C4DA 18                       .
        lda     #$28                            ; C4DB A9 28                    .(
        adc     $0C                             ; C4DD 65 0C                    e.
        sta     $0C                             ; C4DF 85 0C                    ..
        bcc     LC4E5                           ; C4E1 90 02                    ..
        inc     $0D                             ; C4E3 E6 0D                    ..
LC4E5:  rts                                     ; C4E5 60                       `

; ----------------------------------------------------------------------------
.global _WheelsSyscall9
_WheelsSyscall9:
	pla                                     ; C4E6 68                       h
        sta     L003D                           ; C4E7 85 3D                    .=
        pla                                     ; C4E9 68                       h
        sta     $3E                             ; C4EA 85 3E                    .>
        ldy     #$05                            ; C4EC A0 05                    ..
        lda     (L003D),y                       ; C4EE B1 3D                    .=
        sta     $0B                             ; C4F0 85 0B                    ..
        dey                                     ; C4F2 88                       .
        ldx     #$03                            ; C4F3 A2 03                    ..
LC4F5:  lda     (L003D),y                       ; C4F5 B1 3D                    .=
        sta     $04,x                           ; C4F7 95 04                    ..
        dey                                     ; C4F9 88                       .
        dex                                     ; C4FA CA                       .
        bpl     LC4F5                           ; C4FB 10 F8                    ..
        jsr     _WheelsSyscall8                           ; C4FD 20 A8 C4                  ..
        php                                     ; C500 08                       .
        lda     #$06                            ; C501 A9 06                    ..
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