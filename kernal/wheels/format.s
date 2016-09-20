.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

.import FreeBlock
.import PutBlock
.import EnterTurbo
.import DoneWithIO
.import InitForIO
.import PurgeTurbo
.import GetDirHead
.import ExitTurbo
.import CopyFString
.import BitmapUp
.import i_FrameRectangle
.import i_ColorRectangle
.import DoDlgBox
.import StashRAM
.import FetchRAM
.import PutDirHead
.import SetNextFree

.import sysDBColor

.segment "format"

.ifdef wheels

L4000 = $4000
L4003 = $4003
L903F = $903F
L9050 = $9050
L9063 = $9063
L9066 = $9066
LFF54 = $FF54
LFF93 = $FF93
LFF96 = $FF96
LFFA5 = $FFA5
LFFA8 = $FFA8
LFFAB = $FFAB
LFFAE = $FFAE
LFFB1 = $FFB1
LFFB4 = $FFB4
.import Swap4000

NSetGEOSDisk:
	jmp _NSetGEOSDisk
DBFormat:
	jmp _DBFormat
FormatDisk:
	jmp _FormatDisk
DBEraseDisk:
	jmp _DBEraseDisk
EraseDisk:
	jmp _EraseDisk

L500F:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00

L5020:	jsr Swap4000
	jsr L4000
	jmp Swap4000

	jsr Swap4000
	jsr L4003
	jmp Swap4000

_NSetGEOSDisk:
	lda #$31
	sta L50C9
	jsr GetBorder
	bnex L5068
	bit isGEOS
	bmi L5068
	lda curType
	and #$0F
	cmp #$04
	bne L5073
	lda $8223
	sta r1H
	lda $8222
	sta r1L
	beq L5069
	jsr ReadBuff
	bne L5068
	lda $80AC
	sta r1H
	lda $80AB
	sta r1L
	bne L50A2
L5068:	rts

L5069:	lda #$01
	sta r3L
	lda #$FE
	sta r3H
	bne L508E
L5073:	cmp #$03
	beq L5086
	lda #$30
	sta L50C9
	lda #$13
	sta r3L
	lda #$0B
	sta r3H
	bne L508E
L5086:	lda #$29
	sta r3L
	lda #$13
	sta r3H
L508E:	jsr SetNextFree
	bnex L5068
	lda r3H
	sta r1H
	lda r3L
	sta r1L
	jsr L5CB4
	bnex L5068
L50A2:	lda r1H
	sta $82AC
	lda r1L
	sta $82AB
	ldy #$0F
L50AE:	lda L50BA,y
	sta $82AD,y
	dey
	bpl L50AE
	jmp PutDirHead

L50BA:	.byte "GEOS format V1."

L50C9:	.byte "0"

_DBFormat:
	jsr L50FD
	jsr L516B
	jsr L50D7
	ldx L5430
	rts

L50D7:	lda L516A
	sta $84B2
	lda L5169
	sta RecoverVector
	lda L5168
	sta DBoxDescH
	lda L5167
	sta DBoxDescL
	jsr L514A
	jsr FetchRAM
	jsr L512D
	jsr FetchRAM
	ldx L5430
	rts

L50FD:	jsr L512D
	jsr StashRAM
	jsr L514A
	jsr StashRAM
	jsr L5020
	lda DBoxDescH
	sta L5168
	lda DBoxDescL
	sta L5167
	lda $84B2
	sta L516A
	lda RecoverVector
	sta L5169
	lda #$50
	sta $84B2
	lda #$29
	sta RecoverVector
	rts

L512D:	lda #$85
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
	rts

L514A:	lda #$88
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
	lda #$00
	sta r3L
	rts

L5167:	.byte 0
L5168:	.byte 0
L5169:	.byte 0
L516A:	.byte 0

L516B:	lda curType
	cmp #$02
	bne L5175
	lda #$12
	.byte $2C
L5175:	lda #$00
	sta L51F9
	lda #$00
	sta L500F
	LoadW r0, L51E2
	LoadW r5, L500F
	jsr DoDlgBox
	lda r0L
	cmp #$02
	beq L51D8
	lda L500F
	beq L51D8
	ldx #$00
L519F:	lda L51DE,x
	sta L53D1
	lda L51E0,x
	sta L53D2
	jsr L5242
	lda #$52
	sta r0H
	lda #$0E
	sta r0L
	jsr DoDlgBox
	lda r0L
	cmp #$04
	beq L51D8
	lda #$53
	sta L53D7
	lda #$ED
	sta L53D6
	lda #$53
	sta r0H
	lda #$C1
	sta r0L
	jsr DoDlgBox
	ldx L5430
	rts

L51D8:	ldx #$0C
	stx L5430
	rts

L51DE:	.byte $1C,$13
L51E0:	.byte $54,$5C
L51E2:	.byte $00,$28,$5F,$38,$00,$07
	.byte $01,$13,$29,$52,$02,$13,$20,$0B
	.byte $10,$0E,$BB,$52,$0D,$18,$18,$0C
	.byte $10
L51F9:	.byte $12,$13,$08,$A1,$53,$0B,$A6,$0F
	.byte $12,$53,$12,$13,$14,$A9,$53,$0B
	.byte $A6,$1B,$1A,$53,$00,$00,$28,$5F
	.byte $38,$00,$07,$01,$13,$29,$52,$03
	.byte $01,$20,$04,$13,$20,$0B,$08,$0E
	.byte $D2,$52,$0B,$14,$18
L5226:	.byte $F2
L5227:	.byte $52,$00

	lda sysDBColor
	sta L5236
	jsr i_ColorRectangle
	.byte 7, 5, 26, 7
L5236:	.byte $B3
	jsr i_FrameRectangle
	.byte 42, 94
	.word 58, 262
	.byte $FF
	rts

L5242:	ldy #$02
	lda #$20
L5246:	sta L52FD,y
	dey
	bpl L5246
	lda curDrive
	add #$39
	sta L52EE
	lda #$53
	sta L5227
	lda #$03
	sta L5226
	jsr L5562
	beq L5271
	lda curType
	cmp #$83
	bne L5270
	bit $9073
	bmi L5271
L5270:	rts

L5271:	lda #$52
	sta L5227
	lda #$F2
	sta L5226
	jsr L9063
	lda r2L
	ldx #$30
	ldy #$00
L5284:	cmp #$64
	bcc L528E
	sec
	sbc #$64
	inx
	bne L5284
L528E:	cpx #$30
	beq L529B
	pha
	txa
	sta L52FD,y
	pla
	iny
	ldx #$30
L529B:	cmp #$0A
	bcc L52A5
	sec
	sbc #$0A
	inx
	bne L529B
L52A5:	cpx #$30
	bne L52AD
	cpy #$00
	beq L52B4
L52AD:	pha
	txa
	sta L52FD,y
	pla
	iny
L52B4:	add #$30
	sta L52FD,y
	rts

	.byte $18
	.byte "Enter a disk name..."


	.byte $1B,$00,$18
	.byte "Operation will be to drive "



L52EE:	.byte "A,"
	.byte $1B,$00,$18
	.byte "Partition "

L52FD:	.byte "      "
	.byte $18
	.byte "...Continue?"

	.byte $1B,$00
	.byte "1-sided"
	.byte $00
	.byte "2-sided"
	.byte $00
	ldx L571C
	cpx #$29
	bne L532A
	rts

L532A:	lda #$29
	sta L571C
	lda #$53
	sta L53A2
	lda #$B1
	sta L53A1
	lda #$53
	sta L53AA
	lda #$BB
	sta L53A9
	jmp L5367

	ldx L571C
	cpx #$29
	beq L534E
	rts

L534E:	lda #$00
	sta L571C
	lda #$53
	sta L53AA
	lda #$B1
	sta L53A9
	lda #$53
	sta L53A2
	lda #$BB
	sta L53A1
L5367:	lda L53A2
	sta r0H
	lda L53A1
	sta r0L
	lda #$1A
	sta r1L
	lda #$30
	sta r1H
	lda #$01
	sta r2L
	lda #$08
	sta r2H
	jsr BitmapUp
	lda L53AA
	sta r0H
	lda L53A9
	sta r0L
	lda #$1A
	sta r1L
	lda #$3C
	sta r1H
	lda #$01
	sta r2L
	lda #$08
	sta r2H
	jmp BitmapUp

L53A1:	.byte $BB
L53A2:	.byte $53,$00,$00,$01,$08,$22,$53
L53A9:	.byte $B1
L53AA:	.byte $53,$00,$00,$01,$08,$46,$53,$89
	.byte $7E,$81,$81,$99,$99,$81,$81,$7E
	.byte $BF,$81,$7E,$06,$81,$81,$7E,$00
	.byte $28,$5F,$38,$00,$07,$01,$13,$29
	.byte $52,$0B,$08,$0E,$DC,$53,$13
L53D1:	.byte $1C
L53D2:	.byte $54,$0B,$08,$18
L53D6:	.byte $ED
L53D7:	.byte $53,$01,$13,$20
	.byte 0

	.byte $18, "Please Wait...", $1B, 0

	.byte $18, "Operation completed", $1B, 0
	.byte $18, "Disk error encountered", $1B, 0

	jsr L5445
	txa
	sta L5430
	beq L542F
	lda #$54
	sta L53D7
	lda #$03
	sta L53D6
L542F:	rts

L5430:	.byte 0

_FormatDisk:
	stx L571C
	lda #$50
	sta r1H
	lda #$0F
	sta r1L
	ldx #$02
	ldy #$04
	lda #$10
	jsr CopyFString
L5445:	jsr L9050
	lda #$00
	sta L5627
	lda $904F
	cmp #$50
	bcc L548A
	lda curType
	and #$0F
	sta L548D
	lda curType
	bpl L5464
	jmp L54D4

L5464:	cmp #$04
	bne L546B
	jmp L5875

L546B:	lda L548D
	cmp #$04
	bne L5475
	jmp L57DC

L5475:	cmp #$03
	bne L547C
	jmp L5632

L547C:	cmp #$02
	bne L5483
	jmp L56E4

L5483:	cmp #$01
	bne L548A
	jmp L57E2

L548A:	ldx #$0D
	rts

L548D:	.byte 0

L548E:	jsr L9050
	bnex L5498
	jsr _NSetGEOSDisk
	txa
L5498:	pha
	jsr ExitTurbo
	pla
	tax
	rts

L549F:	lda random
	jsr L54B4
	sta L54B2
	lda $850B
	jsr L54B4
	sta L54B3
	rts

L54B2:	.byte $4D
L54B3:	.byte $52
L54B4:	and #$7F
	cmp #$5B
	bcc L54BD
	sec
	sbc #$20
L54BD:	cmp #$41
	bcs L54D3
L54C1:	cmp #$3A
	bcc L54CA
	sec
	sbc #$03
	bcs L54C1
L54CA:	cmp #$30
	bcs L54D3
	add #$03
	bcc L54CA
L54D3:	rts

L54D4:	lda L548D
	cmp #$04
	bne L54DE
	jmp L54F6

L54DE:	cmp #$03
	bne L54E5
	jmp L5508

L54E5:	cmp #$02
	bne L54EC
	jmp L5513

L54EC:	cmp #$01
	bne L54F3
	jmp L551C

L54F3:	ldx #$0D
	rts

L54F6:	jsr L549F
	lda $9062
	sta L5DAD
	sta L594A
	jsr L58B6
	jmp L548E

L5508:	jsr L549F
	lda #$28
	sta L5DAD
	jmp L5643

L5513:	jsr L549F
	jsr L5775
	bra L5522
L551C:	jsr L549F
	jsr L5786
L5522:	jsr GetDirHead
	lda $8201
	sta r1H
	lda curDirHead
	sta r1L
	jsr L5DAE
	jsr L5CD9
	jsr PutDirHead
	jmp L548E

L553B:	jsr L5562
	bne L555F
	jsr L5573
	lda L548D
	cmp L55DB
	beq L555C
	lda L55DB
	bne L555F
	lda curType
	and #$F0
	cmp #$10
	bne L555C
	jsr L55E4
L555C:	ldx #$00
	rts

L555F:	ldx #$0D
	rts

L5562:	lda curType
	and #$F0
	beq L5570
	cmp #$40
	bcs L5570
	lda #$00
	rts

L5570:	lda #$80
	rts

L5573:	jsr PurgeTurbo
	jsr InitForIO
	jsr L55A5
	lda curType
	and #$F0
	cmp #$10
	bne L559F
	lda L55DC
	and #$20
	bne L559F
	lda #$55
	sta z8c
	lda #$DD
	sta z8b
	ldy #$07
	lda curDrive
	jsr L5B6D
	jsr L55A5
L559F:	jsr DoneWithIO
	jmp EnterTurbo

L55A5:	lda #$55
	sta z8c
	lda #$D7
	sta z8b
	ldy #$04
	lda curDrive
	jsr L5B6D
	lda curDrive
	jsr L5BD3
	ldx L5BAB
	cpx #$05
	bcc L55C5
	ldx #$0D
	rts

L55C5:	lda L55D2,x
	sta L55DB
	lda L5BAC
	sta L55DC
	rts

L55D2:	.byte $00,$04,$01,$02,$03,$47,$2D,$50
	.byte $FF
L55DB:	.byte $00
L55DC:	.byte $00
	.byte "M-W"
	.byte $25
	.word $0100
	.byte $01
L55E4:	lda #$38
	sta L562F
	lda #$31
	sta L5630
	lda #$20
	sta L5631
	lda L55DC
	bmi L55FB
	ldx #$21
	rts

L55FB:	and #$10
	bne L561F
	lda #$44
	sta L5630
	lda L55DC
	and #$07
	tax
	lda L5628,x
	sta L562F
	lda L548D
	cmp #$03
	beq L561A
	lda #$4E
	.byte $2C
L561A:	lda #$38
	sta L5631
L561F:	lda #$FF
	sta L5627
	ldx #$00
	rts

L5627:	.byte $00
L5628:	.byte "DDHEDHE"
L562F:	.byte "8"
L5630:	.byte "1"
L5631:	.byte " "
L5632:	jsr L553B
	bne L563A
	jmp L57E2

L563A:	jsr L549F
	jsr L5976
	bnex L564C
L5643:	jsr L5653
	bnex L564C
	jmp L5522

L564C:	pha
	jsr ExitTurbo
	pla
	tax
	rts

L5653:	ldy #$00
	tya
L5656:	sta curDirHead,y
	sta $8900,y
	sta $9C80,y
	iny
	bne L5656
	ldy #$02
L5664:	lda L56AA,y
	sta curDirHead,y
	dey
	bpl L5664
	ldy #$04
L566F:	lda L56AD,y
	sta $82A4,y
	dey
	bpl L566F
	jsr L56C0
	ldy #$06
L567D:	lda L56B2,y
	sta $8900,y
	lda L56B9,y
	sta $9C80,y
	dey
	bpl L567D
	lda L54B2
	sta $8904
	sta $9C84
	sta $82A2
	lda L54B3
	sta $8905
	sta $9C85
	sta $82A3
	jsr PutDirHead
	jmp L5D09

L56AA:	.byte $28,$03,$44
L56AD:	.byte $A0,$33,$44,$A0,$A0
L56B2:	.byte $28,$02,$44,$BB,$00,$00,$C0
L56B9:	.byte $00,$FF,$44,$BB,$00,$00,$C0
L56C0:	ldy #$00
L56C2:	lda L500F,y
	beq L56CF
	sta $8290,y
	iny
	cpy #$10
	bne L56C2
L56CF:	lda #$A0
L56D1:	sta $8290,y
	iny
	cpy #$12
	bne L56D1
	rts

L56DA:	ldy #$00
	tya
L56DD:	sta diskBlkBuf,y
	iny
	bne L56DD
	rts

L56E4:	jsr L549F
	jsr PurgeTurbo
	lda L571C
	cmp #$29
	bne L5701
	jsr L571D
	jsr L57FB
	beqx L5719
L56FA:	pha
	jsr EnterTurbo
	pla
	tax
	rts

L5701:	jsr L5738
	bnex L56FA
	jsr InitForIO
	jsr L585B
	jsr DoneWithIO
	bnex L56FA
	jsr L5775
	bnex L56FA
L5719:	jmp L5522

L571C:	.byte 0

L571D:	jsr InitForIO
	lda #$57
	sta z8c
	lda #$33
	sta z8b
	ldy #$05
	lda curDrive
	jsr L5B6D
	jmp DoneWithIO

	.byte "U0>M0"
L5738:	jsr InitForIO
	lda L54B3
	sta L5774
	lda L54B2
	sta L5773
	lda #$57
	sta z8c
	lda #$6C
	sta z8b
	ldy #$03
	lda curDrive
	jsr L5B6D
	bne L5769
	lda #$57
	sta z8c
	lda #$6F
	sta z8b
	ldy #$06
	lda curDrive
	jsr L5B6D
L5769:	jmp DoneWithIO

	.byte "U0"
	.byte $04
	.byte "U0"
	.byte $06,$00
L5773:	.byte "M"
L5774:	.byte "R"
L5775:	jsr L578C
	jsr GetDirHead
	lda #$80
	sta $8203
	jsr L57B4
	jmp L5D52

L5786:	jsr L578C
	jmp L5D7E

L578C:	jsr L57D2
	jsr L56C0
	lda L54B3
	sta $82A3
	lda L54B2
	sta $82A2
	ldy #$03
L57A0:	lda L57C7,y
	sta curDirHead,y
	dey
	bpl L57A0
	ldy #$06
L57AB:	lda L57CB,y
	sta $82A4,y
	dey
	bpl L57AB
L57B4:	lda #$82
	sta r4H
	lda #$00
	sta r4L
	lda #$12
	sta r1L
	lda #$00
	sta r1H
	jmp PutBlock

L57C7:	.byte $12,$01,$41,$00
L57CB:	.byte $A0,$32,$41,$A0,$A0,$A0,$A0
L57D2:	ldy #$00
	tya
L57D5:	sta curDirHead,y
	iny
	bne L57D5
	rts

L57DC:	jsr L553B
	beq L57E2
	rts

L57E2:	jsr L549F
	jsr PurgeTurbo
	jsr L57FB
	bnex L57FA
	jsr GetDirHead
	jsr L5CD9
	jsr PutDirHead
	jmp L548E

L57FA:	rts

L57FB:	jsr InitForIO
	lda #$58
	sta z8c
	lda #$58
	sta z8b
	lda curDrive
	ldy #$03
	jsr L5B7D
	beq L5813
	jmp DoneWithIO

L5813:	ldy #$00
L5815:	lda L500F,y
	beq L5822
	jsr LFFA8
	iny
	cpy #$10
	bne L5815
L5822:	lda #$2C
	jsr LFFA8
	lda L54B2
	jsr LFFA8
	lda L54B3
	jsr LFFA8
	bit L5627
	bpl L584A
	lda #$2C
	jsr LFFA8
	ldy #$00
L583F:	lda L562F,y
	jsr LFFA8
	iny
	cpy #$03
	bne L583F
L584A:	lda #$0D
	jsr LFFA8
	jsr LFFAE
	jsr L585B
	jmp DoneWithIO

	lsr $3A30
L585B:	lda curDrive
	jsr L5BD3
	bne L5872
	lda L5BAB
	cmp #$30
	bne L5872
	cmp L5BAC
	bne L5872
	ldx #$00
	.byte $2C
L5872:	ldx #$21
	rts

L5875:	jsr EnterTurbo
	lda #$0C
	sta L594A
	sta $9062
	jsr L5962
	bnex L5895
	jsr L589C
	bnex L5895
	jsr L58B6
	bnex L5895
	jmp L548E

L5895:	pha
	jsr ExitTurbo
	pla
	tax
	rts

L589C:	jsr L56DA
	lda #$07
	sta r1L
	lda #$18
	sta r1H
L58A7:	jsr L903F
	bnex L58B5
	inc r1H
	lda r1H
	cmp #$1C
	bcc L58A7
L58B5:	rts

L58B6:	lda L54B3
	sta L5947
	lda L54B2
	sta L5946
	ldy #$00
	lda #$FF
L58C6:	sta diskBlkBuf,y
	iny
	bne L58C6
	lda #$01
	sta r1L
	lda #$03
	sta r1H
L58D4:	jsr L903F
	inc r1H
	lda r1H
	cmp #$22
	bcc L58D4
	ldy #$1F
L58E1:	lda L5942,y
	sta diskBlkBuf,y
	dey
	bpl L58E1
	lda #$01
	sta r1L
	lda #$02
	sta r1H
	jsr L903F
	jsr L57D2
	lda #$01
	sta curDirHead
	lda #$22
	sta $8201
	lda #$48
	sta $8202
	lda #$01
	sta $8220
	sta $8221
	jsr L56C0
	lda L54B3
	sta $82A3
	lda L54B2
	sta $82A2
	ldy #$04
L5920:	lda L593D,y
	sta $82A4,y
	dey
	bpl L5920
	lda #$01
	sta r1L
	sta r1H
	lda #$82
	sta r4H
	lda #$00
	sta r4L
	jsr PutBlock
	jmp L5CE4

L593D:	.byte $A0,$31,$48,$A0,$A0
L5942:	.byte $00,$00,$48,$B7
L5946:	.byte $46
L5947:	.byte $44,$C0,$00
L594A:	.byte $0C,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
L5962:	lda #$46
	sta L54B2
	lda #$44
	sta L54B3
	jsr L5976
	bnex L5975
	jmp L5AE9

L5975:	rts

L5976:	jsr PurgeTurbo
	jsr InitForIO
	lda L54B3
	sta L59BB
	lda L54B2
	sta L59BA
	lda #$59
	sta z8c
	lda #$B4
	sta z8b
	ldy #$08
	lda curDrive
	jsr L5B6D
	lda curDrive
	jsr L5BD3
	bne L59B1
	lda L5BAB
	cmp #$30
	bne L59AF
	cmp L5BAC
	bne L59AF
	ldx #$00
	.byte $2C
L59AF:	ldx #$21
L59B1:	jmp DoneWithIO

	.byte "N0:MR,"
L59BA:	.byte "F"
L59BB:	.byte "D"
	.byte $00,$00,$01,$01,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte "CMD FD SERIES   "

	.byte $01,$01,$FF,$00,$00
	.byte "SYSTEM"
	.byte $A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0
	.byte $A0,$A0,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$01
	.byte $00,$00
	.byte "PARTITION 1"

	.byte $A0,$A0,$A0,$A0,$A0,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$06,$00
	.byte $08
	sei
	lda #$00
L5A20:	sta $01CE
	lda #$9C
	ldx #$00
	jsr LFF54
	lda #$50
	sta $01BC
	lda #$8C
	ldx #$00
	jsr LFF54
	lda #$8E
	ldx #$00
	jsr LFF54
	lda #$01
	cmp $01CE
	bne L5A20
	ldy #$00
L5A46:	lda #$00
	sta $0300,y
	lda #$FF
	sta APP_RAM,y
	iny
	bne L5A46
	tya
	sta APP_RAM
	sta $0438
	sta $0439
	sta $0470
	sta $04A8
	lda #$06
	sta $0471
	lda #$40
	sta $04A9
	lda #$01
	sta $04E2
	sta $04E3
	ldy #$1F
L5A77:	lda $0500,y
	sta $04E0,y
	dey
	bpl L5A77
	lda #$50
	sta r4H
	lda #$03
	sta r5L
	lda #$00
	sta $01CE
	lda #$A6
	ldx #$00
	jsr LFF54
	ldy #$00
	tya
L5A97:	sta $0300,y
	sta APP_RAM,y
	iny
	bne L5A97
	lda #$FF
	sta $0401
	lda #$01
	sta $0300
	lda #$03
	sta $0301
	lda #$50
	sta r4H
	lda #$06
	sta r5L
	lda #$00
	sta $01CE
	lda #$A6
	ldx #$00
	jsr LFF54
	ldy #$3F
L5AC5:	lda $0520,y
	sta $0300,y
	dey
	bpl L5AC5
	lda #$02
	sta $0401
	lda #$50
	sta r4H
	lda #$05
	sta r5L
	lda #$00
	sta $01CE
	lda #$A6
	ldx #$00
	jsr LFF54
	plp
	rts

L5AE9:	jsr PurgeTurbo
	jsr InitForIO
	lda #$00
	sta L5B65
	lda #$05
	sta L5B66
	lda #$59
	sta r0H
	lda #$BC
	sta r0L
L5B01:	ldy #$06
	lda #$5B
	sta z8c
	lda #$62
	sta z8b
	lda curDrive
	jsr L5B7D
	bne L5B5F
	ldy #$00
L5B15:	lda (r0),y
	jsr LFFA8
	iny
	cpy #$20
	bcc L5B15
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	clc
	lda L5B65
	adc #$20
	sta L5B65
	bcc L5B35
	inc L5B66
L5B35:	lda r0H
	cmp #$5A
	bne L5B3F
	lda r0L
	cmp #$E9
L5B3F:	bcs L5B4F
	clc
	lda #$20
	adc r0L
	sta r0L
	bcc L5B4C
	inc r0H
L5B4C:	bra L5B01
L5B4F:	lda #$5B
	sta z8c
	lda #$68
	sta z8b
	lda curDrive
	ldy #$05
	jsr L5B6D
L5B5F:	jmp DoneWithIO

	.byte "M-W"
L5B65:	.byte $00
L5B66:	.byte $05,$20
	.byte "M-E"
	.word $0560
L5B6D:	jsr L5B7D
	bne L5B7C
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	ldx #$00
L5B7C:	rts

L5B7D:	sty L5BAA
	ldy #$00
	sty STATUS
	jsr LFFB1
	lda STATUS
	bne L5BA4
	lda #$6F
	jsr LFF93
	lda STATUS
	bne L5BA4
	ldy #$00
L5B96:	lda (z8b),y
	jsr LFFA8
	iny
	cpy L5BAA
	bne L5B96
	ldx #$00
	rts

L5BA4:	jsr LFFAE
	ldx #$0D
	rts

L5BAA:	.byte $00
L5BAB:	.byte $00
L5BAC:	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00,$00
	.byte $00,$00,$00,$00,$00,$00,$00
L5BD3:	ldy #$00
	sty STATUS
	jsr LFFB4
	lda STATUS
	bne L5BFE
	lda #$6F
	jsr LFF96
	lda STATUS
	bne L5BFE
	ldy #$00
L5BE9:	jsr LFFA5
	ldx STATUS
	bne L5BF8
	sta L5BAB,y
	iny
	cpy #$28
	bcc L5BE9
L5BF8:	jsr LFFAB
	ldx #$00
	rts

L5BFE:	jsr LFFAB
	ldx #$0D
	rts

_DBEraseDisk:
	jsr L50FD
	ldx #$01
	jsr L519F
	jsr L50D7
	ldx L5430
	rts

_EraseDisk:
	jsr L9050
	lda #$00
	sta r2L
	jsr L9066
	lda #$82
	sta r0H
	lda #$90
	sta r0L
	lda #$50
	sta r1H
	lda #$0F
	sta r1L
	ldx #$02
	ldy #$04
	lda #$10
	jsr CopyFString
	lda $82A3
	sta L54B3
	lda $82A2
	sta L54B2
	lda $82AC
	sta L5C77
	lda $82AB
	sta L5C76
	jsr L5C78
	lda L5C77
	sta $82AC
	lda L5C76
	sta $82AB
	jsr L5C9C
	jsr L5CD9
	jsr PutDirHead
	stx L5430
	beq L5C75
	lda #$54
	sta L53D7
	lda #$03
	sta L53D6
L5C75:	rts

L5C76:	.byte 0
L5C77:	.byte 0

L5C78:	lda curType
	and #$0F
	cmp #$04
	bne L5C84
	jmp L5CE4

L5C84:	cmp #$03
	bne L5C8B
	jmp L5653

L5C8B:	cmp #$02
	bne L5C92
	jmp L5D52

L5C92:	cmp #$01
	bne L5C99
	jmp L5D7E

L5C99:	ldx #$0D
	rts

L5C9C:	lda $82AC
	sta r1H
	lda $82AB
	sta r1L
	bne L5CA9
	rts

L5CA9:	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr AllocateBlock
L5CB4:	jsr ReadBuff
	stx $8002
	stx $8022
	stx $8042
	stx $8062
	stx $8082
	stx $80A2
	stx $80C2
	stx $80E2
	stx diskBlkBuf
	dex
	stx diskBlkBuf+1
	jmp PutBlock

L5CD9:	lda #$01
	sta r6L
	lda #$00
	sta r6H
	jmp AllocateBlock

L5CE4:	jsr GetDirHead
	lda #$01
	sta r1L
	lda #$22
	sta r1H
	jsr L5DAE
	lda $9062
	sta L5DAD
	jsr L5D35
	lda #$01
	sta r6L
	lda #$22
	sta r6H
	jsr L5D2D
	jmp PutDirHead

L5D09:	jsr GetDirHead
	lda #$28
	sta r1L
	lda #$03
	sta r1H
	jsr L5DAE
	lda #$50
	sta L5DAD
	jsr L5D35
	lda #$28
	sta r6L
	lda #$03
	sta r6H
	jsr L5D2D
	jmp PutDirHead

L5D2D:	jsr AllocateBlock
	dec r6H
	bpl L5D2D
	rts

L5D35:	lda #$01
	sta r6L
L5D39:	lda #$00
	sta r6H
L5D3D:	jsr FreeBlock
	cpx #$02
	beq L5D48
	inc r6H
	bne L5D3D
L5D48:	inc r6L
	lda L5DAD
	cmp r6L
	bcs L5D39
	rts

L5D52:	jsr GetDirHead
	bit $8203
	bpl L5D89
	ldy #$00
	tya
L5D5D:	sta $8900,y
	iny
	bne L5D5D
	ldy #$DD
L5D65:	sta curDirHead,y
	iny
	bne L5D65
	lda #$46
	jsr L5D91
	lda #$35
	sta r6L
	lda #$12
	sta r6H
	jsr L5D2D
	jmp PutDirHead

L5D7E:	jsr GetDirHead
	bit $8203
	bpl L5D89
	ldx #$06
	rts

L5D89:	lda #$23
	jsr L5D91
	jmp PutDirHead

L5D91:	sta L5DAD
	lda #$12
	sta r1L
	lda #$01
	sta r1H
	jsr L5DAE
	jsr L5D35
	lda #$12
	sta r6L
	lda #$01
	sta r6H
	jmp L5D2D

L5DAD:	.byte 0

L5DAE:	jsr ExitTurbo
	jsr EnterTurbo
	jsr ReadBuff
	ldy #$00
L5DB9:	lda #$00
	sta $8002,y
	tya
	add #$20
	tay
	bcc L5DB9
	ldx #$FF
	stx diskBlkBuf+1
	inx
	stx diskBlkBuf
	jmp PutBlock

.endif
