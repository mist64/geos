; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/REU driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

; syscalls
.global _DoRAMOp
.global _FetchRAM
.global _StashRAM
.global _SwapRAM
.global _VerifyRAM

.segment "reu"

.ifdef REUPresent
_VerifyRAM:
	ldy #$93
.ifdef wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_StashRAM:
	ldy #$90
.ifdef wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_SwapRAM:
	ldy #$92
.ifdef wheels_size
	.byte $2c
.else
	bne _DoRAMOp
.endif
_FetchRAM:
	ldy #$91
_DoRAMOp:
	ldx #DEV_NOT_FOUND
	lda r3L
	cmp ramExpSize
	bcs @3 ; beyond end of REU
.ifdef wheels
	php
	sei
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN

	PushB clkreg
	LoadB clkreg, 0
	ldx #4
@1:	lda r0L-1,x
	sta EXP_BASE+1,x
	dex
	bne @1
	MoveW r2, EXP_BASE+7
	lda r3L
	sta EXP_BASE+6
	stx EXP_BASE+9
	stx EXP_BASE+10
	sty EXP_BASE+1
	ldx EXP_BASE+1
	PopB clkreg
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	plp
	txa
	and #%01100000
	cmp #%01100000
	beq @2
	ldx #0
	.byte $2c
@2:	ldx #WR_VER_ERR
.else
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	MoveW r0, EXP_BASE+2
	MoveW r1, EXP_BASE+4
	MoveB r3L, EXP_BASE+6
	MoveW r2, EXP_BASE+7
	lda #0
	sta EXP_BASE+9
	sta EXP_BASE+10
	sty EXP_BASE+1
@1:	lda EXP_BASE
	and #%01100000
	beq @1
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	ldx #0
.endif
@3:	rts
.endif ; REUPresent

