; simple console I/O

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.import KbdScanHelp3, DecTabH, DecTabL, _DisablSprite, _EnablSprite, _PosSprite, _GraphicsString, Font_10, _GetRealSize, PutCharTabH, PutCharTabL, BSWFont, SerialHiCompare, _GetSerialNumber2, SerialHiCompare
.global DoBACKSPACE, DoBOLDON, DoCR, DoESC_GRAPHICS, DoESC_RULER, DoGOTOXY, DoGOTOY, DoHOME, DoITALICON, DoLF, DoNEWCARDSET, DoOUTLINEON, DoPLAINTEXT, DoREV_OFF, DoREV_ON, DoTAB, DoULINEOFF, DoULINEON, DoUPLINE, GetChWdth1, ProcessCursor, _GetCharWidth, _GetNextChar, _GetString, _InitTextPrompt, _LoadCharSet, _PromptOff, _PromptOn, _PutChar, _PutDecimal, _PutString, _SmallPutChar, _UseSystemFont, _i_PutString, DoGOTOX

.segment "conio"

_PutChar:
	cmp #$20
	bcs PutChar1
	tay
	lda PutCharTabL-8,y
	ldx PutCharTabH-8,y
	jmp CallRoutine
PutChar1:
	pha
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
	bcc *+4
	inc r13H
	CmpW rightMargin, r13
	bcc PutChar4
	CmpW leftMargin, r11
	beq PutChar2
	bcs PutChar3
PutChar2:
	pla
	subv $20
	jmp Font_10
PutChar3:
	lda r13L
	addv 1
	sta r11L
	lda r13H
	adc #0
	sta r11H
PutChar4:
	pla
	ldx StringFaultVec+1
	lda StringFaultVec
	jmp CallRoutine

.segment "conio3"

_SmallPutChar:
	subv $20
	jmp Font_10

DoTAB:
	lda #0
	add r11L
	sta r11L
	bcc *+4
	inc r11H
	rts

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
	bne *+4
	inc r0H
	ldy #0
	lda (r0),y
	sta r11L
	inc r0L
	bne *+4
	inc r0H
	lda (r0),y
	sta r11H
	rts

DoGOTOY:
	inc r0L
	bne *+4
	inc r0H
	ldy #0
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
	bcs *+4
	dec r11H
	PushW r11
	lda #$5f
	jsr Font_10
	PopW r11
	rts

DoESC_GRAPHICS:
	inc r0L
	bne *+4
	inc r0H
	jsr _GraphicsString
	ldx #r0
	jsr Ddec
	ldx #r0
	jsr Ddec
	rts

_i_PutString:
	PopB r0L
	pla
	inc r0L
	bne iPutSt1
	addv 1
iPutSt1:
	sta r0H
	ldy #0
	lda (r0),y
	inc r0L
	bne *+4
	inc r0H
	sta r11L
	lda (r0),y
	inc r0L
	bne *+4
	inc r0H
	sta r11H
	lda (r0),y
	inc r0L
	bne *+4
	inc r0H
	sta r1H
	jsr _PutString
	inc r0L
	bne *+4
	inc r0H
	jmp (r0)

_PutString:
	ldy #0
	lda (r0),y
	beq PutStr1
	jsr _PutChar
	inc r0L
	bne *+4
	inc r0H
	bra _PutString
PutStr1:
	rts

_UseSystemFont:
	LoadW r0, BSWFont
_LoadCharSet:
	ldy #0
UseSysFnt1:
	lda (r0),y
	sta baselineOffset,y
	iny
	cpy #8
	bne UseSysFnt1
	AddW r0, curIndexTable
	AddW r0, cardDataPntr

.if (trap)
    ; copy high-byte of serial
	lda SerialHiCompare
	bne :+
	jsr _GetSerialNumber2
	sta SerialHiCompare
.endif
:	rts

_GetCharWidth:
	subv $20
	bcs GetChWdth1
	lda #0
	rts
GetChWdth1:
	cmp #$5f
	bne GetChWdth2
	lda PrvCharWidth
	rts
GetChWdth2:
	asl
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
	bbrf 7, stringMargCtrl, GetStr1
	MoveW r4, StringFaultVec
GetStr1:
	lda curHeight
	jsr _InitTextPrompt
	jmp _PromptOn

GSStringFault:
	MoveB stringLen, stringMaxLen
	dec stringLen
GSStrFltEnd:
	rts

ProcessCursor:
	lda alphaFlag
	bpl ProcCur2
	dec alphaFlag
	lda alphaFlag
	and #$3f
	bne ProcCur2
	bbrf 6, alphaFlag, ProcCur1
	jmp _PromptOff
ProcCur1:
	jmp _PromptOn
ProcCur2:
	rts

GSSkeyVector:
	jsr _PromptOff
	MoveW stringX, r11
	MoveB stringY, r1H
	ldy stringLen
	lda keyData
	bpl GSSkeyVec2
GSSkeyVec1:
	rts
GSSkeyVec2:
	cmp #CR
	beq GSSkeyVec5
	cmp #BACKSPACE
	beq GSSkeyVec3
	cmp #KEY_DELETE
	beq GSSkeyVec3
	cmp #KEY_INSERT
	beq GSSkeyVec3
	cmp #KEY_RIGHT
	beq GSSkeyVec3
	cmp #' '
	bcc GSSkeyVec1
	cpy stringMaxLen
	beq GSSkeyVec4
	sta (string),y
	PushB dispBufferOn
	bbrf 5, dispBufferOn, GSSkeyVec21
	LoadB dispBufferOn, (ST_WR_FORE | ST_WRGS_FORE)
GSSkeyVec21:
	PushB r1H
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
	bra GSSkeyVec4
GSSkeyVec3:
	jsr GSHelp1
	bra GSSkeyVec4
GSSkeyVec4:
	jmp _PromptOn
GSSkeyVec5:
	sei
	jsr _PromptOff
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
	beq GSHelp12
	dey
	sty stringLen
	PushB dispBufferOn
	bbrf 5, dispBufferOn, GSHelp11
	LoadB dispBufferOn, (ST_WR_FORE | ST_WRGS_FORE)
GSHelp11:
	PushB r1H
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
GSHelp12:
	sec
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
IniTxPrm1:
	sta spr1pic-1,x
	dex
	bne IniTxPrm1
	pla
	tay
	cpy #21
	bcc IniTxPrm2
	beq IniTxPrm2
	tya
	lsr
	tay
	lda moby2
	ora #2
	sta moby2
IniTxPrm2:
	lda #%10000000
IniTxPrm3:
	sta spr1pic,x
	inx
	inx
	inx
	dey
	bpl IniTxPrm3
	PopB CPU_DATA
	rts

CalcDecimal:
	sta r2L
	LoadB r2H, 4
	lda #0
	sta r3L
	sta r3H
CalcDec0:
	ldy #0
	ldx r2H
CalcDec1:
	lda r0L
	sec
	sbc DecTabL,x
	sta r0L
	lda r0H
	sbc DecTabH,x
	bcc CalcDec2
	sta r0H
	iny
	bra CalcDec1
CalcDec2:
	lda r0L
	adc DecTabL,x
	sta r0L
	tya
	bne CalcDec3
	cpx #0
	beq CalcDec3
	bbsf 6, r2L, CalcDec4
CalcDec3:
	ora #%00110000
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
CalcDec4:
	dec r2H
	bpl CalcDec0
	rts

.segment "conio5"

_PutDecimal:
	jsr CalcDecimal
	bbsf 7, r2L, PutDec1
	lda r2L
	and #$3f
	sub r3H
	add r11L
	sta r11L
	bcc *+4
	inc r11H
PutDec1:
	ldx r3L
	stx r0L
PutDec2:
	lda Z45-1,x
	pha
	dex
	bne PutDec2
PutDec3:
	pla
	jsr _PutChar
	dec r0L
	bne PutDec3
	rts

.segment "conio6"

_GetNextChar:
	bbrf KEYPRESS_BIT, pressFlag, GetNxtChar1
	jmp KbdScanHelp3
GetNxtChar1:
	lda #0
	rts
