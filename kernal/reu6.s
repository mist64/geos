; da65 V2.15
; Created:    2016-09-01 21:51:58
; Input file: reu6.bin
; Page:       1


        .setcpu "6502"

CPU_DDR         := $0000
CPU_DATA        := $0001
r0L             := $0002
r0H             := $0003
r1L             := $0004
r1H             := $0005
r2L             := $0006
r2H             := $0007
r3L             := $0008
r3H             := $0009
r4L             := $000A
r4H             := $000B
r5L             := $000C
r5H             := $000D
r6L             := $000E
r6H             := $000F
r7L             := $0010
r7H             := $0011
r8L             := $0012
r8H             := $0013
r9L             := $0014
r9H             := $0015
r10L            := $0016
r10H            := $0017
r11L            := $0018
r11H            := $0019
r12L            := $001A
r12H            := $001B
r13L            := $001C
r13H            := $001D
r14L            := $001E
r14H            := $001F
r15L            := $0020
r15H            := $0021
curPattern      := $0022
string          := $0024
baselineOffset  := $0026
curSetWidth     := $0027
curHeight       := $0029
curIndexTable   := $002A
cardDataPntr    := $002C
currentMode     := $002E
dispBufferOn    := $002F
mouseOn         := $0030
msePicPtr       := $0031
windowTop       := $0033
windowBottom    := $0034
leftMargin      := $0035
rightMargin     := $0037
pressFlag       := $0039
mouseXPos       := $003A
mouseYPos       := $003C
returnAddress   := $003D
graphMode       := $003F
CallRLo         := $0041
CallRHi         := $0042
DBoxDescL       := $0043
DBoxDescH       := $0044
Z45             := $0045
Z46             := $0046
Z47             := $0047
a2L             := $0070
a2H             := $0071
a3L             := $0072
a3H             := $0073
a4L             := $0074
a4H             := $0075
a5L             := $0076
a5H             := $0077
a6L             := $0078
a6H             := $0079
a7L             := $007A
a7H             := $007B
a8L             := $007C
a8H             := $007D
a9L             := $007E
a9H             := $007F
DACC_ST_ADDR    := $0080
DACC_LGH        := $0082
DTOP_CHNUM      := $0083
DTOP_CHAIN      := $0085
z8b             := $008B
z8c             := $008C
z8d             := $008D
z8e             := $008E
z8f             := $008F
STATUS          := $0090
tapeBuffVec     := $00B2
curDevice       := $00BA
kbdQuePos       := $00C6
curScrLine      := $00D1
curPos          := $00D3
a0L             := $00FB
a0H             := $00FC
a1L             := $00FD
a1H             := $00FE
kbdQue          := $0277
BASICMemBot     := $0282
BASICMemTop     := $0284
scrAddyHi       := $0288
PALNTSCFLAG     := $02A6
irqvec          := $0314
bkvec           := $0316
nmivec          := $0318
APP_RAM         := $0400
BASICspace      := $0800
BACK_SCR_BASE   := $6000
PRINTBASE       := $7900
diskBlkBuf      := $8000
fileHeader      := $8100
curDirHead      := $8200
fileTrScTab     := $8300
dirEntryBuf     := $8400
DrACurDkNm      := $841E
DrBCurDkNm      := $8430
dataFileName    := $8442
dataDiskName    := $8453
PrntFilename    := $8465
PrntDiskName    := $8476
curDrive        := $8489
diskOpenFlg     := $848A
isGEOS          := $848B
interleave      := $848C
NUMDRV          := $848D
driveType       := $848E
turboFlags      := $8492
curRecord       := $8496
usedRecords     := $8497
fileWritten     := $8498
fileSize        := $8499
appMain         := $849B
intTopVector    := $849D
intBotVector    := $849F
mouseVector     := $84A1
keyVector       := $84A3
inputVector     := $84A5
mouseFaultVec   := $84A7
otherPressVec   := $84A9
StringFaultVec  := $84AB
alarmTmtVector  := $84AD
BRKVector       := $84AF
RecoverVector   := $84B1
selectionFlash  := $84B3
alphaFlag       := $84B4
iconSelFlg      := $84B5
faultData       := $84B6
menuNumber      := $84B7
mouseTop        := $84B8
mouseBottom     := $84B9
mouseLeft       := $84BA
mouseRight      := $84BC
stringX         := $84BE
stringY         := $84C0
mousePicData    := $84C1
maxMouseSpeed   := $8501
minMouseSpeed   := $8502
mouseAccel      := $8503
keyData         := $8504
mouseData       := $8505
inputData       := $8506
mouseSpeed      := $8507
random          := $850A
saveFontTab     := $850C
dblClickCount   := $8515
year            := $8516
month           := $8517
day             := $8518
hour            := $8519
minutes         := $851A
seconds         := $851B
alarmSetFlag    := $851C
sysDBData       := $851D
screencolors    := $851E
dlgBoxRamBuf    := $851F
menuOptNumber   := $86C0
menuTop         := $86C1
menuBottom      := $86C2
menuLeft        := $86C3
menuRight       := $86C5
menuStackL      := $86C7
menuStackH      := $86CB
menuOptionTab   := $86CF
menuLimitTabL   := $86D3
menuLimitTabH   := $86E2
TimersTab       := $86F1
TimersCMDs      := $8719
TimersRtns      := $872D
TimersVals      := $8755
NumTimers       := $877D
DelaySP         := $877E
DelayValL       := $877F
DelayValH       := $8793
DelayRtnsL      := $87A7
DelayRtnsH      := $87BB
stringLen       := $87CF
stringMaxLen    := $87D0
tmpKeyVector    := $87D1
stringMargCtrl  := $87D3
GraphPenXL      := $87D4
GraphPenXH      := $87D5
KbdQueHead      := $87D7
KbdQueTail      := $87D8
KbdQueFlag      := $87D9
KbdQueue        := $87DA
KbdNextKey      := $87EA
KbdDBncTab      := $87EB
KbdDMltTab      := $87F3
E87FC           := $87FC
E87FD           := $87FD
E87FE           := $87FE
E87FF           := $87FF
E8800           := $8800
PrvCharWidth    := $8807
clkBoxTemp      := $8808
clkBoxTemp2     := $8809
alarmWarnFlag   := $880A
tempIRQAcc      := $880B
defIconTab      := $880C
DeskAccPC       := $8850
DeskAccSP       := $8852
dlgBoxCallerPC  := $8853
dlgBoxCallerSP  := $8855
DBGFilesFound   := $8856
DBGFOffsLeft    := $8857
DBGFOffsTop     := $8858
DBGFNameTable   := $8859
DBGFTableIndex  := $885B
DBGFileSelected := $885C
A885D           := $885D
A885E           := $885E
A885F           := $885F
A8860           := $8860
RecordDirTS     := $8861
RecordDirOffs   := $8863
RecordTableTS   := $8865
verifyFlag      := $8867
TempCurDrive    := $8868
e88b7           := $88B7
SPRITE_PICS     := $8A00
COLOR_MATRIX    := $8C00
A8FE8           := $8FE8
A8FF0           := $8FF0
DISK_BASE       := $9000
L9036           := $9036
L903C           := $903C
L903F           := $903F
L9048           := $9048
SCREEN_BASE     := $A000
OS_ROM          := $C000
InterruptMain   := $C100
InitProcesses   := $C103
RestartProcess  := $C106
EnableProcess   := $C109
BlockProcess    := $C10C
UnblockProcess  := $C10F
FreezeProcess   := $C112
UnfreezeProcess := $C115
HorizontalLine  := $C118
InvertLine      := $C11B
RecoverLine     := $C11E
VerticalLine    := $C121
Rectangle       := $C124
FrameRectangle  := $C127
InvertRectangle := $C12A
RecoverRectangle:= $C12D
DrawLine        := $C130
DrawPoint       := $C133
GraphicsString  := $C136
SetPattern      := $C139
GetScanLine     := $C13C
TestPoint       := $C13F
BitmapUp        := $C142
PutChar         := $C145
PutString       := $C148
UseSystemFont   := $C14B
StartMouseMode  := $C14E
DoMenu          := $C151
RecoverMenu     := $C154
RecoverAllMenus := $C157
DoIcons         := $C15A
DShiftLeft      := $C15D
BBMult          := $C160
BMult           := $C163
DMult           := $C166
Ddiv            := $C169
DSdiv           := $C16C
Dabs            := $C16F
Dnegate         := $C172
Ddec            := $C175
ClearRam        := $C178
FillRam         := $C17B
MoveData        := $C17E
InitRam         := $C181
PutDecimal      := $C184
GetRandom       := $C187
MouseUp         := $C18A
MouseOff        := $C18D
DoPreviousMenu  := $C190
ReDoMenu        := $C193
GetSerialNumber := $C196
Sleep           := $C199
ClearMouseMode  := $C19C
i_Rectangle     := $C19F
i_FrameRectangle:= $C1A2
i_RecoverRectangle:= $C1A5
i_GraphicsString:= $C1A8
i_BitmapUp      := $C1AB
i_PutString     := $C1AE
GetRealSize     := $C1B1
i_FillRam       := $C1B4
i_MoveData      := $C1B7
GetString       := $C1BA
GotoFirstMenu   := $C1BD
InitTextPrompt  := $C1C0
MainLoop        := $C1C3
DrawSprite      := $C1C6
GetCharWidth    := $C1C9
LoadCharSet     := $C1CC
PosSprite       := $C1CF
EnablSprite     := $C1D2
DisablSprite    := $C1D5
CallRoutine     := $C1D8
CalcBlksFree    := $C1DB
ChkDkGEOS       := $C1DE
NewDisk         := $C1E1
GetBlock        := $C1E4
PutBlock        := $C1E7
SetGEOSDisk     := $C1EA
SaveFile        := $C1ED
SetGDirEntry    := $C1F0
BldGDirEntry    := $C1F3
GetFreeDirBlk   := $C1F6
WriteFile       := $C1F9
BlkAlloc        := $C1FC
ReadFile        := $C1FF
SmallPutChar    := $C202
FollowChain     := $C205
GetFile         := $C208
FindFile        := $C20B
CRC             := $C20E
LdFile          := $C211
EnterTurbo      := $C214
LdDeskAcc       := $C217
ReadBlock       := $C21A
LdApplic        := $C21D
WriteBlock      := $C220
VerWriteBlock   := $C223
FreeFile        := $C226
GetFHdrInfo     := $C229
EnterDeskTop    := $C22C
StartAppl       := $C22F
ExitTurbo       := $C232
PurgeTurbo      := $C235
DeleteFile      := $C238
FindFTypes      := $C23B
RstrAppl        := $C23E
ToBASIC         := $C241
FastDelFile     := $C244
GetDirHead      := $C247
PutDirHead      := $C24A
NxtBlkAlloc     := $C24D
ImprintRectangle:= $C250
i_ImprintRectangle:= $C253
DoDlgBox        := $C256
RenameFile      := $C259
InitForIO       := $C25C
DoneWithIO      := $C25F
DShiftRight     := $C262
CopyString      := $C265
CopyFString     := $C268
CmpString       := $C26B
CmpFString      := $C26E
FirstInit       := $C271
OpenRecordFile  := $C274
CloseRecordFile := $C277
NextRecord      := $C27A
PreviousRecord  := $C27D
PointRecord     := $C280
DeleteRecord    := $C283
InsertRecord    := $C286
AppendRecord    := $C289
ReadRecord      := $C28C
WriteRecord     := $C28F
SetNextFree     := $C292
UpdateRecordFile:= $C295
GetPtrCurDkNm   := $C298
PromptOn        := $C29B
PromptOff       := $C29E
OpenDisk        := $C2A1
DoInlineReturn  := $C2A4
GetNextChar     := $C2A7
BitmapClip      := $C2AA
FindBAMBit      := $C2AD
SetDevice       := $C2B0
IsMseInRegion   := $C2B3
ReadByte        := $C2B6
FreeBlock       := $C2B9
ChangeDiskDevice:= $C2BC
RstrFrmDialogue := $C2BF
Panic           := $C2C2
BitOtherClip    := $C2C5
StashRAM        := $C2C8
FetchRAM        := $C2CB
SwapRAM         := $C2CE
VerifyRAM       := $C2D1
DoRAMOp         := $C2D4
TempHideMouse   := $C2D7
SetMousePicture := $C2DA
SetNewMode      := $C2DD
NormalizeX      := $C2E0
MoveBData       := $C2E3
SwapBData       := $C2E6
VerifyBData     := $C2E9
DoBOp           := $C2EC
AccessCache     := $C2EF
HideOnlyMouse   := $C2F2
SetColorMode    := $C2F5
ColorCard       := $C2F8
ColorRectangle  := $C2FB
curScrLineColor := $D8F0
EXP_BASE        := $DF00
MOUSE_JMP_128   := $FD00
KERNALVecTab    := $FD30
KERNALCIAInit   := $FDA3
MOUSE_BASE      := $FE80
config          := $FF00
KERNALVICInit   := $FF81
NMI_VECTOR      := $FFFA
RESET_VECTOR    := $FFFC
IRQ_VECTOR      := $FFFE
InitKernal:
        jmp     L5006

        jmp     L51C4

L5006:  lda     $88C6
        and     #$0F
        cmp     #$04
        bne     L5074
        jsr     OpenDisk
        txa
        bne     L5076
        lda     r1H
        sta     L511B
        lda     r1L
        sta     L511A
        lda     r6H
        sta     L5078
        lda     r6L
        sta     L5077
        jsr     FindFile
        txa
        bne     L5032
        ldx     #$05
        rts

L5032:  jsr     L5092
        txa
        bne     L5076
        jsr     L5079
        txa
        bne     L5076
        jsr     PutDirHead
        txa
        bne     L5076
        jsr     L50D7
        txa
        bne     L5076
        jsr     L513C
        txa
        bne     L5076
        lda     L5090
        sta     r1L
        lda     L5091
        sta     r1H
        jsr     L903C
        txa
        bne     L5076
        ldy     L508F
        ldx     #$00
L5065:  lda     dirEntryBuf,x
        sta     diskBlkBuf,y
        iny
        inx
        cpx     #$1E
        bcc     L5065
        jmp     PutBlock

L5074:  ldx     #$0D
L5076:  rts

L5077:  brk
L5078:  brk
L5079:  lda     #$00
        jsr     GetFreeDirBlk
        txa
        bne     L508E
        sty     L508F
        lda     r1L
        sta     L5090
        lda     r1H
        sta     L5091
L508E:  rts

L508F:  brk
L5090:  brk
L5091:  brk
L5092:  lda     #$01
        sta     r6L
        lda     #$40
        sta     r6H
L509A:  jsr     FindBAMBit
        bne     L50AA
L509F:  inc     r6H
        bne     L509A
L50A3:  inc     r6L
        bne     L509A
        ldx     #$03
        rts

L50AA:  inc     r6H
        beq     L50A3
        jsr     FindBAMBit
        beq     L509F
        lda     r6L
        sta     L50D3
        sta     L50D5
        lda     r6H
        sta     L50D6
        dec     r6H
        lda     r6H
        sta     L50D4
        jsr     L9048
        txa
        bne     L50D2
        inc     r6H
        jsr     L9048
L50D2:  rts

L50D3:  brk
L50D4:  brk
L50D5:  brk
L50D6:  brk
L50D7:  jsr     i_MoveData
        .addr   curDirHead
        .addr   diskBlkBuf
        .word   $0100
        lda     L50D6
        sta     $8001
        lda     L50D5
        sta     diskBlkBuf
        lda     L511B
        sta     $8023
        lda     L511A
        sta     $8022
        lda     L5090
        sta     $8024
        lda     L5091
        sta     $8025
        lda     L508F
        sta     $8026
        jsr     L511C
        lda     L50D4
        sta     r1H
        lda     L50D3
        sta     r1L
        jmp     L903F

L511A:  brk
L511B:  brk
L511C:  jsr     L5156
        ldy     #$1A
L5121:  ldx     $8004,y
        lda     $8090,y
        sta     $8004,y
        txa
        sta     $8090,y
        dey
        bpl     L5121
        ldy     #$11
        lda     #$00
L5135:  sta     $80AB,y
        dey
        bpl     L5135
        rts

L513C:  lda     L50D6
        sta     r1H
        lda     L50D5
        sta     r1L
L5146:  ldy     #$00
        tya
L5149:  sta     diskBlkBuf,y
        iny
        bne     L5149
        dey
        sty     $8001
        jmp     L903F

L5156:  lda     L5078
        sta     r6H
        lda     L5077
        sta     r6L
        ldy     #$00
L5162:  lda     (r6L),y
        beq     L5171
        sta     $8403,y
        sta     $8090,y
        iny
        cpy     #$10
        bcc     L5162
L5171:  lda     #$A0
        cpy     #$10
        beq     L5180
        sta     $8403,y
        sta     $8090,y
        iny
        bne     L5171
L5180:  lda     #$86
        sta     dirEntryBuf
        lda     L50D4
        sta     $8402
        lda     L50D3
        sta     $8401
        ldy     #$03
        lda     #$00
L5195:  sta     $8413,y
        dey
        bpl     L5195
        lda     year
        sta     $8417
        lda     month
        sta     $8418
        lda     day
        sta     $8419
        lda     hour
        sta     $841A
        lda     minutes
        sta     $841B
        lda     #$00
        sta     $841D
        lda     #$02
        sta     $841C
        rts

L51C4:  lda     $88C6
        and     #$0F
        cmp     #$04
        beq     L51D0
        ldx     #$0D
L51CF:  rts

L51D0:  jsr     L9036
        txa
        bne     L51CF
        bit     isGEOS
        bmi     L51CF
        lda     #$01
        sta     r3L
        lda     #$FE
        sta     r3H
        jsr     SetNextFree
        txa
        bne     L51CF
        lda     r3H
        sta     r1H
        sta     $82AC
        lda     r3L
        sta     r1L
        sta     $82AB
        jsr     L5146
        txa
        bne     L51CF
        ldy     #$0F
L51FF:  lda     L520B,y
        sta     $82AD,y
        dey
        bpl     L51FF
        jmp     PutDirHead

L520B:  .byte   "GEOS format V1.1"

