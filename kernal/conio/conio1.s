; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Console I/O: PutChar and SmallPutChar syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import _GetRealSize
.import FontPutChar
.import DoESC_RULER
.import _GraphicsString
.import PrvCharWidth

.import Ddec
.import CallRoutine
.import NormalizeX

.global DoBACKSPC
.global _PutChar
.global _SmallPutChar

.segment "conio1"

_PutChar:
.ifdef bsw128
	pha
	ldx #r11
	jsr NormalizeX
	pla
.endif
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
@2:
.ifdef bsw128
	ldx #rightMargin
	jsr NormalizeX
.endif
	CmpW rightMargin, r13
	bcc @5
.ifdef bsw128
	ldx #leftMargin
	jsr NormalizeX
.endif
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
.ifndef wheels_size_and_speed ; no-op
	lda #0 ; XXX was this a constant in the source?
	add r11L
	sta r11L
	bcc @1
	inc r11H
@1:
.endif
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
.ifdef wheels_size_and_speed ; tail call
	jmp Ddec
.else
	jsr Ddec
	rts
.endif
