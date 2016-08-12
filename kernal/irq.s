; GEOS KERNAL
;
; IRQ/NMI handlers

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"

; keyboarddrv.s
.import _DoKeyboardScan

.segment "irq"

_IRQHandler:
	cld
	sta tempIRQAcc
	pla
	pha
	and #%00010000
	beq IRQHand1
	pla
	jmp (BRKVector)

IRQHand1:
	txa
	pha
	tya
	pha
.if (use2MHz)
	LoadB clkreg, 0
.endif
	PushW CallRLo
	PushW returnAddress
	ldx #0
IRQHand2:
	lda r0,x
	pha
	inx
	cpx #32
	bne IRQHand2
	PushB CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda dblClickCount
	beq IRQHand3
	dec dblClickCount
IRQHand3:
	ldy KbdQueFlag
	beq IRQHand4
	iny
	beq IRQHand4
	dec KbdQueFlag
IRQHand4:
	jsr _DoKeyboardScan
	lda alarmWarnFlag
	beq IRQHand5
	dec alarmWarnFlag
IRQHand5:
	lda intTopVector
	ldx intTopVector+1
	jsr CallRoutine
	lda intBotVector
	ldx intBotVector+1
	jsr CallRoutine
	lda #1
	sta grirq
	PopB CPU_DATA
.if (use2MHz)
	lda #>IRQ2Handler
	sta $ffff
	lda #<IRQ2Handler
	sta $fffe
	LoadB rasreg, $fc
.endif
	ldx #31
IRQHand6:
	pla
	sta r0,x
	dex
	bpl IRQHand6
	PopW returnAddress
	PopW CallRLo
	pla
	tay
	pla
	tax
	lda tempIRQAcc
_NMIHandler:
	rti
.if (use2MHz)
IRQ2Handler:
	pha
	txa
	pha
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda rasreg
	and #%11110000
	beq IRQ2BordOK
	cmp #$f0
	bne IRQ2NoBord
IRQ2BordOK:
	LoadB clkreg, 1
IRQ2NoBord:
	LoadB rasreg, $2c
	LoadW $fffe, _IRQHandler
	inc grirq
	stx CPU_DATA
	pla
	tax
	pla
	rti
.endif
