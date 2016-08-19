
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "inputdrv.inc"

; header.s
.import dateCopy

; irq.s
.import _IRQHandler
.import _NMIHandler

; init.s
.import _ResetHandle

.segment "boot"

L2C98:
	sei
	cld
	ldx #$FF
	txs

	lda #$00
	tax
@1:	sta $8400,x
	sta $8500,x
	sta $8600,x
	sta $8700,x
	sta $8800,x
	dex
	bne @1
	lda #IO_IN
	sta CPU_DATA

	LoadW $fffa, _NMIHandler
	LoadW $fffe, _IRQHandler

	; draw background pattern
	LoadW r0, SCREEN_BASE
	ldx #$7D
@2:	ldy #$3F
@3:	lda #$55
	sta (r0),y
	dey
	lda #$AA
	sta (r0),y
	dey
	bpl @3
	lda #$40
	clc
	adc r0L
	sta r0L
	bcc @4
	inc r0H
@4:	dex
	bne @2

	; set up CIA1
	lda $DC0F
	and #$7F
	sta $DC0F
	lda #$81
	sta $DC0B
	lda #$00
	sta $DC0A
	sta $DC09
	sta $DC08

	; set date
	ldy #2
@6:	lda dateCopy,y
	sta year,y
	dey
	bpl @6

	lda #RAM_64K
	sta CPU_DATA

	;
	jsr FirstInit
	jsr MouseInit
	lda #$08
	sta interleave

	lda #$01
	sta NUMDRV
	ldy $BA
	sty curDrive
	lda #$01
	sta curType
	sta driveType-8,y

	jmp _ResetHandle
