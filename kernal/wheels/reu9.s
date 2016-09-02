.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

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
	brk
L5021:	sty $9D
	php
	.byte $57
	dex
	bpl L501F
	ldy #$00
L502A:	lda (r0L),y
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
	.word $0634
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
	txa
	bne L509C
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
	txa
	beq L50F7
L50B9:	jsr L903C
	bne L50F9
	lda #$80
	sta r5H
	lda #$02
	sta r5L
L50C6:	ldy #$00
	lda (r5L),y
	beq L50DA
	ldy #$03
L50CE:	lda (r6L),y
	cmp (r5L),y
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
	lda $8001
	sta r1H
	lda diskBlkBuf
	sta r1L
	bne L50B9
	bit $7EF9
	bmi L50F7
	jmp L509D

L50F7:	ldx #$05
L50F9:	rts

L50FA:	jsr L7945
	jsr L7951
	lda $8414
	sta r1H
	lda $8413
	sta r1L
	beq L5126
	jsr L903C
	bne L5126
	inc $7F01
	jsr L7C56
	lda $7F23
	cmp #$01
	bne L5129
	cmp $8046
	bne L5129
	lda #$C0
	.byte $2C
L5126:	lda #$00
	.byte $2C
L5129:	lda #$80
	sta $7EF8
	jsr L79BC
	txa
	pha
	jsr L7B76
	jsr L7964
	jsr L7948
	pla
	tax
	rts

	ldx #$45
	bit $49A2
	jsr L9D83
	txa
	jmp L9D80

	bit $7F32
	bvc L515D
	jsr L797A
	lda DBoxDescH
	sta $79BB
	lda DBoxDescL
	sta $79BA
L515D:	rts

	bit $7F32
	bvc L5170
	lda $79BB
	sta DBoxDescH
	lda $79BA
	sta DBoxDescL
	jsr L7977
L5170:	rts

	ldy #$91
	bit $90A0
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

	brk
	brk
	lda #$00
	sta $7EFD
	bit $7F31
	bpl L51C5
	jsr L79EE
	bne L51E7
L51C5:	bit $7F33
	bpl L51CD
	jmp L7AFC

L51CD:	jsr L7C69
	bit $7EF8
	bpl L51DD
	bvc L51DD
	jsr L7C87
	clv
	bvc L51E0
L51DD:	jsr L7D9C
L51E0:	txa
	pha
	jsr L7C6C
	pla
	tax
L51E7:	rts

	jsr L7B79
	beq L51EE
L51ED:	rts

L51EE:	ldx $7F30
	jsr L5018
	txa
	bne L51ED
	jsr OpenDisk
	txa
	bne L51ED
	lda $82AB
	sta $7AFA
	lda $82AC
	sta $7AFB
	jsr L7AB4
	bit $7F33
	bmi L523E
	bit $7F31
	bmi L522B
	lda $7F2D
	sta r0H
	lda $7F2C
	sta r0L
	jsr DeleteFile
	txa
	beq L5243
	cpx #$05
	beq L5243
	rts

L522B:	lda $7F2D
	sta r6H
	lda $7F2C
	sta r6L
	jsr FindFile
	txa
	bne L5243
L523B:	ldx #$FF
	rts

L523E:	jsr L7A6E
	bne L523B
L5243:	jsr L7B67
	txa
	bne L5267
	jsr CalcBlksFree
	lda r4L
	sta $7EFF
	lda r4H
	sta $7F00
	cmp $7F2B
	bne L5260
	lda r4L
	cmp $7F2A
L5260:	bcc L5265
	jmp PutDirHead

L5265:	ldx #$03
L5267:	rts

	lda $7F2D
	sta r6H
	lda $7F2C
	sta r6L
	jsr FindFile
	txa
	bne L52A8
	lda r1L
	cmp $7EFA
	bne L52AB
	lda r1H
	cmp $7EFB
	bne L52AB
	lda r5L
	cmp $7EFC
	bne L52AB
	bit $9074
	bmi L52A8
L5292:	jsr L9033
	tya
	bne L52A8
	ldy #$03
L529A:	lda (r5L),y
	cmp $7F0E,y
	bne L5292
	iny
	cpy #$13
	bne L529A
	beq L52AB
L52A8:	ldx #$00
	rts

L52AB:	ldx #$FF
	rts

	bit $7F32
	bvs L52EC
	lda $7F09
	cmp $7F0A
	bne L52EC
	lda $7F0B
	cmp $7F30
	bne L52EC
	lda $88C6
	and #$0F
	cmp #$04
	bne L52F1
	bit $7F33
	bmi L52E9
	lda $7EF9
	eor $7F32
	bpl L52EC
	lda $7AF8
	cmp $7AFA
	bne L52EC
	lda $7AF9
	cmp $7AFB
	bne L52EC
L52E9:	lda #$80
	.byte $2C
L52EC:	lda #$00
	sta $7F33
L52F1:	rts

	brk
	brk
	brk
	brk
	jsr L7B76
	bne L532A
	lda $7EFA
	sta r1L
	lda $7EFB
	sta r1H
	jsr L903C
	bne L532A
	ldy $7EFC
	lda #$00
L530F:	sta diskBlkBuf,y
	iny
	inx
	cpx #$1E
	bcc L530F
	jsr L7BFB
	bne L532A
	jsr L903F
	bne L532A
	jsr L7B79
	bne L532A
	jmp L7B49

L532A:	rts

	bit $7EF8
	bpl L5343
	jsr L7C59
	lda $7F22
	sta r1H
	lda $7F21
	sta r1L
	jsr L903F
	beq L5343
	rts

L5343:	jsr L7B67
	txa
	bne L5360
L5349:	lda $7F0E,x
	sta diskBlkBuf,y
	iny
	inx
	cpx #$1E
	bcc L5349
	lda $7F33
	sta r3H
	jsr PutBlock
	jmp PutDirHead

L5360:	rts

	lda #$00
	sta r10L
	bit $7F32
	bpl L536D
	jmp L906C

L536D:	jmp GetFreeDirBlk

	ldx #$00
	bit $01A2
	cpx $7EFE
	bne L537D
	ldx #$00
	rts

L537D:	stx $7EFE
L5380:	jsr L7C08
	bne L53C7
	ldx $7EFE
	lda $7F09,x
	jsr SetDevice
	bne L53C7
	lda $7F09
	cmp $7F0A
	bne L53C9
	lda $7F0B
	cmp $7F30
	bne L53A5
	bit $7F32
	bvc L53C9
L53A5:	ldx $7F30
	lda $7EFE
	bne L53BC
	lda $9076
	sta $7F00
	lda $9075
	sta $7EFF
	ldx $7F0B
L53BC:	jsr L5018
	txa
	beq L53C9
	bit $7F32
	bvs L5380
L53C7:	txa
	rts

L53C9:	ldx $7F0C
	ldy $7F0D
	lda $7EFE
	beq L53E6
	lda $7F00
	sta $9076
	lda $7EFF
	sta $9075
	ldx $7F2E
	ldy $7F2F
L53E6:	stx $905C
	sty $905D
	jsr NewDisk
	txa
	bne L53C7
	jmp GetDirHead

	lda KbdNextKey
	cmp #$16
	beq L53FF
	ldx #$00
	rts

L53FF:	ldx #$0C
	rts

	bit $7F32
	bvc L540D
	ldx $7EFE
	jmp L5021

L540D:	ldx #$00
	rts

	jsr L7BFB
	beq L5416
	rts

L5416:	jsr InitForIO
L5419:	lda $7F02
	sta r4H
	lda #$00
	sta r4L
	jsr ReadBlock
	inc $7F02
	txa
	bne L5444
	inc $7F01
	ldy #$01
	lda (r4L),y
	sta r1H
	dey
	lda (r4L),y
	sta r1L
	beq L5442
	lda $7F02
	cmp #$44
	bcc L5419
L5442:	ldx #$00
L5444:	jmp DoneWithIO

	lda #$81
	sta r4H
	lda #$00
	sta r4L
	rts

	ldy #$90
	bit $91A0
	lda #$80
	sta r0H
	lda #$C8
	sta r1H
	lda #$01
	sta r2H
	bne L5474
	ldy #$90
	bit $91A0
	lda #$10
	sta r0H
	lda #$C9
	sta r1H
	lda #$35
	sta r2H
L5474:	lda #$00
	sta r0L
	sta r1L
	sta r2L
	sta r3L
	jmp DoRAMOp

	jsr L7B76
	bne L54A8
	lda #$10
	sta $7F02
	sta $7F03
	lda #$00
	sta $7F07
	sta $7F08
	lda $7F10
	sta r1H
	lda $7F0F
	sta r1L
	jsr L7C4D
	jsr GetBlock
	beq L54A9
L54A8:	rts

L54A9:	inc $7F01
	ldy #$02
	sty $7F04
	sty $7F05
L54B4:	ldy $7F04
	lda $8101,y
	sta r1H
	lda fileHeader,y
	sta r1L
	beq L54E5
L54C3:	jsr L7C16
	txa
	bne L54A8
	lda $7F02
	sta $7F03
	cmp #$44
	bcc L54E5
	jsr L7D1F
	txa
	bne L54A8
	jsr L7B76
	bne L5518
	jsr L7E7B
	lda r1L
	bne L54C3
L54E5:	jsr L7BFB
	bne L5518
	inc $7F04
	inc $7F04
	bne L54B4
	lda $7F02
	cmp #$10
	beq L5500
	jsr L7D1F
	txa
	beq L5505
	rts

L5500:	jsr L7B79
	bne L5518
L5505:	jsr L7C4D
	lda $7F10
	sta r1H
	lda $7F0F
	sta r1L
	jsr PutBlock
	jmp L7B31

L5518:	rts

	bit $7EFD
	bmi L553A
	bit $7F31
	bmi L553A
	jsr i_MoveData
	.addr fileHeader
	.addr L4400
	.word $0100
	jsr L79EE
	bne L5545
	jsr i_MoveData
	.addr L4400
	.addr fileHeader
	.word $0100
L553A:	jsr L7B79
	bne L5545
	jsr L7E5B
	txa
	beq L5546
L5545:	rts

L5546:	jsr L7E14
	jsr InitForIO
	lda #$10
	sta $7F02
	lda $7F07
	bne L5581
L5556:	ldx $7F05
	beq L558D
L555B:	lda fileHeader,x
	bne L556D
	inx
	inx
	bne L555B
	stx $7F05
	jsr DoneWithIO
	jmp PutDirHead

L556D:	ldy $7F08
	lda $8301,y
	sta $8101,x
	lda fileTrScTab,y
	sta fileHeader,x
	inx
	inx
	stx $7F05
L5581:	jsr L7EAF
	bne L5593
	lda $7F02
	cmp #$43
	bcc L5556
L558D:	jsr DoneWithIO
	jmp PutDirHead

L5593:	jmp DoneWithIO

	jsr L7B76
	bne L560D
	lda $7F10
	sta r1H
	lda $7F0F
	sta r1L
	lda #$10
	sta $7F02
	sta $7F03
	lda #$00
	sta $7F08
L55B2:	jsr L7C16
	txa
	bne L560D
L55B8:	lda $7F02
	sta $7F03
	bit $7EFD
	bmi L55CE
	bit $7F31
	bmi L55CE
	jsr L79EE
	beq L55CE
	rts

L55CE:	jsr L7B79
	bne L560D
	jsr L7E5B
	txa
	bne L560D
	jsr L7E14
	jsr InitForIO
	lda #$10
	sta $7F02
	jsr L7EAF
	bne L560A
	jsr DoneWithIO
	jsr PutDirHead
	txa
	bne L560D
	lda $7F03
	cmp #$44
	bcc L5607
	jsr L7B76
	bne L560D
	jsr L7E7B
	lda r1L
	bne L55B2
	beq L55B8
L5607:	jmp L7B31

L560A:	jmp DoneWithIO

L560D:	rts

	bit $7EFD
	bmi L564A
	bit $7EF8
	bmi L5627
	lda $8301
	sta $7F10
	lda fileTrScTab
	sta $7F0F
	clv
	bvc L564A
L5627:	lda $8301
	sta $7F22
	lda fileTrScTab
	sta $7F21
	lda $8303
	sta $7F10
	lda $8302
	sta $7F0F
	bit $7EF8
	bvc L5647
	lda #$04
	.byte $2C
L5647:	lda #$02
	.byte $2C
L564A:	lda #$00
	sta $7F08
	lda #$80
	sta $7EFD
	rts

	lda $7F01
	sta r1L
	bne L565E
	tax
	rts

L565E:	lda #$FE
	sta r2L
	ldx #$06
	ldy #$04
	jsr BBMult
	ldy $7F08
	sty r6L
	lda #$83
	sta r6H
	jmp BlkAlloc

	ldy #$00
L5677:	lda $4300,y
	sta $1000,y
	iny
	bne L5677
	lda #$11
	sta $7F02
	ldy $7F08
	lda fileTrScTab,y
	sta fileTrScTab
	lda $8301,y
	sta $8301
	lda #$00
	sta $7F01
	lda #$02
	sta $7F08
	lda $1001
	sta r1H
	lda $1000
	sta r1L
	rts

L56A9:	lda $7F02
	sta r4H
	lda #$00
	sta r4L
	ldx $7F08
	lda $8301,x
	sta r1H
	lda fileTrScTab,x
	sta r1L
	ldy #$00
	lda (r4L),y
	beq L56D1
	iny
	lda $8303,x
	sta (r4L),y
	dey
	lda $8302,x
	sta (r4L),y
L56D1:	inx
	inx
	stx $7F08
	jsr WriteBlock
	inc $7F02
	txa
	bne L56F1
	ldy #$00
	lda (r4L),y
	sta $7F07
	beq L56EF
	lda $7F02
	cmp #$43
	bcc L56A9
L56EF:	ldx #$00
L56F1:	rts

	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00
L5704:	.byte $00,$00,$00,$00
L5708:	.byte $00,$00,$00
L570B:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00
L5726:	.byte $00,$00,$00,$00,$00,$00,$00,$00
