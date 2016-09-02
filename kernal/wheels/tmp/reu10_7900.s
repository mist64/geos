	jmp L7909

	jmp L79C9

	jmp L79BC

L7909:	sei
	cld
	lda #$C0
	sta dispBufferOn
	bit $88C5
	bpl L7929
	lda curDrive
	jsr SetDevice
	bne L7940
	lda $88C6
	bmi L7931
	and #$F0
	cmp #$30
	beq L7931
	bne L7940
L7929:	lda TempCurDrive
	jsr SetDevice
	bne L7940
L7931:	jsr NewDisk
	bne L7940
	jsr GetDirHead
	bne L7940
	jsr L7D2A
	beq L7953
L7940:	lda #$00
	sta r4L
	jsr L79C9
	lda $886B
	bpl L7953
	jsr L7C9E
	bcc L7940
	bcs L7958
L7953:	jsr L7B11
	bcc L7940
L7958:	ldx #$FF
	stx $88C5
	rts

L795E:	jsr InitForIO
	lda #$80
	sta r4H
	lda #$00
	sta r4L
L7969:	jsr ReadBlock
	bne L79B9
	ldy #$FE
	lda diskBlkBuf
	bne L797D
	ldy $8001
	beq L79AB
	dey
	beq L79AB
L797D:	lda r2H
	bne L798B
	cpy r2L
	bcc L798B
	beq L798B
	ldx #$0B
	bne L79B9
L798B:	sty r1L
L798D:	lda $8001,y
	dey
	sta (r7L),y
	bne L798D
	lda r1L
	clc
	adc r7L
	sta r7L
	bcc L79A0
	inc r7H
L79A0:	lda r2L
	sec
	sbc r1L
	sta r2L
	bcs L79AB
	dec r2H
L79AB:	lda $8001
	sta r1H
	lda diskBlkBuf
	sta r1L
	bne L7969
	ldx #$00
L79B9:	jmp DoneWithIO

L79BC:	lda r6H
	sta L7C67
	lda r6L
	sta L7C66
	lda #$80
	.byte $2C
L79C9:	lda #$00
	sta L7C68
	lda #$00
	sta $886B
	lda r4L
	sta L7A37
L79D8:	lda #$80
	sta L7A38
L79DD:	ldy #$08
	sty L7A39
L79E2:	lda $8486,y
	beq L79F2
	eor L7A38
	bmi L79F2
	jsr L7AA9
	bcc L79F2
	rts

L79F2:	inc L7A39
	ldy L7A39
	cpy #$0C
	bcc L79E2
	lda L7A38
	eor #$80
	sta L7A38
	bmi L7A11
	jsr L7A97
	bcs L7A10
	jsr L7B57
	bcc L79DD
L7A10:	rts

L7A11:	bit L7C68
	bmi L7A10
	bit L7A37
	bmi L7A10
	jsr L7A3A
	lda #$08
	sta L7A39
L7A23:	jsr SetDevice
	bne L7A2B
	jsr OpenDisk
L7A2B:	inc L7A39
	lda L7A39
	cmp #$0C
	bcc L7A23
	bcs L79D8
L7A37:	brk
L7A38:	brk
L7A39:	brk
L7A3A:	jsr L7A85
	lda #$08
	sta r1L
	lda #$04
	sta r1H
	lda #$18
	sta r2L
	lda #$0C
	sta r2H
	lda $9FE1
	sta r4H
	jsr LC313
	lda $84B2
	sta L7A84
	lda RecoverVector
	sta L7A83
	lda #$7A
	sta $84B2
	lda #$8E
	sta RecoverVector
	lda #$7C
	sta r0H
	lda #$96
	sta r0L
	jsr DoDlgBox
	lda L7A84
	sta $84B2
	lda L7A83
	sta RecoverVector
	rts

L7A83:	brk
L7A84:	brk
L7A85:	jsr LCFD9
	jsr L4000
	jmp LCFD9

	jsr LCFD9
	jsr L4003
	jmp LCFD9

L7A97:	ldy #$08
L7A99:	lda $8486,y
	and #$F0
	cmp #$30
	beq L7AA9
	iny
	cpy #$0C
	bcc L7A99
	clc
	rts

L7AA9:	tya
	and #$7F
	jsr SetDevice
	bne L7B0F
	jsr NewDisk
	txa
	bne L7B0F
	jsr GetDirHead
	bne L7B0F
	jsr L7D2A
	bne L7AC9
	lda curDrive
	sta $886B
	sec
	rts

L7AC9:	lda $88C6
	and #$0F
	cmp #$04
	bne L7B0F
	lda $905C
	cmp #$01
	bne L7ADE
	cmp $905D
	beq L7B0F
L7ADE:	lda $905D
	pha
	lda $905C
	pha
	lda #$01
	sta $905C
	sta $905D
	jsr GetDirHead
	bne L7B04
	jsr L7D2A
	bne L7B04
	pla
	pla
	lda curDrive
	ora #$40
	sta $886B
	sec
	rts

L7B04:	pla
	sta $905C
	pla
	sta $905D
	jsr GetDirHead
L7B0F:	clc
	rts

L7B11:	sec
	lda #$00
	sbc r7L
	sta r2L
	lda #$79
	sbc r7H
	sta r2H
	lda $8402
	sta r1H
	lda $8401
	sta r1L
	lda $8146
	cmp #$01
	bne L7B3F
	jsr L903C
	txa
	bne L7B55
	lda $8003
	sta r1H
	lda $8002
	sta r1L
L7B3F:	jsr L795E
	txa
	bne L7B55
	lda #$00
	sta r0L
	lda $814C
	sta r7H
	lda $814B
	sta r7L
	sec
	rts

L7B55:	clc
	rts

L7B57:	lda $886A
	and #$F0
	beq L7B66
	cmp #$40
	bcc L7B68
	cmp #$80
	beq L7B68
L7B66:	clc
	rts

L7B68:	sta L7D13
	lda TempCurDrive
	jsr SetDevice
	bne L7B7E
	jsr L7BD8
	bcc L7B7E
	jsr L7BA4
	bcc L7B7E
	rts

L7B7E:	lda #$08
	sta L7BA3
L7B83:	jsr SetDevice
	bne L7B92
	jsr L7BD8
	bcc L7B92
	jsr L7BA4
	bcs L7BA2
L7B92:	inc L7BA3
	lda L7BA3
	cmp TempCurDrive
	beq L7B92
	cmp #$0C
	bcc L7B83
	clc
L7BA2:	rts

L7BA3:	brk
L7BA4:	lda $905D
	sta L7D16
	lda $905C
	sta L7D15
	jsr L9063
	lda r2L
	sta L7D14
	cmp $8869
	bne L7BC6
	lda $88C6
	and #$F0
	cmp #$10
	bne L7BD5
L7BC6:	jsr L7CB7
	bcc L7BCC
L7BCB:	rts

L7BCC:	lda $88C6
	and #$F0
	cmp #$10
	bne L7BCB
L7BD5:	jmp L7CEC

L7BD8:	lda L7D13
	bpl L7BE8
	lda $88C6
	and #$F0
	cmp #$30
	bne L7BF4
L7BE6:	sec
	rts

L7BE8:	cmp #$30
	bne L7BF4
	lda $88C6
	and $9073
	bmi L7BE6
L7BF4:	lda $88C6
	and #$F0
	cmp L7D13
	beq L7BE6
	clc
	rts

L7C00:	ldx #$01
	lda L7C67
	sta r6H
	lda L7C66
	sta r6L
	bit L7C68
	bmi L7C41
	lda #$C3
	sta r6H
	lda #$CF
	sta r6L
	lda #$7C
	sta r2H
	lda #$69
	sta r2L
	ldx #$0E
	ldy #$06
	jsr CmpString
	bne L7C35
	lda #$7C
	sta r6H
	lda #$85
	sta r6L
	ldx #$00
	.byte $2C
L7C35:	ldx #$01
	lda L7C92,x
	sta r0L
	lda L7C94,x
	sta r0H
L7C41:	stx L7C65
	rts

	jsr i_PutString
	.byte "P"
	.byte $00
	.byte "6Insert a disk with "


	.byte $00
	jsr L7C00
	jmp PutString

L7C65:	brk
L7C66:	brk
L7C67:	brk
L7C68:	brk
	.byte "DESKTOP"
	.byte $00
	.byte "Insert a disk with "


	.byte $00
	.byte "Dashboard 64"

	.byte $00
L7C92:	.byte $85,$CF
L7C94:	.byte $7C,$C3,$80,$13,$45,$7C,$01,$11
	.byte $48,$00

L7C9E:	jsr L7B11
	php
	ldx L7D14
	jsr L7D17
	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	plp
	rts

L7CB7:	ldx $8869
	jsr L7D17
	jsr L9050
	jsr L7D2A
	bne L7CD7
	lda curDrive
	bit L7C68
	bmi L7CD0
	sta TempCurDrive
L7CD0:	ora #$80
	sta $886B
	sec
	rts

L7CD7:	ldx L7D14
	jsr L7D17
	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	clc
	rts

L7CEC:	jsr L9050
	jsr L7D2A
	bne L7D04
	lda curDrive
	bit L7C68
	bmi L7CFF
	sta TempCurDrive
L7CFF:	sta $886B
	sec
	rts

L7D04:	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	clc
	rts

L7D13:	brk
L7D14:	brk
L7D15:	brk
L7D16:	brk
L7D17:	jsr L9D83
	lda #$45
	jsr L9D80
	jsr L5018
	jsr L9D83
	lda #$4A
	jmp L9D80

L7D2A:	jsr L7C00
	jsr FindFile
	txa
	bne L7D5A
	lda #$84
	sta r9H
	lda #$00
	sta r9L
	jsr GetFHdrInfo
	txa
	bne L7D5A
	ldx L7C65
	dex
	beq L7D5A
	lda $815A
	cmp #$35
	bcs L7D58
	lda $815C
	cmp #$30
	bne L7D58
	ldx #$05
	rts

L7D58:	ldx #$00
L7D5A:	rts

