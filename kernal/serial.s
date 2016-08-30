; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Serial number

.include "const.inc"
.include "kernal.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"

.global SerialNumber
.global _GetSerialNumber
.global GetSerialNumber2

.segment "serial1"

SerialNumber:
.if wheels
	.word $DF96
.else
	; This matches the serial in the cbmfiles.com GEOS64.D64
	.word $58B5

	.byte $FF ; ???
.endif

.segment "serial2"

;---------------------------------------------------------------
; GetSerialNumber                                         $C196
;
; Pass:      nothing
; Return:    r0  serial nbr of your kernal
; Destroyed: a
;---------------------------------------------------------------
_GetSerialNumber:
	lda SerialNumber
	sta r0L
GetSerialNumber2:
	lda SerialNumber+1
	sta r0H
	rts

.if !wheels
	.byte 1, $60 ; ???
.endif

.if wheels
.import KbdScanAll
.include "jumptab.inc"
.include "c64.inc"
L88B8 = $88B8
L88B6 = $88B6
; ----------------------------------------------------------------------------
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

; ----------------------------------------------------------------------------
        .byte   $00,$00,$00,$00                 ; CFD5 00 00 00 00              ....
; ----------------------------------------------------------------------------
        lda     #$40                            ; CFD9 A9 40                    .@
        sta     $03                             ; CFDB 85 03                    ..
        lda     #$00                            ; CFDD A9 00                    ..
        sta     r0L                           ; CFDF 85 02                    ..
        lda     #$FE                            ; CFE1 A9 FE                    ..
        sta     $05                             ; CFE3 85 05                    ..
        lda     #$40                            ; CFE5 A9 40                    .@
        sta     $04                             ; CFE7 85 04                    ..
        lda     #$01                            ; CFE9 A9 01                    ..
        sta     $07                             ; CFEB 85 07                    ..
        lda     #$C0                            ; CFED A9 C0                    ..
        sta     $06                             ; CFEF 85 06                    ..
        lda     $88C3                           ; CFF1 AD C3 88                 ...
        sta     $08                             ; CFF4 85 08                    ..
        inc     $88C3                           ; CFF6 EE C3 88                 ...
        jsr     SwapRAM                         ; CFF9 20 CE C2                  ..
        dec     $88C3                           ; CFFC CE C3 88                 ...
        rts                                     ; CFFF 60                       `
.endif