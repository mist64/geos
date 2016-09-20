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

.import FlaggedPutBlock
.import Add2
.import verifyFlag

.import DoneWithIO
.import InitForIO
.import EnterTurbo
.ifdef wheels
.import FetchRAM
.import WriteBlock
.endif

.global _WriteFile

.segment "files1b"

.ifdef wheels_external_readwrite_file
OWriteFile:
.else
_WriteFile:
.endif
	jsr EnterTurbo
.ifdef wheels
	beqx @X
	rts
@X:
.else
	bnex @2
	sta verifyFlag
.endif
	jsr InitForIO
	LoadW r4, diskBlkBuf
	PushW r6
	PushW r7
.ifndef wheels
	jsr DoWriteFile
	PopW r7
	PopW r6
	bnex @1
	dec verifyFlag
	jsr DoWriteFile
@1:	jsr DoneWithIO
@2:	rts

.endif
DoWriteFile:
	ldy #0
	lda (r6),y
	beq @2
	sta r1L
	iny
	lda (r6),y
	sta r1H
	dey
.ifdef wheels ; XXX why?
	AddVW 2, r6
.else
	jsr Add2
.endif
	lda (r6),y
	sta (r4),y
	iny
	lda (r6),y
	sta (r4),y
	ldy #$fe
.ifdef bsw128
	LoadB config, CRAM64K
.else
	LoadB CPU_DATA, RAM_64K
.endif
.ifdef wheels_external_readwrite_file
; special case RAM area occupied by this code
	lda r7H
	cmp #>$4F00
	bcc @1
	cmp #>$5200
	bcs @1
	jsr L5086
	bra @Y
.endif
@1:	dey
	lda (r7),y
	sta diskBlkBuf+2,y
	tya
	bne @1
@Y:
.ifdef bsw128
	LoadB config, CIOIN
.else
	LoadB CPU_DATA, KRNL_IO_IN
.endif
.ifdef wheels
	jsr WriteBlock
	bnex @3
	clc
	lda #$FE
	adc r7L
	sta r7L
	bcc DoWriteFile
	inc r7H
	bne DoWriteFile
.else
	jsr FlaggedPutBlock
	bnex @3
	AddVW $fe, r7
	bra DoWriteFile
.endif
@2:	tax
@3:
.ifdef wheels
	PopW r7
	PopW r6
	jmp DoneWithIO
.else
	rts
.endif

.ifdef wheels_external_readwrite_file
L5086:	PushW r9
	PushW r3
	PushW r2
	PushW r1
	PushW r0
	ldx #2
	lda r7H
	sta r9H
	lda r7L
	sta r9L
@1:	lda r9H
	cmp #>$5000
	bne @2
	lda r9L
	cmp #<$5000
@2:	bcc @4
	lda r9H
	cmp #$51
	bne @3
	lda r9L
	cmp #$5F
@3:	bcc @6
@4:	ldy #$00
	lda (r9),y
	sta diskBlkBuf,x
	clc
	lda #1
	adc r9L
	sta r9L
	bcc @5
	inc r9H
@5:	inx
	bne @1
	beq @B
@6:	jsr @C
	ldx r0L
@7:	clc
	lda #$01
	adc r9L
	sta r9L
	bcc @8
	inc r9H
@8:	inx
	beq @B
	lda r9H
	cmp #$51
	bne @9
	lda r9L
	cmp #$5F
@9:	bcc @7
	ldy #$00
@A:	lda (r9),y
	sta diskBlkBuf,x
	iny
	inx
	bne @A
@B:	PopW r0
	PopW r1
	PopW r2
	PopW r3
	PopW r9
	rts
@C:	sec
	lda r9L
	sbc #$00
	sta r1L
	lda r9H
	sbc #$50
	sta r1H
	stx r0L
	lda #$80
	sta r0H
	dex
	txa
	eor #$FF
	sta r2L
	lda #$00
	sta r2H
	clc
	lda #$7B
	adc r1L
	sta r1L
	lda #$0D
	adc r1H
	sta r1H
	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr FetchRAM
	dec ramExpSize
	rts
.endif

ASSERT_NOT_BELOW_IO

