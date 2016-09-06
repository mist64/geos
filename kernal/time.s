; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/CIA clock driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

; header.s
.import dateCopy

; var.s
.import alarmWarnFlag

; called by main loop
.global _DoUpdateTime

.segment "time1"

_DoUpdateTime:
	sei
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	lda cia1base+15
	and #%01111111
	sta cia1base+15
	lda hour
	cmp #12
	bmi @1
	bbsf 7, cia1base+11, @1
	jsr DateUpdate
@1:	lda cia1base+11
	and #%00011111
	cmp #$12
	bne @2
	lda #0
@2:	bbrf 7, cia1base+11, @3
	sed
	addv $12
	cld
@3:	jsr ConvertBCD
	sta hour
	lda cia1base+10
	jsr ConvertBCD
	sta minutes
	lda cia1base+9
	jsr ConvertBCD
	sta seconds
	lda cia1base+8
	ldy #2
@4:	lda year,y
	sta dateCopy,y
	dey
	bpl @4
	MoveB cia1base+13, r1L
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	bbrf 7, alarmSetFlag, @5
	and #ALARMMASK
	beq @6
	lda #$4a
	sta alarmSetFlag
	lda alarmTmtVector
	ora alarmTmtVector+1
	beq @5
	jmp (alarmTmtVector)
@5:	bbrf 6, alarmSetFlag, @6
	jsr DoClockAlarm
@6:	cli
	rts

DateUpdate:
	jsr CheckMonth
	cmp day
	beq @1
	inc day
	rts
@1:	ldy #1
	sty day
	inc month
	lda month
	cmp #13
	bne @2
	sty month
	inc year
; The implementation disagrees with the documentation,
; which says years are 1900-based: This code implies
; that "2000" is stored as 0, which is the "Excel" way
; of storing dates. With a cutoff year of 1980, numbers
; 80-99 would be 1980-1999, and 0-79 would be 2000-2079.
; It is unknown what the cutoff year should be.
	lda year
	cmp #100
.if wheels
	bcc @2 ; new years with an illegal new year? store "0".
.else
	bne @2 ; 1999->2000: store "0" as year
.endif
	dey
	sty year ; year 0
@2:	rts

CheckMonth:
	ldy month
	lda daysTab-1, y
; This code is correct for the years 1901-2099.
; This is another reason why the year probably should
; not be considered 1900-based, since this logic is
; incorrect for 1900, but it would be correct for any
; cutoff year.
	cpy #2
	bne @2
	tay
	lda year
	and #3
	bne @1
	iny
@1:	tya
@2:	rts

daysTab:
	.byte 31, 28, 31, 30, 31, 30
	.byte 31, 31, 30, 31, 30, 31

ConvertBCD:
	pha
.if !wheels_size_and_speed ; no-op
	and #%11110000
.endif
	lsr
	lsr
	lsr
	lsr
	tay
	pla
	and #%00001111
	clc
@1:	dey
	bmi @2
	adc #10
	bne @1
@2:	rts

DoClockAlarm:
	lda alarmWarnFlag
	bne @3
	ldy CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	ldx #pingTabEnd - pingTab - 1
@1:	lda pingTab,x
	sta sidbase,x
	dex
	bpl @1
	ldx #$21
	lda alarmSetFlag
	and #%00111111
	bne @2
	tax
@2:	stx sidbase+4
	sty CPU_DATA
ASSERT_NOT_BELOW_IO
	lda #$1e
	sta alarmWarnFlag
	dec alarmSetFlag
@3:	rts

.segment "time2"

pingTab:
	.byte $00, $10, $00, $08, $40, $08, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $0f
pingTabEnd:

; ???
.if wheels
	.word 0
.else
	.word $0f00
.endif
