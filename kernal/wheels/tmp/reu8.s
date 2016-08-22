; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu8.bin
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
L7940       := $7940
L79B0       := $79B0
L79C9       := $79C9
L7A64       := $7A64
L7AB3       := $7AB3
L7AE1       := $7AE1
L7B38       := $7B38
L7B52       := $7B52
L7B55       := $7B55
L7B90       := $7B90
L7B9E       := $7B9E
L7BAE       := $7BAE
L7BB1       := $7BB1
L7BC7       := $7BC7
L7C41       := $7C41
L7CB3       := $7CB3
L7CB6       := $7CB6
L7CBF       := $7CBF
L7CF4       := $7CF4
L7D02       := $7D02
L7DB6       := $7DB6
L7DF4       := $7DF4
L7E01       := $7E01
L7E0D       := $7E0D
L7E1A       := $7E1A
L7E32       := $7E32
L7E53       := $7E53
L7E74       := $7E74
L7E8B       := $7E8B
L7E94       := $7E94
L7E9B       := $7E9B
L7EB8       := $7EB8
L7F2B       := $7F2B
L7F69       := $7F69
L7F80       := $7F80
L7F96       := $7F96
L7FBA       := $7FBA
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
L903C       := $903C
L903F       := $903F
L9050       := $9050
L9063       := $9063
L9D80       := $9D80
L9D83       := $9D83
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
        lda #$00                                ; 5000 A9 00                    ..
        bit $80A9                               ; 5002 2C A9 80                 ,..
        sta L5087                               ; 5005 8D 87 50                 ..P
        lda r2L                                 ; 5008 A5 06                    ..
        sta L5724                               ; 500A 8D 24 57                 .$W
        lda r3L                                 ; 500D A5 08                    ..
L500F:  sta L5732                               ; 500F 8D 32 57                 .2W
        and #$3F                                ; 5012 29 3F                    )?
        sta L5722                               ; 5014 8D 22 57                 ."W
        .byte$AD                                ; 5017 AD                       .
L5018:  .byte$89                                ; 5018 89                       .
        sty z8d                                 ; 5019 84 8D                    ..
L501B:  and ($57,x)                             ; 501B 21 57                    !W
        .byte$20                                ; 501D 20                        
L501E:  .byte$63                                ; 501E 63                       c
        bcc $4FC6                               ; 501F 90 A5                    ..
L5021:  asl z8d                                 ; 5021 06 8D                    ..
        .byte$23                                ; 5023 23                       #
        .byte$57                                ; 5024 57                       W
        lda $88C6                               ; 5025 AD C6 88                 ...
        and #$0F                                ; 5028 29 0F                    ).
        sta L5725                               ; 502A 8D 25 57                 .%W
        sta L5729                               ; 502D 8D 29 57                 .)W
        lda $9062                               ; 5030 AD 62 90                 .b.
        sta L5727                               ; 5033 8D 27 57                 .'W
        lda $8203                               ; 5036 AD 03 82                 ...
        sta L572D                               ; 5039 8D 2D 57                 .-W
        jsr i_MoveData                          ; 503C 20 B7 C1                  ..
        .addrL5048                              ; 503F 48 50                    HP
        .addrPRINTBASE                          ; 5041 00 79                    .y
; ----------------------------------------------------------------------------
        .word$06EB                              ; 5043 EB 06                    ..
; ----------------------------------------------------------------------------
        jmp PRINTBASE                           ; 5045 4C 00 79                 L.y

; ----------------------------------------------------------------------------
L5048:  lda #$00                                ; 5048 A9 00                    ..
        sta $7B8F                               ; 504A 8D 8F 7B                 ..{
        sta $79A8                               ; 504D 8D A8 79                 ..y
        jsr L9D83                               ; 5050 20 83 9D                  ..
        lda #$45                                ; 5053 A9 45                    .E
        jsr L9D80                               ; 5055 20 80 9D                  ..
        jsr L79C9                               ; 5058 20 C9 79                  .y
        txa                                     ; 505B 8A                       .
        bne L5071                               ; 505C D0 13                    ..
        bit $793F                               ; 505E 2C 3F 79                 ,?y
        bmi L5071                               ; 5061 30 0E                    0.
        jsr L9D83                               ; 5063 20 83 9D                  ..
        jsr L7940                               ; 5066 20 40 79                  @y
        lda #$45                                ; 5069 A9 45                    .E
        jsr L9D80                               ; 506B 20 80 9D                  ..
        jsr L7BC7                               ; 506E 20 C7 7B                  .{
L5071:  txa                                     ; 5071 8A                       .
        pha                                     ; 5072 48                       H
        jsr L7B52                               ; 5073 20 52 7B                  R{
        jsr OpenDisk                            ; 5076 20 A1 C2                  ..
        jsr L9D83                               ; 5079 20 83 9D                  ..
        jsr L79B0                               ; 507C 20 B0 79                  .y
        lda #$48                                ; 507F A9 48                    .H
        jsr L9D80                               ; 5081 20 80 9D                  ..
        pla                                     ; 5084 68                       h
        tax                                     ; 5085 AA                       .
        rts                                     ; 5086 60                       `

; ----------------------------------------------------------------------------
L5087:  brk                                     ; 5087 00                       .
        lda $7FDE                               ; 5088 AD DE 7F                 ...
        bpl L508E                               ; 508B 10 01                    ..
L508D:  rts                                     ; 508D 60                       `

; ----------------------------------------------------------------------------
L508E:  and #$F0                                ; 508E 29 F0                    ).
        cmp #$30                                ; 5090 C9 30                    .0
        beq L508D                               ; 5092 F0 F9                    ..
        lda $7FDD                               ; 5094 AD DD 7F                 ...
        bmi L508D                               ; 5097 30 F4                    0.
        and #$F0                                ; 5099 29 F0                    ).
        cmp #$30                                ; 509B C9 30                    .0
        beq L508D                               ; 509D F0 EE                    ..
        lda #$40                                ; 509F A9 40                    .@
        jsr L9D80                               ; 50A1 20 80 9D                  ..
        jsr L500F                               ; 50A4 20 0F 50                  .P
        lda r2L                                 ; 50A7 A5 06                    ..
        beq L50E8                               ; 50A9 F0 3D                    .=
        bpl L50AF                               ; 50AB 10 02                    ..
        lda #$80                                ; 50AD A9 80                    ..
L50AF:  sta $79A8                               ; 50AF 8D A8 79                 ..y
        ldy #$01                                ; 50B2 A0 01                    ..
L50B4:  jsr L501E                               ; 50B4 20 1E 50                  .P
        lda r3L                                 ; 50B7 A5 08                    ..
        beq L50C2                               ; 50B9 F0 07                    ..
        iny                                     ; 50BB C8                       .
        cpy #$09                                ; 50BC C0 09                    ..
        bcc L50B4                               ; 50BE 90 F4                    ..
        bcs L50E8                               ; 50C0 B0 26                    .&
L50C2:  lda $79A8                               ; 50C2 AD A8 79                 ..y
        sta r2L                                 ; 50C5 85 06                    ..
        lda #$5D                                ; 50C7 A9 5D                    .]
        sta r7L                                 ; 50C9 85 10                    ..
        lda #$79                                ; 50CB A9 79                    .y
        sta r0H                                 ; 50CD 85 03                    ..
        lda #$AB                                ; 50CF A9 AB                    ..
        sta r0L                                 ; 50D1 85 02                    ..
        ldy #$00                                ; 50D3 A0 00                    ..
        sty r3L                                 ; 50D5 84 08                    ..
        jsr L5018                               ; 50D7 20 18 50                  .P
        txa                                     ; 50DA 8A                       .
        bne L50E8                               ; 50DB D0 0B                    ..
        lda r3L                                 ; 50DD A5 08                    ..
        sta $79A9                               ; 50DF 8D A9 79                 ..y
        sty $79AA                               ; 50E2 8C AA 79                 ..y
        jmp L9D83                               ; 50E5 4C 83 9D                 L..

; ----------------------------------------------------------------------------
L50E8:  lda #$00                                ; 50E8 A9 00                    ..
        sta $79A8                               ; 50EA 8D A8 79                 ..y
        jmp L9D83                               ; 50ED 4C 83 9D                 L..

; ----------------------------------------------------------------------------
        brk                                     ; 50F0 00                       .
        brk                                     ; 50F1 00                       .
        brk                                     ; 50F2 00                       .
        .byte$44                                ; 50F3 44                       D
        .byte$43                                ; 50F4 43                       C
        and $38,y                               ; 50F5 39 38 00                 98.
        bit $793F                               ; 50F8 2C 3F 79                 ,?y
        bpl L50FE                               ; 50FB 10 01                    ..
L50FD:  rts                                     ; 50FD 60                       `

; ----------------------------------------------------------------------------
L50FE:  lda $79A8                               ; 50FE AD A8 79                 ..y
        beq L50FD                               ; 5101 F0 FA                    ..
        lda #$40                                ; 5103 A9 40                    .@
        jsr L9D80                               ; 5105 20 80 9D                  ..
        ldy $79AA                               ; 5108 AC AA 79                 ..y
        jsr L501B                               ; 510B 20 1B 50                  .P
        jmp L9D83                               ; 510E 4C 83 9D                 L..

; ----------------------------------------------------------------------------
        lda #$01                                ; 5111 A9 01                    ..
        sta $7B8F                               ; 5113 8D 8F 7B                 ..{
        lda $7FDA                               ; 5116 AD DA 7F                 ...
        jsr SetDevice                           ; 5119 20 B0 C2                  ..
        bne L513E                               ; 511C D0 20                    . 
        bit $7FEA                               ; 511E 2C EA 7F                 ,..
        bvc L5151                               ; 5121 50 2E                    P.
        lda $88C6                               ; 5123 AD C6 88                 ...
        and #$F0                                ; 5126 29 F0                    ).
        beq L5139                               ; 5128 F0 0F                    ..
        cmp #$10                                ; 512A C9 10                    ..
        beq L5139                               ; 512C F0 0B                    ..
        lda $7FEA                               ; 512E AD EA 7F                 ...
        and #$BF                                ; 5131 29 BF                    ).
        sta $7FEA                               ; 5133 8D EA 7F                 ...
        clv                                     ; 5136 B8                       .
        bvc L5151                               ; 5137 50 18                    P.
L5139:  jsr L7B90                               ; 5139 20 90 7B                  .{
        beq L513F                               ; 513C F0 01                    ..
L513E:  rts                                     ; 513E 60                       `

; ----------------------------------------------------------------------------
L513F:  lda $88C6                               ; 513F AD C6 88                 ...
        and #$F0                                ; 5142 29 F0                    ).
        beq L5151                               ; 5144 F0 0B                    ..
        jsr L501E                               ; 5146 20 1E 50                  .P
        jsr L9063                               ; 5149 20 63 90                  c.
        lda r2L                                 ; 514C A5 06                    ..
        sta $7FDC                               ; 514E 8D DC 7F                 ...
L5151:  jsr EnterTurbo                          ; 5151 20 14 C2                  ..
        ldx $7FDC                               ; 5154 AE DC 7F                 ...
        jsr L5018                               ; 5157 20 18 50                  .P
        txa                                     ; 515A 8A                       .
        bne L51AB                               ; 515B D0 4E                    .N
        jsr L9050                               ; 515D 20 50 90                  P.
        txa                                     ; 5160 8A                       .
        bne L51AB                               ; 5161 D0 48                    .H
        lda $8203                               ; 5163 AD 03 82                 ...
        sta $7FE6                               ; 5166 8D E6 7F                 ...
        lda $88C6                               ; 5169 AD C6 88                 ...
        and #$0F                                ; 516C 29 0F                    ).
        sta $7FDE                               ; 516E 8D DE 7F                 ...
        cmp $7FDD                               ; 5171 CD DD 7F                 ...
        bne L5179                               ; 5174 D0 03                    ..
        jmp L7A64                               ; 5176 4C 64 7A                 Ldz

; ----------------------------------------------------------------------------
L5179:  cmp #$03                                ; 5179 C9 03                    ..
        bcs L51A6                               ; 517B B0 29                    .)
        lda $7FDD                               ; 517D AD DD 7F                 ...
        cmp #$03                                ; 5180 C9 03                    ..
        bcs L51A6                               ; 5182 B0 22                    ."
        cmp #$01                                ; 5184 C9 01                    ..
        bne L518F                               ; 5186 D0 07                    ..
        lda $7FE5                               ; 5188 AD E5 7F                 ...
        bmi L51A6                               ; 518B 30 19                    0.
        bpl L519E                               ; 518D 10 0F                    ..
L518F:  lda $7FE6                               ; 518F AD E6 7F                 ...
        bmi L51A6                               ; 5192 30 12                    0.
        lda $7FE5                               ; 5194 AD E5 7F                 ...
        bpl L519E                               ; 5197 10 05                    ..
        jsr L7AB3                               ; 5199 20 B3 7A                  .z
        bne L51A9                               ; 519C D0 0B                    ..
L519E:  lda #$01                                ; 519E A9 01                    ..
        sta $7FE1                               ; 51A0 8D E1 7F                 ...
        ldx #$00                                ; 51A3 A2 00                    ..
        rts                                     ; 51A5 60                       `

; ----------------------------------------------------------------------------
L51A6:  ldx #$73                                ; 51A6 A2 73                    .s
        rts                                     ; 51A8 60                       `

; ----------------------------------------------------------------------------
L51A9:  ldx #$03                                ; 51A9 A2 03                    ..
L51AB:  rts                                     ; 51AB 60                       `

; ----------------------------------------------------------------------------
        lda $7FE1                               ; 51AC AD E1 7F                 ...
        cmp #$03                                ; 51AF C9 03                    ..
        beq L51F2                               ; 51B1 F0 3F                    .?
        cmp #$04                                ; 51B3 C9 04                    ..
        bne L51C9                               ; 51B5 D0 12                    ..
        lda $9062                               ; 51B7 AD 62 90                 .b.
        sta $7FE0                               ; 51BA 8D E0 7F                 ...
        cmp $7FDF                               ; 51BD CD DF 7F                 ...
        bcs L51F2                               ; 51C0 B0 30                    .0
        jsr L7AE1                               ; 51C2 20 E1 7A                  .z
        bne L51F8                               ; 51C5 D0 31                    .1
        beq L51F2                               ; 51C7 F0 29                    .)
L51C9:  cmp #$01                                ; 51C9 C9 01                    ..
        bne L51D7                               ; 51CB D0 0A                    ..
        lda $7FE5                               ; 51CD AD E5 7F                 ...
        ora $7FE6                               ; 51D0 0D E6 7F                 ...
        bmi L51F5                               ; 51D3 30 20                    0 
        bpl L51EA                               ; 51D5 10 13                    ..
L51D7:  cmp #$02                                ; 51D7 C9 02                    ..
        bne L51F5                               ; 51D9 D0 1A                    ..
        lda $7FE5                               ; 51DB AD E5 7F                 ...
        bpl L51EA                               ; 51DE 10 0A                    ..
        lda $7FE6                               ; 51E0 AD E6 7F                 ...
        bmi L51ED                               ; 51E3 30 08                    0.
        jsr L7AB3                               ; 51E5 20 B3 7A                  .z
        bne L51F8                               ; 51E8 D0 0E                    ..
L51EA:  lda #$01                                ; 51EA A9 01                    ..
        .byte$2C                                ; 51EC 2C                       ,
L51ED:  lda #$02                                ; 51ED A9 02                    ..
        sta $7FE1                               ; 51EF 8D E1 7F                 ...
L51F2:  ldx #$00                                ; 51F2 A2 00                    ..
        rts                                     ; 51F4 60                       `

; ----------------------------------------------------------------------------
L51F5:  ldx #$73                                ; 51F5 A2 73                    .s
        rts                                     ; 51F7 60                       `

; ----------------------------------------------------------------------------
L51F8:  ldx #$03                                ; 51F8 A2 03                    ..
        rts                                     ; 51FA 60                       `

; ----------------------------------------------------------------------------
        jsr L7B52                               ; 51FB 20 52 7B                  R{
        jsr GetDirHead                          ; 51FE 20 47 C2                  G.
        lda #$24                                ; 5201 A9 24                    .$
        sta r1L                                 ; 5203 85 04                    ..
        lda #$00                                ; 5205 A9 00                    ..
        sta r1H                                 ; 5207 85 05                    ..
L5209:  lda r1H                                 ; 5209 A5 05                    ..
        sta r6H                                 ; 520B 85 0F                    ..
        lda r1L                                 ; 520D A5 04                    ..
        sta r6L                                 ; 520F 85 0E                    ..
        jsr FindBAMBit                          ; 5211 20 AD C2                  ..
        beq L5226                               ; 5214 F0 10                    ..
L5216:  jsr L7E74                               ; 5216 20 74 7E                  t~
        lda r1L                                 ; 5219 A5 04                    ..
        cmp #$35                                ; 521B C9 35                    .5
        beq L5216                               ; 521D F0 F7                    ..
        cmp #$47                                ; 521F C9 47                    .G
        bcc L5209                               ; 5221 90 E6                    ..
        ldx #$00                                ; 5223 A2 00                    ..
        rts                                     ; 5225 60                       `

; ----------------------------------------------------------------------------
L5226:  ldx #$06                                ; 5226 A2 06                    ..
        rts                                     ; 5228 60                       `

; ----------------------------------------------------------------------------
        jsr L7B52                               ; 5229 20 52 7B                  R{
        lda #$01                                ; 522C A9 01                    ..
        sta r1L                                 ; 522E 85 04                    ..
        lda $7FDF                               ; 5230 AD DF 7F                 ...
        jsr L7B38                               ; 5233 20 38 7B                  8{
        sty $7FE8                               ; 5236 8C E8 7F                 ...
        clc                                     ; 5239 18                       .
        adc #$02                                ; 523A 69 02                    i.
        sta $7FE7                               ; 523C 8D E7 7F                 ...
        lda $7FE0                               ; 523F AD E0 7F                 ...
        jsr L7B38                               ; 5242 20 38 7B                  8{
        sty $7FE9                               ; 5245 8C E9 7F                 ...
        clc                                     ; 5248 18                       .
        adc #$02                                ; 5249 69 02                    i.
        sta r1H                                 ; 524B 85 05                    ..
        jsr L903C                               ; 524D 20 3C 90                  <.
        txa                                     ; 5250 8A                       .
        bne L527F                               ; 5251 D0 2C                    .,
L5253:  ldy $7FE9                               ; 5253 AC E9 7F                 ...
        lda diskBlkBuf,y                        ; 5256 B9 00 80                 ...
        cmp #$FF                                ; 5259 C9 FF                    ..
        bne L527D                               ; 525B D0 20                    . 
        iny                                     ; 525D C8                       .
        sty $7FE9                               ; 525E 8C E9 7F                 ...
        bne L526B                               ; 5261 D0 08                    ..
        inc r1H                                 ; 5263 E6 05                    ..
        jsr L903C                               ; 5265 20 3C 90                  <.
        txa                                     ; 5268 8A                       .
        bne L527F                               ; 5269 D0 14                    ..
L526B:  lda r1H                                 ; 526B A5 05                    ..
        cmp $7FE7                               ; 526D CD E7 7F                 ...
        bcc L5253                               ; 5270 90 E1                    ..
        lda $7FE9                               ; 5272 AD E9 7F                 ...
        cmp $7FE8                               ; 5275 CD E8 7F                 ...
        bcc L5253                               ; 5278 90 D9                    ..
        ldx #$00                                ; 527A A2 00                    ..
        rts                                     ; 527C 60                       `

; ----------------------------------------------------------------------------
L527D:  ldx #$03                                ; 527D A2 03                    ..
L527F:  rts                                     ; 527F 60                       `

; ----------------------------------------------------------------------------
        ldx #$00                                ; 5280 A2 00                    ..
        stx r1H                                 ; 5282 86 05                    ..
        clc                                     ; 5284 18                       .
        adc #$01                                ; 5285 69 01                    i.
        asl a                                   ; 5287 0A                       .
        rol r1H                                 ; 5288 26 05                    &.
        asl a                                   ; 528A 0A                       .
        rol r1H                                 ; 528B 26 05                    &.
        asl a                                   ; 528D 0A                       .
        rol r1H                                 ; 528E 26 05                    &.
        asl a                                   ; 5290 0A                       .
        rol r1H                                 ; 5291 26 05                    &.
        asl a                                   ; 5293 0A                       .
        rol r1H                                 ; 5294 26 05                    &.
        tay                                     ; 5296 A8                       .
        lda r1H                                 ; 5297 A5 05                    ..
        rts                                     ; 5299 60                       `

; ----------------------------------------------------------------------------
        ldx #$00                                ; 529A A2 00                    ..
        bit $01A2                               ; 529C 2C A2 01                 ,..
        cpx $7B8F                               ; 529F EC 8F 7B                 ..{
        beq L52D3                               ; 52A2 F0 2F                    ./
        stx $7B8F                               ; 52A4 8E 8F 7B                 ..{
        lda $7FD9,x                             ; 52A7 BD D9 7F                 ...
        jsr SetDevice                           ; 52AA 20 B0 C2                  ..
        bne L52D5                               ; 52AD D0 26                    .&
        lda $7FD9                               ; 52AF AD D9 7F                 ...
        cmp $7FDA                               ; 52B2 CD DA 7F                 ...
        bne L52C6                               ; 52B5 D0 0F                    ..
        jsr L7B90                               ; 52B7 20 90 7B                  .{
        bne L52D5                               ; 52BA D0 19                    ..
        ldx $7B8F                               ; 52BC AE 8F 7B                 ..{
        lda $7FDB,x                             ; 52BF BD DB 7F                 ...
        tax                                     ; 52C2 AA                       .
        jsr L5018                               ; 52C3 20 18 50                  .P
L52C6:  jsr EnterTurbo                          ; 52C6 20 14 C2                  ..
        lda $88C6                               ; 52C9 AD C6 88                 ...
        cmp #$03                                ; 52CC C9 03                    ..
        bcs L52D3                               ; 52CE B0 03                    ..
        jsr NewDisk                             ; 52D0 20 E1 C1                  ..
L52D3:  ldx #$00                                ; 52D3 A2 00                    ..
L52D5:  txa                                     ; 52D5 8A                       .
        rts                                     ; 52D6 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 52D7 00                       .
        bit $7FEA                               ; 52D8 2C EA 7F                 ,..
        bvc L52E3                               ; 52DB 50 06                    P.
        ldx $7B8F                               ; 52DD AE 8F 7B                 ..{
        jmp L5021                               ; 52E0 4C 21 50                 L!P

; ----------------------------------------------------------------------------
L52E3:  ldx #$00                                ; 52E3 A2 00                    ..
        rts                                     ; 52E5 60                       `

; ----------------------------------------------------------------------------
        ldx #$00                                ; 52E6 A2 00                    ..
        lda #$7F                                ; 52E8 A9 7F                    ..
        sta $DC00                               ; 52EA 8D 00 DC                 ...
        bit $DC01                               ; 52ED 2C 01 DC                 ,..
        bmi L52F4                               ; 52F0 30 02                    0.
        ldx #$0C                                ; 52F2 A2 0C                    ..
L52F4:  txa                                     ; 52F4 8A                       .
        rts                                     ; 52F5 60                       `

; ----------------------------------------------------------------------------
        ldy #$90                                ; 52F6 A0 90                    ..
        bit $91A0                               ; 52F8 2C A0 91                 ,..
        ldx #$06                                ; 52FB A2 06                    ..
L52FD:  lda $7BC0,x                             ; 52FD BD C0 7B                 ..{
        sta r0L,x                               ; 5300 95 02                    ..
        dex                                     ; 5302 CA                       .
        bpl L52FD                               ; 5303 10 F8                    ..
        jmp DoRAMOp                             ; 5305 4C D4 C2                 L..

; ----------------------------------------------------------------------------
        .byte$00,$10,$00,$C8,$00,$36,$00        ; 5308 00 10 00 C8 00 36 00     .....6.
; ----------------------------------------------------------------------------
        lda $7FE1                               ; 530F AD E1 7F                 ...
        cmp #$01                                ; 5312 C9 01                    ..
        beq L5330                               ; 5314 F0 1A                    ..
        cmp #$02                                ; 5316 C9 02                    ..
        beq L532D                               ; 5318 F0 13                    ..
        cmp #$03                                ; 531A C9 03                    ..
        beq L532A                               ; 531C F0 0C                    ..
        lda $7FDF                               ; 531E AD DF 7F                 ...
        cmp $7FE0                               ; 5321 CD E0 7F                 ...
        bcc L5329                               ; 5324 90 03                    ..
        lda $7FE0                               ; 5326 AD E0 7F                 ...
L5329:  .byte$2C                                ; 5329 2C                       ,
L532A:  lda #$50                                ; 532A A9 50                    .P
        .byte$2C                                ; 532C 2C                       ,
L532D:  lda #$46                                ; 532D A9 46                    .F
        .byte$2C                                ; 532F 2C                       ,
L5330:  lda #$23                                ; 5330 A9 23                    .#
        sta $7FE4                               ; 5332 8D E4 7F                 ...
        ldx #$00                                ; 5335 A2 00                    ..
        stx $7FE3                               ; 5337 8E E3 7F                 ...
        inx                                     ; 533A E8                       .
        stx $7FE2                               ; 533B 8E E2 7F                 ...
        jsr L7BAE                               ; 533E 20 AE 7B                  .{
        ldx $79A8                               ; 5341 AE A8 79                 ..y
        beq L5347                               ; 5344 F0 01                    ..
        dex                                     ; 5346 CA                       .
L5347:  stx $7FD6                               ; 5347 8E D6 7F                 ...
        jsr L7B52                               ; 534A 20 52 7B                  R{
        jsr GetDirHead                          ; 534D 20 47 C2                  G.
        txa                                     ; 5350 8A                       .
        bne L537B                               ; 5351 D0 28                    .(
L5353:  jsr L7B52                               ; 5353 20 52 7B                  R{
        bne L537B                               ; 5356 D0 23                    .#
        jsr L7D02                               ; 5358 20 02 7D                  .}
        bne L537B                               ; 535B D0 1E                    ..
        lda $7C40                               ; 535D AD 40 7C                 .@|
        beq L5379                               ; 5360 F0 17                    ..
        jsr L7B55                               ; 5362 20 55 7B                  U{
        bne L537B                               ; 5365 D0 14                    ..
        jsr L7EB8                               ; 5367 20 B8 7E                  .~
        bne L537B                               ; 536A D0 0F                    ..
        lda $7FE2                               ; 536C AD E2 7F                 ...
        beq L5379                               ; 536F F0 08                    ..
        lda $7FE4                               ; 5371 AD E4 7F                 ...
        cmp $7FE2                               ; 5374 CD E2 7F                 ...
        bcs L5353                               ; 5377 B0 DA                    ..
L5379:  lda #$00                                ; 5379 A9 00                    ..
L537B:  pha                                     ; 537B 48                       H
        tax                                     ; 537C AA                       .
        bne L5382                               ; 537D D0 03                    ..
        jsr L7C41                               ; 537F 20 41 7C                  A|
L5382:  jsr L7BB1                               ; 5382 20 B1 7B                  .{
        pla                                     ; 5385 68                       h
        tax                                     ; 5386 AA                       .
        rts                                     ; 5387 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 5388 00                       .
        jsr L7B55                               ; 5389 20 55 7B                  U{
        lda $7FE1                               ; 538C AD E1 7F                 ...
        cmp #$04                                ; 538F C9 04                    ..
        beq L53E4                               ; 5391 F0 51                    .Q
        cmp #$03                                ; 5393 C9 03                    ..
        beq L53F8                               ; 5395 F0 61                    .a
        cmp #$02                                ; 5397 C9 02                    ..
        beq L53F8                               ; 5399 F0 5D                    .]
        lda $7FE6                               ; 539B AD E6 7F                 ...
        ora $7FE5                               ; 539E 0D E5 7F                 ...
        bpl L53F8                               ; 53A1 10 55                    .U
        lda #$12                                ; 53A3 A9 12                    ..
        sta r1L                                 ; 53A5 85 04                    ..
        lda #$00                                ; 53A7 A9 00                    ..
        sta r1H                                 ; 53A9 85 05                    ..
        jsr L903C                               ; 53AB 20 3C 90                  <.
        lda $7FE6                               ; 53AE AD E6 7F                 ...
        sta $8003                               ; 53B1 8D 03 80                 ...
        bmi L53BE                               ; 53B4 30 08                    0.
        ldy #$BE                                ; 53B6 A0 BE                    ..
        jsr L7CB3                               ; 53B8 20 B3 7C                  .|
        jmp L903F                               ; 53BB 4C 3F 90                 L?.

; ----------------------------------------------------------------------------
L53BE:  ldy #$01                                ; 53BE A0 01                    ..
        ldx #$03                                ; 53C0 A2 03                    ..
L53C2:  lda $7EB0,x                             ; 53C2 BD B0 7E                 ..~
        sta $80DC,y                             ; 53C5 99 DC 80                 ...
        iny                                     ; 53C8 C8                       .
        tya                                     ; 53C9 98                       .
        cmp $7EAC,x                             ; 53CA DD AC 7E                 ..~
        bcc L53C2                               ; 53CD 90 F3                    ..
        dex                                     ; 53CF CA                       .
        bpl L53C2                               ; 53D0 10 F0                    ..
        lda #$00                                ; 53D2 A9 00                    ..
        sta $80EE                               ; 53D4 8D EE 80                 ...
        jsr L903F                               ; 53D7 20 3F 90                  ?.
        jsr L7CBF                               ; 53DA 20 BF 7C                  .|
        lda #$35                                ; 53DD A9 35                    .5
        sta r1L                                 ; 53DF 85 04                    ..
        jmp L903F                               ; 53E1 4C 3F 90                 L?.

; ----------------------------------------------------------------------------
L53E4:  lda #$01                                ; 53E4 A9 01                    ..
        sta r1L                                 ; 53E6 85 04                    ..
        lda #$02                                ; 53E8 A9 02                    ..
        sta r1H                                 ; 53EA 85 05                    ..
        jsr L903C                               ; 53EC 20 3C 90                  <.
        lda $7FE0                               ; 53EF AD E0 7F                 ...
        sta $8008                               ; 53F2 8D 08 80                 ...
        jmp L903F                               ; 53F5 4C 3F 90                 L?.

; ----------------------------------------------------------------------------
L53F8:  ldx #$00                                ; 53F8 A2 00                    ..
        rts                                     ; 53FA 60                       `

; ----------------------------------------------------------------------------
        lda #$00                                ; 53FB A9 00                    ..
        bit $FFA9                               ; 53FD 2C A9 FF                 ,..
L5400:  sta diskBlkBuf,y                        ; 5400 99 00 80                 ...
        iny                                     ; 5403 C8                       .
        bne L5400                               ; 5404 D0 FA                    ..
        rts                                     ; 5406 60                       `

; ----------------------------------------------------------------------------
        ldy #$00                                ; 5407 A0 00                    ..
        jsr L7CB6                               ; 5409 20 B6 7C                  .|
        ldy #$69                                ; 540C A0 69                    .i
        jsr L7CB3                               ; 540E 20 B3 7C                  .|
        ldy #$02                                ; 5411 A0 02                    ..
        ldx #$11                                ; 5413 A2 11                    ..
        lda #$1F                                ; 5415 A9 1F                    ..
        jsr L7CF4                               ; 5417 20 F4 7C                  .|
        ldx #$07                                ; 541A A2 07                    ..
        lda #$07                                ; 541C A9 07                    ..
        jsr L7CF4                               ; 541E 20 F4 7C                  .|
        ldx #$06                                ; 5421 A2 06                    ..
        lda #$03                                ; 5423 A9 03                    ..
        jsr L7CF4                               ; 5425 20 F4 7C                  .|
        ldx #$05                                ; 5428 A2 05                    ..
        lda #$01                                ; 542A A9 01                    ..
        jsr L7CF4                               ; 542C 20 F4 7C                  .|
        lda #$00                                ; 542F A9 00                    ..
        ldy #$33                                ; 5431 A0 33                    .3
L5433:  sta diskBlkBuf,y                        ; 5433 99 00 80                 ...
        iny                                     ; 5436 C8                       .
        cpy #$36                                ; 5437 C0 36                    .6
        bcc L5433                               ; 5439 90 F8                    ..
        rts                                     ; 543B 60                       `

; ----------------------------------------------------------------------------
L543C:  sta diskBlkBuf,y                        ; 543C 99 00 80                 ...
        pha                                     ; 543F 48                       H
        tya                                     ; 5440 98                       .
        clc                                     ; 5441 18                       .
        adc #$03                                ; 5442 69 03                    i.
        tay                                     ; 5444 A8                       .
        pla                                     ; 5445 68                       h
        dex                                     ; 5446 CA                       .
        bne L543C                               ; 5447 D0 F3                    ..
        rts                                     ; 5449 60                       `

; ----------------------------------------------------------------------------
        jsr InitForIO                           ; 544A 20 5C C2                  \.
        ldy #$00                                ; 544D A0 00                    ..
        sty $7FD8                               ; 544F 8C D8 7F                 ...
        sty $7C40                               ; 5452 8C 40 7C                 .@|
        sty $7F67                               ; 5455 8C 67 7F                 .g.
        sty $7F68                               ; 5458 8C 68 7F                 .h.
        sty $7FD4                               ; 545B 8C D4 7F                 ...
        sty $7FD5                               ; 545E 8C D5 7F                 ...
        lda $79A8                               ; 5461 AD A8 79                 ..y
        bne L5497                               ; 5464 D0 31                    .1
        lda #$12                                ; 5466 A9 12                    ..
        sta $7FD7                               ; 5468 8D D7 7F                 ...
        jsr L7DF4                               ; 546B 20 F4 7D                  .}
L546E:  jsr L7B9E                               ; 546E 20 9E 7B                  .{
        bne L5492                               ; 5471 D0 1F                    ..
        lda $7FE3                               ; 5473 AD E3 7F                 ...
        sta r1H                                 ; 5476 85 05                    ..
        lda $7FE2                               ; 5478 AD E2 7F                 ...
        sta r1L                                 ; 547B 85 04                    ..
        beq L5490                               ; 547D F0 11                    ..
        lda $7FE4                               ; 547F AD E4 7F                 ...
        cmp r1L                                 ; 5482 C5 04                    ..
        bcc L5490                               ; 5484 90 0A                    ..
        jsr L7DB6                               ; 5486 20 B6 7D                  .}
        lda $7FD7                               ; 5489 AD D7 7F                 ...
        cmp #$46                                ; 548C C9 46                    .F
        bcc L546E                               ; 548E 90 DE                    ..
L5490:  ldx #$00                                ; 5490 A2 00                    ..
L5492:  jsr DoneWithIO                          ; 5492 20 5F C2                  _.
        txa                                     ; 5495 8A                       .
        rts                                     ; 5496 60                       `

; ----------------------------------------------------------------------------
L5497:  ldy #$00                                ; 5497 A0 00                    ..
        sty $7FD8                               ; 5499 8C D8 7F                 ...
        jsr L7DF4                               ; 549C 20 F4 7D                  .}
L549F:  lda #$12                                ; 549F A9 12                    ..
        sta $7FD7                               ; 54A1 8D D7 7F                 ...
L54A4:  jsr L7B9E                               ; 54A4 20 9E 7B                  .{
        bne L54F9                               ; 54A7 D0 50                    .P
        lda $7FE3                               ; 54A9 AD E3 7F                 ...
        sta r1H                                 ; 54AC 85 05                    ..
        lda $7FE2                               ; 54AE AD E2 7F                 ...
        sta r1L                                 ; 54B1 85 04                    ..
        jsr L7DB6                               ; 54B3 20 B6 7D                  .}
        bne L54F9                               ; 54B6 D0 41                    .A
        tax                                     ; 54B8 AA                       .
        beq L54C9                               ; 54B9 F0 0E                    ..
        lda $7FE4                               ; 54BB AD E4 7F                 ...
        cmp r1L                                 ; 54BE C5 04                    ..
        bcc L54C9                               ; 54C0 90 07                    ..
        lda $7FD7                               ; 54C2 AD D7 7F                 ...
        cmp #$32                                ; 54C5 C9 32                    .2
        bcc L54A4                               ; 54C7 90 DB                    ..
L54C9:  jsr L7E1A                               ; 54C9 20 1A 7E                  .~
        inc $7F67                               ; 54CC EE 67 7F                 .g.
        bne L54DB                               ; 54CF D0 0A                    ..
        inc $7F68                               ; 54D1 EE 68 7F                 .h.
        lda $7F68                               ; 54D4 AD 68 7F                 .h.
        cmp #$04                                ; 54D7 C9 04                    ..
        beq L54F7                               ; 54D9 F0 1C                    ..
L54DB:  lda $7FE4                               ; 54DB AD E4 7F                 ...
        cmp $7FE2                               ; 54DE CD E2 7F                 ...
        bcc L54F7                               ; 54E1 90 14                    ..
        lda $7FD6                               ; 54E3 AD D6 7F                 ...
        beq L54F2                               ; 54E6 F0 0A                    ..
        lda $7FD5                               ; 54E8 AD D5 7F                 ...
        cmp $7FD6                               ; 54EB CD D6 7F                 ...
        bcc L5497                               ; 54EE 90 A7                    ..
        bcs L54F7                               ; 54F0 B0 05                    ..
L54F2:  lda $7FD8                               ; 54F2 AD D8 7F                 ...
        bne L549F                               ; 54F5 D0 A8                    ..
L54F7:  ldx #$00                                ; 54F7 A2 00                    ..
L54F9:  jsr DoneWithIO                          ; 54F9 20 5F C2                  _.
        txa                                     ; 54FC 8A                       .
        rts                                     ; 54FD 60                       `

; ----------------------------------------------------------------------------
        lda $7FD7                               ; 54FE AD D7 7F                 ...
        sta r4H                                 ; 5501 85 0B                    ..
        lda #$00                                ; 5503 A9 00                    ..
        sta r4L                                 ; 5505 85 0A                    ..
        jsr ReadBlock                           ; 5507 20 1A C2                  ..
        inc $7FD7                               ; 550A EE D7 7F                 ...
        txa                                     ; 550D 8A                       .
        bne L553B                               ; 550E D0 2B                    .+
        inx                                     ; 5510 E8                       .
        stx $7C40                               ; 5511 8E 40 7C                 .@|
        ldy $7FD8                               ; 5514 AC D8 7F                 ...
        lda r1L                                 ; 5517 A5 04                    ..
        sta $1000,y                             ; 5519 99 00 10                 ...
        lda r1H                                 ; 551C A5 05                    ..
        sta $1100,y                             ; 551E 99 00 11                 ...
        inc $7FD8                               ; 5521 EE D8 7F                 ...
        inc $7FD4                               ; 5524 EE D4 7F                 ...
        bne L552C                               ; 5527 D0 03                    ..
        inc $7FD5                               ; 5529 EE D5 7F                 ...
L552C:  jsr L7E32                               ; 552C 20 32 7E                  2~
        lda r1H                                 ; 552F A5 05                    ..
        sta $7FE3                               ; 5531 8D E3 7F                 ...
        lda r1L                                 ; 5534 A5 04                    ..
        sta $7FE2                               ; 5536 8D E2 7F                 ...
        ldx #$00                                ; 5539 A2 00                    ..
L553B:  rts                                     ; 553B 60                       `

; ----------------------------------------------------------------------------
        ldy #$00                                ; 553C A0 00                    ..
        tya                                     ; 553E 98                       .
L553F:  sta $1000,y                             ; 553F 99 00 10                 ...
        sta $1100,y                             ; 5542 99 00 11                 ...
        iny                                     ; 5545 C8                       .
        bne L553F                               ; 5546 D0 F7                    ..
        rts                                     ; 5548 60                       `

; ----------------------------------------------------------------------------
        lda #$20                                ; 5549 A9 20                    . 
        sta r0L                                 ; 554B 85 02                    ..
        jsr L7E0D                               ; 554D 20 0D 7E                  .~
        ldy #$02                                ; 5550 A0 02                    ..
        jmp BMult                               ; 5552 4C 63 C1                 Lc.

; ----------------------------------------------------------------------------
        lda $7F68                               ; 5555 AD 68 7F                 .h.
        sta r1H                                 ; 5558 85 05                    ..
        lda $7F67                               ; 555A AD 67 7F                 .g.
        sta r1L                                 ; 555D 85 04                    ..
        ldx #$04                                ; 555F A2 04                    ..
        rts                                     ; 5561 60                       `

; ----------------------------------------------------------------------------
        jsr L7F96                               ; 5562 20 96 7F                  ..
        jsr StashRAM                            ; 5565 20 C8 C2                  ..
        lda $7FD6                               ; 5568 AD D6 7F                 ...
        beq L5579                               ; 556B F0 0C                    ..
        jsr L7FBA                               ; 556D 20 BA 7F                  ..
        jsr StashRAM                            ; 5570 20 C8 C2                  ..
        jsr L7F80                               ; 5573 20 80 7F                  ..
        jsr StashRAM                            ; 5576 20 C8 C2                  ..
L5579:  rts                                     ; 5579 60                       `

; ----------------------------------------------------------------------------
        bit $7FEA                               ; 557A 2C EA 7F                 ,..
        bpl L559B                               ; 557D 10 1C                    ..
L557F:  jsr L7E53                               ; 557F 20 53 7E                  S~
        lda r1L                                 ; 5582 A5 04                    ..
        beq L559A                               ; 5584 F0 14                    ..
        lda $7FE4                               ; 5586 AD E4 7F                 ...
        cmp r1L                                 ; 5589 C5 04                    ..
        bcc L559A                               ; 558B 90 0D                    ..
        lda r1H                                 ; 558D A5 05                    ..
        sta r6H                                 ; 558F 85 0F                    ..
        lda r1L                                 ; 5591 A5 04                    ..
        sta r6L                                 ; 5593 85 0E                    ..
        jsr FindBAMBit                          ; 5595 20 AD C2                  ..
        bne L557F                               ; 5598 D0 E5                    ..
L559A:  rts                                     ; 559A 60                       `

; ----------------------------------------------------------------------------
L559B:  lda $7FE1                               ; 559B AD E1 7F                 ...
        cmp #$03                                ; 559E C9 03                    ..
        bne L55B1                               ; 55A0 D0 0F                    ..
        inc r1H                                 ; 55A2 E6 05                    ..
        lda r1H                                 ; 55A4 A5 05                    ..
        cmp #$28                                ; 55A6 C9 28                    .(
        bcc L55B0                               ; 55A8 90 06                    ..
        inc r1L                                 ; 55AA E6 04                    ..
        lda #$00                                ; 55AC A9 00                    ..
        sta r1H                                 ; 55AE 85 05                    ..
L55B0:  rts                                     ; 55B0 60                       `

; ----------------------------------------------------------------------------
L55B1:  cmp #$04                                ; 55B1 C9 04                    ..
        bne L55BC                               ; 55B3 D0 07                    ..
        inc r1H                                 ; 55B5 E6 05                    ..
        bne L55BB                               ; 55B7 D0 02                    ..
        inc r1L                                 ; 55B9 E6 04                    ..
L55BB:  rts                                     ; 55BB 60                       `

; ----------------------------------------------------------------------------
L55BC:  jsr L7E94                               ; 55BC 20 94 7E                  .~
        clc                                     ; 55BF 18                       .
        adc r1H                                 ; 55C0 65 05                    e.
        sta r1H                                 ; 55C2 85 05                    ..
        jsr L7E8B                               ; 55C4 20 8B 7E                  .~
        bcc L55D2                               ; 55C7 90 09                    ..
        sbc $7EB0,x                             ; 55C9 FD B0 7E                 ..~
        sta r1H                                 ; 55CC 85 05                    ..
        bne L55D2                               ; 55CE D0 02                    ..
        inc r1L                                 ; 55D0 E6 04                    ..
L55D2:  rts                                     ; 55D2 60                       `

; ----------------------------------------------------------------------------
        jsr L7E9B                               ; 55D3 20 9B 7E                  .~
        lda r1H                                 ; 55D6 A5 05                    ..
        cmp $7EB0,x                             ; 55D8 DD B0 7E                 ..~
        rts                                     ; 55DB 60                       `

; ----------------------------------------------------------------------------
        jsr L7E9B                               ; 55DC 20 9B 7E                  .~
        lda $7EB4,x                             ; 55DF BD B4 7E                 ..~
        rts                                     ; 55E2 60                       `

; ----------------------------------------------------------------------------
        lda r1L                                 ; 55E3 A5 04                    ..
        cmp #$24                                ; 55E5 C9 24                    .$
        bcc L55EB                               ; 55E7 90 02                    ..
        sbc #$23                                ; 55E9 E9 23                    .#
L55EB:  ldx #$04                                ; 55EB A2 04                    ..
L55ED:  cmp $7EAB,x                             ; 55ED DD AB 7E                 ..~
        dex                                     ; 55F0 CA                       .
        bcs L55ED                               ; 55F1 B0 FA                    ..
        rts                                     ; 55F3 60                       `

; ----------------------------------------------------------------------------
        .byte$24,$1F,$19,$12,$11,$12,$13,$15    ; 55F4 24 1F 19 12 11 12 13 15  $.......
        .byte$0A,$0B,$0A,$0A                    ; 55FC 0A 0B 0A 0A              ....
; ----------------------------------------------------------------------------
        jsr InitForIO                           ; 5600 20 5C C2                  \.
        ldy #$00                                ; 5603 A0 00                    ..
        sty $7FD8                               ; 5605 8C D8 7F                 ...
        sty $7F67                               ; 5608 8C 67 7F                 .g.
        sty $7F68                               ; 560B 8C 68 7F                 .h.
        lda $79A8                               ; 560E AD A8 79                 ..y
        bne L562A                               ; 5611 D0 17                    ..
        lda #$12                                ; 5613 A9 12                    ..
        sta $7FD7                               ; 5615 8D D7 7F                 ...
L5618:  jsr L7B9E                               ; 5618 20 9E 7B                  .{
        bne L5625                               ; 561B D0 08                    ..
        jsr L7F2B                               ; 561D 20 2B 7F                  +.
        bne L5625                               ; 5620 D0 03                    ..
        tya                                     ; 5622 98                       .
        beq L5618                               ; 5623 F0 F3                    ..
L5625:  jsr DoneWithIO                          ; 5625 20 5F C2                  _.
        txa                                     ; 5628 8A                       .
        rts                                     ; 5629 60                       `

; ----------------------------------------------------------------------------
L562A:  ldy #$00                                ; 562A A0 00                    ..
        sty $7FD8                               ; 562C 8C D8 7F                 ...
        lda $7FD6                               ; 562F AD D6 7F                 ...
        beq L5637                               ; 5632 F0 03                    ..
        jsr L7DF4                               ; 5634 20 F4 7D                  .}
L5637:  lda #$12                                ; 5637 A9 12                    ..
        sta $7FD7                               ; 5639 8D D7 7F                 ...
        jsr L7F69                               ; 563C 20 69 7F                  i.
L563F:  jsr L7B9E                               ; 563F 20 9E 7B                  .{
        bne L566E                               ; 5642 D0 2A                    .*
        jsr L7F2B                               ; 5644 20 2B 7F                  +.
        bne L566E                               ; 5647 D0 25                    .%
        tya                                     ; 5649 98                       .
        bne L566C                               ; 564A D0 20                    . 
        lda $7FD7                               ; 564C AD D7 7F                 ...
        cmp #$32                                ; 564F C9 32                    .2
        bcc L563F                               ; 5651 90 EC                    ..
        inc $7F67                               ; 5653 EE 67 7F                 .g.
        bne L5662                               ; 5656 D0 0A                    ..
        inc $7F68                               ; 5658 EE 68 7F                 .h.
        lda $7F68                               ; 565B AD 68 7F                 .h.
        cmp #$04                                ; 565E C9 04                    ..
        beq L566C                               ; 5660 F0 0A                    ..
L5662:  lda $7FD6                               ; 5662 AD D6 7F                 ...
        bne L562A                               ; 5665 D0 C3                    ..
        lda $7FD8                               ; 5667 AD D8 7F                 ...
        bne L5637                               ; 566A D0 CB                    ..
L566C:  ldx #$00                                ; 566C A2 00                    ..
L566E:  jsr DoneWithIO                          ; 566E 20 5F C2                  _.
        txa                                     ; 5671 8A                       .
        rts                                     ; 5672 60                       `

; ----------------------------------------------------------------------------
        ldx #$00                                ; 5673 A2 00                    ..
        ldy $7FD8                               ; 5675 AC D8 7F                 ...
        lda $1100,y                             ; 5678 B9 00 11                 ...
        sta r1H                                 ; 567B 85 05                    ..
        lda $1000,y                             ; 567D B9 00 10                 ...
        sta r1L                                 ; 5680 85 04                    ..
        beq L56AB                               ; 5682 F0 27                    .'
        inc $7FD8                               ; 5684 EE D8 7F                 ...
        lda $7FD7                               ; 5687 AD D7 7F                 ...
        sta r4H                                 ; 568A 85 0B                    ..
        lda #$00                                ; 568C A9 00                    ..
        sta r4L                                 ; 568E 85 0A                    ..
        jsr WriteBlock                          ; 5690 20 20 C2                   .
        inc $7FD7                               ; 5693 EE D7 7F                 ...
        lda $7FD4                               ; 5696 AD D4 7F                 ...
        bne L569E                               ; 5699 D0 03                    ..
        dec $7FD5                               ; 569B CE D5 7F                 ...
L569E:  dec $7FD4                               ; 569E CE D4 7F                 ...
        bne L56A8                               ; 56A1 D0 05                    ..
        lda $7FD5                               ; 56A3 AD D5 7F                 ...
        beq L56AB                               ; 56A6 F0 03                    ..
L56A8:  ldy #$00                                ; 56A8 A0 00                    ..
        .byte$2C                                ; 56AA 2C                       ,
L56AB:  ldy #$FF                                ; 56AB A0 FF                    ..
        txa                                     ; 56AD 8A                       .
        rts                                     ; 56AE 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 56AF 00                       .
        brk                                     ; 56B0 00                       .
        lda $7FD6                               ; 56B1 AD D6 7F                 ...
        beq L56C2                               ; 56B4 F0 0C                    ..
        jsr L7FBA                               ; 56B6 20 BA 7F                  ..
        jsr FetchRAM                            ; 56B9 20 CB C2                  ..
        jsr L7F80                               ; 56BC 20 80 7F                  ..
        jsr FetchRAM                            ; 56BF 20 CB C2                  ..
L56C2:  jsr L7F96                               ; 56C2 20 96 7F                  ..
        jmp FetchRAM                            ; 56C5 4C CB C2                 L..

; ----------------------------------------------------------------------------
        clc                                     ; 56C8 18                       .
        lda #$00                                ; 56C9 A9 00                    ..
        adc r1L                                 ; 56CB 65 04                    e.
        sta r1L                                 ; 56CD 85 04                    ..
        lda #$80                                ; 56CF A9 80                    ..
        adc r1H                                 ; 56D1 65 05                    e.
        sta r1H                                 ; 56D3 85 05                    ..
        lda #$11                                ; 56D5 A9 11                    ..
        sta r0H                                 ; 56D7 85 03                    ..
        lda #$00                                ; 56D9 A9 00                    ..
        sta r0L                                 ; 56DB 85 02                    ..
        rts                                     ; 56DD 60                       `

; ----------------------------------------------------------------------------
        jsr L7E01                               ; 56DE 20 01 7E                  .~
        clc                                     ; 56E1 18                       .
        lda r1H                                 ; 56E2 A5 05                    ..
        adc $79A9                               ; 56E4 6D A9 79                 m.y
        sta r3L                                 ; 56E7 85 08                    ..
        lda r1L                                 ; 56E9 A5 04                    ..
        sta r1H                                 ; 56EB 85 05                    ..
        lda #$00                                ; 56ED A9 00                    ..
        sta r1L                                 ; 56EF 85 04                    ..
        lda #$12                                ; 56F1 A9 12                    ..
        sta r0H                                 ; 56F3 85 03                    ..
        lda #$00                                ; 56F5 A9 00                    ..
        sta r0L                                 ; 56F7 85 02                    ..
        lda #$20                                ; 56F9 A9 20                    . 
        sta r2H                                 ; 56FB 85 07                    ..
        lda #$00                                ; 56FD A9 00                    ..
        sta r2L                                 ; 56FF 85 06                    ..
        rts                                     ; 5701 60                       `

; ----------------------------------------------------------------------------
        clc                                     ; 5702 18                       .
        adc $79A9                               ; 5703 6D A9 79                 m.y
        sta r3L                                 ; 5706 85 08                    ..
        jsr L7E01                               ; 5708 20 01 7E                  .~
        lda #$00                                ; 570B A9 00                    ..
        sta r2H                                 ; 570D 85 07                    ..
        lda #$20                                ; 570F A9 20                    . 
        sta r2L                                 ; 5711 85 06                    ..
        lda #$10                                ; 5713 A9 10                    ..
        sta r0H                                 ; 5715 85 03                    ..
        lda #$00                                ; 5717 A9 00                    ..
        sta r0L                                 ; 5719 85 02                    ..
        rts                                     ; 571B 60                       `

; ----------------------------------------------------------------------------
        .byte$00,$00,$00,$00,$00                ; 571C 00 00 00 00 00           .....
L5721:  .byte$00                                ; 5721 00                       .
L5722:  .byte$00                                ; 5722 00                       .
L5723:  .byte$00                                ; 5723 00                       .
L5724:  .byte$00                                ; 5724 00                       .
L5725:  .byte$00,$00                            ; 5725 00 00                    ..
L5727:  .byte$00,$00                            ; 5727 00 00                    ..
L5729:  .byte$00,$00,$00,$00                    ; 5729 00 00 00 00              ....
L572D:  .byte$00,$00,$00,$00,$00                ; 572D 00 00 00 00 00           .....
L5732:  .byte$00                                ; 5732 00                       .
