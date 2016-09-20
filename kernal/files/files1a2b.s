; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import verifyFlag
.import Add2_return

.import WriteBlock
.import VerWriteBlock
.import DoneWithIO
.import ReadBlock
.import InitForIO
.import EnterTurbo
.ifdef wheels
.import StashRAM
.endif

.global FlaggedPutBlock
.global _ReadFile

.segment "files1a2b"

ASSERT_NOT_BELOW_IO

.ifdef wheels_external_readwrite_file
OReadFile:
.else
_ReadFile:
.endif
	jsr EnterTurbo
.ifdef wheels
	beqx @X
	rts
@X:
.else
.if 0 ; XXX cc65 issue: branch can't cross segment
	bnex Add2_return
.else
	txa
	.byte $d0, <(Add2_return - (* + 1))
.endif
.endif
	jsr InitForIO
	PushW r0
	LoadW r4, diskBlkBuf
	LoadB r5L, 2
	MoveW r1, fileTrScTab+2
@1:	jsr ReadBlock
	bnex @7
	ldy #$fe
	lda diskBlkBuf
	bne @2
	ldy diskBlkBuf+1
.ifdef wheels
	beq @6
.endif
	dey
	beq @6
@2:	lda r2H
	bne @3
	cpy r2L
	bcc @3
	beq @3
	ldx #BFR_OVERFLOW
	bne @7
@3:	sty r1L
.ifdef bsw128
	LoadB config, CRAM64K
.else
	LoadB CPU_DATA, RAM_64K
.endif
.ifdef wheels_external_readwrite_file
	; special case RAM area occupied by this code
	lda r7H
	cmp #>$4F00
	bcc @4
	cmp #>$5200
	bcs @4
	jsr L50A4
	bra @Y
.endif
@4:	lda diskBlkBuf+1,y
	dey
	sta (r7),y
	bne @4
@Y:
.ifdef bsw128
	LoadB config, CIOIN
.else
	LoadB CPU_DATA, KRNL_IO_IN
.endif
	AddB r1L, r7L
	bcc @5
	inc r7H
@5:	SubB r1L, r2L
	bcs @6
	dec r2H
@6:	inc r5L
	inc r5L
	ldy r5L
	MoveB diskBlkBuf+1, r1H
	sta fileTrScTab+1,y
	MoveB diskBlkBuf, r1L
	sta fileTrScTab,y
	bne @1
	ldx #0
@7:	PopW r0
	jmp DoneWithIO

.ifdef wheels_external_readwrite_file
L50A4:	PushB r10L
	PushW r9
	PushW r3
	PushW r2
	PushW r1
	PushW r0
	ldx #0
	sty r10L
	MoveW r7, r9
@1:	lda r9H
	cmp #>$5000
	bne @2
	lda r9L
	cmp #<$5000
@2:	bcc @4
	lda r9H
	cmp #>$51C2
	bne @3
	lda r9L
	cmp #<$51C2
@3:	bcc @6
@4:	ldy #0
	lda diskBlkBuf+2,x
	sta (r9),y
	clc
	lda #1
	adc r9L
	sta r9L
	bcc @5
	inc r9H
@5:	inx
	cpx r10L
	bcc @1
	bcs @8
@6:	jsr @9
	clc
	lda r9L
	adc r2L
	sta r9L
	lda r9H
	adc r2H
	sta r9H
	clc
	lda r0L
	adc r2L
	bcs @8
	tax
	dex
	dex
	cpx r10L
	bcs @8
	ldy #0
@7:	lda diskBlkBuf+2,x
	sta (r9),y
	iny
	inx
	cpx r10L
	bcc @7
@8:	PopW r0
	PopW r1
	PopW r2
	PopW r3
	PopW r9
	PopB r10L
	rts
@9:	sec
	lda r9L
	sbc #<$5000
	sta r1L
	lda r9H
	sbc #>$5000
	sta r1H
	txa
	add #2
	sta r0L
	lda #$80
	sta r0H
	stx r2L
	sec
	lda r10L
	sbc r2L
	sta r2L
	lda #$00
	sta r2H
	clc
	lda r1L
	adc r2L
	sta r3L
	lda r1H
	adc r2H
	sta r3H
	lda r3H
	cmp #$01
	bne @A
	lda r3L
	cmp #$C2
@A:	bcc @B
	sec
	lda r3L
	sbc #$C2
	sta r3L
	lda r3H
	sbc #$01
	sta r3H
	sec
	lda r2L
	sbc r3L
	sta r2L
	lda r2H
	sbc r3H
	sta r2H
@B:	clc
	lda #$27
	adc r1L
	sta r1L
	lda #$06
	adc r1H
	sta r1H
	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr StashRAM
	dec ramExpSize
	rts
.endif

.ifndef wheels_external_readwrite_file
FlaggedPutBlock:
	lda verifyFlag
	beq @1
	jmp VerWriteBlock
@1:	jmp WriteBlock
.endif

