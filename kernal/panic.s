; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Panic

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

.segment "panic"

; syscall
.global _Panic

;---------------------------------------------------------------
; Panic                                                   $C2C2
;
; Pass:      nothing
; Return:    does not return
;---------------------------------------------------------------
_Panic:
	PopW r0
	SubVW 2, r0
	lda r0H
	ldx #0
	jsr @1
	lda r0L
	jsr @1
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
@1:	pha
	lsr
	lsr
	lsr
	lsr
	jsr @2
	inx
	pla
	and #%00001111
	jsr @2
	inx
	rts
@2:	cmp #10
	bcs @3
	addv ('0')
	bne @4
@3:	addv ('0'+7)
@4:	sta _PanicAddr,x
	rts

_PanicDB_DT:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
	.byte NULL

_PanicDB_Str:
	.byte BOLDON
	.byte "System error near $"
_PanicAddr:
	.byte "xxxx"
	.byte NULL
