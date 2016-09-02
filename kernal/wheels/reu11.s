.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu11"

.import RstrKernal
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
L5062:	sta LF1FB,y
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
	MoveW r7, LF1FB_4
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
	ldy #3
L50C6:	lda BASICspace,y
	sta SaveBASICspace,y
	dey
	bpl L50C6
	lda #0
	sta STATUS
	lda curDevice
	sta SaveDevice
	cmp #8
	bcc L5105
	cmp #12
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
	ldy #0
	tya
L5114:	sta r0L,y
	sta $0200,y
	sta $0300,y
	iny
	bne L5114
	LoadB $b3, 3
	LoadB tapeBuffVec, $3c
	LoadB BASICMemTop, >$a000
	LoadB BASICMemBot, >$0800
	LoadB scrAddrHi, >$0400
	LoadB CPU_DATA, KRNL_IO_IN
	LoadW $a000, L5148
	jmp LFCF8

L5148:	LoadB CPU_DATA, KRNL_BAS_IO_IN
	jsr L8B42
	jsr L8B45
	jsr L8B48
	LoadW nmivec, NMIHandler
	lda #6
	sta LF1FB_2
	lda cia2base+13
	lda #$FF
	sta cia2base+4
	sta cia2base+5
	lda #$81
	sta cia2base+13
	lda cia2base+14
	and #$80
	ora #$11
	sta cia2base+14
	lda #$2F
	sta CPU_DDR
	lda #$E7
	sta CPU_DATA
	sta scpu_turbo
	lda SaveDevice
	sta curDevice
	cli
	jmp $E39D ; continue with BASIC cold start

L8B42:	jmp ($E395) ; initialise the BASIC vector table

L8B45:	jmp ($E398) ; initialise the BASIC RAM locations

L8B48:	jmp ($E39B) ; print the start up message and
                    ; initialise the memory pointers

NMIHandler:
	pha
	tya
	pha
	cld
	lda cia2base+13
	dec LF1FB_2
	bne @5
	lda #$7F
	sta cia2base+13
	LoadW nmivec, $fe47 ; CBM KERNAL NMI handler
	ldy #3
@1:	lda SaveBASICspace,y
	sta BASICspace,y
	dey
	bpl @1
	lda LF1FB_5
	sta currentMode
	MoveB LF1FB_4, $2D
	iny
@2:	lda LF1FB,y
	beq @3
	sta (curScrLine),y
	lda $0286
	sta ($F3),y
	iny
	cpy #$28
	bcc @2
@3:	tya
	beq @4
	LoadB curPos, 40
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
@4:	lda $F0D9
	cmp #$50
	beq @5
	jsr LE4B7
@5:	pla
	tay
	pla
	rti
LF1FB:
	.res 40, 0
LF1FB_2:
	.byte 0
SaveBASICspace:
	.byte 0, 0, 0, 0
LF1FB_4:
	.byte 0
LF1FB_5:
	.byte 0
SaveDevice:
	.byte 0
code2_end:
