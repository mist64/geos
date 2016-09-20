.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

.import SetNextFree
.import i_MoveData
.import FindBAMBit
.import GetFreeDirBlk
.import PutBlock
.import PutDirHead
.import FindFile
.import OpenDisk

L903F = $903F

.segment "directory"

.ifdef wheels

MakeDirectory:
	jmp _MakeDirectory
MakeSysDir:
	jmp _MakeSysDir

_MakeDirectory:
	lda curType
	and #$0F
	cmp #$04
	bne L5074
	jsr OpenDisk
	bnex L5076
	lda r1H
	sta L511B
	lda r1L
	sta L511A
	lda r6H
	sta L5078
	lda r6L
	sta L5077
	jsr FindFile
	bnex L5032
	ldx #$05
	rts

L5032:	jsr L5092
	bnex L5076
	jsr L5079
	bnex L5076
	jsr PutDirHead
	bnex L5076
	jsr L50D7
	bnex L5076
	jsr L513C
	bnex L5076
	lda L5090
	sta r1L
	lda L5091
	sta r1H
	jsr ReadBuff
	bnex L5076
	ldy L508F
	ldx #$00
L5065:	lda dirEntryBuf,x
	sta diskBlkBuf,y
	iny
	inx
	cpx #$1E
	bcc L5065
	jmp PutBlock

L5074:	ldx #$0D
L5076:	rts

L5077:	.byte 0
L5078:	.byte 0

L5079:	lda #$00
	jsr GetFreeDirBlk
	bnex L508E
	sty L508F
	lda r1L
	sta L5090
	lda r1H
	sta L5091
L508E:	rts

L508F:	.byte 0
L5090:	.byte 0
L5091:	.byte 0

L5092:	lda #$01
	sta r6L
	lda #$40
	sta r6H
L509A:	jsr FindBAMBit
	bne L50AA
L509F:	inc r6H
	bne L509A
L50A3:	inc r6L
	bne L509A
	ldx #$03
	rts

L50AA:	inc r6H
	beq L50A3
	jsr FindBAMBit
	beq L509F
	lda r6L
	sta L50D3
	sta L50D5
	lda r6H
	sta L50D6
	dec r6H
	lda r6H
	sta L50D4
	jsr AllocateBlock
	bnex L50D2
	inc r6H
	jsr AllocateBlock
L50D2:	rts

L50D3:	.byte 0
L50D4:	.byte 0
L50D5:	.byte 0
L50D6:	.byte 0

L50D7:	jsr i_MoveData
	.addr curDirHead
	.addr diskBlkBuf
	.word $0100
	lda L50D6
	sta diskBlkBuf+1
	lda L50D5
	sta diskBlkBuf
	lda L511B
	sta $8023
	lda L511A
	sta $8022
	lda L5090
	sta $8024
	lda L5091
	sta $8025
	lda L508F
	sta $8026
	jsr L511C
	lda L50D4
	sta r1H
	lda L50D3
	sta r1L
	jmp L903F

L511A:	.byte 0
L511B:	.byte 0

L511C:	jsr L5156
	ldy #$1A
L5121:	ldx $8004,y
	lda $8090,y
	sta $8004,y
	txa
	sta $8090,y
	dey
	bpl L5121
	ldy #$11
	lda #$00
L5135:	sta $80AB,y
	dey
	bpl L5135
	rts

L513C:	lda L50D6
	sta r1H
	lda L50D5
	sta r1L
L5146:	ldy #$00
	tya
L5149:	sta diskBlkBuf,y
	iny
	bne L5149
	dey
	sty diskBlkBuf+1
	jmp L903F

L5156:	lda L5078
	sta r6H
	lda L5077
	sta r6L
	ldy #$00
L5162:	lda (r6),y
	beq L5171
	sta $8403,y
	sta $8090,y
	iny
	cpy #$10
	bcc L5162
L5171:	lda #$A0
	cpy #$10
	beq L5180
	sta $8403,y
	sta $8090,y
	iny
	bne L5171
L5180:	lda #$86
	sta dirEntryBuf
	lda L50D4
	sta $8402
	lda L50D3
	sta $8401
	ldy #$03
	lda #$00
L5195:	sta $8413,y
	dey
	bpl L5195
	lda year
	sta $8417
	lda month
	sta $8418
	lda day
	sta $8419
	lda hour
	sta $841A
	lda minutes
	sta $841B
	lda #$00
	sta $841D
	lda #$02
	sta $841C
	rts

_MakeSysDir:
	lda curType
	and #$0F
	cmp #$04
	beq L51D0
	ldx #$0D
L51CF:	rts

L51D0:	jsr GetBorder
	bnex L51CF
	bit isGEOS
	bmi L51CF
	lda #$01
	sta r3L
	lda #$FE
	sta r3H
	jsr SetNextFree
	bnex L51CF
	lda r3H
	sta r1H
	sta $82AC
	lda r3L
	sta r1L
	sta $82AB
	jsr L5146
	bnex L51CF
	ldy #$0F
L51FF:	lda L520B,y
	sta $82AD,y
	dey
	bpl L51FF
	jmp PutDirHead

L520B:	.byte "GEOS format V1.1"

.endif
