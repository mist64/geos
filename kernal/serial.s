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
LFB71 = $FB71
.include "jumptab.inc"
.include "c64.inc"
; ----------------------------------------------------------------------------
LCF55:
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushB extclr
	LoadB extclr, 0
	PushB grcntrl1
	and #$6F
	sta grcntrl1
	stx CPU_DATA
	cli
@1:	lda saverStatus
	lsr
	bcs @1
	sei
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	PopB grcntrl1
	PopB extclr
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

; ----------------------------------------------------------------------------
LCF88:  lda     saverStatus                           ; CF88 AD B4 88                 ...
        lsr     a                               ; CF8B 4A                       J
        bcs     LCF9A                           ; CF8C B0 0C                    ..
        lda     saverStatus                           ; CF8E AD B4 88                 ...
        and     #$30                            ; CF91 29 30                    )0
        bne     LCF98                           ; CF93 D0 03                    ..
        jsr     LCFB2                           ; CF95 20 B2 CF                  ..
LCF98:  clc                                     ; CF98 18                       .
        rts                                     ; CF99 60                       `

; ----------------------------------------------------------------------------
LCF9A:  jsr     LCFB2                           ; CF9A 20 B2 CF                  ..
        bcc     LCFB0                           ; CF9D 90 11                    ..
        lda     saverStatus                           ; CF9F AD B4 88                 ...
        and     #$7E                            ; CFA2 29 7E                    )~
        sta     saverStatus                           ; CFA4 8D B4 88                 ...
LCFA7:  jsr     LFB71                           ; CFA7 20 71 FB                  q.
        bne     LCFA7                           ; CFAA D0 FB                    ..
        lda     #$00                            ; CFAC A9 00                    ..
        sta     $39                             ; CFAE 85 39                    .9
LCFB0:  sec                                     ; CFB0 38                       8
        rts                                     ; CFB1 60                       `

; ----------------------------------------------------------------------------
LCFB2:  lda     saverStatus                           ; CFB2 AD B4 88                 ...
        and     #$02                            ; CFB5 29 02                    ).
        bne     LCFC0                           ; CFB7 D0 07                    ..
        lda     $8506                           ; CFB9 AD 06 85                 ...
        cmp     #$FF                            ; CFBC C9 FF                    ..
        bne     LCFC5                           ; CFBE D0 05                    ..
LCFC0:  jsr     LFB71                           ; CFC0 20 71 FB                  q.
        beq     LCFD3                           ; CFC3 F0 0E                    ..
LCFC5:  lda     $88B8                           ; CFC5 AD B8 88                 ...
        sta     $88B6                           ; CFC8 8D B6 88                 ...
        lda     saverCount                           ; CFCB AD B7 88                 ...
        sta     saverTimer                           ; CFCE 8D B5 88                 ...
        sec                                     ; CFD1 38                       8
        rts                                     ; CFD2 60                       `

; ----------------------------------------------------------------------------
LCFD3:  clc                                     ; CFD3 18                       .
        rts                                     ; CFD4 60                       `

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