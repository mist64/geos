; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/C128 keyboard driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import KbdTab2
.import KbdTab1
.import KbdScanHelp6
.import KbdDecodeTab1
.import KbdDecodeTab2
.import KbdDMltTab
.import KbdDBncTab
.import KbdTestTab
.import KbdScanHelp5
.import KbdScanHelp2
.import KbdNextKey
.import KbdQueFlag
.import BitMaskPow2

.global _DoKeyboardScan

.segment "keyboard1"

_DoKeyboardScan:
.ifdef wheels_screensaver
.import ScreenSaver1
	jsr     ScreenSaver1
	bcs @5
.endif
.ifdef bsw128
	PushB clkreg
	LoadB clkreg, 0
.endif
	lda KbdQueFlag
	bne @1
	lda KbdNextKey
	jsr KbdScanHelp2
.ifdef wheels
	sec
	lda keyRptCount
	sbc keyAccel
	bcc @X
	cmp minKeyRepeat
	bcc @X
	asl keyAccel
	bcc @Y
@X:	lda minKeyRepeat
@Y:	sta KbdQueFlag
.else
	LoadB KbdQueFlag, 15
.endif
@1:	LoadB r1H, 0
.ifdef wheels
        ldy     #$FF
        sty     cia1base+2
        iny
        sty     cia1base+3
.endif
	jsr KbdScanRow
	bne @5
	jsr KbdScanHelp5
.ifdef bsw128
	ldy #10
.else
	ldy #7
.endif
@2:	jsr KbdScanRow
	bne @5
.ifdef bsw128
	cpy #8
	bcc @X
	lda KbdTestTab-8,y
	sta keyreg
	bne @Z
@X:
.endif
	lda KbdTestTab,y
	sta cia1base+0
@Z:	lda cia1base+1
	cmp KbdDBncTab,y
	sta KbdDBncTab,y
	bne @4
	cmp KbdDMltTab,y
	beq @4
	pha
	eor KbdDMltTab,y
	beq @3
	jsr KbdScanHelp1
@3:	pla
	sta KbdDMltTab,y
@4:	dey
	bpl @2
@5:
.ifdef bsw128
	PopB clkreg
.endif
	rts

.ifdef wheels_screensaver
.global KbdScanAll
KbdScanAll:
	lda #$00
	.byte $2c
.endif
KbdScanRow:
	LoadB cia1base+0, $ff
.ifdef bsw128
	LoadB $D02F, $ff
.endif
	CmpBI cia1base+1, $ff
	rts

KbdScanHelp1:
	sta r0L
	LoadB r1L, 7
@1:	lda r0L
	ldx r1L
	and BitMaskPow2,x
.if .defined(bsw128) || .defined(wheels)
	beq @X
	jsr @Y
@X:	dec r1L
	bpl @1
	rts
.else
	beq @A	; really dirty trick...
.endif
@Y:	tya
	asl
	asl
	asl
	adc r1L
	tax
	bbrf 7, r1H, @2
	lda KbdDecodeTab2,x
	bra @3
@2:	lda KbdDecodeTab1,x
@3:	sta r0H
.ifdef bsw128
	lda CPU_DATA
	and #%01000000
	bne @XX
	lda r0H
	jsr KbdScanHelp6
	sta r0H
@XX:	lda r1H
	and #$20
	beq @4
.else
	bbrf 5, r1H, @4
.endif
	lda r0H
	jsr KbdScanHelp6
	cmp #'A'
	bcc @4
	cmp #'Z'+1
	bcs @4
	subv $40
	sta r0H
@4:	bbrf 6, r1H, @5
	smbf_ 7, r0H
@5:	lda r0H
	sty r0H
	ldy #8
@6:	cmp KbdTab1,y
	beq @7
	dey
	bpl @6
	bmi @8
@7:	lda KbdTab2,y
@8:	ldy r0H
	sta r0H
	and #%01111111
	cmp #%00011111
	beq @9
	ldx r1L
	lda r0L
	and BitMaskPow2,x
	and KbdDMltTab,y
.ifdef wheels
	beq @9
	lda keyRptCount
	sta KbdQueFlag
	lda keyAccFlag
	sta keyAccel
	lda r0H
	sta keyScanChar
	jmp KbdScanHelp2
@9:	lda #$FF
	sta KbdQueFlag
	lda #0
	sta keyScanChar
	rts
.else
	beq @9
	LoadB KbdQueFlag, 15
	MoveB r0H, KbdNextKey
.ifdef bsw128
	jmp KbdScanHelp2
.else
	jsr KbdScanHelp2
	bra @A
.endif
@9:	LoadB KbdQueFlag, $ff
	LoadB KbdNextKey, 0
.ifndef bsw128
@A:	dec r1L
	bmi @B
	jmp @1
@B:
.endif
	rts
.endif

