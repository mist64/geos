.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

L4000 = $4000
L4003 = $4003
L9030 = $9030
L9033 = $9033
L9050 = $9050
L9053 = $9053
L9063 = $9063
L9066 = $9066
LC316 = $C316
LCFD9 = $CFD9
LFF93 = $FF93
LFF96 = $FF96
LFFA5 = $FFA5
LFFA8 = $FFA8
LFFAB = $FFAB
LFFAE = $FFAE
LFFB1 = $FFB1
LFFB4 = $FFB4
.import DBGFileSelected
.import DBGFTableIndex
.import DBGFilesFound
.import DBGFNameTable

.segment "reu5"

	jmp L502A

	jmp L50DD

	jmp L57C5

	jmp L573F

	jmp L5AB7

	jmp L5889

	jmp L587A

	jmp L5864

	jmp L56C3

	rts

	nop
	nop
	jmp L50D7

	jmp L51CC

	rts

	nop
	nop
	jmp L527C

L502A:	lda r4L
	cmp #$01
	beq L5037
L5030:	cmp #$04
	bne L5047
	lda #$03
	.byte $2C
L5037:	lda #$04
	sta r4L
	lda $88C6
	and #$0F
	cmp r4L
	beq L50BC
	jsr L5161
L5047:	bne L50B8
	jsr PurgeTurbo
	lda $88C6
	and #$F0
	ora r4L
	sta r4L
	ldx #$05
L5057:	cmp L50C9,x
	beq L5061
	dex
	bpl L5057
	bmi L50B8
L5061:	lda $9073
	pha
	lda #$90
	sta r0H
	lda #$00
	sta r0L
	lda L50BD,x
	sta r1L
	lda L50C3,x
	sta r1H
	lda #$0D
	sta r2H
	lda #$80
	sta r2L
	lda r4L
	and #$0F
	cmp #$03
	bne L5089
	dec r2H
L5089:	lda $88C3
	sta r3L
	inc $88C3
	jsr FetchRAM
	dec $88C3
	ldy curDrive
	lda $904E
	sta $8486,y
	sta $88C6
	pla
	sta $9073
	.byte $B9
	.byte $C7
L50A9:	bvc L5030
	.byte $04
	lda L50CB,y
	sta r1H
	lda #$00
	sta r3L
	jmp StashRAM

L50B8:	lda #$FF
	sta r4L
L50BC:	rts

L50BD:	.byte $00,$80,$00,$80,$00,$00
L50C3:	.byte $B2,$BE,$CC,$D8
L50C7:	.byte $E6,$EE
L50C9:	.byte $13,$14
L50CB:	.byte $23,$24,$33,$34,$00,$80,$00,$80
	.byte $83,$90,$9E,$AB
L50D7:	jsr L9050
	lda #$80
	.byte $2C
L50DD:	lda #$00
	sta L5134
	jsr L5161
	beq L50EA
L50E7:	ldx #$00
	rts

L50EA:	jsr L5149
	ldx #$00
	jsr L580A
	lda r0L
	cmp #$01
	beq L50E7
	cmp #$05
	bne L512F
	lda L518C
	cmp #$4E
	beq L510A
	cmp #$38
	bne L50EA
	lda #$04
	.byte $2C
L510A:	lda #$01
	sta r4L
	jsr L502A
	jsr L56F8
	bit L5134
	bpl L5126
	jsr L9050
	txa
	bne L5133
	lda #$00
	sta r2L
	jmp L9066

L5126:	jsr L9063
	jsr L9053
L512C:	jmp L57C5

L512F:	cmp #$32
	beq L512C
L5133:	rts

L5134:	brk
L5135:	ldx #$16
	.byte $2C
L5138:	ldx #$10
	lda #$00
	sta L518C,x
	dex
	lda #$20
L5142:	sta L518C,x
	dex
	bpl L5142
	rts

L5149:	jsr L5174
	bne L5153
	bit L5134
	bpl L5156
L5153:	lda #$00
	.byte $2C
L5156:	lda #$12
	sta L51BE
	rts

L515C:	jsr L5174
	beq L516E
L5161:	jsr L517C
	bcs L516E
	and #$F0
	beq L5171
	cmp #$40
	bcs L5171
L516E:	lda #$00
	rts

L5171:	lda #$80
	rts

L5174:	lda $88C6
	and #$0F
	cmp #$04
	rts

L517C:	lda $88C6
	cmp #$83
	bne L518A
	bit $9073
	bpl L518A
	sec
	rts

L518A:	clc
	rts

L518C:	.byte $00,$00
L518E:	.byte $00,$00,$00,$00
L5192:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00
L51A3:	.byte $24,$3D,$50,$0D,$00
L51A8:	.byte $00
L51A9:	.byte $00
L51AA:	.byte $00,$00,$20,$97,$40,$00,$FF,$00
	.byte $13,$3B,$53,$05,$11,$38,$01,$11
	.byte $60,$10,$06,$1A
L51BE:	.byte $12,$11,$4C,$C4,$51,$00,$0F,$5A
	.byte $00,$00,$06,$10,$14,$53
L51CC:	lda L51E7,x
	sta L522B
	lda L51E9,x
	sta L522C
	jsr L51EB
	lda r0L
	cmp #$01
	beq L51E4
	ldx #$0C
	rts

L51E4:	ldx #$00
	rts

L51E7:	.byte "4I"
L51E9:	.byte "RR"
L51EB:	jsr L57B3
	lda $84B2
	sta L521D
	lda RecoverVector
	sta L521C
	lda #$57
	sta $84B2
	lda #$BC
	sta RecoverVector
	lda #$52
	sta r0H
	lda #$1E
	sta r0L
	jsr DoDlgBox
	lda L521D
	sta $84B2
	lda L521C
	sta RecoverVector
	rts

L521C:	.byte $00
L521D:	.byte $00,$00
	.byte " o@"
	.byte $00,$FF,$00,$13
	.byte "cR"
	.byte $0B,$10
	.byte " "
L522B:	.byte "4"
L522C:	.byte "R"
	.byte $01,$01
	.byte "8"
	.byte $02,$11
	.byte "8"
	.byte $00,$18
	.byte "Insert source disk"


	.byte $1B,$00,$18
	.byte "Insert destination disk"


	.byte $1B,$00
	lda $9FE1
	sta L5270
	jsr LC316
	.byte $08,$04,$18,$0A
L5270:	.byte $B3
	jsr i_FrameRectangle
	.byte $22,$6E
	.word $0042,$00FE
	.byte $FF
	rts

L527C:	jsr ExitTurbo
	jsr InitForIO
	lda #$08
	sta L52E3
L5287:	jsr L52EA
	bmi L52C3
	ldy #$00
L528E:	lda L52E4,y
	jsr LFFA8
	iny
	cpy #$06
	bcc L528E
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	lda L52E3
	jsr L52FF
	bmi L52C3
	jsr LFFA5
	pha
	jsr LFFA5
	pha
	jsr LFFAB
	pla
	tax
	pla
	cmp #$52
	bne L52C3
	cpx #$4C
	beq L52DC
	cpx #$44
	beq L52DC
L52C3:	jsr LFFAE
	jsr LFFAB
L52C9:	inc L52E3
	lda L52E3
	cmp #$0E
	beq L52C9
	cmp #$1F
	bcc L5287
	lda #$00
	sta L52E3
L52DC:	jsr DoneWithIO
	ldx L52E3
	rts

L52E3:	.byte $00
L52E4:	.byte "M-R"
	.byte $A4,$FE,$02
L52EA:	pha
	lda #$00
	sta STATUS
	pla
	jsr LFFB1
	bit STATUS
	bmi L52FE
	lda #$6F
	jsr LFF93
	bit STATUS
L52FE:	rts

L52FF:	pha
	lda #$00
	sta STATUS
	pla
	jsr LFFB4
	bit STATUS
	bmi L5313
	lda #$6F
	jsr LFF96
	bit STATUS
L5313:	rts

	lda #$32
	.byte $2C
L5317:	lda #$50
	bit L55A9
	sta sysDBData
	jmp RstrFrmDialogue

L5322:	lda $9FE1
	sta L532F
	jsr LC316
	php
	.byte $04
	clc
	.byte $0F
L532F:	.byte $B3
	jsr i_FrameRectangle
	.byte $22,$96
	.word $0042,$00FE
	.byte $FF
	rts

	jsr L5322
	jsr OpenDisk
	lda curDrive
	clc
	adc #$39
	sta L53C8
	lda #$53
	sta r1H
	lda #$CB
	sta r1L
	jsr L53F4
	jsr L5161
	bne L5393
	lda #$53
	sta r1H
	lda #$B3
	sta r1L
	jsr L53DC
	lda #$53
	sta r1H
	lda #$AF
	sta r1L
	ldy #$03
	lda #$20
L5371:	sta (r1L),y
	dey
	bpl L5371
	lda L54BA
	jsr L55AA
	lda #$2D
	sta r1H
	lda #$00
	sta r11H
	lda #$46
	sta r11L
	lda #$53
	sta r0H
	lda #$AA
	sta r0L
	jsr PutString
L5393:	lda #$37
	sta r1H
	lda #$00
	sta r11H
	lda #$46
	sta r11L
	lda #$53
	sta r0H
	lda #$C4
	sta r0L
	jmp PutString

	.byte "PART     "

	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00
	.byte "DRV "
L53C8:	.byte "A: "
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00
L53DC:	ldx #$FF
	jsr L5417
	lda #$54
	sta r0H
	lda #$BB
	sta r0L
	lda #$53
	sta r1H
	lda #$B3
	sta r1L
	jmp L53F9

L53F4:	ldx #$02
	jsr GetPtrCurDkNm
L53F9:	ldy #$00
L53FB:	lda (r0L),y
	beq L5412
	cmp #$A0
	beq L5412
	and #$7F
	cmp #$20
	bcs L540B
	lda #$3F
L540B:	sta (r1L),y
	iny
	cpy #$10
	bcc L53FB
L5412:	lda #$00
	sta (r1L),y
	rts

L5417:	stx L5463
	lda curDrive
	sta L545F
	jsr L517C
	bcc L542B
	jsr L527C
	stx L545F
L542B:	jsr PurgeTurbo
	jsr InitForIO
	lda #$54
	sta r0H
	lda #$60
	sta r0L
	ldy #$04
	lda L545F
	jsr L5491
	bne L5454
	lda L545F
	jsr L5464
	bne L5454
	jsr DoneWithIO
	jsr EnterTurbo
	ldx #$00
	rts

L5454:	txa
	pha
	jsr DoneWithIO
	jsr EnterTurbo
	pla
	tax
	rts

L545F:	.byte $00
	.byte "G-P"
L5463:	.byte $FF
L5464:	jsr L52FF
	bmi L5483
	ldy #$00
L546B:	jsr LFFA5
	ldx STATUS
	bne L547D
	sta L54B8,y
	iny
	cpy #$20
	bcc L546B
	jsr L5489
L547D:	jsr LFFAB
	ldx #$00
	rts

L5483:	jsr LFFAB
	ldx #$0D
	rts

L5489:	jsr LFFA5
	ldx STATUS
	beq L5489
	rts

L5491:	sty L54B7
	jsr L52EA
	bmi L54B1
	ldy #$00
L549B:	lda (r0L),y
	jsr LFFA8
	iny
	cpy L54B7
	bcc L549B
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	ldx #$00
	rts

L54B1:	jsr LFFAE
	ldx #$0D
	rts

L54B7:	.byte $00
L54B8:	.byte $00,$00
L54BA:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00
	jsr InitForIO
	jsr L5690
	bcs L551B
	bcc L5539
	lda #$00
	sta L5552
	lda curDrive
	sta L5553
	jsr L517C
	bcc L54FD
	jsr L527C
	stx L5553
	lda #$80
	sta L5552
L54FD:	jsr L5135
	lda curDrive
	jsr SetDevice
	jsr PurgeTurbo
	jsr InitForIO
	jsr L5662
	bcc L5539
	jsr L5690
	bcc L5539
	jsr L5561
	bne L5539
L551B:	jsr L5135
	jsr L5584
	lda L518C
	beq L5539
	jsr LFFAB
	jsr DoneWithIO
	jsr L5554
	lda #$54
	sta r5H
	lda #$D8
	sta r5L
	clc
	rts

L5539:	jsr LFFAE
	jsr LFFAB
	jsr L56A9
	jsr DoneWithIO
	jsr EnterTurbo
	lda #$51
	sta r5H
	lda #$8C
	sta r5L
	sec
	rts

L5552:	brk
L5553:	brk
L5554:	ldy #$00
L5556:	lda L518C,y
	sta (r6L),y
	beq L5560
	iny
	bne L5556
L5560:	rts

L5561:	jsr L5576
	jsr L5576
	jsr L5576
L556A:	jsr LFFA5
	ldx STATUS
	bne L5575
	cmp #$00
	bne L556A
L5575:	rts

L5576:	jsr LFFA5
	sta L5583
	jsr LFFA5
	ora L5583
	rts

L5583:	brk
L5584:	jsr L55E2
	lda L51AA
	beq L55A4
	bmi L5584
	sta L518C
	lda L51A9
	bne L5584
	lda #$51
	sta r1H
	lda #$8E
	sta r1L
	lda L51A8
	jmp L55AA

L55A4:	lda #$00
	sta L518C
L55A9:	rts

L55AA:	ldx #$30
	ldy #$00
L55AE:	cmp #$64
	bcc L55B8
	sec
	sbc #$64
	inx
	bne L55AE
L55B8:	cpx #$30
	beq L55C4
	pha
	txa
	sta (r1L),y
	pla
	iny
	ldx #$30
L55C4:	cmp #$0A
	bcc L55CE
	sec
	sbc #$0A
	inx
	bne L55C4
L55CE:	cpx #$30
	bne L55D6
	cpy #$00
	beq L55DC
L55D6:	pha
	txa
	sta (r1L),y
	pla
	iny
L55DC:	clc
	adc #$30
	sta (r1L),y
	rts

L55E2:	jsr L5576
	beq L565C
	jsr LFFA5
	sta L51A8
	ldx STATUS
	bne L565C
	jsr LFFA5
	sta L51A9
	ldx STATUS
	bne L565C
L55FB:	jsr LFFA5
	ldx STATUS
	bne L565C
	cmp #$00
	beq L565C
	cmp #$22
	bne L55FB
	ldy #$00
L560C:	jsr LFFA5
	ldx STATUS
	bne L565C
	cmp #$22
	beq L561F
	sta L5192,y
	iny
	cpy #$10
	bcc L560C
L561F:	lda #$00
	sta L5192,y
L5624:	jsr LFFA5
	ldx STATUS
	bne L565C
	cmp #$00
	beq L564D
	cmp #$22
	beq L5624
	cmp #$20
	beq L5624
	cmp #$A0
	beq L5624
	bit L5552
	bmi L5644
	cmp #$4E
	beq L5653
L5644:	cmp #$38
	beq L5653
	jsr L556A
	bne L565C
L564D:	lda #$FF
	sta L51AA
	rts

L5653:	sta L51AA
	jsr L556A
	bne L565C
	rts

L565C:	lda #$00
	sta L51AA
	rts

L5662:	lda #$00
	sta STATUS
	lda L5553
	jsr LFFB1
	lda STATUS
	bne L568B
	lda #$F0
	jsr LFF93
	lda STATUS
	bne L568B
	ldy #$00
L567B:	lda L51A3,y
	beq L5686
	jsr LFFA8
	iny
	bne L567B
L5686:	jsr LFFAE
	sec
	rts

L568B:	jsr LFFAE
	clc
	rts

L5690:	lda #$00
	sta STATUS
	lda L5553
	jsr LFFB4
	lda STATUS
	bne L56A9
	lda #$60
	jsr LFF96
	lda STATUS
	bne L56A9
	sec
	rts

L56A9:	jsr LFFAE
	jsr LFFAB
	lda #$00
	sta STATUS
	lda L5553
	jsr LFFB1
	lda #$E0
	jsr LFF93
	jsr LFFAE
	clc
	rts

L56C3:	stx L56F7
	jsr L5161
	bne L56F1
	ldx L56F7
	jsr L5417
	lda L54B8
	sta r4L
	jsr L502A
	lda r4L
	bmi L56F4
	jsr L5135
	lda #$51
	sta r1H
	lda #$8E
	sta r1L
	lda L56F7
	jsr L55AA
	jsr L56F8
L56F1:	ldx #$00
	rts

L56F4:	ldx #$0D
	rts

L56F7:	brk
L56F8:	lda curDrive
	sta L573E
	jsr L517C
	bcc L5709
	jsr L527C
	stx L573E
L5709:	jsr ExitTurbo
	jsr InitForIO
	lda L573E
	jsr L52EA
	lda #$43
	jsr LFFA8
	lda #$50
	jsr LFFA8
	ldy #$00
L5721:	lda L518E,y
	cmp #$20
	beq L5730
	jsr LFFA8
	iny
	cpy #$03
	bcc L5721
L5730:	lda #$0D
	jsr LFFA8
	jsr LFFAE
	jsr DoneWithIO
	jmp EnterTurbo

L573E:	brk
L573F:	jsr L515C
	beq L5747
	ldx #$00
	rts

L5747:	jsr L576F
	lda DBoxDescH
	sta L57B0
	lda DBoxDescL
	sta L57AF
	jsr L5174
	bne L575F
	jsr L57C5
	clv
	bvc L5762
L575F:	jsr L50DD
L5762:	lda L57B0
	sta DBoxDescH
	lda L57AF
	sta DBoxDescL
	ldy #$91
	.byte $2C
L576F:	ldy #$90
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

L57AF:	brk
L57B0:	brk
L57B1:	brk
L57B2:	brk
L57B3:	jsr LCFD9
	jsr L4000
	jmp LCFD9

	jsr LCFD9
	jsr L4003
	jmp LCFD9

L57C5:	jsr L5174
	beq L57CD
	ldx #$00
	rts

L57CD:	jsr L57FD
L57D0:	ldx #$01
	jsr L580A
	lda r0L
	cmp #$50
	beq L57D0
	cmp #$55
	bne L57E2
	jmp L50DD

L57E2:	cmp #$05
	beq L57E7
L57E6:	rts

L57E7:	lda L518C
	beq L57E6
	lda #$51
	sta r6H
	lda #$8C
	sta r6L
	jsr FindFile
	jsr L5864
	clv
	bvc L57D0
L57FD:	lda $88C6
	and #$70
	beq L5806
	lda #$12
L5806:	sta L5949
	rts

L580A:	txa
	pha
	jsr L57B3
	lda $84B2
	sta L57B2
	lda RecoverVector
	sta L57B1
	lda #$57
	sta $84B2
	lda #$BC
	sta RecoverVector
	lda #$05
	sta $9FF1
	pla
	tax
	lda L585A,x
	sta r5L
	lda L585C,x
	sta r5H
	lda L585E,x
	sta r7L
	lda L5860,x
	sta r0L
	lda L5862,x
	sta r0H
	jsr DoDlgBox
	lda L57B2
	sta $84B2
	lda L57B1
	sta RecoverVector
	lda #$00
	sta $9FF1
	rts

L585A:	.byte $E2,$A1
L585C:	.byte "TX"
L585E:	.byte $97,$91
L5860:	.byte $AB
	.byte ","
L5862:	.byte "QY"
L5864:	lda dirEntryBuf
	and #$BF
	cmp #$86
	bne L589E
	lda $8402
	sta r1H
	lda $8401
	sta r1L
	clv
	bvc L588F
L587A:	jsr GetDirHead
	lda $8223
	sta r1H
	lda $8222
	sta r1L
	bne L588F
L5889:	lda #$01
	sta r1L
	sta r1H
L588F:	jsr L5174
	bne L589E
	lda #$00
	sta r2L
	jsr L9066
	jmp L9053

L589E:	ldx #$05
	rts

	jsr L5138
	lda curDrive
	jsr SetDevice
	jsr OpenDisk
	txa
	bne L5910
	jsr L9030
	txa
	bne L5910
L58B6:	ldy #$00
	lda (r5L),y
	and #$BF
	cmp #$86
	bne L5907
	ldy #$03
	ldx #$00
L58C4:	lda (r5L),y
	beq L58D5
	cmp #$A0
	beq L58D5
	sta L518C,x
	iny
	inx
	cpx #$10
	bne L58C4
L58D5:	lda #$00
	sta L518C,x
	lda #$51
	sta r0H
	lda #$8C
	sta r0L
	ldx #$02
	ldy #$0E
	jsr CopyString
	lda r5H
	sta L591B
	lda r5L
	sta L591A
	lda #$58
	sta r5H
	lda #$FD
	sta r5L
	clc
	rts

	lda L591B
	sta r5H
	lda L591A
	sta r5L
L5907:	jsr L9033
	txa
	bne L5910
	tya
	beq L58B6
L5910:	lda #$51
	sta r5H
	lda #$8C
	sta r5L
	sec
	rts

L591A:	brk
L591B:	brk
	jsr L587A
	txa
	beq L5929
L5922:	rts

	jsr L5889
	txa
	bne L5922
L5929:	jmp L5317

	.byte $00,$20,$97,$40,$00,$FF,$00,$13
	.byte $3B,$53,$10,$06,$1A,$05,$11,$10
	.byte $01,$11,$60,$12,$11,$24,$4F,$59
	.byte $12,$11,$38,$57,$59
L5949:	.byte $12,$11,$4C,$5F,$59,$00,$BB,$59
	.byte $00,$00,$06,$10,$23,$59,$67,$59
	.byte $00,$00,$06,$10,$1C,$59,$63,$5A
	.byte $00,$00,$06,$10,$1A,$53,$05,$FF
	.byte $82,$FE,$80,$04,$00,$82,$03,$80
	.byte $04,$00,$B8,$03,$83,$F0,$00,$00
	.byte $01,$83,$83,$18,$00,$00,$01,$83
	.byte $83,$19,$C7,$9C,$F3,$C3,$83,$1B
	.byte $67,$36,$F9,$83,$83,$F0,$66,$36
	.byte $D9,$83,$83,$01,$E6,$3E,$D9,$83
	.byte $83,$03,$66,$30,$D9,$83,$83,$03
	.byte $66,$36,$D9,$83,$83,$01,$F6,$1C
	.byte $D9,$C3,$80,$04,$00,$82,$03,$80
	.byte $04,$00,$81,$03,$06,$FF,$81,$7F
	.byte $05,$FF,$05,$FF,$82,$FE,$80,$04
	.byte $00,$82,$03,$80,$04,$00,$B8,$03
	.byte $80,$1F,$80,$00,$C0,$03,$80,$18
	.byte $C0,$00,$C0,$03,$80,$18,$CE,$39
	.byte $E0,$03,$80,$18,$DB,$6C,$C0,$03
	.byte $80,$1F,$9B,$6C,$C0,$03,$80,$19
	.byte $9B,$6C,$C0,$03,$80,$18,$DB,$6C
	.byte $C0,$03,$80,$18,$DB,$6C,$C0,$03
	.byte $80,$18,$CE,$38,$E0,$03,$80,$04
	.byte $00,$82,$03,$80,$04,$00,$81,$03
	.byte $06,$FF,$81,$7F,$05,$FF,$05,$FF
	.byte $82,$FE,$80,$04,$00,$82,$03,$80
	.byte $04,$00,$B8,$03,$80,$F8,$06,$03
	.byte $60,$03,$81,$8C,$06,$03,$00,$03
	.byte $81,$8D,$B7,$8F,$6F,$03,$81,$81
	.byte $B7,$DF,$6E,$03,$80,$F9,$B6,$DB
	.byte $6C,$03,$80,$0D,$B6,$DB,$6C,$03
	.byte $81,$8D,$B6,$DB,$6C,$03,$81,$8D
	.byte $F7,$DF,$6C,$03,$80,$F8,$F7,$8F
	.byte $6C,$03,$80,$04,$00,$82,$03,$80
	.byte $04,$00,$81,$03,$06,$FF,$81,$7F
	.byte $05,$FF,$05,$FF,$82,$FE,$80,$04
	.byte $00,$82,$03,$80,$04,$00,$B8,$03
	.byte $80,$1F,$80,$00,$C0,$03,$80,$18
	.byte $C0,$00,$C0,$03,$80,$18,$CE,$3D
	.byte $E0,$03,$80,$18,$DB,$38,$C0,$03
	.byte $80,$1F,$83,$30,$C0,$03,$80,$18
	.byte $0F,$30,$C0,$03,$80,$18,$1B,$30
	.byte $C0,$03,$80,$18,$1B,$30,$C0,$03
	.byte $80,$18,$0F,$B0,$EC,$03,$80,$04
	.byte $00,$82,$03,$80,$04,$00,$81,$03
	.byte $06,$FF,$81,$7F,$05,$FF
L5AB7:	.byte $A9,$FF
	sta r7H
	lda #$C3
	sta r5H
	lda #$0A
	sta r5L
	lda r7L
	eor #$80
	sta $9FF3
	bmi L5ADB
	lda $885A
	sta r5H
	lda DBGFNameTable
	sta r5L
	lda r7L
	and #$7F
	.byte $2C
L5ADB:	lda #$11
	sta $9FF2
	lda #$00
	sta DBGFilesFound
	sta DBGFTableIndex
L5AE8:	jsr L5B58
	lda #$05
	sta DBGFileSelected
	lda #$83
	sta r6H
	lda #$00
	sta r6L
L5AF8:	jsr L5B51
	bcs L5B32
	lda r6L
	adc $9FF2
	sta r6L
	bcc L5B08
	inc r6H
L5B08:	inc DBGFilesFound
	dec DBGFileSelected
	bne L5AF8
	lda DBGFTableIndex
	jsr L5B62
	jsr StashRAM
	lda DBGFilesFound
	sta DBGFTableIndex
	cmp #$FF
	bcc L5AE8
L5B23:	lda #$83
	sta r6H
	lda #$00
	sta r6L
	jsr L5B51
	bcc L5B23
	bcs L5B3B
L5B32:	lda DBGFTableIndex
	jsr L5B62
	jsr StashRAM
L5B3B:	bit $9FF3
	bpl L5B46
	lda #$00
	sta $9FF3
	rts

L5B46:	lda r5H
	sta $885A
	lda r5L
	sta DBGFNameTable
	rts

L5B51:	lda r5L
	ldx r5H
	jmp CallRoutine

L5B58:	ldx #$00
	txa
L5B5B:	sta fileTrScTab,x
	inx
	bne L5B5B
	rts

L5B62:	sta r1L
	lda r7H
	pha
	lda r7L
	pha
	lda #$05
	sta r0L
	lda $9FF2
	sta r2L
	ldx #$06
	ldy #$02
	jsr BBMult
	lda $9FF2
	sta r0L
	ldx #$04
	ldy #$02
	jsr BBMult
	clc
	lda r1L
	adc #$80
	sta r1L
	lda r1H
	adc #$E0
	sta r1H
	lda #$83
	sta r0H
	lda #$00
	sta r0L
	lda #$00
	sta r3L
	pla
	sta r7L
	pla
	sta r7H
	rts

