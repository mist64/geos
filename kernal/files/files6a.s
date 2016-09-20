; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "c64.inc"

.import GetHeaderFileName
.import SerialHiCompare

.import LdDeskAcc
.import CallRoutine
.import GetSerialNumber
.import ClearRam
.import DoneWithIO
.import InitForIO
.import EnterTurbo
.ifdef wheels
.import GetBlock
.endif

.global _FollowChain
.global _FindFTypes

.ifdef wheels
.global LoadDiskBlkBuf
.endif

.segment "files6a"

_FollowChain:
.ifdef wheels
.import WheelsTemp
	php
	sei
	jsr LoadDiskBlkBuf
	PushB r3H
	lda #0
	sta WheelsTemp
@1:	jsr GetLink
@2:	bnex @5
	ldy WheelsTemp
	lda r1L
	sta (r3),y
	iny
	lda r1H
	sta (r3),y
	iny
	sty WheelsTemp
	bne @3
	inc r3H
@3:	lda r1L
	beq @6
	lda diskBlkBuf
	bne @4
	jsr GetBlock
@4:	lda r3H
	cmp #>OS_VARS
	bcs @5
	MoveW diskBlkBuf, r1
	bne @1
	beq @2
@5:	ldx #BFR_OVERFLOW
@6:	PopB r3H
	plp
	rts
.else
	php
	sei
	PushB r3H
.ifdef bsw128
	jsr EnterTurbo
	jsr InitForIO
	LoadW r4, diskBlkBuf
.endif
	ldy #0
@1:	lda r1L
	sta (r3),y
	iny
	lda r1H
	sta (r3),y
	iny
	bne @2
	inc r3H
@2:	lda r1L
	beq @3
	tya
	pha
.ifdef bsw128
	jsr ReadLink
.else
	jsr ReadBuff
.endif
	pla
	tay
	bnex @4
	MoveW diskBlkBuf, r1
	bra @1
@3:	ldx #0
@4:
.ifdef bsw128
	jsr DoneWithIO
.endif
	PopB r3H
	plp
	rts
.endif

.ifdef wheels ; common code
LoadDiskBlkBuf:
	LoadW r4, diskBlkBuf
	rts
.endif

_FindFTypes:
.ifdef wheels
.import fftIndicator
	bit fftIndicator
	bmi LD5FD
	lda r6H
	sta r1H
	lda r6L
	sta r1L
	lda #$00
	sta r0H
	lda r7H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	adc r7H
	sta r0L
	bcc LD5FA
	inc r0H
LD5FA:	jsr ClearRam
LD5FD:	jsr Get1stDirEntry
	bnex LD661
LD603:	ldy #$00
	lda (r5),y
	beq LD658
	ldy #$16
	lda r7L
	cmp #$64
	beq LD624
	cmp #$65
	bne LD61B
	lda (r5),y
	beq LD658
	bne LD624
LD61B:	cmp (r5),y
	bne LD658
	jsr GetHeaderFileName
	bne LD658
LD624:	clc
	lda r5L
	adc #$03
	sta r0L
	lda r5H
	adc #$00
	sta r0H
	ldy #$00
LD633:	lda (r0),y
	cmp #$A0
	beq LD640
	sta (r6),y
	iny
	cpy #$10
	bne LD633
LD640:	lda #$00
	sta (r6),y
	bit fftIndicator
	bmi LD663
	clc
	lda #$11
	adc r6L
	sta r6L
	bcc LD654
	inc r6H
LD654:	dec r7H
	beq LD661
LD658:	jsr GetNxtDirEntry
	bnex LD661
	tya
	beq LD603
LD661:	sec
	rts

LD663:	lda r5H
	sta LD685
	lda r5L
	sta LD684
	LoadW r5, LD677
	clc
	rts

LD677:	lda LD685
	sta r5H
	lda LD684
	sta r5L
	jmp LD658

LD684:	.byte 0
LD685:	.byte 0

.else
.ifdef useRamExp
	CmpWI r7, ($0100+SYSTEM)
	bne FFTypesStart
	CmpWI r6, $8b80
	bne FFTypesStart
	LoadB DeskTopOpen, 1
	LoadW r5, DeskTopName
	ldx #r5
	ldy #r6
	jmp CopyString
FFTypesStart:
.endif
	php
	sei
	MoveW r6, r1
	LoadB r0H, 0
	lda r7H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	adc r7H
	sta r0L
	bcc @1
	inc r0H
@1:	jsr ClearRam
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex @7

.ifdef trap1
	; sabotage code: breaks LdDeskAcc if
	; _UseSystemFont hasn't been called before this
	ldx #>GetSerialNumber
	lda #<GetSerialNumber
	jsr CallRoutine
	lda r0H
	cmp SerialHiCompare
	beq @2
	inc LdDeskAcc+1
.endif

@2:	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq @6
	ldy #OFF_GFILE_TYPE
	lda (r5),y
	cmp r7L
	bne @6
	jsr GetHeaderFileName
	bnex @7
	tya
	bne @6
	ldy #OFF_FNAME
@3:	lda (r5),y
	cmp #$a0
	beq @4
	sta (r6),y
	iny
	cpy #OFF_FNAME + $10
	bne @3
@4:	lda #NULL
	sta (r6),y
	clc
	lda #$11
	adc r6L
	sta r6L
	bcc @5
	inc r6H
@5:	dec r7H
	beq @7
@6:	jsr GetNxtDirEntry
	bnex @7
	tya
	beq @2
@7:	plp
	rts
.endif

