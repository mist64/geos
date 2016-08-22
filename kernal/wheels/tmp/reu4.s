; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu4.bin
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
        lda #$80                                ; 500A A9 80                    ..
        sta r4H                                 ; 500C 85 0B                    ..
        lda #$00                                ; 500E A9 00                    ..
        sta r4L                                 ; 5010 85 0A                    ..
        lda r6H                                 ; 5012 A5 0F                    ..
        pha                                     ; 5014 48                       H
        lda r6L                                 ; 5015 A5 0E                    ..
        pha                                     ; 5017 48                       H
        lda r7H                                 ; 5018 A5 11                    ..
        pha                                     ; 501A 48                       H
        lda r7L                                 ; 501B A5 10                    ..
        pha                                     ; 501D 48                       H
L501E:  ldy #$00                                ; 501E A0 00                    ..
        lda (r6L),y                             ; 5020 B1 0E                    ..
        beq L5076                               ; 5022 F0 52                    .R
        sta r1L                                 ; 5024 85 04                    ..
        iny                                     ; 5026 C8                       .
        lda (r6L),y                             ; 5027 B1 0E                    ..
        sta r1H                                 ; 5029 85 05                    ..
        dey                                     ; 502B 88                       .
        clc                                     ; 502C 18                       .
        lda #$02                                ; 502D A9 02                    ..
        adc r6L                                 ; 502F 65 0E                    e.
        sta r6L                                 ; 5031 85 0E                    ..
        bcc L5037                               ; 5033 90 02                    ..
        inc r6H                                 ; 5035 E6 0F                    ..
L5037:  lda (r6L),y                             ; 5037 B1 0E                    ..
        sta (r4L),y                             ; 5039 91 0A                    ..
        iny                                     ; 503B C8                       .
        lda (r6L),y                             ; 503C B1 0E                    ..
        sta (r4L),y                             ; 503E 91 0A                    ..
        ldy #$FE                                ; 5040 A0 FE                    ..
        lda #$30                                ; 5042 A9 30                    .0
        sta CPU_DATA                            ; 5044 85 01                    ..
        lda r7H                                 ; 5046 A5 11                    ..
        cmp #$4F                                ; 5048 C9 4F                    .O
        bcc L5056                               ; 504A 90 0A                    ..
        cmp #$52                                ; 504C C9 52                    .R
        bcs L5056                               ; 504E B0 06                    ..
        jsr L5086                               ; 5050 20 86 50                  .P
        clv                                     ; 5053 B8                       .
        bvc L505F                               ; 5054 50 09                    P.
L5056:  dey                                     ; 5056 88                       .
        lda (r7L),y                             ; 5057 B1 10                    ..
        sta $8002,y                             ; 5059 99 02 80                 ...
        tya                                     ; 505C 98                       .
        bne L5056                               ; 505D D0 F7                    ..
L505F:  lda #$36                                ; 505F A9 36                    .6
        sta CPU_DATA                            ; 5061 85 01                    ..
        jsr WriteBlock                          ; 5063 20 20 C2                   .
        txa                                     ; 5066 8A                       .
        bne L5077                               ; 5067 D0 0E                    ..
        clc                                     ; 5069 18                       .
        lda #$FE                                ; 506A A9 FE                    ..
        adc r7L                                 ; 506C 65 10                    e.
        sta r7L                                 ; 506E 85 10                    ..
        bcc L501E                               ; 5070 90 AC                    ..
        inc r7H                                 ; 5072 E6 11                    ..
        bne L501E                               ; 5074 D0 A8                    ..
L5076:  tax                                     ; 5076 AA                       .
L5077:  pla                                     ; 5077 68                       h
        sta r7L                                 ; 5078 85 10                    ..
        pla                                     ; 507A 68                       h
        sta r7H                                 ; 507B 85 11                    ..
        pla                                     ; 507D 68                       h
        sta r6L                                 ; 507E 85 0E                    ..
        pla                                     ; 5080 68                       h
        sta r6H                                 ; 5081 85 0F                    ..
        jmp DoneWithIO                          ; 5083 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L5086:  lda r9H                                 ; 5086 A5 15                    ..
        pha                                     ; 5088 48                       H
        lda r9L                                 ; 5089 A5 14                    ..
        pha                                     ; 508B 48                       H
        lda r3H                                 ; 508C A5 09                    ..
        pha                                     ; 508E 48                       H
        lda r3L                                 ; 508F A5 08                    ..
        pha                                     ; 5091 48                       H
        lda r2H                                 ; 5092 A5 07                    ..
        pha                                     ; 5094 48                       H
        lda r2L                                 ; 5095 A5 06                    ..
        pha                                     ; 5097 48                       H
        lda r1H                                 ; 5098 A5 05                    ..
        pha                                     ; 509A 48                       H
        lda r1L                                 ; 509B A5 04                    ..
        pha                                     ; 509D 48                       H
        lda r0H                                 ; 509E A5 03                    ..
        pha                                     ; 50A0 48                       H
        lda r0L                                 ; 50A1 A5 02                    ..
        pha                                     ; 50A3 48                       H
        ldx #$02                                ; 50A4 A2 02                    ..
        lda r7H                                 ; 50A6 A5 11                    ..
        sta r9H                                 ; 50A8 85 15                    ..
        lda r7L                                 ; 50AA A5 10                    ..
        sta r9L                                 ; 50AC 85 14                    ..
L50AE:  lda r9H                                 ; 50AE A5 15                    ..
        cmp #$50                                ; 50B0 C9 50                    .P
        bne L50B8                               ; 50B2 D0 04                    ..
        lda r9L                                 ; 50B4 A5 14                    ..
        cmp #$00                                ; 50B6 C9 00                    ..
L50B8:  bcc L50C6                               ; 50B8 90 0C                    ..
        lda r9H                                 ; 50BA A5 15                    ..
        cmp #$51                                ; 50BC C9 51                    .Q
        bne L50C4                               ; 50BE D0 04                    ..
        lda r9L                                 ; 50C0 A5 14                    ..
        cmp #$5F                                ; 50C2 C9 5F                    ._
L50C4:  bcc L50DD                               ; 50C4 90 17                    ..
L50C6:  ldy #$00                                ; 50C6 A0 00                    ..
        lda (r9L),y                             ; 50C8 B1 14                    ..
        sta diskBlkBuf,x                        ; 50CA 9D 00 80                 ...
        clc                                     ; 50CD 18                       .
        lda #$01                                ; 50CE A9 01                    ..
        adc r9L                                 ; 50D0 65 14                    e.
        sta r9L                                 ; 50D2 85 14                    ..
        bcc L50D8                               ; 50D4 90 02                    ..
        inc r9H                                 ; 50D6 E6 15                    ..
L50D8:  inx                                     ; 50D8 E8                       .
        bne L50AE                               ; 50D9 D0 D3                    ..
        beq L5107                               ; 50DB F0 2A                    .*
L50DD:  jsr L5126                               ; 50DD 20 26 51                  &Q
        ldx r0L                                 ; 50E0 A6 02                    ..
L50E2:  clc                                     ; 50E2 18                       .
        lda #$01                                ; 50E3 A9 01                    ..
        adc r9L                                 ; 50E5 65 14                    e.
        sta r9L                                 ; 50E7 85 14                    ..
        bcc L50ED                               ; 50E9 90 02                    ..
        inc r9H                                 ; 50EB E6 15                    ..
L50ED:  inx                                     ; 50ED E8                       .
        beq L5107                               ; 50EE F0 17                    ..
        lda r9H                                 ; 50F0 A5 15                    ..
        cmp #$51                                ; 50F2 C9 51                    .Q
        bne L50FA                               ; 50F4 D0 04                    ..
        lda r9L                                 ; 50F6 A5 14                    ..
        cmp #$5F                                ; 50F8 C9 5F                    ._
L50FA:  bcc L50E2                               ; 50FA 90 E6                    ..
        ldy #$00                                ; 50FC A0 00                    ..
L50FE:  lda (r9L),y                             ; 50FE B1 14                    ..
        sta diskBlkBuf,x                        ; 5100 9D 00 80                 ...
        iny                                     ; 5103 C8                       .
        inx                                     ; 5104 E8                       .
        bne L50FE                               ; 5105 D0 F7                    ..
L5107:  pla                                     ; 5107 68                       h
        sta r0L                                 ; 5108 85 02                    ..
        pla                                     ; 510A 68                       h
        sta r0H                                 ; 510B 85 03                    ..
        pla                                     ; 510D 68                       h
        sta r1L                                 ; 510E 85 04                    ..
        pla                                     ; 5110 68                       h
        sta r1H                                 ; 5111 85 05                    ..
        pla                                     ; 5113 68                       h
        sta r2L                                 ; 5114 85 06                    ..
        pla                                     ; 5116 68                       h
        sta r2H                                 ; 5117 85 07                    ..
        pla                                     ; 5119 68                       h
        sta r3L                                 ; 511A 85 08                    ..
        pla                                     ; 511C 68                       h
        sta r3H                                 ; 511D 85 09                    ..
        pla                                     ; 511F 68                       h
        sta r9L                                 ; 5120 85 14                    ..
        pla                                     ; 5122 68                       h
        sta r9H                                 ; 5123 85 15                    ..
        rts                                     ; 5125 60                       `

; ----------------------------------------------------------------------------
L5126:  sec                                     ; 5126 38                       8
        lda r9L                                 ; 5127 A5 14                    ..
        sbc #$00                                ; 5129 E9 00                    ..
        sta r1L                                 ; 512B 85 04                    ..
        lda r9H                                 ; 512D A5 15                    ..
        sbc #$50                                ; 512F E9 50                    .P
        sta r1H                                 ; 5131 85 05                    ..
        stx r0L                                 ; 5133 86 02                    ..
        lda #$80                                ; 5135 A9 80                    ..
        sta r0H                                 ; 5137 85 03                    ..
        dex                                     ; 5139 CA                       .
        txa                                     ; 513A 8A                       .
        eor #$FF                                ; 513B 49 FF                    I.
        sta r2L                                 ; 513D 85 06                    ..
        lda #$00                                ; 513F A9 00                    ..
        sta r2H                                 ; 5141 85 07                    ..
        clc                                     ; 5143 18                       .
        lda #$7B                                ; 5144 A9 7B                    .{
        adc r1L                                 ; 5146 65 04                    e.
        sta r1L                                 ; 5148 85 04                    ..
        lda #$0D                                ; 514A A9 0D                    ..
        adc r1H                                 ; 514C 65 05                    e.
        sta r1H                                 ; 514E 85 05                    ..
        lda $88C3                               ; 5150 AD C3 88                 ...
        sta r3L                                 ; 5153 85 08                    ..
        inc $88C3                               ; 5155 EE C3 88                 ...
        jsr FetchRAM                            ; 5158 20 CB C2                  ..
        dec $88C3                               ; 515B CE C3 88                 ...
        rts                                     ; 515E 60                       `

; ----------------------------------------------------------------------------
