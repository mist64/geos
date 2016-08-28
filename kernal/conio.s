; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

; bswfont.s
.import BSWFont

; fonts.s
.import FontPutChar
.import _GetRealSize

; graph.s
.import _GraphicsString

; mouse.s
.import DoESC_RULER

; sprites.s
.import _DisablSprite
.import _EnablSprite
.import _PosSprite

; var.s
.import tmpKeyVector
.import stringLen
.import stringMaxLen
.import stringMargCtrl
.import PrvCharWidth

.if (trap)
; filesys.s
.import SerialHiCompare
; serial.s
.import GetSerialNumber2
.endif

.global GetChWdth1
.global ProcessCursor
.global _GetCharWidth
.global _GetString
.global _InitTextPrompt
.global _LoadCharSet
.global _PromptOff
.global _PromptOn
.global _PutChar
.global _PutDecimal
.global _PutString
.global _SmallPutChar
.global _UseSystemFont
.global _i_PutString

.segment "conio"

_PutChar:
	cmp #$20
	bcs @1
	tay
	lda PutCharTabL-8,y
	ldx PutCharTabH-8,y
	jmp CallRoutine
@1:	pha
	ldy r11H
	sty r13H
	ldy r11L
	sty r13L
	ldx currentMode
	jsr _GetRealSize
	dey
	tya
	add r13L
	sta r13L
	bcc @2
	inc r13H
@2:	CmpW rightMargin, r13
	bcc @5
	CmpW leftMargin, r11
	beq @3
	bcs @4
@3:	pla
	subv $20
	jmp FontPutChar
@4:	lda r13L
	addv 1
	sta r11L
	lda r13H
	adc #0
	sta r11H
@5:	pla
	ldx StringFaultVec+1
	lda StringFaultVec
	jmp CallRoutine

.define PutCharTab DoBACKSPACE, DoTAB, DoLF, DoHOME, DoUPLINE, DoCR, DoULINEON, DoULINEOFF, DoESC_GRAPHICS, DoESC_RULER, DoREV_ON, DoREV_OFF, DoGOTOX, DoGOTOY, DoGOTOXY, DoNEWCARDSET, DoBOLDON, DoITALICON, DoOUTLINEON, DoPLAINTEXT
PutCharTabL:
	.lobytes PutCharTab
PutCharTabH:
	.hibytes PutCharTab

;---------------------------------------------------------------
; SmallPutChar                                            $C202
;
; Pass:      same as PutChar, but must be sure that
;            everything is OK, there is no checking
; Return:    same as PutChar
; Destroyed: same as PutChar
;---------------------------------------------------------------
_SmallPutChar:
	subv $20
	jmp FontPutChar

DoTAB:
.if !wheels
	lda #0
	add r11L
	sta r11L
	bcc @1
	inc r11H
.else
@1:	rts
.endif

DoLF:
	lda r1H
	sec
	adc curHeight
	sta r1H
	rts

DoHOME:
	LoadW_ r11, 0
	sta r1H
	rts

DoUPLINE:
	SubB curHeight, r1H
	rts

DoCR:
	MoveW leftMargin, r11
	jmp DoLF

DoULINEON:
	smbf UNDERLINE_BIT, currentMode
	rts

DoULINEOFF:
	rmbf UNDERLINE_BIT, currentMode
	rts

DoREV_ON:
	smbf REVERSE_BIT, currentMode
	rts

DoREV_OFF:
	rmbf REVERSE_BIT, currentMode
	rts

DoGOTOX:
	inc r0L
	bne @1
	inc r0H
@1:	ldy #0
	lda (r0),y
	sta r11L
	inc r0L
	bne @2
	inc r0H
@2:	lda (r0),y
	sta r11H
	rts

DoGOTOY:
	inc r0L
	bne @1
	inc r0H
@1:	ldy #0
	lda (r0),y
	sta r1H
	rts

DoGOTOXY:
	jsr DoGOTOX
	jmp DoGOTOY

DoNEWCARDSET:
	AddVW 3, r0
	rts

DoBOLDON:
	smbf BOLD_BIT, currentMode
	rts

DoITALICON:
	smbf ITALIC_BIT, currentMode
	rts

DoOUTLINEON:
	smbf OUTLINE_BIT, currentMode
	rts

DoPLAINTEXT:
	LoadB currentMode, NULL
	rts

DoBACKSPC:
	ldx currentMode
	jsr _GetRealSize
	sty PrvCharWidth
DoBACKSPACE:
	SubB PrvCharWidth, r11L
	bcs @1
	dec r11H
@1:	PushW r11
	lda #$5f
	jsr FontPutChar
	PopW r11
	rts

DoESC_GRAPHICS:
	inc r0L
	bne @1
	inc r0H
@1:	jsr _GraphicsString
	ldx #r0
	jsr Ddec
	ldx #r0
.if wheels
	jmp Ddec
.else
	jsr Ddec
	rts
.endif

_i_PutString:
	PopB r0L
	pla
	inc r0L
	bne @1
	addv 1
@1:	sta r0H
	ldy #0
	lda (r0),y
	inc r0L
	bne @2
	inc r0H
@2:	sta r11L
	lda (r0),y
	inc r0L
	bne @3
	inc r0H
@3:	sta r11H
	lda (r0),y
	inc r0L
	bne @4
	inc r0H
@4:	sta r1H
	jsr _PutString
	inc r0L
	bne @5
	inc r0H
@5:	jmp (r0)

_PutString:
	ldy #0
	lda (r0),y
	beq @2
	jsr _PutChar
	inc r0L
	bne @1
	inc r0H
@1:	bra _PutString
@2:	rts

_UseSystemFont:
	LoadW r0, BSWFont
_LoadCharSet:
	ldy #0
@1:	lda (r0),y
	sta baselineOffset,y
	iny
	cpy #8
	bne @1
	AddW r0, curIndexTable
	AddW r0, cardDataPntr

.if !wheels
.if (trap)
	; copy high-byte of serial
	lda SerialHiCompare
	bne @2
	jsr GetSerialNumber2
	sta SerialHiCompare
.endif
.endif
@2:	rts

_GetCharWidth:
	subv $20
	bcs GetChWdth1
	lda #0
	rts
GetChWdth1:
	cmp #$5f
	bne @1
	lda PrvCharWidth
	rts
@1:	asl
	tay
	iny
	iny
	lda (curIndexTable),y
	dey
	dey
	sec
	sbc (curIndexTable),y
	rts

_GetString:
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
	lda #>GSSkeyVector
	sta keyVector+1
	lda #<GSSkeyVector
	sta keyVector
	lda #>GSStringFault
	sta StringFaultVec+1
	lda #<GSStringFault
	sta StringFaultVec
	bbrf 7, stringMargCtrl, @1
	MoveW r4, StringFaultVec
@1:	lda curHeight
	jsr $E822;xxx_InitTextPrompt
	jmp $E7E4;xxx_PromptOn

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
	jmp $E808;xxx_PromptOff
@1:	jmp $E7E4;xxx_PromptOn
@2:	rts

GSSkeyVector:
	jsr $E808;xxx_PromptOff
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
.if wheels
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
@4:	jsr $E7A9;xxxGSHelp1
.if !wheels
	bra @5
.endif
@5:	jmp $E7E4;xxx_PromptOn
@6:	sei
	jsr $E808;xxx_PromptOff
	lda #%01111111
	and alphaFlag
	sta alphaFlag
	cli
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

_PromptOn:
	lda #%01000000
	ora alphaFlag
	sta alphaFlag
	LoadB r3L, 1
	MoveW stringX, r4
	MoveB stringY, r5L
	jsr _PosSprite
	jsr _EnablSprite
	bra PrmptOff1

_PromptOff:
	lda #%10111111
	and alphaFlag
	sta alphaFlag
	LoadB r3L, 1
	jsr _DisablSprite
PrmptOff1:
	lda alphaFlag
	and #%11000000
	ora #%00111100
	sta alphaFlag
	rts

_InitTextPrompt:
	tay
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	MoveB mob0clr, mob1clr
	lda moby2
	and #%11111101
	sta moby2
	tya
	pha
	LoadB alphaFlag, %10000011
	ldx #64
	lda #0
@1:	sta spr1pic-1,x
	dex
	bne @1
	pla
	tay
	cpy #21
	bcc @2
	beq @2
	tya
	lsr
	tay
	lda moby2
	ora #2
	sta moby2
@2:	lda #%10000000
@3:	sta spr1pic,x
	inx
	inx
	inx
	dey
	bpl @3
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

CalcDecimal:
	sta r2L
	LoadB r2H, 4
	lda #0
	sta r3L
	sta r3H
@1:	ldy #0
	ldx r2H
@2:	lda r0L
	sec
	sbc DecTabL,x
	sta r0L
	lda r0H
	sbc DecTabH,x
	bcc @3
	sta r0H
	iny
.if wheels
	bne @2
.else
	bra @2
.endif
@3:	lda r0L
	adc DecTabL,x
	sta r0L
	tya
	bne @4
	cpx #0
	beq @4
	bbsf 6, r2L, @5
@4:	ora #%00110000
	ldx r3L
	sta Z45,x
	ldx currentMode
	jsr _GetRealSize
	tya
	add r3H
	sta r3H
	inc r3L
	lda #%10111111
	and r2L
	sta r2L
@5:	dec r2H
	bpl @1
	rts

.define DecTab 1, 10, 100, 1000, 10000
DecTabL:
	.lobytes DecTab
DecTabH:
	.hibytes DecTab

;---------------------------------------------------------------
; PutDecimal                                              $C184
;
; Pass:     a - format: Bit 7: 1 for left justify
;                              0 for right
;                       Bit 6: 1 supress leading 0's
;                              0 print leading 0's
;                       Bit 0-5: field width 4 right justify
;           r0          16 Bit nbr to print
;           r1H         y position (0-199)
;           r11         x position (0-319)
;Return:    r1H         y position for next char
;           r11         x position for next char
;Destroyed: a, x, y, r0, r2 - r10, r12, r13
;---------------------------------------------------------------
_PutDecimal:
	jsr CalcDecimal
.if wheels
	lda r2L
	bmi @1
.else
	bbsf 7, r2L, @1
	lda r2L
.endif
	and #$3f
	sub r3H
	add r11L
	sta r11L
	bcc @1
	inc r11H
@1:	ldx r3L
	stx r0L
@2:	lda Z45-1,x
	pha
	dex
	bne @2
@3:	pla
	jsr _PutChar
	dec r0L
	bne @3
	rts
