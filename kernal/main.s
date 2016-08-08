; GEOS Kernal
; system core - all address-aligned data (for compatibility), core (EnterDeskTop) and init stuff
; reassembled by Maciej 'YTM/Alliance' Witkowiak

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.import InitMsePic, ClrScr, _DoUpdateTime, _DoCheckDelays, _ExecuteProcesses, _DoCheckButtons, ResetMseRegion, ProcessCursor, _ProcessDelays, _ProcessTimers, ProcessMouse, _DoRAMOp, _VerifyRAM, _SwapRAM, _FetchRAM, _StashRAM
.import _BitOtherClip, _RstrFrmDialogue, _ReadByte, _IsMseInRegion, _SetDevice, _BitmapClip, _GetNextChar, _PromptOff, _PromptOn, _GetPtrCurDkNm, _UpdateRecordFile
.import _WriteRecord, _ReadRecord, _AppendRecord, _InsertRecord, _DeleteRecord, _PointRecord, _PreviousRecord, _NextRecord, _CloseRecordFile, _OpenRecordFile, _CmpFString, _CmpString, _CopyFString, _CopyString, _DShiftRight
.import _RenameFile, _DoDlgBox, _i_ImprintRectangle, _ImprintRectangle, _FastDelFile, _RstrAppl, _FindFTypes, _DeleteFile, _GetFHdrInfo, _FreeFile
.import _LdApplic, _LdDeskAcc, _LdFile, _CRC, _FindFile, _GetFile, _FollowChain, _SmallPutChar, _ReadFile, _WriteFile
.import _BldGDirEntry, _SetGDirEntry, _SaveFile, _DisablSprite, _EnablSprite, _PosSprite, _LoadCharSet, _GetCharWidth, _DrawSprite
.import _InitTextPrompt, _GotoFirstMenu, _GetString, _i_MoveData, _i_FillRam, _GetRealSize, _i_PutString, _i_BitmapUp, _i_GraphicsString, _i_RecoverRectangle, _i_FrameRectangle, _i_Rectangle, _ClearMouseMode, _Sleep, _ReDoMenu, _DoPreviousMenu
.import _MouseOff, _MouseUp, _GetRandom, _PutDecimal, _MoveData, _FillRam, _ClearRam, _Ddec, _Dnegate, _Dabs, _DSDiv, _Ddiv, _DMult, _BMult, _BBMult, _DShiftLeft
.import _DoIcons, _RecoverAllMenus, _RecoverMenu, _DoMenu, _StartMouseMode, _UseSystemFont, _PutString, _PutChar, _BitmapUp, _TestPoint, _GetScanLine, _SetPattern, _GraphicsString, _DrawPoint, _DrawLine, _RecoverRectangle
.import _InvertRectangle, _FrameRectangle, _Rectangle, _VerticalLine, _RecoverLine, _InvertLine, _HorizontalLine, _UnFreezeProcess, _FreezeProcess, _UnBlockProcess, _BlockProcess, _EnableProcess, _RestartProcess, _InitProcesses, DoPLAINTEXT, DoOUTLINEON
.import DoITALICON, DoBOLDON, DoNEWCARDSET, DoGOTOXY, DoGOTOY, DoGOTOX, DoREV_OFF, DoREV_ON, DoESC_RULER, DoESC_GRAPHICS, DoULINEOFF, DoULINEON, DoCR, DoUPLINE, DoHOME, DoLF
.import LoKernal1, LoKernalBuf
.import DoTAB, DoBACKSPACE
.global BitMask1, BitMask2, BitMask3, BitMask4
.global DBIcPicDISK, DBIcPicNO, DBIcPicOPEN, DBIcPicYES, DecTabH, DecTabL, DkNmTab, FontTVar1, FontTVar2, InitGEOEnv, LineTabH, LineTabL, PutCharTabH, PutCharTabL, SprTabH, SprTabL, UNK_4, UNK_5, _DoFirstInitIO, _EnterDeskTop, _FirstInit, _MNLP, dateCopy, daysTab, Init_KRNLVec, _GetSerialNumber, _GetSerialNumber2

.segment "main"

;--------------------------------------------
;IMPORTANT! DO NOT CHANGE ANYTHING BELOW, UP TO 'DESK TOP' STRING.
;DOING SO WILL CREATE FATAL INCOMPATIBILITES!
;--------------------------------------------

	jmp BootKernal
	jmp InitKernal

bootName:
	.byte "GEOS BOOT"
version:
	.byte $20
nationality:
	.byte $00,$00
sysFlgCopy:
	.byte $00
c128Flag:
	.byte $00
	.byte $05,$00,$00,$00
dateCopy:
.ifdef maurice
	.byte 92,3,23
.else
	.byte 88,4,20
.endif

.segment "main5"
;--------------------------------------------

BitMask1:
	.byte $80, $40, $20, $10, $08, $04, $02
BitMask2:
	.byte $01, $02, $04, $08, $10, $20, $40, $80
BitMask3:
	.byte $00, $80, $c0, $e0, $f0, $f8, $fc, $fe
BitMask4:
	.byte $7f, $3f, $1f, $0f, $07, $03, $01, $00

.segment "main9"
VIC_IniTbl:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $3b, $fb, $aa, $aa, $01, $08, $00
	.byte $38, $0f, $01, $00, $00, $00

.segment "graph2"
LineTabL:
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00
LineTabH:
	.byte $a0, $a1, $a2, $a3, $a5, $a6, $a7, $a8
	.byte $aa, $ab, $ac, $ad, $af, $b0, $b1, $b2
	.byte $b4, $b5, $b6, $b7, $b9, $ba, $bb, $bc
	.byte $be

.segment "panic2"
_PanicDB_DT:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
	.byte NULL

_PanicDB_Str:
	.byte BOLDON
	.byte "System error near $"
_PanicAddy:
	.byte "xxxx"
	.byte NULL

.segment "fonttvar"

FontTVar1:
	.byte 0
FontTVar2:
.ifdef maurice
    ; This should be initialized to 0, and will
    ; be changed at runtime.
    ; Maurice's version was created by dumping
    ; KERNAL from memory after it had been running,
    ; so it has a random value here.
	.word $34
.else
	.word 0
.endif

.segment "sprites2"

SprTabL:
	.byte <spr0pic, <spr1pic, <spr2pic, <spr3pic
	.byte <spr4pic, <spr5pic, <spr6pic, <spr7pic
SprTabH:
	.byte >spr0pic, >spr1pic, >spr2pic, >spr3pic
	.byte >spr4pic, >spr5pic, >spr6pic, >spr7pic

.segment "conio2"

PutCharTabL:
	.byte <DoBACKSPACE, <DoTAB
	.byte <DoLF, <DoHOME
	.byte <DoUPLINE, <DoCR
	.byte <DoULINEON, <DoULINEOFF
	.byte <DoESC_GRAPHICS, <DoESC_RULER
	.byte <DoREV_ON, <DoREV_OFF
	.byte <DoGOTOX, <DoGOTOY
	.byte <DoGOTOXY, <DoNEWCARDSET
	.byte <DoBOLDON, <DoITALICON
	.byte <DoOUTLINEON, <DoPLAINTEXT

PutCharTabH:
	.byte >DoBACKSPACE, >DoTAB
	.byte >DoLF, >DoHOME
	.byte >DoUPLINE, >DoCR
	.byte >DoULINEON, >DoULINEOFF
	.byte >DoESC_GRAPHICS, >DoESC_RULER
	.byte >DoREV_ON, >DoREV_OFF
	.byte >DoGOTOX, >DoGOTOY
	.byte >DoGOTOXY, >DoNEWCARDSET
	.byte >DoBOLDON, >DoITALICON
	.byte >DoOUTLINEON, >DoPLAINTEXT

.segment "conio4"

DecTabL:
	.byte <1, <10, <100, <1000, <10000
DecTabH:
	.byte >1, >10, >100, >1000, >10000

.segment "daystab"

daysTab:
	.byte 31, 28, 31, 30, 31, 30
	.byte 31, 31, 30, 31, 30, 31

.segment "X"

.if (useRamExp)
DeskTopOpen:
	.byte 0 ;these two bytes are here just
DeskTopRecord:
	.byte 0 ;to keep OS_JUMPTAB at $c100
	.byte 0,0,0 ;three really unused
.endif

.segment "main3"
;--------------------------------------------
;here the JumpTable begins, DO NOT CHANGE!!!
;		*= OS_JUMPTAB

InterruptMain:
	jmp _InterruptMain
InitProcesses:
	jmp _InitProcesses
RestartProcess:
	jmp _RestartProcess
EnableProcess:
	jmp _EnableProcess
BlockProcess:
	jmp _BlockProcess
UnBlockProcess:
	jmp _UnBlockProcess
FreezeProcess:
	jmp _FreezeProcess
UnFreezeProcess:
	jmp _UnFreezeProcess
HorizontalLine:
	jmp _HorizontalLine
InvertLine:
	jmp _InvertLine
RecoverLine:
	jmp _RecoverLine
VerticalLine:
	jmp _VerticalLine
Rectangle:
	jmp _Rectangle
FrameRectangle:
	jmp _FrameRectangle
InvertRectangle:
	jmp _InvertRectangle
RecoverRectangle:
	jmp _RecoverRectangle
DrawLine:
	jmp _DrawLine
DrawPoint:
	jmp _DrawPoint
GraphicsString:
	jmp _GraphicsString
SetPattern:
	jmp _SetPattern
GetScanLine:
	jmp _GetScanLine
TestPoint:
	jmp _TestPoint
BitmapUp:
	jmp _BitmapUp
PutChar:
	jmp _PutChar
PutString:
	jmp _PutString
UseSystemFont:
	jmp _UseSystemFont
StartMouseMode:
	jmp _StartMouseMode
DoMenu:
	jmp _DoMenu
RecoverMenu:
	jmp _RecoverMenu
RecoverAllMenus:
	jmp _RecoverAllMenus
DoIcons:
	jmp _DoIcons
DShiftLeft:
	jmp _DShiftLeft
BBMult:
	jmp _BBMult
BMult:
	jmp _BMult
DMult:
	jmp _DMult
Ddiv:
	jmp _Ddiv
DSDiv:
	jmp _DSDiv
Dabs:
	jmp _Dabs
Dnegate:
	jmp _Dnegate
Ddec:
	jmp _Ddec
ClearRam:
	jmp _ClearRam
FillRam:
	jmp _FillRam
MoveData:
	jmp _MoveData
InitRam:
	jmp _InitRam
PutDecimal:
	jmp _PutDecimal
GetRandom:
	jmp _GetRandom
MouseUp:
	jmp _MouseUp
MouseOff:
	jmp _MouseOff
DoPreviousMenu:
	jmp _DoPreviousMenu
ReDoMenu:
	jmp _ReDoMenu
GetSerialNumber:
	jmp _GetSerialNumber
Sleep:
	jmp _Sleep
ClearMouseMode:
	jmp _ClearMouseMode
i_Rectangle:
	jmp _i_Rectangle
i_FrameRectangle:
	jmp _i_FrameRectangle
i_RecoverRectangle:
	jmp _i_RecoverRectangle
i_GraphicsString:
	jmp _i_GraphicsString
i_BitmapUp:
	jmp _i_BitmapUp
i_PutString:
	jmp _i_PutString
GetRealSize:
	jmp _GetRealSize
i_FillRam:
	jmp _i_FillRam
i_MoveData:
	jmp _i_MoveData
GetString:
	jmp _GetString
GotoFirstMenu:
	jmp _GotoFirstMenu
InitTextPrompt:
	jmp _InitTextPrompt
MainLoop:
	jmp _MainLoop
DrawSprite:
	jmp _DrawSprite
GetCharWidth:
	jmp _GetCharWidth
LoadCharSet:
	jmp _LoadCharSet
PosSprite:
	jmp _PosSprite
EnablSprite:
	jmp _EnablSprite
DisablSprite:
	jmp _DisablSprite
CallRoutine:
	jmp _CallRoutine
CalcBlksFree:
	jmp (_CalcBlksFree)
ChkDkGEOS:
	jmp (_ChkDkGEOS)
NewDisk:
	jmp (_NewDisk)
GetBlock:
	jmp (_GetBlock)
PutBlock:
	jmp (_PutBlock)
SetGEOSDisk:
	jmp (_SetGEOSDisk)
SaveFile:
	jmp _SaveFile
SetGDirEntry:
	jmp _SetGDirEntry
BldGDirEntry:
	jmp _BldGDirEntry
GetFreeDirBlk:
	jmp (_GetFreeDirBlk)
WriteFile:
	jmp _WriteFile
BlkAlloc:
	jmp (_BlkAlloc)
ReadFile:
	jmp _ReadFile
SmallPutChar:
	jmp _SmallPutChar
FollowChain:
	jmp _FollowChain
GetFile:
	jmp _GetFile
FindFile:
	jmp _FindFile
CRC:
	jmp _CRC
LdFile:
	jmp _LdFile
EnterTurbo:
	jmp (_EnterTurbo)
LdDeskAcc:
	jmp _LdDeskAcc
ReadBlock:
	jmp (_ReadBlock)
LdApplic:
	jmp _LdApplic
WriteBlock:
	jmp (_WriteBlock)
VerWriteBlock:
	jmp (_VerWriteBlock)
FreeFile:
	jmp _FreeFile
GetFHdrInfo:
	jmp _GetFHdrInfo
EnterDeskTop:
	jmp _EnterDeskTop
StartAppl:
	jmp _StartAppl
ExitTurbo:
	jmp (_ExitTurbo)
PurgeTurbo:
	jmp (_PurgeTurbo)
DeleteFile:
	jmp _DeleteFile
FindFTypes:
	jmp _FindFTypes
RstrAppl:
	jmp _RstrAppl
ToBASIC:
	jmp _ToBASIC
FastDelFile:
	jmp _FastDelFile
GetDirHead:
	jmp (_GetDirHead)
PutDirHead:
	jmp (_PutDirHead)
NxtBlkAlloc:
	jmp (_NxtBlkAlloc)
ImprintRectangle:
	jmp _ImprintRectangle
i_ImprintRectangle:
	jmp _i_ImprintRectangle
DoDlgBox:
	jmp _DoDlgBox
RenameFile:
	jmp _RenameFile
InitForIO:
	jmp (_InitForIO)
DoneWithIO:
	jmp (_DoneWithIO)
DShiftRight:
	jmp _DShiftRight
CopyString:
	jmp _CopyString
CopyFString:
	jmp _CopyFString
CmpString:
	jmp _CmpString
CmpFString:
	jmp _CmpFString
FirstInit:
	jmp _FirstInit
OpenRecordFile:
	jmp _OpenRecordFile
CloseRecordFile:
	jmp _CloseRecordFile
NextRecord:
	jmp _NextRecord
PreviousRecord:
	jmp _PreviousRecord
PointRecord:
	jmp _PointRecord
DeleteRecord:
	jmp _DeleteRecord
InsertRecord:
	jmp _InsertRecord
AppendRecord:
	jmp _AppendRecord
ReadRecord:
	jmp _ReadRecord
WriteRecord:
	jmp _WriteRecord
SetNextFree:
	jmp (_SetNextFree)
UpdateRecordFile:
	jmp _UpdateRecordFile
GetPtrCurDkNm:
	jmp _GetPtrCurDkNm
PromptOn:
	jmp _PromptOn
PromptOff:
	jmp _PromptOff
OpenDisk:
	jmp (_OpenDisk)
DoInlineReturn:
	jmp _DoInlineReturn
GetNextChar:
	jmp _GetNextChar
BitmapClip:
	jmp _BitmapClip
FindBAMBit:
	jmp (_FindBAMBit)
SetDevice:
	jmp _SetDevice
IsMseInRegion:
	jmp _IsMseInRegion
ReadByte:
	jmp _ReadByte
FreeBlock:
	jmp (_FreeBlock)
ChangeDiskDevice:
	jmp (_ChangeDiskDevice)
RstrFrmDialogue:
	jmp _RstrFrmDialogue
Panic:
	jmp _Panic
BitOtherClip:
	jmp _BitOtherClip
.if (REUPresent)
StashRAM:
	jmp _StashRAM
FetchRAM:
	jmp _FetchRAM
SwapRAM:
	jmp _SwapRAM
VerifyRAM:
	jmp _VerifyRAM
DoRAMOp:
	jmp _DoRAMOp
.else
StashRAM:
	ldx #DEV_NOT_FOUND
	rts
FetchRAM:
	ldx #DEV_NOT_FOUND
	rts
SwapRAM:
	ldx #DEV_NOT_FOUND
	rts
VerifyRAM:
	ldx #DEV_NOT_FOUND
	rts
DoRAMOp:
	ldx #DEV_NOT_FOUND
	rts
.endif
;here the JumpTable ends
;--------------------------------------------

.segment "main2"
DkNmTab:
	.byte <DrACurDkNm, <DrBCurDkNm
	.byte <DrCCurDkNm, <DrDCurDkNm
	.byte >DrACurDkNm, >DrBCurDkNm
	.byte >DrCCurDkNm, >DrDCurDkNm

.segment "main4"
_InterruptMain:
	jsr ProcessMouse
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom

.segment "main15"
_CallRoutine:
	cmp #0
	bne CRou1
	cpx #0
	beq CRou2
CRou1:
	sta CallRLo
	stx CallRHi
	jmp (CallRLo)
CRou2:
	rts

_DoInlineReturn:
	add returnAddress
	sta returnAddress
	bcc DILR1
	inc returnAddress+1
DILR1:
	plp
	jmp (returnAddress)

SetVICRegs:
	sty r1L
	ldy #0
SVR0:
	lda (r0),Y
	cmp #$AA
	beq SVR1
	sta vicbase,Y
SVR1:
	iny
	cpy r1L
	bne SVR0
	rts

.segment "main14"
_InitRam:
	ldy #0
	lda (r0),Y
	sta r1L
	iny
	ora (r0),Y
	beq IRam3
	lda (r0),Y
	sta r1H
	iny
	lda (r0),Y
	sta r2L
	iny
IRam0:
	tya
	tax
	lda (r0),Y
	ldy #0
	sta (r1),Y
	inc r1L
	bne IRam1
	inc r1H
IRam1:
	txa
	tay
	iny
	dec r2L
	bne IRam0
	tya
	add r0L
	sta r0L
	bcc IRam2
	inc r0H
IRam2:
	bra _InitRam
IRam3:
	rts

.segment "main8"
InitGEOS:
	jsr _DoFirstInitIO ;UNK_1
InitGEOEnv:
	lda #>InitRamTab ;UNK_1_1
	sta r0H
	lda #<InitRamTab
	sta r0L
	jmp _InitRam

.segment "main10"
_DoFirstInitIO:
	LoadB CPU_DDR, $2f
	LoadB CPU_DATA, KRNL_IO_IN
	ldx #7
	lda #$ff
DFIIO0:
	sta KbdDMltTab,X
	sta KbdDBncTab,X
	dex
	bpl DFIIO0
	stx KbdQueFlag
	stx cia1base+2
	inx
	stx KbdQueHead
	stx KbdQueTail
	stx cia1base+3
	stx cia1base+15
	stx cia2base+15
	lda PALNTSCFLAG
	beq DFIIO1
	ldx #$80
DFIIO1:
	stx cia1base+14
	stx cia2base+14
	lda cia2base
	and #%00110000
	ora #%00000101
	sta cia2base
	LoadB cia2base+2, $3f
	LoadB cia1base+13, $7f
	sta cia2base+13
	LoadW r0, VIC_IniTbl
	ldy #30
	jsr SetVICRegs
	jsr Init_KRNLVec
	LoadB CPU_DATA, RAM_64K
	jmp ResetMseRegion

.segment "X"
.if (useRamExp)
DeskTopStart:
	.word 0 ;these are for ensuring compatibility with
DeskTopExec:
	.word 0 ;DeskTop replacements - filename of desktop
DeskTopLgh:
	.byte 0 ;have to be at $c3cf .IDLE
.endif

.segment "main7b"
DeskTopName:
	.byte "DESK TOP", NULL

.segment "main1c"
;--------------------------------------------
;IMPORTANT! FROM NOW ON YOU CAN CHANGE THE CODE UNTIL FURTHER NOTICES.
;--------------------------------------------
_MainLoop:
	jsr _DoCheckButtons
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:
	jsr CallRoutine
	cli
	jmp _MainLoop2

.segment "main6"
_MainLoop2:
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
	jmp _MainLoop

.segment "main1b"
BootKernal:
	bbsf 5, sysFlgCopy, BootREU
	jsr $FF90
	lda #version-bootName
	ldx #<bootName
	ldy #>bootName
	jsr $FFBD
	lda #$50
	ldx #8
	ldy #1
	jsr $FFBA
	lda #0
	jsr $FFD5
	bcc _RunREU
	jmp ($0302)
BootREU:
	ldy #8
BootREU1:
	lda BootREUTab,Y
	sta EXP_BASE+1,Y
	dey
	bpl BootREU1
BootREU2:
	dey
	bne BootREU2
_RunREU:
	jmp RunREU
BootREUTab:
	.word $0091
	.word $0060
	.word $007e
	.word $0500
	.word $0000

.if (removeToBASIC)
_ToBASIC:
	sei
	jsr PurgeTurbo
	LoadB CPU_DATA, KRNL_BAS_IO_IN
	LoadB $DE00, 0
	jmp $fce2
.else
_ToBASIC:
	ldy #39
TB1:
	lda (r0),Y
	cmp #'A'
	bcc TB2
	cmp #'Z'+1
	bcs TB2
	sbc #$3F
TB2:
	sta LoKernalBuf,Y
	dey
	bpl TB1
	lda r5H
	beq TB4
	iny
	tya
TB3:
	sta BASICspace,Y
	iny
	bne TB3
	SubVW $0002,r7
	lda (r7),Y
	pha
	iny
	lda (r7),Y
	pha
	PushW r7
	lda (r5),Y
	sta r1L
	iny
	lda (r5),Y
	sta r1H
.if 1
	lda #$ff
	sta r2L
	sta r2H
.else
	LoadW r2, $ffff
.endif
	jsr _ReadFile
	PopW r0
	ldy #1
	pla
	sta (r0),Y
	dey
	pla
	sta (r0),Y
TB4:
	jsr GetDirHead
	jsr PurgeTurbo
	lda sysRAMFlg
	sta sysFlgCopy
	and #%00100000
	beq TB6
	ldy #6
TB5:
	lda ToBASICTab,Y
	sta r0,Y
	dey
	bpl TB5
	jsr StashRAM
TB6:
	jmp LoKernal1
ToBASICTab:
	.word dirEntryBuf
	.word REUOsVarBackup
	.word OS_VARS_LGH
	.byte $00
.endif

.segment "main7a"
.if (useRamExp)
_EnterDeskTop:
	sei
	cld
	ldx #$ff
	stx firstBoot
	txs
	jsr ClrScr
	jsr InitGEOS
	MoveW DeskTopStart, r0
	MoveB DeskTopLgh, r2H
	LoadW r1, 1
	jsr RamExpRead
	LoadB r0L, NULL
	MoveW DeskTopExec, r7
.else
_EnterDT_DB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word _EnterDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word _EnterDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL

.segment "main7c"
_EnterDT_Str0:
	.byte BOLDON, "Please insert a disk", NULL
_EnterDT_Str1:
	.byte "with deskTop V1.5 or higher", NULL

.segment "main7"
_EnterDeskTop:
	sei
	cld
	ldx #$ff
	stx firstBoot
	txs
	jsr ClrScr
	jsr InitGEOS
	MoveB curDrive, TempCurDrive
	eor #1
	tay
	lda _driveType,Y
	php
	lda TempCurDrive
	plp
	bpl EDT1
	tya
EDT1:
	jsr EDT3
	ldy NUMDRV
	cpy #2
	bcc EDT2
	lda curDrive
	eor #1
	jsr EDT3
EDT2:
	LoadW r0, _EnterDT_DB
	jsr DoDlgBox
	lda TempCurDrive
	bne EDT1
EDT3:
	jsr SetDevice
	jsr OpenDisk
	beqx EDT5
EDT4:
	rts
EDT5:
	sta r0L
	LoadW r6, DeskTopName
	jsr GetFile
	bnex EDT4
	lda fileHeader+O_GHFNAME+13
	cmp #'1'
	bcc EDT4
	bne EDT6
	lda fileHeader+O_GHFNAME+15
	cmp #'5'
	bcc EDT4
EDT6:
	lda TempCurDrive
	jsr SetDevice
	LoadB r0L, NULL
	MoveW fileHeader+O_GHST_VEC, r7
.endif
_StartAppl:
	sei
	cld
	ldx #$FF
	txs
	jsr UNK_5
	jsr InitGEOS
	jsr _UseSystemFont
	jsr UNK_4
	ldx r7H
	lda r7L
	jmp _MNLP

.segment "main16"
UNK_4:
	MoveB A885D, r10L
	MoveB A885E, r0L
	and #1
	beq U_40
	MoveW A885F, r7
U_40:
	LoadW r2, dataDiskName
	LoadW r3, dataFileName
U_41:
	rts


UNK_5:
	MoveW r7, A885F
	MoveB r10L, A885D
	MoveB r0L, A885E
	and #%11000000
	beq U_51
	ldy #>dataDiskName
	lda #<dataDiskName
	ldx #r2
	jsr U_50
	ldy #>dataFileName
	lda #<dataFileName
	ldx #r3
U_50:
	sty r4H
	sta r4L
	ldy #r4
	lda #16
	jsr CopyFString
U_51:
	rts

.segment "main12"

Init_KRNLVec:
	ldx #32
IKV1:
	lda KERNALVecTab-1,X
	sta irqvec-1,X
	dex
	bne IKV1
	rts

_FirstInit:
	sei
	cld
	jsr InitGEOS
	LoadW EnterDeskTop+1, _EnterDeskTop
	LoadB maxMouseSpeed, iniMaxMouseSpeed
	LoadB minMouseSpeed, iniMinMouseSpeed
	LoadB mouseAccel, iniMouseAccel
	LoadB screencolors, (DKGREY << 4)+LTGREY
	sta FItempColor
	jsr i_FillRam
	.word 1000
	.word COLOR_MATRIX
FItempColor:
	.byte (DKGREY << 4)+LTGREY
	ldx CPU_DATA
	LoadB CPU_DATA, IO_IN
	LoadB mob0clr, BLUE
	sta mob1clr
	LoadB extclr, BLACK
	stx CPU_DATA
	ldy #62
FI1:
	lda #0
	sta mousePicData,Y
	dey
	bpl FI1
	ldx #24
FI2:
	lda InitMsePic-1,X
	sta mousePicData-1,X
	dex
	bne FI2
	jmp UNK_6

.segment "getserial"

_GetSerialNumber:
;	LoadW r0, SerialNumber
	lda $9EA7
	sta r0L
_GetSerialNumber2:
	lda $9EA8
	sta r0H
	rts
	.byte 1, $60 ; ???

.segment "panic"

_Panic:
	PopW r0
	SubVW 2, r0
	lda r0H
	ldx #0
	jsr Panil0
	lda r0L
	jsr Panil0
	LoadW r0, _PanicDB_DT
	jsr DoDlgBox
Panil0:
	pha
	lsr
	lsr
	lsr
	lsr
	jsr Panil1
	inx
	pla
	and #%00001111
	jsr Panil1
	inx
	rts
Panil1:
	cmp #10
	bcs Panil2
	addv ('0')
	bne Panil3
Panil2:
	addv ('0'+7)
Panil3:
	sta _PanicAddy,X
	rts

.segment "initramtab"

InitRamTab:
	.word currentMode
	.byte 12
	.byte NULL
	.byte ST_WR_FORE | ST_WR_BACK
	.byte NULL
	.word mousePicData
	.byte NULL, SC_PIX_HEIGHT-1
	.word NULL, SC_PIX_WIDTH-1
	.byte NULL
	.word appMain
	.byte 28
	.word NULL, _InterruptMain
	.word NULL, NULL, NULL, NULL
	.word NULL, NULL, NULL, NULL
	.word _Panic, _RecoverRectangle
	.byte SelectFlashDelay, NULL
	.byte ST_FLASH, NULL
	.word NumTimers
	.byte 2
	.byte NULL, NULL
	.word clkBoxTemp
	.byte 1
	.byte NULL
	.word IconDescVecH
	.byte 1
	.byte NULL
	.word obj0Pointer
	.byte 8
	.byte $28, $29, $2a, $2b
	.byte $2c, $2d, $2e, $2f
	.word NULL

.segment "unk6"

UNK_6:
	lda #$bf
	sta A8FF0
	ldx #7
	lda #$bb
UNK_61:
	sta A8FE8,x
	dex
	bpl UNK_61
	rts

.segment "icon3"

DBIcPicNO:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+12
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00000001, %11001100, %01111100, %00000000, %00000011
	.byte %10000000, %00000001, %11001100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000001, %11101100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	     ;%10000000, %00000001, %11101100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10111100, %11000110, %00000000, %00000011, $db+8, 2, $80+6
	     ;%10000000, %00000001, %10111100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10011100, %11000110, %00000000, %00000011, $80+6
	     ;%10000000, %00000001, %10011100, %11000110, %00000000, %00000011
	.byte %10000000, %00000001, %10001100, %01111100, %00000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicYES:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(5*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00001100, %11001111, %11000111, %11000000, %00000011 ;1
	.byte %10000000, %00001100, %11001100, %00001100, %01100000, %00000011 ;2
	.byte %10000000, %00001100, %11001100, %00001100, %00000000, %00000011 ;3
	.byte %10000000, %00000111, %10001100, %00001100, %00000000, %00000011 ;4
	.byte %10000000, %00000111, %10001111, %10000111, %11000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000011, %00001100, %00000000, %01100000, %00000011, $80+12
	     ;%10000000, %00000011, %00001100, %00000000, %01100000, %00000011
	.byte %10000000, %00000011, %00001100, %00001100, %01100000, %00000011
	.byte %10000000, %00000011, %00001111, %11000111, %11000000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicOPEN:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(9*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00111110, %00000000, %00000000, %00000000, %00000011 ;1
	.byte %10000000, %01100011, %00000000, %00000000, %00000000, %00000011 ;2
	.byte %10000000, %01100011, %01111100, %01111001, %11110000, %00000011 ;3
	.byte %10000000, %01100011, %01100110, %11001101, %11011000, %00000011 ;4
	.byte %10000000, %01100011, %01100110, %11001101, %10011000, %00000011 ;5
	.byte %10000000, %01100011, %01100110, %11111101, %10011000, %00000011 ;6
	.byte %10000000, %01100011, %01100110, %11000001, %10011000, %00000011 ;7
	.byte %10000000, %01100011, %01100110, %11001101, %10011000, %00000011 ;8
	.byte %10000000, %00111110, %01111100, %01111001, %10011000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %01100000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %01100000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

DBIcPicDISK:
	.byte 5, %11111111, $80+1, %11111110, $db+8, 2, $80+6
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111110
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011, $80+(9*6)
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	.byte %10000000, %00011111, %00001100, %00000011, %00000000, %00000011 ;1
	.byte %10000000, %00011001, %10000000, %00000011, %00000000, %00000011 ;2
	.byte %10000000, %00011000, %11011100, %11110011, %00110000, %00000011 ;3
	.byte %10000000, %00011000, %11001101, %10011011, %01100000, %00000011 ;4
	.byte %10000000, %00011000, %11001101, %10000011, %11000000, %00000011 ;5
	.byte %10000000, %00011000, %11001100, %11110011, %10000000, %00000011 ;6
	.byte %10000000, %00011000, %11001100, %00011011, %11000000, %00000011 ;7
	.byte %10000000, %00011001, %10001101, %10011011, %01100000, %00000011 ;8
	.byte %10000000, %00011111, %00001100, %11110011, %00110000, %00000011, $db+8, 2, $80+6
	.byte %10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%10000000, %00000000, %00000000, %00000000, %00000000, %00000011
	     ;%11111111, %11111111, %11111111, %11111111, %11111111, %11111111
	     ;%01111111, %11111111, %11111111, %11111111, %11111111, %11111111
	.byte 6, %11111111, $80+1, %01111111, 5, %11111111

