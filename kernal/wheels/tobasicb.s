.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.segment "tobasicb"

.ifdef wheels

.import RstrKernal
.import sFirstPage
.import ramExpType

.import InitForIO
.import PurgeTurbo
.import ReadFile
.import i_MoveData
.import DEFOptimize
.import MouseOff

LE4B7 = $E4B7
LFF84 = $FF84
LFF93 = $FF93
LFFA8 = $FFA8
LFFAE = $FFAE
LFFB1 = $FFB1

KToBasic:
	sei
	MoveW r0, scr+1 - SPRITE_PICS + L5050
	jsr MouseOff
	jsr DEFOptimize
	START_IO
	ldx $D0BC
	END_IO
	txa
	bmi @1
	lda ramExpType
	cmp #4
	bne @1
	lda sFirstPage
	; ??? probably 65816 code, ramExpType == 4 -> SuperCPU?
	.byte $8F,$7C,$D2,$01,$AD,$D7,$9F,$8F
	.byte $7D,$D2,$01,$AD,$D8,$9F,$8F,$7E
	.byte $D2,$01,$AD,$D9,$9F,$8F,$7F,$D2
	.byte $01
@1:	jsr i_MoveData
	.addr L5050
	.addr SPRITE_PICS
	.word code2_end - code2_start
	jmp SPRITE_PICS

L5050:
	.org SPRITE_PICS
code2_start:
	jsr RstrKernal
	ldy #40 - 1
scr:	lda $0400,y
	cmp #'Z'+1
	bcs @2
	cmp #'A'
	bcc @2
	sbc #'@'
@2:	sta ScreenLine,y
	dey
	bpl scr
	lda r5H
	beq @4
	iny
	tya
@3:	sta BASICspace,y
	iny
	bne @3
	sec
	lda r7L
	sbc #$02
	sta r7L
	lda r7H
	sbc #$00
	sta r7H
	lda (r7),y
	pha
	iny
	lda (r7),y
	pha
	PushW r7
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	lda #$FF
	sta r2L
	sta r2H
	jsr ReadFile
	MoveW r7, LF1FB_4
	PopW r0
	ldy #$01
	pla
	sta (r0),y
	dey
	pla
	sta (r0),y
@4:	jsr PurgeTurbo
	jsr InitForIO
	lda #$37
	sta CPU_DATA
	sei
	ldy #3
@5:	lda BASICspace,y
	sta SaveBASICspace,y
	dey
	bpl @5
	lda #0
	sta STATUS
	lda curDevice
	sta SaveDevice
	cmp #8
	bcc @7
	cmp #12
	bcs @7
	jsr LFFB1
	lda STATUS
	bne @6
	lda #$6F
	jsr LFF93
	lda STATUS
	bne @6
	lda #$49
	jsr LFFA8
	lda #$0D
	jsr LFFA8
	jsr LFFAE
	lda curDevice
	jsr LFFB1
@6:	jsr LFFAE
@7:	ldx #$FF
	txs
	cld
	lda #$00
	sta $D016
	jsr LFF84
	ldy #0
	tya
@8:	sta r0L,y
	sta $0200,y
	sta $0300,y
	iny
	bne @8
	LoadB $b3, 3
	LoadB tapeBuffVec, $3c
	LoadB BASICMemTop, >BASIC_START
	LoadB BASICMemBot, >BASICspace
	LoadB scrAddrHi, >$0400
	LoadB CPU_DATA, KRNL_IO_IN
	LoadW BASIC_START, BASICvector ; catch CBM KERNAL's jump to BASIC
	jmp $FCF8 ; CBM KERNAL RESET

BASICvector:
	LoadB CPU_DATA, KRNL_BAS_IO_IN
	jsr @1
	jsr @2
	jsr @3
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
	LoadB CPU_DDR, $2f
	LoadB CPU_DATA, $e7
	sta scpu_turbo
	lda SaveDevice
	sta curDevice
	cli
	jmp $E39D ; continue with BASIC cold start

@1:	jmp ($E395) ; initialise the BASIC vector table
@2:	jmp ($E398) ; initialise the BASIC RAM locations
@3:	jmp ($E39B) ; print the start up message and
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
@2:	lda ScreenLine,y
	beq @3
	sta (curScrLine),y
	lda $0286
	sta ($F3),y
	iny
	cpy #40
	bcc @2
@3:	tya
	beq @4
	LoadB curPos, 40
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
@4:	lda $F0D9
	cmp #'P' ; "PRESS PLAY ON TAPE" message exists?
	beq @5
	jsr $E4B7 ; unused in standard KERNAL - JiffyDOS?
@5:	pla
	tay
	pla
	rti
ScreenLine:
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

.endif
