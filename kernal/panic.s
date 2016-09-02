; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Panic

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

.segment "panic"

; syscall
.global _Panic

.if gateway
_Panic:
	; On the gateWay KERNAL, the "Panic" syscall points to
	; the EnterDesktop implementation. The BRK vector still
	; points here though.
	;
	; This seems to deal with swapping the disk driver from
	; and to the REU, triggered by the RESTORE key.
	sei
	pha
	txa
	pha
	tya
	pha
	lda CPU_DATA
	pha
	ldx StackPtr
	bne @1
	tsx
@1:	txs
	stx StackPtr
	ldx #0
@2:	dex
	bne @2
	jsr SwapMemory
	jmp DISK_BASE

; ??? no entry?
	ldx StackPtr
	txs
	jsr SwapMemory
	stx StackPtr
	LoadW NMI_VECTOR, _Panic
	pla
	sta CPU_DATA
	pla
	tay
	pla
	tax
	pla
	rti

SwapRegs:
	ldx #6
@1:	lda r0,x
	tay
	lda SwapRAMArgs,x
	sta r0,x
	tya
	sta SwapRAMArgs,x
	dex
	bpl @1
	rts

SwapMemory:
	jsr SwapRegs
	jsr SwapRAM
	jsr SwapRegs
	inx
	rts

SwapRAMArgs:
	.word DISK_BASE ; CBM addr
	.word $c000     ; REU addr
	.word 0         ; count
	.byte 0         ; REU bank

	.byte 0, 0 ; XXX

StackPtr:
	.byte 0

	.byte 0, 0, 0 ; PADDING

.elseif wheels
_Panic:
	sec                                     ; CEF0 38                       8
	pla                                     ; CEF1 68                       h
	sbc     #$02                            ; CEF2 E9 02                    ..
	tay                                     ; CEF4 A8                       .
	pla                                     ; CEF5 68                       h
	sbc     #$00                            ; CEF6 E9 00                    ..
	ldx     #$00                            ; CEF8 A2 00                    ..
	jsr     LCF0F                           ; CEFA 20 0F CF                  ..
	tya                                     ; CEFD 98                       .
	jsr     LCF0F                           ; CEFE 20 0F CF                  ..
	lda     #$CF                            ; CF01 A9 CF                    ..
	sta     r0H                             ; CF03 85 03                    ..
	lda     #$30                            ; CF05 A9 30                    .0
	sta     r0L                           ; CF07 85 02                    ..
	jsr     DoDlgBox                        ; CF09 20 56 C2                  V.
	jmp     EnterDeskTop                    ; CF0C 4C 2C C2                 L,.

LCF0F:  pha                                     ; CF0F 48                       H
        lsr     a                               ; CF10 4A                       J
        lsr     a                               ; CF11 4A                       J
        lsr     a                               ; CF12 4A                       J
        lsr     a                               ; CF13 4A                       J
        jsr     LCF20                           ; CF14 20 20 CF                   .
        inx                                     ; CF17 E8                       .
        pla                                     ; CF18 68                       h
        and     #$0F                            ; CF19 29 0F                    ).
        jsr     LCF20                           ; CF1B 20 20 CF                   .
        inx                                     ; CF1E E8                       .
        rts                                     ; CF1F 60                       `

LCF20:  cmp     #$0A                            ; CF20 C9 0A                    ..
        bcs     LCF29                           ; CF22 B0 05                    ..
        clc                                     ; CF24 18                       .
        adc     #$30                            ; CF25 69 30                    i0
        bne     LCF2C                           ; CF27 D0 03                    ..
LCF29:  clc                                     ; CF29 18                       .
        adc     #$37                            ; CF2A 69 37                    i7
LCF2C:  sta     _PanicAddr,x                         ; CF2C 9D 45 CF                 .E.
        rts                                     ; CF2F 60                       `


.else
;---------------------------------------------------------------
; Panic                                                   $C2C2
;
; Pass:      nothing
; Return:    does not return
;---------------------------------------------------------------
_Panic:
	PopW r0
	SubVW 2, r0
	lda r0H
	ldx #0
	jsr @1
	lda r0L
	jsr @1
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
@1:	pha
	lsr
	lsr
	lsr
	lsr
	jsr @2
	inx
	pla
	and #%00001111
	jsr @2
	inx
	rts
@2:	cmp #10
	bcs @3
	addv ('0')
	bne @4
@3:	addv ('0'+7)
@4:	sta _PanicAddr,x
	rts


.endif

_PanicDB_DT:
.if wheels
        .byte DEF_DB_POS | 1, DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.byte $38,$CF,$0E
	.byte NULL
.else
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
.endif

_PanicDB_Str:
	.byte BOLDON
.if wheels_size
	.byte "Error near "
.else
	.byte "System error near "
.endif

	.byte "$"
_PanicAddr:
	.byte "xxxx"
	.byte NULL
