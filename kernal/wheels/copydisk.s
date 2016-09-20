.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

L903F = $903F
L9050 = $9050
L9063 = $9063
.import GetNewKernal
.import RstrKernal

.import FetchRAM
.import WriteBlock
.import StashRAM
.import BMult
.import ReadBlock
.import DoneWithIO
.import InitForIO
.import DoRAMOp
.import NewDisk
.import FindBAMBit
.import GetDirHead
.import EnterTurbo
.import SetDevice
.import OpenDisk
.import i_MoveData

.ifdef wheels
L5087 = L793F - PRINTBASE + L5048
L5721 = L7FD9 - PRINTBASE + L5048
L5722 = L7FDA - PRINTBASE + L5048
L5723 = L7FDB - PRINTBASE + L5048
L5724 = L7FDC - PRINTBASE + L5048
L5725 = L7FDD - PRINTBASE + L5048
L5727 = L7FDF - PRINTBASE + L5048
L5729 = L7FE1 - PRINTBASE + L5048
L572D = L7FE5 - PRINTBASE + L5048
L5732 = L7FEA - PRINTBASE + L5048
.endif

.segment "copydisk"

.ifdef wheels

CopyDisk:
	lda #$00
	.byte $2c
TestCompatibility:
	lda #$80
	sta L5087
	lda r2L
	sta L5724
	lda r3L
L500F:	sta L5732
	and #$3F
	sta L5722
	.byte $AD
L5018:	.byte $89
	sty z8d
L501B:	and ($57,x)
	.byte $20
L501E:	.byte $63
	.byte $90, $A5
L5021:	asl z8d
	.byte $23
	.byte $57
	lda curType
	and #$0F
	sta L5725
	sta L5729
	lda $9062
	sta L5727
	lda $8203
	sta L572D
	jsr i_MoveData
	.addr L5048
	.addr PRINTBASE
	.word $06EB
	jmp PRINTBASE

L5048:
	.org PRINTBASE
code2_start:
	lda #$00
	sta L7B8F
	sta L79A8
	jsr RstrKernal
	lda #$45
	jsr GetNewKernal
	jsr L79C9
	bnex L7929
	bit L793F
	bmi L7929
	jsr RstrKernal
	jsr L7940
	lda #$45
	jsr GetNewKernal
	jsr L7BC7
L7929:	txa
	pha
	jsr L7B52
	jsr OpenDisk
	jsr RstrKernal
	jsr L79B0
	lda #$48
	jsr GetNewKernal
	pla
	tax
	rts

L793F:	.byte 0

L7940:	lda L7FDE
	bpl L7946
L7945:	rts

L7946:	and #$F0
	cmp #$30
	beq L7945
	lda L7FDD
	bmi L7945
	and #$F0
	cmp #$30
	beq L7945
	lda #$40
	jsr GetNewKernal
	jsr L500F
	lda r2L
	beq L79A0
	bpl L7967
	lda #$80
L7967:	sta L79A8
	ldy #$01
L796C:	jsr L501E
	lda r3L
	beq L797A
	iny
	cpy #$09
	bcc L796C
	bcs L79A0
L797A:	lda L79A8
	sta r2L
	lda #$5D
	sta r7L
	lda #$79
	sta r0H
	lda #$AB
	sta r0L
	ldy #$00
	sty r3L
	jsr L5018
	bnex L79A0
	lda r3L
	sta L79A9
	sty L79AA
	jmp RstrKernal

L79A0:	lda #$00
	sta L79A8
	jmp RstrKernal

L79A8:	.byte 0
L79A9:	.byte 0
L79AA:	.byte 0

	.byte "DC98"
	.byte 0

L79B0:	bit L793F
	bpl L79B6
L79B5:	rts

L79B6:	lda L79A8
	beq L79B5
	lda #$40
	jsr GetNewKernal
	ldy L79AA
	jsr L501B
	jmp RstrKernal

L79C9:	lda #$01
	sta L7B8F
	lda L7FDA
	jsr SetDevice
	bne L79F6
	bit L7FEA
	bvc L7A09
	lda curType
	and #$F0
	beq L79F1
	cmp #$10
	beq L79F1
	lda L7FEA
	and #$BF
	sta L7FEA
	bra L7A09
L79F1:	jsr L7B90
	beq L79F7
L79F6:	rts

L79F7:	lda curType
	and #$F0
	beq L7A09
	jsr L501E
	jsr L9063
	lda r2L
	sta L7FDC
L7A09:	jsr EnterTurbo
	ldx L7FDC
	jsr L5018
	bnex L7A63
	jsr L9050
	bnex L7A63
	lda $8203
	sta L7FE6
	lda curType
	and #$0F
	sta L7FDE
	cmp L7FDD
	bne L7A31
	jmp L7A64

L7A31:	cmp #$03
	bcs L7A5E
	lda L7FDD
	cmp #$03
	bcs L7A5E
	cmp #$01
	bne L7A47
	lda L7FE5
	bmi L7A5E
	bpl L7A56
L7A47:	lda L7FE6
	bmi L7A5E
	lda L7FE5
	bpl L7A56
	jsr L7AB3
	bne L7A61
L7A56:	lda #$01
	sta L7FE1
	ldx #$00
	rts

L7A5E:	ldx #$73
	rts

L7A61:	ldx #$03
L7A63:	rts

L7A64:	lda L7FE1
	cmp #$03
	beq L7AAA
	cmp #$04
	bne L7A81
	lda $9062
	sta L7FE0
	cmp L7FDF
	bcs L7AAA
	jsr L7AE1
	bne L7AB0
	beq L7AAA
L7A81:	cmp #$01
	bne L7A8F
	lda L7FE5
	ora L7FE6
	bmi L7AAD
	bpl L7AA2
L7A8F:	cmp #$02
	bne L7AAD
	lda L7FE5
	bpl L7AA2
	lda L7FE6
	bmi L7AA5
	jsr L7AB3
	bne L7AB0
L7AA2:	lda #$01
	.byte $2C
L7AA5:	lda #$02
	sta L7FE1
L7AAA:	ldx #$00
	rts

L7AAD:	ldx #$73
	rts

L7AB0:	ldx #$03
	rts

L7AB3:	jsr L7B52
	jsr GetDirHead
	lda #$24
	sta r1L
	lda #$00
	sta r1H
L7AC1:	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr FindBAMBit
	beq L7ADE
L7ACE:	jsr L7E74
	lda r1L
	cmp #$35
	beq L7ACE
	cmp #$47
	bcc L7AC1
	ldx #$00
	rts

L7ADE:	ldx #$06
	rts

L7AE1:	jsr L7B52
	lda #$01
	sta r1L
	lda L7FDF
	jsr L7B38
	sty L7FE8
	add #$02
	sta L7FE7
	lda L7FE0
	jsr L7B38
	sty L7FE9
	add #$02
	sta r1H
	jsr ReadBuff
	bnex L7B37
L7B0B:	ldy L7FE9
	lda diskBlkBuf,y
	cmp #$FF
	bne L7B35
	iny
	sty L7FE9
	bne L7B23
	inc r1H
	jsr ReadBuff
	bnex L7B37
L7B23:	lda r1H
	cmp L7FE7
	bcc L7B0B
	lda L7FE9
	cmp L7FE8
	bcc L7B0B
	ldx #$00
	rts

L7B35:	ldx #$03
L7B37:	rts

L7B38:	ldx #$00
	stx r1H
	add #$01
	asl a
	rol r1H
	asl a
	rol r1H
	asl a
	rol r1H
	asl a
	rol r1H
	asl a
	rol r1H
	tay
	lda r1H
	rts

L7B52:	ldx #$00
	.byte $2C
L7B55:	ldx #$01
	cpx L7B8F
	beq L7B8B
	stx L7B8F
	lda L7FD9,x
	jsr SetDevice
	bne L7B8D
	lda L7FD9
	cmp L7FDA
	bne L7B7E
	jsr L7B90
	bne L7B8D
	ldx L7B8F
	lda L7FDB,x
	tax
	jsr L5018
L7B7E:	jsr EnterTurbo
	lda curType
	cmp #$03
	bcs L7B8B
	jsr NewDisk
L7B8B:	ldx #$00
L7B8D:	txa
	rts

L7B8F:	.byte 0

L7B90:	bit L7FEA
	bvc L7B9B
	ldx L7B8F
	jmp L5021

L7B9B:	ldx #$00
	rts

L7B9E:	ldx #$00
	lda #$7F
	sta $DC00
	bit $DC01
	bmi L7BAC
	ldx #$0C
L7BAC:	txa
	rts

L7BAE:	ldy #$90
	.byte $2C
L7BB1:	ldy #$91
	ldx #$06
L7BB5:	lda L7BC0,x
	sta r0L,x
	dex
	bpl L7BB5
	jmp DoRAMOp

L7BC0:	.byte $00,$10,$00,$C8,$00,$36,$00
L7BC7:	lda L7FE1
	cmp #$01
	beq L7BE8
	cmp #$02
	beq L7BE5
	cmp #$03
	beq L7BE2
	lda L7FDF
	cmp L7FE0
	bcc L7BE1
	lda L7FE0
L7BE1:	.byte $2C
L7BE2:	lda #$50
	.byte $2C
L7BE5:	lda #$46
	.byte $2C
L7BE8:	lda #$23
	sta L7FE4
	ldx #$00
	stx L7FE3
	inx
	stx L7FE2
	jsr L7BAE
	ldx L79A8
	beq L7BFF
	dex
L7BFF:	stx L7FD6
	jsr L7B52
	jsr GetDirHead
	bnex L7C33
L7C0B:	jsr L7B52
	bne L7C33
	jsr L7D02
	bne L7C33
	lda L7C40
	beq L7C31
	jsr L7B55
	bne L7C33
	jsr L7EB8
	bne L7C33
	lda L7FE2
	beq L7C31
	lda L7FE4
	cmp L7FE2
	bcs L7C0B
L7C31:	lda #$00
L7C33:	pha
	tax
	bne L7C3A
	jsr L7C41
L7C3A:	jsr L7BB1
	pla
	tax
	rts

L7C40:	.byte 0

L7C41:	jsr L7B55
	lda L7FE1
	cmp #$04
	beq L7C9C
	cmp #$03
	beq L7CB0
	cmp #$02
	beq L7CB0
	lda L7FE6
	ora L7FE5
	bpl L7CB0
	lda #$12
	sta r1L
	lda #$00
	sta r1H
	jsr ReadBuff
	lda L7FE6
	sta $8003
	bmi L7C76
	ldy #$BE
	jsr L7CB3
	jmp L903F

L7C76:	ldy #$01
	ldx #$03
L7C7A:	lda L7EB0,x
	sta $80DC,y
	iny
	tya
	cmp L7EAC,x
	bcc L7C7A
	dex
	bpl L7C7A
	lda #$00
	sta $80EE
	jsr L903F
	jsr L7CBF
	lda #$35
	sta r1L
	jmp L903F

L7C9C:	lda #$01
	sta r1L
	lda #$02
	sta r1H
	jsr ReadBuff
	lda L7FE0
	sta $8008
	jmp L903F

L7CB0:	ldx #$00
	rts

L7CB3:	lda #$00
	.byte $2C
L7CB6:	lda #$FF
L7CB8:	sta diskBlkBuf,y
	iny
	bne L7CB8
	rts

L7CBF:	ldy #$00
	jsr L7CB6
	ldy #$69
	jsr L7CB3
	ldy #$02
	ldx #$11
	lda #$1F
	jsr L7CF4
	ldx #$07
	lda #$07
	jsr L7CF4
	ldx #$06
	lda #$03
	jsr L7CF4
	ldx #$05
	lda #$01
	jsr L7CF4
	lda #$00
	ldy #$33
L7CEB:	sta diskBlkBuf,y
	iny
	cpy #$36
	bcc L7CEB
	rts

L7CF4:	sta diskBlkBuf,y
	pha
	tya
	add #$03
	tay
	pla
	dex
	bne L7CF4
	rts

L7D02:	jsr InitForIO
	ldy #$00
	sty L7FD8
	sty L7C40
	sty L7F67
	sty L7F68
	sty L7FD4
	sty L7FD5
	lda L79A8
	bne L7D4F
	lda #$12
	sta L7FD7
	jsr L7DF4
L7D26:	jsr L7B9E
	bne L7D4A
	lda L7FE3
	sta r1H
	lda L7FE2
	sta r1L
	beq L7D48
	lda L7FE4
	cmp r1L
	bcc L7D48
	jsr L7DB6
	lda L7FD7
	cmp #$46
	bcc L7D26
L7D48:	ldx #$00
L7D4A:	jsr DoneWithIO
	txa
	rts

L7D4F:	ldy #$00
	sty L7FD8
	jsr L7DF4
L7D57:	lda #$12
	sta L7FD7
L7D5C:	jsr L7B9E
	bne L7DB1
	lda L7FE3
	sta r1H
	lda L7FE2
	sta r1L
	jsr L7DB6
	bne L7DB1
	tax
	beq L7D81
	lda L7FE4
	cmp r1L
	bcc L7D81
	lda L7FD7
	cmp #$32
	bcc L7D5C
L7D81:	jsr L7E1A
	inc L7F67
	bne L7D93
	inc L7F68
	lda L7F68
	cmp #$04
	beq L7DAF
L7D93:	lda L7FE4
	cmp L7FE2
	bcc L7DAF
	lda L7FD6
	beq L7DAA
	lda L7FD5
	cmp L7FD6
	bcc L7D4F
	bcs L7DAF
L7DAA:	lda L7FD8
	bne L7D57
L7DAF:	ldx #$00
L7DB1:	jsr DoneWithIO
	txa
	rts

L7DB6:	lda L7FD7
	sta r4H
	lda #$00
	sta r4L
	jsr ReadBlock
	inc L7FD7
	bnex L7DF3
	inx
	stx L7C40
	ldy L7FD8
	lda r1L
	sta $1000,y
	lda r1H
	sta $1100,y
	inc L7FD8
	inc L7FD4
	bne L7DE4
	inc L7FD5
L7DE4:	jsr L7E32
	lda r1H
	sta L7FE3
	lda r1L
	sta L7FE2
	ldx #$00
L7DF3:	rts

L7DF4:	ldy #$00
	tya
L7DF7:	sta $1000,y
	sta $1100,y
	iny
	bne L7DF7
	rts

L7E01:	lda #$20
	sta r0L
	jsr L7E0D
	ldy #$02
	jmp BMult

L7E0D:	lda L7F68
	sta r1H
	lda L7F67
	sta r1L
	ldx #$04
	rts

L7E1A:	jsr L7F96
	jsr StashRAM
	lda L7FD6
	beq L7E31
	jsr L7FBA
	jsr StashRAM
	jsr L7F80
	jsr StashRAM
L7E31:	rts

L7E32:	bit L7FEA
	bpl L7E53
L7E37:	jsr L7E53
	lda r1L
	beq L7E52
	lda L7FE4
	cmp r1L
	bcc L7E52
	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr FindBAMBit
	bne L7E37
L7E52:	rts

L7E53:	lda L7FE1
	cmp #$03
	bne L7E69
	inc r1H
	lda r1H
	cmp #$28
	bcc L7E68
	inc r1L
	lda #$00
	sta r1H
L7E68:	rts

L7E69:	cmp #$04
	bne L7E74
	inc r1H
	bne L7E73
	inc r1L
L7E73:	rts

L7E74:	jsr L7E94
	clc
	adc r1H
	sta r1H
	jsr L7E8B
	bcc L7E8A
	sbc L7EB0,x
	sta r1H
	bne L7E8A
	inc r1L
L7E8A:	rts

L7E8B:	jsr L7E9B
	lda r1H
	cmp L7EB0,x
	rts

L7E94:	jsr L7E9B
	lda L7EB4,x
	rts

L7E9B:	lda r1L
	cmp #$24
	bcc L7EA3
	sbc #$23
L7EA3:	ldx #$04
L7EA5:	cmp L7EAB,x
	dex
	bcs L7EA5
L7EAB:	rts

L7EAC:	.byte $24,$1F,$19,$12
L7EB0:	.byte $11,$12,$13,$15
L7EB4:	.byte $0A,$0B,$0A,$0A
L7EB8:	jsr InitForIO
	ldy #$00
	sty L7FD8
	sty L7F67
	sty L7F68
	lda L79A8
	bne L7EE2
	lda #$12
	sta L7FD7
L7ED0:	jsr L7B9E
	bne L7EDD
	jsr L7F2B
	bne L7EDD
	tya
	beq L7ED0
L7EDD:	jsr DoneWithIO
	txa
	rts

L7EE2:	ldy #$00
	sty L7FD8
	lda L7FD6
	beq L7EEF
	jsr L7DF4
L7EEF:	lda #$12
	sta L7FD7
	jsr L7F69
L7EF7:	jsr L7B9E
	bne L7F26
	jsr L7F2B
	bne L7F26
	tya
	bne L7F24
	lda L7FD7
	cmp #$32
	bcc L7EF7
	inc L7F67
	bne L7F1A
	inc L7F68
	lda L7F68
	cmp #$04
	beq L7F24
L7F1A:	lda L7FD6
	bne L7EE2
	lda L7FD8
	bne L7EEF
L7F24:	ldx #$00
L7F26:	jsr DoneWithIO
	txa
	rts

L7F2B:	ldx #$00
	ldy L7FD8
	lda $1100,y
	sta r1H
	lda $1000,y
	sta r1L
	beq L7F63
	inc L7FD8
	lda L7FD7
	sta r4H
	lda #$00
	sta r4L
	jsr WriteBlock
	inc L7FD7
	lda L7FD4
	bne L7F56
	dec L7FD5
L7F56:	dec L7FD4
	bne L7F60
	lda L7FD5
	beq L7F63
L7F60:	ldy #$00
	.byte $2C
L7F63:	ldy #$FF
	txa
	rts

L7F67:	.byte 0
L7F68:	.byte 0

L7F69:	lda L7FD6
	beq L7F7A
	jsr L7FBA
	jsr FetchRAM
	jsr L7F80
	jsr FetchRAM
L7F7A:	jsr L7F96
	jmp FetchRAM

L7F80:	clc
	lda #$00
	adc r1L
	sta r1L
	lda #$80
	adc r1H
	sta r1H
	lda #$11
	sta r0H
	lda #$00
	sta r0L
	rts

L7F96:	jsr L7E01
	clc
	lda r1H
	adc L79A9
	sta r3L
	lda r1L
	sta r1H
	lda #$00
	sta r1L
	lda #$12
	sta r0H
	lda #$00
	sta r0L
	lda #$20
	sta r2H
	lda #$00
	sta r2L
	rts

L7FBA:	clc
	adc L79A9
	sta r3L
	jsr L7E01
	lda #$00
	sta r2H
	lda #$20
	sta r2L
	lda #$10
	sta r0H
	lda #$00
	sta r0L
	rts

L7FD4:	.byte 0
L7FD5:	.byte 0
L7FD6:	.byte 0
L7FD7:	.byte 0
L7FD8:	.byte 0
L7FD9:	.byte 0
L7FDA:	.byte 0
L7FDB:	.byte 0
L7FDC:	.byte 0
L7FDD:	.byte 0
L7FDE:	.byte 0
L7FDF:	.byte 0
L7FE0:	.byte 0
L7FE1:	.byte 0
L7FE2:	.byte 0
L7FE3:	.byte 0
L7FE4:	.byte 0
L7FE5:	.byte 0
L7FE6:	.byte 0
L7FE7:	.byte 0
L7FE8:	.byte 0
L7FE9:	.byte 0
L7FEA:	.byte 0
code2_end:

.endif
