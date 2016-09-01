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
	jmp _GetNewKernal

; REU swap, preserving r registers and x, y
RstrKernal:
	jmp _RstrKernal

_ReadFile:
	jmp __ReadFile

_WriteFile:
	jmp __WriteFile

_ToBASIC:
	jmp __ToBASIC

L9D8F:	.byte $4c ; jmp
REUArgs:
	.word $5000 ; CBM address
        .word $0100 ; REU address
	.word $03bd ; byte count

L9D96:	.byte   $42
	.byte $04,$F4,$50,$EA,$06,$01     ; 9D96 42 04 F4 50 EA 06 01     B..P...
SaveX:	.byte 3
SaveY:	.byte 0

_GetNewKernal:
	pha
	stx SaveX
	sty SaveY
	jsr SaveRegs
	pla
	pha
	asl
	asl ; bank * 4
	sta r1L
	lda #0
	sta r1H
	sta r2H
	lda #$04
	sta r2L
	LoadW r0, $9D92
	jsr SetBank
	jsr FetchDec
	jsr SetREUArgs
	pla
	pha
	bmi @1
	jsr SwapDec
	bne @2
@1:	jsr FetchDec
@2:	jsr RestoreRegs
	ldx SaveX
	ldy SaveY
	pla
	pha
	and #$40
	beq @4
	pla
@3:	rts
@4:	jsr L9D8F                           ; 9DE7 20 8F 9D                  ..
        pla
        bmi     @3
_RstrKernal:
	stx     SaveX
        sty     SaveY
        jsr     SaveRegs
        jsr     SetREUArgs
        jsr     SwapDec
        jsr     RestoreRegs
        ldx     SaveX                           ; 9DFF AE 9D 9D                 ...
        ldy     SaveY                           ; 9E02 AC 9E 9D                 ...
        rts                                     ; 9E05 60                       `

; ----------------------------------------------------------------------------
; set up args, inc
SetREUArgs:
	ldx #5 ; only src, dst and count
@1:	lda REUArgs,x
	sta r0L,x
	dex
	bpl @1
SetBank:
	lda ramExpSize ; first bank after logical end of REU
	sta r3L
	inc ramExpSize ; allow accessing this bank
	rts

; swap
SwapDec:
	jsr     SwapRAM                         ; 9E19 20 CE C2                  ..
        bra     L9E22                           ; 9E1D 50 03                    P.
; fetch
FetchDec:
	jsr     FetchRAM                        ; 9E1F 20 CB C2                  ..
L9E22:	dec     ramExpSize ; restore original REU size
        rts                                     ; 9E25 60                       `

RestoreRegs:
	ldx     #6                            ; 9E26 A2 06                    ..
L9E28:	lda     L9D96,x                         ; 9E28 BD 96 9D                 ...
        sta     r0L,x                         ; 9E2B 95 02                    ..
        dex                                     ; 9E2D CA                       .
        bpl     L9E28                           ; 9E2E 10 F8                    ..
        rts                                     ; 9E30 60                       `

SaveRegs:
	ldx     #6                            ; 9E31 A2 06                    ..
L9E33:	lda     r0L,x                         ; 9E33 B5 02                    ..
        sta     L9D96,x                         ; 9E35 9D 96 9D                 ...
        dex                                     ; 9E38 CA                       .
        bpl     L9E33                           ; 9E39 10 F8                    ..
        rts                                     ; 9E3B 60                       `

__ReadFile:
	lda #3 ; bank for OReadFile
	.byte $2c
__WriteFile:
	lda #4 ; bank for OWriteFile
	jmp _GetNewKernal

__ToBASIC:
	lda #$40 + 11
	jsr _GetNewKernal
	jmp KToBasic


	.byte 0, 0, 0, 0, 0, 0, 0

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
        sta     r0H                             ; 9E6B 85 03                    ..
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
        sta     r0H                             ; 9E84 85 03                    ..
        lda     #$F7                            ; 9E86 A9 F7                    ..
        sta     r1H                             ; 9E88 85 05                    ..
        lda     #$01                            ; 9E8A A9 01                    ..
        sta     r2H                             ; 9E8C 85 07                    ..
        lda     #$00                            ; 9E8E A9 00                    ..
        sta     r0L                           ; 9E90 85 02                    ..
        sta     r1L                             ; 9E92 85 04                    ..
        sta     r2L                             ; 9E94 85 06                    ..
L9E96:	lda     ramExpSize ; first bank after logical end of REU
        sta     r3L                             ; 9E99 85 08                    ..
        inc     ramExpSize ; allow accessing this bank
        jsr     FetchRAM                        ; 9E9E 20 CB C2                  ..
        dec     ramExpSize ; restore original REU size
        ldx     #$00                            ; 9EA4 A2 00                    ..
        rts                                     ; 9EA6 60                       `

; ----------------------------------------------------------------------------
.import _GetFileOld
L9EA7:	jmp _GetFileOld

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
L9FDA:	.byte   $BF,$E0                         ; 9FDA BF E0                    ..
L9FDC:	.byte   $06                             ; 9FDC 06                       .
L9FDD:	.byte   $00,$00,$00,$67,$63,$41,$61,$C3 ; 9FDD 00 00 00 67 63 41 61 C3  ...gcAa.
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
	LoadW r0, $4000
	LoadW r1, $fe40
	LoadW r2, $01c0
	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr SwapRAM
	dec ramExpSize
	rts
.endif