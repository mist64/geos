.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

.import KbdNextKey
L4400 = $4400
L9033 = $9033
L903F = $903F
L9063 = $9063
L906C = $906C
.import GetNewKernal
.import RstrKernal

.import WriteBlock
.import BlkAlloc
.import BBMult
.import GetBlock
.import DoneWithIO
.import ReadBlock
.import InitForIO
.import NewDisk
.import SetDevice
.import GetFreeDirBlk
.import PutBlock
.import PutDirHead
.import CalcBlksFree
.import FindFile
.import DeleteFile
.import OpenDisk
.import DoRAMOp
.import GetDirHead
.import i_MoveData

.ifdef wheels
L5704 = L7F0A - PRINTBASE + L50FA
L5708 = L7F0E - PRINTBASE + L50FA
L570B = L7F11 - PRINTBASE + L50FA
L5726 = L7F2C - PRINTBASE + L50FA
.endif

.segment "copyfile"

.ifdef wheels

CopyFile:
	ldx #$05
	lda dirEntryBuf
	and #$BF
	cmp #$84
	bne L500C
	rts

L500C:	ldx #$07
L500E:	lda r0L,x
	sta L5726,x
	dex
	bpl L500E
	lda r3L
L5018:	and #$3F
	sta L5704
	ldx #$1D
L501F:	.byte $BD
	.byte 0
L5021:	sty $9D
	php
	.byte $57
	dex
	bpl L501F
	ldy #$00
L502A:	lda (r0),y
	beq L5036
	sta L570B,y
	iny
	cpy #$10
	bcc L502A
L5036:	lda #$A0
L5038:	cpy #$10
	bcs L5042
	sta L570B,y
	iny
	bne L5038
L5042:	jsr i_MoveData
	.addr L50FA
	.addr PRINTBASE
	.word code2_end - code2_start
	lda curDrive
	sta $7F09
	jsr L9063
	lda r2L
	sta $7F0B
	jsr GetDirHead
	bne L509C
	lda r1H
	sta $7F0D
	lda r1L
	sta $7F0C
	lda $82AB
	sta $7AF8
	lda $82AC
	sta $7AF9
	lda #$00
	sta $7F01
	sta $7EFE
	lda #$84
	sta r6H
	lda #$00
	sta r6L
	jsr L50A7
	bnex L509C
	lda r1L
	sta $7EFA
	lda r1H
	sta $7EFB
	lda r5L
	sta $7EFC
	jmp PRINTBASE

L509C:	rts

L509D:	ldx $82AB
	ldy $82AC
	lda #$FF
	bne L50AF
L50A7:	ldx curDirHead
	ldy $8201
	lda #$00
L50AF:	stx r1L
	sty r1H
	sta $7EF9
	beqx L50F7
L50B9:	jsr ReadBuff
	bne L50F9
	lda #$80
	sta r5H
	lda #$02
	sta r5L
L50C6:	ldy #$00
	lda (r5),y
	beq L50DA
	ldy #$03
L50CE:	lda (r6),y
	cmp (r5),y
	bne L50DA
	iny
	cpy #$13
	bcc L50CE
	rts

L50DA:	clc
	lda r5L
	adc #$20
	sta r5L
	bcc L50C6
	lda diskBlkBuf+1
	sta r1H
	lda diskBlkBuf
	sta r1L
	bne L50B9
	bit $7EF9
	bmi L50F7
	jmp L509D

L50F7:	ldx #$05
L50F9:	rts

L50FA:
	.org $7900
code2_start:

	jsr L7945
	jsr L7951
	lda $8414
	sta r1H
	lda $8413
	sta r1L
	beq L792C
	jsr ReadBuff
	bne L792C
	inc L7F01
	jsr L7C56
	lda L7F23
	cmp #$01
	bne L792F
	cmp $8046
	bne L792F
	lda #$C0
	.byte $2C
L792C:	lda #$00
	.byte $2C
L792F:	lda #$80
	sta L7EF8
	jsr L79BC
	txa
	pha
	jsr L7B76
	jsr L7964
	jsr L7948
	pla
	tax
	rts

L7945:	ldx #$45
	.byte $2C
L7948:	ldx #$49
	jsr RstrKernal
	txa
	jmp GetNewKernal

L7951:	bit L7F32
	bvc L7963
	jsr L797A
	lda DBoxDescH
	sta L79BB
	lda DBoxDescL
	sta L79BA
L7963:	rts

L7964:	bit L7F32
	bvc L7976
	lda L79BB
	sta DBoxDescH
	lda L79BA
	sta DBoxDescL
	jsr L7977
L7976:	rts

L7977:	ldy #$91
	.byte $2C
L797A:	ldy #$90
	tya
	pha
	lda #$85
	sta r0H
	lda #$1F
	sta r0L
	lda #$B9
	sta r1H
	lda #$00
	sta r1L
	lda #$01
	sta r2H
	lda #$7A
	sta r2L
	lda #$00
	sta r3L
	jsr DoRAMOp
	pla
	tay
	lda #$88
	sta r0H
	lda #$0C
	sta r0L
	lda #$BA
	sta r1H
	lda #$7A
	sta r1L
	lda #$00
	sta r2H
	lda #$51
	sta r2L
	jmp DoRAMOp

L79BA:	.byte 0
L79BB:	.byte 0

L79BC:	lda #$00
	sta L7EFD
	bit L7F31
	bpl L79CB
	jsr L79EE
	bne L79ED
L79CB:	bit L7F33
	bpl L79D3
	jmp L7AFC

L79D3:	jsr L7C69
	bit L7EF8
	bpl L79E3
	bvc L79E3
	jsr L7C87
	bra L79E6
L79E3:	jsr L7D9C
L79E6:	txa
	pha
	jsr L7C6C
	pla
	tax
L79ED:	rts

L79EE:	jsr L7B79
	beq L79F4
L79F3:	rts

L79F4:	ldx L7F30
	jsr L5018
	bnex L79F3
	jsr OpenDisk
	bnex L79F3
	lda $82AB
	sta L7AFA
	lda $82AC
	sta L7AFB
	jsr L7AB4
	bit L7F33
	bmi L7A44
	bit L7F31
	bmi L7A31
	lda L7F2D
	sta r0H
	lda L7F2C
	sta r0L
	jsr DeleteFile
	beqx L7A49
	cpx #$05
	beq L7A49
	rts

L7A31:	lda L7F2D
	sta r6H
	lda L7F2C
	sta r6L
	jsr FindFile
	bnex L7A49
L7A41:	ldx #$FF
	rts

L7A44:	jsr L7A6E
	bne L7A41
L7A49:	jsr L7B67
	bnex L7A6D
	jsr CalcBlksFree
	lda r4L
	sta L7EFF
	lda r4H
	sta L7F00
	cmp L7F2B
	bne L7A66
	lda r4L
	cmp L7F2A
L7A66:	bcc L7A6B
	jmp PutDirHead

L7A6B:	ldx #$03
L7A6D:	rts

L7A6E:	lda L7F2D
	sta r6H
	lda L7F2C
	sta r6L
	jsr FindFile
	bnex L7AAE
	lda r1L
	cmp L7EFA
	bne L7AB1
	lda r1H
	cmp L7EFB
	bne L7AB1
	lda r5L
	cmp L7EFC
	bne L7AB1
	bit $9074
	bmi L7AAE
L7A98:	jsr L9033
	tya
	bne L7AAE
	ldy #$03
L7AA0:	lda (r5),y
	cmp L7F0E,y
	bne L7A98
	iny
	cpy #$13
	bne L7AA0
	beq L7AB1
L7AAE:	ldx #$00
	rts

L7AB1:	ldx #$FF
	rts

L7AB4:	bit L7F32
	bvs L7AF2
	lda L7F09
	cmp L7F0A
	bne L7AF2
	lda L7F0B
	cmp L7F30
	bne L7AF2
	lda curType
	and #$0F
	cmp #$04
	bne L7AF7
	bit L7F33
	bmi L7AEF
	lda L7EF9
	eor L7F32
	bpl L7AF2
	lda L7AF8
	cmp L7AFA
	bne L7AF2
	lda L7AF9
	cmp L7AFB
	bne L7AF2
L7AEF:	lda #$80
	.byte $2C
L7AF2:	lda #$00
	sta L7F33
L7AF7:	rts

L7AF8:	.byte 0
L7AF9:	.byte 0
L7AFA:	.byte 0
L7AFB:	.byte 0

L7AFC:	jsr L7B76
	bne L7B30
	lda L7EFA
	sta r1L
	lda L7EFB
	sta r1H
	jsr ReadBuff
	bne L7B30
	ldy L7EFC
	lda #$00
L7B15:	sta diskBlkBuf,y
	iny
	inx
	cpx #$1E
	bcc L7B15
	jsr L7BFB
	bne L7B30
	jsr L903F
	bne L7B30
	jsr L7B79
	bne L7B30
	jmp L7B49

L7B30:	rts

L7B31:	bit L7EF8
	bpl L7B49
	jsr L7C59
	lda L7F22
	sta r1H
	lda L7F21
	sta r1L
	jsr L903F
	beq L7B49
	rts

L7B49:	jsr L7B67
	bnex L7B66
L7B4F:	lda L7F0E,x
	sta diskBlkBuf,y
	iny
	inx
	cpx #$1E
	bcc L7B4F
	lda L7F33
	sta r3H
	jsr PutBlock
	jmp PutDirHead

L7B66:	rts

L7B67:	lda #$00
	sta r10L
	bit L7F32
	bpl L7B73
	jmp L906C

L7B73:	jmp GetFreeDirBlk

L7B76:	ldx #$00
	.byte $2C
L7B79:	ldx #$01
	cpx L7EFE
	bne L7B83
	ldx #$00
	rts

L7B83:	stx L7EFE
L7B86:	jsr L7C08
	bne L7BCD
	ldx L7EFE
	lda L7F09,x
	jsr SetDevice
	bne L7BCD
	lda L7F09
	cmp L7F0A
	bne L7BCF
	lda L7F0B
	cmp L7F30
	bne L7BAB
	bit L7F32
	bvc L7BCF
L7BAB:	ldx L7F30
	lda L7EFE
	bne L7BC2
	lda $9076
	sta L7F00
	lda $9075
	sta L7EFF
	ldx L7F0B
L7BC2:	jsr L5018
	beqx L7BCF
	bit L7F32
	bvs L7B86
L7BCD:	txa
	rts

L7BCF:	ldx L7F0C
	ldy L7F0D
	lda L7EFE
	beq L7BEC
	lda L7F00
	sta $9076
	lda L7EFF
	sta $9075
	ldx L7F2E
	ldy L7F2F
L7BEC:	stx $905C
	sty $905D
	jsr NewDisk
	bnex L7BCD
	jmp GetDirHead

L7BFB:	lda KbdNextKey
	cmp #$16
	beq L7C05
	ldx #$00
	rts

L7C05:	ldx #$0C
	rts

L7C08:	bit L7F32
	bvc L7C13
	ldx L7EFE
	jmp L5021

L7C13:	ldx #$00
	rts

L7C16:	jsr L7BFB
	beq L7C1C
	rts

L7C1C:	jsr InitForIO
L7C1F:	lda L7F02
	sta r4H
	lda #$00
	sta r4L
	jsr ReadBlock
	inc L7F02
	bnex L7C4A
	inc L7F01
	ldy #$01
	lda (r4),y
	sta r1H
	dey
	lda (r4),y
	sta r1L
	beq L7C48
	lda L7F02
	cmp #$44
	bcc L7C1F
L7C48:	ldx #$00
L7C4A:	jmp DoneWithIO

L7C4D:	lda #$81
	sta r4H
	lda #$00
	sta r4L
	rts

L7C56:	ldy #$90
	.byte $2C
L7C59:	ldy #$91
	lda #$80
	sta r0H
	lda #$C8
	sta r1H
	lda #$01
	sta r2H
	bne L7C7A
L7C69:	ldy #$90
	.byte $2C
L7C6C:	ldy #$91
	lda #$10
	sta r0H
	lda #$C9
	sta r1H
	lda #$35
	sta r2H
L7C7A:	lda #$00
	sta r0L
	sta r1L
	sta r2L
	sta r3L
	jmp DoRAMOp

L7C87:	jsr L7B76
	bne L7CAE
	lda #$10
	sta L7F02
	sta L7F03
	lda #$00
	sta L7F07
	sta L7F08
	lda L7F10
	sta r1H
	lda L7F0F
	sta r1L
	jsr L7C4D
	jsr GetBlock
	beq L7CAF
L7CAE:	rts

L7CAF:	inc L7F01
	ldy #$02
	sty L7F04
	sty L7F05
L7CBA:	ldy L7F04
	lda fileHeader+1,y
	sta r1H
	lda fileHeader,y
	sta r1L
	beq L7CEB
L7CC9:	jsr L7C16
	bnex L7CAE
	lda L7F02
	sta L7F03
	cmp #$44
	bcc L7CEB
	jsr L7D1F
	bnex L7CAE
	jsr L7B76
	bne L7D1E
	jsr L7E7B
	lda r1L
	bne L7CC9
L7CEB:	jsr L7BFB
	bne L7D1E
	inc L7F04
	inc L7F04
	bne L7CBA
	lda L7F02
	cmp #$10
	beq L7D06
	jsr L7D1F
	beqx L7D0B
	rts

L7D06:	jsr L7B79
	bne L7D1E
L7D0B:	jsr L7C4D
	lda L7F10
	sta r1H
	lda L7F0F
	sta r1L
	jsr PutBlock
	jmp L7B31

L7D1E:	rts

L7D1F:	bit L7EFD
	bmi L7D40
	bit L7F31
	bmi L7D40
	jsr i_MoveData
	.addr fileHeader
	.addr L4400
	.word $0100
	jsr L79EE
	bne L7D4B
	jsr i_MoveData
	.addr L4400
	.addr fileHeader
	.word $0100
L7D40:	jsr L7B79
	bne L7D4B
	jsr L7E5B
	beqx L7D4C
L7D4B:	rts

L7D4C:	jsr L7E14
	jsr InitForIO
	lda #$10
	sta L7F02
	lda L7F07
	bne L7D87
L7D5C:	ldx L7F05
	beq L7D93
L7D61:	lda fileHeader,x
	bne L7D73
	inx
	inx
	bne L7D61
	stx L7F05
	jsr DoneWithIO
	jmp PutDirHead

L7D73:	ldy L7F08
	lda $8301,y
	sta fileHeader+1,x
	lda fileTrScTab,y
	sta fileHeader,x
	inx
	inx
	stx L7F05
L7D87:	jsr L7EAF
	bne L7D99
	lda L7F02
	cmp #$43
	bcc L7D5C
L7D93:	jsr DoneWithIO
	jmp PutDirHead

L7D99:	jmp DoneWithIO

L7D9C:	jsr L7B76
	bne L7E13
	lda L7F10
	sta r1H
	lda L7F0F
	sta r1L
	lda #$10
	sta L7F02
	sta L7F03
	lda #$00
	sta L7F08
L7DB8:	jsr L7C16
	bnex L7E13
L7DBE:	lda L7F02
	sta L7F03
	bit L7EFD
	bmi L7DD4
	bit L7F31
	bmi L7DD4
	jsr L79EE
	beq L7DD4
	rts

L7DD4:	jsr L7B79
	bne L7E13
	jsr L7E5B
	bnex L7E13
	jsr L7E14
	jsr InitForIO
	lda #$10
	sta L7F02
	jsr L7EAF
	bne L7E10
	jsr DoneWithIO
	jsr PutDirHead
	bnex L7E13
	lda L7F03
	cmp #$44
	bcc L7E0D
	jsr L7B76
	bne L7E13
	jsr L7E7B
	lda r1L
	bne L7DB8
	beq L7DBE
L7E0D:	jmp L7B31

L7E10:	jmp DoneWithIO

L7E13:	rts

L7E14:	bit L7EFD
	bmi L7E50
	bit L7EF8
	bmi L7E2D
	lda $8301
	sta L7F10
	lda fileTrScTab
	sta L7F0F
	bra L7E50
L7E2D:	lda $8301
	sta L7F22
	lda fileTrScTab
	sta L7F21
	lda $8303
	sta L7F10
	lda $8302
	sta L7F0F
	bit L7EF8
	bvc L7E4D
	lda #$04
	.byte $2C
L7E4D:	lda #$02
	.byte $2C
L7E50:	lda #$00
	sta L7F08
	lda #$80
	sta L7EFD
	rts

L7E5B:	lda L7F01
	sta r1L
	bne L7E64
	tax
	rts

L7E64:	lda #$FE
	sta r2L
	ldx #$06
	ldy #$04
	jsr BBMult
	ldy L7F08
	sty r6L
	lda #$83
	sta r6H
	jmp BlkAlloc

L7E7B:	ldy #$00
L7E7D:	lda $4300,y
	sta $1000,y
	iny
	bne L7E7D
	lda #$11
	sta L7F02
	ldy L7F08
	lda fileTrScTab,y
	sta fileTrScTab
	lda $8301,y
	sta $8301
	lda #$00
	sta L7F01
	lda #$02
	sta L7F08
	lda $1001
	sta r1H
	lda $1000
	sta r1L
	rts

L7EAF:	lda L7F02
	sta r4H
	lda #$00
	sta r4L
	ldx L7F08
	lda $8301,x
	sta r1H
	lda fileTrScTab,x
	sta r1L
	ldy #$00
	lda (r4),y
	beq L7ED7
	iny
	lda $8303,x
	sta (r4),y
	dey
	lda $8302,x
	sta (r4),y
L7ED7:	inx
	inx
	stx L7F08
	jsr WriteBlock
	inc L7F02
	bnex L7EF7
	ldy #$00
	lda (r4),y
	sta L7F07
	beq L7EF5
	lda L7F02
	cmp #$43
	bcc L7EAF
L7EF5:	ldx #$00
L7EF7:	rts

L7EF8:	.byte 0
L7EF9:	.byte 0
L7EFA:	.byte 0
L7EFB:	.byte 0
L7EFC:	.byte 0
L7EFD:	.byte 0
L7EFE:	.byte 0
L7EFF:	.byte 0
L7F00:	.byte 0
L7F01:	.byte 0
L7F02:	.byte 0
L7F03:	.byte 0
L7F04:	.byte 0
L7F05:	.byte 0
	.byte 0
L7F07:	.byte 0
L7F08:	.byte 0
L7F09:	.byte 0
L7F0A:	.byte 0
L7F0B:	.byte 0
L7F0C:	.byte 0
L7F0D:	.byte 0
L7F0E:	.byte 0
L7F0F:	.byte 0
L7F10:	.byte 0
L7F11:	.res 16, 0
L7F21:	.byte 0
L7F22:	.byte 0
L7F23:	.byte 0, 0, 0, 0, 0, 0, 0
L7F2A:	.byte 0
L7F2B:	.byte 0
L7F2C:	.byte 0
L7F2D:	.byte 0
L7F2E:	.byte 0
L7F2F:	.byte 0
L7F30:	.byte 0
L7F31:	.byte 0
L7F32:	.byte 0
L7F33:	.byte 0

code2_end:

.endif
