; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/C128: Start a program in BASIC mode

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import ToBASIC2
.import sysFlgCopy
.import _ReadFile
.import ToBASICBuf

.import StashRAM
.import PurgeTurbo
.import NewDisk

.ifdef bsw128
.import _CopyCmdToBack
.import ToBASIC2
.else
.import GetDirHead
.endif

.global _ToBASIC

.segment "tobasic2"

.ifndef wheels
_ToBASIC:
.ifdef removeToBASIC
	sei
	jsr PurgeTurbo
	LoadB CPU_DATA, KRNL_BAS_IO_IN
	LoadB $DE00, 0
	jmp $fce2
.else
.ifdef bsw128
	jsr _CopyCmdToBack
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
.endif
	lda r5H
	beq @4
	iny
	tya
@3:	sta BASICspace,y
	iny
	bne @3
	SubVW 2, r7
	lda (r7),y
	pha
	iny
	lda (r7),y
	pha
	PushW r7
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	LoadW_ r2, $ffff
	jsr _ReadFile
	PopW r0
	ldy #1
	pla
	sta (r0),y
	dey
	pla
	sta (r0),y
.ifdef bsw128
	lda #0
	sta r5L
.endif
@4:
.ifdef bsw128
	jsr NewDisk
	txa
	pha
.else
	jsr GetDirHead
.endif
	jsr PurgeTurbo
	lda sysRAMFlg
	sta sysFlgCopy
	and #%00100000
	beq @6
	ldy #ToBASICTab_end - ToBASICTab - 1
@5:	lda ToBASICTab,y
	sta r0,y
	dey
	bpl @5
	jsr StashRAM
@6:
.ifdef bsw128
	pla
.endif
	jmp ToBASIC2

ToBASICTab:
	.word dirEntryBuf
	.word REUOsVarBackup
	.word OS_VARS_LGH
	.byte 0
ToBASICTab_end:
.endif
.endif
