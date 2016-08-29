; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; System call jump table

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"

; init.s
.import _FirstInit

; icons.s
.import _DoIcons

; graph.s
.import _BitOtherClip
.import _BitmapClip
.import _i_ImprintRectangle
.import _ImprintRectangle
.import _i_BitmapUp
.import _i_GraphicsString
.import _i_RecoverRectangle
.import _i_FrameRectangle
.import _i_Rectangle
.import _BitmapUp
.import _TestPoint
.import _GetScanLine
.import _SetPattern
.import _GraphicsString
.import _DrawPoint
.import _DrawLine
.import _RecoverRectangle
.import _InvertRectangle
.import _FrameRectangle
.import _Rectangle
.import _VerticalLine
.import _RecoverLine
.import _InvertLine
.import _HorizontalLine

; keyboard.s
.import _GetNextChar

; process.s
.import _Sleep
.import _UnFreezeProcess
.import _FreezeProcess
.import _UnBlockProcess
.import _BlockProcess
.import _EnableProcess
.import _RestartProcess
.import _InitProcesses

; mouse.s
.import _IsMseInRegion
.import _ClearMouseMode
.import _MouseOff
.import _MouseUp
.import _StartMouseMode

; conio.s
.import _PromptOff
.import _PromptOn
.import _SmallPutChar
.import _LoadCharSet
.import _GetCharWidth
.import _InitTextPrompt
.import _GetString
.import _i_PutString
.import _PutDecimal
.import _UseSystemFont
.import _PutString
.import _PutChar

; reu.s
.import _DoRAMOp
.import _VerifyRAM
.import _SwapRAM
.import _FetchRAM
.import _StashRAM

; dlgbox.s
.import _RstrFrmDialogue
.import _DoDlgBox

; load.s
.import _GetFile
.import _LdApplic
.import _LdDeskAcc
.import _LdFile
.import _RstrAppl

; filesys.s
.import _AppendRecord
.import _BldGDirEntry
.import _CloseRecordFile
.import _DeleteFile
.import _DeleteRecord
.import _FastDelFile
.import _FindFTypes
.import _FindFile
.import _FollowChain
.import _FreeFile
.import _GetFHdrInfo
.import _GetPtrCurDkNm
.import _InsertRecord
.import _NextRecord
.import _OpenRecordFile
.import _PointRecord
.import _PreviousRecord
.import _ReadByte
.import _ReadFile
.import _ReadRecord
.import _RenameFile
.import _SaveFile
.import _SetDevice
.import _SetGDirEntry
.import _UpdateRecordFile
.import _WriteFile
.import _WriteRecord

; memory.s
.import _CmpFString
.import _CmpString
.import _CopyFString
.import _CopyString
.import _i_MoveData
.import _i_FillRam
.import _InitRam
.import _MoveData
.import _FillRam
.import _ClearRam

; math.s
.import _DShiftRight
.import _CRC
.import _GetRandom
.import _Ddec
.import _Dnegate
.import _Dabs
.import _DSDiv
.import _Ddiv
.import _DMult
.import _BMult
.import _BBMult
.import _DShiftLeft

; sprites.s
.import _DisablSprite
.import _EnablSprite
.import _PosSprite
.import _DrawSprite

; menu.s
.import _GotoFirstMenu
.import _ReDoMenu
.import _DoPreviousMenu
.import _RecoverAllMenus
.import _RecoverMenu
.import _DoMenu

; fonts.s
.import _GetRealSize

; tobasic.s
.import _ToBASIC

; main.s
.import _StartAppl
.import _EnterDeskTop
.import _MainLoop
.import _InterruptMain

; misc.s
.import _CallRoutine
.import _DoInlineReturn

; panic.s
.import _Panic

; serial.s
.import _GetSerialNumber

.segment "jumptab"

.assert * = $C100, error, "Jump table not at $C100"

.if !wheels

.byte $4c, $7f, $c3, $4c, $c4, $ca, $4c, $8f, $cb, $4c, $ae, $cb, $4c, $ab, $cb, $4c
.byte $b5, $cb, $4c, $a8, $cb, $4c, $b8, $cb, $4c, $7c, $c6, $4c, $81, $c6, $4c, $1b
.byte $c7, $4c, $b9, $c7, $4c, $25, $c8, $4c, $8d, $c8, $4c, $3c, $c8, $4c, $55, $c8
.byte $4c, $77, $e9, $4c, $03, $eb, $4c, $04, $c9, $4c, $07, $ca, $4c, $2d, $ca, $4c
.byte $40, $eb, $4c, $c1, $e3, $4c, $87, $e4, $4c, $17, $e6, $4c, $2a, $e6, $4c, $60
.byte $eb, $4c, $f6, $ec, $4c, $68, $ef, $4c, $57, $ef, $4c, $a2, $f0, $4c, $d5, $cc
.byte $4c, $e9, $cc, $4c, $0a, $cd, $4c, $0f, $cd, $4c, $42, $cd, $4c, $70, $cd, $4c
.byte $8c, $cd, $4c, $91, $cd, $4c, $a4, $cd, $4c, $66, $c5, $4c, $6a, $c5, $4c, $26
.byte $ce, $4c, $97, $c5, $4c, $c9, $e8, $4c, $b1, $cd, $4c, $a5, $eb, $4c, $9c, $eb
.byte $4c, $e9, $ed, $4c, $d4, $ed, $4c, $4a, $cf, $4c, $29, $cc, $4c, $91, $eb, $4c
.byte $19, $c8, $4c, $7e, $c8, $4c, $4c, $c8, $4c, $f1, $c8, $4c, $93, $e3, $4c, $de
.byte $e5, $4c, $00, $e0, $4c, $01, $d5, $4c, $05, $ce, $4c, $75, $e6, $4c, $da, $ed
.byte $4c, $22, $e8, $4c, $37, $c0, $4c, $49, $cc, $4c, $59, $e6, $4c, $32, $e6, $4c
.byte $6f, $cc, $4c, $b1, $cc, $4c, $b4, $cc, $4c, $ce, $c5, $6c, $20, $90, $6c, $2c
.byte $90, $6c, $0c, $90, $6c, $16, $90, $6c, $18, $90, $6c, $2e, $90, $4c, $6f, $d8
.byte $4c, $08, $d9, $4c, $40, $d9, $6c, $1e, $90, $4c, $89, $9d, $6c, $2a, $90, $4c
.byte $86, $9d, $4c, $0e, $e5, $4c, $7c, $d5, $4c, $53, $9e, $4c, $a3, $d6, $4c, $f1
.byte $e8, $4c, $3c, $d5, $6c, $08, $90, $4c, $c3, $d7, $6c, $0e, $90, $4c, $4e, $d8
.byte $6c, $10, $90, $6c, $12, $90, $4c, $c7, $d9, $4c, $69, $d7, $4c, $26, $c3, $4c
.byte $31, $c3, $6c, $04, $90, $6c, $06, $90, $4c, $b8, $d9, $4c, $d3, $d5, $4c, $1d
.byte $d8, $4c, $8c, $9d, $4c, $74, $da, $6c, $1a, $90, $6c, $1c, $90, $6c, $28, $90
.byte $4c, $6e, $c8, $4c, $65, $c8, $4c, $e6, $f1, $4c, $b9, $da, $6c, $00, $90, $6c
.byte $02, $90, $4c, $df, $cc, $4c, $e7, $cd, $4c, $e9, $cd, $4c, $a1, $ce, $4c, $a3
.byte $ce, $4c, $06, $c5, $4c, $f2, $da, $4c, $6c, $db, $4c, $b9, $db, $4c, $c2, $db
.byte $4c, $c8, $db, $4c, $e1, $db, $4c, $1b, $dc, $4c, $33, $dc, $4c, $4d, $dc, $4c
.byte $60, $dc, $6c, $24, $90, $4c, $75, $db, $4c, $71, $c3, $4c, $e4, $e7, $4c, $08
.byte $e8, $6c, $14, $90, $4c, $da, $c5, $4c, $5b, $fc, $4c, $46, $e3, $6c, $26, $90
.byte $4c, $e9, $d6, $4c, $c4, $ce, $4c, $b6, $dd, $6c, $22, $90, $6c, $0a, $90, $4c
.byte $56, $f3, $4c, $f0, $ce, $4c, $43, $e3, $4c, $ad, $9e, $4c, $b3, $9e, $4c, $b0
.byte $9e, $4c, $aa, $9e, $4c, $b5, $9e

.else
InterruptMain:
	jmp _InterruptMain
InitProcesses:
	jmp _InitProcesses
RestartProcess:
	jmp _RestartProcess
EnableProcess:
	jmp $cbae;xxx_EnableProcess
BlockProcess:
	jmp $cbab;xxx_BlockProcess
UnBlockProcess:
	jmp $cbb5;xxx_UnBlockProcess
FreezeProcess:
	jmp $cba8;xxx_FreezeProcess
UnFreezeProcess:
	jmp $cbb8;xxx_UnFreezeProcess
HorizontalLine:
	jmp _HorizontalLine
InvertLine:
	jmp $C681;xxx_InvertLine
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
	jmp $C037;xxx_MainLoop
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
	jmp $9E53;xxx_GetFile
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
	jmp $c326;xxx_EnterDeskTop
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
	jmp $9d8c;xxx_ToBASIC
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
.if gateway
	jmp _EnterDeskTop
.else
	jmp _Panic
.endif
BitOtherClip:
	jmp _BitOtherClip
.if (REUPresent)
StashRAM:
	jmp $9ead;xxx_StashRAM
FetchRAM:
	jmp $9eb3;xxx_FetchRAM
SwapRAM:
	jmp $9eb0;xxx_SwapRAM
VerifyRAM:
	jmp $9eaa;xxx_VerifyRAM
DoRAMOp:
	jmp $9eb5;xxx_DoRAMOp
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
.endif

.if wheels
LC0CD = $C0CD
LC38E = $C38E
LC391 = $C391
LC4E6 = $C4E6
LC4A8 = $C4A8
LFA73 = $FA73
LC083 = $C083
LD5D3 = $D5D3
LC020 = $C020
LC01E = $C01E
LC01B = $C01B
LC58C = $C58C

.macro UNIMPLEMENTED
	rts
	nop
	nop
.endmacro

; C128 syscalls
TempHideMouse:
	UNIMPLEMENTED
SetMousePicture:
	UNIMPLEMENTED
SetNewMode:
	UNIMPLEMENTED
NormalizeX:
	UNIMPLEMENTED
MoveBData:
	UNIMPLEMENTED
SwapBData:
	UNIMPLEMENTED
VerifyBData:
	UNIMPLEMENTED
DoBOp:
	UNIMPLEMENTED
AccessCache:
	UNIMPLEMENTED
HideOnlyMouse:
	UNIMPLEMENTED
SetColorMode:
	UNIMPLEMENTED
ColorCard:
	UNIMPLEMENTED
ColorRectangle:
	UNIMPLEMENTED

; new Wheels syscalls
LC2FE:
	jmp LC58C
LC301:
	jmp LC01B
LC304:
	jmp LC01E
LC307:
	jmp LC020
LC30A:
	jmp LD5D3
LC30D:
	jmp LC083
LC310:
	jmp LFA73
LC313:
	jmp LC4A8
LC316:
	jmp LC4E6
LC319:
	jmp LC391
LC31C:
	jmp LC38E
LC31F:	jmp LC0CD

	.byte 0, 0, 0 ; ???

LC325:	.byte 0
.endif