; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Serial number

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"

.global SerialNumber
.global _GetSerialNumber
.global GetSerialNumber2

.segment "serial1"

.if !wheels
SerialNumber:
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
	lda $9FF4;xxxSerialNumber
	sta r0L
GetSerialNumber2:
	lda $9FF5;xxxSerialNumber+1
	sta r0H
	rts

.if !wheels
	.byte 1, $60 ; ???
.endif

.if wheels
LFB71 = $FB71
.include "jumptab.inc"
; ----------------------------------------------------------------------------
LCF55:  ldx     $01                             ; CF55 A6 01                    ..
        lda     #$35                            ; CF57 A9 35                    .5
        sta     $01                             ; CF59 85 01                    ..
        lda     $D020                           ; CF5B AD 20 D0                 . .
        pha                                     ; CF5E 48                       H
        lda     #$00                            ; CF5F A9 00                    ..
        sta     $D020                           ; CF61 8D 20 D0                 . .
        lda     $D011                           ; CF64 AD 11 D0                 ...
        pha                                     ; CF67 48                       H
        and     #$6F                            ; CF68 29 6F                    )o
        sta     $D011                           ; CF6A 8D 11 D0                 ...
        stx     $01                             ; CF6D 86 01                    ..
        cli                                     ; CF6F 58                       X
LCF70:  lda     $88B4                           ; CF70 AD B4 88                 ...
        lsr     a                               ; CF73 4A                       J
        bcs     LCF70                           ; CF74 B0 FA                    ..
        sei                                     ; CF76 78                       x
        ldx     $01                             ; CF77 A6 01                    ..
        lda     #$35                            ; CF79 A9 35                    .5
        sta     $01                             ; CF7B 85 01                    ..
        pla                                     ; CF7D 68                       h
        sta     $D011                           ; CF7E 8D 11 D0                 ...
        pla                                     ; CF81 68                       h
        sta     $D020                           ; CF82 8D 20 D0                 . .
        stx     $01                             ; CF85 86 01                    ..
        rts                                     ; CF87 60                       `

; ----------------------------------------------------------------------------
LCF88:  lda     $88B4                           ; CF88 AD B4 88                 ...
        lsr     a                               ; CF8B 4A                       J
        bcs     LCF9A                           ; CF8C B0 0C                    ..
        lda     $88B4                           ; CF8E AD B4 88                 ...
        and     #$30                            ; CF91 29 30                    )0
        bne     LCF98                           ; CF93 D0 03                    ..
        jsr     LCFB2                           ; CF95 20 B2 CF                  ..
LCF98:  clc                                     ; CF98 18                       .
        rts                                     ; CF99 60                       `

; ----------------------------------------------------------------------------
LCF9A:  jsr     LCFB2                           ; CF9A 20 B2 CF                  ..
        bcc     LCFB0                           ; CF9D 90 11                    ..
        lda     $88B4                           ; CF9F AD B4 88                 ...
        and     #$7E                            ; CFA2 29 7E                    )~
        sta     $88B4                           ; CFA4 8D B4 88                 ...
LCFA7:  jsr     LFB71                           ; CFA7 20 71 FB                  q.
        bne     LCFA7                           ; CFAA D0 FB                    ..
        lda     #$00                            ; CFAC A9 00                    ..
        sta     $39                             ; CFAE 85 39                    .9
LCFB0:  sec                                     ; CFB0 38                       8
        rts                                     ; CFB1 60                       `

; ----------------------------------------------------------------------------
LCFB2:  lda     $88B4                           ; CFB2 AD B4 88                 ...
        and     #$02                            ; CFB5 29 02                    ).
        bne     LCFC0                           ; CFB7 D0 07                    ..
        lda     $8506                           ; CFB9 AD 06 85                 ...
        cmp     #$FF                            ; CFBC C9 FF                    ..
        bne     LCFC5                           ; CFBE D0 05                    ..
LCFC0:  jsr     LFB71                           ; CFC0 20 71 FB                  q.
        beq     LCFD3                           ; CFC3 F0 0E                    ..
LCFC5:  lda     $88B8                           ; CFC5 AD B8 88                 ...
        sta     $88B6                           ; CFC8 8D B6 88                 ...
        lda     $88B7                           ; CFCB AD B7 88                 ...
        sta     $88B5                           ; CFCE 8D B5 88                 ...
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