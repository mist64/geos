; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Commodore 1581 disk driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

.segment "drv1581"

DriveAddy = $0300

dir3Head	= $9c80

_InitForIO:
	.word __InitForIO
_DoneWithIO:
	.word __DoneWithIO
_ExitTurbo:
	.word __ExitTurbo
_PurgeTurbo:
	.word __PurgeTurbo
_EnterTurbo:
	.word __EnterTurbo
_ChangeDiskDevice:
	.word __ChangeDiskDevice
_NewDisk:
	.word __NewDisk
_ReadBlock:
	.word __ReadBlock
_WriteBlock:
	.word __WriteBlock
_VerWriteBlock:
	.word __VerWriteBlock
_OpenDisk:
	.word __OpenDisk
_GetBlock:
	.word __GetBlock
_PutBlock:
	.word __PutBlock
_GetDirHead:
	.word __GetDirHead
_PutDirHead:
	.word __PutDirHead
_GetFreeDirBlk:
	.word __GetFreeDirBlk
_CalcBlksFree:
	.word __CalcBlksFree
_FreeBlock:
	.word __FreeBlock
_SetNextFree:
	.word __SetNextFree
_FindBAMBit:
	.word __FindBAMBit
_NxtBlkAlloc:
	.word __NxtBlkAlloc
_BlkAlloc:
	.word __BlkAlloc
_ChkDkGEOS:
	.word __ChkDkGEOS
_SetGEOSDisk:
	.word __SetGEOSDisk

Get1stDirEntry:
	jmp _Get1stDirEntry
GetNxtDirEntry:
	jmp _GetNxtDirEntry
GetBorder:
	jmp _GetBorder
AddDirBlock:
	jmp _AddDirBlock
ReadBuff:
	jmp _ReadBuff
WriteBuff:
	jmp _WriteBuff
	jmp DUNK4_2
	jmp GetDOSError
AllocateBlock:
	jmp _AllocateBlock
ReadLink:
	jmp _ReadLink

E904E:
	.byte $03

__GetDirHead:
	jsr SetDirHead_1
	jsr __GetBlock
	bne GDH_0
	jsr SetDirHead_2
	jsr __GetBlock
	bne GDH_0
	jsr SetDirHead_3
	bne __GetBlock
GDH_0:
	rts

_ReadBuff:
	LoadW r4, diskBlkBuf
__GetBlock:
	jsr EnterTurbo
	bne GetBlk0
	jsr InitForIO
	jsr ReadBlock
	jsr DoneWithIO
GetBlk0:
	txa
	rts

__PutDirHead:
	jsr SetDirHead_1
	jsr __PutBlock
	bne PDH_0
	jsr SetDirHead_2
	jsr __PutBlock
	bne PDH_0
	jsr SetDirHead_3
	bne __PutBlock
PDH_0:
	rts

_WriteBuff:
	LoadW r4, diskBlkBuf
__PutBlock:
	jsr EnterTurbo
	bne PutBlk1
	jsr InitForIO
	jsr WriteBlock
	bnex PutBlk0
	jsr VerWriteBlock
PutBlk0:
	jsr DoneWithIO
PutBlk1:
	txa
	rts

SetDirHead_1:
	ldx #>curDirHead
	ldy #<curDirHead
	lda #0
	beq SDH_1
SetDirHead_2:
	ldx #>dir2Head
	ldy #<dir2Head
	lda #1
	bne SDH_1
SetDirHead_3:
	ldx #>dir3Head
	ldy #<dir3Head
	lda #2
SDH_1:
	stx r4H
	sty r4L
	sta r1H
	lda #40
	sta r1L
	rts

CheckParams:
	bbrf 6, curType, CheckParams_1
	jsr DoCacheVerify
	beq CheckParams_2
CheckParams_1:
	lda #0
	sta errCount
	ldx #INV_TRACK
	lda r1L
	beq CheckParams_2
	cmp #81
	bcs CheckParams_2
	sec
	rts
CheckParams_2:
	clc
	rts

__OpenDisk:
	ldy curDrive
	lda _driveType,y
	sta tmpDriveType
	and #%10111111
	sta _driveType,y
	jsr NewDisk
	bnex OpenDsk1
	jsr GetDirHead
	bnex OpenDsk1
	bbrf 6, tmpDriveType, OpenDsk10
	jsr SetDirHead_1
	jsr DoCacheVerify
	bne OpenDsk0
	jsr SetDirHead_2
	jsr DoCacheVerify
	beq OpenDsk10
OpenDsk0:
	jsr DoClearCache
	jsr SetDirHead_1
	jsr DoCacheWrite
	jsr SetDirHead_2
	jsr DoCacheWrite
	jsr SetDirHead_3
	jsr DoCacheWrite
OpenDsk10:
	jsr SetCurDHVec

	jsr ChkDkGEOS
	LoadW r4, curDirHead+OFF_DISK_NAME
	ldx #r5
	jsr GetPtrCurDkNm
	ldx #r4
	ldy #r5
	lda #18
	jsr CopyFString
	ldx #0
OpenDsk1:
	ldy curDrive
	lda tmpDriveType
	sta _driveType,y
	rts

__BlkAlloc:
	PopW r3 ;!!!hint???
	PushW r3
	SubW SaveFile+1, r3
	ldy #$27
	lda r3H
	beq E917E
	ldy #$23
E917E:
	sty r3L
	ldy #0
	sty r3H
	lda #2
	bne E918A
__NxtBlkAlloc:
	lda #0
E918A:
	sta E9C64

	PushW r9
	PushW r3
	LoadW r3, $00fe
	ldx #r2
	ldy #r3
	jsr Ddiv
	lda r8L
	beq BlkAlc0
	inc r2L
	bne *+4
	inc r2H
BlkAlc0:
	jsr SetCurDHVec
	jsr CalcBlksFree
	PopW r3
	ldx #INSUFF_SPACE
	CmpW r2, r4
	beq BlkAlc1
	bcs BlkAlc4
BlkAlc1:
	MoveW r6, r4
	MoveW r2, r5
BlkAlc2:
	jsr SetNextFree
	bnex BlkAlc4
	ldy #0
	lda r3L
	sta (r4),y
	iny
	lda r3H
	sta (r4),y
	AddVW 2, r4
	lda E9C64
	beq BlkAlc2_1
	dec E9C64
	bne BlkAlc2_1
	LoadB r3L, $23
BlkAlc2_1:
	lda r5L
	bne *+4
	dec r5H
	dec r5L
	lda r5L
	ora r5H
	bne BlkAlc2
	ldy #0
	tya
	sta (r4),y
	iny
	lda r8L
	bne BlkAlc3
	lda #$fe
BlkAlc3:
	clc
	adc #1
	sta (r4),y
	ldx #0
BlkAlc4:
	PopW r9
	rts

SetCurDHVec:
	LoadW r5, curDirHead
	rts

_Get1stDirEntry:
	jsr SetDirHead_3
	inc r1H
	LoadB borderFlag, 0
	beq GNDirEntry0

_GetNxtDirEntry:
	ldx #0
	ldy #0
	AddVW $20, r5
	CmpWI r5, diskBlkBuf+$ff
	bcc GNDirEntry1
	ldy #$ff
	MoveW diskBlkBuf, r1
	bne GNDirEntry0
	lda borderFlag
	bne GNDirEntry1
	lda #$ff
	sta borderFlag
	jsr GetBorder
	bnex GNDirEntry1
	tya
	bne GNDirEntry1
GNDirEntry0:
	jsr ReadBuff
	ldy #0
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
GNDirEntry1:
	rts

_GetBorder:
	jsr GetDirHead
	bnex GetBord2
	jsr SetCurDHVec
	jsr ChkDkGEOS
	bne GetBord0
	ldy #$ff
	bne GetBord1
GetBord0:
	MoveW curDirHead+OFF_OP_TR_SC, r1
	ldy #0
GetBord1:
	ldx #0
GetBord2:
	rts

__ChkDkGEOS:
	ldy #OFF_GS_ID
	ldx #0
	stx isGEOS
ChkDkG0:
	lda (r5),y
	cmp GEOSDiskID,x
	bne ChkDkG1
	iny
	inx
	cpx #11
	bne ChkDkG0
	LoadB isGEOS, $ff
ChkDkG1:
	lda isGEOS
	rts

GEOSDiskID:
	.byte "GEOS format V1.0",NULL

__GetFreeDirBlk:
	php
	sei
	PushB r6L
	PushW r2
	ldx r10L
	inx
	stx r6L
	LoadB r1L, DIR_1581_TRACK
	LoadB r1H, 3
GFDirBlk0:
	jsr ReadBuff
GFDirBlk1:
	bnex GFDirBlk5
	dec r6L
	beq GFDirBlk3
GFDirBlk11:
	lda diskBlkBuf
	bne GFDirBlk2
	jsr AddDirBlock
	bra GFDirBlk1
GFDirBlk2:
	sta r1L
	MoveB diskBlkBuf+1, r1H
	bra GFDirBlk0
GFDirBlk3:
	ldy #FRST_FILE_ENTRY
	ldx #0
GFDirBlk4:
	lda diskBlkBuf,y
	beq GFDirBlk5
	tya
	addv $20
	tay
	bcc GFDirBlk4
	LoadB r6L, 1
	ldx #FULL_DIRECTORY
	ldy r10L
	iny
	sty r10L
	cpy #$12
	bcc GFDirBlk11
GFDirBlk5:
	PopW r2
	PopB r6L
	plp
	rts

_AddDirBlock:
	PushW r6
	ldx #4
	lda dir2Head+$fa
	beq ADirBlk0
	MoveW r1, r3
	jsr SetNextFree
	MoveW r3, diskBlkBuf
	jsr WriteBuff
	bnex ADirBlk0
	MoveW r3, r1
	jsr ClearAndWrite
ADirBlk0:
	PopW r6
	rts

ClearAndWrite:
	lda #0
	tay
CAndWr0:
	sta diskBlkBuf,y
	iny
	bne CAndWr0
	dey
	sty diskBlkBuf+1
	jmp WriteBuff

__SetNextFree:
	jsr SNF_1
	bne SNF_0
	rts
SNF_0:
	LoadB r3L, $27
SNF_1:
	lda r3H
	addv 1
	sta r6H
	MoveB r3L, r6L
	cmp #DIR_1581_TRACK
	beq SNF_3
SNF_2:
	lda r6L
	cmp #DIR_1581_TRACK
	beq SNF_8
SNF_3:
	cmp #DIR_1581_TRACK+1
	bcc SNF_4
	subv DIR_1581_TRACK
SNF_4:
	subv $01
	asl
	sta r7L
	asl
	clc
	adc r7L
	tax
	CmpBI r6L, DIR_1581_TRACK+1
	bcc SNF_5
	lda dir3Head+$10,x
	bra SNF_6
SNF_5:
	lda dir2Head+$10,x
SNF_6:
	beq SNF_8
	LoadB r7L, DIR_1581_TRACK
	tay
SNF_7:
	jsr SNxtFreeHelp
	beq SNF_11
	inc r6H
	dey
	bne SNF_7
SNF_8:
	CmpBI r6L, DIR_1581_TRACK+1
	bcs SNF_9
	dec r6L
	bne SNF_10
	LoadB r6L, DIR_1581_TRACK+1
	bne SNF_10
SNF_9:
	inc r6L
SNF_10:
	CmpBI r6L, $51
	bcs SNF_12
	LoadB r6H, 0
	beq SNF_2
SNF_11:
	MoveW r6, r3
	ldx #0
	rts
SNF_12:
	ldx #INSUFF_SPACE
	rts

SNxtFreeHelp:
	lda r6H
SNFHlp_1:
	cmp r7L
	bcc SNFHlp_2
	sub r7L
	bra SNFHlp_1
SNFHlp_2:
	sta r6H

_AllocateBlock:
	jsr FindBAMBit
	bne AllBlk_0
	ldx #BAD_BAM
	rts
AllBlk_0:
	php
	CmpBI r6L, DIR_1581_TRACK+1
	bcc AllBlk_2
	lda r8H
	eor dir3Head+$10,x
	sta dir3Head+$10,x
	ldx r7H
	plp
	beq AllBlk_1
	dec dir3Head+$10,x
	bra AllBlk_4
AllBlk_1:
	inc dir3Head+$10,x
	bra AllBlk_4
AllBlk_2:
	lda r8H
	eor dir2Head+$10,x
	sta dir2Head+$10,x
	ldx r7H
	plp
	beq AllBlk_3
	dec dir2Head+$10,x
	bra AllBlk_4
AllBlk_3:
	inc dir2Head+$10,x
AllBlk_4:
	ldx #0
	rts

__FreeBlock:
	jsr FindBAMBit
	beq AllBlk_0
	ldx #BAD_BAM
	rts

__FindBAMBit:
	lda r6H
	and #%00000111
	tax
	lda FBBBitTab,x
	sta r8H
	CmpBI r6L, DIR_1581_TRACK+1
	bcc FBB_1
	subv DIR_1581_TRACK
FBB_1:
	subv $1
	asl
	sta r7H
	asl
	add r7H
	sta r7H
	lda r6H
	lsr
	lsr
	lsr
	sec
	adc r7H
	tax
	CmpBI r6L, DIR_1581_TRACK+1
	bcc FBB_2
	lda dir3Head+$10,x
	and r8H
	rts
FBB_2:
	lda dir2Head+$10,x
	and r8H
	rts

FBBBitTab:
	.byte $01, $02, $04, $08
	.byte $10, $20, $40, $80

__CalcBlksFree:
	LoadW r4, 0
	ldy #$10
CBlksFre0:
	lda dir2Head,y
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre1:
	tya
	addv 6
	tay
	cpy #$FA
	beq CBlksFre1
	cpy #$00
	bne CBlksFre0
	ldy #$10
CBlksFre2:
	lda dir3Head,y
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre3:
	tya
	addv 6
	tay
	bne CBlksFre2
	LoadW r3, $0c58
	rts

__SetGEOSDisk:
	jsr GetDirHead
	bnex SetGDisk2
	jsr SetCurDHVec
	jsr CalcBlksFree
	ldx #INSUFF_SPACE
	lda r4L
	ora r4H
	beq SetGDisk2
	LoadB r3L, DIR_1581_TRACK
	LoadB r3H, $12
	jsr SetNextFree
	bnex SetGDisk2
	MoveW r3, r1
	jsr ClearAndWrite
	bnex SetGDisk2
	MoveW r1, curDirHead+OFF_OP_TR_SC
	ldy #OFF_GS_ID+15
	ldx #15
SetGDisk1:
	lda GEOSDiskID,x
	sta curDirHead,y
	dey
	dex
	bpl SetGDisk1
	jsr PutDirHead
SetGDisk2:
	rts


__InitForIO:
	php
	pla
	sta tmpPS
	sei
	lda CPU_DATA
	sta tmpCPU_DATA
.ifdef bsw128
	LoadB CPU_DATA, KRNL_IO_IN
.endif
	lda grirqen
	sta tmpgrirqen
	lda clkreg
	sta tmpclkreg
	ldy #0
	sty clkreg
	sty grirqen
	lda #%01111111
	sta grirq
	sta cia1base+13
	sta cia2base+13
	lda #>D_IRQHandler
	sta irqvec+1
.ifdef bsw128
	sta nmivec+1
.endif
	lda #<D_IRQHandler
	sta irqvec
.ifndef bsw128
	lda #>D_NMIHandler
	sta nmivec+1
	lda #<D_NMIHandler
.endif
	sta nmivec
	lda #%00111111
	sta cia2base+2
	lda mobenble
	sta tmpmobenble
	sty mobenble
	sty cia2base+5
	iny
	sty cia2base+4
	LoadB cia2base+13, %10000001
	LoadB cia2base+14, %00001001
	ldy #$2c
IniForIO0:
	lda rasreg
	cmp TURBO_DD00_CPY
	beq IniForIO0
	sta TURBO_DD00_CPY
	dey
	bne IniForIO0
	lda cia2base
	and #%00000111
	sta TURBO_DD00
	ora #%00110000
	sta TURBO_DD00_CPY
	lda TURBO_DD00
	ora #%00010000
	sta tmpDD00
	ldy #$1f
IniForIO1:
	lda NibbleTab2,y
	and #$f0
	ora TURBO_DD00
	sta NibbleTab2,y
	dey
	bpl IniForIO1
	rts

D_IRQHandler:
.ifdef bsw128
	PopB $ff00
.endif
	pla
	tay
	pla
	tax
	pla
D_NMIHandler:
	rti

__DoneWithIO:
	sei
	lda tmpclkreg
	sta clkreg
	lda tmpmobenble
	sta mobenble
	LoadB cia2base+13, %01111111
	lda cia2base+13
	lda tmpgrirqen
	sta grirqen
.ifndef bsw128
	lda tmpCPU_DATA
	sta CPU_DATA
.endif
	lda tmpPS
	pha
	plp
	rts

SendDOSCmd:
	stx z8c
	sta z8b
	LoadB STATUS, 0
	lda curDrive
	jsr $ffb1
	bbsf 7, STATUS, SndDOSCmd1
	lda #$ff
	jsr $ff93
	bbsf 7, STATUS, SndDOSCmd1
	ldy #0
SndDOSCmd0:
	lda (z8b),y
	jsr $ffa8
	iny
	cpy #5
	bcc SndDOSCmd0
	ldx #0
	rts
SndDOSCmd1:
	jsr $ffae
	ldx #DEV_NOT_FOUND
	rts

__EnterTurbo:
	lda curDrive
	jsr SetDevice
	ldx curDrive
	lda _turboFlags,x
	bmi EntTur0
	jsr SendCODE
	bnex EntTur5
	ldx curDrive
	lda #%10000000
	sta _turboFlags,x
EntTur0:
	and #%01000000
	bne EntTur3
	jsr InitForIO
	ldx #>EnterCommand
	lda #<EnterCommand
	jsr SendDOSCmd
	bnex EntTur4
	jsr $ffae
	sei
	ldy #$21
EntTur1:
	dey
	bne EntTur1
	jsr Hst_RecvByte_3
EntTur2:
	bbsf 7, cia2base, EntTur2
	jsr DoneWithIO
	ldx curDrive
	lda _turboFlags,x
	ora #%01000000
	sta _turboFlags,x
EntTur3:
	ldx #0
	beq EntTur5
EntTur4:
	jsr DoneWithIO
EntTur5:
	txa
	rts

EnterCommand:
	.byte "M-E"
	.word DriveStart

SendExitTurbo:
	jsr InitForIO
	ldx #>Drv_ExitTurbo
	lda #<Drv_ExitTurbo
	jsr DUNK4
	ldx #>E0457
	lda #<E0457
	jsr DUNK4
	jsr GetSync
E9685:
	lda curDrive
	jsr $ffb1
	lda #$ef
	jsr $ff93
	jsr $ffae
	ldx #0
	jmp DoneWithIO

SendCODE:
	jsr InitForIO
	lda #>DriveCode
	sta z8e
	lda #<DriveCode
	sta z8d
	lda #>DriveAddy
	sta WriteAddy+1
	lda #<DriveAddy
	sta WriteAddy
	LoadB z8f, $0f
SndCDE0:
	jsr SendCHUNK
	bnex SndCDE1
	clc
	lda #$20
	adc z8d
	sta z8d
	bcc *+4
	inc z8e
	clc
	lda #$20
	adc WriteAddy
	sta WriteAddy
	bcc *+5
	inc WriteAddy+1
	dec z8f
	bpl SndCDE0
SndCDE1:
	jmp DoneWithIO

SendCHUNK:
	ldx #>WriteCommand
	lda #<WriteCommand
	jsr SendDOSCmd
	bnex SndCHNK2
	lda #$20
	jsr $ffa8
	ldy #0
SndCHNK0:
	lda (z8d),y
	jsr $ffa8
	iny
	cpy #$20
	bcc SndCHNK0
	jsr $ffae
	ldx #0
SndCHNK2:
	rts

WriteCommand:
	.byte "M-W"
WriteAddy:
	.word $0300

__ExitTurbo:
	txa
	pha
	ldx curDrive
	lda _turboFlags,x
	and #%01000000
	beq ExiTur0
	jsr SendExitTurbo
	ldx curDrive
	lda _turboFlags,x
	and #%10111111
	sta _turboFlags,x
	bbrf 6, sysRAMFlg, ExiTur0
	jsr E9C4A
	ldx curDrive
	lda E9746-8, x
	sta r1L
	lda E974A-8, x
	sta r1H
	LoadW r0, dir3Head
	ldy #0
	sty r3L
	sty r2L
	iny
	sty r2H
	jsr StashRAM
	jsr DoClrCache2
ExiTur0:
	pla
	tax
	rts

E9746:
	.byte $80, $00, $80, $00 ;!!!
E974A:
	.byte $8f, $9d, $aa, $b8

__PurgeTurbo:
	jsr ClearCache
	jsr ExitTurbo
	ldy curDrive
	lda #0
	sta _turboFlags,y
	rts

DUNK4:
	stx z8c
	sta z8b
	ldy #2
	bne DUNK4_3
DUNK4_1:
	stx z8c
	sta z8b
DUNK4_2:
	ldy #4
	lda r1H
	sta DTrkSec+1
	lda r1L
	sta DTrkSec
DUNK4_3:
	lda z8c
	sta DExeProc+1
	lda z8b
	sta DExeProc
	lda #>DExeProc
	sta z8c
	lda #<DExeProc
	sta z8b
	jmp Hst_SendByte

DUNK5:
	ldy #1
	jsr Hst_RecvByte
	pha
	tay
	jsr Hst_RecvByte
	pla
	tay
	rts

GetSync:
	sei
	MoveB TURBO_DD00, cia2base
GetSync0:
	bbrf 7, cia2base, GetSync0
	rts

__ChangeDiskDevice:
	sta ChngDskDev_Number
	jsr PurgeTurbo
	jsr InitForIO
	ldx #>ChngDskDev_Command
	lda #<ChngDskDev_Command
	jsr SendDOSCmd
	bnex ChngDskDv0
	ldy ChngDskDev_Number
	lda #0
	sta _turboFlags,y
	sty curDrive
	sty curDevice
	jmp E9685
ChngDskDv0:
	jmp DoneWithIO

ChngDskDev_Command:
	.byte "U0>"
ChngDskDev_Number:
	.byte 8, 0

__NewDisk:
	jsr EnterTurbo
	bne NewDsk2
	jsr ClearCache
	lda #0
	sta errCount
	sta r1L
	jsr InitForIO
NewDsk0:
	ldx #>Drv_NewDisk
	lda #<Drv_NewDisk
	jsr DUNK4_1
	jsr GetDOSError
	beq NewDsk1
	inc errCount
	cpy errCount
	beq NewDsk1
	bcs NewDsk0
NewDsk1:
	jsr DoneWithIO
NewDsk2:
	rts

DOSErrTab:
	.byte $01, $05, $02, $08
	.byte $08, $01, $05, $01
	.byte $05, $05, $05

NibbleTab:
	.byte $0f, $07, $0d, $05, $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04, $0a, $02, $08, $00
NibbleTab2:
	.byte $05, $85, $25, $a5, $45, $c5, $65, $e5
	.byte $15, $95, $35, $b5, $55, $d5, $75, $f5
E9825:
	.byte $05, $25, $05, $25, $15, $35, $15, $35
	.byte $05, $25, $05, $25, $15, $35, $15, $35

Hst_RecvByte:
	jsr GetSync
	sty z8d
Hst_RecvByte_0:
	sec
Hst_RecvByte_1:
	lda rasreg
	sbc #$31
	bcc Hst_RecvByte_2
	and #6
	beq Hst_RecvByte_1
Hst_RecvByte_2:
	MoveB TURBO_DD00_CPY, cia2base
	MoveB TURBO_DD00, cia2base
	dec z8d
	lda cia2base
	lsr
	lsr
	nop
	ora cia2base
	lsr
	lsr
	lsr
	lsr
	ldy cia2base
	tax
	tya
	lsr
	lsr
	ora cia2base
	and #%11110000
	ora NibbleTab,x
	ldy z8d
	sta (z8b),y
	bne Hst_RecvByte_0
Hst_RecvByte_3:
	ldx tmpDD00
	stx cia2base
	rts

Hst_SendByte:
	jsr GetSync
	tya
	pha
	ldy #0
	jsr Hst_SendByte_01
	pla
	tay
Hst_SendBt_00:
	jsr GetSync
Hst_SendByte_0:
	dey
	lda (z8b),y
	ldx TURBO_DD00
	stx cia2base
Hst_SendByte_01:
	tax
	and #%00001111
	sta z8d
	sec
Hst_SendByte_1:
	lda rasreg
	sbc #$31
	bcc Hst_SendByte_2
	and #6
	beq Hst_SendByte_1
Hst_SendByte_2:
	txa
	ldx TURBO_DD00_CPY
	stx cia2base
	and #%11110000
	ora TURBO_DD00
	sta cia2base
	ror
	ror
	and #%11110000
	ora TURBO_DD00
	sta cia2base
	ldx z8d
	lda NibbleTab2,x
	sta cia2base
	lda E9825,x
	cpy #0
	sta cia2base
	bne Hst_SendByte_0
	nop
	nop
	beq Hst_RecvByte_3

_ReadLink:
	jsr CheckParams_1
	bcc RdLink2
	lda r1L
	ora #$80
	sta r1L
	jsr RdBlock0
	lda r1L
	and #$7f
	sta r1L
RdLink2:
	rts

__ReadBlock:
	jsr CheckParams_1
	bcc RdBlock2
	bbrf 6, curType, RdBlock0
	jsr DoCacheRead
	bne RdBlock2
RdBlock0:
	ldx #>Drv_ReadSec
	lda #<Drv_ReadSec
	jsr DUNK4_1
	ldx #>Drv_SendByte
	lda #<Drv_SendByte
	jsr DUNK4
	MoveW r4, z8b
	ldy #0
	lda r1L
	bpl RdBlock_00
	ldy #2
RdBlock_00:
	jsr Hst_RecvByte
	jsr GetDError
	beqx RdBlock1
	inc errCount
	cpy errCount
	beq RdBlock1
	bcs RdBlock0
RdBlock1:
	CmpBI r1L, DIR_1581_TRACK
	bne RdBlock_2
	lda r1H
	bne RdBlock_2
	ldy #4
RdBlock_1:
	lda (r4),y
	sta E9C63
	tya
	addv $8c
	tay
	lda (r4),y
	pha
	lda E9C63
	sta (r4),y
	tya
	subv $8c
	tay
	pla
	sta (r4),y
	iny
	cpy #$1d
	bne RdBlock_1
RdBlock_2:
	bnex RdBlock2
	bbrf 6, curType, RdBlock2
	jsr DoCacheWrite
	bra RdBlock2
RdBlock2:
	ldy #0
	rts

__WriteBlock:
	jsr CheckParams
	bcc WrBlock3
	jsr RdBlock1
WrBlock1:
	ldx #>Drv_WriteSec
	lda #<Drv_WriteSec
	jsr DUNK4_1
	MoveW r4, z8b
	ldy #0
	jsr Hst_SendBt_00
	jsr GetDError
	beq WrBlock2
	inc errCount
	cpy errCount
WrBlock_1:
	beq WrBlock2
	bcs WrBlock1
WrBlock2:
	jsr RdBlock1
WrBlock3:
	rts

__VerWriteBlock:
	ldx #0
	bbrf 6, curType, VWrBlock3
	jmp DoCacheWrite
VWrBlock3:
	rts

GetDOSError:
	ldx #>Drv_SendByte_1
	lda #<Drv_SendByte_1
	jsr DUNK4
GetDError:
	lda #>errStore
	sta z8c
	lda #<errStore
	sta z8b
	jsr DUNK5
	lda errStore
	pha
	tay
	lda DOSErrTab-1,y
	tay
	pla
	cmp #0
	beq GetDErr1
	cmp #1
	beq GetDErr1
	addv $1e
	bne GetDErr2
GetDErr1:
	lda #0
GetDErr2:
	tax
	rts

DriveCode:
.segment "drv1581_drivecode"

DNibbleTab:
	.byte $0f, $07, $0d, $05
	.byte $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04
	.byte $0a, $02, $08

DNibbleTab2:
	.byte $00, $80, $20, $a0
	.byte $40, $c0, $60, $e0
	.byte $10, $90, $30, $b0
	.byte $50, $d0, $70, $f0
Drv_SendByte:
	ldy #0
	lda E04EB
	bpl E0328
	ldy #2
E0328:
	jsr E0362
Drv_SendByte_1:
	lda #>$0500
	sta $7e
	ldy #0
	sty $7f
	iny
	jsr E0354
	jsr E046A
	cli
E033B:
	lda E04E8
	beq E034B
	dex
	bne E034B
	dec E04E8
	bne E034B
;!!!E034A=*+2
	jsr E04BE
E034B:
	lda #4
	bit $4001
	bne E033B
	sei
	rts

E0354:
	sty $42
	ldy #0
	jsr E0402
	lda $42
	jsr E0368
	ldy $42
E0362:
	jsr E0402
E0365:
	dey
	lda ($7e),y
E0368:
	tax
	lsr
	lsr
	lsr
E036c:
	lsr
	sta $41
	txa
	and #%00001111
	tax
	lda #4
	sta $4001
	bit $4001
	beq *-3
	nop
	nop
	nop
	nop
	stx $4001
	jsr E0401
	txa
	rol
	and #%00001111
	sta $4001
E038E:
	php
	plp
	nop
	nop
	nop
	ldx $41
	lda DNibbleTab,x
	sta $4001
	jsr E0400
	rol
	and #%00001111
	cpy #0
	sta $4001
	bne E0365
	jsr E03FB
	beq E03ED
E03AD:
	jsr E0402
	jsr E03FB
	lda #0
	sta $41
E03B7:
	eor $41
	sta $41
	jsr E03FC
	lda #4
	bit $4001
	beq *-3
	jsr E03FD
	lda $4001
	jsr E03FC
	asl
	ora $4001
	php
	plp
	nop
	nop
	and #%00001111
	tax
	lda $4001
	jsr E03FF
	asl
	ora $4001
	and #%00001111
	ora DNibbleTab2,x
	dey
	sta ($7e),y
	bne E03B7
E03ED:
	ldx #2
	stx $4001
	php
	plp
	php
	plp
	php
	plp
	php
	plp
	nop
E03FB:
	nop
E03FC:
	nop
E03FD:
	nop
	nop
E03FF:
	nop
E0400:
	nop
E0401:
	rts

E0402:
	lda #4
	bit $4001
	bne E0402
	lda #0
	sta $4001
	rts

DriveStart:
	sei
	PushB $41
	PushB $42
	PushW $7e
	ldx #2
	ldy #0
E0420:
	dey
	bne E0420
	dex
	bne E0420
	jsr E03ED
	lda #4
	bit $4001
	beq *-3
E0430:
	lda #>E04E9
	sta $7f
	lda #<E04E9
	sta $7e
	ldy #1
	jsr E03AD
	sta $42
	tay
	jsr E03AD
	jsr E046E
	LoadW $7e, $0600
	lda #>E0430-1
	pha
	lda #<E0430-1
	pha
	jmp ($04E9)

E0457:
	jsr E0402 ;!!! ExitTurbo
	pla
	pla
	PopW $7e
	PopB $42
	PopB $41
	cli
	rts

E046A:
	lda #$BF
	bne E0475
E046E:
	lda #$40
	ora $4000
	bne E0478
E0475:
	and $4000
E0478:
	sta $4000
	rts

Drv_WriteSec:
	jsr E04B0
	ldy #0
	jsr E03AD
	lda #$B6
	jsr E04D1
	lda $05
	sta $01FA
	bne E0498
	lda #$90
	sta E04E8
	jsr E04D1
E0498:
	jmp Drv_SendByte_1

Drv_NewDisk:
	jsr Drv_ExitTurbo
	lda #$92
	jsr E04D1
	lda $05
	cmp #1
	bcc E04AC
	beq E04AC
	rts
E04AC:
	lda #$B0
	bne E04D1
E04B0:
	lda E04EB
	and #$7f
	cmp $11
	beq E04E6
Drv_ExitTurbo:
	lda E04E8
	beq E04E6
E04BE:
	ldx #3
	jsr $ff6c
	lda #0
	sta E04E8
	lda #$86
	bne E04D1
Drv_ReadSec:
	jsr E04B0
	lda #$80
E04D1:
	sta $05
	lda E04EB
	and #$7f
	sta $11
	lda E04EC
	sta $12
	ldx #3
	lda $2,x
	jsr $ff54
E04E6:
	rts

	.byte 0
E04E8:
	.byte 0
E04E9:
	.byte 0, 0
E04EB	=*
E04EC	=*+1
.segment "drv1581_b"
ClrCacheDat:
	.word 0

ClearCache:
	bbsf 6, curType, DoClearCache
	rts
DoClearCache:
	jsr E9C4A
	LoadW r0, ClrCacheDat
	lda #0
	sta r1L
	sta r1H
	sta r2H
	lda #2
	sta r2L
	ldy curDrive
	lda driveData,y
	sta r3L
DoClrCache1:
	jsr StashRAM
	inc r1H
	bne DoClrCache1
DoClrCache2:
	ldx #8
DoClrCache3:
	lda E9C63-1,x
	sta r0L-1,x
	dex
	bne DoClrCache3
	rts

DoCacheVerify:
	lda r1L
	cmp #DIR_1581_TRACK
	bne E9BF9
	ldy #$93
	jsr DoCacheDisk
	and #$20
	rts
E9BF9:
	ldx #0
	lda #$ff
	rts

DoCacheRead:
	lda r1L
	cmp #DIR_1581_TRACK
	bne GiveNoError
	ldy #%10010001
	jsr DoCacheDisk
	ldy #0
	lda (r4),y
	iny
	ora (r4),y
	rts
GiveNoError:
	ldx #0
	rts

DoCacheWrite:
	lda r1L
	cmp #DIR_1581_TRACK
	bne E9C1E
	ldy #%10010000
	bne DoCacheDisk
E9C1E:
	ldx #0
	rts
DoCacheDisk:
	jsr E9C4A
	tya
	pha
	ldy curDrive
	lda driveData,y
	sta r3L
	ldy #0
	sty r1L
	sty r2L
	iny
	sty r2H
	MoveW r4, r0
	pla
	tay
	jsr DoRAMOp
	tay
	jsr DoClrCache2
	tya
	rts

E9C4A:
	ldx #8
E9C4C:
	lda r0L-1,x
	sta E9C63-1,x
	dex
	bne E9C4C
	rts

tmpclkreg:
	.byte 0
tmpPS:
	.byte 0
tmpgrirqen:
	.byte 0
tmpCPU_DATA:
	.byte 0
tmpmobenble:
	.byte 0
	.byte 0
DExeProc:
	.word 0
DTrkSec:
	.word 0
tmpDD00:
	.byte 0
errCount:
	.byte 0
errStore:
	.byte 0
tmpDriveType:
	.byte 0
E9C63:
	.byte 0
E9C64:
	.byte 0
borderFlag:
	.byte 0
