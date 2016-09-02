; da65 V2.15
; Created:    2016-09-01 21:51:58
; Input file: reu11.bin
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
L8B42           := $8B42
L8B45           := $8B45
L8B48           := $8B48
COLOR_MATRIX    := $8C00
A8FE8           := $8FE8
A8FF0           := $8FF0
DISK_BASE       := $9000
L9D83           := $9D83
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
LC304           := $C304
curScrLineColor := $D8F0
EXP_BASE        := $DF00
LE395           := $E395
LE398           := $E398
LE39B           := $E39B
LE39D           := $E39D
LE4B7           := $E4B7
LFCF8           := $FCF8
MOUSE_JMP_128   := $FD00
KERNALVecTab    := $FD30
KERNALCIAInit   := $FDA3
MOUSE_BASE      := $FE80
config          := $FF00
KERNALVICInit   := $FF81
LFF84           := $FF84
LFF93           := $FF93
LFFA8           := $FFA8
LFFAE           := $FFAE
LFFB1           := $FFB1
NMI_VECTOR      := $FFFA
RESET_VECTOR    := $FFFC
IRQ_VECTOR      := $FFFE
InitKernal:
        sei
        lda     r0H
        sta     L5057
        lda     r0L
        sta     L5056
        jsr     MouseOff
        jsr     LC304
        lda     CPU_DATA
        pha
        lda     #$35
        sta     CPU_DATA
        ldx     $D0BC
        pla
        sta     CPU_DATA
        txa
        bmi     L5044
        lda     $9FED
        cmp     #$04
        bne     L5044
        lda     $9FD6
        .byte   $8F,$7C,$D2,$01,$AD,$D7,$9F,$8F
        .byte   $7D,$D2,$01,$AD,$D8,$9F,$8F,$7E
        .byte   $D2,$01,$AD,$D9,$9F,$8F,$7F,$D2
        .byte   $01
L5044:  jsr     i_MoveData
        .addr   L5050
        .addr   SPRITE_PICS
        .word   $01DB
        jmp     SPRITE_PICS

L5050:  jsr     L9D83
        ldy     #$27
L5055:  .byte   $B9
L5056:  brk
L5057:  .byte   $04
        cmp     #$5B
        bcs     L5062
        cmp     #$41
        bcc     L5062
        sbc     #$40
L5062:  sta     $8BAB,y
        dey
        bpl     L5055
        lda     r5H
        beq     L50B9
        iny
        tya
L506E:  sta     BASICspace,y
        iny
        bne     L506E
        sec
        lda     r7L
        sbc     #$02
        sta     r7L
        lda     r7H
        sbc     #$00
        sta     r7H
        lda     (r7L),y
        pha
        iny
        lda     (r7L),y
        pha
        lda     r7H
        pha
        lda     r7L
        pha
        lda     (r5L),y
        sta     r1L
        iny
        lda     (r5L),y
        sta     r1H
        lda     #$FF
        sta     r2L
        sta     r2H
        jsr     ReadFile
        lda     r7H
        sta     $8BD9
        lda     r7L
        sta     $8BD8
        pla
        sta     r0L
        pla
        sta     r0H
        ldy     #$01
        pla
        sta     (r0L),y
        dey
        pla
        sta     (r0L),y
L50B9:  jsr     PurgeTurbo
        jsr     InitForIO
        lda     #$37
        sta     CPU_DATA
        sei
        ldy     #$03
L50C6:  lda     BASICspace,y
        sta     $8BD4,y
        dey
        bpl     L50C6
        lda     #$00
        sta     STATUS
        lda     curDevice
        sta     $8BDA
        cmp     #$08
        bcc     L5105
        cmp     #$0C
        bcs     L5105
        jsr     LFFB1
        lda     STATUS
        bne     L5102
        lda     #$6F
        jsr     LFF93
        lda     STATUS
        bne     L5102
        lda     #$49
        jsr     LFFA8
        lda     #$0D
        jsr     LFFA8
        jsr     LFFAE
        lda     curDevice
        jsr     LFFB1
L5102:  jsr     LFFAE
L5105:  ldx     #$FF
        txs
        cld
        lda     #$00
        sta     $D016
        jsr     LFF84
        ldy     #$00
        tya
L5114:  sta     r0L,y
        sta     $0200,y
        sta     $0300,y
        iny
        bne     L5114
        lda     #$03
        sta     $B3
        lda     #$3C
        sta     tapeBuffVec
        lda     #$A0
        sta     BASICMemTop
        lda     #$08
        sta     BASICMemBot
        lda     #$04
        sta     scrAddyHi
        lda     #$36
        sta     CPU_DATA
        lda     #$8A
        sta     $A001
        lda     #$F8
        sta     SCREEN_BASE
        jmp     LFCF8

        lda     #$37
        sta     CPU_DATA
        jsr     L8B42
        jsr     L8B45
        jsr     L8B48
        lda     #$8B
        sta     $0319
        lda     #$4B
        sta     nmivec
        lda     #$06
        sta     $8BD3
        lda     $DD0D
        lda     #$FF
        sta     $DD04
        sta     $DD05
        lda     #$81
        sta     $DD0D
        lda     $DD0E
        and     #$80
        ora     #$11
        sta     $DD0E
        lda     #$2F
        sta     CPU_DDR
        lda     #$E7
        sta     CPU_DATA
        sta     $D07B
        lda     $8BDA
        sta     curDevice
        cli
        jmp     LE39D

        jmp     (LE395)

        jmp     (LE398)

        jmp     (LE39B)

        pha
        tya
        pha
        cld
        lda     $DD0D
        dec     $8BD3
        bne     L51F7
        lda     #$7F
        sta     $DD0D
        lda     #$FE
        sta     $0319
        lda     #$47
        sta     nmivec
        ldy     #$03
L51B8:  lda     $8BD4,y
        sta     BASICspace,y
        dey
        bpl     L51B8
        lda     $8BD9
        sta     currentMode
        lda     $8BD8
        sta     $2D
        iny
L51CC:  lda     $8BAB,y
        beq     L51DD
        sta     (curScrLine),y
        lda     $0286
        sta     ($F3),y
        iny
        cpy     #$28
        bcc     L51CC
L51DD:  tya
        beq     L51ED
        lda     #$28
        sta     curPos
        lda     #$01
        sta     kbdQuePos
        lda     #$0D
        sta     kbdQue
L51ED:  lda     $F0D9
        cmp     #$50
        beq     L51F7
        jsr     LE4B7
L51F7:  pla
        tay
        pla
        rti

        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
        brk
