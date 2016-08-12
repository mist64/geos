; GEOS Kernal
; logic to start a program in BASIC mode

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; files.s
.import _ReadFile

; hw.s
.import Init_KRNLVec

; main.s
.import sysFlgCopy

.global _ToBASIC

.segment "tobasic"

_ToBASIC:
.if (removeToBASIC)
	sei
	jsr PurgeTurbo
	LoadB CPU_DATA, KRNL_BAS_IO_IN
	LoadB $DE00, 0
	jmp $fce2
.else
	ldy #39
TB1:
	lda (r0),Y
	cmp #'A'
	bcc TB2
	cmp #'Z'+1
	bcs TB2
	sbc #$3F
TB2:
	sta LoKernalBuf,Y
	dey
	bpl TB1
	lda r5H
	beq TB4
	iny
	tya
TB3:
	sta BASICspace,Y
	iny
	bne TB3
	SubVW $0002,r7
	lda (r7),Y
	pha
	iny
	lda (r7),Y
	pha
	PushW r7
	lda (r5),Y
	sta r1L
	iny
	lda (r5),Y
	sta r1H
	LoadW_ r2, $ffff
	jsr _ReadFile
	PopW r0
	ldy #1
	pla
	sta (r0),Y
	dey
	pla
	sta (r0),Y
TB4:
	jsr GetDirHead
	jsr PurgeTurbo
	lda sysRAMFlg
	sta sysFlgCopy
	and #%00100000
	beq TB6
	ldy #6
TB5:
	lda ToBASICTab,Y
	sta r0,Y
	dey
	bpl TB5
	jsr StashRAM
TB6:
	jmp LoKernal1
ToBASICTab:
	.word dirEntryBuf
	.word REUOsVarBackup
	.word OS_VARS_LGH
	.byte $00
.endif

.segment "tobasic2"

.if (removeToBASIC)
.else
LoKernalBuf:
	.byte 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0
	.byte 0, 0, 0, 0, 0, 0, 0, 0
LKIntTimer:
	.byte 0
LKSaveBASIC:
	.byte 0, 0, 0
LKSaveR7:
	.byte 0, 0

LoKernal1:
	sei
	LoadB CPU_DATA, KRNL_IO_IN
	ldy #2
LKernal1:
	lda BASICspace,y
	sta LKSaveBASIC,y
	dey
	bpl LKernal1
	MoveW r7, LKSaveR7
	inc CPU_DATA
	ldx #$ff
	txs
	LoadB grcntrl2, 0
	jsr KERNALCIAInit
	ldx curDevice
	lda #0
	tay
LKernal2:
	sta zpage+2,y
	sta zpage+$0200, y
	sta zpage+$0300, y
	iny
	bne LKernal2
	stx curDevice
	LoadB BASICMemTop, $a0
	LoadW_ tapeBuffVec, $03c3
	LoadB BASICMemBot, $08
	lsr
	sta scrAddyHi
	jsr Init_KRNLVec
	jsr KERNALVICInit
	lda #>execBASIC
	sta nmivec+1
	lda #<execBASIC
	sta nmivec
	LoadB LKIntTimer, 6
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
	dec LKIntTimer
	bne exeBAS4
	LoadB cia2base+13, $7f
	LoadW nmivec, OS_ROM
	ldy #2
exeBAS1:
	lda LKSaveBASIC, y
	sta BASICspace, y
	dey
	bpl exeBAS1
	MoveW LKSaveR7, cardDataPntr+1
	iny
exeBAS2:
	lda LoKernalBuf,y
	beq exeBAS3
	sta (curScrLine),y
	lda #14
	sta curScrLineColor,y
	iny
	bne exeBAS2
exeBAS3:
	tya
	beq exeBAS4
	LoadB curPos, $28
	LoadB kbdQuePos, 1
	LoadB kbdQue, CR
exeBAS4:
	pla
	tay
	pla
	rti
.endif

 ; ???
.ifdef maurice
	.byte $ff
.else
	.byte $40
.endif
