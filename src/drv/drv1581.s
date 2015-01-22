.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import DoRAMOp, PurgeTurbo, ExitTurbo, StashRAM, SetDevice, PutDirHead, FindBAMBit, SetNextFree, CalcBlksFree, Ddiv, SaveFile, CopyFString, GetPtrCurDkNm, ChkDkGEOS, GetDirHead, NewDisk, VerWriteBlock, WriteBlock, DoneWithIO, ReadBlock, InitForIO, EnterTurbo
.global Get1stDirEntry, GetNxtDirEntry, PurgeTurbo, ReadBuff, SaveFile, WriteBuff, _BlkAlloc, _CalcBlksFree, _ChangeDiskDevice, _ChkDkGEOS, _DoneWithIO, _EnterTurbo, _ExitTurbo, _FindBAMBit, _FreeBlock, _GetBlock, _GetDirHead, _GetFreeDirBlk, _InitForIO, _NewDisk, _NxtBlkAlloc, _OpenDisk, _PurgeTurbo, _PutBlock, _PutDirHead, _ReadBlock, _SetGEOSDisk, _SetNextFree, _VerWriteBlock, _WriteBlock

.segment "drv1581"

;GEOS 1581 disk driver
;reassembled by Maciej 'YTM/Elysium' Witkowiak
;31.08-3.09.2001


DriveAddy = $0300

dir3Head	= $9c80

_InitForIO:
	.word __InitForIO ;9000
_DoneWithIO:
	.word __DoneWithIO ;9002
_ExitTurbo:
	.word __ExitTurbo ;9004
_PurgeTurbo:
	.word __PurgeTurbo ;9006
_EnterTurbo:
	.word __EnterTurbo ;9008
_ChangeDiskDevice:
	.word __ChangeDiskDevice ;900a
_NewDisk:
	.word __NewDisk ;900c
_ReadBlock:
	.word __ReadBlock ;900e
_WriteBlock:
	.word __WriteBlock ;9010
_VerWriteBlock:
	.word __VerWriteBlock ;9012
_OpenDisk:
	.word __OpenDisk ;9014
_GetBlock:
	.word __GetBlock ;9016
_PutBlock:
	.word __PutBlock ;9018
_GetDirHead:
	.word __GetDirHead ;901a
_PutDirHead:
	.word __PutDirHead ;901c
_GetFreeDirBlk:
	.word __GetFreeDirBlk ;901e
_CalcBlksFree:
	.word __CalcBlksFree ;9020
_FreeBlock:
	.word __FreeBlock ;9022
_SetNextFree:
	.word __SetNextFree ;9024
_FindBAMBit:
	.word __FindBAMBit ;9026
_NxtBlkAlloc:
	.word __NxtBlkAlloc ;9028
_BlkAlloc:
	.word __BlkAlloc ;902a
_ChkDkGEOS:
	.word __ChkDkGEOS ;902c
_SetGEOSDisk:
	.word __SetGEOSDisk ;902e

Get1stDirEntry:
	jmp _Get1stDirEntry ;9030
GetNxtDirEntry:
	jmp _GetNxtDirEntry ;9033
GetBorder:
	jmp _GetBorder ;9036
AddDirBlock:
	jmp _AddDirBlock ;9039
ReadBuff:
	jmp _ReadBuff ;903c
WriteBuff:
	jmp _WriteBuff ;903f
	jmp DUNK4_2 ;9042
	jmp GetDOSError ;9045
AllocateBlock:
	jmp _AllocateBlock ;9048
ReadLink:
	jmp _ReadLink ;904b

E904E:
	.byte $03 ;904e

__GetDirHead:
	jsr SetDirHead_1 ;904f
	jsr __GetBlock
	bne GDH_0
	jsr SetDirHead_2
	jsr __GetBlock
	bne GDH_0
	jsr SetDirHead_3
	bne __GetBlock
GDH_0:
	rts ;9064

_ReadBuff:
	LoadW r4, diskBlkBuf ;9065
__GetBlock:
	jsr EnterTurbo ;906d
	bne GetBlk0
	jsr InitForIO
	jsr ReadBlock
	jsr DoneWithIO
GetBlk0:
	txa
	rts

__PutDirHead:
	;907d
	jsr SetDirHead_1
	jsr __PutBlock
	bne PDH_0
	jsr SetDirHead_2
	jsr __PutBlock
	bne PDH_0
	jsr SetDirHead_3
	bne __PutBlock
PDH_0:
	rts ;9092

_WriteBuff:
	LoadW r4, diskBlkBuf ;9093
__PutBlock:
	jsr EnterTurbo ;909b
	bne PutBlk1
	jsr InitForIO
	jsr WriteBlock
	bnex PutBlk0
	jsr VerWriteBlock
PutBlk0:
	jsr DoneWithIO ;90ac
PutBlk1:
	txa ;90af
	rts

SetDirHead_1:
	ldx #>curDirHead ;90b1
	ldy #<curDirHead
	lda #0
	beq SDH_1
SetDirHead_2:
	ldx #>dir2Head ;90b9
	ldy #<dir2Head
	lda #1
	bne SDH_1
SetDirHead_3:
	ldx #>dir3Head ;90c1
	ldy #<dir3Head
	lda #2
SDH_1:
	stx r4H ;90c7
	sty r4L
	sta r1H
	lda #40
	sta r1L
	rts

CheckParams:
	bbrf 6, curType, CheckParams_1 ;90d2
	jsr DoCacheVerify
	beq CheckParams_2
CheckParams_1:
	lda #0 ;90dc
	sta errCount
	ldx #INV_TRACK
	lda r1L
	beq CheckParams_2
	cmp #81
	bcs CheckParams_2
	sec
	rts
CheckParams_2:
	clc ;90ed
	rts

__OpenDisk:
	;90ba
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
	jsr DoClearCache ;911e
	jsr SetDirHead_1
	jsr DoCacheWrite
	jsr SetDirHead_2
	jsr DoCacheWrite
	jsr SetDirHead_3
	jsr DoCacheWrite
OpenDsk10:
	jsr SetCurDHVec ;9133

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
	ldy curDrive ;910a
	lda tmpDriveType
	sta _driveType,y
	rts

__BlkAlloc:
	;915b
	PopW r3 ;!!!hint???
	PushW r3
	SubW SaveFile+1, r3
	ldy #$27
	lda r3H
	beq E917E
	ldy #$23
E917E:
	sty r3L ;917e
	ldy #0
	sty r3H
	lda #2
	bne E918A
__NxtBlkAlloc:
	lda #0 ;9188
E918A:
	sta E9C64 ;918a

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
	jsr SetCurDHVec ;91b2
	jsr CalcBlksFree
	PopW r3
	ldx #INSUFF_SPACE
	CmpW r2, r4
	beq BlkAlc1
	bcs BlkAlc4
BlkAlc1:
	MoveW r6, r4 ;91ce
	MoveW r2, r5
BlkAlc2:
	jsr SetNextFree ;91de
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
	lda r5L ;9208
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
	clc ;9222
	adc #1
	sta (r4),y
	ldx #0
BlkAlc4:
	PopW r9 ;9229
	rts

SetCurDHVec:
	LoadW r5, curDirHead ;9230
	rts

_Get1stDirEntry:
	;9239
	jsr SetDirHead_3
	inc r1H
	LoadB borderFlag, 0
	beq GNDirEntry0

_GetNxtDirEntry:
	;9245
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
	jsr ReadBuff ;9281
	ldy #0
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
GNDirEntry1:
	rts ;928e

_GetBorder:
	;928f
	jsr GetDirHead
	bnex GetBord2
	jsr SetCurDHVec
	jsr ChkDkGEOS
	bne GetBord0
	ldy #$ff
	bne GetBord1
GetBord0:
	MoveW curDirHead+OFF_OP_TR_SC, r1 ;92a1
	ldy #0
GetBord1:
	ldx #0 ;92ad
GetBord2:
	rts ;92af

__ChkDkGEOS:
	;92b0
	ldy #OFF_GS_ID
	ldx #0
	stx isGEOS
ChkDkG0:
	lda (r5),y ;92b7
	cmp GEOSDiskID,x
	bne ChkDkG1
	iny
	inx
	cpx #11
	bne ChkDkG0
	LoadB isGEOS, $ff
ChkDkG1:
	lda isGEOS ;92c9
	rts

GEOSDiskID:
	.byte "GEOS format V1.0",NULL ;92cd

__GetFreeDirBlk:
	;92de
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
	jsr ReadBuff ;92f6
GFDirBlk1:
	bnex GFDirBlk5 ;92f9
	dec r6L
	beq GFDirBlk3
GFDirBlk11:
	lda diskBlkBuf ;9300
	bne GFDirBlk2
	jsr AddDirBlock
	bra GFDirBlk1
GFDirBlk2:
	sta r1L ;930b
	MoveB diskBlkBuf+1, r1H
	bra GFDirBlk0
GFDirBlk3:
	ldy #FRST_FILE_ENTRY ;9315
	ldx #0
GFDirBlk4:
	lda diskBlkBuf,y ;9319
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
	PopW r2 ;9334
	PopB r6L
	plp
	rts

_AddDirBlock:
	;933f
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
	PopW r6 ;9372
	rts

ClearAndWrite:
	lda #0 ;9379
	tay
CAndWr0:
	sta diskBlkBuf,y ;937c
	iny
	bne CAndWr0
	dey
	sty diskBlkBuf+1
	jmp WriteBuff

__SetNextFree:
	;9389
	jsr SNF_1
	bne SNF_0
	rts
SNF_0:
	LoadB r3L, $27 ;938f
SNF_1:
	lda r3H ;9393
	addv 1
	sta r6H
	MoveB r3L, r6L
	cmp #DIR_1581_TRACK
	beq SNF_3
SNF_2:
	lda r6L ;93a2
	cmp #DIR_1581_TRACK
	beq SNF_8
SNF_3:
	cmp #DIR_1581_TRACK+1 ;93a8
	bcc SNF_4
	subv DIR_1581_TRACK
SNF_4:
	subv $01 ;93af
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
	lda dir2Head+$10,x ;93c6
SNF_6:
	beq SNF_8 ;93c9
	LoadB r7L, DIR_1581_TRACK
	tay
SNF_7:
	jsr SNxtFreeHelp ;93d0
	beq SNF_11
	inc r6H
	dey
	bne SNF_7
SNF_8:
	CmpBI r6L, DIR_1581_TRACK+1 ;93da
	bcs SNF_9
	dec r6L
	bne SNF_10
	LoadB r6L, DIR_1581_TRACK+1
	bne SNF_10
SNF_9:
	inc r6L ;93ea
SNF_10:
	CmpBI r6L, $51 ;93ec
	bcs SNF_12
	LoadB r6H, 0
	beq SNF_2
SNF_11:
	MoveW r6, r3 ;93f8
	ldx #0
	rts
SNF_12:
	ldx #INSUFF_SPACE ;9403
	rts

SNxtFreeHelp:
	lda r6H ;9406
SNFHlp_1:
	cmp r7L ;9408
	bcc SNFHlp_2
	sub r7L
	bra SNFHlp_1
SNFHlp_2:
	sta r6H ;9412

_AllocateBlock:
	jsr FindBAMBit ;9414
	bne AllBlk_0
	ldx #BAD_BAM
	rts
AllBlk_0:
	php ;941c
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
	inc dir3Head+$10,x ;9436
	bra AllBlk_4
AllBlk_2:
	lda r8H ;943c
	eor dir2Head+$10,x
	sta dir2Head+$10,x
	ldx r7H
	plp
	beq AllBlk_3
	dec dir2Head+$10,x
	bra AllBlk_4
AllBlk_3:
	inc dir2Head+$10,x ;944f
AllBlk_4:
	ldx #0 ;9452
	rts

__FreeBlock:
	jsr FindBAMBit ;9455
	beq AllBlk_0
	ldx #BAD_BAM
	rts

__FindBAMBit:
	;945d
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
	.byte $01, $02, $04, $08 ;9497
	.byte $10, $20, $40, $80

__CalcBlksFree:
	;949f
	LoadW r4, 0
	ldy #$10
CBlksFre0:
	lda dir2Head,y ;94a7
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre1:
	tya ;94b3
	addv 6
	tay
	cpy #$FA
	beq CBlksFre1
	cpy #$00
	bne CBlksFre0
	ldy #$10
CBlksFre2:
	lda dir3Head,y ;94c2
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre3:
	tya ;94ce
	addv 6
	tay
	bne CBlksFre2
	LoadW r3, $0c58
	rts

__SetGEOSDisk:
	;94de
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
	lda GEOSDiskID,x ;951c
	sta curDirHead,y
	dey
	dex
	bpl SetGDisk1
	jsr PutDirHead
SetGDisk2:
	rts ;9529


__InitForIO:
	;95c6
	php
	pla
	sta tmpPS
	sei
	lda CPU_DATA
	sta tmpCPU_DATA
	LoadB CPU_DATA, KRNL_IO_IN
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
	lda #<D_IRQHandler
	sta irqvec
	lda #>D_NMIHandler
	sta nmivec+1
	lda #<D_NMIHandler
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
	lda rasreg ;958d
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
	lda NibbleTab2,y ;95ad
	and #$f0
	ora TURBO_DD00
	sta NibbleTab2,y
	dey
	bpl IniForIO1
	rts

D_IRQHandler:
	pla ;95bb
	tay
	pla
	tax
	pla
D_NMIHandler:
	rti ;95c0

__DoneWithIO:
	sei ;95c1
	lda tmpclkreg
	sta clkreg
	lda tmpmobenble
	sta mobenble
	LoadB cia2base+13, %01111111
	lda cia2base+13
	lda tmpgrirqen
	sta grirqen
	lda tmpCPU_DATA
	sta CPU_DATA
	lda tmpPS
	pha
	plp
	rts

SendDOSCmd:
	stx z8c ;95e7
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
	lda (z8b),y ;9604
	jsr $ffa8
	iny
	cpy #5
	bcc SndDOSCmd0
	ldx #0
	rts
SndDOSCmd1:
	jsr $ffae ;9611
	ldx #DEV_NOT_FOUND
	rts

__EnterTurbo:
	;9617
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
	and #%01000000 ;9633
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
	dey ;964a
	bne EntTur1
	jsr Hst_RecvByte_3
EntTur2:
	bbsf 7, cia2base, EntTur2 ;9650
	jsr DoneWithIO
	ldx curDrive
	lda _turboFlags,x
	ora #%01000000
	sta _turboFlags,x
EntTur3:
	ldx #0 ;9663
	beq EntTur5
EntTur4:
	jsr DoneWithIO ;9667
EntTur5:
	txa ;966a
	rts

EnterCommand:
	.byte "M-E" ;966c
	.word DriveStart

SendExitTurbo:
	jsr InitForIO ;9671
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
	jsr InitForIO ;9698
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
	jsr SendCHUNK ;96b1
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
	jmp DoneWithIO ;96d4

SendCHUNK:
	ldx #>WriteCommand ;96d7
	lda #<WriteCommand
	jsr SendDOSCmd
	bnex SndCHNK2
	lda #$20
	jsr $ffa8
	ldy #0
SndCHNK0:
	lda (z8d),y ;96e8
	jsr $ffa8
	iny
	cpy #$20
	bcc SndCHNK0
	jsr $ffae
	ldx #0
SndCHNK2:
	rts ;96f7

WriteCommand:
	.byte "M-W" ;96f8
WriteAddy:
	.word $0300 ;96fb

__ExitTurbo:
	;96fd
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
	pla ;9743
	tax
	rts

E9746:
	.byte $80, $00, $80, $00 ;!!!
E974A:
	.byte $8f, $9d, $aa, $b8

__PurgeTurbo:
	;974e
	jsr ClearCache
	jsr ExitTurbo
	ldy curDrive
	lda #0
	sta _turboFlags,y
	rts

DUNK4:
	stx z8c ;975d
	sta z8b
	ldy #2
	bne DUNK4_3
DUNK4_1:
	stx z8c ;9765
	sta z8b
DUNK4_2:
	ldy #4 ;9769
	lda r1H
	sta DTrkSec+1
	lda r1L
	sta DTrkSec
DUNK4_3:
	lda z8c ;9775
	sta DExeProc+1
	lda z8b
	sta DExeProc
	lda #>DExeProc
	sta z8c
	lda #<DExeProc
	sta z8b
	jmp Hst_SendByte

DUNK5:
	ldy #1 ;978a
	jsr Hst_RecvByte
	pha
	tay
	jsr Hst_RecvByte
	pla
	tay
	rts

GetSync:
	sei ;9797
	MoveB TURBO_DD00, cia2base
GetSync0:
	bbrf 7, cia2base, GetSync0 ;979d
	rts

__ChangeDiskDevice:
	;97a6
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
	jmp DoneWithIO ;97c6

ChngDskDev_Command:
	;97c9
	.byte "U0>"
ChngDskDev_Number:
	;97cc
	.byte 8, 0

__NewDisk:
	;97ce
	jsr EnterTurbo
	bne NewDsk2
	jsr ClearCache
	lda #0
	sta errCount
	sta r1L
	jsr InitForIO
NewDsk0:
	ldx #>Drv_NewDisk ;97e0
	lda #<Drv_NewDisk
	jsr DUNK4_1
	jsr GetDOSError
	beq NewDsk1
	inc errCount
	cpy errCount
	beq NewDsk1
	bcs NewDsk0
NewDsk1:
	jsr DoneWithIO ;97f6
NewDsk2:
	rts ;97f9

DOSErrTab:
	.byte $01, $05, $02, $08 ;97fa
	.byte $08, $01, $05, $01
	.byte $05, $05, $05

NibbleTab:
	.byte $0f, $07, $0d, $05, $0b, $03, $09, $01 ;9805
	.byte $0e, $06, $0c, $04, $0a, $02, $08, $00
NibbleTab2:
	.byte $05, $85, $25, $a5, $45, $c5, $65, $e5 ;9815
	.byte $15, $95, $35, $b5, $55, $d5, $75, $f5
E9825:
	.byte $05, $25, $05, $25, $15, $35, $15, $35
	.byte $05, $25, $05, $25, $15, $35, $15, $35

Hst_RecvByte:
	jsr GetSync ;9835
	sty z8d
Hst_RecvByte_0:
	sec ;983a
Hst_RecvByte_1:
	lda rasreg ;983b
	sbc #$31
	bcc Hst_RecvByte_2
	and #6
	beq Hst_RecvByte_1
Hst_RecvByte_2:
	MoveB TURBO_DD00_CPY, cia2base ;9846
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
	ldx tmpDD00 ;9874
	stx cia2base
	rts

Hst_SendByte:
	jsr GetSync ;987b
	tya
	pha
	ldy #0
	jsr Hst_SendByte_01
	pla
	tay
Hst_SendBt_00:
	jsr GetSync ;9887
Hst_SendByte_0:
	dey ;988a
	lda (z8b),y
	ldx TURBO_DD00
	stx cia2base
Hst_SendByte_01:
	tax ;9892
	and #%00001111
	sta z8d
	sec
Hst_SendByte_1:
	lda rasreg ;9898
	sbc #$31
	bcc Hst_SendByte_2
	and #6
	beq Hst_SendByte_1
Hst_SendByte_2:
	txa ;98a3
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
	;98cf
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
	rts ;98e3

__ReadBlock:
	;98e4
	jsr CheckParams_1
	bcc RdBlock2
	bbrf 6, curType, RdBlock0
	jsr DoCacheRead
	bne RdBlock2
RdBlock0:
	ldx #>Drv_ReadSec ;98f3
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
	jsr Hst_RecvByte ;9911
	jsr GetDError
	beqx RdBlock1
	inc errCount
	cpy errCount
	beq RdBlock1
	bcs RdBlock0
RdBlock1:
	CmpBI r1L, DIR_1581_TRACK ;9924
	bne RdBlock_2
	lda r1H
	bne RdBlock_2
	ldy #4
RdBlock_1:
	lda (r4),y ;9930
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
	bnex RdBlock2 ;9924
	bbrf 6, curType, RdBlock2
	jsr DoCacheWrite
	bra RdBlock2
RdBlock2:
	ldy #0 ;995d
	rts

__WriteBlock:
	;9960
	jsr CheckParams
	bcc WrBlock3
	jsr RdBlock1
WrBlock1:
	ldx #>Drv_WriteSec ;9968
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
	beq WrBlock2 ;9987
	bcs WrBlock1
WrBlock2:
	jsr RdBlock1 ;998b
WrBlock3:
	rts ;998e

__VerWriteBlock:
	;998f
	ldx #0
	bbrf 6, curType, VWrBlock3
	jmp DoCacheWrite
VWrBlock3:
	rts ;9886

GetDOSError:
	ldx #>Drv_SendByte_1 ;999a
	lda #<Drv_SendByte_1
	jsr DUNK4
GetDError:
	lda #>errStore ;99a1
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
	lda #0 ;99c3
GetDErr2:
	tax ;98c5
	rts

DriveCode:
	;99c7
.segment "drv1581_drivecode"

DNibbleTab:
	.byte $0f, $07, $0d, $05 ;0300
	.byte $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04
	.byte $0a, $02, $08

DNibbleTab2:
	.byte $00, $80, $20, $a0 ;030f
	.byte $40, $c0, $60, $e0
	.byte $10, $90, $30, $b0
	.byte $50, $d0, $70, $f0
Drv_SendByte:
	;031f
	ldy #0
	lda E04EB
	bpl E0328
	ldy #2
E0328:
	jsr E0362 ;0328
Drv_SendByte_1:
	lda #>$0500 ;032b
	sta $7e
	ldy #0
	sty $7f
	iny
	jsr E0354
	jsr E046A
	cli
E033B:
	lda E04E8 ;033b
	beq E034B
	dex
	bne E034B
	dec E04E8
	bne E034B
;!!!E034A=*+2
	jsr E04BE
E034B:
	lda #4 ;034b
	bit $4001
	bne E033B
	sei
	rts

E0354:
	sty $42 ;0354
	ldy #0
	jsr E0402
	lda $42
	jsr E0368
	ldy $42
E0362:
	jsr E0402 ;0362
E0365:
	dey ;0365
	lda ($7e),y
E0368:
	tax ;0368
	lsr
	lsr
	lsr
E036c:
	lsr ;036c
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
	php ;038e
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
	jsr E0402 ;03ad
	jsr E03FB
	lda #0
	sta $41
E03B7:
	eor $41 ;03b7
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
	ldx #2 ;03ed
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
	lda #4 ;0402
	bit $4001
	bne E0402
	lda #0
	sta $4001
	rts

DriveStart:
	;040f
	sei
	PushB $41
	PushB $42
	PushW $7e
	ldx #2
	ldy #0
E0420:
	dey ;0420
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
	jsr E0402 ;0457 ;!!! ExitTurbo
	pla
	pla
	PopW $7e
	PopB $42
	PopB $41
	cli
	rts

E046A:
	lda #$BF ;046a
	bne E0475
E046E:
	lda #$40 ;046e
	ora $4000
	bne E0478
E0475:
	and $4000 ;0475
E0478:
	sta $4000 ;0478
	rts

Drv_WriteSec:
	jsr E04B0 ;047c
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
	jmp Drv_SendByte_1 ;0498

Drv_NewDisk:
	jsr Drv_ExitTurbo ;049b
	lda #$92
	jsr E04D1
	lda $05
	cmp #1
	bcc E04AC
	beq E04AC
	rts
E04AC:
	lda #$B0 ;04ac
	bne E04D1
E04B0:
	lda E04EB ;04b0
	and #$7f
	cmp $11
	beq E04E6
Drv_ExitTurbo:
	lda E04E8 ;04b9
	beq E04E6
E04BE:
	ldx #3
	jsr $ff6c
	lda #0
	sta E04E8
	lda #$86
	bne E04D1
Drv_ReadSec:
	jsr E04B0 ;04cc
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
	rts ;04e6

	.byte 0
E04E8:
	.byte 0
E04E9:
	.byte 0, 0
E04EB:
	=*
E04EC:
	=*+1
;04ed
.segment "drv1581_b"
;9bb2
ClrCacheDat:
	.word 0 ;9bb2

ClearCache:
	bbsf 6, curType, DoClearCache ;9bb4
	rts
DoClearCache:
	jsr E9C4A ;9bba
	LoadW r0, ClrCacheDat ;9c0f
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
	jsr StashRAM ;9bd9
	inc r1H
	bne DoClrCache1
DoClrCache2:
	ldx #8 ;9be0
DoClrCache3:
	lda E9C63-1,x ;9be2
	sta r0L-1,x
	dex
	bne DoClrCache3
	rts

DoCacheVerify:
	lda r1L ;9beb
	cmp #DIR_1581_TRACK
	bne E9BF9
	ldy #$93 ;9bf1
	jsr DoCacheDisk
	and #$20
	rts
E9BF9:
	ldx #0 ;9bf9
	lda #$ff
	rts

DoCacheRead:
	lda r1L ;9bfe
	cmp #DIR_1581_TRACK
	bne GiveNoError
	ldy #%10010001 ;9bfe
	jsr DoCacheDisk
	ldy #0
	lda (r4),y
	iny
	ora (r4),y
	rts
GiveNoError:
	ldx #0 ;9c11
	rts

DoCacheWrite:
	lda r1L ;9c14
	cmp #DIR_1581_TRACK
	bne E9C1E
	ldy #%10010000
	bne DoCacheDisk
E9C1E:
	ldx #0 ;9c1e
	rts
DoCacheDisk:
	jsr E9C4A ;9c21
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
	ldx #8 ;9c4a
E9C4C:
	lda r0L-1,x ;9c4c
	sta E9C63-1,x
	dex
	bne E9C4C
	rts

tmpclkreg:
	.byte 0 ;9c55
tmpPS:
	.byte 0 ;9c56
tmpgrirqen:
	.byte 0 ;9c57
tmpCPU_DATA:
	.byte 0 ;9c58
tmpmobenble:
	.byte 0 ;9c59
	.byte 0 ;9c5a
DExeProc:
	.word 0 ;9c5b
DTrkSec:
	.word 0 ;9c5d
tmpDD00:
	.byte 0 ;9c5f
errCount:
	.byte 0 ;9c60
errStore:
	.byte 0 ;9c61
tmpDriveType:
	.byte 0 ;9c62
E9C63:
	.byte 0 ;9c63
E9C64:
	.byte 0 ;9c64
borderFlag:
	.byte 0 ;9c65
