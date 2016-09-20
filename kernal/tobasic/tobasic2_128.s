; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C128: Start a program in BASIC mode

.segment "tobasic2"

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "diskdrv.inc"
.include "kernal.inc"
.include "c64.inc"

.import _MoveBData
.import ShareTop
.import ShareTopBot

.global ToBASIC2
.global _CopyCmdToBack

L0A00 = $0A00
L0E00 = $0E00

;---------------------------------------------------------------
_CopyCmdToBack:
	jsr ShareTopBot
	ldy #39
@1:	lda (r0),y
	sta L0E00,y
	dey
	bpl @1
	jmp ShareTop

;---------------------------------------------------------------
;A is the parameter, if it's =0 then "I:0" is sent to drive
;before exit to BASIC? BOOT?
ToBASIC2:
	pha
	ldy #$00
	sty r0L
	sty r1L
	sty r2L
	sty r3H ; dst bank: back
	iny
	sty r3L ; src bank: front
	lda #>BASICspace
	sta r0H ; src
	sta r1H ; and dst
	lda #>$6400 ; len
	sta r2H
	jsr _MoveBData ; copy $1C00-$8000 from front to back
	sei
	jsr ShareTopBot
	MoveB r5L, L0E00+$2D
	ldy #2
@1:	lda BASICspace,y
	sta L0E00+$29,y
	dey
	bpl @1
	ldx #ContCodeEnd - ContCode
@2:	lda ContCode-1,x
	sta L0E00+$2E-1,x
	dex
	bne @2
	pla
	jmp L0E00+$2E

; this is copied to $0E2E
ContCode:
	ldx #0
	stx config
	dex
	txs
	tax
	bne @1
	lda curDevice
	jsr $FFB1
	lda #$FF
	jsr $FF93
	lda #'I'
	jsr $FFA8
	lda #':'
	jsr $FFA8
	lda #'0'
	jsr $FFA8
	jsr $FFAE
	lda curDevice
	jsr $FFB1
	lda #$EF
	jsr $FF93
	jsr $FFAE
@1:	ldx #10
@2:	lda $E04B,x
	sta mmu,x
	dex
	bpl @2
	sta $0A04
	jsr $E0CD
	jsr $E242
	jsr $E109
	jsr $F63D
	lda #$00
	sta $0A02
	jsr $E093
	jsr $E056
	jsr $C000
	lda L0E00+$2D
	beq @3
	cli
	jmp (L0A00)
@3:	jsr $417A
	jsr $4251
	jsr $4045
	jsr $419B
	lda $0A04
	ora #$01
	sta $0A04
	ldx #$03
	stx L0A00
	ldx #$FB
	txs
	LoadW nmivec, L0E00+$2E+NMIHandler-ContCode
	lda #$00
	sta L0E00+$2C
	lda #$06
	sta L0E00+$28
	lda cia2base+13
	lda #$FF
	sta cia2base+4
	sta cia2base+5
	LoadB cia2base+13, $81
	LoadB cia2base+14, 1
	jmp $401C
NMIHandler:
	lda cia2base+13
	dec L0E00+$28
	bne @3
	lda #1
	sta L0E00+$28
	ldy L0E00+$2C
	inc L0E00+$2C
	lda L0E00+$00,y
	bne @2
	lda #$7F
	sta cia2base+13
	ldx #2
@1:	lda L0E00+$29,x
	sta BASICspace,x
	dex
	bpl @1
	lda #$0D
@2:	sta $034A
	lda #$01
	sta $D0
@3:	jmp $FF33 ; C128 return from interrupt
ContCodeEnd:
