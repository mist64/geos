; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64: Start a program in BASIC mode

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import BootGEOS
.import Init_KRNLVec

.global ToBASIC2
.global ToBASICBuf

.segment "tobasic1"

.if (!.defined(wheels)) && (!.defined(removeToBASIC))
ToBASICBuf:
	.res 40, 0
IntTimer:
	.byte 0
SaveBASIC:
	.byte 0, 0, 0
SaveR7:
	.word 0

ToBASIC2:
	sei
	LoadB CPU_DATA, KRNL_IO_IN
	ldy #2
@1:	lda BASICspace,y
	sta SaveBASIC,y
	dey
	bpl @1
	MoveW r7, SaveR7
	inc CPU_DATA
	ldx #$ff
	txs
	LoadB grcntrl2, 0
	jsr KERNALCIAInit
	ldx curDevice
	lda #0
	tay
@2:	sta zpage+2,y
	sta zpage+$0200,y
	sta zpage+$0300,y
	iny
	bne @2
	stx curDevice
	LoadB BASICMemTop, $a0
	LoadW_ tapeBuffVec, $03c3
	LoadB BASICMemBot, $08
	lsr
	sta scrAddrHi
	jsr Init_KRNLVec
	jsr KERNALVICInit
	LoadW nmivec, execBASIC
	LoadB IntTimer, 6
	lda cia2base+13
	LoadB cia2base+4, $ff
	sta cia2base+5
	LoadB cia2base+13, $81
	LoadB cia2base+14, $01
	jmp (BASIC_START)

execBASIC:
	pha
	tya
	pha
	lda cia2base+13
	dec IntTimer
	bne @4
	LoadB cia2base+13, $7f
	LoadW nmivec, BootGEOS
	ldy #2
@1:	lda SaveBASIC,y
	sta BASICspace,y
	dey
	bpl @1
	MoveW SaveR7, $2d ; VARTAB
	iny
@2:	lda ToBASICBuf,y
	beq @3
	sta (curScrLine),y
	lda #14
	sta curScrLineColor,y
	iny
	bne @2
@3:	tya
	beq @4
	LoadB curPos, 40
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
@4:	pla
	tay
	pla
	rti

.ifndef remove_dead_bytes
; ???
.if .defined(cbmfiles) || .defined(gateway)
	.byte $ff
.else
	.byte $40
.endif
.endif ; remove_dead_bytes

.endif 

