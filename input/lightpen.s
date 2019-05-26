; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Lightpen input driver
;

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "jumptab.inc"
.include "c64.inc"

.segment "inputdrv"

MouseInit:
	jmp _MouseInit
SlowMouse:
	jmp _SlowMouse
UpdateMouse:
	jmp _UpdateMouse
.ifdef bsw128
SetMouse:
	rts
.endif

calibMark:
	.byte 0
xDelta:
	.byte 0
tmpFire:
	.byte 0
lphalfx:
	.byte 0
lpy:
	.byte 0
EFE8E:
	.byte 0

_MouseInit:
	LoadB mouseXPos, 8
	sta mouseYPos
	LoadB mouseXPos+1, 0
	bbsf 7, calibMark, _SlowMouse
	sta menuNumber
	LoadB calibMark, $ff
	lda #>_calibrate_db
	sta r0H
	lda #<_calibrate_db
	sta r0L
	;+LoadW r0, _calibrate_db
	jsr DoDlgBox
_SlowMouse:
	rts

_DrawLine:
	;+LoadW r0, _calbrate_gs
	lda #>_calibrate_gs
	sta r0H
	lda #<_calibrate_gs
	sta r0L
	jmp GraphicsString

_calibrate_gs:
	.byte NEWPATTERN, 1
	.byte MOVEPENTO
	.word $0082
	.byte $3c
	.byte RECTANGLETO
	.word $00be
	.byte $64
	.byte NEWPATTERN, 0
	.byte MOVEPENTO
	.word $00a0
	.byte $3e
	.byte RECTANGLETO
	.word $00a0
	.byte $62
	.byte NULL

_DoCalibLP:
	bbsf MOUSEON_BIT, mouseData, DCLP_END
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda lpxpos
	subv $5c
	sta xDelta
	stx CPU_DATA
DCLP_END:
	rts

_UpdateMouse:
	bbsf MOUSEON_BIT, mouseOn, UM_1
	jmp UM_END

UM_1:
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	PushW cia1base+2
	PushB cia1base+0
	LoadW cia1base+2, 0

	lda cia1base+1
	and #$04
	cmp tmpFire
	beq UM_2
	sta tmpFire
	asl
	asl
	asl
	asl
	asl
	sta mouseData
	smbf MOUSE_BIT, pressFlag

UM_2:
	lda menuNumber
	beq UM_3
	MoveB mouseXPos+1, r0L
	lda mouseXPos
	ror r0L
	ror
	clc
	adc #12
	sta lphalfx
	lda mouseYPos
	addv $32
	sta lpy
UM_3:
	LoadB EFE8E, 0
	lda lpxpos
	sub xDelta
	ldx lphalfx
	jsr LPosNormalize
	stx lphalfx
	ora EFE8E
	sta EFE8E

	lda lpypos
	ldx lpy
	jsr LPosNormalize
	stx lpy
	ora EFE8E
	bne UM_END_POP

	ldx #0
	lda lphalfx
	asl
	bcc UM_4
	inx
UM_4:
	stx mouseXPos+1
	sta mouseXPos
	SubVW $18, mouseXPos
	lda lpy
	subv $32
	sta mouseYPos

UM_END_POP:
	PopB cia1base
	PopW cia1base+2
	PopB CPU_DATA
UM_END:
	rts

LPosNormalize:
	stx r0L
	tax
	sub r0L
	bpl LPN_1
	eor #$ff
	addv 1
LPN_1:
	cmp #6
	beq LPN_2
	bcs LPN_END
LPN_2:
	lda #0
LPN_END:
	rts

_calibrate_db:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, $26, TXT_LN_1_Y
	.word _calibrate_db_txt
	.byte DB_USR_ROUT
	.word _DrawLine
	.byte DBOPVEC
	.word _DoCalibLP
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL

_calibrate_db_txt:
	.byte "Click on white vertical line"
	.byte NULL
