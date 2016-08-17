; GEOS KERNAL
;
; C64 keyboard driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "c64.inc"

; bitmask.s
.import BitMaskPow2

; var.s
.import KbdQueHead
.import KbdQueue
.import KbdQueTail
.import KbdDMltTab
.import KbdDBncTab
.import KbdNextKey
.import KbdQueFlag

; used by irq.s
.global _DoKeyboardScan

; used by mouse.s
.global KbdScanHelp3

; syscall
.global _GetNextChar

.segment "keyboard"

_DoKeyboardScan:
	lda KbdQueFlag
	bne DoKbdScan1
	lda KbdNextKey
	jsr KbdScanHelp2
	LoadB KbdQueFlag, 15
DoKbdScan1:
	LoadB r1H, 0
	jsr KbdScanRow
	bne DoKbdScan5
	jsr KbdScanHelp5
	ldy #7
DoKbdScan2:
	jsr KbdScanRow
	bne DoKbdScan5
	lda KbdTestTab,y
	sta cia1base+0
	lda cia1base+1
	cmp KbdDBncTab,y
	sta KbdDBncTab,y
	bne DoKbdScan4
	cmp KbdDMltTab,y
	beq DoKbdScan4
	pha
	eor KbdDMltTab,y
	beq DoKbdScan3
	jsr KbdScanHelp1
DoKbdScan3:
	pla
	sta KbdDMltTab,y
DoKbdScan4:
	dey
	bpl DoKbdScan2
DoKbdScan5:
	rts

KbdScanRow:
	LoadB cia1base+0, $ff
	CmpBI cia1base+1, $ff
	rts

KbdScanHelp1:
	sta r0L
	LoadB r1L, 7
KbdScanHlp_10:
	lda r0L
	ldx r1L
	and BitMaskPow2,x
	beq KbdScanHlp_19	; really dirty trick...
	tya
	asl
	asl
	asl
	adc r1L
	tax
	bbrf 7, r1H, KbdScanHlp_11
	lda KbdDecodeTab2,x
	bra KbdScanHlp_12
KbdScanHlp_11:
	lda KbdDecodeTab1,x
KbdScanHlp_12:
	sta r0H
	bbrf 5, r1H, KbdScanHlp_13
	lda r0H
	jsr KbdScanHelp6
	cmp #'A'
	bcc KbdScanHlp_13
	cmp #'Z'+1
	bcs KbdScanHlp_13
	subv $40
	sta r0H
KbdScanHlp_13:
	bbrf 6, r1H, KbdScanHlp_14
	smbf_ 7, r0H
KbdScanHlp_14:
	lda r0H
	sty r0H
	ldy #8
KbdScanHlp_15:
	cmp KbdTab1,y
	beq KbdScanHlp_16
	dey
	bpl KbdScanHlp_15
	bmi KbdScanHlp_17
KbdScanHlp_16:
	lda KbdTab2,y
KbdScanHlp_17:
	ldy r0H
	sta r0H
	and #%01111111
	cmp #%00011111
	beq KbdScanHlp_18
	ldx r1L
	lda r0L
	and BitMaskPow2,x
	and KbdDMltTab,y
	beq KbdScanHlp_18
	LoadB KbdQueFlag, 15
	MoveB r0H, KbdNextKey
	jsr KbdScanHelp2
	bra KbdScanHlp_19
KbdScanHlp_18:
	LoadB KbdQueFlag, $ff
	LoadB KbdNextKey, 0
KbdScanHlp_19:
	dec r1L
	bmi KbdScanHlp_1a
	jmp KbdScanHlp_10
KbdScanHlp_1a:
	rts

KbdTab1:
	.byte $db, $dd, $de, $ad, $af, $aa, $c0, $ba, $bb
KbdTab2:
	.byte $7b, $7d, $7c, $5f, $5c, $7e, $60, $7b, $7d

KbdTestTab:
	.byte $fe, $fd, $fb, $f7, $ef, $df, $bf, $7f

KbdDecodeTab1:
	.byte KEY_DELETE, CR, KEY_RIGHT, KEY_F7, KEY_F1, KEY_F3, KEY_F5, KEY_DOWN
	.byte "3", "w", "a", "4", "z", "s", "e", KEY_INVALID
	.byte "5", "r", "d", "6", "c", "f", "t", "x"
	.byte "7", "y", "g", "8", "b", "h", "u", "v"
	.byte "9", "i", "j", "0", "m", "k", "o", "n"
	.byte "+", "p", "l", "-", ".", ":", "@", ","
	.byte KEY_BPS, "*", ";", KEY_HOME, KEY_INVALID, "=", "^", "/"
	.byte "1", KEY_LARROW, KEY_INVALID, "2", " ", KEY_INVALID, "q", KEY_STOP
KbdDecodeTab2:
	.byte KEY_INSERT, CR, BACKSPACE, KEY_F8, KEY_F2, KEY_F4, KEY_F6, KEY_UP
	.byte "#", "W", "A", "$", "Z", "S", "E", KEY_INVALID
	.byte "%", "R", "D", "&", "C", "F", "T", "X"
	.byte "'", "Y", "G", "(", "B", "H", "U", "V"
	.byte ")", "I", "J", "0", "M", "K", "O", "N"
	.byte "+", "P", "L", "-", ">", "[", "@", "<"
	.byte KEY_BPS, "*", "]", KEY_CLEAR, KEY_INVALID, "=", "^", "?"
	.byte "!", KEY_LARROW, KEY_INVALID, $22, " ", KEY_INVALID, "Q", KEY_RUN

KbdScanHelp2:
	php
	sei
	pha
	smbf KEYPRESS_BIT, pressFlag
	ldx KbdQueTail
	pla
	sta KbdQueue,x
	jsr KbdScanHelp4
	cpx KbdQueHead
	beq KbdScanHlp_21
	stx KbdQueTail
KbdScanHlp_21:
	plp
	rts

KbdScanHelp3:
	php
	sei
	ldx KbdQueHead
	lda KbdQueue,x
	sta keyData
	jsr KbdScanHelp4
	stx KbdQueHead
	cpx KbdQueTail
	bne KbdScanHlp_31
	rmb KEYPRESS_BIT, pressFlag
KbdScanHlp_31:
	plp
	rts

KbdScanHelp4:
	inx
	cpx #16
	bne KbdScanHlp_41
	ldx #0
KbdScanHlp_41:
	rts

;---------------------------------------------------------------
;---------------------------------------------------------------
_GetNextChar:
	bbrf KEYPRESS_BIT, pressFlag, GetNxtChar1
	jmp KbdScanHelp3
GetNxtChar1:
	lda #0
	rts

KbdScanHelp5:
	LoadB cia1base+0, %11111101
	lda cia1base+1
	eor #$ff
	and #%10000000
	bne KbdScanHlp_51
	LoadB cia1base+0, %10111111
	lda cia1base+1
	eor #$ff
	and #%00010000
	beq KbdScanHlp_52
KbdScanHlp_51:
	smbf 7, r1H
KbdScanHlp_52:
	LoadB cia1base+0, %01111111
	lda cia1base+1
	eor #$ff
	and #%00100000
	beq KbdScanHlp_53
	smbf 6, r1H
KbdScanHlp_53:
	LoadB cia1base+0, %01111111
	lda cia1base+1
	eor #$ff
	and #%00000100
	beq KbdScanHlp_54
	smbf 5, r1H
KbdScanHlp_54:
	rts

KbdScanHelp6:
	pha
	and #%01111111
	cmp #'a'
	bcc KbdScanHlp_61
	cmp #'z'+1
	bcs KbdScanHlp_61
	pla
	subv $20
	pha
KbdScanHlp_61:
	pla
	rts

