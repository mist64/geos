
.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"

; main.s
.import dateCopy

.global _DoUpdateTime

.segment "time"

_DoUpdateTime:
	sei
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda cia1base+15
	and #%01111111
	sta cia1base+15
	lda hour
	cmp #12
	bmi DoUpdTime1
	bbsf 7, cia1base+11, DoUpdTime1
	jsr DateUpdate
DoUpdTime1:
	lda cia1base+11
	and #%00011111
	cmp #$12
	bne DoUpdTime2
	lda #0
DoUpdTime2:
	bbrf 7, cia1base+11, DoUpdTime3
	sed
	addv $12
	cld
DoUpdTime3:
	jsr ConvertBCD
	sta hour
	lda cia1base+10
	jsr ConvertBCD
	sta minutes
	lda cia1base+9
	jsr ConvertBCD
	sta seconds
	lda cia1base+8
	ldy #2
DoUpdTime4:
	lda year,y
	sta dateCopy,y
	dey
	bpl DoUpdTime4
	MoveB cia1base+13, r1L
	stx CPU_DATA
	bbrf 7, alarmSetFlag, DoUpdTime5
	and #ALARMMASK
	beq DoUpdTime6
	lda #$4a
	sta alarmSetFlag
	lda alarmTmtVector
	ora alarmTmtVector+1
	beq DoUpdTime5
	jmp (alarmTmtVector)

DoUpdTime5:
	bbrf 6, alarmSetFlag, DoUpdTime6
	jsr DoClockAlarm
DoUpdTime6:
	cli
	rts

DateUpdate:
	jsr CheckMonth
	cmp day
	beq DateUpd1
	inc day
	rts
DateUpd1:
	ldy #1
	sty day
	inc month
	lda month
	cmp #13
	bne DateUpd2
	sty month
	inc year
	lda year
	cmp #100
	bne DateUpd2
	dey
	sty year
DateUpd2:
	rts

CheckMonth:
	ldy month
	lda daysTab-1, y
	cpy #2
	bne CheckMonth2
	tay
	lda year
	and #3
	bne CheckMonth1
	iny
CheckMonth1:
	tya
CheckMonth2:
	rts

daysTab:
	.byte 31, 28, 31, 30, 31, 30
	.byte 31, 31, 30, 31, 30, 31

ConvertBCD:
	pha
	and #%11110000
	lsr
	lsr
	lsr
	lsr
	tay
	pla
	and #%00001111
	clc
CvtBCD1:
	dey
	bmi CvtBCD2
	adc #10
	bne CvtBCD1
CvtBCD2:
	rts

DoClockAlarm:
	lda alarmWarnFlag
	bne DoClkAlrm3
	ldy CPU_DATA
	LoadB CPU_DATA, IO_IN
	ldx #24
DoClkAlrm1:
	lda pingTab,x
	sta sidbase,x
	dex
	bpl DoClkAlrm1
	ldx #$21
	lda alarmSetFlag
	and #%00111111
	bne DoClkAlrm2
	tax
DoClkAlrm2:
	stx sidbase+4
	sty CPU_DATA
	lda #$1e
	sta alarmWarnFlag
	dec alarmSetFlag
DoClkAlrm3:
	rts

pingTab:
	.byte $00, $10, $00, $08, $40, $08, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $0f, $00, $0f
