; GEOS KERNAL
;
; Panic

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

.segment "panic"

.global _Panic

_Panic:
	PopW r0
	SubVW 2, r0
	lda r0H
	ldx #0
	jsr Panil0
	lda r0L
	jsr Panil0
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
Panil0:
	pha
	lsr
	lsr
	lsr
	lsr
	jsr Panil1
	inx
	pla
	and #%00001111
	jsr Panil1
	inx
	rts
Panil1:
	cmp #10
	bcs Panil2
	addv ('0')
	bne Panil3
Panil2:
	addv ('0'+7)
Panil3:
	sta _PanicAddy,X
	rts

_PanicDB_DT:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
	.byte NULL

_PanicDB_Str:
	.byte BOLDON
	.byte "System error near $"
_PanicAddy:
	.byte "xxxx"
	.byte NULL
