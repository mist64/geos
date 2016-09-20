; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: GetString syscall

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import DoBACKSPC
.import tmpKeyVector
.import stringLen
.import stringMaxLen
.import stringMargCtrl
.import _PromptOff
.import _PromptOn
.import _InitTextPrompt

.import NormalizeX

.ifdef bsw128
.import PromptOn
.import _PutChar
.import _PutString
PutChar = _PutChar
PutString = _PutString
.else
.import PutChar
.import PutString
.endif

.global ProcessCursor
.global _GetString

.segment "conio4"

_GetString:
.ifdef bsw128
	ldx #r11
	jsr NormalizeX
.endif
	MoveW r0, string
	MoveB r1L, stringMargCtrl
	MoveB r1H, stringY
	MoveB r2L, stringMaxLen
	PushB r1H
	clc
	lda baselineOffset
	adc r1H
	sta r1H
	jsr PutString
	PopB r1H
	sec
	lda r0L
	sbc string
	sta stringLen
	MoveW r11, stringX
	MoveW keyVector, tmpKeyVector
	LoadW keyVector, GSSkeyVector
	LoadW StringFaultVec, GSStringFault
	bbrf 7, stringMargCtrl, @1
	MoveW r4, StringFaultVec
@1:	lda curHeight
	jsr _InitTextPrompt
.ifdef bsw128
	jmp PromptOn
.else
	jmp _PromptOn
.endif

GSStringFault:
	MoveB stringLen, stringMaxLen
	dec stringLen
	rts

ProcessCursor:
	lda alphaFlag
	bpl @2
	dec alphaFlag
	lda alphaFlag
	and #$3f
	bne @2
	bbrf 6, alphaFlag, @1
	jmp _PromptOff
@1:	jmp _PromptOn
@2:	rts

GSSkeyVector:
	jsr _PromptOff
	MoveW stringX, r11
	MoveB stringY, r1H
	ldy stringLen
	lda keyData
	bpl @2
@1:	rts
@2:	cmp #CR
	beq @6
	cmp #BACKSPACE
	beq @4
	cmp #KEY_DELETE
	beq @4
	cmp #KEY_INSERT
	beq @4
	cmp #KEY_RIGHT
	beq @4
	cmp #' '
	bcc @1
	cpy stringMaxLen
	beq @5
	sta (string),y
	PushB dispBufferOn
.ifdef wheels_size_and_speed ; duplicate read of dispBufferOn
	and #$20
        beq @3
.else
	bbrf 5, dispBufferOn, @3
.endif
	LoadB dispBufferOn, (ST_WR_FORE | ST_WRGS_FORE)
@3:	PushB r1H
	clc
	lda baselineOffset
	adc r1H
	sta r1H
	lda (string),y
	jsr PutChar
	PopB r1H
	PopB dispBufferOn
	inc stringLen
	ldx r11H
	stx stringX+1
	ldx r11L
	stx stringX
	bra @5
@4:	jsr GSHelp1
.ifndef wheels_size_and_speed ; no op
	bra @5
.endif
@5:	jmp _PromptOn
@6:
.ifdef bsw128
	php
.endif
	sei
	jsr _PromptOff
	lda #%01111111
	and alphaFlag
	sta alphaFlag
.ifdef bsw128
	plp
.else
	cli
.endif
	lda #0
	sta (string),y
	MoveW tmpKeyVector, r0
	lda #0
	sta keyVector
	sta keyVector+1
	sta StringFaultVec
	sta StringFaultVec+1
	ldx stringLen
	jmp (r0)

GSHelp1:
	cpy #0
	beq @2
	dey
	sty stringLen
	PushB dispBufferOn
	bbrf 5, dispBufferOn, @1
	LoadB dispBufferOn, (ST_WR_FORE | ST_WRGS_FORE)
@1:	PushB r1H
	clc
	lda baselineOffset
	adc r1H
	sta r1H
	lda (string),y
	jsr DoBACKSPC
	PopB r1H
	ldy stringLen
	PopB dispBufferOn
	ldx r11H
	stx stringX+1
	ldx r11L
	stx stringX
	clc
	rts
@2:	sec
	rts
