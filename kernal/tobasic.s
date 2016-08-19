; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64: Start a program in BASIC mode

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

; filesys.s
.import _ReadFile

; hw.s
.import Init_KRNLVec

; header.s
.import BootGEOS
.import sysFlgCopy

; syscall
.global _ToBASIC

.segment "tobasic1"

.if (!removeToBASIC)
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
	sta zpage+$0200, y
	sta zpage+$0300, y
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
	lda #>execBASIC
	sta nmivec+1
	lda #<execBASIC
	sta nmivec
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

 ; ???
.ifdef cbmfiles
	.byte $ff
.else
	.byte $40
.endif

.endif

.segment "tobasic2"

_ToBASIC:
.if (removeToBASIC)
	sei
	jsr PurgeTurbo
	LoadB CPU_DATA, KRNL_BAS_IO_IN
	LoadB $DE00, 0
	jmp $fce2
.else
	ldy #39
@1:	lda (r0),Y
	cmp #'A'
	bcc @2
	cmp #'Z'+1
	bcs @2
	sbc #$3F
@2:	sta ToBASICBuf,Y
	dey
	bpl @1
	lda r5H
	beq @4
	iny
	tya
@3:	sta BASICspace,Y
	iny
	bne @3
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
@4:	jsr GetDirHead
	jsr PurgeTurbo
	lda sysRAMFlg
	sta sysFlgCopy
	and #%00100000
	beq @6
	ldy #ToBASICTab_end - ToBASICTab - 1
@5:	lda ToBASICTab,Y
	sta r0,Y
	dey
	bpl @5
	jsr StashRAM
@6:	jmp ToBASIC2

ToBASICTab:
	.word dirEntryBuf
	.word REUOsVarBackup
	.word OS_VARS_LGH
	.byte $00
ToBASICTab_end:
.endif
