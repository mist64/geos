; GEOS by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Commodore 1571 disk driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "jumptab.inc"
.include "c64.inc"

;GEOS 1571 disk driver
;reassembled by Maciej 'YTM/Elysium' Witkowiak
;25-26.02.2002, 2-4.03.2002
; burst version - 08.03.2002, 29-30.03.2002
; burst in ca65 - 02.03.2024

; ADVANTAGES
; - burst is really fast
; - ability to use MFM formats (only 256 b. blocks, but some might be bigger than 1571)
; - ease of porting to 1581 (?)
; - ease of porting to remote drive emulators (64net/2, 64hdd, IDE64 (?))

; DISADVANTAGES
; - disk login doesn't work always for GCR, sometimes need to nearly unlock disk to
;   make head move (like when reading bad sector) then everything is OK
; - preparatory routines (listen/.../unlisten) take much time


;BUGS
; - no write_block yet
;	https://www.zimmers.net/anonftp/pub/cbm/manuals/drives/1571_Users_Guide_252095-04_(1985_Aug).pdf p 82 (90)
; - send DOS command uses Listen which uses $0a1c serialFlag - should switch to bank0 there; maybe that was the reason for lockup sometimes?
;   (BUT listen goes through trampoline which should handle that)
; - copy $ff47 code to here (k_Spinp)

; pure U0 (block read/write) driver
; https://github.com/MEGA65/c64-GEOS2000/blob/master/src/drv/drvf011.tas
;	! doesn't use NewDisk at all
; MFM burst
; https://github.com/michielboland/c64stuff/blob/master/asm/serial.s

;$ff47 is not in GEOS Kernal mirror!
;	(just copy what it does)
;	E5C3-E5FF C=1 -> fast, C=0 -> slow
; https://klasek.at/c64/c128-rom-listing.html#$E5C3
; https://commodore.software/downloads?task=download.send&id=12906:mapping-the-commodore-128&catid=218 p 530 (517)
;$0a1c should be checked in BANK0!!!

; __NewDisk: I+Inquire seems better than query because head doesn't go back to track 1

.segment "drv1571"

serialFlag	= $0a1c	;!!! in BANK0 !!!

cia1Data	= $dc0c
cia1ICR		= $dc0d
ciaSerialClk	= $dd00

DriveAddy = $0300

k_Listen	= $ffb1
k_Second	= $ff93
k_Ciout		= $ffa8
k_Unlsn		= $ffae
k_Spinp		= $ff47		; XXX !!! this is NOT in kernal mirror jump table in bank 1

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


__GetDirHead:
	jsr SetDirHead_1
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
	lda #8
GDH_1:
	sta interleave
DUNK4_2:
GetDOSError:
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
	rts

__PutDirHead:
	jsr EnterTurbo
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
	jsr SetDirHead_1
	jsr VerWriteBlock
	bnex PDH_1
	bbrf 7, curDirHead+3, PDH_1
	jsr SetDirHead_2
	jsr VerWriteBlock
PDH_1:
	jmp DoneWithIO

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
	rts

SetDirHead_1:
	ldy #$12
	lda #>curDirHead
	bne SDH_1
SetDirHead_2:
	ldy #$35
	lda #>dir2Head
SDH_1:
	sty r1L
	sta r4H
	lda #0
	sta r1H
	sta r4L
	rts

CheckParams:
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
	sec
	rts
CheckParams_2:
	clc
	rts

__OpenDisk:
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
	rts

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
	LoadB r1L, 18
	ldy #1
	sty r1H
	dey
	sty borderFlag
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
	LoadB r1L, 18
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
	cmp #DIR_TRACK
	beq SNxtFree1
	cmp #$35
	beq SNxtFree1
SNxtFree00:
	lda r6L
	cmp #DIR_TRACK
	beq SNxtFree3
	cmp #$35
	beq SNxtFree3
SNxtFree1:
	cmp #$24
	bcc SNxtFree11
	addv $b9
	tax
	lda curDirHead,x
	bne SNxtFree12
	beq SNxtFree3
SNxtFree11:
	asl
	asl
	tax
	lda curDirHead,x
	beq SNxtFree3
SNxtFree12:
	lda r6L
	jsr SNxtFreeHelp
	lda SecScTab,x
	sta r7L
	tay
SNxtFree2:
	jsr SNxtFreeHelp2
	beq SNxtFreeEnd_OK
	inc r6H
	dey
	bne SNxtFree2
SNxtFree3:
	bbrf 7, curDirHead+3, SNxtFree5
	CmpBI r6L, $24
	bcs SNxtFree4
	addv $23
	sta r6L
	bne SNxtFree7
SNxtFree4:
	subv $22
	sta r6L
	bne SNxtFree6
SNxtFree5:
	inc r6L
	lda r6L
SNxtFree6:
	cmp #$24
	bcs SNxtFreeEnd_Err
SNxtFree7:
	sub r3L
	sta r6H
	asl
	adc #4
	adc interleave
	sta r6H
	bra SNxtFree00
SNxtFreeEnd_OK:
	MoveW r6, r3
	ldx #0
	rts
SNxtFreeEnd_Err:
	ldx #INSUFF_SPACE
	rts

SNxtFreeHelp:
	pha
	cmp #$24
	bcc SNFHlp
	subv $23
SNFHlp:
	ldx #0
SNFHlp0:
	cmp SecTrTab,x
	bcc SNFHlp1
	inx
	bne SNFHlp0
SNFHlp1:
	pla
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
	bne AllBlk0
	ldx #BAD_BAM
	rts
AllBlk0:
	php
	CmpBI r6L, $24
	bcc AllBlk1
	lda r8H
	eor dir2Head,x
	sta dir2Head,x
	bra AllBlk2
AllBlk1:
	lda r8H
	eor curDirHead,x
	sta curDirHead,x
AllBlk2:
	ldx r7H
	plp
	beq AllBlk3
	dec curDirHead,x
	bra AllBlk4
AllBlk3:
	inc curDirHead,x
AllBlk4:
	ldx #0
	rts

__FreeBlock:
	jsr FindBAMBit
	beq AllBlk0
	ldx #BAD_BAM
	rts

__FindBAMBit:
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
	asl
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
	.byte $01, $02, $04, $08
	.byte $10, $20, $40, $80

__CalcBlksFree:
	LoadW r4, 0
	ldy #OFF_TO_BAM
CBlksFre0:
	lda (r5),y
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre1:
	tya
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
	lda (r5),y
	add r4L
	sta r4L
	bcc *+4
	inc r4H
CBlksFre3:
	iny
	bne CBlksFre2
	asl r3L
	rol r3H
CBlksFre4:
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
	pla
	sta tmpPS
	sei
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
	sta nmivec+1
	lda #<D_IRQHandler
	sta irqvec
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
;;x
.ifdef dontuse
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
	sta tmpDD00_2
	ldy #$1f
IniForIO1:
	lda NibbleTab2,y
	and #%11110000
	ora TURBO_DD00
	sta NibbleTab2,y
	dey
	bpl IniForIO1
.endif
	rts

D_IRQHandler:
	PopB $ff00
	pla
	tay
	pla
	tax
	pla
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
	lda tmpPS
	pha
	plp
	rts

SendDOSCmd:
	stx z8c				; x/a vector must be above bottom 4K
	sta z8b
	sty z8d
	PushB config
	LoadB config, %01001110		; bank 1 with HIROM and I/O (avoid GEOS trampoline to save time)
	PushB rcr
	LoadB rcr,    %01000110		; share bottom 4K with bank 0 to have serialFlag (k_Listen will write to it)
	LoadB STATUS, 0
	lda serialFlag			; why 1571 DOS example does this?
	and #%10111111
	sta serialFlag
	lda curDrive
	jsr k_Listen
	bbsf 7, STATUS, SndDOSCmdErr
	lda #$6f
	jsr k_Second
	bbsf 7, STATUS, SndDOSCmdErr
	ldy #0
:	lda (z8b),y
	jsr k_Ciout
	iny
	cpy z8d
	bcc :-
	lda #0
	.byte $2c
SndDOSCmdErr:
	lda #DEV_NOT_FOUND
	sta z8d
	jsr k_Unlsn
	PopB rcr
	PopB config
	ldx z8d
	rts

__EnterTurbo:
	lda curDrive
	jsr SetDevice
	ldx #0
	rts

__PurgeTurbo:
__ExitTurbo:
	LoadB interleave, 8
	ldx #0
	rts

__ChangeDiskDevice:
	sta ChngDskDev_Number
	pha
	jsr InitForIO
	ldx #>ChngDskDev_Command
	lda #<ChngDskDev_Command
	ldy #4
DOSCmdOnly:
	jsr SendDOSCmd
	bnex DOSCmdErr
	PopB curDrive
	sta curDevice
DOSCmdErr:
	jmp DoneWithIO

ChngDskDev_Command:
		.byte "U0>"
ChngDskDev_Number:
		.byte 8

__NewDisk:
	jsr InitForIO
;.ifdef dontuse
	ldx #>NewDiskCommand
	lda #<NewDiskCommand
	ldy #1
	jsr SendDOSCmd
;;	bnex NewDsk1
;;	ldx #>InquireDisk_Cmd
;;	lda #<InquireDisk_Cmd
;;	ldy #3
;;	jsr SendDOSCmd
;.endif
;	ldx #>QueryDisk_Cmd
;	lda #<QueryDisk_Cmd
;	ldy #4
;	jsr SendDOSCmd
;;NewDsk1:
	jmp DoneWithIO

;.ifdef dontuse
NewDiskCommand:
		.byte "I"
;;InquireDisk_Cmd:
;;		.byte "U0"
;;		.byte 4
;.endif
;QueryDisk_Cmd:
;		.byte "U0"
;		.byte 138,18		;QueryDisk on track 18

__ReadBlock:
_ReadLink:
	jsr CheckParams
	bcs RdLink0
	ldy #0
	rts
RdLink0:
	; Burst Read command
	LoadB ReadWriteCmd, $00
	lda r1L
	sta ReadBlk_CmdTr
	sta ReadBlk_CmdTr2
	lda r1H
	sta ReadBlk_CmdSec
	ldx #>ReadBlk_Command
	lda #<ReadBlk_Command
	ldy #7
	jsr SendDOSCmd
	beqx :+
	rts

:	PushB config
	LoadB config, %01001110		; bank 1 only with HIROM and I/O
	PushB rcr
	LoadB rcr,    %01000000		; no sharing - all is bank 1
	SEI				; XXX needed ?
	CLC
	JSR k_Spinp			; only reason why HIROM is enabled
	BIT cia1ICR			; clear ICR register
	LDA ciaSerialClk
	EOR #$10			; toggle CLK
	STA ciaSerialClk

	LDA #8
:	BIT cia1ICR			; wait for status byte
	BEQ :-
	LDA ciaSerialClk
	EOR #$10
	STA ciaSerialClk

	LDA cia1Data
	STA STATUS
	AND #%00001111			; error?
	CMP #2
	BCS RdLinkErr			; yes

	LDY #0				; no, read the data
RdBurstLp:
	LDA ciaSerialClk
	EOR #$10			; toggle CLK
	TAX
	LDA #8
:	BIT cia1ICR			; wait for next byte
	BEQ :-
	STX ciaSerialClk
	LDA cia1Data
	STA (r4),y
inc $d020
	INY
	BNE RdBurstLp

	LDA #0		; no error

RdLinkErr:
	tax
	PopB rcr
	PopB config
LoadB $d020, 0
	rts

ReadBlk_Command:
		.byte "U0"
ReadWriteCmd:	.byte $00
ReadBlk_CmdTr:	.byte 1
ReadBlk_CmdSec:	.byte 0
		.byte 1
ReadBlk_CmdTr2:	.byte 1


__WriteBlock:
	ldx #0
	rts
		JSR CheckParams
		BCS WrBlock0
		RTS
WrBlock0:	; perform write
		; Burst Write command
		LoadB ReadWriteCmd, $02
	
		LDA r1L
		STA ReadBlk_CmdTr
		STA ReadBlk_CmdTr2
		LDA r1H
		STA ReadBlk_CmdSec
		; ...
		RTS

__VerWriteBlock:
		JSR CheckParams
		BCS VWrBlock0
		RTS
VWrBlock0:	; perform write, then
		; read, if failed -> upto tryCount=3
		; if read failed -> again, upto errCount=5
		JMP __WriteBlock


tmpclkreg:
	.byte 0
tmpPS:
	.byte 0
tmpgrirqen:
	.byte 0
tmpmobenble:
	.byte 0
borderFlag:
	.byte 0

