.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

L4000 = $4000
L4003 = $4003
L9033 = $9033
L9050 = $9050
L9053 = $9053
L9063 = $9063
L9066 = $9066
LFF93 = $FF93
LFF96 = $FF96
LFFA5 = $FFA5
LFFA8 = $FFA8
LFFAB = $FFAB
LFFAE = $FFAE
LFFB1 = $FFB1
LFFB4 = $FFB4
.import Swap4000
.import DBGFileSelected
.import DBGFTableIndex
.import DBGFilesFound
.import DBGFNameTable
.import dbFieldWidth
.import fftIndicator
.import extKrnlIn
.import sysDBColor

.import BBMult
.import CallRoutine
.import CopyString
.import GetDirHead
.import FindFile
.import DoRAMOp
.import SetDevice
.import EnterTurbo
.import GetPtrCurDkNm
.import PutString
.import OpenDisk
.import RstrFrmDialogue
.import DoneWithIO
.import InitForIO
.import ExitTurbo
.import i_FrameRectangle
.import i_ColorRectangle
.import DoDlgBox
.import StashRAM
.import FetchRAM
.import PurgeTurbo


.global ChDiskDirectory
.global GetFEntries

.segment "partition"

.ifdef wheels

ChgParType:
	jmp _ChgParType
ChPartition:
	jmp _ChPartition
ChSubdir:
	jmp _ChSubdir
ChDiskDirectory:
	jmp _ChDiskDirectory
GetFEntries:
	jmp _GetFEntries
TopDirectory:
	jmp _TopDirectory
UpDirectory:
	jmp _UpDirectory
DownDirectory:
	jmp _DownDirectory
GoPartition:
	jmp _GoPartition
; ???
	rts
	nop
	nop
ChPartOnly:
	jmp L50D7
Syscall_5_11:; ???
	jmp _Syscall_5_11
; ???
	rts
	nop
	nop
FindRamLink:
	jmp L527C

_ChgParType:
	lda r4L
	cmp #$01
	beq L5037
L5030:	cmp #$04
	bne L5047
	lda #$03
	.byte $2C
L5037:	lda #$04
	sta r4L
	lda curType
	and #$0F
	cmp r4L
	beq L50BC
	jsr L5161
L5047:	bne L50B8
	jsr PurgeTurbo
	lda curType
	and #$F0
	ora r4L
	sta r4L
	ldx #$05
L5057:	cmp L50C9,x
	beq L5061
	dex
	bpl L5057
	bmi L50B8
L5061:	PushB $9073
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
L5089:	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr FetchRAM
	dec ramExpSize
	ldy curDrive
	lda $904E
	sta _driveType,y
	sta curType
	PopB $9073
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
_ChPartition:
	lda #$00
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
	jsr _ChgParType
	jsr L56F8
	bit L5134
	bpl L5126
	jsr L9050
	bnex L5133
	lda #$00
	sta r2L
	jmp L9066

L5126:	jsr L9063
	jsr L9053
L512C:	jmp _ChSubdir

L512F:	cmp #$32
	beq L512C
L5133:	rts

L5134:	.byte 0

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

L5174:	lda curType
	and #$0F
	cmp #$04
	rts

L517C:	lda curType
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

_Syscall_5_11:
	lda L51E7,x
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
	lda sysDBColor
	sta L5270
	jsr i_ColorRectangle
	.byte 8, 4, 24, 10
L5270:	.byte $B3
	jsr i_FrameRectangle
	.byte 34, 110
	.word 66, 254
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

L5322:	lda sysDBColor
	sta L532F
	jsr i_ColorRectangle
	.byte 8, 4, 24, 15
L532F:	.byte $B3
	jsr i_FrameRectangle
	.byte 34, 150
	.word 66, 254
	.byte $FF
	rts

	jsr L5322
	jsr OpenDisk
	lda curDrive
	add #$39
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
L5371:	sta (r1),y
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
L53FB:	lda (r0),y
	beq L5412
	cmp #$A0
	beq L5412
	and #$7F
	cmp #$20
	bcs L540B
	lda #$3F
L540B:	sta (r1),y
	iny
	cpy #$10
	bcc L53FB
L5412:	lda #$00
	sta (r1),y
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
L549B:	lda (r0),y
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

L5552:	.byte 0
L5553:	.byte 0

L5554:	ldy #$00
L5556:	lda L518C,y
	sta (r6),y
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

L5583:	.byte 0

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
	sta (r1),y
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
	sta (r1),y
	pla
	iny
L55DC:	add #$30
	sta (r1),y
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

_GoPartition:
	stx L56F7
	jsr L5161
	bne L56F1
	ldx L56F7
	jsr L5417
	lda L54B8
	sta r4L
	jsr _ChgParType
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

L56F7:	.byte 0

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

L573E:	.byte 0

_ChDiskDirectory:
	jsr L515C
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
	jsr _ChSubdir
	bra L5762
L575F:	jsr _ChPartition
L5762:	lda L57B0
	sta DBoxDescH
	lda L57AF
	sta DBoxDescL
	ldy #$91 ; fetch
	.byte $2c
L576F:	ldy #$90 ; stash
	tya
	pha
	LoadW r0, dlgBoxRamBuf
	LoadW r1, $B900
	LoadW r2, $017A
	lda #0 ; REU bank 0
	sta r3L
	jsr DoRAMOp
	pla
	tay
	LoadW r0, $880C
	LoadW r1, $BA7A
	LoadW r2, $0051
	jmp DoRAMOp

L57AF:	.byte 0
L57B0:	.byte 0
L57B1:	.byte 0
L57B2:	.byte 0

L57B3:	jsr Swap4000
	jsr L4000
	jmp Swap4000

L57BC:	jsr Swap4000
	jsr L4003
	jmp Swap4000

_ChSubdir:
	jsr L5174
	beq @1
	ldx #0
	rts
@1:	jsr @6
@2:	ldx #1
	jsr L580A
	lda r0L
	cmp #$50
	beq @2
	cmp #$55
	bne @3
	jmp _ChPartition
@3:	cmp #$05
	beq @5
@4:	rts
@5:	lda L518C
	beq @4
	lda #$51
	sta r6H
	lda #$8C
	sta r6L
	jsr FindFile
	jsr _DownDirectory
	bra @2
@6:	lda curType
	and #$70
	beq @7
	lda #$12
@7:	sta L5949
	rts

L580A:	txa
	pha
	jsr L57B3
	lda $84B2
	sta L57B2
	lda RecoverVector
	sta L57B1
	lda #>L57BC
	sta $84B2
	lda #<L57BC
	sta RecoverVector
	lda #5
	sta extKrnlIn
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
	lda #0
	sta extKrnlIn
	rts

L585A:	.byte $E2,$A1
L585C:	.byte "TX"
L585E:	.byte $97,$91
L5860:	.byte $AB,","
L5862:	.byte "QY"

_DownDirectory:
	lda dirEntryBuf
	and #$BF
	cmp #$86
	bne L589E
	lda $8402
	sta r1H
	lda $8401
	sta r1L
	bra L588F
_UpDirectory:
	jsr GetDirHead
	lda $8223
	sta r1H
	lda $8222
	sta r1L
	bne L588F
_TopDirectory:
	lda #$01
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
	bnex L5910
	jsr Get1stDirEntry
	bnex L5910
L58B6:	ldy #$00
	lda (r5),y
	and #$BF
	cmp #$86
	bne L5907
	ldy #$03
	ldx #$00
L58C4:	lda (r5),y
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
	bnex L5910
	tya
	beq L58B6
L5910:	lda #$51
	sta r5H
	lda #$8C
	sta r5L
	sec
	rts

L591A:	.byte 0
L591B:	.byte 0

	jsr _UpDirectory
	beqx L5929
L5922:	rts

	jsr _TopDirectory
	bnex L5922
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

_GetFEntries:
	lda #$FF
	sta r7H
	lda #$C3
	sta r5H
	lda #$0A
	sta r5L
	lda r7L
	eor #$80
	sta fftIndicator
	bmi L5ADB
	lda $885A
	sta r5H
	lda DBGFNameTable
	sta r5L
	lda r7L
	and #$7F
	.byte $2C
L5ADB:	lda #$11
	sta dbFieldWidth
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
	adc dbFieldWidth
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
L5B3B:	bit fftIndicator
	bpl L5B46
	lda #$00
	sta fftIndicator
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
	PushW r7
	lda #$05
	sta r0L
	lda dbFieldWidth
	sta r2L
	ldx #$06
	ldy #$02
	jsr BBMult
	lda dbFieldWidth
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
	PopW r7
	rts

.endif
