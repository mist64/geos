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

.segment "time"

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
	lda year
	cmp #100
.if wheels
	bcc @2
.else
	bne @2
.endif
	dey
	sty year
@2:	rts

CheckMonth:
	ldy month
	lda daysTab-1, y
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
.if !wheels
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

.if wheels
LFDCB:  .byte   $BB,$BB,$BB,$BB,$BB,$BB,$BB,$BA ; FDCB BB BB BB BB BB BB BB BA  ........
        .byte   $E0                             ; FDD3 E0                       .
LFDD4:  .byte   $3C,$3C,$3C,$3C,$3C,$3C,$3C,$3E ; FDD4 3C 3C 3C 3C 3C 3C 3C 3E  <<<<<<<>
        .byte   $5E                             ; FDDC 5E                       ^
LFDDD:  .byte   $FE,$FD,$FB,$F7,$EF,$DF,$BF,$7F ; FDDD FE FD FB F7 EF DF BF 7F  ........
LFDE5:  .byte   $1D,$0D,$1E,$0E,$01,$03,$05,$11 ; FDE5 1D 0D 1E 0E 01 03 05 11  ........
        .byte   $33,$77,$61,$34,$79,$73,$65,$1F ; FDED 33 77 61 34 79 73 65 1F  3wa4yse.
        .byte   $35,$72,$64,$36,$63,$66,$74,$78 ; FDF5 35 72 64 36 63 66 74 78  5rd6cftx
        .byte   $37,$7A,$67,$38,$62,$68,$75,$76 ; FDFD 37 7A 67 38 62 68 75 76  7zg8bhuv
        .byte   $39,$69,$6A,$30,$6D,$6B,$6F,$6E ; FE05 39 69 6A 30 6D 6B 6F 6E  9ij0mkon
        .byte   $7E,$70,$6C,$27,$2E,$7C,$7D,$2C ; FE0D 7E 70 6C 27 2E 7C 7D 2C  ~pl'.|},
        .byte   $1F,$2B,$7B,$12,$1F,$23,$1F,$2D ; FE15 1F 2B 7B 12 1F 23 1F 2D  .+{..#.-
        .byte   $31,$14,$1F,$32,$20,$1F,$71,$16 ; FE1D 31 14 1F 32 20 1F 71 16  1..2 .q.
LFE25:  .byte   $1C,$0D,$08,$0F,$02,$04,$06,$10 ; FE25 1C 0D 08 0F 02 04 06 10  ........
        .byte   $40,$57,$41,$24,$59,$53,$45,$1F ; FE2D 40 57 41 24 59 53 45 1F  @WA$YSE.
        .byte   $25,$52,$44,$26,$43,$46,$54,$58 ; FE35 25 52 44 26 43 46 54 58  %RD&CFTX
        .byte   $2F,$5A,$47,$28,$42,$48,$55,$56 ; FE3D 2F 5A 47 28 42 48 55 56  /ZG(BHUV
        .byte   $29,$49,$4A,$3D,$4D,$4B,$4F,$4E ; FE45 29 49 4A 3D 4D 4B 4F 4E  )IJ=MKON
        .byte   $3F,$50,$4C,$60,$3A,$5C,$5D,$3B ; FE4D 3F 50 4C 60 3A 5C 5D 3B  ?PL`:\];
        .byte   $5E,$2A,$5B,$13,$1F,$27,$1F,$5F ; FE55 5E 2A 5B 13 1F 27 1F 5F  ^*[..'._
        .byte   $21,$14,$1F,$22,$20,$1F,$51,$17 ; FE5D 21 14 1F 22 20 1F 51 17  !.." .Q.
.endif

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
