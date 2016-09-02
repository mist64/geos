; da65 V2.15
; Created:    2016-09-01 21:51:58
; Input file: reu7.bin
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
L903C           := $903C
L9048           := $9048
L904B           := $904B
L9050           := $9050
L9053           := $9053
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
        lda     #$00
        sta     L54CF
        sta     L54D0
        jsr     GetDirHead
        bne     L5033
        lda     $88C6
        and     #$0F
        beq     L5031
        cmp     #$05
        bcs     L5031
        tax
        lda     L5035,x
        pha
        lda     L5039,x
        tax
        pla
        jsr     CallRoutine
        ldy     L54D0
        beq     L502D
        ldy     #$FF
        rts

L502D:  ldy     L54CF
        rts

L5031:  ldx     #$0D
L5033:  ldy     #$00
L5035:  rts

        .byte   $FB,$BE,$2B
L5039:  .byte   $3E,$51,$51,$51,$50
        jsr     L507E
        jsr     L509A
        txa
        beq     L5048
        rts

L5048:  jsr     L549C
        txa
        bne     L5074
        lda     #$01
        sta     r6L
        lda     #$21
        sta     r6H
        jsr     L547A
        txa
        bne     L5074
        jsr     PutDirHead
        txa
        bne     L5074
        jsr     L9050
        jsr     L5228
        txa
        bne     L5074
        jsr     PutDirHead
        txa
        bne     L5074
        jmp     L508B

L5074:  pha
        jsr     L50F9
        jsr     L508B
        pla
        tax
        rts

L507E:  lda     $905C
        sta     L5098
        lda     $905D
        sta     L5099
        rts

L508B:  lda     L5098
        sta     r1L
        lda     L5099
        sta     r1H
        jmp     L9053

L5098:  brk
L5099:  brk
L509A:  lda     curDrive
        jsr     SetDevice
        beq     L50A3
        rts

L50A3:  jsr     L50C6
L50A6:  lda     r6L
        sta     r1L
        lda     r6H
        sta     r1H
        jsr     ReadBlock
        bne     L50C3
        jsr     L50E6
        jsr     StashRAM
        inc     r7H
        inc     r6H
        lda     r6H
        cmp     #$22
        bcc     L50A6
L50C3:  jmp     DoneWithIO

L50C6:  jsr     InitForIO
        lda     #$01
        sta     r6L
        lda     #$02
        sta     r6H
        lda     #$B9
        sta     r7H
        lda     #$00
        sta     r7L
        lda     #$00
        sta     r4L
        sta     r0L
        lda     #$80
        sta     r4H
        sta     r0H
        rts

L50E6:  lda     r7H
        sta     r1H
        lda     r7L
        sta     r1L
L50EE:  lda     #$00
        sta     r2L
        sta     r3L
        lda     #$01
        sta     r2H
        rts

L50F9:  lda     curDrive
        jsr     SetDevice
        jsr     EnterTurbo
        jsr     L50C6
L5105:  jsr     L50E6
        jsr     FetchRAM
        lda     #$80
        sta     r4H
        lda     #$00
        sta     r4L
        lda     r6L
        sta     r1L
        lda     r6H
        sta     r1H
        jsr     WriteBlock
        inc     r7H
        inc     r6H
        lda     r6H
        cmp     #$22
        bcc     L5105
        jmp     DoneWithIO

        jsr     L5158
        jsr     L54A1
        txa
        bne     L5151
        lda     #$28
        sta     r6L
        lda     #$02
        sta     r6H
        jsr     L547A
        jsr     L5228
        txa
        bne     L5151
        jsr     L546C
        jsr     PutDirHead
        txa
        bne     L5151
        jmp     OpenDisk

L5151:  pha
        jsr     L516A
        pla
        tax
        rts

L5158:  jsr     L517F
        jsr     L51B2
L515E:  jsr     L5190
        jsr     L51B2
L5164:  jsr     L51A1
        jmp     L51B2

L516A:  jsr     L517F
        jsr     L51B8
L5170:  jsr     L5190
        jsr     L51B8
L5176:  jsr     L51A1
        jsr     L51B8
        jmp     PutDirHead

L517F:  lda     #$9C
        sta     r0H
        lda     #$80
        sta     r0L
        lda     #$BB
        sta     r1H
        lda     #$00
        sta     r1L
        rts

L5190:  lda     #$89
        sta     r0H
        lda     #$00
        sta     r0L
        lda     #$BA
        sta     r1H
        lda     #$00
        sta     r1L
        rts

L51A1:  lda     #$82
        sta     r0H
        lda     #$00
        sta     r0L
        lda     #$B9
        sta     r1H
        lda     #$00
        sta     r1L
        rts

L51B2:  jsr     L50EE
        jmp     StashRAM

L51B8:  jsr     L50EE
        jmp     FetchRAM

        jsr     L515E
        jsr     L548B
        txa
        bne     L51F4
        lda     #$12
        sta     r6L
        lda     #$00
        sta     r6H
        jsr     L547A
        bit     $8203
        bpl     L51E2
        lda     #$35
        sta     r6L
        lda     #$12
        sta     r6H
        jsr     L547A
L51E2:  jsr     L5228
        txa
        bne     L51F4
        jsr     L546C
        jsr     PutDirHead
        txa
        bne     L51F4
        jmp     OpenDisk

L51F4:  pha
        jsr     L5170
        pla
        tax
        rts

        jsr     L5164
        jsr     L5492
        txa
        bne     L5221
        lda     #$12
        sta     r6L
        lda     #$00
        sta     r6H
        jsr     L547A
        jsr     L5228
        txa
        bne     L5221
        jsr     L546C
        jsr     PutDirHead
        txa
        bne     L5221
        jmp     OpenDisk

L5221:  pha
        jsr     L5176
        pla
        tax
        rts

L5228:  lda     $8201
        sta     r6H
        lda     curDirHead
        sta     r6L
L5232:  jsr     L9048
        lda     r6H
        sta     r1H
        lda     r6L
        sta     r1L
        jsr     L903C
        txa
        beq     L5244
        rts

L5244:  lda     #$80
        sta     r5H
        lda     #$02
        sta     r5L
L524C:  jsr     L5436
        ldy     #$00
        lda     (r5L),y
        and     #$BF
        cmp     #$86
        bne     L525F
        jsr     L52D5
        jmp     L5228

L525F:  jsr     L530A
        txa
        bne     L52A0
L5265:  jsr     L544B
        clc
        lda     r5L
        adc     #$20
        sta     r5L
        bcc     L524C
        lda     $8001
        sta     r6H
        lda     diskBlkBuf
        sta     r6L
        bne     L5232
        bit     L5435
        bmi     L528D
        jsr     L53FF
        txa
        bne     L52D4
        bit     L5435
        bmi     L524C
L528D:  lda     #$00
        sta     L5435
        lda     $88C6
        and     #$0F
        cmp     #$04
        bne     L52A0
        lda     $8222
        bne     L52A3
L52A0:  rts

L52A1:  beq     L5265
L52A3:  lda     $8225
        sta     r1H
        lda     $8224
        sta     r1L
        lda     $8226
        sta     r5L
        lda     #$80
        sta     r5H
        jsr     L5436
        jsr     L544B
        jsr     GetBlock
        bne     L52D4
        jsr     PutDirHead
        lda     $8223
        sta     r1H
        lda     $8222
        sta     r1L
        jsr     L9053
        txa
        beq     L52A1
L52D4:  rts

L52D5:  jsr     L544B
        ldy     #$01
        lda     (r5L),y
        sta     r6L
        iny
        lda     (r5L),y
        sta     r6H
        jsr     L9048
        jsr     PutDirHead
        jsr     L544B
        ldy     #$01
        lda     (r5L),y
        sta     r1L
        iny
        lda     (r5L),y
        sta     r1H
        jsr     L9053
        lda     $8201
        sta     r6H
        lda     curDirHead
        sta     r6L
        jsr     L9048
        jmp     PutDirHead

L530A:  ldy     #$00
        lda     (r5L),y
        beq     L5320
        and     #$BF
        cmp     #$81
        bcs     L5322
        lda     #$00
        sta     (r5L),y
        jsr     L544B
        jmp     PutBlock

L5320:  tax
        rts

L5322:  and     #$3F
        cmp     #$04
        beq     L533A
        ldy     #$13
        lda     (r5L),y
        bne     L5331
L532E:  jmp     L533D

L5331:  ldy     #$16
        lda     (r5L),y
        beq     L532E
        jmp     L5379

L533A:  jmp     L53E0

L533D:  ldy     #$01
        lda     (r5L),y
        sta     r1L
        iny
        lda     (r5L),y
        sta     r1H
L5348:  jsr     InitForIO
        lda     r1H
        sta     r6H
        lda     r1L
        sta     r6L
L5353:  jsr     L9048
        jsr     L53F1
        lda     #$54
        sta     r4H
        lda     #$CD
        sta     r4L
        jsr     L904B
        bne     L5376
        lda     L54CE
        sta     r1H
        sta     r6H
        lda     L54CD
        sta     r1L
        sta     r6L
        bne     L5353
L5376:  jmp     DoneWithIO

L5379:  ldy     #$13
        lda     (r5L),y
        sta     r6L
        iny
        lda     (r5L),y
        sta     r6H
        jsr     L9048
        jsr     L53F1
        ldy     #$01
        lda     (r5L),y
        sta     r1L
        iny
        lda     (r5L),y
        sta     r1H
        ldy     #$15
        lda     (r5L),y
        cmp     #$01
        beq     L53A0
        jmp     L5348

L53A0:  lda     #$81
        sta     r4H
        lda     #$00
        sta     r4L
        jsr     GetBlock
        bne     L53DE
        lda     r1H
        sta     r6H
        lda     r1L
        sta     r6L
        jsr     L9048
        jsr     L53F1
        ldy     #$02
        sty     L53DF
L53C0:  lda     $8101,y
        sta     r1H
        lda     fileHeader,y
        sta     r1L
        beq     L53D2
        jsr     L5348
        txa
        bne     L53DE
L53D2:  ldy     L53DF
        iny
        iny
        sty     L53DF
        bne     L53C0
        ldx     #$00
L53DE:  rts

L53DF:  brk
L53E0:  jsr     L533D
        ldy     #$13
        lda     (r5L),y
        sta     r1L
        iny
        lda     (r5L),y
        sta     r1H
        jmp     L5348

L53F1:  txa
        beq     L53FE
        inc     L54CF
        bne     L53FC
        inc     L54D0
L53FC:  ldx     #$00
L53FE:  rts

L53FF:  lda     $82AC
        sta     r6H
        sta     r1H
        lda     $82AB
        sta     r6L
        sta     r1L
        beq     L542D
        jsr     L9048
        cpx     #$06
        beq     L542D
        txa
        bne     L542F
        jsr     L903C
        lda     #$80
        sta     r5H
        lda     #$02
        sta     r5L
        txa
        bne     L542F
        lda     #$FF
        sta     L5435
        rts

L542D:  ldx     #$00
L542F:  lda     #$00
        sta     L5435
        rts

L5435:  brk
L5436:  lda     r1H
        sta     L5469
        lda     r1L
        sta     L5468
        lda     r5H
        sta     L546B
        lda     r5L
        sta     L546A
        rts

L544B:  lda     L5469
        sta     r1H
        lda     L5468
        sta     r1L
        lda     L546B
        sta     r5H
        lda     L546A
        sta     r5L
        lda     #$80
        sta     r4H
        lda     #$00
        sta     r4L
        rts

L5468:  brk
L5469:  brk
L546A:  brk
L546B:  brk
L546C:  lda     #$01
        sta     r6L
        lda     #$00
        sta     r6H
        jsr     L9048
        ldx     #$00
        rts

L547A:  jsr     L9048
        txa
        beq     L5484
        cpx     #$06
        bne     L548A
L5484:  dec     r6H
        bpl     L547A
        ldx     #$00
L548A:  rts

L548B:  ldx     #$47
        bit     $8203
        bmi     L54A3
L5492:  ldx     #$24
        bit     $8203
        bpl     L54A3
        ldx     #$06
        rts

L549C:  ldx     $9062
        inx
        .byte   $2C
L54A1:  ldx     #$51
L54A3:  stx     L54CC
        lda     #$01
        sta     r6L
L54AA:  lda     #$00
        sta     r6H
L54AE:  jsr     FreeBlock
        txa
        beq     L54BC
        cpx     #$02
        beq     L54C0
        cpx     #$06
        bne     L54CB
L54BC:  inc     r6H
        bne     L54AE
L54C0:  inc     r6L
        lda     r6L
        cmp     L54CC
        bne     L54AA
        ldx     #$00
L54CB:  rts

L54CC:  brk
L54CD:  brk
L54CE:  brk
L54CF:  brk
L54D0:  brk
