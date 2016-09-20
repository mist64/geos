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
.import _i_ImprintRectangle
.import _i_BitmapUp
.import _i_GraphicsString
.import _i_RecoverRectangle
.import _i_FrameRectangle
.import _i_Rectangle
.import _SetPattern
.import _GraphicsString

; keyboard.s
.import _GetNextChar

; process.s
.import _Sleep
.import _UnfreezeProcess
.import _FreezeProcess
.import _UnblockProcess
.import _BlockProcess
.import _EnableProcess
.import _RestartProcess
.import _InitProcesses

; mouse.s
.import _ClearMouseMode
.import _MouseOff
.import _MouseUp
.import _StartMouseMode

; conio.s
.import _SmallPutChar
.import _i_PutString
.import _PutDecimal
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
.import _Ddec
.import _Dnegate
.import _Dabs
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

; ...
.import __IsMseInRegion
.import __CRC
.import __GetRandom
.import __DSdiv
.import __Ddiv
.import __DMult
.import __BMult
.import __BBMult
.import __MainLoop

.import _BitOtherClip
.import _BitmapClip
.import _ImprintRectangle
.import _BitmapUp
.import _TestPoint
.import _GetScanLine
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
.import _PromptOff
.import _PromptOn
.import _LoadCharSet
.import _GetCharWidth
.import _InitTextPrompt
.import _GetString
.import _UseSystemFont
.import _BldGDirEntry
.import _GetRealSize
.import _ColorRectangle
.import _ColorCard
.import _SetColorMode
.import _HideOnlyMouse
.import _AccessCache
.import _DoBOp
.import _VerifyBData
.import _SwapBData
.import _MoveBData
.import _SetMsePic
.import _TempHideMouse
.import _NormalizeX


.global InterruptMain
.global InitProcesses
.global RestartProcess
.global EnableProcess
.global BlockProcess
.global UnblockProcess
.global FreezeProcess
.global UnfreezeProcess
.global HorizontalLine
.global InvertLine
.global RecoverLine
.global VerticalLine
.global Rectangle
.global FrameRectangle
.global InvertRectangle
.global RecoverRectangle
.global DrawLine
.global DrawPoint
.global GraphicsString
.global SetPattern
.global GetScanLine
.global TestPoint
.global BitmapUp
.global PutChar
.global PutString
.global UseSystemFont
.global StartMouseMode
.global DoMenu
.global RecoverMenu
.global RecoverAllMenus
.global DoIcons
.global DShiftLeft
.global BBMult
.global BMult
.global DMult
.global Ddiv
.global DSdiv
.global Dabs
.global Dnegate
.global Ddec
.global ClearRam
.global FillRam
.global MoveData
.global InitRam
.global PutDecimal
.global GetRandom
.global MouseUp
.global MouseOff
.global DoPreviousMenu
.global ReDoMenu
.global GetSerialNumber
.global Sleep
.global ClearMouseMode
.global i_Rectangle
.global i_FrameRectangle
.global i_RecoverRectangle
.global i_GraphicsString
.global i_BitmapUp
.global i_PutString
.global GetRealSize
.global i_FillRam
.global i_MoveData
.global GetString
.global GotoFirstMenu
.global InitTextPrompt
.global MainLoop
.global DrawSprite
.global GetCharWidth
.global LoadCharSet
.global PosSprite
.global EnablSprite
.global DisablSprite
.global CallRoutine
.global CalcBlksFree
.global ChkDkGEOS
.global NewDisk
.global GetBlock
.global PutBlock
.global SetGEOSDisk
.global SaveFile
.global SetGDirEntry
.global BldGDirEntry
.global GetFreeDirBlk
.global WriteFile
.global BlkAlloc
.global ReadFile
.global SmallPutChar
.global FollowChain
.global GetFile
.global FindFile
.global CRC
.global LdFile
.global EnterTurbo
.global LdDeskAcc
.global ReadBlock
.global LdApplic
.global WriteBlock
.global VerWriteBlock
.global FreeFile
.global GetFHdrInfo
.global EnterDeskTop
.global StartAppl
.global ExitTurbo
.global PurgeTurbo
.global DeleteFile
.global FindFTypes
.global RstrAppl
.global ToBASIC
.global FastDelFile
.global GetDirHead
.global PutDirHead
.global NxtBlkAlloc
.global ImprintRectangle
.global i_ImprintRectangle
.global DoDlgBox
.global RenameFile
.global InitForIO
.global DoneWithIO
.global DShiftRight
.global CopyString
.global CopyFString
.global CmpString
.global CmpFString
.global FirstInit
.global OpenRecordFile
.global CloseRecordFile
.global NextRecord
.global PreviousRecord
.global PointRecord
.global DeleteRecord
.global InsertRecord
.global AppendRecord
.global ReadRecord
.global WriteRecord
.global SetNextFree
.global UpdateRecordFile
.global GetPtrCurDkNm
.global PromptOn
.global PromptOff
.global OpenDisk
.global DoInlineReturn
.global GetNextChar
.global BitmapClip
.global FindBAMBit
.global SetDevice
.global IsMseInRegion
.global ReadByte
.global FreeBlock
.global ChangeDiskDevice
.global RstrFrmDialogue
.global Panic
.global BitOtherClip
.global StashRAM
.global FetchRAM
.global SwapRAM
.global VerifyRAM
.global DoRAMOp
.global StashRAM
.global FetchRAM
.global SwapRAM
.global VerifyRAM
.global DoRAMOp

.ifdef bsw128
.global TempHideMouse
.global SetMsePic
.global SetNewMode
.global NormalizeX
.global MoveBData
.global SwapBData
.global VerifyBData
.global DoBOp
.global AccessCache
.global HideOnlyMouse
.global SetColorMode
.global ColorCard
.global ColorRectangle
.endif

.ifdef wheels
.global InitMachine
.global GEOSOptimize
.global DEFOptimize
.global DoOptimize
.global NFindFTypes
.global ReadXYPot
.global MainIRQ
.global ColorRectangle_W
.global i_ColorRectangle
.global SaveColor
.global RstrColor
.global ConvToCards
.endif

.segment "jumptab"

.assert * = $C100, error, "Jump table not at $C100"

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
UnblockProcess:
	jmp _UnblockProcess
FreezeProcess:
	jmp _FreezeProcess
UnfreezeProcess:
	jmp _UnfreezeProcess
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
	jmp __BBMult
BMult:
	jmp __BMult
DMult:
	jmp __DMult
Ddiv:
	jmp __Ddiv
DSdiv:
	jmp __DSdiv
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
	jmp __GetRandom
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
.ifdef bsw128
	jmp __MainLoop
.else
	jmp _MainLoop
.endif
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
	jmp __CRC
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
	jmp __IsMseInRegion
ReadByte:
	jmp _ReadByte
FreeBlock:
	jmp (_FreeBlock)
ChangeDiskDevice:
	jmp (_ChangeDiskDevice)
RstrFrmDialogue:
	jmp _RstrFrmDialogue
Panic:
.ifdef gateway
	jmp _EnterDeskTop
.else
	jmp _Panic
.endif
BitOtherClip:
	jmp _BitOtherClip
.ifdef REUPresent
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

.ifdef bsw128
TempHideMouse:
	jmp _TempHideMouse

SetMsePic:
	jmp _SetMsePic

SetNewMode:
.import _SetNewMode
	jmp _SetNewMode

NormalizeX:
	jmp _NormalizeX

MoveBData:
	jmp _MoveBData

SwapBData:
	jmp _SwapBData

VerifyBData:
	jmp _VerifyBData

DoBOp:
	jmp _DoBOp

AccessCache:
	jmp _AccessCache

HideOnlyMouse:
	jmp _HideOnlyMouse

SetColorMode:
	jmp _SetColorMode

ColorCard:
	jmp _ColorCard

ColorRectangle:
	jmp _ColorRectangle

.elseif .defined(wheels)

.macro UNIMPLEMENTED
	rts
	nop
	nop
.endmacro

; C128 syscalls
TempHideMouse:
	UNIMPLEMENTED
SetMsePic:
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
.global InitMachine, _i_ColorRectangle
.import _InitMachine, _GEOSOptimize, _DEFOptimize, _DoOptimize, _FindFTypes, _ReadXYPot, _IRQHandler, _ColorRectangle_W, _i_ColorRectangle, _SaveColor, _RstrColor, _ConvToCards
InitMachine: ; $C2FE
	jmp _InitMachine
GEOSOptimize: ; $C301
	jmp _GEOSOptimize
DEFOptimize: ; $C304
	jmp _DEFOptimize
DoOptimize: ; $C307
	jmp _DoOptimize
NFindFTypes: ; $C30A
	jmp _FindFTypes
ReadXYPot: ; $C30D
	jmp _ReadXYPot
MainIRQ: ; $C310
	jmp _IRQHandler
ColorRectangle_W: ; $C313
	jmp _ColorRectangle_W
i_ColorRectangle: ; $C316
	jmp _i_ColorRectangle
SaveColor: ; $C319
	jmp _SaveColor
RstrColor: ; $C31C
	jmp _RstrColor
ConvToCards: ; $C31F
	jmp _ConvToCards

	.byte 0, 0, 0 ; ???
.endif

.ifdef wheels_size
.global WheelsTemp
WheelsTemp: ; xxx
	.byte 0
.endif
