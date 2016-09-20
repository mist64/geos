.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

.import FreeBlock
.import PutBlock
.import GetBlock
.import OpenDisk
.import WriteBlock
.import FetchRAM
.import EnterTurbo
.import InitForIO
.import DoneWithIO
.import StashRAM
.import ReadBlock
.import SetDevice
.import PutDirHead
.import CallRoutine
.import GetDirHead

L9050 = $9050
L9053 = $9053

.segment "validate"

.ifdef wheels

ValDisk:
	lda #$00
	sta L54CF
	sta L54D0
	jsr GetDirHead
	bne L5033
	lda curType
	and #$0F
	beq L5031
	cmp #$05
	bcs L5031
	tax
	lda L5035,x
	pha
	lda L5039,x
	tax
	pla
	jsr CallRoutine
	ldy L54D0
	beq L502D
	ldy #$FF
	rts

L502D:	ldy L54CF
	rts

L5031:	ldx #$0D
L5033:	ldy #$00
L5035:	rts

	.byte $FB,$BE,$2B
L5039:	.byte $3E,$51,$51,$51,$50
	jsr L507E
	jsr L509A
	beqx L5048
	rts

L5048:	jsr L549C
	bnex L5074
	lda #$01
	sta r6L
	lda #$21
	sta r6H
	jsr L547A
	bnex L5074
	jsr PutDirHead
	bnex L5074
	jsr L9050
	jsr L5228
	bnex L5074
	jsr PutDirHead
	bnex L5074
	jmp L508B

L5074:	pha
	jsr L50F9
	jsr L508B
	pla
	tax
	rts

L507E:	lda $905C
	sta L5098
	lda $905D
	sta L5099
	rts

L508B:	lda L5098
	sta r1L
	lda L5099
	sta r1H
	jmp L9053

L5098:	.byte 0
L5099:	.byte 0

L509A:	lda curDrive
	jsr SetDevice
	beq L50A3
	rts

L50A3:	jsr L50C6
L50A6:	lda r6L
	sta r1L
	lda r6H
	sta r1H
	jsr ReadBlock
	bne L50C3
	jsr L50E6
	jsr StashRAM
	inc r7H
	inc r6H
	lda r6H
	cmp #$22
	bcc L50A6
L50C3:	jmp DoneWithIO

L50C6:	jsr InitForIO
	lda #$01
	sta r6L
	lda #$02
	sta r6H
	lda #$B9
	sta r7H
	lda #$00
	sta r7L
	lda #$00
	sta r4L
	sta r0L
	lda #$80
	sta r4H
	sta r0H
	rts

L50E6:	lda r7H
	sta r1H
	lda r7L
	sta r1L
L50EE:	lda #$00
	sta r2L
	sta r3L
	lda #$01
	sta r2H
	rts

L50F9:	lda curDrive
	jsr SetDevice
	jsr EnterTurbo
	jsr L50C6
L5105:	jsr L50E6
	jsr FetchRAM
	lda #$80
	sta r4H
	lda #$00
	sta r4L
	lda r6L
	sta r1L
	lda r6H
	sta r1H
	jsr WriteBlock
	inc r7H
	inc r6H
	lda r6H
	cmp #$22
	bcc L5105
	jmp DoneWithIO

	jsr L5158
	jsr L54A1
	bnex L5151
	lda #$28
	sta r6L
	lda #$02
	sta r6H
	jsr L547A
	jsr L5228
	bnex L5151
	jsr L546C
	jsr PutDirHead
	bnex L5151
	jmp OpenDisk

L5151:	pha
	jsr L516A
	pla
	tax
	rts

L5158:	jsr L517F
	jsr L51B2
L515E:	jsr L5190
	jsr L51B2
L5164:	jsr L51A1
	jmp L51B2

L516A:	jsr L517F
	jsr L51B8
L5170:	jsr L5190
	jsr L51B8
L5176:	jsr L51A1
	jsr L51B8
	jmp PutDirHead

L517F:	lda #$9C
	sta r0H
	lda #$80
	sta r0L
	lda #$BB
	sta r1H
	lda #$00
	sta r1L
	rts

L5190:	lda #$89
	sta r0H
	lda #$00
	sta r0L
	lda #$BA
	sta r1H
	lda #$00
	sta r1L
	rts

L51A1:	lda #$82
	sta r0H
	lda #$00
	sta r0L
	lda #$B9
	sta r1H
	lda #$00
	sta r1L
	rts

L51B2:	jsr L50EE
	jmp StashRAM

L51B8:	jsr L50EE
	jmp FetchRAM

	jsr L515E
	jsr L548B
	bnex L51F4
	lda #$12
	sta r6L
	lda #$00
	sta r6H
	jsr L547A
	bit $8203
	bpl L51E2
	lda #$35
	sta r6L
	lda #$12
	sta r6H
	jsr L547A
L51E2:	jsr L5228
	bnex L51F4
	jsr L546C
	jsr PutDirHead
	bnex L51F4
	jmp OpenDisk

L51F4:	pha
	jsr L5170
	pla
	tax
	rts

	jsr L5164
	jsr L5492
	bnex L5221
	lda #$12
	sta r6L
	lda #$00
	sta r6H
	jsr L547A
	jsr L5228
	bnex L5221
	jsr L546C
	jsr PutDirHead
	bnex L5221
	jmp OpenDisk

L5221:	pha
	jsr L5176
	pla
	tax
	rts

L5228:	lda $8201
	sta r6H
	lda curDirHead
	sta r6L
L5232:	jsr AllocateBlock
	lda r6H
	sta r1H
	lda r6L
	sta r1L
	jsr ReadBuff
	beqx L5244
	rts

L5244:	lda #$80
	sta r5H
	lda #$02
	sta r5L
L524C:	jsr L5436
	ldy #$00
	lda (r5),y
	and #$BF
	cmp #$86
	bne L525F
	jsr L52D5
	jmp L5228

L525F:	jsr L530A
	bnex L52A0
L5265:	jsr L544B
	clc
	lda r5L
	adc #$20
	sta r5L
	bcc L524C
	lda diskBlkBuf+1
	sta r6H
	lda diskBlkBuf
	sta r6L
	bne L5232
	bit L5435
	bmi L528D
	jsr L53FF
	bnex L52D4
	bit L5435
	bmi L524C
L528D:	lda #$00
	sta L5435
	lda curType
	and #$0F
	cmp #$04
	bne L52A0
	lda $8222
	bne L52A3
L52A0:	rts

L52A1:	beq L5265
L52A3:	lda $8225
	sta r1H
	lda $8224
	sta r1L
	lda $8226
	sta r5L
	lda #$80
	sta r5H
	jsr L5436
	jsr L544B
	jsr GetBlock
	bne L52D4
	jsr PutDirHead
	lda $8223
	sta r1H
	lda $8222
	sta r1L
	jsr L9053
	beqx L52A1
L52D4:	rts

L52D5:	jsr L544B
	ldy #$01
	lda (r5),y
	sta r6L
	iny
	lda (r5),y
	sta r6H
	jsr AllocateBlock
	jsr PutDirHead
	jsr L544B
	ldy #$01
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	jsr L9053
	lda $8201
	sta r6H
	lda curDirHead
	sta r6L
	jsr AllocateBlock
	jmp PutDirHead

L530A:	ldy #$00
	lda (r5),y
	beq L5320
	and #$BF
	cmp #$81
	bcs L5322
	lda #$00
	sta (r5),y
	jsr L544B
	jmp PutBlock

L5320:	tax
	rts

L5322:	and #$3F
	cmp #$04
	beq L533A
	ldy #$13
	lda (r5),y
	bne L5331
L532E:	jmp L533D

L5331:	ldy #$16
	lda (r5),y
	beq L532E
	jmp L5379

L533A:	jmp L53E0

L533D:	ldy #$01
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
L5348:	jsr InitForIO
	lda r1H
	sta r6H
	lda r1L
	sta r6L
L5353:	jsr AllocateBlock
	jsr L53F1
	lda #$54
	sta r4H
	lda #$CD
	sta r4L
	jsr ReadLink
	bne L5376
	lda L54CE
	sta r1H
	sta r6H
	lda L54CD
	sta r1L
	sta r6L
	bne L5353
L5376:	jmp DoneWithIO

L5379:	ldy #$13
	lda (r5),y
	sta r6L
	iny
	lda (r5),y
	sta r6H
	jsr AllocateBlock
	jsr L53F1
	ldy #$01
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	ldy #$15
	lda (r5),y
	cmp #$01
	beq L53A0
	jmp L5348

L53A0:	lda #$81
	sta r4H
	lda #$00
	sta r4L
	jsr GetBlock
	bne L53DE
	lda r1H
	sta r6H
	lda r1L
	sta r6L
	jsr AllocateBlock
	jsr L53F1
	ldy #$02
	sty L53DF
L53C0:	lda fileHeader+1,y
	sta r1H
	lda fileHeader,y
	sta r1L
	beq L53D2
	jsr L5348
	bnex L53DE
L53D2:	ldy L53DF
	iny
	iny
	sty L53DF
	bne L53C0
	ldx #$00
L53DE:	rts

L53DF:	.byte 0

L53E0:	jsr L533D
	ldy #$13
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	jmp L5348

L53F1:	beqx L53FE
	inc L54CF
	bne L53FC
	inc L54D0
L53FC:	ldx #$00
L53FE:	rts

L53FF:	lda $82AC
	sta r6H
	sta r1H
	lda $82AB
	sta r6L
	sta r1L
	beq L542D
	jsr AllocateBlock
	cpx #$06
	beq L542D
	bnex L542F
	jsr ReadBuff
	lda #$80
	sta r5H
	lda #$02
	sta r5L
	bnex L542F
	lda #$FF
	sta L5435
	rts

L542D:	ldx #$00
L542F:	lda #$00
	sta L5435
	rts

L5435:	.byte 0

L5436:	lda r1H
	sta L5469
	lda r1L
	sta L5468
	lda r5H
	sta L546B
	lda r5L
	sta L546A
	rts

L544B:	lda L5469
	sta r1H
	lda L5468
	sta r1L
	lda L546B
	sta r5H
	lda L546A
	sta r5L
	lda #$80
	sta r4H
	lda #$00
	sta r4L
	rts

L5468:	.byte 0
L5469:	.byte 0
L546A:	.byte 0
L546B:	.byte 0

L546C:	lda #$01
	sta r6L
	lda #$00
	sta r6H
	jsr AllocateBlock
	ldx #$00
	rts

L547A:	jsr AllocateBlock
	beqx L5484
	cpx #$06
	bne L548A
L5484:	dec r6H
	bpl L547A
	ldx #$00
L548A:	rts

L548B:	ldx #$47
	bit $8203
	bmi L54A3
L5492:	ldx #$24
	bit $8203
	bpl L54A3
	ldx #$06
	rts

L549C:	ldx $9062
	inx
	.byte $2C
L54A1:	ldx #$51
L54A3:	stx L54CC
	lda #$01
	sta r6L
L54AA:	lda #$00
	sta r6H
L54AE:	jsr FreeBlock
	beqx L54BC
	cpx #$02
	beq L54C0
	cpx #$06
	bne L54CB
L54BC:	inc r6H
	bne L54AE
L54C0:	inc r6L
	lda r6L
	cmp L54CC
	bne L54AA
	ldx #$00
L54CB:	rts

L54CC:	.byte 0
L54CD:	.byte 0
L54CE:	.byte 0
L54CF:	.byte 0
L54D0:	.byte 0

.endif
