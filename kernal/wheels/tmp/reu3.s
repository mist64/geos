; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu3.bin
; Page:       1


        .setcpu"6502"

; ----------------------------------------------------------------------------
CPU_DDR     := $0000
CPU_DATA    := $0001
r0L         := $0002
r0H         := $0003
r1L         := $0004
r1H         := $0005
r2L         := $0006
r2H         := $0007
r3L         := $0008
r3H         := $0009
r4L         := $000A
r4H         := $000B
r5L         := $000C
r5H         := $000D
r6L         := $000E
r6H         := $000F
r7L         := $0010
r7H         := $0011
r8L         := $0012
r8H         := $0013
r9L         := $0014
r9H         := $0015
r10L        := $0016
r10H        := $0017
r11L        := $0018
r11H        := $0019
r12L        := $001A
r12H        := $001B
r13L        := $001C
r13H        := $001D
r14L        := $001E
r14H        := $001F
r15L        := $0020
r15H        := $0021
curPattern  := $0022
string      := $0024
baselineOffset:= $0026
curSetWidth := $0027
curHeight   := $0029
curIndexTable:= $002A
cardDataPntr:= $002C
currentMode := $002E
dispBufferOn:= $002F
mouseOn     := $0030
msePicPtr   := $0031
windowTop   := $0033
windowBottom:= $0034
leftMargin  := $0035
rightMargin := $0037
pressFlag   := $0039
mouseXPos   := $003A
mouseYPos   := $003C
returnAddress:= $003D
graphMode   := $003F
CallRLo     := $0041
CallRHi     := $0042
DBoxDescL   := $0043
DBoxDescH   := $0044
Z45         := $0045
Z46         := $0046
Z47         := $0047
a2L         := $0070
a2H         := $0071
a3L         := $0072
a3H         := $0073
a4L         := $0074
a4H         := $0075
a5L         := $0076
a5H         := $0077
a6L         := $0078
a6H         := $0079
a7L         := $007A
a7H         := $007B
a8L         := $007C
a8H         := $007D
a9L         := $007E
a9H         := $007F
DACC_ST_ADDR:= $0080
DACC_LGH    := $0082
DTOP_CHNUM  := $0083
DTOP_CHAIN  := $0085
z8b         := $008B
z8c         := $008C
z8d         := $008D
z8e         := $008E
z8f         := $008F
STATUS      := $0090
tapeBuffVec := $00B2
curDevice   := $00BA
kbdQuePos   := $00C6
curScrLine  := $00D1
curPos      := $00D3
a0L         := $00FB
a0H         := $00FC
a1L         := $00FD
a1H         := $00FE
kbdQue      := $0277
BASICMemBot := $0282
BASICMemTop := $0284
scrAddyHi   := $0288
PALNTSCFLAG := $02A6
irqvec      := $0314
bkvec       := $0316
nmivec      := $0318
APP_RAM     := $0400
BASICspace  := $0800
BACK_SCR_BASE:= $6000
PRINTBASE   := $7900
diskBlkBuf  := $8000
fileHeader  := $8100
curDirHead  := $8200
fileTrScTab := $8300
dirEntryBuf := $8400
DrACurDkNm  := $841E
DrBCurDkNm  := $8430
dataFileName:= $8442
dataDiskName:= $8453
PrntFilename:= $8465
PrntDiskName:= $8476
curDrive    := $8489
diskOpenFlg := $848A
isGEOS      := $848B
interleave  := $848C
NUMDRV      := $848D
driveType   := $848E
turboFlags  := $8492
curRecord   := $8496
usedRecords := $8497
fileWritten := $8498
fileSize    := $8499
appMain     := $849B
intTopVector:= $849D
intBotVector:= $849F
mouseVector := $84A1
keyVector   := $84A3
inputVector := $84A5
mouseFaultVec:= $84A7
otherPressVec:= $84A9
StringFaultVec:= $84AB
alarmTmtVector:= $84AD
BRKVector   := $84AF
RecoverVector:= $84B1
selectionFlash:= $84B3
alphaFlag   := $84B4
iconSelFlg  := $84B5
faultData   := $84B6
menuNumber  := $84B7
mouseTop    := $84B8
mouseBottom := $84B9
mouseLeft   := $84BA
mouseRight  := $84BC
stringX     := $84BE
stringY     := $84C0
mousePicData:= $84C1
maxMouseSpeed:= $8501
minMouseSpeed:= $8502
mouseAccel  := $8503
keyData     := $8504
mouseData   := $8505
inputData   := $8506
mouseSpeed  := $8507
random      := $850A
saveFontTab := $850C
dblClickCount:= $8515
year        := $8516
month       := $8517
day         := $8518
hour        := $8519
minutes     := $851A
seconds     := $851B
alarmSetFlag:= $851C
sysDBData   := $851D
screencolors:= $851E
dlgBoxRamBuf:= $851F
menuOptNumber:= $86C0
menuTop     := $86C1
menuBottom  := $86C2
menuLeft    := $86C3
menuRight   := $86C5
menuStackL  := $86C7
menuStackH  := $86CB
menuOptionTab:= $86CF
menuLimitTabL:= $86D3
menuLimitTabH:= $86E2
TimersTab   := $86F1
TimersCMDs  := $8719
TimersRtns  := $872D
TimersVals  := $8755
NumTimers   := $877D
DelaySP     := $877E
DelayValL   := $877F
DelayValH   := $8793
DelayRtnsL  := $87A7
DelayRtnsH  := $87BB
stringLen   := $87CF
stringMaxLen:= $87D0
tmpKeyVector:= $87D1
stringMargCtrl:= $87D3
GraphPenXL  := $87D4
GraphPenXH  := $87D5
KbdQueHead  := $87D7
KbdQueTail  := $87D8
KbdQueFlag  := $87D9
KbdQueue    := $87DA
KbdNextKey  := $87EA
KbdDBncTab  := $87EB
KbdDMltTab  := $87F3
E87FC       := $87FC
E87FD       := $87FD
E87FE       := $87FE
E87FF       := $87FF
E8800       := $8800
PrvCharWidth:= $8807
clkBoxTemp  := $8808
clkBoxTemp2 := $8809
alarmWarnFlag:= $880A
tempIRQAcc  := $880B
defIconTab  := $880C
DeskAccPC   := $8850
DeskAccSP   := $8852
dlgBoxCallerPC:= $8853
dlgBoxCallerSP:= $8855
DBGFilesFound:= $8856
DBGFOffsLeft:= $8857
DBGFOffsTop := $8858
DBGFNameTable:= $8859
DBGFTableIndex:= $885B
DBGFileSelected:= $885C
A885D       := $885D
A885E       := $885E
A885F       := $885F
A8860       := $8860
RecordDirTS := $8861
RecordDirOffs:= $8863
RecordTableTS:= $8865
verifyFlag  := $8867
TempCurDrive:= $8868
e88b7       := $88B7
SPRITE_PICS := $8A00
COLOR_MATRIX:= $8C00
A8FE8       := $8FE8
A8FF0       := $8FF0
DISK_BASE   := $9000
SCREEN_BASE := $A000
OS_ROM      := $C000
InterruptMain:= $C100
InitProcesses:= $C103
RestartProcess:= $C106
EnableProcess:= $C109
BlockProcess:= $C10C
UnblockProcess:= $C10F
FreezeProcess:= $C112
UnfreezeProcess:= $C115
HorizontalLine:= $C118
InvertLine  := $C11B
RecoverLine := $C11E
VerticalLine:= $C121
Rectangle   := $C124
FrameRectangle:= $C127
InvertRectangle:= $C12A
RecoverRectangle:= $C12D
DrawLine    := $C130
DrawPoint   := $C133
GraphicsString:= $C136
SetPattern  := $C139
GetScanLine := $C13C
TestPoint   := $C13F
BitmapUp    := $C142
PutChar     := $C145
PutString   := $C148
UseSystemFont:= $C14B
StartMouseMode:= $C14E
DoMenu      := $C151
RecoverMenu := $C154
RecoverAllMenus:= $C157
DoIcons     := $C15A
DShiftLeft  := $C15D
BBMult      := $C160
BMult       := $C163
DMult       := $C166
Ddiv        := $C169
DSdiv       := $C16C
Dabs        := $C16F
Dnegate     := $C172
Ddec        := $C175
ClearRam    := $C178
FillRam     := $C17B
MoveData    := $C17E
InitRam     := $C181
PutDecimal  := $C184
GetRandom   := $C187
MouseUp     := $C18A
MouseOff    := $C18D
DoPreviousMenu:= $C190
ReDoMenu    := $C193
GetSerialNumber:= $C196
Sleep       := $C199
ClearMouseMode:= $C19C
i_Rectangle := $C19F
i_FrameRectangle:= $C1A2
i_RecoverRectangle:= $C1A5
i_GraphicsString:= $C1A8
i_BitmapUp  := $C1AB
i_PutString := $C1AE
GetRealSize := $C1B1
i_FillRam   := $C1B4
i_MoveData  := $C1B7
GetString   := $C1BA
GotoFirstMenu:= $C1BD
InitTextPrompt:= $C1C0
MainLoop    := $C1C3
DrawSprite  := $C1C6
GetCharWidth:= $C1C9
LoadCharSet := $C1CC
PosSprite   := $C1CF
EnablSprite := $C1D2
DisablSprite:= $C1D5
CallRoutine := $C1D8
CalcBlksFree:= $C1DB
ChkDkGEOS   := $C1DE
NewDisk     := $C1E1
GetBlock    := $C1E4
PutBlock    := $C1E7
SetGEOSDisk := $C1EA
SaveFile    := $C1ED
SetGDirEntry:= $C1F0
BldGDirEntry:= $C1F3
GetFreeDirBlk:= $C1F6
WriteFile   := $C1F9
BlkAlloc    := $C1FC
ReadFile    := $C1FF
SmallPutChar:= $C202
FollowChain := $C205
GetFile     := $C208
FindFile    := $C20B
CRC         := $C20E
LdFile      := $C211
EnterTurbo  := $C214
LdDeskAcc   := $C217
ReadBlock   := $C21A
LdApplic    := $C21D
WriteBlock  := $C220
VerWriteBlock:= $C223
FreeFile    := $C226
GetFHdrInfo := $C229
EnterDeskTop:= $C22C
StartAppl   := $C22F
ExitTurbo   := $C232
PurgeTurbo  := $C235
DeleteFile  := $C238
FindFTypes  := $C23B
RstrAppl    := $C23E
ToBASIC     := $C241
FastDelFile := $C244
GetDirHead  := $C247
PutDirHead  := $C24A
NxtBlkAlloc := $C24D
ImprintRectangle:= $C250
i_ImprintRectangle:= $C253
DoDlgBox    := $C256
RenameFile  := $C259
InitForIO   := $C25C
DoneWithIO  := $C25F
DShiftRight := $C262
CopyString  := $C265
CopyFString := $C268
CmpString   := $C26B
CmpFString  := $C26E
FirstInit   := $C271
OpenRecordFile:= $C274
CloseRecordFile:= $C277
NextRecord  := $C27A
PreviousRecord:= $C27D
PointRecord := $C280
DeleteRecord:= $C283
InsertRecord:= $C286
AppendRecord:= $C289
ReadRecord  := $C28C
WriteRecord := $C28F
SetNextFree := $C292
UpdateRecordFile:= $C295
GetPtrCurDkNm:= $C298
PromptOn    := $C29B
PromptOff   := $C29E
OpenDisk    := $C2A1
DoInlineReturn:= $C2A4
GetNextChar := $C2A7
BitmapClip  := $C2AA
FindBAMBit  := $C2AD
SetDevice   := $C2B0
IsMseInRegion:= $C2B3
ReadByte    := $C2B6
FreeBlock   := $C2B9
ChangeDiskDevice:= $C2BC
RstrFrmDialogue:= $C2BF
Panic       := $C2C2
BitOtherClip:= $C2C5
StashRAM    := $C2C8
FetchRAM    := $C2CB
SwapRAM     := $C2CE
VerifyRAM   := $C2D1
DoRAMOp     := $C2D4
TempHideMouse:= $C2D7
SetMousePicture:= $C2DA
SetNewMode  := $C2DD
NormalizeX  := $C2E0
MoveBData   := $C2E3
SwapBData   := $C2E6
VerifyBData := $C2E9
DoBOp       := $C2EC
AccessCache := $C2EF
HideOnlyMouse:= $C2F2
SetColorMode:= $C2F5
ColorCard   := $C2F8
ColorRectangle:= $C2FB
curScrLineColor:= $D8F0
EXP_BASE    := $DF00
MOUSE_JMP_128:= $FD00
KERNALVecTab:= $FD30
KERNALCIAInit:= $FDA3
MOUSE_BASE  := $FE80
config      := $FF00
KERNALVICInit:= $FF81
NMI_VECTOR  := $FFFA
RESET_VECTOR:= $FFFC
IRQ_VECTOR  := $FFFE
; ----------------------------------------------------------------------------
InitKernal:
        jsr EnterTurbo                          ; 5000 20 14 C2                  ..
        txa                                     ; 5003 8A                       .
        beq L5007                               ; 5004 F0 01                    ..
        rts                                     ; 5006 60                       `

; ----------------------------------------------------------------------------
L5007:  jsr InitForIO                           ; 5007 20 5C C2                  \.
        lda r0H                                 ; 500A A5 03                    ..
        pha                                     ; 500C 48                       H
        lda r0L                                 ; 500D A5 02                    ..
        pha                                     ; 500F 48                       H
        lda #$80                                ; 5010 A9 80                    ..
        sta r4H                                 ; 5012 85 0B                    ..
        lda #$00                                ; 5014 A9 00                    ..
        sta r4L                                 ; 5016 85 0A                    ..
        lda #$02                                ; 5018 A9 02                    ..
        sta r5L                                 ; 501A 85 0C                    ..
        lda r1H                                 ; 501C A5 05                    ..
        sta $8303                               ; 501E 8D 03 83                 ...
        lda r1L                                 ; 5021 A5 04                    ..
        sta $8302                               ; 5023 8D 02 83                 ...
L5026:  jsr ReadBlock                           ; 5026 20 1A C2                  ..
        txa                                     ; 5029 8A                       .
        bne L509B                               ; 502A D0 6F                    .o
        ldy #$FE                                ; 502C A0 FE                    ..
        lda diskBlkBuf                          ; 502E AD 00 80                 ...
        bne L503B                               ; 5031 D0 08                    ..
        ldy $8001                               ; 5033 AC 01 80                 ...
        beq L5081                               ; 5036 F0 49                    .I
        dey                                     ; 5038 88                       .
        beq L5081                               ; 5039 F0 46                    .F
L503B:  lda r2H                                 ; 503B A5 07                    ..
        bne L5049                               ; 503D D0 0A                    ..
        cpy r2L                                 ; 503F C4 06                    ..
        bcc L5049                               ; 5041 90 06                    ..
        beq L5049                               ; 5043 F0 04                    ..
        ldx #$0B                                ; 5045 A2 0B                    ..
        bne L509B                               ; 5047 D0 52                    .R
L5049:  sty r1L                                 ; 5049 84 04                    ..
        lda #$30                                ; 504B A9 30                    .0
        sta CPU_DATA                            ; 504D 85 01                    ..
        lda r7H                                 ; 504F A5 11                    ..
        cmp #$4F                                ; 5051 C9 4F                    .O
        bcc L505F                               ; 5053 90 0A                    ..
        cmp #$52                                ; 5055 C9 52                    .R
        bcs L505F                               ; 5057 B0 06                    ..
        jsr L50A4                               ; 5059 20 A4 50                  .P
        clv                                     ; 505C B8                       .
        bvc L5067                               ; 505D 50 08                    P.
L505F:  lda $8001,y                             ; 505F B9 01 80                 ...
        dey                                     ; 5062 88                       .
        sta (r7L),y                             ; 5063 91 10                    ..
        bne L505F                               ; 5065 D0 F8                    ..
L5067:  lda #$36                                ; 5067 A9 36                    .6
        sta CPU_DATA                            ; 5069 85 01                    ..
        lda r1L                                 ; 506B A5 04                    ..
        clc                                     ; 506D 18                       .
        adc r7L                                 ; 506E 65 10                    e.
        sta r7L                                 ; 5070 85 10                    ..
        bcc L5076                               ; 5072 90 02                    ..
        inc r7H                                 ; 5074 E6 11                    ..
L5076:  lda r2L                                 ; 5076 A5 06                    ..
        sec                                     ; 5078 38                       8
        sbc r1L                                 ; 5079 E5 04                    ..
        sta r2L                                 ; 507B 85 06                    ..
        bcs L5081                               ; 507D B0 02                    ..
        dec r2H                                 ; 507F C6 07                    ..
L5081:  inc r5L                                 ; 5081 E6 0C                    ..
        inc r5L                                 ; 5083 E6 0C                    ..
        ldy r5L                                 ; 5085 A4 0C                    ..
        lda $8001                               ; 5087 AD 01 80                 ...
        sta r1H                                 ; 508A 85 05                    ..
        sta $8301,y                             ; 508C 99 01 83                 ...
        lda diskBlkBuf                          ; 508F AD 00 80                 ...
        sta r1L                                 ; 5092 85 04                    ..
        sta fileTrScTab,y                       ; 5094 99 00 83                 ...
        bne L5026                               ; 5097 D0 8D                    ..
        ldx #$00                                ; 5099 A2 00                    ..
L509B:  pla                                     ; 509B 68                       h
        sta r0L                                 ; 509C 85 02                    ..
        pla                                     ; 509E 68                       h
        sta r0H                                 ; 509F 85 03                    ..
        jmp DoneWithIO                          ; 50A1 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L50A4:  lda r10L                                ; 50A4 A5 16                    ..
        pha                                     ; 50A6 48                       H
        lda r9H                                 ; 50A7 A5 15                    ..
        pha                                     ; 50A9 48                       H
        lda r9L                                 ; 50AA A5 14                    ..
        pha                                     ; 50AC 48                       H
        lda r3H                                 ; 50AD A5 09                    ..
        pha                                     ; 50AF 48                       H
        lda r3L                                 ; 50B0 A5 08                    ..
        pha                                     ; 50B2 48                       H
        lda r2H                                 ; 50B3 A5 07                    ..
        pha                                     ; 50B5 48                       H
        lda r2L                                 ; 50B6 A5 06                    ..
        pha                                     ; 50B8 48                       H
        lda r1H                                 ; 50B9 A5 05                    ..
        pha                                     ; 50BB 48                       H
        lda r1L                                 ; 50BC A5 04                    ..
        pha                                     ; 50BE 48                       H
        lda r0H                                 ; 50BF A5 03                    ..
        pha                                     ; 50C1 48                       H
        lda r0L                                 ; 50C2 A5 02                    ..
        pha                                     ; 50C4 48                       H
        ldx #$00                                ; 50C5 A2 00                    ..
        sty r10L                                ; 50C7 84 16                    ..
        lda r7H                                 ; 50C9 A5 11                    ..
        sta r9H                                 ; 50CB 85 15                    ..
        lda r7L                                 ; 50CD A5 10                    ..
        sta r9L                                 ; 50CF 85 14                    ..
L50D1:  lda r9H                                 ; 50D1 A5 15                    ..
        cmp #$50                                ; 50D3 C9 50                    .P
        bne L50DB                               ; 50D5 D0 04                    ..
        lda r9L                                 ; 50D7 A5 14                    ..
        cmp #$00                                ; 50D9 C9 00                    ..
L50DB:  bcc L50E9                               ; 50DB 90 0C                    ..
        lda r9H                                 ; 50DD A5 15                    ..
        cmp #$51                                ; 50DF C9 51                    .Q
        bne L50E7                               ; 50E1 D0 04                    ..
        lda r9L                                 ; 50E3 A5 14                    ..
        cmp #$C2                                ; 50E5 C9 C2                    ..
L50E7:  bcc L5102                               ; 50E7 90 19                    ..
L50E9:  ldy #$00                                ; 50E9 A0 00                    ..
        lda $8002,x                             ; 50EB BD 02 80                 ...
        sta (r9L),y                             ; 50EE 91 14                    ..
        clc                                     ; 50F0 18                       .
        lda #$01                                ; 50F1 A9 01                    ..
        adc r9L                                 ; 50F3 65 14                    e.
        sta r9L                                 ; 50F5 85 14                    ..
        bcc L50FB                               ; 50F7 90 02                    ..
        inc r9H                                 ; 50F9 E6 15                    ..
L50FB:  inx                                     ; 50FB E8                       .
        cpx r10L                                ; 50FC E4 16                    ..
        bcc L50D1                               ; 50FE 90 D1                    ..
        bcs L512D                               ; 5100 B0 2B                    .+
L5102:  jsr L514F                               ; 5102 20 4F 51                  OQ
        clc                                     ; 5105 18                       .
        lda r9L                                 ; 5106 A5 14                    ..
        adc r2L                                 ; 5108 65 06                    e.
        sta r9L                                 ; 510A 85 14                    ..
        lda r9H                                 ; 510C A5 15                    ..
        adc r2H                                 ; 510E 65 07                    e.
        sta r9H                                 ; 5110 85 15                    ..
        clc                                     ; 5112 18                       .
        lda r0L                                 ; 5113 A5 02                    ..
        adc r2L                                 ; 5115 65 06                    e.
        bcs L512D                               ; 5117 B0 14                    ..
        tax                                     ; 5119 AA                       .
        dex                                     ; 511A CA                       .
        dex                                     ; 511B CA                       .
        cpx r10L                                ; 511C E4 16                    ..
        bcs L512D                               ; 511E B0 0D                    ..
        ldy #$00                                ; 5120 A0 00                    ..
L5122:  lda $8002,x                             ; 5122 BD 02 80                 ...
        sta (r9L),y                             ; 5125 91 14                    ..
        iny                                     ; 5127 C8                       .
        inx                                     ; 5128 E8                       .
        cpx r10L                                ; 5129 E4 16                    ..
        bcc L5122                               ; 512B 90 F5                    ..
L512D:  pla                                     ; 512D 68                       h
        sta r0L                                 ; 512E 85 02                    ..
        pla                                     ; 5130 68                       h
        sta r0H                                 ; 5131 85 03                    ..
        pla                                     ; 5133 68                       h
        sta r1L                                 ; 5134 85 04                    ..
        pla                                     ; 5136 68                       h
        sta r1H                                 ; 5137 85 05                    ..
        pla                                     ; 5139 68                       h
        sta r2L                                 ; 513A 85 06                    ..
        pla                                     ; 513C 68                       h
        sta r2H                                 ; 513D 85 07                    ..
        pla                                     ; 513F 68                       h
        sta r3L                                 ; 5140 85 08                    ..
        pla                                     ; 5142 68                       h
        sta r3H                                 ; 5143 85 09                    ..
        pla                                     ; 5145 68                       h
        sta r9L                                 ; 5146 85 14                    ..
        pla                                     ; 5148 68                       h
        sta r9H                                 ; 5149 85 15                    ..
        pla                                     ; 514B 68                       h
        sta r10L                                ; 514C 85 16                    ..
        rts                                     ; 514E 60                       `

; ----------------------------------------------------------------------------
L514F:  sec                                     ; 514F 38                       8
        lda r9L                                 ; 5150 A5 14                    ..
        sbc #$00                                ; 5152 E9 00                    ..
        sta r1L                                 ; 5154 85 04                    ..
        lda r9H                                 ; 5156 A5 15                    ..
        sbc #$50                                ; 5158 E9 50                    .P
        sta r1H                                 ; 515A 85 05                    ..
        txa                                     ; 515C 8A                       .
        clc                                     ; 515D 18                       .
        adc #$02                                ; 515E 69 02                    i.
        sta r0L                                 ; 5160 85 02                    ..
        lda #$80                                ; 5162 A9 80                    ..
        sta r0H                                 ; 5164 85 03                    ..
        stx r2L                                 ; 5166 86 06                    ..
        sec                                     ; 5168 38                       8
        lda r10L                                ; 5169 A5 16                    ..
        sbc r2L                                 ; 516B E5 06                    ..
        sta r2L                                 ; 516D 85 06                    ..
        lda #$00                                ; 516F A9 00                    ..
        sta r2H                                 ; 5171 85 07                    ..
        clc                                     ; 5173 18                       .
        lda r1L                                 ; 5174 A5 04                    ..
        adc r2L                                 ; 5176 65 06                    e.
        sta r3L                                 ; 5178 85 08                    ..
        lda r1H                                 ; 517A A5 05                    ..
        adc r2H                                 ; 517C 65 07                    e.
        sta r3H                                 ; 517E 85 09                    ..
        lda r3H                                 ; 5180 A5 09                    ..
        cmp #$01                                ; 5182 C9 01                    ..
        bne L518A                               ; 5184 D0 04                    ..
        lda r3L                                 ; 5186 A5 08                    ..
        cmp #$C2                                ; 5188 C9 C2                    ..
L518A:  bcc L51A6                               ; 518A 90 1A                    ..
        sec                                     ; 518C 38                       8
        lda r3L                                 ; 518D A5 08                    ..
        sbc #$C2                                ; 518F E9 C2                    ..
        sta r3L                                 ; 5191 85 08                    ..
        lda r3H                                 ; 5193 A5 09                    ..
        sbc #$01                                ; 5195 E9 01                    ..
        sta r3H                                 ; 5197 85 09                    ..
        sec                                     ; 5199 38                       8
        lda r2L                                 ; 519A A5 06                    ..
        sbc r3L                                 ; 519C E5 08                    ..
        sta r2L                                 ; 519E 85 06                    ..
        lda r2H                                 ; 51A0 A5 07                    ..
        sbc r3H                                 ; 51A2 E5 09                    ..
        sta r2H                                 ; 51A4 85 07                    ..
L51A6:  clc                                     ; 51A6 18                       .
        lda #$27                                ; 51A7 A9 27                    .'
        adc r1L                                 ; 51A9 65 04                    e.
        sta r1L                                 ; 51AB 85 04                    ..
        lda #$06                                ; 51AD A9 06                    ..
        adc r1H                                 ; 51AF 65 05                    e.
        sta r1H                                 ; 51B1 85 05                    ..
        lda $88C3                               ; 51B3 AD C3 88                 ...
        sta r3L                                 ; 51B6 85 08                    ..
        inc $88C3                               ; 51B8 EE C3 88                 ...
        jsr StashRAM                            ; 51BB 20 C8 C2                  ..
        dec $88C3                               ; 51BE CE C3 88                 ...
        rts                                     ; 51C1 60                       `

; ----------------------------------------------------------------------------
