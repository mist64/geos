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

.else
;---------------------------------------------------------------
; Panic                                                   $C2C2
;
; Pass:      nothing
; Return:    does not return
;---------------------------------------------------------------
_Panic:
.if wheels
	sec
	pla
	sbc #2
	tay
	pla
	sbc #0
.else
	PopW r0
	SubVW 2, r0
	lda r0H
.endif
	ldx #0
	jsr @1
.if wheels
	tya
.else
	lda r0L
.endif
	jsr @1
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
.if wheels
	jmp EnterDeskTop
.endif
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
	addv '0'
	bne @4
@3:	addv '0'+7
@4:	sta _PanicAddr,x
	rts

_PanicDB_DT:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
.if wheels
	.byte DBSYSOPV
.endif
	.byte NULL

_PanicDB_Str:
	.byte BOLDON
.if wheels_size
	.byte "Error near "
.else
	.byte "System error near "
.endif
.endif

	.byte "$"
_PanicAddr:
	.byte "xxxx"
	.byte NULL
