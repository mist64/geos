; GEOS
; reverse engineered by Michael Steil
;
; Wheels additions

.include "config.inc"
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"
.ifdef wheels
.include "jumptab_wheels.inc"
.endif

.import FetchRAM
.import SwapRAM
.import DoInlineReturn
.import i_Rectangle
.import SetPattern

.global modKeyCopy
.global dbFieldWidth
.global extKrnlIn
.global fftIndicator
.global ramExpType
.global sysDBColor

.segment "wheels1"

.ifdef wheels
.global _GEOSOptimize, _DEFOptimize, _DoOptimize
_GEOSOptimize:
	ldy #0 ; enable GEOS optimization
	.byte $2c
_DEFOptimize:
	ldy #3 ; disable all optimizations
_DoOptimize:
	php
	sei
	START_IO
	sta scpu_hwreg_enable
	sta scpu_base,y
	sta scpu_hwreg_disable
	END_IO
	plp
	rts
.endif

.segment "wheels2"

.ifdef wheels
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
; * SaveColor
; * RstrColor
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

.ifdef wheels
.global _SaveColor, _RstrColor
.import WheelsTemp
; Saves a rectangle into or restores it from a linear buffer
; in:  r0:  buffer address
;      r1L: x
;      r1H: y
;      r2L: width
;      r2H: height
_RstrColor:
	lda #0
	.byte $2c
_SaveColor:
	lda #$80
	sta WheelsTemp
	jsr GetColorMatrixOffset
	MoveW r0, r6
	ldx r2H
@1:	ldy #0
@2:	bbrf 7, WheelsTemp, @3
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

.ifdef wheels
.global DrawCheckeredScreen
DrawCheckeredScreen:
	lda #2
	jsr SetPattern
	jsr i_Rectangle
.global ScreenDimensions
ScreenDimensions:
	.byte 0, 199
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

.ifdef wheels

.segment "wheels_lokernal1"

.global GetNewKernal
.global RstrKernal
.global _ReadFile
.global _WriteFile
.global _ToBASIC

GetNewKernal:
	jmp _GetNewKernal

RstrKernal:
	jmp _RstrKernal

_ReadFile:
	jmp __ReadFile

_WriteFile:
	jmp __WriteFile

_ToBASIC:
	jmp __ToBASIC

Execute:
	.byte $4c   ; jmp
REUArgs:
	.word $5000 ; CBM address
REUAddr:
        .word $0100 ; REU address
	.word $03bd ; byte count

SavedRegs:
	.byte $42, $04, $F4, $50, $EA, $06, $01

SaveX:	.byte 3
SaveY:	.byte 0

_GetNewKernal:
; The start of the private area of the REU contains
; a four byte entry for every code bank, consisting
; of a 16 bit REU address and a 16 bit length.
; This allows for variable length code banks, and a
; total of 64 KB of code.
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
	lda #4 ; fetch 4 bytes
	sta r2L
	LoadW r0, REUAddr
	jsr SetBank
	jsr FetchDec ; get address and count of block
	jsr SetREUArgs
	pla
	pha
	bmi @1
	jsr SwapDec  ; $80 = swap
	bne @2
@1:	jsr FetchDec ; otherwise fetch
@2:	jsr RestoreRegs
	ldx SaveX
	ldy SaveY
	pla
	pha
	and #$40     ; $40 = and execute first function, then restore
	beq @4
	pla
@3:	rts
@4:	jsr Execute
	pla
	bmi @3
_RstrKernal:
	stx SaveX
	sty SaveY
	jsr SaveRegs
	jsr SetREUArgs
	jsr SwapDec
	jsr RestoreRegs
	ldx SaveX
	ldy SaveY
	rts

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

SwapDec:
	jsr SwapRAM
	bra Decr
FetchDec:
	jsr FetchRAM
Decr:	dec ramExpSize ; restore original REU size
	rts

RestoreRegs:
	ldx #6
@1:	lda SavedRegs,x
	sta r0L,x
	dex
	bpl @1
	rts

SaveRegs:
	ldx #6
@1:	lda r0L,x
	sta SavedRegs,x
	dex
	bpl @1
	rts

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


	.res 7, 0 ; ???

; GetFile
.global _GetFile
.import _GetFileOld
_GetFile:
; If the printer driver is supposed to be loaded,
; fetch it from REU, otherwise jump to original code.
	lda sysRAMFlg
	and #$10
	beq @2
	lda r6H
	cmp #>PrntFilename
	bne @2
	lda r6L
	sec
	sbc #<PrntFilename
	ora r0L         ; options: load at regular address, no args, no printing
	bne @2
	lda #>PRINTBASE ; CBM destination
	sta r0H
	lda #>prtCodeStorage ; REU source
	.assert <prtCodeStorage = 0, error, "prtCodeStorage must be page-aligned!"
	sta r1H
	lda #0
	sta r0L
	sta r1L
	LoadW r2, 1600  ; count
	jsr @1
	lda #>fileHeader; CBM destination
	sta r0H
	lda #>prtHdrStorage ; REU source
	.assert <prtHdrStorage = 0, error, "prtHdrStorage must be page-aligned!"
	sta r1H
	lda #>$0100     ; count
	sta r2H
	lda #$00
	sta r0L
	sta r1L
	sta r2L
@1:	lda ramExpSize ; first bank after logical end of REU
	sta r3L
	inc ramExpSize ; allow accessing this bank
	jsr FetchRAM
	dec ramExpSize ; restore original REU size
	ldx #$00
	rts
@2:	jmp _GetFileOld

.segment "wheels_lokernal1b"

; ----------------------------------------------------------------------------
	.res 200, 0
	.byte $00,$01,$00,$00
.global sFirstPage
sFirstPage:
	.byte 0
sFirstBank:
	.byte 0
sLastPage:
	.byte 0
sLastBank:
	.byte 0

.global sysScrnColors
.global sysMob0Clr
.global sysExtClr
sysScrnColors:
	.byte $bf
sys80ScrnColors: ; Wheels 128 only
	.byte $e0
sysMob0Clr:
	.byte 6
sysExtClr:
	.byte 0
sysBorder:
	.byte 0
sys80Border: ; Wheels 128 only
	.byte 0
miscColor:
	.byte $67
sysDBColor:
	.byte $63
appDBColor:
	.byte $41
menuColor:
	.byte $61
backColor:
	.byte $c3

backSysPattern: ; 8 byte system pattern
	.byte $52, $95, $2d, $52, $8a, $6d, $94, $a2
ramExpType:
	.byte 1 ; 1 = REU, 4 = SuperCPU?
relayDelay:
	.word $0800
.ifdef wheels_expose_mod_keys
modKeyCopy: ; SHIFT, CMDR, CTRL key indicator
	.byte 0
.endif
extKrnlIn:
	.byte 0
dbFieldWidth:
	.byte 0
fftIndicator:
	.byte 0

.segment "wheels_lokernal2"

IntRoutine: ; 128 irq and nmi routine
	.byte $68, $8d, $00, $ff
IrqRoutine: ; 64 irq routine
	.byte $68, $a8, $68, $aa, $68
nmiDefault: ; 64 nmi routine
	.byte $40

.endif

.segment "screensaver"

.ifdef wheels_screensaver
.import KbdScanAll
.global RunScreensaver
RunScreensaver:
	START_IO_X
	PushB extclr
	LoadB extclr, 0 ; black border
	PushB grcntrl1
	and #$6F
	sta grcntrl1 ; turn off screen
	END_IO_X
	cli
@1:	lda saverStatus ; wait for IRQ to disable screen saver
	lsr
	bcs @1
	sei
	START_IO_X
	PopB grcntrl1
	PopB extclr
	END_IO_X
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
@7:	lda saverCount+1
	sta saverTimer+1
	lda saverCount
	sta saverTimer
	sec
	rts
@8:	clc
	rts

	.byte 0, 0, 0, 0 ; ??? unused
.endif

.ifdef wheels
; called from extended KERNAL
.global Swap4000
Swap4000:
	LoadW r0, $4000 ; CBM address
	LoadW r1, $fe40 ; REU address
	LoadW r2, $01c0 ; size
	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr SwapRAM
	dec ramExpSize
	rts
.endif
