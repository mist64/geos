.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"
.include "diskdrv.inc"

.segment "loadb"

.ifdef wheels

L4000 = $4000
L4003 = $4003
L9050 = $9050
L9053 = $9053
L9063 = $9063
.import GetNewKernal
.import RstrKernal
LC313 = $C313
.import Swap4000
.import TempCurDrive
.import sysDBColor
.import DeskTopName

.import FindFile
.import PutString
.import i_PutString
.import CmpString
.import DoDlgBox
.import OpenDisk
.import DoneWithIO
.import ReadBlock
.import InitForIO
.import GetDirHead
.import NewDisk
.import SetDevice
.import DoRAMOp
.import CopyFString
.import GetFHdrInfo
.import MoveData
.import CallRoutine
.import i_MoveData

.global LoadDiskBlkBuf
.global OEnterDesktop

L5018 = $5018
L5195 = $5195

NewDesktop:
	jmp __NewDesktop
OEnterDesktop:
	lda #$00
	.byte $2c
InstallDriver:
	lda #$80
	.byte $2c
FindDesktop:
	lda #$03
	.byte $2c
FindAFile:
	lda #$06
	tax
	bmi L5034
	pha
	jsr i_MoveData
L5015:	.addr L5137
	.addr PRINTBASE
	.word code2_end - code2_start
	ldx #$79
	pla
	jmp CallRoutine

__NewDesktop:
	LoadW r1, DeskTopName
	LoadW r2, 9
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
	bnex L5041
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
	bnex L5041
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
	bnex L5102
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

L5103:	lda ramExpSize
	sta r3L
	inc ramExpSize
	jsr DoRAMOp
	dec ramExpSize
	rts

L5112:	ldy #$00
	lda $8403,y
	cmp #$A0
	beq L512A
	and #$7F
	cmp #$20
	bcs L5123
	lda #$3F
L5123:	sta (r2),y
	iny
	.byte $C0
L5127:	bpl L50B9
	nop
L512A:	.byte $A9
L512B:	.byte 0
	sta (r2),y
	rts

	asl $DC30,x
	inc $8484
	dey
	dey
L5137:


.org PRINTBASE
code2_start:
	jmp L7909

	jmp L79C9

	jmp L79BC

L7909:	sei
	cld
	lda #$C0
	sta dispBufferOn
	bit $88C5
	bpl L7929
	lda curDrive
	jsr SetDevice
	bne L7940
	lda curType
	bmi L7931
	and #$F0
	cmp #$30
	beq L7931
	bne L7940
L7929:	lda TempCurDrive
	jsr SetDevice
	bne L7940
L7931:	jsr NewDisk
	bne L7940
	jsr GetDirHead
	bne L7940
	jsr L7D2A
	beq L7953
L7940:	lda #$00
	sta r4L
	jsr L79C9
	lda $886B
	bpl L7953
	jsr L7C9E
	bcc L7940
	bcs L7958
L7953:	jsr L7B11
	bcc L7940
L7958:	ldx #$FF
	stx $88C5
	rts

L795E:	jsr InitForIO
	lda #$80
	sta r4H
	lda #$00
	sta r4L
L7969:	jsr ReadBlock
	bne L79B9
	ldy #$FE
	lda diskBlkBuf
	bne L797D
	ldy diskBlkBuf+1
	beq L79AB
	dey
	beq L79AB
L797D:	lda r2H
	bne L798B
	cpy r2L
	bcc L798B
	beq L798B
	ldx #$0B
	bne L79B9
L798B:	sty r1L
L798D:	lda diskBlkBuf+1,y
	dey
	sta (r7),y
	bne L798D
	lda r1L
	clc
	adc r7L
	sta r7L
	bcc L79A0
	inc r7H
L79A0:	lda r2L
	sec
	sbc r1L
	sta r2L
	bcs L79AB
	dec r2H
L79AB:	lda diskBlkBuf+1
	sta r1H
	lda diskBlkBuf
	sta r1L
	bne L7969
	ldx #$00
L79B9:	jmp DoneWithIO

L79BC:	lda r6H
	sta L7C67
	lda r6L
	sta L7C66
	lda #$80
	.byte $2C
L79C9:	lda #$00
	sta L7C68
	lda #$00
	sta $886B
	lda r4L
	sta L7A37
L79D8:	lda #$80
	sta L7A38
L79DD:	ldy #$08
	sty L7A39
L79E2:	lda _driveType,y
	beq L79F2
	eor L7A38
	bmi L79F2
	jsr L7AA9
	bcc L79F2
	rts

L79F2:	inc L7A39
	ldy L7A39
	cpy #$0C
	bcc L79E2
	lda L7A38
	eor #$80
	sta L7A38
	bmi L7A11
	jsr L7A97
	bcs L7A10
	jsr L7B57
	bcc L79DD
L7A10:	rts

L7A11:	bit L7C68
	bmi L7A10
	bit L7A37
	bmi L7A10
	jsr L7A3A
	lda #$08
	sta L7A39
L7A23:	jsr SetDevice
	bne L7A2B
	jsr OpenDisk
L7A2B:	inc L7A39
	lda L7A39
	cmp #$0C
	bcc L7A23
	bcs L79D8

L7A37:	.byte 0
L7A38:	.byte 0
L7A39:	.byte 0

L7A3A:	jsr L7A85
	lda #$08
	sta r1L
	lda #$04
	sta r1H
	lda #$18
	sta r2L
	lda #$0C
	sta r2H
	lda sysDBColor
	sta r4H
	jsr LC313
	lda $84B2
	sta L7A84
	lda RecoverVector
	sta L7A83
	lda #$7A
	sta $84B2
	lda #$8E
	sta RecoverVector
	lda #$7C
	sta r0H
	lda #$96
	sta r0L
	jsr DoDlgBox
	lda L7A84
	sta $84B2
	lda L7A83
	sta RecoverVector
	rts

L7A83:	.byte 0
L7A84:	.byte 0

L7A85:	jsr Swap4000
	jsr L4000
	jmp Swap4000

	jsr Swap4000
	jsr L4003
	jmp Swap4000

L7A97:	ldy #$08
L7A99:	lda _driveType,y
	and #$F0
	cmp #$30
	beq L7AA9
	iny
	cpy #$0C
	bcc L7A99
	clc
	rts

L7AA9:	tya
	and #$7F
	jsr SetDevice
	bne L7B0F
	jsr NewDisk
	bnex L7B0F
	jsr GetDirHead
	bne L7B0F
	jsr L7D2A
	bne L7AC9
	lda curDrive
	sta $886B
	sec
	rts

L7AC9:	lda curType
	and #$0F
	cmp #$04
	bne L7B0F
	lda $905C
	cmp #$01
	bne L7ADE
	cmp $905D
	beq L7B0F
L7ADE:	PushW $905C
	lda #$01
	sta $905C
	sta $905D
	jsr GetDirHead
	bne L7B04
	jsr L7D2A
	bne L7B04
	pla
	pla
	lda curDrive
	ora #$40
	sta $886B
	sec
	rts

L7B04:	PopW $905C
	jsr GetDirHead
L7B0F:	clc
	rts

L7B11:	sec
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
	lda fileHeader+O_GHSTR_TYPE
	cmp #$01
	bne L7B3F
	jsr ReadBuff
	bnex L7B55
	lda diskBlkBuf+3
	sta r1H
	lda diskBlkBuf+2
	sta r1L
L7B3F:	jsr L795E
	bnex L7B55
	LoadB r0L, 0
	MoveW fileHeader+O_GHST_VEC, r7
	sec
	rts

L7B55:	clc
	rts

L7B57:	lda $886A
	and #$F0
	beq L7B66
	cmp #$40
	bcc L7B68
	cmp #$80
	beq L7B68
L7B66:	clc
	rts

L7B68:	sta L7D13
	lda TempCurDrive
	jsr SetDevice
	bne L7B7E
	jsr L7BD8
	bcc L7B7E
	jsr L7BA4
	bcc L7B7E
	rts

L7B7E:	lda #$08
	sta L7BA3
L7B83:	jsr SetDevice
	bne L7B92
	jsr L7BD8
	bcc L7B92
	jsr L7BA4
	bcs L7BA2
L7B92:	inc L7BA3
	lda L7BA3
	cmp TempCurDrive
	beq L7B92
	cmp #$0C
	bcc L7B83
	clc
L7BA2:	rts

L7BA3:	.byte 0

L7BA4:	lda $905D
	sta L7D16
	lda $905C
	sta L7D15
	jsr L9063
	lda r2L
	sta L7D14
	cmp $8869
	bne L7BC6
	lda curType
	and #$F0
	cmp #$10
	bne L7BD5
L7BC6:	jsr L7CB7
	bcc L7BCC
L7BCB:	rts

L7BCC:	lda curType
	and #$F0
	cmp #$10
	bne L7BCB
L7BD5:	jmp L7CEC

L7BD8:	lda L7D13
	bpl L7BE8
	lda curType
	and #$F0
	cmp #$30
	bne L7BF4
L7BE6:	sec
	rts

L7BE8:	cmp #$30
	bne L7BF4
	lda curType
	and $9073
	bmi L7BE6
L7BF4:	lda curType
	and #$F0
	cmp L7D13
	beq L7BE6
	clc
	rts

L7C00:	ldx #$01
	lda L7C67
	sta r6H
	lda L7C66
	sta r6L
	bit L7C68
	bmi L7C41
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
	bne L7C35
	lda #$7C
	sta r6H
	lda #$85
	sta r6L
	ldx #$00
	.byte $2C
L7C35:	ldx #$01
	lda L7C92,x
	sta r0L
	lda L7C94,x
	sta r0H
L7C41:	stx L7C65
	rts

	jsr i_PutString
	.byte "P"
	.byte $00
	.byte "6Insert a disk with "


	.byte $00
	jsr L7C00
	jmp PutString

L7C65:	.byte 0
L7C66:	.byte 0
L7C67:	.byte 0
L7C68:	.byte 0

	.byte "DESKTOP", 0
	.byte "Insert a disk with ", 0
	.byte "Dashboard 64", 0

L7C92:	.byte $85,$CF
L7C94:	.byte $7C,$C3,$80,$13,$45,$7C,$01,$11
	.byte $48,$00

L7C9E:	jsr L7B11
	php
	ldx L7D14
	jsr L7D17
	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	plp
	rts

L7CB7:	ldx $8869
	jsr L7D17
	jsr L9050
	jsr L7D2A
	bne L7CD7
	lda curDrive
	bit L7C68
	bmi L7CD0
	sta TempCurDrive
L7CD0:	ora #$80
	sta $886B
	sec
	rts

L7CD7:	ldx L7D14
	jsr L7D17
	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	clc
	rts

L7CEC:	jsr L9050
	jsr L7D2A
	bne L7D04
	lda curDrive
	bit L7C68
	bmi L7CFF
	sta TempCurDrive
L7CFF:	sta $886B
	sec
	rts

L7D04:	lda L7D16
	sta r1H
	lda L7D15
	sta r1L
	jsr L9053
	clc
	rts

L7D13:	.byte 0
L7D14:	.byte 0
L7D15:	.byte 0
L7D16:	.byte 0

L7D17:	jsr RstrKernal
	lda #$45
	jsr GetNewKernal
	jsr L5018
	jsr RstrKernal
	lda #$4A
	jmp GetNewKernal

L7D2A:	jsr L7C00
	jsr FindFile
	bnex L7D5A
	LoadW r9, dirEntryBuf
	jsr GetFHdrInfo
	bnex L7D5A
	ldx L7C65
	dex
	beq L7D5A
	lda fileHeader+O_GHFNAME+13
	cmp #'5'
	bcs L7D58
	lda fileHeader+O_GHFNAME+15
	cmp #'0'
	bne L7D58
	ldx #$05
	rts

L7D58:	ldx #$00
L7D5A:	rts

code2_end:

.endif
