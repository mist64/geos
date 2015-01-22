;GEOS 1541 disk driver
;reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import DoRAMOp, StashRAM, ExitTurbo, SetDevice, PutDirHead, FindBAMBit, SetNextFree, CalcBlksFree, Ddiv, CopyFString, GetPtrCurDkNm, ChkDkGEOS, GetDirHead, NewDisk, VerWriteBlock, WriteBlock, DoneWithIO, ReadBlock, InitForIO, EnterTurbo
.global _InitForIO, _DoneWithIO, _ExitTurbo, _PurgeTurbo, _EnterTurbo, _ChangeDiskDevice, _NewDisk, _ReadBlock, _WriteBlock, _VerWriteBlock, _OpenDisk, _GetBlock, _PutBlock, _GetDirHead, _PutDirHead, _GetFreeDirBlk, _CalcBlksFree, _FreeBlock, _SetNextFree, _FindBAMBit, _NxtBlkAlloc, _BlkAlloc, _ChkDkGEOS, _SetGEOSDisk, WriteBuff, ReadBuff, Get1stDirEntry, GetNxtDirEntry

.segment "drv1541"

DriveAddy = $0300

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

__GetDirHead:
	;904e
	jsr SetDirHead
	bne __GetBlock
_ReadBuff:
	LoadW r4, diskBlkBuf ;9053
__GetBlock:
	jsr EnterTurbo ;905b
	bnex GetBlk0
	jsr InitForIO
	jsr ReadBlock
	jsr DoneWithIO
GetBlk0:
	rts ;906a

__PutDirHead:
	;906b
	jsr SetDirHead
	bne __PutBlock
_WriteBuff:
	LoadW r4, diskBlkBuf ;9070
__PutBlock:
	jsr EnterTurbo ;9078
	bnex PutBlk1
	jsr InitForIO
	jsr WriteBlock
	bnex PutBlk0
	jsr VerWriteBlock
PutBlk0:
	jsr DoneWithIO ;908a
PutBlk1:
	rts ;908d

SetDirHead:
	LoadB r1L, DIR_TRACK ;908e
	LoadB r1H, 0
	sta r4L
	LoadB r4H, (>curDirHead)
	rts

CheckParams:
	bbrf 6, curType, CheckParams_1 ;909d
	jsr DoCacheVerify
	beq CheckParams_2
CheckParams_1:
	lda #0 ;90a7
	sta errCount
	ldx #INV_TRACK
	lda r1L
	beq CheckParams_2
	cmp #N_TRACKS+1
	bcs CheckParams_2
	sec
	rts
CheckParams_2:
	clc ;90b8
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
	bbrf 6, tmpDriveType, OpenDsk0
	jsr DoCacheVerify
	beq OpenDsk0
	jsr DoClearCache
	jsr SetDirHead
	jsr DoCacheWrite
OpenDsk0:
	LoadW r5, curDirHead ;90e7
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
	lda tmpDriveType ;910a
	ldy curDrive
	sta _driveType,y
	rts
tmpDriveType:
	.byte 0 ;9114

__BlkAlloc:
	;9115
	ldy #1
	sty r3L
	dey
	sty r3H
__NxtBlkAlloc:
	PushW r9 ;911c
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
	LoadW r5, curDirHead ;9141
	jsr CalcBlksFree
	PopW r3
	ldx #INSUFF_SPACE
	CmpW r2, r4
	beq BlkAlc1
	bcs BlkAlc4
BlkAlc1:
	MoveW r6, r4 ;9162
	MoveW r2, r5
BlkAlc2:
	jsr SetNextFree ;9172
	bnex BlkAlc4
	ldy #0
	lda r3L
	sta (r4),y
	iny
	lda r3H
	sta (r4),y
	AddVW 2, r4
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
	clc ;91a8
	adc #1
	sta (r4),y
	ldx #0
BlkAlc4:
	PopW r9 ;91af
	rts

_Get1stDirEntry:
	;91b6
	LoadB r1L, DIR_TRACK
	LoadB r1H, 1
	jsr ReadBuff
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
	lda #0
	sta borderFlag
	rts

_GetNxtDirEntry:
	;91cf
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
	jsr ReadBuff ;920b
	ldy #0
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
GNDirEntry1:
	rts ;9218

_GetBorder:
	;9219
	jsr GetDirHead
	bnex GetBord2
	LoadW r5, curDirHead
	jsr ChkDkGEOS
	bne GetBord0
	ldy #$ff
	bne GetBord1
GetBord0:
	MoveW curDirHead+OFF_OP_TR_SC, r1 ;9230
	ldy #0
GetBord1:
	ldx #0 ;923c
GetBord2:
	rts ;923e

__ChkDkGEOS:
	;923f
	ldy #OFF_GS_ID
	ldx #0
	LoadB isGEOS, FALSE
ChkDkG0:
	lda (r5),y ;9248
	cmp GEOSDiskID,x
	bne ChkDkG1
	iny
	inx
	cpx #11
	bne ChkDkG0
	LoadB isGEOS, $ff
ChkDkG1:
	lda isGEOS ;925a
	rts

GEOSDiskID:
	.byte "GEOS format V1.0",NULL ;925e

__GetFreeDirBlk:
	;926f
	php
	sei
	PushB r6L
	PushW r2
	ldx r10L
	inx
	stx r6L
	LoadB r1L, DIR_TRACK
	LoadB r1H, 1
GFDirBlk0:
	jsr ReadBuff ;9287
GFDirBlk1:
	bnex GFDirBlk5 ;928a
	dec r6L
	beq GFDirBlk3
GFDirBlk11:
	lda diskBlkBuf ;9291
	bne GFDirBlk2
	jsr AddDirBlock
	bra GFDirBlk1
GFDirBlk2:
	sta r1L ;929c
	MoveB diskBlkBuf+1, r1H
	bra GFDirBlk0
GFDirBlk3:
	ldy #FRST_FILE_ENTRY ;92a6
	ldx #0
GFDirBlk4:
	lda diskBlkBuf,y ;92aa
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
	PopW r2 ;92c5
	PopB r6L
	plp
	rts

_AddDirBlock:
	;92d0
	PushW r6
	ldy #$48
	ldx #FULL_DIRECTORY
	lda curDirHead,y
	beq ADirBlk0
	MoveW r1, r3
	jsr SetNextFree
	MoveW r3, diskBlkBuf
	jsr WriteBuff
	bnex ADirBlk0
	MoveW r3, r1
	jsr ClearAndWrite
ADirBlk0:
	PopW r6 ;9305
	rts

ClearAndWrite:
	lda #0 ;930c
	tay
CAndWr0:
	sta diskBlkBuf,y ;930f
	iny
	bne CAndWr0
	dey
	sty diskBlkBuf+1
	jmp WriteBuff

__SetNextFree:
	;931c
	lda r3H
	add interleave
	sta r6H
	MoveB r3L, r6L
	cmp #25
	bcc SNxtFree0
	dec r6H
SNxtFree0:
	cmp #DIR_TRACK ;932e
	beq SNxtFree1
SNxtFree00:
	lda r6L ;9332
	cmp #DIR_TRACK
	beq SNxtFree3
SNxtFree1:
	asl ;9338
	asl
	tax
	lda curDirHead,x
	beq SNxtFree3
	lda r6L
	jsr SNxtFreeHelp
	lda SecScTab,x
	sta r7L
	tay
SNxtFree2:
	jsr SNxtFreeHelp2 ;934b
	beq SNxtFree4
	inc r6H
	dey
	bne SNxtFree2
SNxtFree3:
	inc r6L ;9355
	CmpBI r6L, N_TRACKS+1
	bcs SNxtFree5
	sub r3L
	sta r6H
	asl
	adc #4
	adc interleave
	sta r6H
	bra SNxtFree00
SNxtFree4:
	MoveW r6, r3 ;936d
	ldx #0
	rts
SNxtFree5:
	ldx #INSUFF_SPACE ;9378
	rts

SNxtFreeHelp:
	ldx #0 ;937b
SNFHlp0:
	cmp SecTrTab,x ;937d
	bcc SNFHlp1
	inx
	bne SNFHlp0
SNFHlp1:
	rts ;9385

SecTrTab:
	.byte 18, 25, 31, 36 ;9386
SecScTab:
	.byte 21, 19, 18, 17 ;938a

SNxtFreeHelp2:
	lda r6H ;938e
SNFHlp2_1:
	cmp r7L ;9390
	bcc SNFHlp2_2
	sub r7L
	bra SNFHlp2_1
SNFHlp2_2:
	sta r6H ;939a

_AllocateBlock:
	jsr FindBAMBit ;939c
	beq SNFHlp2_3
	lda r8H
	eor #$ff
	and curDirHead,x
	sta curDirHead,x
	ldx r7H
	dec curDirHead,x
	ldx #0
	rts
SNFHlp2_3:
	ldx #BAD_BAM ;93b3
	rts

__FindBAMBit:
	;93b6
	lda r6L
	asl
	asl
	sta r7H
	lda r6H
	and #%00000111
	tax
	lda FBBBitTab,x
	sta r8H
	lda r6H
	lsr
	lsr
	lsr
	sec
	adc r7H
	tax
	lda curDirHead,x
	and r8H
	rts

FBBBitTab:
	.byte $01, $02, $04, $08 ;93d5
	.byte $10, $20, $40, $80

__FreeBlock:
	;93dd
	jsr FindBAMBit
	bne FreeBlk0
	lda r8H
	eor curDirHead,x
	sta curDirHead,x
	ldx r7H
	inc curDirHead,x
	ldx #0
	rts
FreeBlk0:
	ldx #BAD_BAM ;93f2
	rts

__CalcBlksFree:
	;93f5
	LoadW r4, 0
	ldy #OFF_TO_BAM
CBlksFre0:
	lda (r5),y ;93fd
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre1:
	tya ;94f8
	clc
	adc #4
	tay
	cpy #$48
	beq CBlksFre1
	cpy #$90
	bne CBlksFre0
	LoadW r3, $0298
	rts

__SetGEOSDisk:
	;941e
	jsr GetDirHead
	bnex SetGDisk2
	LoadW r5, curDirHead
	jsr CalcBlksFree
	ldx #INSUFF_SPACE
	lda r4L
	ora r4H
	beq SetGDisk2
	LoadB r3L, DIR_TRACK+1
	LoadB r3H, 0
	jsr SetNextFree
	beqx SetGDisk0
	LoadB r3L, 1
	jsr SetNextFree
	bnex SetGDisk2
SetGDisk0:
	MoveW r3, r1 ;944f
	jsr ClearAndWrite
	bnex SetGDisk2
	MoveW r1, curDirHead+OFF_OP_TR_SC
	ldy #OFF_GS_ID+15
	ldx #15
SetGDisk1:
	lda GEOSDiskID,x ;946b
	sta curDirHead,y
	dey
	dex
	bpl SetGDisk1
	jsr PutDirHead
SetGDisk2:
	rts ;9478

__InitForIO:
	;9479
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
	lda rasreg ;94dc
	cmp TURBO_DD00_CPY
	beq IniForIO0
	sta TURBO_DD00_CPY
	dey
	bne IniForIO0
	lda cia2base
	and #%00000111
	sta TURBO_DD00
	sta tmpDD00
	ora #%00110000
	sta TURBO_DD00_CPY
	lda TURBO_DD00
	ora #%00010000
	sta tmpDD00_2
	rts

D_IRQHandler:
	pla ;94fe
	tay
	pla
	tax
	pla
D_NMIHandler:
	rti ;9503

__DoneWithIO:
	sei ;9504
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
;952a
NibbleTab:
	.byte $0f, $07, $0d, $05, $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04, $0a, $02, $08
NibbleTab2:
	.byte $00 ;9539
	.byte $80, $20, $a0, $40, $c0, $60, $e0, $10
	.byte $90, $30, $b0, $50, $d0, $70, $f0

Hst_RecvByte:
	jsr GetSync ;9549
	pha
	pla
	pha
	pla
	sty z8d
Hst_RecvByte_0:
	sec ;9552
Hst_RecvByte_1:
	lda rasreg ;9553
	sbc #$31
	bcc Hst_RecvByte_2
	and #6
	beq Hst_RecvByte_1
Hst_RecvByte_2:
	MoveB TURBO_DD00_CPY, cia2base ;955e
	lda z8b
	MoveB TURBO_DD00, cia2base
	dec z8d
	nop
	nop
	nop
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
	ldx tmpDD00_2 ;9591
	stx cia2base
	rts

Hst_SendByte:
	jsr GetSync ;9598
	tya
	pha
	ldy #0
	jsr Hst_SendByte_01
	pla
	tay
	jsr GetSync
Hst_SendByte_0:
	dey ;95a7
	lda (z8b),y
	ldx TURBO_DD00
	stx cia2base
Hst_SendByte_01:
	tax ;95af
	and #%00001111
	sta z8d
	sec
Hst_SendByte_1:
	lda rasreg ;95b5
	sbc #$31
	bcc Hst_SendByte_2
	and #6
	beq Hst_SendByte_1
Hst_SendByte_2:
	txa ;95c0
	ldx TURBO_DD00_CPY
	stx cia2base
	and #%11110000
	ora TURBO_DD00
	sta cia2base
	ror
	ror
	and #%11110000
	ora tmpDD00
	sta cia2base
	ldx z8d
	lda NibbleTab2,x
	ora TURBO_DD00
	sta cia2base
	ror
	ror
	and #%11110000
	ora TURBO_DD00
	cpy #0
	sta cia2base
	bne Hst_SendByte_0
	nop
	nop
	beq Hst_RecvByte_3

SendDOSCmd:
	stx z8c ;95f2
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
	lda (z8b),y ;960f
	jsr $ffa8
	iny
	cpy #5
	bcc SndDOSCmd0
	ldx #0
	rts
SndDOSCmd1:
	jsr $ffae ;961c
	ldx #DEV_NOT_FOUND
	rts

DUNK4:
	stx z8c ;9622
	sta z8b
	ldy #2
	bne DUNK4_3
DUNK4_1:
	stx z8c ;962a
	sta z8b
DUNK4_2:
	ldy #4 ;962e
	lda r1H
	sta DTrkSec+1
	lda r1L
	sta DTrkSec
DUNK4_3:
	lda z8c ;963a
	sta DExeProc+1
	lda z8b
	sta DExeProc
	lda #>DExeProc
	sta z8c
	lda #<DExeProc
	sta z8b
	jmp Hst_SendByte

DUNK5:
	ldy #1 ;964f
	jsr Hst_RecvByte
	pha
	tay
	jsr Hst_RecvByte
	pla
	tay
	rts

GetSync:
	sei ;965c
	MoveB TURBO_DD00, cia2base
GetSync0:
	bbrf 7, cia2base, GetSync0
	rts

__EnterTurbo:
	;9668
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
	and #%01000000 ;9684
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
	dey ;969b
	bne EntTur1
	jsr Hst_RecvByte_3
EntTur2:
	bbsf 7, cia2base, EntTur2 ;96a1
	jsr DoneWithIO
	ldx curDrive
	lda _turboFlags,x
	ora #%01000000
	sta _turboFlags,x
EntTur3:
	ldx #0 ;96b4
	beq EntTur5
EntTur4:
	jsr DoneWithIO ;96b8
EntTur5:
	rts ;96bb

EnterCommand:
	.byte "M-E" ;96bc
	.word DriveStart

SendExitTurbo:
	jsr InitForIO ;96c1
	ldx #>Drv_ExitTurbo
	lda #<Drv_ExitTurbo
	jsr DUNK4
	jsr GetSync
	lda curDrive
	jsr $ffb1
	lda #$ef
	jsr $ff93
	jsr $ffae
	jmp DoneWithIO

SendCODE:
	jsr InitForIO ;96df
	lda #>DriveCode
	sta z8e
	lda #<DriveCode
	sta z8d
	lda #>DriveAddy
	sta WriteAddy+1
	lda #<DriveAddy
	sta WriteAddy
	LoadB z8f, $1b
SndCDE0:
	jsr SendCHUNK ;96f8
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
	jmp DoneWithIO ;971b

SendCHUNK:
	lda z8f ;971e
	ora NUMDRV
	beq SndCHNK1
	ldx #>WriteCommand
	lda #<WriteCommand
	jsr SendDOSCmd
	bnex SndCHNK2
	lda #$20
	jsr $ffa8
	ldy #0
SndCHNK0:
	lda (z8d),y ;9736
	jsr $ffa8
	iny
	cpy #$20
	bcc SndCHNK0
	jsr $ffae
SndCHNK1:
	ldx #0 ;9743
SndCHNK2:
	rts ;9745

WriteCommand:
	.byte "M-W" ;9746
WriteAddy:
	.word $0300 ;9749

__ExitTurbo:
	;974b
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
ExiTur0:
	pla ;9765
	tax
	rts

__PurgeTurbo:
	;9768
	jsr ClearCache
	jsr ExitTurbo
PurTur0:
	ldy curDrive ;976e
	lda #0
	sta _turboFlags,y
	rts

__NewDisk:
	;9777
	jsr EnterTurbo
	bnex NewDsk2
	jsr ClearCache
	jsr InitForIO
	lda #0
	sta errCount
NewDsk0:
	lda #>Drv_NewDisk ;9788
	sta z8c
	lda #<Drv_NewDisk
	sta z8b
	jsr DUNK4_2
	jsr GetDOSError
	beq NewDsk1
	inc errCount
	cpy errCount
	beq NewDsk1
	bcs NewDsk0
NewDsk1:
	jsr DoneWithIO ;97a2
NewDsk2:
	rts ;97a5

__ChangeDiskDevice:
	;97a6
	pha
	jsr EnterTurbo
	bnex ChngDskDv0
	pla
	pha
	ora #%00100000
	sta r1L
	jsr InitForIO
	ldx #>Drv_ChngDskDev
	lda #<Drv_ChngDskDev
	jsr DUNK4_1
	jsr DoneWithIO
	jsr PurTur0
	pla
	tax
	lda #%11000000
	sta _turboFlags,x
	stx curDrive
	stx curDevice
	ldx #0
	rts
ChngDskDv0:
	pla ;97d2
	rts

__ReadBlock:
	;97d4
_ReadLink:
	jsr CheckParams_1
	bcc RdBlock2
	bbrf 6, curType, RdBlock0
	jsr DoCacheRead
	bne RdBlock2
RdBlock0:
	ldx #>Drv_ReadSec ;97e3
	lda #<Drv_ReadSec
	jsr DUNK4_1
	ldx #>Drv_SendByte
	lda #<Drv_SendByte
	jsr DUNK4
	MoveW r4, z8b
	ldy #0
	jsr Hst_RecvByte
	jsr GetDError
	beqx RdBlock1
	inc errCount
	cpy errCount
	beq RdBlock1
	bcs RdBlock0
RdBlock1:
	bnex RdBlock2 ;980e
	bbrf 6, curType, RdBlock2
	jsr DoCacheWrite
	bra RdBlock2
RdBlock2:
	ldy #0 ;981c
	rts

__WriteBlock:
	;981f
	jsr CheckParams
	bcc WrBlock2
WrBlock1:
	ldx #>Drv_WriteSec ;9824
	lda #<Drv_WriteSec
	jsr DUNK4_1
	MoveW r4, z8b
	ldy #0
	jsr Hst_SendByte
	jsr GetDOSError
	beq WrBlock2
	inc errCount
	cpy errCount
	beq WrBlock2
	bcs WrBlock1
WrBlock2:
	rts ;9847

__VerWriteBlock:
	;9848
	jsr CheckParams
	bcc VWrBlock3
VWrBlock0:
	lda #3 ;984d
	sta tryCount
VWrBlock1:
	ldx #>Drv_ReadSec ;9852
	lda #<Drv_ReadSec
	jsr DUNK4_1
	jsr GetDOSError
	beqx VWrBlock2
	dec tryCount
	bne VWrBlock1
	ldx #$25
	inc errCount
	lda errCount
	cmp #5
	beq VWrBlock2
	pha
	jsr WriteBlock
	pla
	sta errCount
	beqx VWrBlock0
VWrBlock2:
	bnex VWrBlock3 ;987b
	bbrf 6, curType, VWrBlock3
	jmp DoCacheWrite
VWrBlock3:
	rts ;9886

GetDOSError:
	ldx #>Drv_SendByte_0 ;9887
	lda #<Drv_SendByte_0
	jsr DUNK4
GetDError:
	lda #>errStore ;988e
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
	cmp #1
	beq GetDErr1
	addv $1e
	bne GetDErr2
GetDErr1:
	lda #0 ;98ac
GetDErr2:
	tax ;98ae
	rts

DOSErrTab:
	.byte $01, $05, $02, $08 ;98b0
	.byte $08, $01, $05, $01
	.byte $05, $05, $05

DriveCode:
	;98bb
.segment "drv1541_drivecode"
;		.org DriveAddy

DNibbleTab:
	.byte $0f, $07, $0d, $05 ;0300
	.byte $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04
	.byte $0a, $02, $08, $00
	;0310
DNibbleTab2:
	.byte $00, $80, $20, $a0
	.byte $40, $c0, $60, $e0
	.byte $10, $90, $30, $b0
	.byte $50, $d0, $70, $f0
	;0320
Drv_SendByte:
	ldy #0
	jsr Drv_SendByte_1
Drv_SendByte_0:
	ldy #0 ;0325
	sty $73
	sty $74
	iny
	sty $71
	ldy #0
	jsr D_DUNK4_1
	lda $71
	jsr Drv_SendByte_3
	ldy $71
Drv_SendByte_1:
	jsr D_DUNK4_1 ;033a
Drv_SendByte_2:
	dey ;033d
	lda ($73),y
Drv_SendByte_3:
	tax ;0340
	lsr
	lsr
	lsr
	lsr
	sta $70
	txa
	and #%00001111
	tax
	lda #4
	sta $1800
	bit $1800
	beq *-3
	bit $1800
	bne *+2
	bne *+2
	stx $1800
	txa
	rol
	and #%00001111
	sta $1800
	ldx $70
	lda DNibbleTab,x
	sta $1800
	nop
	rol
	and #%00001111
	cpy #0
	sta $1800
	bne Drv_SendByte_2
	beq Drv_RecvByte_2

Drv_RecvWord:
	ldy #1 ;037b
	jsr Drv_RecvByte
	sta $71
	tay
	jsr Drv_RecvByte
	ldy $71
	rts

Drv_RecvByte:
	jsr D_DUNK4_1 ;0389
Drv_RecvByte_1:
	pha ;038c
	pla
	lda #4
	bit $1800
	beq *-3
	nop
	nop
	nop
	lda $1800
	asl
	nop
	nop
	nop
	nop
	ora $1800
	and #%00001111
	tax
	nop
	nop
	nop
	lda $1800
	asl
	pha
	lda $70
	pla
	ora $1800
	and #%00001111
	ora DNibbleTab2,x
	dey
	sta ($73),y
	bne Drv_RecvByte_1
Drv_RecvByte_2:
	ldx #2 ;03be
	stx $1800
	rts

D_DUNK4:
	dec $48 ;03c4
	bne D_DUNK4_1
	jsr D_DUNK8_2
D_DUNK4_1:
	LoadB $1805, $c0 ;03cb
D_DUNK4_2:
	bbrf 7, $1805, D_DUNK4 ;03d0
	lda #4
	bit $1800
	bne D_DUNK4_2
	LoadB $1800, 0
	rts

DriveStart:
	php ;03e2
	sei
	PushB $49
	lda $180f
	and #%11011111
	sta $180f
	ldy #0
	dey
	bne *-1
	jsr Drv_RecvByte_2
	lda #4
	bit $1800
	beq *-3
DriveLoop:
	jsr D_DUNK8 ;03fe
	lda #>DExecAddy
	sta $74
	lda #<DExecAddy
	sta $73
	jsr Drv_RecvWord
	jsr D_DUNK8_1
	LoadW $73, $0700
	lda #>(DriveLoop-1)
	pha
	lda #<(DriveLoop-1)
	pha
	jmp (DExecAddy)

Drv_ExitTurbo:
	jsr D_DUNK4_1 ;0420
	LoadB $33, 0
	sta $1800
	jsr $f98f
	LoadB $1c0c, $ec
	pla
	pla
	PopB $49
	plp
	rts

Drv_ChngDskDev:
	lda DDatas ;0439
	sta $77
	eor #$60
	sta $78
	rts

D_DUNK5:
	jsr D_DUNK12 ;0443
	lda $22
	beq D_DUNK5_1
	ldx $00
	dex
	beq D_DUNK5_2
D_DUNK5_1:
	PushB $12 ;044f
	PushB $13
	jsr Drv_NewDisk_1
	PopB $13
	tax
	PopB $12
	ldy $00
	cpy #$01
	bne D_DUNK5_41
	cpx $17
	bne D_DUNK5_5
	cmp $16
	bne D_DUNK5_5
	lda #0
D_DUNK5_2:
	pha ;046f
	lda $22
	ldx #$ff
	sec
	sbc DDatas
	beq D_DUNK5_4
	bcs D_DUNK5_3
	eor #$ff
	adc #1
	ldx #1
D_DUNK5_3:
	jsr D_DUNK6 ;0482
	lda DDatas
	sta $22
	jsr Drv_NewDisk_6
D_DUNK5_4:
	pla ;048d
D_DUNK5_41:
	rts ;048e
D_DUNK5_5:
	LoadB $00, $0b ;048f
	rts

D_DUNK6:
	stx $4a ;0494
	asl
	tay
	lda $1c00
	and #$fe
	sta $70
	lda #$1e
	sta $71
D_DUNK6_1:
	lda $70 ;04a3
	add $4a
	eor $70
	and #%00000011
	eor $70
	sta $70
	sta $1c00
	lda $71
	jsr D_DUNK6_4
	lda $71
	cpy #5
	bcc D_DUNK6_2
	cmp #$11
	bcc D_DUNK6_3
	sbc #2
	bne D_DUNK6_3
D_DUNK6_2:
	cmp #$1c ;04c6
	bcs D_DUNK6_3
	adc #4
D_DUNK6_3:
	sta $71 ;04cc
	dey
	bne D_DUNK6_1
	lda #$4b
D_DUNK6_4:
	sta $1805 ;04d3
	lda $1805
	bne *-3
	rts

Drv_NewDisk:
	jsr D_DUNK12 ;04dc
Drv_NewDisk_1:
	ldx $00 ;04df
	dex
	beq Drv_NewDisk_2
	ldx #$ff
	lda #$01
	jsr D_DUNK6
	ldx #$01
	txa
	jsr D_DUNK6
	lda #$ff
	jsr D_DUNK6_4
Drv_NewDisk_2:
	LoadB $70, $04 ;04f6
Drv_NewDisk_3:
	jsr D_DUNK11 ;04fa
	ldx $18
	stx $22
	ldy $00
	dey
	beq Drv_NewDisk_5
	dec $70
	bmi Drv_NewDisk_4
	ldx $70
	jsr Drv_NewDisk_7
	sec
	bcs Drv_NewDisk_3
Drv_NewDisk_4:
	LoadB $22, 0 ;0512
	rts
Drv_NewDisk_5:
	txa ;0517
Drv_NewDisk_6:
	jsr $f24b ;0518
	sta $43
Drv_NewDisk_7:
	lda $1c00 ;051d
	and #$9f
	ora DTrackTab,x
Drv_NewDisk_8:
	sta $1c00 ;0525
	rts

D_DUNK8:
	lda #$f7 ;0529
	bne D_DUNK8_3
D_DUNK8_1:
	lda #$08 ;052d
	ora $1c00
	bne Drv_NewDisk_8
D_DUNK8_2:
	LoadB $20, 0 ;0534
	LoadB $3e, $ff
	lda #$fb
D_DUNK8_3:
	and $1c00 ;053e
	jmp Drv_NewDisk_8

DTrackTab:
	.byte $00, $20, $40, $60 ;0544

D_DUNK9:
	tax ;0548
	bbrf 7, $20, D_DUNK9_0
	jsr D_DUNK12_1
	LoadB $20, $20
	ldx #0
D_DUNK9_0:
	cpx $22 ;0556
	beq D_DUNK9_1
	jsr Drv_NewDisk_2
	cmp #1
	bne D_DUNK9_1
	ldy $19
	iny
	cpy $43
	bcc *+4
	ldy #0
	sty $19
	LoadB $45, 0
	LoadW $32, $0018
	jsr D_DUNK11_1
D_DUNK9_1:
	rts ;057b

Drv_WriteSec:
	jsr D_DUNK5 ;057c
	ldx $00
	dex
	bne D_DUNK10_1
	jsr D_DUNK9
D_DUNK10_1:
	jsr Drv_RecvWord ;0587
	lda #$10
	bne D_DUNK10_2
Drv_ReadSec:
	jsr D_DUNK5 ;058e
	lda #0
D_DUNK10_2:
	ldx $00 ;0593
	dex
	beq D_DUNK11_0
	rts

D_DUNK11:
	lda #$30 ;0599
D_DUNK11_0:
	sta $45 ;059b
	lda #>DDatas
	sta $33
	lda #<DDatas
	sta $32
D_DUNK11_1:
	LoadB $31, 7 ;05a5
	tsx
	stx $49
	ldx #1
	stx $00
	dex
	stx $3f
	LoadB $1c0c, $ee
	lda $45
	cmp #$10
	beq D_DUNK11_3
	cmp #$30
	beq D_DUNK11_2
	jmp $f4ca
D_DUNK11_2:
	jmp $f3b1 ;05c5
D_DUNK11_3:
	jsr $f5e9 ;05c8
	sta $3a
	lda $1c00
	and #$10
	bne D_DUNK11_4
	lda #$08
	bne D_DUNK11_9
D_DUNK11_4:
	jsr $f78f ;05d8
	jsr $f510
	ldx #9
D_DUNK11_5:
	bvc D_DUNK11_5 ;05e0
	clv
	dex
	bne D_DUNK11_5
	lda #$ff
	sta $1c03
	lda $1c0c
	and #$1f
	ora #$c0
	sta $1c0c
	lda #$ff
	ldx #5
	sta $1c01
	clv
D_DUNK11_6:
	bvc D_DUNK11_6 ;05fd
	clv
	dex
	bne D_DUNK11_6
	ldy #$bb
D_DUNK11_7:
	lda $0100,y ;0605
	bvc *
	clv
	sta $1c01
	iny
	bne D_DUNK11_7
D_DUNK11_8:
	lda ($30),y ;0611
	bvc *
	clv
	sta $1c01
	iny
	bne D_DUNK11_8
	bvc *
	lda $1c0c
	ora #$e0
	sta $1c0c
	LoadB $1c03, 0
	sta $50
	lda #1
D_DUNK11_9:
	sta $00 ;062f
	rts

D_DUNK12:
	lda $20 ;0632
	and #$20
	bne D_DUNK12_3
	jsr $f97e
D_DUNK12_1:
	ldy #$80 ;063b
D_DUNK12_2:
	dex ;063d
	bne D_DUNK12_2
	dey
	bne D_DUNK12_2
	sty $3e
D_DUNK12_3:
	LoadB $48, $ff ;0645
	rts

DExecAddy:
	.word 0 ;064a
DDatas:
	;.word 0 ;064c
;064c
.segment "drv1541_b"

ClrCacheDat:
	.word 0 ;9c07

ClearCache:
	bbsf 6, curType, DoClearCache ;9c09
	rts
DoClearCache:
	LoadW r0, ClrCacheDat ;9c0f
	ldy #0
	sty r1L
	sty r1H
	sty r2H
	iny
	iny
	sty r2L
	iny
	sty r3H
	ldy curDrive
	lda driveData,y
	sta r3L
DoClrCache1:
	jsr StashRAM ;9c2e
	inc r1H
	bne DoClrCache1
	inc r3L
	dec r3H
	bne DoClrCache1
	rts

DoCacheRead:
	ldy #%10010001 ;9c3c
	jsr DoCacheDisk
	ldy #0
	lda (r4),y
	iny
	ora (r4),y
	rts

GiveNoError:
	ldx #0 ;9c49
	rts

DoCacheVerify:
	ldy #%10010011 ;9c4c
	jsr DoCacheDisk
	and #$20
	rts

DoCacheWrite:
	ldy #%10010000 ;9c54
DoCacheDisk:
	PushW r0 ;9c56
	PushW r1
	PushW r2
	PushB r3L
	tya
	pha
	ldy r1L
	dey
	lda CacheTabL,y
	add r1H
	sta r1H
	lda CacheTabH,y
	ldy curDrive
	adc driveData,y
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
	tax
	PopB r3L
	PopW r2
	PopW r1
	PopW r0
	txa
	ldx #0
	rts

CacheTabL:
	;9cb3
	.byte $00, $15, $2a, $3f, $54, $69, $7e, $93
	.byte $a8, $bd, $d2, $e7, $fc, $11, $26, $3b
	.byte $50, $65, $78, $8b, $9e, $b1, $c4, $d7
	.byte $ea, $fc, $0e, $20, $32, $44, $56, $67
	.byte $78, $89, $9a, $ab
CacheTabH:
	;9cd7
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $01, $01, $01
	.byte $01, $01, $01, $01, $01, $01, $01, $01
	.byte $01, $01, $02, $02, $02, $02, $02, $02
	.byte $02, $02, $02, $02

tmpclkreg:
	.byte 0 ;9cfb
tmpPS:
	.byte 0 ;9cfc
tmpgrirqen:
	.byte 0 ;9cfd
tmpCPU_DATA:
	.byte 0 ;9cfe
tmpmobenble:
	.byte 0 ;9cff
	.byte 0 ;9d00
DExeProc:
	.word 0 ;9d01
DTrkSec:
	.word 0 ;9d03
tmpDD00:
	.byte 0 ;9d05
tmpDD00_2:
	.byte 0 ;9d06
errCount:
	.byte 0 ;9d07
errStore:
	.byte 0 ;9d08
tryCount:
	.byte 0 ;9d09
borderFlag:
	.byte 0 ;9d0a
