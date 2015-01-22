;GEOS Kernal
;reassembled by Maciej 'YTM/Alliance' Witkowiak
;this file:system core - all address-aligned data (for compatibility), core (EnterDeskTop) and init stuff

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "equ.inc"
.include "kernal.inc"
.import InitMsePic, ClrScr, _DoUpdateTime, _DoCheckDelays, _ExecuteProcesses, _DoCheckButtons, ResetMseRegion, ProcessCursor, _ProcessDelays, _ProcessTimers, ProcessMouse, _DoRAMOp, _VerifyRAM, _SwapRAM, _FetchRAM, _StashRAM
.import _BitOtherClip, _RstrFrmDialogue, _ChangeDiskDevice, _FreeBlock, _ReadByte, _IsMseInRegion, _SetDevice, _FindBAMBit, _BitmapClip, _GetNextChar, _OpenDisk, _PromptOff, _PromptOn, _GetPtrCurDkNm, _UpdateRecordFile, _SetNextFree
.import _WriteRecord, _ReadRecord, _AppendRecord, _InsertRecord, _DeleteRecord, _PointRecord, _PreviousRecord, _NextRecord, _CloseRecordFile, _OpenRecordFile, _CmpFString, _CmpString, _CopyFString, _CopyString, _DShiftRight, _DoneWithIO
.import _InitForIO, _RenameFile, _DoDlgBox, _i_ImprintRectangle, _ImprintRectangle, _NxtBlkAlloc, _PutDirHead, _GetDirHead, _FastDelFile, _RstrAppl, _FindFTypes, _DeleteFile, _PurgeTurbo, _ExitTurbo, _GetFHdrInfo, _FreeFile
.import _VerWriteBlock, _WriteBlock, _LdApplic, _ReadBlock, _LdDeskAcc, _EnterTurbo, _LdFile, _CRC, _FindFile, _GetFile, _FollowChain, _SmallPutChar, _ReadFile, _BlkAlloc, _WriteFile
.import _GetFreeDirBlk, _BldGDirEntry, _SetGDirEntry, _SaveFile, _SetGEOSDisk, _PutBlock, _GetBlock, _NewDisk, _ChkDkGEOS, _CalcBlksFree, _DisablSprite, _EnablSprite, _PosSprite, _LoadCharSet, _GetCharWidth, _DrawSprite
.import _InitTextPrompt, _GotoFirstMenu, _GetString, _i_MoveData, _i_FillRam, _GetRealSize, _i_PutString, _i_BitmapUp, _i_GraphicsString, _i_RecoverRectangle, _i_FrameRectangle, _i_Rectangle, _ClearMouseMode, _Sleep, _ReDoMenu, _DoPreviousMenu
.import _MouseOff, _MouseUp, _GetRandom, _PutDecimal, _MoveData, _FillRam, _ClearRam, _Ddec, _Dnegate, _Dabs, _DSDiv, _Ddiv, _DMult, _BMult, _BBMult, _DShiftLeft
.import _DoIcons, _RecoverAllMenus, _RecoverMenu, _DoMenu, _StartMouseMode, _UseSystemFont, _PutString, _PutChar, _BitmapUp, _TestPoint, _GetScanLine, _SetPattern, _GraphicsString, _DrawPoint, _DrawLine, _RecoverRectangle
.import _InvertRectangle, _FrameRectangle, _Rectangle, _VerticalLine, _RecoverLine, _InvertLine, _HorizontalLine, _UnFreezeProcess, _FreezeProcess, _UnBlockProcess, _BlockProcess, _EnableProcess, _RestartProcess, _InitProcesses, DoPLAINTEXT, DoOUTLINEON
.import DoITALICON, DoBOLDON, DoNEWCARDSET, DoGOTOXY, DoGOTOY, DoGOTOX, DoREV_OFF, DoREV_ON, DoESC_RULER, DoESC_GRAPHICS, DoULINEOFF, DoULINEON, DoCR, DoUPLINE, DoHOME, DoLF
.import DoTAB, DoBACKSPACE
.global BBMult, BitMask1, BitMask2, BitMask3, BitMask4, BldGDirEntry, BlkAlloc, CalcBlksFree, CallRoutine, ChkDkGEOS, ClearRam, CopyFString, CopyString, DBIcPicDISK, DBIcPicNO, DBIcPicOPEN, DBIcPicYES
.global DShiftLeft, Dabs, DecTabH, DecTabL, DkNmTab, DoInlineReturn, DoneWithIO, DrawSprite, EnablSprite, EnterTurbo, ExitTurbo, FastDelFile, FindBAMBit, FindFTypes, FindFile, FontTVar1
.global FontTVar2, FrameRectangle, GetBlock, GetDirHead, GetFHdrInfo, GetFile, GetFreeDirBlk, GetPtrCurDkNm, GetRealSize, GetScanLine, GetString, GraphicsString, HorizontalLine, InitForIO, InitGEOEnv, InvertRectangle
.global IsMseInRegion, LdApplic, LdDeskAcc, LdFile, LineTabH, LineTabL, MainLoop, MouseUp, NewDisk, PosSprite, PutBlock, PutCharTabH, PutCharTabL, PutDirHead, PutString, ReadBlock
.global ReadFile, Rectangle, RstrFrmDialogue, SetDevice, SetGDirEntry, SetNextFree, SetPattern, SprTabH, SprTabL, StartAppl, UNK_4, UNK_5, UseSystemFont, VerWriteBlock, WriteBlock, WriteFile, _MNLP, dateCopy, daysTab
.global i_FillRam, EnterDeskTop, _DoFirstInitIO, _FirstInit, FirstInit, OpenDisk, _DoFirstInitIO, _FirstInit, Ddec, Ddiv, DoIcons, FreeBlock, PutChar, _EnterDeskTop, StashRAM, DoRAMOp, FetchRAM, Dnegate, PurgeTurbo, SaveFile, DoDlgBox

.segment "main"

;--------------------------------------------
;IMPORTANT! DO NOT CHANGE ANYTHING BELOW, UP TO 'DESK TOP' STRING.
;DOING SO WILL CREATE FATAL INCOMPATIBILITES!
;--------------------------------------------

	jmp BootKernal ;C01B
	jmp InitKernal ;5000

bootName:
	.byte "GEOS BOOT" ;c006
version:
	.byte $20 ;c00f
nationality:
	.byte $00,$00
sysFlgCopy:
	.byte $00 ;c012
c128Flag:
	.byte $00
	.byte $05,$00,$00,$00
dateCopy:
	.byte 88,4,20 ;c018


;--------------------------------------------

BitMask1:
	.byte $80, $40, $20, $10, $08, $04, $02
BitMask2:
	.byte $01, $02, $04, $08, $10, $20, $40, $80
BitMask3:
	.byte $00, $80, $c0, $e0, $f0, $f8, $fc, $fe
BitMask4:
	.byte $7f, $3f, $1f, $0f, $07, $03, $01, $00

	;c418
VIC_IniTbl:
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00, $00, $00, $00
	.byte $f8, $3b, $fb, $aa, $aa, $01, $08, $00
	.byte $38, $0f, $01, $00, $00, $00

	;caeb
LineTabL:
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00, $40, $80, $c0, $00, $40, $80, $c0
	.byte $00
	;cb04
LineTabH:
	.byte $a0, $a1, $a2, $a3, $a5, $a6, $a7, $a8
	.byte $aa, $ab, $ac, $ad, $af, $b0, $b1, $b2
	.byte $b4, $b5, $b6, $b7, $b9, $ba, $bb, $bc
	.byte $be

_PanicDB_DT:
	;cfd3
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y
	.word _PanicDB_Str
	.byte NULL

_PanicDB_Str:
	;cfda
	.byte BOLDON
	.byte "System error near $"
_PanicAddy:
	.byte "xxxx" ;cfee
	.byte NULL

FontTVar1:
	.byte 0 ;e391
FontTVar2:
	.word 0 ;e392
	;ccb0
SprTabL:
	.byte <spr0pic, <spr1pic, <spr2pic, <spr3pic
	.byte <spr4pic, <spr5pic, <spr6pic, <spr7pic
	;ccb8
SprTabH:
	.byte >spr0pic, >spr1pic, >spr2pic, >spr3pic
	.byte >spr4pic, >spr5pic, >spr6pic, >spr7pic

PutCharTabL:
	.byte <DoBACKSPACE, <DoTAB ;e54b
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
	.byte >DoBACKSPACE, >DoTAB ;e55f
	.byte >DoLF, >DoHOME
	.byte >DoUPLINE, >DoCR
	.byte >DoULINEON, >DoULINEOFF
	.byte >DoESC_GRAPHICS, >DoESC_RULER
	.byte >DoREV_ON, >DoREV_OFF
	.byte >DoGOTOX, >DoGOTOY
	.byte >DoGOTOXY, >DoNEWCARDSET
	.byte >DoBOLDON, >DoITALICON
	.byte >DoOUTLINEON, >DoPLAINTEXT

DecTabL:
	.byte <1, <10, <100, <1000, <10000 ;e941
DecTabH:
	.byte >1, >10, >100, >1000, >10000 ;e946

daysTab:
	;fe17
	.byte 31, 28, 31, 30, 31, 30
	.byte 31, 31, 30, 31, 30, 31

DeskTopOpen:
	.byte 0 ;these two bytes are here just
DeskTopRecord:
	.byte 0 ;to keep OS_JUMPTAB at $c100
	.byte 0,0,0 ;three really unused
;--------------------------------------------
;here the JumpTable begins, DO NOT CHANGE!!!
;		*= OS_JUMPTAB

InterruptMain:
	jmp _InterruptMain ;c100
InitProcesses:
	jmp _InitProcesses ;c103
RestartProcess:
	jmp _RestartProcess ;c106
EnableProcess:
	jmp _EnableProcess ;c109
BlockProcess:
	jmp _BlockProcess ;c10c
UnBlockProcess:
	jmp _UnBlockProcess ;c10f
FreezeProcess:
	jmp _FreezeProcess ;c112
UnFreezeProcess:
	jmp _UnFreezeProcess ;c115
HorizontalLine:
	jmp _HorizontalLine ;c118
InvertLine:
	jmp _InvertLine ;c11d
RecoverLine:
	jmp _RecoverLine ;c11e
VerticalLine:
	jmp _VerticalLine ;c121
Rectangle:
	jmp _Rectangle ;c124
FrameRectangle:
	jmp _FrameRectangle ;c127
InvertRectangle:
	jmp _InvertRectangle ;c12a
RecoverRectangle:
	jmp _RecoverRectangle ;c12d
DrawLine:
	jmp _DrawLine ;c130
DrawPoint:
	jmp _DrawPoint ;c133
GraphicsString:
	jmp _GraphicsString ;c136
SetPattern:
	jmp _SetPattern ;c139
GetScanLine:
	jmp _GetScanLine ;c13c
TestPoint:
	jmp _TestPoint ;c13f
BitmapUp:
	jmp _BitmapUp ;c142
PutChar:
	jmp _PutChar ;c145
PutString:
	jmp _PutString ;c148
UseSystemFont:
	jmp _UseSystemFont ;c14b
StartMouseMode:
	jmp _StartMouseMode ;c14e
DoMenu:
	jmp _DoMenu ;c151
RecoverMenu:
	jmp _RecoverMenu ;c154
RecoverAllMenus:
	jmp _RecoverAllMenus ;c157
DoIcons:
	jmp _DoIcons ;c15a
DShiftLeft:
	jmp _DShiftLeft ;c15d
BBMult:
	jmp _BBMult ;c160
BMult:
	jmp _BMult ;c163
DMult:
	jmp _DMult ;c166
Ddiv:
	jmp _Ddiv ;c169
DSDiv:
	jmp _DSDiv ;c16c
Dabs:
	jmp _Dabs ;c16f
Dnegate:
	jmp _Dnegate ;c172
Ddec:
	jmp _Ddec ;c175
ClearRam:
	jmp _ClearRam ;c178
FillRam:
	jmp _FillRam ;c17b
MoveData:
	jmp _MoveData ;c17e
InitRam:
	jmp _InitRam ;c181
PutDecimal:
	jmp _PutDecimal ;c184
GetRandom:
	jmp _GetRandom ;c187
MouseUp:
	jmp _MouseUp ;c18a
MouseOff:
	jmp _MouseOff ;c18d
DoPreviousMenu:
	jmp _DoPreviousMenu ;c190
ReDoMenu:
	jmp _ReDoMenu ;c193
GetSerialNumber:
	jmp _GetSerialNumber ;c196
Sleep:
	jmp _Sleep ;c199
ClearMouseMode:
	jmp _ClearMouseMode ;c19c
i_Rectangle:
	jmp _i_Rectangle ;c19f
i_FrameRectangle:
	jmp _i_FrameRectangle ;c1a2
i_RecoverRectangle:
	jmp _i_RecoverRectangle ;c1a5
i_GraphicsString:
	jmp _i_GraphicsString ;c1a8
i_BitmapUp:
	jmp _i_BitmapUp ;c1ab
i_PutString:
	jmp _i_PutString ;c1ae
GetRealSize:
	jmp _GetRealSize ;c1b1
i_FillRam:
	jmp _i_FillRam ;c1b4
i_MoveData:
	jmp _i_MoveData ;c1b7
GetString:
	jmp _GetString ;c1ba
GotoFirstMenu:
	jmp _GotoFirstMenu ;c1bd
InitTextPrompt:
	jmp _InitTextPrompt ;c1c0
MainLoop:
	jmp _MainLoop ;c1c3
DrawSprite:
	jmp _DrawSprite ;c1c6
GetCharWidth:
	jmp _GetCharWidth ;c1c9
LoadCharSet:
	jmp _LoadCharSet ;c1cc
PosSprite:
	jmp _PosSprite ;c1cf
EnablSprite:
	jmp _EnablSprite ;c1d2
DisablSprite:
	jmp _DisablSprite ;c1d5
CallRoutine:
	jmp _CallRoutine ;c1d8
CalcBlksFree:
	jmp (_CalcBlksFree) ;c1db
ChkDkGEOS:
	jmp (_ChkDkGEOS) ;c1de
NewDisk:
	jmp (_NewDisk) ;c1e1
GetBlock:
	jmp (_GetBlock) ;c1e4
PutBlock:
	jmp (_PutBlock) ;c1e7
SetGEOSDisk:
	jmp (_SetGEOSDisk) ;c1ea
SaveFile:
	jmp _SaveFile ;c1ed
SetGDirEntry:
	jmp _SetGDirEntry ;c1f0
BldGDirEntry:
	jmp _BldGDirEntry ;c1f3
GetFreeDirBlk:
	jmp (_GetFreeDirBlk) ;c1f6
WriteFile:
	jmp _WriteFile ;c1f9
BlkAlloc:
	jmp (_BlkAlloc) ;c1fc
ReadFile:
	jmp _ReadFile ;c1ff
SmallPutChar:
	jmp _SmallPutChar ;c202
FollowChain:
	jmp _FollowChain ;c205
GetFile:
	jmp _GetFile ;c208
FindFile:
	jmp _FindFile ;c20b
CRC:
	jmp _CRC ;c20e
LdFile:
	jmp _LdFile ;c211
EnterTurbo:
	jmp (_EnterTurbo) ;c214
LdDeskAcc:
	jmp _LdDeskAcc ;c217
ReadBlock:
	jmp (_ReadBlock) ;c21a
LdApplic:
	jmp _LdApplic ;c21d
WriteBlock:
	jmp (_WriteBlock) ;c220
VerWriteBlock:
	jmp (_VerWriteBlock) ;c223
FreeFile:
	jmp _FreeFile ;c226
GetFHdrInfo:
	jmp _GetFHdrInfo ;c229
EnterDeskTop:
	jmp _EnterDeskTop ;c22c
StartAppl:
	jmp _StartAppl ;c22f
ExitTurbo:
	jmp (_ExitTurbo) ;c232
PurgeTurbo:
	jmp (_PurgeTurbo) ;c235
DeleteFile:
	jmp _DeleteFile ;c238
FindFTypes:
	jmp _FindFTypes ;c23b
RstrAppl:
	jmp _RstrAppl ;c23e
ToBASIC:
	jmp _ToBASIC ;c241
FastDelFile:
	jmp _FastDelFile ;c244
GetDirHead:
	jmp (_GetDirHead) ;c247
PutDirHead:
	jmp (_PutDirHead) ;c24a
NxtBlkAlloc:
	jmp (_NxtBlkAlloc) ;c24d
ImprintRectangle:
	jmp _ImprintRectangle ;c250
i_ImprintRectangle:
	jmp _i_ImprintRectangle ;c253
DoDlgBox:
	jmp _DoDlgBox ;c256
RenameFile:
	jmp _RenameFile ;c259
InitForIO:
	jmp (_InitForIO) ;c25c
DoneWithIO:
	jmp (_DoneWithIO) ;c25f
DShiftRight:
	jmp _DShiftRight ;c262
CopyString:
	jmp _CopyString ;c265
CopyFString:
	jmp _CopyFString ;c268
CmpString:
	jmp _CmpString ;c26b
CmpFString:
	jmp _CmpFString ;c26e
FirstInit:
	jmp _FirstInit ;c271
OpenRecordFile:
	jmp _OpenRecordFile ;c274
CloseRecordFile:
	jmp _CloseRecordFile ;c277
NextRecord:
	jmp _NextRecord ;c27a
PreviousRecord:
	jmp _PreviousRecord ;c27d
PointRecord:
	jmp _PointRecord ;c280
DeleteRecord:
	jmp _DeleteRecord ;c283
InsertRecord:
	jmp _InsertRecord ;c286
AppendRecord:
	jmp _AppendRecord ;c289
ReadRecord:
	jmp _ReadRecord ;c28c
WriteRecord:
	jmp _WriteRecord ;c28f
SetNextFree:
	jmp (_SetNextFree) ;c292
UpdateRecordFile:
	jmp _UpdateRecordFile ;c295
GetPtrCurDkNm:
	jmp _GetPtrCurDkNm ;c298
PromptOn:
	jmp _PromptOn ;c29b
PromptOff:
	jmp _PromptOff ;c29e
OpenDisk:
	jmp (_OpenDisk) ;c2a1
DoInlineReturn:
	jmp _DoInlineReturn ;c2a4
GetNextChar:
	jmp _GetNextChar ;c2a7
BitmapClip:
	jmp _BitmapClip ;c2aa
FindBAMBit:
	jmp (_FindBAMBit) ;c2ad
SetDevice:
	jmp _SetDevice ;c2b0
IsMseInRegion:
	jmp _IsMseInRegion ;c2b3
ReadByte:
	jmp _ReadByte ;c2b6
FreeBlock:
	jmp (_FreeBlock) ;c2b9
ChangeDiskDevice:
	jmp (_ChangeDiskDevice) ;c2bc
RstrFrmDialogue:
	jmp _RstrFrmDialogue ;c2bf
Panic:
	jmp _Panic ;c2c2
BitOtherClip:
	jmp _BitOtherClip ;c2c5
.if (REUPresent)
StashRAM:
	jmp _StashRAM ;c2c8
FetchRAM:
	jmp _FetchRAM ;c2cb
SwapRAM:
	jmp _SwapRAM ;c2ce
VerifyRAM:
	jmp _VerifyRAM ;c2d1
DoRAMOp:
	jmp _DoRAMOp ;c2d4
.else
StashRAM:
	ldx #DEV_NOT_FOUND ;c2c8
	rts
FetchRAM:
	ldx #DEV_NOT_FOUND ;c2cb
	rts
SwapRAM:
	ldx #DEV_NOT_FOUND ;c2ce
	rts
VerifyRAM:
	ldx #DEV_NOT_FOUND ;c2d1
	rts
DoRAMOp:
	ldx #DEV_NOT_FOUND ;c2d4
	rts
.endif
;here the JumpTable ends
;--------------------------------------------

DkNmTab:
	.byte <DrACurDkNm, <DrBCurDkNm
	.byte <DrCCurDkNm, <DrDCurDkNm
	.byte >DrACurDkNm, >DrBCurDkNm
	.byte >DrCCurDkNm, >DrDCurDkNm

_InterruptMain:
	jsr ProcessMouse ;c2d7
	jsr _ProcessTimers
	jsr _ProcessDelays
	jsr ProcessCursor
	jmp _GetRandom

_CallRoutine:
	;c59f
	cmp #0
	bne CRou1
	cpx #0
	beq CRou2
CRou1:
	sta CallRLo ;c5a7
	stx CallRHi
	jmp (CallRLo)
CRou2:
	rts ;c5ae

_DoInlineReturn:
	;c5af
	add returnAddress
	sta returnAddress
	bcc DILR1
	inc returnAddress+1
DILR1:
	plp ;c5b8
	jmp (returnAddress)

SetVICRegs:
	sty r1L ;c5bc
	ldy #0
SVR0:
	lda (r0),Y ;c5c0
	cmp #$AA
	beq SVR1
	sta vicbase,Y
SVR1:
	iny ;c5c9
	cpy r1L
	bne SVR0
	rts

_InitRam:
	ldy #0 ;c567
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
	tya ;c57c
	tax
	lda (r0),Y
	ldy #0
	sta (r1),Y
	inc r1L
	bne IRam1
	inc r1H
IRam1:
	txa ;c58a
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
	bra _InitRam ;c59b
IRam3:
	rts ;c59e

InitGEOS:
	jsr _DoFirstInitIO ;c40a ;UNK_1
InitGEOEnv:
	lda #>InitRamTab ;c40d ;UNK_1_1
	sta r0H
	lda #<InitRamTab
	sta r0L
	jmp _InitRam

_DoFirstInitIO:
	LoadB CPU_DDR, $2f ;c436
	LoadB CPU_DATA, KRNL_IO_IN
	ldx #7
	lda #true
DFIIO0:
	sta KbdDMltTab,X ;c442
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
	stx cia1base+14 ;c468
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

DeskTopStart:
	.word 0 ;these are for ensuring compatibility with
DeskTopExec:
	.word 0 ;DeskTop replacements - filename of desktop
DeskTopLgh:
	.byte 0 ;have to be at $c3cf .IDLE

DeskTopName:
	.byte "DESK TOP", NULL ;c3cf

;--------------------------------------------
;IMPORTANT! FROM NOW ON YOU CAN CHANGE THE CODE UNTIL FURTHER NOTICES.
;--------------------------------------------
_MainLoop:
	jsr _DoCheckButtons ;c0df
	jsr _ExecuteProcesses
	jsr _DoCheckDelays
	jsr _DoUpdateTime
	lda appMain+0
	ldx appMain+1
_MNLP:
	jsr CallRoutine ;c0f1
	cli

_MainLoop2:
	ldx CPU_DATA ;c313
	LoadB CPU_DATA, IO_IN
	lda grcntrl1
	and #%01111111
	sta grcntrl1
	stx CPU_DATA
	jmp _MainLoop

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
	ldy #8 ;c041
BootREU1:
	lda BootREUTab,Y ;c043
	sta EXP_BASE+1,Y
	dey
	bpl BootREU1
BootREU2:
	dey ;c04c
	bne BootREU2
_RunREU:
	jmp RunREU ;c04f
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
	ldy #39 ;c05c
TB1:
	lda (r0),Y ;c05e
	cmp #"A"
	bcc TB2
	cmp #"Z"+1
	bcs TB2
	sbc #$3F
TB2:
	sta LoKernalBuf,Y ;c06a
	dey
	bpl TB1
	lda r5H
	beq TB4
	iny
	tya
TB3:
	sta BASICspace,Y ;c076
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
	LoadW r2, $ffff
	jsr _ReadFile
	PopW r0
	ldy #1
	pla
	sta (r0),Y
	dey
	pla
	sta (r0),Y
TB4:
	jsr GetDirHead ;c0b7
	jsr PurgeTurbo
	lda sysRAMFlg
	sta sysFlgCopy
	and #%00100000
	beq TB6
	ldy #6
TB5:
	lda ToBASICTab,Y ;c0c9
	sta r0,Y
	dey
	bpl TB5
	jsr StashRAM
TB6:
	jmp LoKernal1 ;c0d5
ToBASICTab:
	.word dirEntryBuf
	.word REUOsVarBackup
	.word OS_VARS_LGH
	.byte $00
.endif

.if (useRamExp)
_EnterDeskTop:
	;c326
	sei
	cld
	ldx #TRUE
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
	;c3c0
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word _EnterDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word _EnterDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL

_EnterDT_Str0:
	;c3d8
	.byte BOLDON, "Please insert a disk", NULL
_EnterDT_Str1:
	;c3ee
	.byte "with deskTop V1.5 or higher", NULL

_EnterDeskTop:
	;c326
	sei
	cld
	ldx #TRUE
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
	jsr EDT3 ;c348
	ldy NUMDRV
	cpy #2
	bcc EDT2
	lda curDrive
	eor #1
	jsr EDT3
EDT2:
	LoadW r0, _EnterDT_DB ;c35a
	jsr DoDlgBox
	lda TempCurDrive
	bne EDT1
EDT3:
	jsr SetDevice ;c36a
	jsr OpenDisk
	beqx EDT5
EDT4:
	rts ;c373
EDT5:
	sta r0L ;c374
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
	lda TempCurDrive ;c394
	jsr SetDevice
	LoadB r0L, NULL
	MoveW fileHeader+O_GHST_VEC, r7
.endif
_StartAppl:
	sei ;c3a8
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

UNK_4:
	MoveB A885D, r10L ;c5cf
	MoveB A885E, r0L
	and #1
	beq U_40
	MoveW A885F, r7
U_40:
	LoadW r2, dataDiskName ;c5e7
	LoadW r3, dataFileName
U_41:
	rts


UNK_5:
	MoveW r7, A885F
	MoveB r10L, A885D
	MoveB r0L, A885E
	and #%11000000
	beq U_41
	ldy #>dataDiskName
	lda #<dataDiskName
	ldx #r2
	jsr U_50
	ldy #>dataFileName
	lda #<dataFileName
	ldx #r3
U_50:
	sty r4H ;c61f
	sta r4L
	ldy #r4
	lda #16
	jmp CopyFString

Init_KRNLVec:
	ldx #32 ;c4da
IKV1:
	lda KERNALVecTab-1,X ;c4dc
	sta irqvec-1,X
	dex
	bne IKV1
	rts

_FirstInit:
	;c4e6
	sei
	cld
	jsr InitGEOS
	LoadW EnterDeskTop+1, _EnterDeskTop
	LoadB maxMouseSpeed, iniMaxMouseSpeed
.if (iniMaxMouseSpeed=iniMouseAccel)
	sta mouseAccel
.else
	LoadB mouseAccel, iniMouseAccel
.endif
	LoadB minMouseSpeed, iniMinMouseSpeed
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
	lda #0 ;c52b
	sta mousePicData,Y
	dey
	bpl FI1
	ldx #24
FI2:
	lda InitMsePic-1,X ;c535
	sta mousePicData-1,X
	dex
	bne FI2
	jmp UNK_6


_GetSerialNumber:
	LoadW r0, SerialNumber
	rts
;d000

_Panic:
	;cf88
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
	pha ;cfb2
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
	cmp #10 ;cfc3
	bcs Panil2
	addv ('0')
	bne Panil3
Panil2:
	addv ('0'+7) ;cfcc
Panil3:
	sta _PanicAddy,X ;cfcf
	rts


InitRamTab:
	;ddfa
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


UNK_6:
	lda #$bf ;e393
	sta A8FF0
	ldx #7
	lda #$bb
UNK_61:
	sta A8FE8,x ;e39d
	dex
	bpl UNK_61
	rts

DBIcPicNO:
	;f914
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
	;f95f
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
	;f9b0
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
	;fa03
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

;fa56
