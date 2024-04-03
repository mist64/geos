; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Commodore 1541 disk driver with parallel cable by Maciej Witkowiak
; NOTE: OPTIMAL_INTERLEAVE has to be determined experimentally
; NOTE2: if drive code jams - check if 'jmp (DExecAddy)' is on page boundary - it's dangerously close

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

.import __DRIVE0300_START__
.import __DRIVE0300_LAST__

.import __drv1541_drivecode_RUN__
.import __drv1541_drivecode_SIZE__
.import __drv1541_zp_RUN__
.import __drv1541_zp_LOAD__
.import __drv1541_zp_SIZE__

; interleave testing in VICE (load DESK TOP saved with that interleave, count cycles between c326 and c3a8)
; interleave	start	end	diff	diff%
;1	124188392	138549570	14361178	226%
;2	206544077	221469179	14925102	235%
;3	323246805	326144363	2897558	46%
;4	377406197	380848405	3442208	54%
;5	444598875	448993889	4395014	69%
;6	503908689	508692309	4783620	75%
;7	567056391	572631055	5574664	88%
;8	630004373	636087138	6082765	96%
;9	717602340	724270720	6668380	105%
;10	779826865	787041178	7214313	113%
;11	873107683	881082247	7974564	125%
;12	924738595	933295187	8556592	135%
;13	1014288120	1023780169	9492049	149%
;14	1076008138	1085921087	9912949	156%
;15	1154807307	1165244853	10437546	164%


OPTIMAL_INTERLEAVE = 3

DExeProc = $80
DTrkSec  = $82
DTrkSecH = $83

.segment "drv1541"

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
	jmp DUNK4_1
	jmp GetDOSError
AllocateBlock:
	jmp _AllocateBlock
ReadLink:
	jmp _ReadLink

__GetDirHead:
	jsr SetDirHead
	bne __GetBlock
_ReadBuff:
	LoadW r4, diskBlkBuf
__GetBlock:
	jsr EnterTurbo
	bnex GetBlk0
	jsr InitForIO
	jsr ReadBlock
	jsr DoneWithIO
GetBlk0:
	rts

__PutDirHead:
	jsr SetDirHead
	bne __PutBlock
_WriteBuff:
	LoadW r4, diskBlkBuf
__PutBlock:
	jsr EnterTurbo
	bnex PutBlk1
	jsr InitForIO
	jsr WriteBlock
	bnex PutBlk0
	jsr VerWriteBlock
PutBlk0:
	jsr DoneWithIO
PutBlk1:
	rts

SetDirHead:
	LoadB r1L, DIR_TRACK
	LoadB r1H, 0
	sta r4L
	LoadB r4H, (>curDirHead)
	rts

CheckParams:
CheckParams_1:
	lda #0
	sta errCount
	ldx #INV_TRACK
	lda r1L
	beq CheckParams_2
	cmp #N_TRACKS+1
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
	jsr SetDirHead
OpenDsk0:
	LoadW r5, curDirHead
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
	lda tmpDriveType
	ldy curDrive
	sta _driveType,y
	rts
tmpDriveType:
	.byte 0

__BlkAlloc:
	ldy #1
	sty r3L
	dey
	sty r3H
__NxtBlkAlloc:
	PushW r9
	PushW r3
	LoadW r3, $00fe
	ldx #r2
	ldy #r3
	jsr Ddiv
	lda r8L
	beq BlkAlc0
	inc r2L
	bne BlkAlc0
	inc r2H
BlkAlc0:
	LoadW r5, curDirHead
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
	lda r5L
	bne @X
	dec r5H
@X:	dec r5L
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

_Get1stDirEntry:
	LoadB r1L, DIR_TRACK
	LoadB r1H, 1
	jsr ReadBuff
	LoadW r5, diskBlkBuf+FRST_FILE_ENTRY
	lda #0
	sta borderFlag
	rts

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
	LoadW r5, curDirHead
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
	LoadB isGEOS, 0
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
	LoadB r1L, DIR_TRACK
	LoadB r1H, 1
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
	lda r3H
	add interleave
	sta r6H
	MoveB r3L, r6L
	cmp #25
	bcc SNxtFree0
	dec r6H
SNxtFree0:
	cmp #DIR_TRACK
	beq SNxtFree1
SNxtFree00:
	lda r6L
	cmp #DIR_TRACK
	beq SNxtFree3
SNxtFree1:
	asl
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
	jsr SNxtFreeHelp2
	beq SNxtFree4
	inc r6H
	dey
	bne SNxtFree2
SNxtFree3:
	inc r6L
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
	MoveW_ r6, r3
	ldx #0
	rts
SNxtFree5:
	ldx #INSUFF_SPACE
	rts

SNxtFreeHelp:
	ldx #0
SNFHlp0:
	cmp SecTrTab,x
	bcc SNFHlp1
	inx
	bne SNFHlp0
SNFHlp1:
	rts

SecTrTab:
	.byte 18, 25, 31, 36
SecScTab:
	.byte 21, 19, 18, 17

SNxtFreeHelp2:
	lda r6H
SNFHlp2_1:
	cmp r7L
	bcc SNFHlp2_2
	sub r7L
	bra SNFHlp2_1
SNFHlp2_2:
	sta r6H

_AllocateBlock:
	jsr FindBAMBit
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
	ldx #BAD_BAM
	rts

__FindBAMBit:
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
	.byte $01, $02, $04, $08
	.byte $10, $20, $40, $80

__FreeBlock:
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
	ldx #BAD_BAM
	rts

__CalcBlksFree:
	LoadW_ r4, 0
	ldy #OFF_TO_BAM
CBlksFre0:
	lda (r5),y
	add r4L
	sta r4L
	bcc CBlksFre1
	inc r4H
CBlksFre1:
	tya
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
	PopB tmpPS
	sei
	MoveB CPU_DATA, tmpCPU_DATA
.ifndef bsw128
	LoadB CPU_DATA, KRNL_IO_IN
.endif
	MoveB grirqen, tmpgrirqen
	MoveB clkreg, tmpclkreg
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
	LoadB cia2base+2, %00111111
	MoveB mobenble, tmpmobenble
	sty mobenble
	sty cia2base+5
	iny
	sty cia2base+4
	LoadB cia2base+13, %10000001
	LoadB cia2base+14, %00001001
	LoadB cia2base+3, $00	; user port input
	lda cia2base+13		; clear /FLAG
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
	MoveB tmpclkreg, clkreg
	MoveB tmpmobenble, mobenble
	LoadB cia2base+13, %01111111
	lda cia2base+13
	MoveB tmpgrirqen, grirqen
.ifndef bsw128
	MoveB tmpCPU_DATA, CPU_DATA
.endif
	PushB tmpPS
	plp
	rts

Hst_RecvByte:
	MoveW z8b, RecvAddr
:	nop			; delay adjusted to Drv_SendByte timing
	nop			; so that branch after wait for flag is mostly not taken
	nop			; (4xNOP)=28 cycles per byte loop
	nop
:	lda cia2base+13		; wait for flag
	beq :-
	lda cia2base+1		; read data
	dey
RecvAddr = *+1
	sta $8000,y
	bne :--
	rts

Hst_SendByte:
	tya
	pha
	ldy #$ff
	sty cia2base+3			; port B output
	iny
	jsr Hst_SendByte_01
	pla
	tay
	LoadB cia2base+3, $ff		; port B output
Hst_SendByte_0:
	dey
	lda (z8b),y
Hst_SendByte_01:
	sta cia2base+1			; write
:	lda cia2base+13			; wait for handshake
	beq :-
	cpy #0
	bne Hst_SendByte_0
	LoadB cia2base+3, $00		; port B input
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

DUNK4:					; A/X addr of procedure to run, without parameters
	stx DExeProc+1
	sta DExeProc
	ldy #2				; 2 bytes to send
	bne DUNK4_3
DUNK4_1:				; A/X addr of procedure to run, r1 t&s parameters
	pha
	MoveW r1, DTrkSec
	pla
DUNK4_11:				; A/X addr of procedure to run, parameters in DTrkSec already
	stx DExeProc+1
	sta DExeProc
	ldy #4				; 4 bytes to send
DUNK4_3:
	LoadW z8b, DExeProc
	jmp Hst_SendByte

DUNK5:					; receive 2 bytes, but ignorethe first(?)
	ldy #1
	jsr Hst_RecvByte
	pha
	tay
	jsr Hst_RecvByte
	pla
	tay
	rts

__EnterTurbo:
	LoadB interleave, OPTIMAL_INTERLEAVE
	lda curDrive
	jsr SetDevice
	ldx curDrive
	lda _turboFlags,x
	bpl :+
	jmp EntTur3
:	jsr InitForIO
	jsr SendCODE
	beqx :+
	jmp EntTur4
:	ldx #>EnterCommand
	lda #<EnterCommand
	jsr SendDOSCmd
	bnex EntTur4
	lda cia2base+13			; clear flag
	jsr $ffae
	sei
:	lda cia2base+13			; wait for initial sync
	beq :-
:	lda cia2base+13			; twice (some part of M-E or DriveStart setup will trigger handhsake pulse)
	beq :-
	lda cia2base+1			; confirm

	; send remainder code for zero page
	LoadB LastOper, $ff
	jsr ReloadDrvZP

	; fast send rest of drive code: pages $03-$07
	LoadB EntTH+1, >DriveCode
	LoadW DTrkSec, __DRIVE0300_START__	; target address
EntTur1:
	ldx #>Drv_RecvZP			; recieve data
	lda #<Drv_RecvZP
	jsr DUNK4_11
	LoadB z8b, <DriveCode			; source address
EntTH:	lda #>DriveCode
	sta z8c
	ldy #0
	jsr Hst_SendByte
	inc DTrkSecH
	inc EntTH+1
	CmpBI DTrkSecH, $07
	bne EntTur1
	; send page 7 data also to page 2
	inc z8c
	LoadB DTrkSecH, $02
	ldx #>Drv_RecvZP
	lda #<Drv_RecvZP
	jsr DUNK4_11
	LoadW z8b, DriveCode+$0400
	ldy #<(__DRIVE0300_LAST__-__DRIVE0300_START__)
	jsr Hst_SendByte
	jsr DoneWithIO
	ldx curDrive
;;	lda _turboFlags,x
;;	ora #%01000000
	lda #%11000000
	sta _turboFlags,x
EntTur3:
	ldx #0
	beq EntTur5
EntTur4:
	jsr DoneWithIO
EntTur5:
	rts

EnterCommand:
	.byte "M-E"
	.word DriveStart

SendExitTurbo:
	jsr InitForIO
	ldx #>Drv_ExitTurbo
	lda #<Drv_ExitTurbo
	jsr DUNK4
:	lda cia2base+13			; wait for final sync
	beq :-
	lda curDrive
	jsr $ffb1
	lda #$ef
	jsr $ff93
	jsr $ffae
	jmp DoneWithIO

SendCODE:
	LoadW z8d, DriveCode+$0100	; skip over first page (gcr decode, send only 1 page of code)
	LoadW WriteAddy, __DRIVE0300_START__+$0100
	LoadB z8f, <($00ff/$20)
SndCDE0:
	jsr SendCHUNK
	bnex SndCDE1
	clc
	lda #$20
	adc z8d
	sta z8d
	bcc @X
	inc z8e
@X:	clc
	lda #$20
	adc WriteAddy
	sta WriteAddy
	bcc @Y
	inc WriteAddy+1
@Y:	dec z8f
	bpl SndCDE0
SndCDE1:
	rts

SendCHUNK:
	lda z8f
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
	lda (z8d),y
	jsr $ffa8
	iny
	cpy #$20
	bcc SndCHNK0
	jsr $ffae
SndCHNK1:
	ldx #0
SndCHNK2:
	rts

WriteCommand:
	.byte "M-W"
WriteAddy:
	.word 0

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
	and #%00111111			; clear bit 7 because we *have to* reload the code
	sta _turboFlags,x
ExiTur0:
	pla
	tax
	rts

__PurgeTurbo:
	jsr ExitTurbo
PurTur0:
	ldy curDrive
	lda #0
	sta _turboFlags,y
	rts

__NewDisk:
	jsr EnterTurbo
	bnex NewDsk2
	jsr InitForIO
	LoadB errCount, 0
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

__ChangeDiskDevice:
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
	pla
	rts

ReloadDrvZP:
	lda LastOper				; need to reload ZP code?
	beq :+					; no, it's already there
	LoadB LastOper, 0			; mark that ZP code is loaded
	LoadW DTrkSec, __drv1541_zp_RUN__	; target address
	ldx #>Drv_RecvZP			; recieve data
	lda #<Drv_RecvZP
	jsr DUNK4_11
	LoadW z8b, __drv1541_zp_LOAD__		; source address
	ldy #<(__drv1541_zp_SIZE__)		; bytes ($00=256)
	jsr Hst_SendByte
:	rts

__ReadBlock:
_ReadLink:
	jsr CheckParams_1
	bcc RdBlock2
RdBlock0:
	jsr ReloadDrvZP
	ldx #>Drv_ReadSec			; read sector and status
	lda #<Drv_ReadSec
	jsr DUNK4_1
	MoveW r4, z8b
	ldy #0
	jsr Hst_RecvByte
	jsr GetDError
	beq RdBlock1
	inc errCount
	cpy errCount
	beq RdBlock1
	bcs RdBlock0
RdBlock1:
	bnex RdBlock2
RdBlock2:
	ldy #0
	rts

__WriteBlock:
__VerWriteBlock:
	jsr CheckParams
	bcc WrBlock2
WrBlock1:
	ldx #>Drv_WriteSec
	lda #<Drv_WriteSec
	jsr DUNK4_1
	MoveW r4, z8b
	ldy #0
	jsr Hst_SendByte
	jsr GetDError
	beq WrBlock2
	inc errCount
	cpy errCount
	beq WrBlock2
	bcs WrBlock1
WrBlock2:
	rts

GetDOSError:
	ldx #>Drv_SendByte_0
	lda #<Drv_SendByte_0
	jsr DUNK4
GetDError:
	LoadW z8b, errStore
	jsr DUNK5
	PushB errStore
	tay
	lda DOSErrTab-1,y
	tay
	pla
	cmp #1
	beq GetDErr1
	addv $1e
	bne GetDErr2
GetDErr1:
	lda #0
GetDErr2:
	tax
	rts

DOSErrTab:
	.byte $01, $05, $02, $08
	.byte $08, $01, $05, $01
	.byte $05, $05, $05

DriveCode:
.segment "drv1541_drivecode"

DExecAddy = $0a		; unused t&s for buffer $0500
DDatas = DExecAddy+2		; unused t&s for buffer $0600
DLastOper = $0e		; 1 if $0700-$0790 has to be restored after write

gcrdecode:
.byte $03, $99, $99, $99, $99, $99, $99, $99, $99, $80, $00, $10, $99, $c0, $40, $50, $99, $99, $20, $30, $99, $f0, $60, $70, $99, $90, $a0, $b0, $99, $d0, $e0, $7f, $76, $80, $99, $90, $99, $99, $99, $76, $7f, $08, $00, $01, $99, $0c, $04, $05, $99, $99, $02, $03, $99, $0f, $06, $07, $99, $09, $0a, $0b, $99, $0d, $0e, $99, $99, $00, $20, $a0, $6c, $4c, $2c, $0c, $80, $08, $08, $0c, $99, $0f, $09, $0d, $00, $00, $08, $99, $00, $99, $01, $99, $10, $01, $0c, $99, $04, $99, $05, $99, $99, $10, $30, $b0, $02, $99, $03, $99, $c0, $0c, $0f, $99, $06, $99, $07, $99, $40, $04, $09, $99, $0a, $99, $0b, $99, $50, $05, $0d, $99, $0e, $90, $00, $d0, $40, $99, $20, $e0, $60, $80, $a0, $c0, $e0, $99, $00, $04, $02, $06, $0a, $0e, $20, $02, $18, $99, $10, $99, $11, $99, $30, $03, $1c, $99, $14, $99, $15, $99, $99, $c0, $f0, $d0, $12, $99, $13, $99, $f0, $0f, $1f, $99, $16, $99, $17, $99, $60, $06, $19, $99, $1a, $99, $1b, $99, $70, $07, $1d, $99, $1e, $a4, $a4, $a4, $a3, $40, $60, $e0, $15, $13, $12, $11, $90, $09, $01, $05, $03, $07, $0b, $99, $a0, $0a, $99, $99, $99, $99, $99, $99, $b0, $0b, $99, $99, $99, $99, $99, $99, $99, $50, $70, $99, $99, $99, $99, $99, $d0, $0d, $99, $99, $99, $99, $99, $99, $e0, $0e, $99, $99, $99, $99, $99, $99, $99, $99, $99, $99, $99, $99, $99, $99


Drv_SendByte_0:
	LoadB $1803, $ff	; send length (1) and status byte from $00
Drv_SendStatus:
	LoadB $1801, $01	; send length
	lda #$10
:	bit $180d		; wait for handshake
	beq :-
	bit $1800		; clear flag
	ldy $00
	sty $1801		; send status
:	bit $180d		; wait for handshake
	beq :-
	bit $1800		; clear flag
	LoadB $1803, $00	; port A input
	rts


Drv_RecvWord:
	ldy #1
	jsr Drv_RecvByte
	sta $71
	tay
	jsr Drv_RecvByte
	ldy $71
	rts

Drv_RecvByte:
Drv_RecvByte_1:
	lda #$10
:	bit $180d
	beq :-
	lda $1801			; read data
	bit $1800			; clear CB1
	dey
	sta ($73),y
	bne Drv_RecvByte_1
	rts

D_DUNK4:
	dec $48
	bne D_DUNK4_1
	jsr D_DUNK8_2
D_DUNK4_1:
	LoadB $1800, 0
	rts

DriveStart:
	php
	sei
	PushB $49
	LoadB $1803, $00		; port A input
	LoadB $180c, $0b
	bit $180c
	lda $180f
	and #%11011111
	sta $180f
	bit $1800			; clear CB1
	lda $1801			; notify we're runing (initial sync)
	lda #$10
	sta DLastOper			; READ not allowed
:	bit $180d			; sync
	beq :-
	bit $1800			; clear CB1
DriveLoop:
	jsr Drv_LedOFF
	LoadW $73, DExecAddy		; set rcv buffer to next command 
	jsr Drv_RecvWord		; receive address
	jsr Drv_LedON
	LoadW $73, $0700		; buffer to data
	lda #>(DriveLoop-1)		; return address
	pha
	lda #<(DriveLoop-1)
	pha
	jmp (DExecAddy)

Drv_LedOFF:
	lda #$f7
	and $1c00
Drv_LedDo:
	sta $1c00
	rts
Drv_LedON:
	lda #$08
	ora $1c00
	bne Drv_LedDo

Drv_RecvZP:
	MoveW DDatas, $73
	jmp Drv_RecvWord

	.assert * < __DRIVE0300_START__ + $1ff, error, "Drv_Recv+DriveStart+DriveLoop+Drv_RecvZP must be within $0400-$04ff"

Drv_ExitTurbo:
	jsr Drv_RestorePage7
	jmp Drv_DoExitTurbo

Drv_ChngDskDev:
	lda DDatas
	sta $77
	eor #$60
	sta $78
	rts

D_DUNK5:
	jsr D_DUNK12
	lda $22
	beq D_DUNK5_1
	ldx $00
	dex
	beq D_DUNK5_2
D_DUNK5_1:
	lda $12				; was disk logged in?
	ora $13
	beq :+				; no, just read the ID

	PushB $12			; preserve current disk ID
	PushB $13
	jsr Drv_NewDisk_1
	PopB $13
	tax
	PopB $12
	ldy $00
	cpy #$01			; any error?
	bne D_DUNK5_41			; yes, error
	cpx $17				; different ID?
	bne D_DUNK5_5			; yes, error
	cmp $16
	bne D_DUNK5_5
	beq :++

:	jsr Drv_NewDisk_1		; login disk
:	lda #0				; ID the same
D_DUNK5_2:
	pha
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
	jsr D_DUNK6
	lda DDatas
	sta $22
	jsr Drv_NewDisk_6
D_DUNK5_4:
	pla
D_DUNK5_41:
	rts
D_DUNK5_5:
	LoadB $00, $0b			; ID mismatch
	rts

D_DUNK6:
	stx $4a
	asl
	tay
	lda $1c00
	and #$fe
	sta $70
	lda #$1e
	sta $71
D_DUNK6_1:
	lda $70
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
	cmp #$1c
	bcs D_DUNK6_3
	adc #4
D_DUNK6_3:
	sta $71
	dey
	bne D_DUNK6_1
	lda #$4b
D_DUNK6_4:
	sta $1805
	lda $1805
	bne *-3
	rts

Drv_NewDisk:
	jsr D_DUNK12
Drv_NewDisk_1:
	ldx $00
	dex
	beq Drv_NewDisk_2
	ldx #$ff
	lda #$01
	jsr D_DUNK6
	lax #$01
	jsr D_DUNK6
	lda #$ff
	jsr D_DUNK6_4
Drv_NewDisk_2:
	LoadB $70, $04
Drv_NewDisk_3:
	jsr D_DUNK11
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
	LoadB $22, 0
	rts
Drv_NewDisk_5:
	txa
Drv_NewDisk_6:
	jsr $f24b			; Establish number of sectors per track (in: A=track, out: A=number of sectors on that track, X=speed zone number)
	sta $43
Drv_NewDisk_7:
	lda $1c00			; set speedzone
	and #$9f
	ora DTrackTab,x
Drv_NewDisk_8:
	sta $1c00
	rts

D_DUNK8_2:
	LoadB $20, 0
	LoadB $3e, $ff
	lda #$fb
	and $1c00
	jmp Drv_NewDisk_8

DTrackTab:				; speedzone (bitrate) bits for $1c00
	.byte $00, $20, $40, $60

D_DUNK9:
	tax
	bbrf 7, $20, D_DUNK9_0
	jsr D_DUNK12_1
	LoadB $20, $20
	ldx #0
D_DUNK9_0:
	cpx $22
	beq D_DUNK9_1
	jsr Drv_NewDisk_2
	cmp #1
	bne D_DUNK9_1
	ldy $19
	iny
	cpy $43
	bcc @X
	ldy #0
@X:	sty $19
	LoadB $45, 0			; job READ
	LoadW $32, $0018		; sector 18,0
	jsr D_DUNK11_1
D_DUNK9_1:
	rts

Drv_WriteSec:
	LoadB DLastOper, 1		; mark that $07xx will be destroyed
	jsr D_DUNK5
	ldx $00
	dex
	bne D_DUNK10_1
	jsr D_DUNK9
D_DUNK10_1:
	jsr Drv_RecvWord
	lda #$10
	bne D_DUNK10_2

Drv_RestorePage7:
	lda DLastOper			; last operation was READ?
	beq :++
	ldx #0				; no, restore that code after write
	stx DLastOper
:	lda $0200,x
	sta $0700,x
	inx
	cpx #<(__DRIVE0300_LAST__-__DRIVE0300_START__)
	bne :-
:	rts

Drv_ReadSec:
	jsr Drv_RestorePage7
	jsr D_DUNK5
	lda #0
D_DUNK10_2:
	ldx $00
	dex
	beq D_DUNK11_0
	rts

D_DUNK11:
	lda #$30				; job $B0 = SEEK
D_DUNK11_0:
	sta $45
	lda #>DDatas
	sta $33
	lda #<DDatas
	sta $32
D_DUNK11_1:
	LoadB $31, 7
	tsx
	stx $49
	ldx #1
	stx $00
	dex
	stx $3f
	LoadB $1c0c, $ee
	lda $45
	bne :+
	jmp Drv_DoReadSector			; job $80 = READ
:	cmp #$10				; job $90 = WRITE
	bne :+
	jmp Drv_DoWriteSector
:	cmp #$30				; job $B0 = SEEK
	beq :+
	jmp $f4ca				; Test command code further ($00=read, $10=write, $20=verify, $30 = SEEK, is this ever used?)
:	jmp $f3b1				; SEEK, Read block header, verify ID

D_DUNK12:					; spin up motor
	lda $20
	and #$20
	bne D_DUNK12_3				; already on
	jsr $f97e				; Turn drive motor on
D_DUNK12_1:
	ldy #$80				; delay until it spins up
:	dex
	bne :-
	dey
	bne :-
	sty $3e
D_DUNK12_3:
	LoadB $48, $ff
	rts

Drv_DoWriteSector:
D_DUNK11_3:
	jsr $f5e9				; Calculate parity for data buffer ($30)
	sta $3a
	lda $1c00
	and #$10
	bne D_DUNK11_4
	lda #$08
	bne D_DUNK11_9
D_DUNK11_4:
	jsr $f78f				; Convert 260 bytes (256+4) to 325 bytes group code buffer $01BB-$01FF and ($30)
	jsr $f510				; Read block header (wait until needed block header arrives)
	ldx #9
D_DUNK11_5:
	bvc D_DUNK11_5				; skip over sync
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
	bvc D_DUNK11_6
	clv
	dex
	bne D_DUNK11_6
	ldy #$bb
D_DUNK11_7:
	lda $0100,y				; write data
	bvc *
	clv
	sta $1c01
	iny
	bne D_DUNK11_7
D_DUNK11_8:
	lda ($30),y				; write data, continued
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
	sta $00
	jmp Drv_SendByte_0			; set port to output, send status from $00

	.assert * < $700, error, "D_DUNK11 (WriteSector) must end before $0700"

Drv_DoReadSector:
		; Encode t&s into GCR

		MoveW $12, $16		; ID1,2
		MoveW DDatas, $18	; t&s
		lda #0
		eor $16
		eor $17
		eor $18
		eor $19
		sta $1a			; parity
		jsr $f934		; encode to GCR, result in $24-2b

		LoadB $00, 1		; no error by default

		ldx #90			; 90 attempts
		; Wait for sync + compare encoded header (like DOS does)
waitheader:
		jsr $f556		; wait for sync
		;ldy #0			; F556 sets Y to 0
:		bvc *
		clv
		lda $1c01
		cmp $24,y
		bne nextheader		; next one
		iny
		cpy #8
		bne :-			; XXX ROM does check for maximum number of tries, error would jump to sendblock below with error $02
		beq foundheader
nextheader:	dex
		bne waitheader
		LoadB $00, 2		; 20, 'read error'
		jmp Drv_ReadSec_DataOut

foundheader:
		; code from Spindle 3.1 by lft, linusakesson.net/software/spindle/
		; Wait for a data block

		ldx	#0		; will be ff when entering the loop
		txs
waitsync:
		bit	$1c00
		bpl	*-3

		bit	$1c00
		bmi	*-3

		lda	$1c01	; ack the sync byte
		clv
		bvc	*
		lda	$1c01	; aaaaabbb, which is 01010.010(01) for a header
		clv		; or 01010.101(11) for data
		eor	#$55
		bne	waitsync

		bvc	*
		lda	$1c01	; bbcccccd
		clv
		.byt	$4b,$3f			; asr imm, d -> carry
		sta	first_mod3+1

		bvc	*
		lax	$1c01			; 0 1 2 3	ddddeeee
		.byt	$6b,$f0			; 4 5		arr imm, ddddd000
		clv				; 6 7
		tay				; 8 9
first_mod3:	lda	gcrdecode		; 10 11 12 13	lsb = 000ccccc
		ora	gcrdecode+1,y		; 14 15 16 17	y = ddddd000, lsb = 00000001
		pha				; 18 19 20	first byte to $100

		; get sector number from the lowest 5 bits of the first byte

		and	#$1f			; 21 22
		tay				; 23 24
		nop ; lda interested,y		; 25 26
		nop ; lda interested,y		; 27 28
		nop ; beq notint (not taken)	; 29 30
		;lda	interested,y		; 25 26 27 28
;mod_safety:
		;beq	notint			; 29 30

		jmp	zpc_entry		; 31 32 33	x = ----eeee
zp_return:
		.byt	$6b,$f0			; arr imm, ddddd000
		tay
		lda	gcrdecode,x		; x = 000ccccc
		ora	gcrdecode+1,y		; y = ddddd000, lsb = 00000001

	sta $24			; checksum

Drv_ReadSec_DataOut:
	; send out data, compute checksum
	ldy #$ff
	sty $1803		; port B output
	iny
	sty $25			; clear computed checksum
:	pla
	sta $1801		; send next byte (reversed order, as host expects)
	eor $25
	sta $25			; update checksum
	lda #$10		; handshake test bit pattern
:	bit $180d		; wait for handshake
	beq :-
	bit $1800		; clear CB1 flag
	dey
	cpy #0
	bne :--

	CmpBI $00, 1		; if there is error already
	bne :+			; return it
	CmpB $24, $25		; otherwise compare checksums
	beq :+
	LoadB $00, 5		; checksum error
	; if header was found in time and checksum is OK then send status byte==1
	; if header not found, send error $04
:	jsr Drv_SendStatus

	; restore stack pointer (must be below $01bb)
	ldx #$45
	txs

	; return to main loop (XXX ExitTurbo must warm reset drive somehow because we have destroyed stack contents)
	jmp DriveLoop

Drv_DoExitTurbo:
	jsr Drv_LedOFF
	ldy $78				; preserve device number
	lax #0
:	sta $00,x
	sta $0200,x
	inx
	bne :-
	bit $1801			; final sync
	LoadB $180c, $01		; CA1 (ATN IN) trigger on positive edge
	lda #$82
	sta $180d			; interrupt possible through ATN IN
	sta $180e
	ldx #$45
	txs
	tya				; restore device number ($78)
	jmp $eb45			; reset routine, after RAM/ROM test when device number is set


.segment "drv1541_zp" : zeropage

prof_zp:
zpc_loop:
		; This nop is needed for the slow bitrates (at least for 00),
		; because apparently the third byte after a bvc sync might not be
		; ready at cycle 65 after all.

		; However, with the nop, the best case time for the entire loop
		; is 128 cycles, which leaves too little slack for motor speed
		; variance at bitrate 11.

		; Thus, we modify the bne instruction at the end of the loop to
		; either include or skip the nop depending on the current
		; bitrate.

		nop

		lax	$1c01			; 62 63 64 65	ddddeeee
		.byte	$6b,$f0			; 66 67		arr imm, ddddd000
		clv				; 68 69
		tay				; 70 71
zpc_mod3:	lda	gcrdecode		; 72 73 74 75	lsb = 000ccccc
		ora	gcrdecode+1,y		; 76 77 78 79	y = ddddd000, lsb = 00000001

		; first read in [0..25]
		; second read in [32..51]
		; third read in [64..77]
		; clv in [64..77]
		; in total, 80 cycles from bvc

		bvc	*			; 0 1

		pha				; 2 3 4		second complete byte (nybbles c, d)
zpc_entry:
		lda	#$0f			; 5 6
		sax	z:zpc_mod5+1		; 7 8 9

		lda	$1c01			; 10 11 12 13	efffffgg
		ldx	#$03			; 14 15
		sax	z:zpc_mod7+1		; 16 17 18
		.byte	$4b,$fc			; 19 20		asr imm, 0efffff0
		tay				; 21 22
		ldx	#$79			; 23 24
zpc_mod5:	lda	gcrdecode,x		; 25 26 27 28	lsb = 0000eeee, x = 01111001
		eor	gcrdecode+$40,y		; 29 30 31 32	y = 0efffff0, lsb = 01000000
		pha				; 33 34 35	third complete byte (nybbles e, f)

		lax	$1c01			; 36 37 38 39	ggghhhhh
		clv				; 40 41
		and	#$1f			; 42 43
		tay				; 44 45

		; first read in [0..25]
		; second read in [32..51]
		; clv in [32..51]
		; in total, 46 cycles from bvc

		bvc	*			; 0 1

		lda	#$e0			; 2 3
		.byte $cb, $00	; sbx	#0			; 4 5
zpc_mod7:	lda	gcrdecode,x		; 6 7 8 9	x = ggg00000, lsb = 000000gg
		ora	gcrdecode+$20,y		; 10 11 12 13	y = 000hhhhh, lsb = 00100000
		pha				; 14 15 16	fourth complete byte (nybbles g, h)

		; start of a new 5-byte chunk

		lda	$1c01			; 17 18 19 20	aaaaabbb
		ldx	#$f8			; 21 22
		sax	z:zpc_mod1+1		; 23 24 25
		and	#$07			; 26 27
		ora	#$08			; 28 29
		tay				; 30 31

		lda	$1c01			; 32 33 34 35	bbcccccd
		ldx	#$c0			; 36 37
		sax	z:zpc_mod2+1		; 38 39 40
		.byt	$4b,$3f			; 41 42		asr imm, 000ccccc, d -> carry
		sta	z:zpc_mod3+1		; 43 44 45

zpc_mod1:	lda	gcrdecode		; 46 47 48 49	lsb = aaaaa000
zpc_mod2:	eor	gcrdecode,y		; 50 51 52 53	lsb = bb000000, y = 00001bbb
		pha				; 54 55 56	first complete byte (nybbles a, b)

		tsx				; 57 58
BNE_WITH_NOP	=	(zpc_loop - (* + 2)) & $ff
BNE_WITHOUT_NOP	=	(zpc_loop + 1 - (* + 2)) & $ff
zpc_bne:	.byt	$d0,BNE_WITHOUT_NOP	; 59 60 61	bne zpc_loop

		ldx	z:zpc_mod3+1		; 61 62 63
		lda	$1c01			; 64 65 66 67	ddddeeee
		jmp	zp_return

.segment "drv1541_b"

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
errCount:
	.byte 0
errStore:
	.byte 0
borderFlag:
	.byte 0
LastOper:
	.byte $ff

