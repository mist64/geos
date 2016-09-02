.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "jumptab.inc"

.segment "reu10"

L4000 = $4000
L4003 = $4003
L903C = $903C
L9050 = $9050
L9053 = $9053
L9063 = $9063
L9D80 = $9D80
L9D83 = $9D83
LC313 = $C313
LCFD9 = $CFD9
.import TempCurDrive

NewDesktop              =       $5000
	jmp L5021
OEnterDesktop           =       $5003
	lda #$00
	.byte $2c
InstallDriver           =       $5006
	lda #$80
	.byte $2c
FindDesktop             =       $5009
	lda #$03
	.byte $2c
FindAFile               =       $500c
	lda #$06
	tax
	bmi L5034
	pha
	jsr i_MoveData
L5015:	.addr L5137
	.addr PRINTBASE
	.word $045B
	ldx #$79
	pla
	jmp CallRoutine

L5021:	lda #$C3
	sta r1H
	lda #$CF
	sta r1L
	lda #$00
	sta r2H
	lda #$09
	sta r2L
	jmp MoveData

L5034:	lda $8416
	cmp #$09
	beq L506D
	cmp #$0A
	beq L5042
	ldx #$05
L5041:	rts

L5042:	lda $8402
	sta r1H
	lda $8401
	sta r1L
	lda #$FE
	sta r7H
	lda #$80
	sta r7L
	lda #$01
	sta r2H
	lda #$7A
	sta r2L
	jsr L5195
	txa
	bne L5041
	lda #$88
	sta r2H
	lda #$CB
	sta r2L
	jmp L5112

L506D:	lda #$84
	sta r9H
	lda #$00
	sta r9L
	jsr GetFHdrInfo
	txa
	bne L5041
	ldx curDrive
	lda L5127,x
	sta r0L
	lda L512B,x
	sta r0H
	lda #$84
	sta r2H
	lda #$76
	sta r2L
	ldx #$02
	ldy #$06
	lda #$12
	jsr CopyFString
	ldy #$90
	lda #$81
	sta r0H
	lda #$F7
	sta r1H
	lda #$01
	sta r2H
	lda #$00
	sta r0L
	sta r1L
	sta r2L
	jsr L5103
	lda $8402
	sta r1H
	.byte $AD
	.byte $01
L50B9:	sty DTOP_CHAIN
	.byte $04
	lda #$79
	sta r7H
	lda #$00
	sta r7L
	lda #$06
	sta r2H
	lda #$40
	sta r2L
	jsr L5195
	txa
	bne L5102
	ldy #$90
	lda #$79
	sta r0H
	lda #$F8
	sta r1H
	lda #$00
	sta r0L
	sta r1L
	lda #$06
	sta r2H
	lda #$40
	sta r2L
	jsr L5103
	lda #$84
	sta r2H
	lda #$65
	sta r2L
	jsr L5112
	lda $88C4
	ora #$10
	sta $88C4
	ldx #$00
L5102:	rts

L5103:	lda $88C3
	sta r3L
	inc $88C3
	jsr DoRAMOp
	dec $88C3
	rts

L5112:	ldy #$00
	lda $8403,y
	cmp #$A0
	beq L512A
	and #$7F
	cmp #$20
	bcs L5123
	lda #$3F
L5123:	sta (r2L),y
	iny
	.byte $C0
L5127:	bpl L50B9
	nop
L512A:	.byte $A9
L512B:	brk
	sta (r2L),y
	rts

	asl $DC30,x
	inc $8484
	dey
	dey
L5137:	jmp $7909

	jmp $79C9

	jmp $79BC

	sei
	cld
	lda #$C0
	sta dispBufferOn
	bit $88C5
	bpl L5160
	lda curDrive
	jsr SetDevice
	bne L5177
	lda $88C6
	bmi L5168
	and #$F0
	cmp #$30
	beq L5168
	bne L5177
L5160:	lda TempCurDrive
	jsr SetDevice
	bne L5177
L5168:	jsr NewDisk
	bne L5177
	jsr GetDirHead
	bne L5177
	jsr $7D2A
	beq L518A
L5177:	lda #$00
	sta r4L
	jsr $79C9
	lda $886B
	bpl L518A
	jsr $7C9E
	bcc L5177
	bcs L518F
L518A:	jsr $7B11
	bcc L5177
L518F:	ldx #$FF
	stx $88C5
	rts

L5195:	jsr InitForIO
	lda #$80
	sta r4H
	lda #$00
	sta r4L
L51A0:	jsr ReadBlock
	bne L51F0
	ldy #$FE
	lda diskBlkBuf
	bne L51B4
	ldy $8001
	beq L51E2
	dey
	beq L51E2
L51B4:	lda r2H
	bne L51C2
	cpy r2L
	bcc L51C2
	beq L51C2
	ldx #$0B
	bne L51F0
L51C2:	sty r1L
L51C4:	lda $8001,y
	dey
	sta (r7L),y
	bne L51C4
	lda r1L
	clc
	adc r7L
	sta r7L
	bcc L51D7
	inc r7H
L51D7:	lda r2L
	sec
	sbc r1L
	sta r2L
	bcs L51E2
	dec r2H
L51E2:	lda $8001
	sta r1H
	lda diskBlkBuf
	sta r1L
	bne L51A0
	ldx #$00
L51F0:	jmp DoneWithIO

	lda r6H
	sta $7C67
	lda r6L
	sta $7C66
	lda #$80
	bit a:$A9
	sta $7C68
	lda #$00
	sta $886B
	lda r4L
	sta $7A37
L520F:	lda #$80
	sta $7A38
L5214:	ldy #$08
	sty $7A39
L5219:	lda $8486,y
	beq L5229
	eor $7A38
	bmi L5229
	jsr $7AA9
	bcc L5229
	rts

L5229:	inc $7A39
	ldy $7A39
	cpy #$0C
	bcc L5219
	lda $7A38
	eor #$80
	sta $7A38
	bmi L5248
	jsr $7A97
	bcs L5247
	jsr $7B57
	bcc L5214
L5247:	rts

L5248:	bit $7C68
	bmi L5247
	bit $7A37
	bmi L5247
	jsr $7A3A
	lda #$08
	sta $7A39
L525A:	jsr SetDevice
	bne L5262
	jsr OpenDisk
L5262:	inc $7A39
	lda $7A39
	cmp #$0C
	bcc L525A
	bcs L520F
	brk
	brk
	brk
	jsr $7A85
	lda #$08
	sta r1L
	lda #$04
	sta r1H
	lda #$18
	sta r2L
	lda #$0C
	sta r2H
	lda $9FE1
	sta r4H
	jsr LC313
	lda $84B2
	sta $7A84
	lda RecoverVector
	sta $7A83
	lda #$7A
	sta $84B2
	lda #$8E
	sta RecoverVector
	lda #$7C
	sta r0H
	lda #$96
	sta r0L
	jsr DoDlgBox
	lda $7A84
	sta $84B2
	lda $7A83
	sta RecoverVector
	rts

	brk
	brk
	jsr LCFD9
	jsr L4000
	jmp LCFD9

	jsr LCFD9
	jsr L4003
	jmp LCFD9

	ldy #$08
L52D0:	lda $8486,y
	and #$F0
	cmp #$30
	beq L52E0
	iny
	cpy #$0C
	bcc L52D0
	clc
	rts

L52E0:	tya
	and #$7F
	jsr SetDevice
	bne L5346
	jsr NewDisk
	txa
	bne L5346
	jsr GetDirHead
	bne L5346
	jsr $7D2A
	bne L5300
	lda curDrive
	sta $886B
	sec
	rts

L5300:	lda $88C6
	and #$0F
	cmp #$04
	bne L5346
	lda $905C
	cmp #$01
	bne L5315
	cmp $905D
	beq L5346
L5315:	lda $905D
	pha
	lda $905C
	pha
	lda #$01
	sta $905C
	sta $905D
	jsr GetDirHead
	bne L533B
	jsr $7D2A
	bne L533B
	pla
	pla
	lda curDrive
	ora #$40
	sta $886B
	sec
	rts

L533B:	pla
	sta $905C
	pla
	sta $905D
	jsr GetDirHead
L5346:	clc
	rts

	sec
	lda #$00
	sbc r7L
	sta r2L
	lda #$79
	sbc r7H
	sta r2H
	lda $8402
	sta r1H
	lda $8401
	sta r1L
	lda $8146
	cmp #$01
	bne L5376
	jsr L903C
	txa
	bne L538C
	lda $8003
	sta r1H
	lda $8002
	sta r1L
L5376:	jsr $795E
	txa
	bne L538C
	lda #$00
	sta r0L
	lda $814C
	sta r7H
	lda $814B
	sta r7L
	sec
	rts

L538C:	clc
	rts

	lda $886A
	and #$F0
	beq L539D
	cmp #$40
	bcc L539F
	cmp #$80
	beq L539F
L539D:	clc
	rts

L539F:	sta $7D13
	lda TempCurDrive
	jsr SetDevice
	bne L53B5
	jsr $7BD8
	bcc L53B5
	jsr $7BA4
	bcc L53B5
	rts

L53B5:	lda #$08
	sta $7BA3
L53BA:	jsr SetDevice
	bne L53C9
	jsr $7BD8
	bcc L53C9
	jsr $7BA4
	bcs L53D9
L53C9:	inc $7BA3
	lda $7BA3
	cmp TempCurDrive
	beq L53C9
	cmp #$0C
	bcc L53BA
	clc
L53D9:	rts

	brk
	lda $905D
	sta $7D16
	lda $905C
	sta $7D15
	jsr L9063
	lda r2L
	sta $7D14
	cmp $8869
	bne L53FD
	lda $88C6
	and #$F0
	cmp #$10
	bne L540C
L53FD:	jsr $7CB7
	bcc L5403
L5402:	rts

L5403:	lda $88C6
	and #$F0
	cmp #$10
	bne L5402
L540C:	jmp $7CEC

	lda $7D13
	bpl L541F
	lda $88C6
	and #$F0
	cmp #$30
	bne L542B
L541D:	sec
	rts

L541F:	cmp #$30
	bne L542B
	lda $88C6
	and $9073
	bmi L541D
L542B:	lda $88C6
	and #$F0
	cmp $7D13
	beq L541D
	clc
	rts

	ldx #$01
	lda $7C67
	sta r6H
	lda $7C66
	sta r6L
	bit $7C68
	bmi L5478
	lda #$C3
	sta r6H
	lda #$CF
	sta r6L
	lda #$7C
	sta r2H
	lda #$69
	sta r2L
	ldx #$0E
	ldy #$06
	jsr CmpString
	bne L546C
	lda #$7C
	sta r6H
	lda #$85
	sta r6L
	ldx #$00
	.byte $2C
L546C:	ldx #$01
	lda $7C92,x
	sta r0L
	lda $7C94,x
	sta r0H
L5478:	stx $7C65
	rts

	jsr i_PutString
	.byte "P"
	.byte $00
	.byte "6Insert a disk with "


	.byte $00
	jsr $7C00
	jmp PutString

	.byte $00,$00,$00,$00
	.byte "DESKTOP"
	.byte $00
	.byte "Insert a disk with "


	.byte $00
	.byte "Dashboard 64"

	.byte $00
	.byte $85,$CF,$7C,$C3,$80,$13,$45,$7C
	.byte $01,$11,$48
	brk
	jsr $7B11
	php
	ldx $7D14
	jsr $7D17
	lda $7D16
	sta r1H
	lda $7D15
	sta r1L
	jsr L9053
	plp
	rts

	ldx $8869
	jsr $7D17
	jsr L9050
	jsr $7D2A
	bne L550E
	lda curDrive
	bit $7C68
	bmi L5507
	sta TempCurDrive
L5507:	ora #$80
	sta $886B
	sec
	rts

L550E:	ldx $7D14
	jsr $7D17
	lda $7D16
	sta r1H
	lda $7D15
	sta r1L
	jsr L9053
	clc
	rts

	jsr L9050
	jsr $7D2A
	bne L553B
	lda curDrive
	bit $7C68
	bmi L5536
	sta TempCurDrive
L5536:	sta $886B
	sec
	rts

L553B:	lda $7D16
	sta r1H
	lda $7D15
	sta r1L
	jsr L9053
	clc
	rts

	brk
	brk
	brk
	brk
	jsr L9D83
	lda #$45
	jsr L9D80
	jsr L5015+3
	jsr L9D83
	lda #$4A
	jmp L9D80

	jsr $7C00
	jsr FindFile
	txa
	bne L5591
	lda #$84
	sta r9H
	lda #$00
	sta r9L
	jsr GetFHdrInfo
	txa
	bne L5591
	ldx $7C65
	dex
	beq L5591
	lda $815A
	cmp #$35
	bcs L558F
	lda $815C
	cmp #$30
	bne L558F
	ldx #$05
	rts

L558F:	ldx #$00
L5591:	rts

