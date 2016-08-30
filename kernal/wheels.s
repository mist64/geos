; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Michael Steil
;
; Wheels additions

.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

.global modKeyCopy
.global dbFieldWidth
.global extKrnlIn
.global fftIndicator

.segment "wheels1"

.if wheels
.global _GEOSOptimize, _DEFOptimize, _DoOptimize
_GEOSOptimize:
	ldy #0 ; enable GEOS optimization
	.byte $2c
_DEFOptimize:
	ldy #3 ; disable all optimizations
_DoOptimize:
	php
	sei
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, $35
	sta scpu_hwreg_enable
	sta scpu_base,y
	sta scpu_hwreg_disable
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	plp
	rts
.endif

.segment "wheels2"

.if wheels
.global _ReadXYPot
_ReadXYPot:
	php
	sei
	lsr
	ror
	ror
	sta cia1base+0
	PushB cia1base+2 ; DDR A
	LoadB cia1base+2, $C0
	lda cia1base+14
	and #$FE
	sta cia1base+14 ; stop timer A
	MoveW relayDelay, cia1base+4 ; timer A value
	lda #$7F
	sta cia1base+13 ; disabe all interrupts
	lda cia1base+13 ; clear pending interrupts
	lda cia1base+14
	and #$40
	ora #$19
	sta cia1base+14 ; load timer A, one shot, start
	lda #$01
@1:	bit cia1base+13 ; wait for timer A underflow
	beq @1
	ldx sidbase+$19 ; mouse
	ldy sidbase+$1A
	PopB cia1base+2 ; DDR A
	plp
	rts

.global _ConvToCards
; Convert a rectangle in pixel space into a origin/size
; rectangle in card space, i.e. convert it into a
; color matrix rectangle for
; * ColorRectangle_W
; * SaveColorRectangle
; * RestoreColorRectangle
;
; in:  r2L: y1
;      r2H: y2
;      r3:  x1
;      r4:  x2
; out: r1L: x1
;      r1H: y1
;      r2L: width
;      r2H: height
_ConvToCards:
	lda r2L
	lsr
	lsr
	lsr
	sta r1H
	sec
	lda r2H
	sbc r2L
	lsr
	lsr
	lsr
	sta r2H
	inc r2H
	lda r3H
	lsr
	lda r3L
	ror
	lsr
	lsr
	sta r1L
	sec
	lda r4L
	sbc r3L
	pha
	lda r4H
	sbc r3H
	lsr
	pla
	ror
	lsr
	lsr
	sta r2L
	inc r2L
	rts

        .byte 0, 0 ; ??? unused
.endif

.segment "wheels3"

.if wheels
temp = $c325
.global _SaveColorRectangle, _RestoreColorRectangle
; Saves a rectangle into or restores it from a linear buffer
; in:  r0:  buffer address
;      r1L: x
;      r1H: y
;      r2L: width
;      r2H: height
_RestoreColorRectangle:
	lda #0
	.byte $2c
_SaveColorRectangle:
	lda #$80
	sta temp
	jsr GetColorMatrixOffset
	MoveW r0, r6
	ldx r2H
@1:	ldy #0
@2:	bbrf 7, temp, @3
	lda (r5),y
	sta (r6),y
	bra @4
@3:	lda (r6),y
	sta (r5),y
@4:	iny
	cpy r2L
	bcc @2
	tya
	clc
	adc r6L
	sta r6L
	bcc @5
	inc r6H
@5:	jsr NextScreenLine
	dex
	bne @1
	rts

        .byte 0, 0, 0, 0
.endif

.segment "wheels4"

.if wheels
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
.global _ColorRectangle_W
.global GetColorMatrixOffset
.global NextScreenLine
_ColorRectangle_W:
; r1L   x
; r1H   y
; r2L   width
; r2H   height
; r4H   value
	php
	sei
	jsr GetColorMatrixOffset
	ldx r2H
@1:	ldy #0
	lda r4H
@2:	sta (r5),y
	iny
	cpy r2L
	bcc @2
	jsr NextScreenLine
	dex
	bne @1
	plp
	rts

GetColorMatrixOffset:
; in:  r1L: x
;      r1H: y
; out: r5:  color matrix offset
	clc
	lda r1L
	adc #<COLOR_MATRIX
	sta r5L
	lda #>COLOR_MATRIX
	adc #0
	sta r5H
	ldx r1H
	beq @5
@4:	jsr NextScreenLine
	dex
	bne @4
@5:	rts

NextScreenLine:
	AddVW 40, r5
	rts

; ----------------------------------------------------------------------------
.global _i_ColorRectangle
; inline version of ColorRectangle_W
_i_ColorRectangle:
	PopW returnAddress
	ldy #5
	lda (returnAddress),y
	sta r4H
	dey
	ldx #3
@1:	lda (returnAddress),y
	sta r1L,x
	dey
	dex
	bpl @1
	jsr _ColorRectangle_W
	php
	lda #6
	jmp DoInlineReturn
.endif

.if wheels

.segment "wheels_lokernal1"

.global GetNewKernal
.global RstrKernal
.global _ReadFile
.global _WriteFile
.global _ToBASIC

GetNewKernal:
	jmp     L9D9F ; far call

; REU swap, preserving r registers and x, y
RstrKernal:
	jmp     L9DED

_ReadFile:
	jmp     L9E3C                           ; 9D86 4C 3C 9E                 L<.

_WriteFile:
	jmp     L9E3F                           ; 9D89 4C 3F 9E                 L?.

_ToBASIC:
	jmp     L9E44                           ; 9D8C 4C 44 9E                 LD.

L9D8F:  jmp $5000
        .byte   $00,$01,$BD,$03             ; 9D91 50 00 01 BD 03           P....
L9D96:  .byte   $42,$04,$F4,$50,$EA,$06,$01     ; 9D96 42 04 F4 50 EA 06 01     B..P...
L9D9D:  .byte   $03                             ; 9D9D 03                       .
L9D9E:  .byte   $00                             ; 9D9E 00                       .

L9D9F:  pha                                     ; 9D9F 48                       H
        stx     L9D9D                           ; 9DA0 8E 9D 9D                 ...
        sty     L9D9E                           ; 9DA3 8C 9E 9D                 ...
        jsr     L9E31 ; read args                           ; 9DA6 20 31 9E                  1.
        pla                                     ; 9DA9 68                       h
        pha                                     ; 9DAA 48                       H
        asl                               ; 9DAB 0A                       .
        asl                               ; 9DAC 0A                       .
        sta     r1L                             ; 9DAD 85 04                    ..
        lda     #$00                            ; 9DAF A9 00                    ..
        sta     r1H                             ; 9DB1 85 05                    ..
        sta     r2H                             ; 9DB3 85 07                    ..
        lda     #$04                            ; 9DB5 A9 04                    ..
        sta     r2L                             ; 9DB7 85 06                    ..
        lda     #$9D                            ; 9DB9 A9 9D                    ..
        sta     $03                             ; 9DBB 85 03                    ..
        lda     #$92                            ; 9DBD A9 92                    ..
        sta     r0L                           ; 9DBF 85 02                    ..
        jsr     L9E10                           ; 9DC1 20 10 9E                  ..
        jsr     L9E1F                           ; 9DC4 20 1F 9E                  ..
        jsr     L9E06                           ; 9DC7 20 06 9E                  ..
        pla                                     ; 9DCA 68                       h
        pha                                     ; 9DCB 48                       H
        bmi     L9DD3                           ; 9DCC 30 05                    0.
        jsr     L9E19 ; swap                           ; 9DCE 20 19 9E                  ..
        bne     L9DD6                           ; 9DD1 D0 03                    ..
L9DD3:  jsr     L9E1F ; fetch                           ; 9DD3 20 1F 9E                  ..
L9DD6:  jsr     L9E26                           ; 9DD6 20 26 9E                  &.
        ldx     L9D9D                           ; 9DD9 AE 9D 9D                 ...
        ldy     L9D9E                           ; 9DDC AC 9E 9D                 ...
        pla                                     ; 9DDF 68                       h
        pha                                     ; 9DE0 48                       H
        and     #$40                            ; 9DE1 29 40                    )@
        beq     L9DE7                           ; 9DE3 F0 02                    ..
        pla                                     ; 9DE5 68                       h
L9DE6:  rts                                     ; 9DE6 60                       `

; ----------------------------------------------------------------------------
L9DE7:  jsr     L9D8F                           ; 9DE7 20 8F 9D                  ..
        pla                                     ; 9DEA 68                       h
        bmi     L9DE6                           ; 9DEB 30 F9                    0.
L9DED:  stx     L9D9D                           ; 9DED 8E 9D 9D                 ...
        sty     L9D9E                           ; 9DF0 8C 9E 9D                 ...
        jsr     L9E31 ; read args                           ; 9DF3 20 31 9E                  1.
        jsr     L9E06                           ; 9DF6 20 06 9E                  ..
        jsr     L9E19 ; swap                           ; 9DF9 20 19 9E                  ..
        jsr     L9E26 ; set up args                           ; 9DFC 20 26 9E                  &.
        ldx     L9D9D                           ; 9DFF AE 9D 9D                 ...
        ldy     L9D9E                           ; 9E02 AC 9E 9D                 ...
        rts                                     ; 9E05 60                       `

; ----------------------------------------------------------------------------
; set up args, inc
L9E06:  ldx     #$05                            ; 9E06 A2 05                    ..
L9E08:  lda     L9D8F+1,x                         ; 9E08 BD 90 9D                 ...
        sta     r0L,x                         ; 9E0B 95 02                    ..
        dex                                     ; 9E0D CA                       .
        bpl     L9E08                           ; 9E0E 10 F8                    ..
L9E10:  lda     $88C3                           ; 9E10 AD C3 88                 ...
        sta     r3L                             ; 9E13 85 08                    ..
        inc     $88C3                           ; 9E15 EE C3 88                 ...
        rts                                     ; 9E18 60                       `

; ----------------------------------------------------------------------------
; swap
L9E19:  jsr     SwapRAM                         ; 9E19 20 CE C2                  ..
        clv                                     ; 9E1C B8                       .
        bvc     L9E22                           ; 9E1D 50 03                    P.
; fetch
L9E1F:  jsr     FetchRAM                        ; 9E1F 20 CB C2                  ..
L9E22:  dec     $88C3                           ; 9E22 CE C3 88                 ...
        rts                                     ; 9E25 60                       `

; ----------------------------------------------------------------------------
; set up args
L9E26:  ldx     #$06                            ; 9E26 A2 06                    ..
L9E28:  lda     L9D96,x                         ; 9E28 BD 96 9D                 ...
        sta     r0L,x                         ; 9E2B 95 02                    ..
        dex                                     ; 9E2D CA                       .
        bpl     L9E28                           ; 9E2E 10 F8                    ..
        rts                                     ; 9E30 60                       `

; ----------------------------------------------------------------------------
; copy back args
L9E31:  ldx     #$06                            ; 9E31 A2 06                    ..
L9E33:  lda     r0L,x                         ; 9E33 B5 02                    ..
        sta     L9D96,x                         ; 9E35 9D 96 9D                 ...
        dex                                     ; 9E38 CA                       .
        bpl     L9E33                           ; 9E39 10 F8                    ..
        rts                                     ; 9E3B 60                       `

; ----------------------------------------------------------------------------
L9E3C:  lda     #$03                            ; 9E3C A9 03                    ..
        .byte   $2C                             ; 9E3E 2C                       ,
L9E3F:  lda     #$04                            ; 9E3F A9 04                    ..
        jmp     L9D9F                           ; 9E41 4C 9F 9D                 L..

; ----------------------------------------------------------------------------
; ToBasic
L5000 = $5000
L9E44:  lda     #$4B                            ; 9E44 A9 4B                    .K
        jsr     L9D9F ; far call                           ; 9E46 20 9F 9D                  ..
        jmp     L5000                           ; 9E49 4C 00 50                 L.P

; ----------------------------------------------------------------------------
        brk                                     ; 9E4C 00                       .
        brk                                     ; 9E4D 00                       .
        brk                                     ; 9E4E 00                       .
        brk                                     ; 9E4F 00                       .
        brk                                     ; 9E50 00                       .
        brk                                     ; 9E51 00                       .
        brk                                     ; 9E52 00                       .

; GetFile
.global _GetFile
_GetFile:
	lda     $88C4                           ; 9E53 AD C4 88                 ...
        and     #$10                            ; 9E56 29 10                    ).
        beq     L9EA7                           ; 9E58 F0 4D                    .M
        lda     $0F                             ; 9E5A A5 0F                    ..
        cmp     #$84                            ; 9E5C C9 84                    ..
        bne     L9EA7                           ; 9E5E D0 47                    .G
        lda     $0E                             ; 9E60 A5 0E                    ..
        sec                                     ; 9E62 38                       8
        sbc     #$65                            ; 9E63 E9 65                    .e
        ora     r0L                           ; 9E65 05 02                    ..
        bne     L9EA7                           ; 9E67 D0 3E                    .>
        lda     #$79                            ; 9E69 A9 79                    .y
        sta     $03                             ; 9E6B 85 03                    ..
        lda     #$F8                            ; 9E6D A9 F8                    ..
        sta     r1H                             ; 9E6F 85 05                    ..
        lda     #$00                            ; 9E71 A9 00                    ..
        sta     r0L                           ; 9E73 85 02                    ..
        sta     r1L                             ; 9E75 85 04                    ..
        lda     #$06                            ; 9E77 A9 06                    ..
        sta     r2H                             ; 9E79 85 07                    ..
        lda     #$40                            ; 9E7B A9 40                    .@
        sta     r2L                             ; 9E7D 85 06                    ..
        jsr     L9E96                           ; 9E7F 20 96 9E                  ..
        lda     #$81                            ; 9E82 A9 81                    ..
        sta     $03                             ; 9E84 85 03                    ..
        lda     #$F7                            ; 9E86 A9 F7                    ..
        sta     r1H                             ; 9E88 85 05                    ..
        lda     #$01                            ; 9E8A A9 01                    ..
        sta     r2H                             ; 9E8C 85 07                    ..
        lda     #$00                            ; 9E8E A9 00                    ..
        sta     r0L                           ; 9E90 85 02                    ..
        sta     r1L                             ; 9E92 85 04                    ..
        sta     r2L                             ; 9E94 85 06                    ..
L9E96:  lda     $88C3                           ; 9E96 AD C3 88                 ...
        sta     r3L                             ; 9E99 85 08                    ..
        inc     $88C3                           ; 9E9B EE C3 88                 ...
        jsr     FetchRAM                        ; 9E9E 20 CB C2                  ..
        dec     $88C3                           ; 9EA1 CE C3 88                 ...
        ldx     #$00                            ; 9EA4 A2 00                    ..
        rts                                     ; 9EA6 60                       `

; ----------------------------------------------------------------------------
.import _GetFileOld
L9EA7:	jmp _GetFileOld

.segment "wheels_lokernal1a"
; ----------------------------------------------------------------------------
.global _VerifyRAM, _StashRAM, _SwapRAM, _FetchRAM, _DoRAMOp
_VerifyRAM:
	ldy     #$93                            ; 9EAA A0 93                    ..
        .byte   $2C                             ; 9EAC 2C                       ,
_StashRAM:
	ldy     #$90                            ; 9EAD A0 90                    ..
        .byte   $2C                             ; 9EAF 2C                       ,
_SwapRAM:
	ldy     #$92                            ; 9EB0 A0 92                    ..
        .byte   $2C                             ; 9EB2 2C                       ,
_FetchRAM:
	ldy     #$91                            ; 9EB3 A0 91                    ..
_DoRAMOp:
	ldx     #$0D                            ; 9EB5 A2 0D                    ..
        lda     r3L                             ; 9EB7 A5 08                    ..
        cmp     $88C3                           ; 9EB9 CD C3 88                 ...
        bcs     L9F09                           ; 9EBC B0 4B                    .K
        php                                     ; 9EBE 08                       .
        sei                                     ; 9EBF 78                       x
        lda     $01                             ; 9EC0 A5 01                    ..
        pha                                     ; 9EC2 48                       H
        lda     #$35                            ; 9EC3 A9 35                    .5
        sta     $01                             ; 9EC5 85 01                    ..
        lda     $D030                           ; 9EC7 AD 30 D0                 .0.
        pha                                     ; 9ECA 48                       H
        lda     #$00                            ; 9ECB A9 00                    ..
        sta     $D030                           ; 9ECD 8D 30 D0                 .0.
        ldx     #$04                            ; 9ED0 A2 04                    ..
L9ED2:  lda     $01,x                           ; 9ED2 B5 01                    ..
        sta     EXP_BASE+1,x                         ; 9ED4 9D 01 DF                 ...
        dex                                     ; 9ED7 CA                       .
        bne     L9ED2                           ; 9ED8 D0 F8                    ..
        lda     r2H                             ; 9EDA A5 07                    ..
        sta     EXP_BASE+8                           ; 9EDC 8D 08 DF                 ...
        lda     r2L                             ; 9EDF A5 06                    ..
        sta     EXP_BASE+7                           ; 9EE1 8D 07 DF                 ...
        lda     r3L                             ; 9EE4 A5 08                    ..
        sta     EXP_BASE+6                           ; 9EE6 8D 06 DF                 ...
        stx     EXP_BASE+9                           ; 9EE9 8E 09 DF                 ...
        stx     EXP_BASE+10                           ; 9EEC 8E 0A DF                 ...
        sty     EXP_BASE+1                           ; 9EEF 8C 01 DF                 ...
        ldx     EXP_BASE+1                           ; 9EF2 AE 01 DF                 ...
        pla                                     ; 9EF5 68                       h
        sta     $D030                           ; 9EF6 8D 30 D0                 .0.
        pla                                     ; 9EF9 68                       h
        sta     $01                             ; 9EFA 85 01                    ..
        plp                                     ; 9EFC 28                       (
        txa                                     ; 9EFD 8A                       .
        and     #$60                            ; 9EFE 29 60                    )`
        cmp     #$60                            ; 9F00 C9 60                    .`
        beq     L9F07                           ; 9F02 F0 03                    ..
        ldx     #$00                            ; 9F04 A2 00                    ..
        .byte   $2C                             ; 9F06 2C                       ,
L9F07:  ldx     #$25                            ; 9F07 A2 25                    .%
L9F09:  rts                                     ; 9F09 60                       `

.segment "wheels_lokernal1b"

; ----------------------------------------------------------------------------
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F0A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F12 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F1A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F22 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F2A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F32 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F3A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F42 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F4A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F52 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F5A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F62 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F6A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F72 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F7A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F82 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F8A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F92 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9F9A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FA2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FAA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FB2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FBA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FC2 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; 9FCA 00 00 00 00 00 00 00 00  ........
        .byte   $00,$01,$00,$00,$00,$00,$00,$00 ; 9FD2 00 01 00 00 00 00 00 00  ........
L9FDA:  .byte   $BF,$E0                         ; 9FDA BF E0                    ..
L9FDC:  .byte   $06                             ; 9FDC 06                       .
L9FDD:  .byte   $00,$00,$00,$67,$63,$41,$61,$C3 ; 9FDD 00 00 00 67 63 41 61 C3  ...gcAa.
backSysPattern:
        .byte   $52,$95,$2D,$52,$8A,$6D,$94,$A2 ; 9FE5 52 95 2D 52 8A 6D 94 A2  R.-R.m..
        .byte   $01                             ; 9FED 01                       .
relayDelay:
	.word $0800
modKeyCopy:
	.byte   $00                             ; 9FF0 00                       .
extKrnlIn:
	.byte   $00                             ; 9FF1 00                       .
dbFieldWidth:
	.byte   $00                             ; 9FF2 00                       .
fftIndicator:
	.byte   $00                             ; 9FF3 00                       .

.segment "wheels_lokernal2"

IntRoutine:
	.byte $68, $8D, $00, $FF
IrqRoutine:
	.byte $68, $A8, $68, $AA, $68
nmiDefault:
	.byte $40

.endif

.segment "screensaver"

.if wheels
.import KbdScanAll
L88B8 = $88B8
L88B6 = $88B6
.global RunScreensaver
RunScreensaver:
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushB extclr
	LoadB extclr, 0 ; black border
	PushB grcntrl1
	and #$6F
	sta grcntrl1 ; turn off screen
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	cli
@1:	lda saverStatus ; wait for IRQ to disable screen saver
	lsr
	bcs @1
	sei
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PopB grcntrl1
	PopB extclr
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

.global ScreenSaver1
ScreenSaver1:
	lda saverStatus
	lsr
	bcs @2 ; screen saver on
	lda saverStatus
	and #$30
	bne @1 ; timer stopped
	jsr @5
@1:	clc
	rts
@2:	jsr @5
	bcc @4
	lda saverStatus
	and #$7E
	sta saverStatus
@3:	jsr KbdScanAll
	bne @3
	lda #0
	sta pressFlag
@4:	sec
	rts

@5:	lda saverStatus
	and #$02
	bne @6 ; ignore mouse
	lda inputData
	cmp #$FF
	bne @7 ; mouse moved
@6:	jsr KbdScanAll
	beq @8
@7:	lda L88B8
	sta L88B6
	lda saverCount
	sta saverTimer
	sec
	rts
@8:	clc
	rts

	.byte 0, 0, 0, 0 ; ??? unused

; ??? unused
	lda #$40
	sta $03
	lda #$00
	sta r0L
	lda #$FE
	sta $05
	lda #$40
	sta $04
	lda #$01
	sta $07
	lda #$C0
	sta $06
	lda $88C3
	sta $08
	inc $88C3
	jsr SwapRAM
	dec $88C3
	rts
.endif