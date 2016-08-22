; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu6.bin
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
L9036       := $9036
L903C       := $903C
L903F       := $903F
L9048       := $9048
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
        jmp L5006                               ; 5000 4C 06 50                 L.P

; ----------------------------------------------------------------------------
        jmp L51C4                               ; 5003 4C C4 51                 L.Q

; ----------------------------------------------------------------------------
L5006:  lda $88C6                               ; 5006 AD C6 88                 ...
        and #$0F                                ; 5009 29 0F                    ).
        cmp #$04                                ; 500B C9 04                    ..
        bne L5074                               ; 500D D0 65                    .e
        jsr OpenDisk                            ; 500F 20 A1 C2                  ..
        txa                                     ; 5012 8A                       .
        bne L5076                               ; 5013 D0 61                    .a
        lda r1H                                 ; 5015 A5 05                    ..
        sta L511B                               ; 5017 8D 1B 51                 ..Q
        lda r1L                                 ; 501A A5 04                    ..
        sta L511A                               ; 501C 8D 1A 51                 ..Q
        lda r6H                                 ; 501F A5 0F                    ..
        sta L5078                               ; 5021 8D 78 50                 .xP
        lda r6L                                 ; 5024 A5 0E                    ..
        sta L5077                               ; 5026 8D 77 50                 .wP
        jsr FindFile                            ; 5029 20 0B C2                  ..
        txa                                     ; 502C 8A                       .
        bne L5032                               ; 502D D0 03                    ..
        ldx #$05                                ; 502F A2 05                    ..
        rts                                     ; 5031 60                       `

; ----------------------------------------------------------------------------
L5032:  jsr L5092                               ; 5032 20 92 50                  .P
        txa                                     ; 5035 8A                       .
        bne L5076                               ; 5036 D0 3E                    .>
        jsr L5079                               ; 5038 20 79 50                  yP
        txa                                     ; 503B 8A                       .
        bne L5076                               ; 503C D0 38                    .8
        jsr PutDirHead                          ; 503E 20 4A C2                  J.
        txa                                     ; 5041 8A                       .
        bne L5076                               ; 5042 D0 32                    .2
        jsr L50D7                               ; 5044 20 D7 50                  .P
        txa                                     ; 5047 8A                       .
        bne L5076                               ; 5048 D0 2C                    .,
        jsr L513C                               ; 504A 20 3C 51                  <Q
        txa                                     ; 504D 8A                       .
        bne L5076                               ; 504E D0 26                    .&
        lda L5090                               ; 5050 AD 90 50                 ..P
        sta r1L                                 ; 5053 85 04                    ..
        lda L5091                               ; 5055 AD 91 50                 ..P
        sta r1H                                 ; 5058 85 05                    ..
        jsr L903C                               ; 505A 20 3C 90                  <.
        txa                                     ; 505D 8A                       .
        bne L5076                               ; 505E D0 16                    ..
        ldy L508F                               ; 5060 AC 8F 50                 ..P
        ldx #$00                                ; 5063 A2 00                    ..
L5065:  lda dirEntryBuf,x                       ; 5065 BD 00 84                 ...
        sta diskBlkBuf,y                        ; 5068 99 00 80                 ...
        iny                                     ; 506B C8                       .
        inx                                     ; 506C E8                       .
        cpx #$1E                                ; 506D E0 1E                    ..
        bcc L5065                               ; 506F 90 F4                    ..
        jmp PutBlock                            ; 5071 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L5074:  ldx #$0D                                ; 5074 A2 0D                    ..
L5076:  rts                                     ; 5076 60                       `

; ----------------------------------------------------------------------------
L5077:  brk                                     ; 5077 00                       .
L5078:  brk                                     ; 5078 00                       .
L5079:  lda #$00                                ; 5079 A9 00                    ..
        jsr GetFreeDirBlk                       ; 507B 20 F6 C1                  ..
        txa                                     ; 507E 8A                       .
        bne L508E                               ; 507F D0 0D                    ..
        sty L508F                               ; 5081 8C 8F 50                 ..P
        lda r1L                                 ; 5084 A5 04                    ..
        sta L5090                               ; 5086 8D 90 50                 ..P
        lda r1H                                 ; 5089 A5 05                    ..
        sta L5091                               ; 508B 8D 91 50                 ..P
L508E:  rts                                     ; 508E 60                       `

; ----------------------------------------------------------------------------
L508F:  brk                                     ; 508F 00                       .
L5090:  brk                                     ; 5090 00                       .
L5091:  brk                                     ; 5091 00                       .
L5092:  lda #$01                                ; 5092 A9 01                    ..
        sta r6L                                 ; 5094 85 0E                    ..
        lda #$40                                ; 5096 A9 40                    .@
        sta r6H                                 ; 5098 85 0F                    ..
L509A:  jsr FindBAMBit                          ; 509A 20 AD C2                  ..
        bne L50AA                               ; 509D D0 0B                    ..
L509F:  inc r6H                                 ; 509F E6 0F                    ..
        bne L509A                               ; 50A1 D0 F7                    ..
L50A3:  inc r6L                                 ; 50A3 E6 0E                    ..
        bne L509A                               ; 50A5 D0 F3                    ..
        ldx #$03                                ; 50A7 A2 03                    ..
        rts                                     ; 50A9 60                       `

; ----------------------------------------------------------------------------
L50AA:  inc r6H                                 ; 50AA E6 0F                    ..
        beq L50A3                               ; 50AC F0 F5                    ..
        jsr FindBAMBit                          ; 50AE 20 AD C2                  ..
        beq L509F                               ; 50B1 F0 EC                    ..
        lda r6L                                 ; 50B3 A5 0E                    ..
        sta L50D3                               ; 50B5 8D D3 50                 ..P
        sta L50D5                               ; 50B8 8D D5 50                 ..P
        lda r6H                                 ; 50BB A5 0F                    ..
        sta L50D6                               ; 50BD 8D D6 50                 ..P
        dec r6H                                 ; 50C0 C6 0F                    ..
        lda r6H                                 ; 50C2 A5 0F                    ..
        sta L50D4                               ; 50C4 8D D4 50                 ..P
        jsr L9048                               ; 50C7 20 48 90                  H.
        txa                                     ; 50CA 8A                       .
        bne L50D2                               ; 50CB D0 05                    ..
        inc r6H                                 ; 50CD E6 0F                    ..
        jsr L9048                               ; 50CF 20 48 90                  H.
L50D2:  rts                                     ; 50D2 60                       `

; ----------------------------------------------------------------------------
L50D3:  brk                                     ; 50D3 00                       .
L50D4:  brk                                     ; 50D4 00                       .
L50D5:  brk                                     ; 50D5 00                       .
L50D6:  brk                                     ; 50D6 00                       .
L50D7:  jsr i_MoveData                          ; 50D7 20 B7 C1                  ..
        .addrcurDirHead                         ; 50DA 00 82                    ..
        .addrdiskBlkBuf                         ; 50DC 00 80                    ..
; ----------------------------------------------------------------------------
        .word$0100                              ; 50DE 00 01                    ..
; ----------------------------------------------------------------------------
        lda L50D6                               ; 50E0 AD D6 50                 ..P
        sta $8001                               ; 50E3 8D 01 80                 ...
        lda L50D5                               ; 50E6 AD D5 50                 ..P
        sta diskBlkBuf                          ; 50E9 8D 00 80                 ...
        lda L511B                               ; 50EC AD 1B 51                 ..Q
        sta $8023                               ; 50EF 8D 23 80                 .#.
        lda L511A                               ; 50F2 AD 1A 51                 ..Q
        sta $8022                               ; 50F5 8D 22 80                 .".
        lda L5090                               ; 50F8 AD 90 50                 ..P
        sta $8024                               ; 50FB 8D 24 80                 .$.
        lda L5091                               ; 50FE AD 91 50                 ..P
        sta $8025                               ; 5101 8D 25 80                 .%.
        lda L508F                               ; 5104 AD 8F 50                 ..P
        sta $8026                               ; 5107 8D 26 80                 .&.
        jsr L511C                               ; 510A 20 1C 51                  .Q
        lda L50D4                               ; 510D AD D4 50                 ..P
        sta r1H                                 ; 5110 85 05                    ..
        lda L50D3                               ; 5112 AD D3 50                 ..P
        sta r1L                                 ; 5115 85 04                    ..
        jmp L903F                               ; 5117 4C 3F 90                 L?.

; ----------------------------------------------------------------------------
L511A:  brk                                     ; 511A 00                       .
L511B:  brk                                     ; 511B 00                       .
L511C:  jsr L5156                               ; 511C 20 56 51                  VQ
        ldy #$1A                                ; 511F A0 1A                    ..
L5121:  ldx $8004,y                             ; 5121 BE 04 80                 ...
        lda $8090,y                             ; 5124 B9 90 80                 ...
        sta $8004,y                             ; 5127 99 04 80                 ...
        txa                                     ; 512A 8A                       .
        sta $8090,y                             ; 512B 99 90 80                 ...
        dey                                     ; 512E 88                       .
        bpl L5121                               ; 512F 10 F0                    ..
        ldy #$11                                ; 5131 A0 11                    ..
        lda #$00                                ; 5133 A9 00                    ..
L5135:  sta $80AB,y                             ; 5135 99 AB 80                 ...
        dey                                     ; 5138 88                       .
        bpl L5135                               ; 5139 10 FA                    ..
        rts                                     ; 513B 60                       `

; ----------------------------------------------------------------------------
L513C:  lda L50D6                               ; 513C AD D6 50                 ..P
        sta r1H                                 ; 513F 85 05                    ..
        lda L50D5                               ; 5141 AD D5 50                 ..P
        sta r1L                                 ; 5144 85 04                    ..
L5146:  ldy #$00                                ; 5146 A0 00                    ..
        tya                                     ; 5148 98                       .
L5149:  sta diskBlkBuf,y                        ; 5149 99 00 80                 ...
        iny                                     ; 514C C8                       .
        bne L5149                               ; 514D D0 FA                    ..
        dey                                     ; 514F 88                       .
        sty $8001                               ; 5150 8C 01 80                 ...
        jmp L903F                               ; 5153 4C 3F 90                 L?.

; ----------------------------------------------------------------------------
L5156:  lda L5078                               ; 5156 AD 78 50                 .xP
        sta r6H                                 ; 5159 85 0F                    ..
        lda L5077                               ; 515B AD 77 50                 .wP
        sta r6L                                 ; 515E 85 0E                    ..
        ldy #$00                                ; 5160 A0 00                    ..
L5162:  lda (r6L),y                             ; 5162 B1 0E                    ..
        beq L5171                               ; 5164 F0 0B                    ..
        sta $8403,y                             ; 5166 99 03 84                 ...
        sta $8090,y                             ; 5169 99 90 80                 ...
        iny                                     ; 516C C8                       .
        cpy #$10                                ; 516D C0 10                    ..
        bcc L5162                               ; 516F 90 F1                    ..
L5171:  lda #$A0                                ; 5171 A9 A0                    ..
        cpy #$10                                ; 5173 C0 10                    ..
        beq L5180                               ; 5175 F0 09                    ..
        sta $8403,y                             ; 5177 99 03 84                 ...
        sta $8090,y                             ; 517A 99 90 80                 ...
        iny                                     ; 517D C8                       .
        bne L5171                               ; 517E D0 F1                    ..
L5180:  lda #$86                                ; 5180 A9 86                    ..
        sta dirEntryBuf                         ; 5182 8D 00 84                 ...
        lda L50D4                               ; 5185 AD D4 50                 ..P
        sta $8402                               ; 5188 8D 02 84                 ...
        lda L50D3                               ; 518B AD D3 50                 ..P
        sta $8401                               ; 518E 8D 01 84                 ...
        ldy #$03                                ; 5191 A0 03                    ..
        lda #$00                                ; 5193 A9 00                    ..
L5195:  sta $8413,y                             ; 5195 99 13 84                 ...
        dey                                     ; 5198 88                       .
        bpl L5195                               ; 5199 10 FA                    ..
        lda year                                ; 519B AD 16 85                 ...
        sta $8417                               ; 519E 8D 17 84                 ...
        lda month                               ; 51A1 AD 17 85                 ...
        sta $8418                               ; 51A4 8D 18 84                 ...
        lda day                                 ; 51A7 AD 18 85                 ...
        sta $8419                               ; 51AA 8D 19 84                 ...
        lda hour                                ; 51AD AD 19 85                 ...
        sta $841A                               ; 51B0 8D 1A 84                 ...
        lda minutes                             ; 51B3 AD 1A 85                 ...
        sta $841B                               ; 51B6 8D 1B 84                 ...
        lda #$00                                ; 51B9 A9 00                    ..
        sta $841D                               ; 51BB 8D 1D 84                 ...
        lda #$02                                ; 51BE A9 02                    ..
        sta $841C                               ; 51C0 8D 1C 84                 ...
        rts                                     ; 51C3 60                       `

; ----------------------------------------------------------------------------
L51C4:  lda $88C6                               ; 51C4 AD C6 88                 ...
        and #$0F                                ; 51C7 29 0F                    ).
        cmp #$04                                ; 51C9 C9 04                    ..
        beq L51D0                               ; 51CB F0 03                    ..
        ldx #$0D                                ; 51CD A2 0D                    ..
L51CF:  rts                                     ; 51CF 60                       `

; ----------------------------------------------------------------------------
L51D0:  jsr L9036                               ; 51D0 20 36 90                  6.
        txa                                     ; 51D3 8A                       .
        bne L51CF                               ; 51D4 D0 F9                    ..
        bit isGEOS                              ; 51D6 2C 8B 84                 ,..
        bmi L51CF                               ; 51D9 30 F4                    0.
        lda #$01                                ; 51DB A9 01                    ..
        sta r3L                                 ; 51DD 85 08                    ..
        lda #$FE                                ; 51DF A9 FE                    ..
        sta r3H                                 ; 51E1 85 09                    ..
        jsr SetNextFree                         ; 51E3 20 92 C2                  ..
        txa                                     ; 51E6 8A                       .
        bne L51CF                               ; 51E7 D0 E6                    ..
        lda r3H                                 ; 51E9 A5 09                    ..
        sta r1H                                 ; 51EB 85 05                    ..
        sta $82AC                               ; 51ED 8D AC 82                 ...
        lda r3L                                 ; 51F0 A5 08                    ..
        sta r1L                                 ; 51F2 85 04                    ..
        sta $82AB                               ; 51F4 8D AB 82                 ...
        jsr L5146                               ; 51F7 20 46 51                  FQ
        txa                                     ; 51FA 8A                       .
        bne L51CF                               ; 51FB D0 D2                    ..
        ldy #$0F                                ; 51FD A0 0F                    ..
L51FF:  lda L520B,y                             ; 51FF B9 0B 52                 ..R
        sta $82AD,y                             ; 5202 99 AD 82                 ...
        dey                                     ; 5205 88                       .
        bpl L51FF                               ; 5206 10 F7                    ..
        jmp PutDirHead                          ; 5208 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L520B:  .byte"GEOS format V1.1"                 ; 520B 47 45 4F 53 20 66 6F 72  GEOS for
                                                ; 5213 6D 61 74 20 56 31 2E 31  mat V1.1
