.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu11"

.import RstrKernal
LC304 = $C304
LE395 = $E395
LE398 = $E398
LE39B = $E39B
LE39D = $E39D
LE4B7 = $E4B7
LFCF8 = $FCF8
LFF84 = $FF84
LFF93 = $FF93
LFFA8 = $FFA8
LFFAE = $FFAE
LFFB1 = $FFB1

KToBasic:
	sei
	MoveW r0, L5055+1 - SPRITE_PICS + L5050
	jsr MouseOff
	jsr DEFOptimize
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	ldx $D0BC
	PopB CPU_DATA
	txa
	bmi L5044
	lda $9FED
	cmp #$04
	bne L5044
	lda $9FD6
	; ???
	.byte $8F,$7C,$D2,$01,$AD,$D7,$9F,$8F
	.byte $7D,$D2,$01,$AD,$D8,$9F,$8F,$7E
	.byte $D2,$01,$AD,$D9,$9F,$8F,$7F,$D2
	.byte $01
L5044:	jsr i_MoveData
	.addr L5050
	.addr SPRITE_PICS
	.word code2_end - code2_start
	jmp SPRITE_PICS

L5050:
	.org SPRITE_PICS
code2_start:
	jsr RstrKernal
	ldy #40 - 1
L5055:	lda $0400,y
	cmp #'['
	bcs L5062
	cmp #'A'
	bcc L5062
	sbc #'@'
L5062:	sta $8BAB,y
	dey
	bpl L5055
	lda r5H
	beq L50B9
	iny
	tya
L506E:	sta BASICspace,y
	iny
	bne L506E
	sec
	lda r7L
	sbc #$02
	sta r7L
	lda r7H
	sbc #$00
	sta r7H
	lda (r7L),y
	pha
	iny
	lda (r7L),y
	pha
	lda r7H
	pha
	lda r7L
	pha
	lda (r5L),y
	sta r1L
	iny
	lda (r5L),y
	sta r1H
	lda #$FF
	sta r2L
	sta r2H
	jsr ReadFile
	lda r7H
	sta $8BD9
	lda r7L
	sta $8BD8
	pla
	sta r0L
	pla
	sta r0H
	ldy #$01
	pla
	sta (r0L),y
	dey
	pla
	sta (r0L),y
L50B9:	jsr PurgeTurbo
	jsr InitForIO
	lda #$37
	sta CPU_DATA
	sei
	ldy #$03
L50C6:	lda BASICspace,y
	sta $8BD4,y
	dey
	bpl L50C6
	lda #$00
	sta STATUS
	lda curDevice
	sta $8BDA
	cmp #$08
	bcc L5105
	cmp #$0C
	bcs L5105
	jsr LFFB1
	lda STATUS
	bne L5102
	lda #$6F
	jsr LFF93
	lda STATUS
	bne L5102
	lda #$49
	jsr LFFA8
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	lda curDevice
	jsr LFFB1
L5102:	jsr LFFAE
L5105:	ldx #$FF
	txs
	cld
	lda #$00
	sta $D016
	jsr LFF84
	ldy #$00
	tya
L5114:	sta r0L,y
	sta $0200,y
	sta $0300,y
	iny
	bne L5114
	lda #$03
	sta $B3
	lda #$3C
	sta tapeBuffVec
	lda #$A0
	sta BASICMemTop
	lda #$08
	sta BASICMemBot
	lda #$04
	sta scrAddrHi
	lda #$36
	sta CPU_DATA
	lda #$8A
	sta $A001
	lda #$F8
	sta SCREEN_BASE
	jmp LFCF8

	lda #$37
	sta CPU_DATA
	jsr L8B42
	jsr L8B45
	jsr L8B48
	lda #$8B
	sta $0319
	lda #$4B
	sta nmivec
	lda #$06
	sta $8BD3
	lda $DD0D
	lda #$FF
	sta $DD04
	sta $DD05
	lda #$81
	sta $DD0D
	lda $DD0E
	and #$80
	ora #$11
	sta $DD0E
	lda #$2F
	sta CPU_DDR
	lda #$E7
	sta CPU_DATA
	sta $D07B
	lda $8BDA
	sta curDevice
	cli
	jmp LE39D

L8B42:	jmp (LE395)

L8B45:	jmp (LE398)

L8B48:	jmp (LE39B)

	pha
	tya
	pha
	cld
	lda $DD0D
	dec $8BD3
	bne L51F7
	lda #$7F
	sta $DD0D
	lda #$FE
	sta $0319
	lda #$47
	sta nmivec
	ldy #3
L51B8:	lda $8BD4,y
	sta BASICspace,y
	dey
	bpl L51B8
	lda $8BD9
	sta currentMode
	MoveB $8BD8, $2D
	iny
L51CC:	lda $8BAB,y
	beq L51DD
	sta (curScrLine),y
	lda $0286
	sta ($F3),y
	iny
	cpy #$28
	bcc L51CC
L51DD:	tya
	beq L51ED
	LoadB curPos, 40
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
L51ED:	lda $F0D9
	cmp #$50
	beq L51F7
	jsr LE4B7
L51F7:	pla
	tay
	pla
	rti
	.res 48, 0
code2_end:
