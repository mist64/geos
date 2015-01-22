.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import ExitTurbo, SetDevice, PutDirHead, FindBAMBit, SetNextFree, CalcBlksFree, Ddiv, CopyFString, GetPtrCurDkNm, ChkDkGEOS, GetDirHead, NewDisk, VerWriteBlock, WriteBlock, DoneWithIO, ReadBlock, InitForIO, EnterTurbo
.global Get1stDirEntry, GetNxtDirEntry, ReadBuff, WriteBuff, _BlkAlloc, _CalcBlksFree, _ChangeDiskDevice, _ChkDkGEOS, _DoneWithIO, _EnterTurbo, _ExitTurbo, _FindBAMBit, _FreeBlock, _GetBlock, _GetDirHead, _GetFreeDirBlk, _InitForIO, _NewDisk, _NxtBlkAlloc, _OpenDisk, _PurgeTurbo, _PutBlock, _PutDirHead, _ReadBlock, _SetGEOSDisk, _SetNextFree, _VerWriteBlock, _WriteBlock
.segment "drv1571"

;GEOS 1571 disk driver
;reassembled by Maciej 'YTM/Elysium' Witkowiak
;25-26.02.2002, 2-4.03.2002


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
	jsr SetDirHead_1 ;904e
	jsr __GetBlock
	bnex GDH_0
	ldy curDrive
	lda curDirHead+3
	sta e88b7,y
	bpl GDH_0
	jsr SetDirHead_2
	jsr __GetBlock
	lda #6
	bne GDH_1
GDH_0:
	lda #8 ;906c
GDH_1:
	sta interleave ;906e
	rts

_ReadBuff:
	LoadW r4, diskBlkBuf ;9072
__GetBlock:
	jsr EnterTurbo ;907a
	bne GetBlk0
	jsr InitForIO
	jsr ReadBlock
	jsr DoneWithIO
GetBlk0:
	rts ;9088

__PutDirHead:
	jsr EnterTurbo ;9089
	jsr InitForIO
	jsr SetDirHead_1
	jsr WriteBlock
	bnex PDH_1
	ldy curDrive
	lda curDirHead+3
	sta e88b7,y
	bpl PDH_0
	jsr SetDirHead_2
	jsr WriteBlock
	bnex PDH_1
PDH_0:
	jsr SetDirHead_1 ;90ac
	jsr VerWriteBlock
	bnex PDH_1
	bbrf 7, curDirHead+3, PDH_1
	jsr SetDirHead_2
	jsr VerWriteBlock
PDH_1:
	jmp DoneWithIO ;90c3

_WriteBuff:
	LoadW r4, diskBlkBuf ;90c6
__PutBlock:
	jsr EnterTurbo ;90ce
	bne PutBlk1
	jsr InitForIO
	jsr WriteBlock
	bnex PutBlk0
	jsr VerWriteBlock
PutBlk0:
	jsr DoneWithIO ;90df
PutBlk1:
	rts ;90e2

SetDirHead_1:
	ldy #$12 ;90e3
	lda #>curDirHead
	bne SDH_1
SetDirHead_2:
	ldy #$35 ;90e9
	lda #>dir2Head
SDH_1:
	sty r1L ;90ed
	sta r4H
	lda #0
	sta r1H
	sta r4L
	rts

CheckParams:
	lda #0 ;90f8
	sta errCount
	ldx #INV_TRACK
	lda r1L
	beq CheckParams_2
	cmp #$24
	bcc CheckParams_1
	ldy curDrive
	lda e88b7,y
	bpl CheckParams_2
	lda r1L
	cmp #$47
	bcs CheckParams_2
CheckParams_1:
	sec ;9115
	rts
CheckParams_2:
	clc ;9117
	rts

__OpenDisk:
	;9119
	jsr NewDisk
	bnex OpenDsk1
	jsr GetDirHead
	bnex OpenDsk1
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
	rts ;9143

__BlkAlloc:
	;9144
	ldy #1
	sty r3L
	dey
	sty r3H
__NxtBlkAlloc:
	PushW r9 ;914b
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
	jsr SetCurDHVec ;9170
	jsr CalcBlksFree
	PopW r3
	ldx #INSUFF_SPACE
	CmpW r2, r4
	beq BlkAlc1
	bcs BlkAlc4
BlkAlc1:
	MoveW r6, r4 ;918c
	MoveW r2, r5
BlkAlc2:
	jsr SetNextFree ;919c
	bnex BlkAlc4
	ldy #0
	lda r3L
	sta (r4),y
	iny
	lda r3H
	sta (r4),y
	AddVW 2, r4
BlkAlc2_1:
	lda r5L ;91b8
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
	clc ;91d2
	adc #1
	sta (r4),y
	ldx #0
BlkAlc4:
	PopW r9 ;91d9
	rts

SetCurDHVec:
	LoadW r5, curDirHead ;91e0
	rts

_Get1stDirEntry:
	;91e9
	LoadB r1L, 18
	ldy #1
	sty r1H
	dey
	sty borderFlag
	beq GNDirEntry0

_GetNxtDirEntry:
	;91f7
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
	jsr ReadBuff ;9233
	ldy #0
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
GNDirEntry1:
	rts ;9240

_GetBorder:
	;9241
	jsr GetDirHead
	bnex GetBord2
	jsr SetCurDHVec
	jsr ChkDkGEOS
	bne GetBord0
	ldy #$ff
	bne GetBord1
GetBord0:
	MoveW curDirHead+OFF_OP_TR_SC, r1 ;9253
	ldy #0
GetBord1:
	ldx #0 ;925f
GetBord2:
	rts ;9261

__ChkDkGEOS:
	;9262
	ldy #OFF_GS_ID
	ldx #0
	stx isGEOS
ChkDkG0:
	lda (r5),y ;9269
	cmp GEOSDiskID,x
	bne ChkDkG1
	iny
	inx
	cpx #11
	bne ChkDkG0
	LoadB isGEOS, $ff
ChkDkG1:
	lda isGEOS ;927b
	rts

GEOSDiskID:
	.byte "GEOS format V1.0",NULL ;927f

__GetFreeDirBlk:
	;9290
	php
	sei
	PushB r6L
	PushW r2
	ldx r10L
	inx
	stx r6L
	LoadB r1L, 18
	LoadB r1H, 1
GFDirBlk0:
	jsr ReadBuff ;92a8
GFDirBlk1:
	bnex GFDirBlk5 ;92ab
	dec r6L
	beq GFDirBlk3
GFDirBlk11:
	lda diskBlkBuf ;92b2
	bne GFDirBlk2
	jsr AddDirBlock
	bra GFDirBlk1
GFDirBlk2:
	sta r1L ;92bd
	MoveB diskBlkBuf+1, r1H
	bra GFDirBlk0
GFDirBlk3:
	ldy #FRST_FILE_ENTRY ;92c7
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
	PopW r2 ;92e6
	PopB r6L
	plp
	rts

_AddDirBlock:
	;92f1
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
	PopW r6 ;9326
	rts

ClearAndWrite:
	lda #0 ;932d
	tay
CAndWr0:
	sta diskBlkBuf,y ;9330
	iny
	bne CAndWr0
	dey
	sty diskBlkBuf+1
	jmp WriteBuff

__SetNextFree:
	;933d
	lda r3H
	add interleave
	sta r6H
	MoveB r3L, r6L
	cmp #DIR_TRACK
	beq SNxtFree1
	cmp #$35
	beq SNxtFree1
SNxtFree00:
	lda r6L ;9351
	cmp #DIR_TRACK
	beq SNxtFree3
	cmp #$35
	beq SNxtFree3
SNxtFree1:
	cmp #$24 ;935b
	bcc SNxtFree11
	addv $b9
	tax
	lda curDirHead,x
	bne SNxtFree12
	beq SNxtFree3
SNxtFree11:
	asl ;936a
	asl
	tax
	lda curDirHead,x
	beq SNxtFree3
SNxtFree12:
	lda r6L ;9372
	jsr SNxtFreeHelp
	lda SecScTab,x
	sta r7L
	tay
SNxtFree2:
	jsr SNxtFreeHelp2 ;937d
	beq SNxtFreeEnd_OK
	inc r6H
	dey
	bne SNxtFree2
SNxtFree3:
	bbrf 7, curDirHead+3, SNxtFree5 ;9387
	CmpBI r6L, $24
	bcs SNxtFree4
	addv $23
	sta r6L
	bne SNxtFree7
SNxtFree4:
	subv $22 ;9399
	sta r6L
	bne SNxtFree6
SNxtFree5:
	inc r6L ;93a0
	lda r6L
SNxtFree6:
	cmp #$24 ;93a4
	bcs SNxtFreeEnd_Err
SNxtFree7:
	sub r3L ;93a8
	sta r6H
	asl
	adc #4
	adc interleave
	sta r6H
	bra SNxtFree00
SNxtFreeEnd_OK:
	MoveW r6, r3 ;93b8
	ldx #0
	rts
SNxtFreeEnd_Err:
	ldx #INSUFF_SPACE ;93c3
	rts

SNxtFreeHelp:
	pha ;93c6
	cmp #$24
	bcc SNFHlp
	subv $23
SNFHlp:
	ldx #0 ;93ce
SNFHlp0:
	cmp SecTrTab,x ;93d0
	bcc SNFHlp1
	inx
	bne SNFHlp0
SNFHlp1:
	pla ;93d8
	rts

SecTrTab:
	.byte 18, 25, 31, 36 ;93da
SecScTab:
	.byte 21, 19, 18, 17 ;93de

SNxtFreeHelp2:
	lda r6H ;93e2
SNFHlp2_1:
	cmp r7L ;93e4
	bcc SNFHlp2_2
	sub r7L
	bra SNFHlp2_1
SNFHlp2_2:
	sta r6H ;93ee

_AllocateBlock:
	jsr FindBAMBit ;93f0
	bne AllBlk0
	ldx #BAD_BAM
	rts
AllBlk0:
	php ;93f8
	CmpBI r6L, $24
	bcc AllBlk1
	lda r8H
	eor dir2Head,x
	sta dir2Head,x
	bra AllBlk2
AllBlk1:
	lda r8H ;940a
	eor curDirHead,x
	sta curDirHead,x
AllBlk2:
	ldx r7H ;9412
	plp
	beq AllBlk3
	dec curDirHead,x
	bra AllBlk4
AllBlk3:
	inc curDirHead,x ;941d
AllBlk4:
	ldx #0 ;9420
	rts

__FreeBlock:
	;9423
	jsr FindBAMBit
	beq AllBlk0
	ldx #BAD_BAM
	rts

__FindBAMBit:
	;942B
	lda r6H
	and #%00000111
	tax
	lda FBBBitTab,x
	sta r8H
	CmpBI r6L, $24
	bcc FBB_0
	subv $24
	sta r7H
	lda r6H
	lsr
	lsr
	lsr
	clc
	adc r7H
	asl r7H
	add r7H
	tax
	lda r6L
	addv $b9
	sta r7H
	lda dir2Head,x
	and r8H
	rts
FBB_0:
	asl ;945b
	asl
	sta r7H
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
	.byte $01, $02, $04, $08 ;946e
	.byte $10, $20, $40, $80

__CalcBlksFree:
	;9476
	LoadW r4, 0
	ldy #OFF_TO_BAM
CBlksFre0:
	lda (r5),y ;947e
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre1:
	tya ;9489
	addv 4
	tay
	cpy #$48
	beq CBlksFre1
	cpy #$90
	bne CBlksFre0
	LoadW r3, $0298
	bbrf 7, curDirHead+3, CBlksFre4
	ldy #$DD
CBlksFre2:
	lda (r5),y ;94a5
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre3:
	iny ;94b0
	bne CBlksFre2
	asl r3L
	rol r3H
CBlksFre4:
	rts ;94b7

__SetGEOSDisk:
	;94b8
	jsr GetDirHead
	bnex SetGDisk2
	jsr SetCurDHVec
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
	MoveW r3, r1 ;94e4
	jsr ClearAndWrite
	bnex SetGDisk2
	MoveW r1, curDirHead+OFF_OP_TR_SC
	ldy #OFF_GS_ID+15
	ldx #15
SetGDisk1:
	lda GEOSDiskID,x ;9500
	sta curDirHead,y
	dey
	dex
	bpl SetGDisk1
	jsr PutDirHead
SetGDisk2:
	rts ;950d

__InitForIO:
	;950e
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
	lda rasreg ;9571
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
	sta tmpDD00_2
	ldy #$1f
IniForIO1:
	lda NibbleTab2,y ;9591
	and #%11110000
	ora TURBO_DD00
	sta NibbleTab2,y
	dey
	bpl IniForIO1
	rts

D_IRQHandler:
	pla ;959f
	tay
	pla
	tax
	pla
D_NMIHandler:
	rti ;95a4

__DoneWithIO:
	sei ;95a5
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
	stx z8c ;95cb
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
	lda (z8b),y ;95e8
	jsr $ffa8
	iny
	cpy #5
	bcc SndDOSCmd0
	ldx #0
	rts
SndDOSCmd1:
	jsr $ffae ;95f5
	ldx #DEV_NOT_FOUND
	rts

__EnterTurbo:
	;95fb
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
	and #%01000000 ;9617
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
	dey ;962e
	bne EntTur1
	jsr Hst_RecvByte_3
EntTur2:
	bbsf 7, cia2base, EntTur2 ;9634
	jsr DoneWithIO
	ldx curDrive
	lda _turboFlags,x
	ora #%01000000
	sta _turboFlags,x
EntTur3:
	ldx #0 ;9647
	beq EntTur5
EntTur4:
	jsr DoneWithIO ;964b
EntTur5:
	txa ;964e
	rts

EnterCommand:
	.byte "M-E" ;9650
	.word DriveStart

SendExitTurbo:
	jsr InitForIO ;9655
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
	jsr InitForIO ;9673
	lda #>DriveCode
	sta z8e
	lda #<DriveCode
	sta z8d
	lda #>DriveAddy
	sta WriteAddy+1
	lda #<DriveAddy
	sta WriteAddy
	LoadB z8f, $1f
SndCDE0:
	jsr SendCHUNK ;968c
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
	jmp DoneWithIO ;96af

SendCHUNK:
	ldx #>WriteCommand ;96b2
	lda #<WriteCommand
	jsr SendDOSCmd
	bnex SndCHNK2
	lda #$20
	jsr $ffa8
	ldy #0
SndCHNK0:
	lda (z8d),y ;96c3
	jsr $ffa8
	iny
	cpy #$20
	bcc SndCHNK0
	jsr $ffae
	ldx #0
SndCHNK2:
	rts ;96d2

WriteCommand:
	.byte "M-W" ;96d3
WriteAddy:
	.word $0300 ;96d6

NibbleTab:
	.byte $0f, $07, $0d, $05, $0b, $03, $09, $01 ;96d8
	.byte $0e, $06, $0c, $04, $0a, $02, $08, $00
NibbleTab2:
	.byte $05, $85, $25, $a5, $45, $c5, $65, $e5 ;96e8
	.byte $15, $95, $35, $b5, $55, $d5, $75, $f5
E96F8:
	.byte $05, $25, $05, $25, $15, $35, $15, $35 ;96f8
	.byte $05, $25, $05, $25, $15, $35, $15, $35

Hst_RecvByte:
	PushB r0L ;9708
	jsr GetSync
	sty r0L
Hst_RecvByte_0:
	sec ;9710
Hst_RecvByte_1:
	lda rasreg ;9711
	sbc #$31
	bcc Hst_RecvByte_2
	and #6
	beq Hst_RecvByte_1
Hst_RecvByte_2:
	MoveB TURBO_DD00_CPY, cia2base ;971c
	MoveB TURBO_DD00, cia2base
	dec r0L
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
	ldy r0L
e9746:
	sta (z8b),y
	ora z8d
e974a:
	ora z8d
	tya
	bne Hst_RecvByte_0
	jsr Hst_RecvByte_3
	PopB r0L
	lda (z8b),y
	rts

Hst_RecvByte_3:
	ldx tmpDD00_2 ;9758
	stx cia2base
	rts

Hst_SendByte:
	jsr GetSync ;975f
	tya
	pha
	ldy #0
	jsr Hst_SendByte_01
	pla
	tay
e976b:
	jsr GetSync ;976b
Hst_SendByte_0:
	dey ;976e
	lda (z8b),y
	ldx TURBO_DD00
	stx cia2base
Hst_SendByte_01:
	tax ;9776
	and #%00001111
	sta z8d
	sec
Hst_SendByte_1:
	lda rasreg ;977c
	sbc #$31
	bcc Hst_SendByte_2
	and #6
	beq Hst_SendByte_1
Hst_SendByte_2:
	txa ;9787
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
	lda E96F8,X
	cpy #0
	sta cia2base
	bne Hst_SendByte_0
	nop
	nop
	beq Hst_RecvByte_3

__ExitTurbo:
	;97b3
	LoadB interleave, 8
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
	pla ;97d2
	tax
	rts

__PurgeTurbo:
	;97d5
	jsr ExitTurbo
PurTur0:
	ldy curDrive ;97d8
	lda #0
	sta _turboFlags,y
	rts

DUNK4:
	stx z8c ;97e1
	sta z8b
	ldy #2
	bne DUNK4_3
DUNK4_1:
	stx z8c ;97e9
	sta z8b
DUNK4_2:
	ldy #4 ;97ed
	lda r1H
	sta DTrkSec+1
	lda r1L
	sta DTrkSec
DUNK4_3:
	lda z8c ;97f9
	sta DExeProc+1
	lda z8b
	sta DExeProc
	lda #>DExeProc
	sta z8c
	lda #<DExeProc
	sta z8b
	jmp Hst_SendByte

DUNK5:
	ldy #1 ;980e
	jsr Hst_RecvByte
	pha
	tay
	jsr Hst_RecvByte
	pla
	tay
	rts

GetSync:
	sei ;981b
	MoveB TURBO_DD00, cia2base
GetSync0:
	bbrf 7, cia2base, GetSync0 ;9821
	rts

__ChangeDiskDevice:
	;9827
	pha
	jsr EnterTurbo
	bne ChngDskDv0
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
	pla ;9852
	rts

__NewDisk:
	;9854
	jsr EnterTurbo
	bne NewDsk2
	sta errCount
	sta r1L
	jsr InitForIO
NewDsk0:
	ldx #>Drv_NewDisk ;9861
	lda #<Drv_NewDisk
	jsr DUNK4_1
	jsr GetDOSError
	beq NewDsk1
	inc errCount
	cpy errCount
	beq NewDsk1
	bcs NewDsk0
NewDsk1:
	jsr DoneWithIO ;9877
NewDsk2:
	rts ;987a

__ReadBlock:
_ReadLink:
	;987b
	jsr CheckParams
	bcc RdLink1
RdLink0:
	jsr e990b ;9880
	jsr Hst_RecvByte
	jsr GetDError
	beqx RdLink1
	inc errCount
	cpy errCount
	beq RdLink1
	bcs RdLink0
RdLink1:
	ldy #0 ;9896
	rts

__WriteBlock:
	;9899
	jsr CheckParams
	bcc WrBlock2
WrBlock1:
	ldx #>Drv_WriteSec ;989e
	lda #<Drv_WriteSec
	jsr e990f
	jsr e976b
	jsr GetDError
	beq WrBlock2
	inc errCount
	cpy errCount
	beq WrBlock2
	bcs WrBlock1
WrBlock2:
	rts ;98b7

__VerWriteBlock:
	;98b8
	jsr CheckParams
	bcc VWrBlock3
	ldx #0
VWrBlock0:
	lda #3 ;98bf
	sta tryCount
VWrBlock1:
	jsr e990b ;98c4
	sty z8d
	lda #$51
	sta e9746
	lda #$85
	sta e974a
	jsr Hst_RecvByte
	lda #$91
	sta e9746
	lda #$05
	sta e974a
	PushB z8d
	jsr GetDError
	pla
	cpx #0
	bne VWrBlock2
	tax
	beq VWrBlock3
	ldx #$25
VWrBlock2:
	dec tryCount ;98f0
	bne VWrBlock1
	inc errCount
	lda errCount
	cmp #5
	beq VWrBlock3
	pha
	jsr WriteBlock
	pla
	sta errCount
	beqx VWrBlock0
VWrBlock3:
	rts ;990a

e990b:
	;990b
	ldx #>Drv_ReadSec
	lda #<Drv_ReadSec
e990f:
	jsr DUNK4_1 ;990f
	MoveW r4, z8b
	ldy #0
	rts

GetDOSError:
	ldx #>Drv_SendByte_0 ;991d
	lda #<Drv_SendByte_0
	jsr DUNK4
GetDError:
	lda #>errStore ;9924
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
	lda #0 ;9942
GetDErr2:
	tax ;9944
	rts

DOSErrTab:
	.byte $01, $05, $02, $08 ;9946
	.byte $08, $01, $05, $01
	.byte $05, $05, $05

DriveCode:
	;9951
.segment "drv1571_drivecode"

DNibbleTab:
	.byte $0f, $07, $0d, $05 ;0300
	.byte $0b, $03, $09, $01
	.byte $0e, $06, $0c, $04
	.byte $0a, $02, $08
	;0310
DNibbleTab2:
	.byte $00, $80, $20, $a0
	.byte $40, $c0, $60, $e0
	.byte $10, $90, $30, $b0
	.byte $50, $d0, $70, $f0

Drv_SendByte_0:
	ldy #0 ;031f
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
	jsr D_DUNK4_1 ;0334
Drv_SendByte_2:
	dey ;0337
	lda ($73),y
Drv_SendByte_3:
	tax ;033a
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
	nop
	nop
	nop
	nop
	stx $1800
	jsr e03e0
	txa
	rol
	and #%00001111
	sta $1800
	php
	plp
	nop
	nop
	nop
	ldx $70
	lda DNibbleTab,x
	sta $1800
	jsr e03df
	rol
	and #%00001111
	cpy #0
	sta $1800
	jsr e03de
	bne Drv_SendByte_2
	jsr e03da
	beq Drv_RecvByte_2

Drv_RecvWord:
	ldy #1 ;0382
	jsr Drv_RecvByte
	sta $71
	tay
	jsr Drv_RecvByte
	ldy $71
	rts

Drv_RecvByte:
	jsr D_DUNK4_1 ;0390
	jsr e03db
	lda #0
	sta $70
Drv_RecvByte_1:
	eor $70 ;039a
	sta $70
	jsr e03db
	lda #4
	bit $1800
	beq *-3
	jsr e03dc
	lda $1800
	jsr e03db
	asl
	ora $1800
	php
	plp
	nop
	nop
	and #%00001111
	tax
	lda $1800
	jsr e03de
	asl
	ora $1800
	and #%00001111
	ora DNibbleTab2,x
	dey
	sta ($73),y
	bne Drv_RecvByte_1
Drv_RecvByte_2:
	ldx #2 ;03d0
	stx $1800
	jsr e03d9
	nop
e03d9:
	nop ;03d9
e03da:
	nop ;03da
e03db:
	nop ;03db
e03dc:
	nop ;03dc
	nop
e03de:
	nop ;03de
e03df:
	nop ;03df
e03e0:
	rts ;03e0

D_DUNK4:
	dec $48 ;03e1
	bne D_DUNK4_1
	jsr D_DUNK8_2
D_DUNK4_1:
	LoadB $1805, $c0 ;03e8
D_DUNK4_2:
	bbrf 7, $1805, D_DUNK4 ;03ed
	lda #4
	bit $1800
	bne D_DUNK4_2
	LoadB $1800, 0
	rts

DriveStart:
	php ;03ff
	sei
	PushB $49
	ldy #0
	dey
	bne *-1
	ldy #0
	dey
	bne *-1
	jsr e048e
	lda $180f
	ora #%00100000
	sta $180f
	jsr $a483
	LoadB $1800, 0
	LoadB $1802, $1a
	jsr Drv_RecvByte_2
	lda #4
	bit $1800
	beq *-3
DriveLoop:
	jsr D_DUNK8 ;0430
	lda #>DExecAddy
	sta $74
	lda #<DExecAddy
	sta $73
	jsr Drv_RecvWord
	MoveB e06f9, DDatas
	cmp #$24
	bcs Drv_Loop1
	lda $180f
	and #$fb
	sta $180f
	jmp Drv_Loop2
Drv_Loop1:
	sec ;0453
	sbc #$23
	sta DDatas
	lda $180f
	ora #$04
	sta $180f
Drv_Loop2:
	jsr D_DUNK8_1 ;0461
	LoadW $73, $0700
	lda #>(DriveLoop-1)
	pha
	lda #<(DriveLoop-1)
	pha
	jmp (DExecAddy)

Drv_ExitTurbo:
	jsr D_DUNK4_1 ;0475
	LoadB $33, 0
	jsr $f98f
	LoadB $1c0c, $ec
	jsr e048e
	pla
	pla
	PopB $49
	plp
	rts

e048e:
	lda $180f ;048e
	and #$df
	sta $180f
	jsr $a483
	jsr $ff82
	lda $02af
	ora #$80
	sta $02af
	rts

Drv_ChngDskDev:
	lda e06f9 ;04a5
	sta $77
	eor #$60
	sta $78
	rts


Drv_ReadSec:
	jsr e062a ;04af
	ldy #0
	jsr Drv_SendByte_1
	jmp Drv_SendByte_0

D_DUNK8:
	lda #$f7 ;04ba
	bne D_DUNK8_3
D_DUNK8_1:
	lda #$08 ;04be
	ora $1c00
	bne D_DUNK8_5
D_DUNK8_2:
	LoadB $20, 0 ;04c5
	LoadB $3e, $ff
	lda #$fb
D_DUNK8_3:
	and $1c00 ;04cf
	jmp D_DUNK8_5
D_DUNK8_4:
	lda $1c00 ;04d5
	and #$9f
	ora DTrackTab,x
D_DUNK8_5:
	sta $1c00 ;04dd
	rts

DTrackTab:
	.byte $00, $20, $40, $60 ;04e1

D_DUNK5:
	jsr D_DUNK12 ;04e5
	lda $22
	beq D_DUNK5_1
	ldx $00
	dex
	beq D_DUNK5_2
D_DUNK5_1:
	PushB $12 ;04f1
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
	pha ;0511
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
	jsr D_DUNK6 ;0524
	lda DDatas
	sta $22
	jsr Drv_NewDisk_5
D_DUNK5_4:
	pla ;052f
D_DUNK5_41:
	rts ;0530
D_DUNK5_5:
	LoadB $00, $0b ;0531
	rts

D_DUNK6:
	stx $4a ;0536
	asl
	tay
	lda $1c00
	and #$fe
	sta $70
	lda #$2f
	sta $71
D_DUNK6_1:
	lda $70 ;0545
	add $4a
	eor $70
	and #%00000011
	eor $70
	sta $70
	sta $1c00
	lda $71
	jsr D_DUNK6_4
	cpy #6
	bcc D_DUNK6_2
	cmp #$1b
	bcc D_DUNK6_3
	sbc #3
	bne D_DUNK6_3
D_DUNK6_2:
	cmp #$2f ;0566
	bcs D_DUNK6_3
	adc #4
D_DUNK6_3:
	sta $71 ;056c
	dey
	bne D_DUNK6_1
	lda #$96
D_DUNK6_4:
	pha ;0573
	sta $1805
	lda $1805
	bne *-3
	pla
	rts

Drv_NewDisk:
	jsr D_DUNK12 ;057e
Drv_NewDisk_1:
	ldx $00 ;0581
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
	jsr D_DUNK6_4
Drv_NewDisk_2:
	LoadB $70, $04 ;059b
Drv_NewDisk_3:
	jsr D_DUNK11 ;059f
	lda $18
	cmp #$24
	bcc Drv_NewDisk_30
	sbc #$23
Drv_NewDisk_30:
	sta $22 ;05aa
	ldy $00
	dey
	beq Drv_NewDisk_5
	dec $70
	bmi Drv_NewDisk_4
	ldx $70
	jsr D_DUNK8_4
	sec
	bcs Drv_NewDisk_3
Drv_NewDisk_4:
	LoadB $22, 0 ;05bd
	rts
Drv_NewDisk_5:
	jsr $f24b ;05c2
	sta $43
	jmp D_DUNK8_4

D_DUNK9:
	tax ;05ca
	bbrf 7, e06f5, D_DUNK9_0
	jsr D_DUNK12_1
	ldx #0
	stx e06f5
D_DUNK9_0:
	cpx $22 ;05d8
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
	rts ;05fd

Drv_WriteSec:
	jsr D_DUNK5 ;05fe
	ldx $00
	dex
	bne D_DUNK10_1
	jsr D_DUNK9
D_DUNK10_1:
	ldy #0 ;0609
	jsr Drv_RecvByte
	eor $70
	sta $3a
	ldy $0
	dey
	bne Drv_WriteSec_1
	lda $1c00
	and #$10
	bne Drv_WriteSec_1
	LoadB $00, 8
Drv_WriteSec_1:
	jsr Drv_SendByte_0 ;0622
	lda #$10
	jmp e062f

e062a:
	jsr D_DUNK5 ;062a
	lda #0
e062f:
	ldx $00 ;062f
	dex
	beq D_DUNK11_0
	rts

D_DUNK11:
	lda #$30 ;0635
D_DUNK11_0:
	sta $45 ;0637
	lda #>e06f9
	sta $33
	lda #<e06f9
	sta $32
D_DUNK11_1:
	LoadB $31, 7 ;0641
	tsx
	stx $49
	ldx #1
	stx $00
	dex
	stx $02ab
	stx $02fe
	stx $3f
	LoadB $1c0c, $ee
	lda $45
	cmp #$10
	beq D_DUNK11_3
	cmp #$30
	beq D_DUNK11_2
	jmp $9606
D_DUNK11_2:
	jmp $944f ;0667
D_DUNK11_3:
	jsr $f78f ;066a
	jsr $970f
	ldy #9
D_DUNK11_4:
	bit $180f ;0672
	bmi D_DUNK11_4
	bit $1c00
	dey
	bne D_DUNK11_4
	lda #$ff
	sta $1c03
	lda $1c0c
	and #$1f
	ora #$c0
	sta $1c0c
	lda #$ff
	ldy #5
	sta $1c01
D_DUNK11_5:
	bit $180f ;0693
	bmi D_DUNK11_5
	bit $1c00
	dey
	bne D_DUNK11_5
	ldy #$bb
D_DUNK11_7:
	lda $0100,y ;06a0
	bit $180f
	bmi *-3
	sta $1c01
	iny
	bne D_DUNK11_7
D_DUNK11_8:
	lda ($30),y ;06ae
	bit $180f
	bmi *-3
	sta $1c01
	iny
	bne D_DUNK11_8
	bit $180f
	bmi *-3
	lda $1c0c
	ora #$e0
	sta $1c0c
	LoadB $1c03, 0
	sta $50
	lda #1
	sta $00
	rts

D_DUNK12:
	lda $20 ;06d4
	and #$20
	bne D_DUNK12_3
	jsr $f97e
	lda #$ff
	sta e06f5
D_DUNK12_1:
	ldy #$c8 ;06e2
D_DUNK12_2:
	dex ;06e4
	bne D_DUNK12_2
	dey
	bne D_DUNK12_2
	sty $3e
	LoadB $20, $20
D_DUNK12_3:
	LoadB $48, $ff ;0645
	rts

e06f5:
	.byte 0 ;06f5
DDatas:
	.byte 0 ;06f6
DExecAddy:
	.word 0 ;06f7
e06f9:
	.word 0 ;06f9

.segment "drv1571_b"

tmpclkreg:
	.byte 0 ;9d4c
tmpPS:
	.byte 0 ;9d4d
tmpgrirqen:
	.byte 0 ;9d4e
tmpCPU_DATA:
	.byte 0 ;9d4f
tmpmobenble:
	.byte 0 ;9d50
	.byte 0
DExeProc:
	.word 0 ;9d52
DTrkSec:
	.word 0 ;9d54
tmpDD00_2:
	.byte 0 ;9d56
errCount:
	.byte 0 ;9d57
errStore:
	.byte 0 ;9d58
tryCount:
	.byte 0 ;9d59
borderFlag:
	.byte 0 ;9d5a

