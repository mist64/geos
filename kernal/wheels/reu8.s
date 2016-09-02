 lda #$00
	bit $80A9
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
	bcc $4FC6
L5021:	asl z8d
	.byte $23
	.byte $57
	lda $88C6
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

L5048:	lda #$00
	sta $7B8F
	sta $79A8
	jsr L9D83
	lda #$45
	jsr L9D80
	jsr L79C9
	txa
	bne L5071
	bit $793F
	bmi L5071
	jsr L9D83
	jsr L7940
	lda #$45
	jsr L9D80
	jsr L7BC7
L5071:	txa
	pha
	jsr L7B52
	jsr OpenDisk
	jsr L9D83
	jsr L79B0
	lda #$48
	jsr L9D80
	pla
	tax
	rts

L5087:	brk
	lda $7FDE
	bpl L508E
L508D:	rts

L508E:	and #$F0
	cmp #$30
	beq L508D
	lda $7FDD
	bmi L508D
	and #$F0
	cmp #$30
	beq L508D
	lda #$40
	jsr L9D80
	jsr L500F
	lda r2L
	beq L50E8
	bpl L50AF
	lda #$80
L50AF:	sta $79A8
	ldy #$01
L50B4:	jsr L501E
	lda r3L
	beq L50C2
	iny
	cpy #$09
	bcc L50B4
	bcs L50E8
L50C2:	lda $79A8
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
	txa
	bne L50E8
	lda r3L
	sta $79A9
	sty $79AA
	jmp L9D83

L50E8:	lda #$00
	sta $79A8
	jmp L9D83

	brk
	brk
	brk
	.byte $44
	.byte $43
	and $38,y
	bit $793F
	bpl L50FE
L50FD:	rts

L50FE:	lda $79A8
	beq L50FD
	lda #$40
	jsr L9D80
	ldy $79AA
	jsr L501B
	jmp L9D83

	lda #$01
	sta $7B8F
	lda $7FDA
	jsr SetDevice
	bne L513E
	bit $7FEA
	bvc L5151
	lda $88C6
	and #$F0
	beq L5139
	cmp #$10
	beq L5139
	lda $7FEA
	and #$BF
	sta $7FEA
	clv
	bvc L5151
L5139:	jsr L7B90
	beq L513F
L513E:	rts

L513F:	lda $88C6
	and #$F0
	beq L5151
	jsr L501E
	jsr L9063
	lda r2L
	sta $7FDC
L5151:	jsr EnterTurbo
	ldx $7FDC
	jsr L5018
	txa
	bne L51AB
	jsr L9050
	txa
	bne L51AB
	lda $8203
	sta $7FE6
	lda $88C6
	and #$0F
	sta $7FDE
	cmp $7FDD
	bne L5179
	jmp L7A64

L5179:	cmp #$03
	bcs L51A6
	lda $7FDD
	cmp #$03
	bcs L51A6
	cmp #$01
	bne L518F
	lda $7FE5
	bmi L51A6
	bpl L519E
L518F:	lda $7FE6
	bmi L51A6
	lda $7FE5
	bpl L519E
	jsr L7AB3
	bne L51A9
L519E:	lda #$01
	sta $7FE1
	ldx #$00
	rts

L51A6:	ldx #$73
	rts

L51A9:	ldx #$03
L51AB:	rts

	lda $7FE1
	cmp #$03
	beq L51F2
	cmp #$04
	bne L51C9
	lda $9062
	sta $7FE0
	cmp $7FDF
	bcs L51F2
	jsr L7AE1
	bne L51F8
	beq L51F2
L51C9:	cmp #$01
	bne L51D7
	lda $7FE5
	ora $7FE6
	bmi L51F5
	bpl L51EA
L51D7:	cmp #$02
	bne L51F5
	lda $7FE5
	bpl L51EA
	lda $7FE6
	bmi L51ED
	jsr L7AB3
	bne L51F8
L51EA:	lda #$01
	.byte $2C
L51ED:	lda #$02
	sta $7FE1
L51F2:	ldx #$00
	rts

L51F5:	ldx #$73
	rts

L51F8:	ldx #$03
	rts

	jsr L7B52
	jsr GetDirHead
	lda #$24
	sta r1L
	lda #$00
	sta r1H
L5209:	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr FindBAMBit
	beq L5226
L5216:	jsr L7E74
	lda r1L
	cmp #$35
	beq L5216
	cmp #$47
	bcc L5209
	ldx #$00
	rts

L5226:	ldx #$06
	rts

	jsr L7B52
	lda #$01
	sta r1L
	lda $7FDF
	jsr L7B38
	sty $7FE8
	clc
	adc #$02
	sta $7FE7
	lda $7FE0
	jsr L7B38
	sty $7FE9
	clc
	adc #$02
	sta r1H
	jsr L903C
	txa
	bne L527F
L5253:	ldy $7FE9
	lda diskBlkBuf,y
	cmp #$FF
	bne L527D
	iny
	sty $7FE9
	bne L526B
	inc r1H
	jsr L903C
	txa
	bne L527F
L526B:	lda r1H
	cmp $7FE7
	bcc L5253
	lda $7FE9
	cmp $7FE8
	bcc L5253
	ldx #$00
	rts

L527D:	ldx #$03
L527F:	rts

	ldx #$00
	stx r1H
	clc
	adc #$01
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

	ldx #$00
	bit $01A2
	cpx $7B8F
	beq L52D3
	stx $7B8F
	lda $7FD9,x
	jsr SetDevice
	bne L52D5
	lda $7FD9
	cmp $7FDA
	bne L52C6
	jsr L7B90
	bne L52D5
	ldx $7B8F
	lda $7FDB,x
	tax
	jsr L5018
L52C6:	jsr EnterTurbo
	lda $88C6
	cmp #$03
	bcs L52D3
	jsr NewDisk
L52D3:	ldx #$00
L52D5:	txa
	rts

	brk
	bit $7FEA
	bvc L52E3
	ldx $7B8F
	jmp L5021

L52E3:	ldx #$00
	rts

	ldx #$00
	lda #$7F
	sta $DC00
	bit $DC01
	bmi L52F4
	ldx #$0C
L52F4:	txa
	rts

	ldy #$90
	bit $91A0
	ldx #$06
L52FD:	lda $7BC0,x
	sta r0L,x
	dex
	bpl L52FD
	jmp DoRAMOp

	.byte $00,$10,$00,$C8,$00,$36,$00
	lda $7FE1
	cmp #$01
	beq L5330
	cmp #$02
	beq L532D
	cmp #$03
	beq L532A
	lda $7FDF
	cmp $7FE0
	bcc L5329
	lda $7FE0
L5329:	.byte $2C
L532A:	lda #$50
	.byte $2C
L532D:	lda #$46
	.byte $2C
L5330:	lda #$23
	sta $7FE4
	ldx #$00
	stx $7FE3
	inx
	stx $7FE2
	jsr L7BAE
	ldx $79A8
	beq L5347
	dex
L5347:	stx $7FD6
	jsr L7B52
	jsr GetDirHead
	txa
	bne L537B
L5353:	jsr L7B52
	bne L537B
	jsr L7D02
	bne L537B
	lda $7C40
	beq L5379
	jsr L7B55
	bne L537B
	jsr L7EB8
	bne L537B
	lda $7FE2
	beq L5379
	lda $7FE4
	cmp $7FE2
	bcs L5353
L5379:	lda #$00
L537B:	pha
	tax
	bne L5382
	jsr L7C41
L5382:	jsr L7BB1
	pla
	tax
	rts

	brk
	jsr L7B55
	lda $7FE1
	cmp #$04
	beq L53E4
	cmp #$03
	beq L53F8
	cmp #$02
	beq L53F8
	lda $7FE6
	ora $7FE5
	bpl L53F8
	lda #$12
	sta r1L
	lda #$00
	sta r1H
	jsr L903C
	lda $7FE6
	sta $8003
	bmi L53BE
	ldy #$BE
	jsr L7CB3
	jmp L903F

L53BE:	ldy #$01
	ldx #$03
L53C2:	lda $7EB0,x
	sta $80DC,y
	iny
	tya
	cmp $7EAC,x
	bcc L53C2
	dex
	bpl L53C2
	lda #$00
	sta $80EE
	jsr L903F
	jsr L7CBF
	lda #$35
	sta r1L
	jmp L903F

L53E4:	lda #$01
	sta r1L
	lda #$02
	sta r1H
	jsr L903C
	lda $7FE0
	sta $8008
	jmp L903F

L53F8:	ldx #$00
	rts

	lda #$00
	bit $FFA9
L5400:	sta diskBlkBuf,y
	iny
	bne L5400
	rts

	ldy #$00
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
L5433:	sta diskBlkBuf,y
	iny
	cpy #$36
	bcc L5433
	rts

L543C:	sta diskBlkBuf,y
	pha
	tya
	clc
	adc #$03
	tay
	pla
	dex
	bne L543C
	rts

	jsr InitForIO
	ldy #$00
	sty $7FD8
	sty $7C40
	sty $7F67
	sty $7F68
	sty $7FD4
	sty $7FD5
	lda $79A8
	bne L5497
	lda #$12
	sta $7FD7
	jsr L7DF4
L546E:	jsr L7B9E
	bne L5492
	lda $7FE3
	sta r1H
	lda $7FE2
	sta r1L
	beq L5490
	lda $7FE4
	cmp r1L
	bcc L5490
	jsr L7DB6
	lda $7FD7
	cmp #$46
	bcc L546E
L5490:	ldx #$00
L5492:	jsr DoneWithIO
	txa
	rts

L5497:	ldy #$00
	sty $7FD8
	jsr L7DF4
L549F:	lda #$12
	sta $7FD7
L54A4:	jsr L7B9E
	bne L54F9
	lda $7FE3
	sta r1H
	lda $7FE2
	sta r1L
	jsr L7DB6
	bne L54F9
	tax
	beq L54C9
	lda $7FE4
	cmp r1L
	bcc L54C9
	lda $7FD7
	cmp #$32
	bcc L54A4
L54C9:	jsr L7E1A
	inc $7F67
	bne L54DB
	inc $7F68
	lda $7F68
	cmp #$04
	beq L54F7
L54DB:	lda $7FE4
	cmp $7FE2
	bcc L54F7
	lda $7FD6
	beq L54F2
	lda $7FD5
	cmp $7FD6
	bcc L5497
	bcs L54F7
L54F2:	lda $7FD8
	bne L549F
L54F7:	ldx #$00
L54F9:	jsr DoneWithIO
	txa
	rts

	lda $7FD7
	sta r4H
	lda #$00
	sta r4L
	jsr ReadBlock
	inc $7FD7
	txa
	bne L553B
	inx
	stx $7C40
	ldy $7FD8
	lda r1L
	sta $1000,y
	lda r1H
	sta $1100,y
	inc $7FD8
	inc $7FD4
	bne L552C
	inc $7FD5
L552C:	jsr L7E32
	lda r1H
	sta $7FE3
	lda r1L
	sta $7FE2
	ldx #$00
L553B:	rts

	ldy #$00
	tya
L553F:	sta $1000,y
	sta $1100,y
	iny
	bne L553F
	rts

	lda #$20
	sta r0L
	jsr L7E0D
	ldy #$02
	jmp BMult

	lda $7F68
	sta r1H
	lda $7F67
	sta r1L
	ldx #$04
	rts

	jsr L7F96
	jsr StashRAM
	lda $7FD6
	beq L5579
	jsr L7FBA
	jsr StashRAM
	jsr L7F80
	jsr StashRAM
L5579:	rts

	bit $7FEA
	bpl L559B
L557F:	jsr L7E53
	lda r1L
	beq L559A
	lda $7FE4
	cmp r1L
	bcc L559A
	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr FindBAMBit
	bne L557F
L559A:	rts

L559B:	lda $7FE1
	cmp #$03
	bne L55B1
	inc r1H
	lda r1H
	cmp #$28
	bcc L55B0
	inc r1L
	lda #$00
	sta r1H
L55B0:	rts

L55B1:	cmp #$04
	bne L55BC
	inc r1H
	bne L55BB
	inc r1L
L55BB:	rts

L55BC:	jsr L7E94
	clc
	adc r1H
	sta r1H
	jsr L7E8B
	bcc L55D2
	sbc $7EB0,x
	sta r1H
	bne L55D2
	inc r1L
L55D2:	rts

	jsr L7E9B
	lda r1H
	cmp $7EB0,x
	rts

	jsr L7E9B
	lda $7EB4,x
	rts

	lda r1L
	cmp #$24
	bcc L55EB
	sbc #$23
L55EB:	ldx #$04
L55ED:	cmp $7EAB,x
	dex
	bcs L55ED
	rts

	.byte $24,$1F,$19,$12,$11,$12,$13,$15
	.byte $0A,$0B,$0A,$0A
	jsr InitForIO
	ldy #$00
	sty $7FD8
	sty $7F67
	sty $7F68
	lda $79A8
	bne L562A
	lda #$12
	sta $7FD7
L5618:	jsr L7B9E
	bne L5625
	jsr L7F2B
	bne L5625
	tya
	beq L5618
L5625:	jsr DoneWithIO
	txa
	rts

L562A:	ldy #$00
	sty $7FD8
	lda $7FD6
	beq L5637
	jsr L7DF4
L5637:	lda #$12
	sta $7FD7
	jsr L7F69
L563F:	jsr L7B9E
	bne L566E
	jsr L7F2B
	bne L566E
	tya
	bne L566C
	lda $7FD7
	cmp #$32
	bcc L563F
	inc $7F67
	bne L5662
	inc $7F68
	lda $7F68
	cmp #$04
	beq L566C
L5662:	lda $7FD6
	bne L562A
	lda $7FD8
	bne L5637
L566C:	ldx #$00
L566E:	jsr DoneWithIO
	txa
	rts

	ldx #$00
	ldy $7FD8
	lda $1100,y
	sta r1H
	lda $1000,y
	sta r1L
	beq L56AB
	inc $7FD8
	lda $7FD7
	sta r4H
	lda #$00
	sta r4L
	jsr WriteBlock
	inc $7FD7
	lda $7FD4
	bne L569E
	dec $7FD5
L569E:	dec $7FD4
	bne L56A8
	lda $7FD5
	beq L56AB
L56A8:	ldy #$00
	.byte $2C
L56AB:	ldy #$FF
	txa
	rts

	brk
	brk
	lda $7FD6
	beq L56C2
	jsr L7FBA
	jsr FetchRAM
	jsr L7F80
	jsr FetchRAM
L56C2:	jsr L7F96
	jmp FetchRAM

	clc
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

	jsr L7E01
	clc
	lda r1H
	adc $79A9
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

	clc
	adc $79A9
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

	.byte $00,$00,$00,$00,$00
L5721:	.byte $00
L5722:	.byte $00
L5723:	.byte $00
L5724:	.byte $00
L5725:	.byte $00,$00
L5727:	.byte $00,$00
L5729:	.byte $00,$00,$00,$00
L572D:	.byte $00,$00,$00,$00,$00
L5732:	.byte $00
