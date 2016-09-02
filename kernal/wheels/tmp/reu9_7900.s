
	jsr L7945
	jsr L7951
	lda $8414
	sta r1H
	lda $8413
	sta r1L
	beq L792C
	jsr L903C
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
	jsr L9D83
	txa
	jmp L9D80

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

L79BA:	brk
L79BB:	brk
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
	clv
	bvc L79E6
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
	txa
	bne L79F3
	jsr OpenDisk
	txa
	bne L79F3
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
	txa
	beq L7A49
	cpx #$05
	beq L7A49
	rts

L7A31:	lda L7F2D
	sta r6H
	lda L7F2C
	sta r6L
	jsr FindFile
	txa
	bne L7A49
L7A41:	ldx #$FF
	rts

L7A44:	jsr L7A6E
	bne L7A41
L7A49:	jsr L7B67
	txa
	bne L7A6D
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
	txa
	bne L7AAE
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
L7AA0:	lda (r5L),y
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
	lda $88C6
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

L7AF8:	brk
L7AF9:	brk
L7AFA:	brk
L7AFB:	brk
L7AFC:	jsr L7B76
	bne L7B30
	lda L7EFA
	sta r1L
	lda L7EFB
	sta r1H
	jsr L903C
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
	txa
	bne L7B66
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
	txa
	beq L7BCF
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
	txa
	bne L7BCD
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
	txa
	bne L7C4A
	inc L7F01
	ldy #$01
	lda (r4L),y
	sta r1H
	dey
	lda (r4L),y
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
	lda $8101,y
	sta r1H
	lda fileHeader,y
	sta r1L
	beq L7CEB
L7CC9:	jsr L7C16
	txa
	bne L7CAE
	lda L7F02
	sta L7F03
	cmp #$44
	bcc L7CEB
	jsr L7D1F
	txa
	bne L7CAE
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
	txa
	beq L7D0B
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
	txa
	beq L7D4C
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
	sta $8101,x
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
	txa
	bne L7E13
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
	txa
	bne L7E13
	jsr L7E14
	jsr InitForIO
	lda #$10
	sta L7F02
	jsr L7EAF
	bne L7E10
	jsr DoneWithIO
	jsr PutDirHead
	txa
	bne L7E13
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
	clv
	bvc L7E50
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
	lda (r4L),y
	beq L7ED7
	iny
	lda $8303,x
	sta (r4L),y
	dey
	lda $8302,x
	sta (r4L),y
L7ED7:	inx
	inx
	stx L7F08
	jsr WriteBlock
	inc L7F02
	txa
	bne L7EF7
	ldy #$00
	lda (r4L),y
	sta L7F07
	beq L7EF5
	lda L7F02
	cmp #$43
	bcc L7EAF
L7EF5:	ldx #$00
L7EF7:	rts

L7EF8:	.byte $00
L7EF9:	.byte $00
L7EFA:	.byte $00
L7EFB:	.byte $00
L7EFC:	.byte $00
L7EFD:	.byte $00
L7EFE:	.byte $00
L7EFF:	.byte $00
L7F00:	.byte $00
L7F01:	.byte $00
L7F02:	.byte $00
L7F03:	.byte $00
L7F04:	.byte $00
L7F05:	.byte $00,$00
L7F07:	.byte $00
L7F08:	.byte $00
L7F09:	.byte $00
L7F0A:	.byte $00
L7F0B:	.byte $00
L7F0C:	.byte $00
L7F0D:	.byte $00
L7F0E:	.byte $00
L7F0F:	.byte $00
L7F10:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00
L7F21:	.byte $00
L7F22:	.byte $00
L7F23:	.byte $00,$00,$00,$00,$00,$00,$00
L7F2A:	.byte $00
L7F2B:	.byte $00
L7F2C:	.byte $00
L7F2D:	.byte $00
L7F2E:	.byte $00
L7F2F:	.byte $00
L7F30:	.byte $00
L7F31:	.byte $00
L7F32:	.byte $00
L7F33:	.byte $00
