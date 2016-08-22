; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu2.bin
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
L4000       := $4000
L4003       := $4003
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
L9050       := $9050
L9063       := $9063
L9066       := $9066
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
LC316       := $C316
LCFD9       := $CFD9
curScrLineColor:= $D8F0
EXP_BASE    := $DF00
MOUSE_JMP_128:= $FD00
KERNALVecTab:= $FD30
KERNALCIAInit:= $FDA3
MOUSE_BASE  := $FE80
config      := $FF00
LFF54       := $FF54
KERNALVICInit:= $FF81
LFF93       := $FF93
LFF96       := $FF96
LFFA5       := $FFA5
LFFA8       := $FFA8
LFFAB       := $FFAB
LFFAE       := $FFAE
LFFB1       := $FFB1
LFFB4       := $FFB4
NMI_VECTOR  := $FFFA
RESET_VECTOR:= $FFFC
IRQ_VECTOR  := $FFFE
; ----------------------------------------------------------------------------
InitKernal:
        jmp L5032                               ; 5000 4C 32 50                 L2P

; ----------------------------------------------------------------------------
        jmp L50CA                               ; 5003 4C CA 50                 L.P

; ----------------------------------------------------------------------------
        jmp L5431                               ; 5006 4C 31 54                 L1T

; ----------------------------------------------------------------------------
        jmp L5C04                               ; 5009 4C 04 5C                 L.\

; ----------------------------------------------------------------------------
        jmp L5C13                               ; 500C 4C 13 5C                 L.\

; ----------------------------------------------------------------------------
L500F:  .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 500F 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5017 00 00 00 00 00 00 00 00  ........
        .byte$00                                ; 501F 00                       .
; ----------------------------------------------------------------------------
L5020:  jsr LCFD9                               ; 5020 20 D9 CF                  ..
        jsr L4000                               ; 5023 20 00 40                  .@
        jmp LCFD9                               ; 5026 4C D9 CF                 L..

; ----------------------------------------------------------------------------
        jsr LCFD9                               ; 5029 20 D9 CF                  ..
        jsr L4003                               ; 502C 20 03 40                  .@
        jmp LCFD9                               ; 502F 4C D9 CF                 L..

; ----------------------------------------------------------------------------
L5032:  lda #$31                                ; 5032 A9 31                    .1
        sta L50C9                               ; 5034 8D C9 50                 ..P
        jsr L9036                               ; 5037 20 36 90                  6.
        txa                                     ; 503A 8A                       .
        bne L5068                               ; 503B D0 2B                    .+
        bit isGEOS                              ; 503D 2C 8B 84                 ,..
        bmi L5068                               ; 5040 30 26                    0&
        lda $88C6                               ; 5042 AD C6 88                 ...
        and #$0F                                ; 5045 29 0F                    ).
        cmp #$04                                ; 5047 C9 04                    ..
        bne L5073                               ; 5049 D0 28                    .(
        lda $8223                               ; 504B AD 23 82                 .#.
        sta r1H                                 ; 504E 85 05                    ..
        lda $8222                               ; 5050 AD 22 82                 .".
        sta r1L                                 ; 5053 85 04                    ..
        beq L5069                               ; 5055 F0 12                    ..
        jsr L903C                               ; 5057 20 3C 90                  <.
        bne L5068                               ; 505A D0 0C                    ..
        lda $80AC                               ; 505C AD AC 80                 ...
        sta r1H                                 ; 505F 85 05                    ..
        lda $80AB                               ; 5061 AD AB 80                 ...
        sta r1L                                 ; 5064 85 04                    ..
        bne L50A2                               ; 5066 D0 3A                    .:
L5068:  rts                                     ; 5068 60                       `

; ----------------------------------------------------------------------------
L5069:  lda #$01                                ; 5069 A9 01                    ..
        sta r3L                                 ; 506B 85 08                    ..
        lda #$FE                                ; 506D A9 FE                    ..
        sta r3H                                 ; 506F 85 09                    ..
        bne L508E                               ; 5071 D0 1B                    ..
L5073:  cmp #$03                                ; 5073 C9 03                    ..
        beq L5086                               ; 5075 F0 0F                    ..
        lda #$30                                ; 5077 A9 30                    .0
        sta L50C9                               ; 5079 8D C9 50                 ..P
        lda #$13                                ; 507C A9 13                    ..
        sta r3L                                 ; 507E 85 08                    ..
        lda #$0B                                ; 5080 A9 0B                    ..
        sta r3H                                 ; 5082 85 09                    ..
        bne L508E                               ; 5084 D0 08                    ..
L5086:  lda #$29                                ; 5086 A9 29                    .)
        sta r3L                                 ; 5088 85 08                    ..
        lda #$13                                ; 508A A9 13                    ..
        sta r3H                                 ; 508C 85 09                    ..
L508E:  jsr SetNextFree                         ; 508E 20 92 C2                  ..
        txa                                     ; 5091 8A                       .
        bne L5068                               ; 5092 D0 D4                    ..
        lda r3H                                 ; 5094 A5 09                    ..
        sta r1H                                 ; 5096 85 05                    ..
        lda r3L                                 ; 5098 A5 08                    ..
        sta r1L                                 ; 509A 85 04                    ..
        jsr L5CB4                               ; 509C 20 B4 5C                  .\
        txa                                     ; 509F 8A                       .
        bne L5068                               ; 50A0 D0 C6                    ..
L50A2:  lda r1H                                 ; 50A2 A5 05                    ..
        sta $82AC                               ; 50A4 8D AC 82                 ...
        lda r1L                                 ; 50A7 A5 04                    ..
        sta $82AB                               ; 50A9 8D AB 82                 ...
        ldy #$0F                                ; 50AC A0 0F                    ..
L50AE:  lda L50BA,y                             ; 50AE B9 BA 50                 ..P
        sta $82AD,y                             ; 50B1 99 AD 82                 ...
        dey                                     ; 50B4 88                       .
        bpl L50AE                               ; 50B5 10 F7                    ..
        jmp PutDirHead                          ; 50B7 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L50BA:  .byte"GEOS format V1."                  ; 50BA 47 45 4F 53 20 66 6F 72  GEOS for
                                                ; 50C2 6D 61 74 20 56 31 2E     mat V1.
L50C9:  .byte"0"                                ; 50C9 30                       0
; ----------------------------------------------------------------------------
L50CA:  jsr L50FD                               ; 50CA 20 FD 50                  .P
        jsr L516B                               ; 50CD 20 6B 51                  kQ
        jsr L50D7                               ; 50D0 20 D7 50                  .P
        ldx L5430                               ; 50D3 AE 30 54                 .0T
        rts                                     ; 50D6 60                       `

; ----------------------------------------------------------------------------
L50D7:  lda L516A                               ; 50D7 AD 6A 51                 .jQ
        sta $84B2                               ; 50DA 8D B2 84                 ...
        lda L5169                               ; 50DD AD 69 51                 .iQ
        sta RecoverVector                       ; 50E0 8D B1 84                 ...
        lda L5168                               ; 50E3 AD 68 51                 .hQ
        sta DBoxDescH                           ; 50E6 85 44                    .D
        lda L5167                               ; 50E8 AD 67 51                 .gQ
        sta DBoxDescL                           ; 50EB 85 43                    .C
        jsr L514A                               ; 50ED 20 4A 51                  JQ
        jsr FetchRAM                            ; 50F0 20 CB C2                  ..
        jsr L512D                               ; 50F3 20 2D 51                  -Q
        jsr FetchRAM                            ; 50F6 20 CB C2                  ..
        ldx L5430                               ; 50F9 AE 30 54                 .0T
        rts                                     ; 50FC 60                       `

; ----------------------------------------------------------------------------
L50FD:  jsr L512D                               ; 50FD 20 2D 51                  -Q
        jsr StashRAM                            ; 5100 20 C8 C2                  ..
        jsr L514A                               ; 5103 20 4A 51                  JQ
        jsr StashRAM                            ; 5106 20 C8 C2                  ..
        jsr L5020                               ; 5109 20 20 50                   P
        lda DBoxDescH                           ; 510C A5 44                    .D
        sta L5168                               ; 510E 8D 68 51                 .hQ
        lda DBoxDescL                           ; 5111 A5 43                    .C
        sta L5167                               ; 5113 8D 67 51                 .gQ
        lda $84B2                               ; 5116 AD B2 84                 ...
        sta L516A                               ; 5119 8D 6A 51                 .jQ
        lda RecoverVector                       ; 511C AD B1 84                 ...
        sta L5169                               ; 511F 8D 69 51                 .iQ
        lda #$50                                ; 5122 A9 50                    .P
        sta $84B2                               ; 5124 8D B2 84                 ...
        lda #$29                                ; 5127 A9 29                    .)
        sta RecoverVector                       ; 5129 8D B1 84                 ...
        rts                                     ; 512C 60                       `

; ----------------------------------------------------------------------------
L512D:  lda #$85                                ; 512D A9 85                    ..
        sta r0H                                 ; 512F 85 03                    ..
        lda #$1F                                ; 5131 A9 1F                    ..
        sta r0L                                 ; 5133 85 02                    ..
        lda #$B9                                ; 5135 A9 B9                    ..
        sta r1H                                 ; 5137 85 05                    ..
        lda #$00                                ; 5139 A9 00                    ..
        sta r1L                                 ; 513B 85 04                    ..
        lda #$01                                ; 513D A9 01                    ..
        sta r2H                                 ; 513F 85 07                    ..
        lda #$7A                                ; 5141 A9 7A                    .z
        sta r2L                                 ; 5143 85 06                    ..
        lda #$00                                ; 5145 A9 00                    ..
        sta r3L                                 ; 5147 85 08                    ..
        rts                                     ; 5149 60                       `

; ----------------------------------------------------------------------------
L514A:  lda #$88                                ; 514A A9 88                    ..
        sta r0H                                 ; 514C 85 03                    ..
        lda #$0C                                ; 514E A9 0C                    ..
        sta r0L                                 ; 5150 85 02                    ..
        lda #$BA                                ; 5152 A9 BA                    ..
        sta r1H                                 ; 5154 85 05                    ..
        lda #$7A                                ; 5156 A9 7A                    .z
        sta r1L                                 ; 5158 85 04                    ..
        lda #$00                                ; 515A A9 00                    ..
        sta r2H                                 ; 515C 85 07                    ..
        lda #$51                                ; 515E A9 51                    .Q
        sta r2L                                 ; 5160 85 06                    ..
        lda #$00                                ; 5162 A9 00                    ..
        sta r3L                                 ; 5164 85 08                    ..
        rts                                     ; 5166 60                       `

; ----------------------------------------------------------------------------
L5167:  brk                                     ; 5167 00                       .
L5168:  brk                                     ; 5168 00                       .
L5169:  brk                                     ; 5169 00                       .
L516A:  brk                                     ; 516A 00                       .
L516B:  lda $88C6                               ; 516B AD C6 88                 ...
        cmp #$02                                ; 516E C9 02                    ..
        bne L5175                               ; 5170 D0 03                    ..
        lda #$12                                ; 5172 A9 12                    ..
        .byte$2C                                ; 5174 2C                       ,
L5175:  lda #$00                                ; 5175 A9 00                    ..
        sta L51F9                               ; 5177 8D F9 51                 ..Q
        lda #$00                                ; 517A A9 00                    ..
        sta L500F                               ; 517C 8D 0F 50                 ..P
        lda #$51                                ; 517F A9 51                    .Q
        sta r0H                                 ; 5181 85 03                    ..
        lda #$E2                                ; 5183 A9 E2                    ..
        sta r0L                                 ; 5185 85 02                    ..
        lda #$50                                ; 5187 A9 50                    .P
        sta r5H                                 ; 5189 85 0D                    ..
        lda #$0F                                ; 518B A9 0F                    ..
        sta r5L                                 ; 518D 85 0C                    ..
        jsr DoDlgBox                            ; 518F 20 56 C2                  V.
        lda r0L                                 ; 5192 A5 02                    ..
        cmp #$02                                ; 5194 C9 02                    ..
        beq L51D8                               ; 5196 F0 40                    .@
        lda L500F                               ; 5198 AD 0F 50                 ..P
        beq L51D8                               ; 519B F0 3B                    .;
        ldx #$00                                ; 519D A2 00                    ..
L519F:  lda L51DE,x                             ; 519F BD DE 51                 ..Q
        sta L53D1                               ; 51A2 8D D1 53                 ..S
        lda L51E0,x                             ; 51A5 BD E0 51                 ..Q
        sta L53D2                               ; 51A8 8D D2 53                 ..S
        jsr L5242                               ; 51AB 20 42 52                  BR
        lda #$52                                ; 51AE A9 52                    .R
        sta r0H                                 ; 51B0 85 03                    ..
        lda #$0E                                ; 51B2 A9 0E                    ..
        sta r0L                                 ; 51B4 85 02                    ..
        jsr DoDlgBox                            ; 51B6 20 56 C2                  V.
        lda r0L                                 ; 51B9 A5 02                    ..
        cmp #$04                                ; 51BB C9 04                    ..
        beq L51D8                               ; 51BD F0 19                    ..
        lda #$53                                ; 51BF A9 53                    .S
        sta L53D7                               ; 51C1 8D D7 53                 ..S
        lda #$ED                                ; 51C4 A9 ED                    ..
        sta L53D6                               ; 51C6 8D D6 53                 ..S
        lda #$53                                ; 51C9 A9 53                    .S
        sta r0H                                 ; 51CB 85 03                    ..
        lda #$C1                                ; 51CD A9 C1                    ..
        sta r0L                                 ; 51CF 85 02                    ..
        jsr DoDlgBox                            ; 51D1 20 56 C2                  V.
        ldx L5430                               ; 51D4 AE 30 54                 .0T
        rts                                     ; 51D7 60                       `

; ----------------------------------------------------------------------------
L51D8:  ldx #$0C                                ; 51D8 A2 0C                    ..
        stx L5430                               ; 51DA 8E 30 54                 .0T
        rts                                     ; 51DD 60                       `

; ----------------------------------------------------------------------------
L51DE:  .byte$1C,$13                            ; 51DE 1C 13                    ..
L51E0:  .byte$54,$5C,$00,$28,$5F,$38,$00,$07    ; 51E0 54 5C 00 28 5F 38 00 07  T\.(_8..
        .byte$01,$13,$29,$52,$02,$13,$20,$0B    ; 51E8 01 13 29 52 02 13 20 0B  ..)R.. .
        .byte$10,$0E,$BB,$52,$0D,$18,$18,$0C    ; 51F0 10 0E BB 52 0D 18 18 0C  ...R....
        .byte$10                                ; 51F8 10                       .
L51F9:  .byte$12,$13,$08,$A1,$53,$0B,$A6,$0F    ; 51F9 12 13 08 A1 53 0B A6 0F  ....S...
        .byte$12,$53,$12,$13,$14,$A9,$53,$0B    ; 5201 12 53 12 13 14 A9 53 0B  .S....S.
        .byte$A6,$1B,$1A,$53,$00,$00,$28,$5F    ; 5209 A6 1B 1A 53 00 00 28 5F  ...S..(_
        .byte$38,$00,$07,$01,$13,$29,$52,$03    ; 5211 38 00 07 01 13 29 52 03  8....)R.
        .byte$01,$20,$04,$13,$20,$0B,$08,$0E    ; 5219 01 20 04 13 20 0B 08 0E  . .. ...
        .byte$D2,$52,$0B,$14,$18                ; 5221 D2 52 0B 14 18           .R...
L5226:  .byte$F2                                ; 5226 F2                       .
L5227:  .byte$52,$00                            ; 5227 52 00                    R.
; ----------------------------------------------------------------------------
        lda $9FE1                               ; 5229 AD E1 9F                 ...
        sta L5236                               ; 522C 8D 36 52                 .6R
        jsr LC316                               ; 522F 20 16 C3                  ..
        .byte$07                                ; 5232 07                       .
        ora r12L                                ; 5233 05 1A                    ..
        .byte$07                                ; 5235 07                       .
L5236:  .byte$B3                                ; 5236 B3                       .
        jsr i_FrameRectangle                    ; 5237 20 A2 C1                  ..
        .byte$2A,$5E                            ; 523A 2A 5E                    *^
; ----------------------------------------------------------------------------
        .word$003A,$0106                        ; 523C 3A 00 06 01              :...
; ----------------------------------------------------------------------------
        .byte$FF                                ; 5240 FF                       .
; ----------------------------------------------------------------------------
        rts                                     ; 5241 60                       `

; ----------------------------------------------------------------------------
L5242:  ldy #$02                                ; 5242 A0 02                    ..
        lda #$20                                ; 5244 A9 20                    . 
L5246:  sta L52FD,y                             ; 5246 99 FD 52                 ..R
        dey                                     ; 5249 88                       .
        bpl L5246                               ; 524A 10 FA                    ..
        lda curDrive                            ; 524C AD 89 84                 ...
        clc                                     ; 524F 18                       .
        adc #$39                                ; 5250 69 39                    i9
        sta L52EE                               ; 5252 8D EE 52                 ..R
        lda #$53                                ; 5255 A9 53                    .S
        sta L5227                               ; 5257 8D 27 52                 .'R
        lda #$03                                ; 525A A9 03                    ..
        sta L5226                               ; 525C 8D 26 52                 .&R
        jsr L5562                               ; 525F 20 62 55                  bU
        beq L5271                               ; 5262 F0 0D                    ..
        lda $88C6                               ; 5264 AD C6 88                 ...
        cmp #$83                                ; 5267 C9 83                    ..
        bne L5270                               ; 5269 D0 05                    ..
        bit $9073                               ; 526B 2C 73 90                 ,s.
        bmi L5271                               ; 526E 30 01                    0.
L5270:  rts                                     ; 5270 60                       `

; ----------------------------------------------------------------------------
L5271:  lda #$52                                ; 5271 A9 52                    .R
        sta L5227                               ; 5273 8D 27 52                 .'R
        lda #$F2                                ; 5276 A9 F2                    ..
        sta L5226                               ; 5278 8D 26 52                 .&R
        jsr L9063                               ; 527B 20 63 90                  c.
        lda r2L                                 ; 527E A5 06                    ..
        ldx #$30                                ; 5280 A2 30                    .0
        ldy #$00                                ; 5282 A0 00                    ..
L5284:  cmp #$64                                ; 5284 C9 64                    .d
        bcc L528E                               ; 5286 90 06                    ..
        sec                                     ; 5288 38                       8
        sbc #$64                                ; 5289 E9 64                    .d
        inx                                     ; 528B E8                       .
        bne L5284                               ; 528C D0 F6                    ..
L528E:  cpx #$30                                ; 528E E0 30                    .0
        beq L529B                               ; 5290 F0 09                    ..
        pha                                     ; 5292 48                       H
        txa                                     ; 5293 8A                       .
        sta L52FD,y                             ; 5294 99 FD 52                 ..R
        pla                                     ; 5297 68                       h
        iny                                     ; 5298 C8                       .
        ldx #$30                                ; 5299 A2 30                    .0
L529B:  cmp #$0A                                ; 529B C9 0A                    ..
        bcc L52A5                               ; 529D 90 06                    ..
        sec                                     ; 529F 38                       8
        sbc #$0A                                ; 52A0 E9 0A                    ..
        inx                                     ; 52A2 E8                       .
        bne L529B                               ; 52A3 D0 F6                    ..
L52A5:  cpx #$30                                ; 52A5 E0 30                    .0
        bne L52AD                               ; 52A7 D0 04                    ..
        cpy #$00                                ; 52A9 C0 00                    ..
        beq L52B4                               ; 52AB F0 07                    ..
L52AD:  pha                                     ; 52AD 48                       H
        txa                                     ; 52AE 8A                       .
        sta L52FD,y                             ; 52AF 99 FD 52                 ..R
        pla                                     ; 52B2 68                       h
        iny                                     ; 52B3 C8                       .
L52B4:  clc                                     ; 52B4 18                       .
        adc #$30                                ; 52B5 69 30                    i0
        sta L52FD,y                             ; 52B7 99 FD 52                 ..R
        rts                                     ; 52BA 60                       `

; ----------------------------------------------------------------------------
        .byte$18                                ; 52BB 18                       .
        .byte"Enter a disk name..."             ; 52BC 45 6E 74 65 72 20 61 20  Enter a 
                                                ; 52C4 64 69 73 6B 20 6E 61 6D  disk nam
                                                ; 52CC 65 2E 2E 2E              e...
        .byte$1B,$00,$18                        ; 52D0 1B 00 18                 ...
        .byte"Operation will be to drive "      ; 52D3 4F 70 65 72 61 74 69 6F  Operatio
                                                ; 52DB 6E 20 77 69 6C 6C 20 62  n will b
                                                ; 52E3 65 20 74 6F 20 64 72 69  e to dri
                                                ; 52EB 76 65 20                 ve 
L52EE:  .byte"A,"                               ; 52EE 41 2C                    A,
        .byte$1B,$00,$18                        ; 52F0 1B 00 18                 ...
        .byte"Partition "                       ; 52F3 50 61 72 74 69 74 69 6F  Partitio
                                                ; 52FB 6E 20                    n 
L52FD:  .byte"      "                           ; 52FD 20 20 20 20 20 20              
        .byte$18                                ; 5303 18                       .
        .byte"...Continue?"                     ; 5304 2E 2E 2E 43 6F 6E 74 69  ...Conti
                                                ; 530C 6E 75 65 3F              nue?
        .byte$1B,$00                            ; 5310 1B 00                    ..
        .byte"1-sided"                          ; 5312 31 2D 73 69 64 65 64     1-sided
        .byte$00                                ; 5319 00                       .
        .byte"2-sided"                          ; 531A 32 2D 73 69 64 65 64     2-sided
        .byte$00                                ; 5321 00                       .
; ----------------------------------------------------------------------------
        ldx L571C                               ; 5322 AE 1C 57                 ..W
        cpx #$29                                ; 5325 E0 29                    .)
        bne L532A                               ; 5327 D0 01                    ..
        rts                                     ; 5329 60                       `

; ----------------------------------------------------------------------------
L532A:  lda #$29                                ; 532A A9 29                    .)
        sta L571C                               ; 532C 8D 1C 57                 ..W
        lda #$53                                ; 532F A9 53                    .S
        sta L53A2                               ; 5331 8D A2 53                 ..S
        lda #$B1                                ; 5334 A9 B1                    ..
        sta L53A1                               ; 5336 8D A1 53                 ..S
        lda #$53                                ; 5339 A9 53                    .S
        sta L53AA                               ; 533B 8D AA 53                 ..S
        lda #$BB                                ; 533E A9 BB                    ..
        sta L53A9                               ; 5340 8D A9 53                 ..S
        jmp L5367                               ; 5343 4C 67 53                 LgS

; ----------------------------------------------------------------------------
        ldx L571C                               ; 5346 AE 1C 57                 ..W
        cpx #$29                                ; 5349 E0 29                    .)
        beq L534E                               ; 534B F0 01                    ..
        rts                                     ; 534D 60                       `

; ----------------------------------------------------------------------------
L534E:  lda #$00                                ; 534E A9 00                    ..
        sta L571C                               ; 5350 8D 1C 57                 ..W
        lda #$53                                ; 5353 A9 53                    .S
        sta L53AA                               ; 5355 8D AA 53                 ..S
        lda #$B1                                ; 5358 A9 B1                    ..
        sta L53A9                               ; 535A 8D A9 53                 ..S
        lda #$53                                ; 535D A9 53                    .S
        sta L53A2                               ; 535F 8D A2 53                 ..S
        lda #$BB                                ; 5362 A9 BB                    ..
        sta L53A1                               ; 5364 8D A1 53                 ..S
L5367:  lda L53A2                               ; 5367 AD A2 53                 ..S
        sta r0H                                 ; 536A 85 03                    ..
        lda L53A1                               ; 536C AD A1 53                 ..S
        sta r0L                                 ; 536F 85 02                    ..
        lda #$1A                                ; 5371 A9 1A                    ..
        sta r1L                                 ; 5373 85 04                    ..
        lda #$30                                ; 5375 A9 30                    .0
        sta r1H                                 ; 5377 85 05                    ..
        lda #$01                                ; 5379 A9 01                    ..
        sta r2L                                 ; 537B 85 06                    ..
        lda #$08                                ; 537D A9 08                    ..
        sta r2H                                 ; 537F 85 07                    ..
        jsr BitmapUp                            ; 5381 20 42 C1                  B.
        lda L53AA                               ; 5384 AD AA 53                 ..S
        sta r0H                                 ; 5387 85 03                    ..
        lda L53A9                               ; 5389 AD A9 53                 ..S
        sta r0L                                 ; 538C 85 02                    ..
        lda #$1A                                ; 538E A9 1A                    ..
        sta r1L                                 ; 5390 85 04                    ..
        lda #$3C                                ; 5392 A9 3C                    .<
        sta r1H                                 ; 5394 85 05                    ..
        lda #$01                                ; 5396 A9 01                    ..
        sta r2L                                 ; 5398 85 06                    ..
        lda #$08                                ; 539A A9 08                    ..
        sta r2H                                 ; 539C 85 07                    ..
        jmp BitmapUp                            ; 539E 4C 42 C1                 LB.

; ----------------------------------------------------------------------------
L53A1:  .byte$BB                                ; 53A1 BB                       .
L53A2:  .byte$53,$00,$00,$01,$08,$22,$53        ; 53A2 53 00 00 01 08 22 53     S...."S
L53A9:  .byte$B1                                ; 53A9 B1                       .
L53AA:  .byte$53,$00,$00,$01,$08,$46,$53,$89    ; 53AA 53 00 00 01 08 46 53 89  S....FS.
        .byte$7E,$81,$81,$99,$99,$81,$81,$7E    ; 53B2 7E 81 81 99 99 81 81 7E  ~......~
        .byte$BF,$81,$7E,$06,$81,$81,$7E,$00    ; 53BA BF 81 7E 06 81 81 7E 00  ..~...~.
        .byte$28,$5F,$38,$00,$07,$01,$13,$29    ; 53C2 28 5F 38 00 07 01 13 29  (_8....)
        .byte$52,$0B,$08,$0E,$DC,$53,$13        ; 53CA 52 0B 08 0E DC 53 13     R....S.
L53D1:  .byte$1C                                ; 53D1 1C                       .
L53D2:  .byte$54,$0B,$08,$18                    ; 53D2 54 0B 08 18              T...
L53D6:  .byte$ED                                ; 53D6 ED                       .
L53D7:  .byte$53,$01,$13,$20                    ; 53D7 53 01 13 20              S.. 
; ----------------------------------------------------------------------------
        brk                                     ; 53DB 00                       .
        .byte$18                                ; 53DC 18                       .
        .byte"Please Wait..."                   ; 53DD 50 6C 65 61 73 65 20 57  Please W
                                                ; 53E5 61 69 74 2E 2E 2E        ait...
        .byte$1B,$00,$18                        ; 53EB 1B 00 18                 ...
        .byte"Operation completed"              ; 53EE 4F 70 65 72 61 74 69 6F  Operatio
                                                ; 53F6 6E 20 63 6F 6D 70 6C 65  n comple
                                                ; 53FE 74 65 64                 ted
        .byte$1B,$00,$18                        ; 5401 1B 00 18                 ...
        .byte"Disk error encountered"           ; 5404 44 69 73 6B 20 65 72 72  Disk err
                                                ; 540C 6F 72 20 65 6E 63 6F 75  or encou
                                                ; 5414 6E 74 65 72 65 64        ntered
        .byte$1B,$00                            ; 541A 1B 00                    ..
; ----------------------------------------------------------------------------
        jsr L5445                               ; 541C 20 45 54                  ET
        txa                                     ; 541F 8A                       .
        sta L5430                               ; 5420 8D 30 54                 .0T
        beq L542F                               ; 5423 F0 0A                    ..
        lda #$54                                ; 5425 A9 54                    .T
        sta L53D7                               ; 5427 8D D7 53                 ..S
        lda #$03                                ; 542A A9 03                    ..
        sta L53D6                               ; 542C 8D D6 53                 ..S
L542F:  rts                                     ; 542F 60                       `

; ----------------------------------------------------------------------------
L5430:  brk                                     ; 5430 00                       .
L5431:  stx L571C                               ; 5431 8E 1C 57                 ..W
        lda #$50                                ; 5434 A9 50                    .P
        sta r1H                                 ; 5436 85 05                    ..
        lda #$0F                                ; 5438 A9 0F                    ..
        sta r1L                                 ; 543A 85 04                    ..
        ldx #$02                                ; 543C A2 02                    ..
        ldy #$04                                ; 543E A0 04                    ..
        lda #$10                                ; 5440 A9 10                    ..
        jsr CopyFString                         ; 5442 20 68 C2                  h.
L5445:  jsr L9050                               ; 5445 20 50 90                  P.
        lda #$00                                ; 5448 A9 00                    ..
        sta L5627                               ; 544A 8D 27 56                 .'V
        lda $904F                               ; 544D AD 4F 90                 .O.
        cmp #$50                                ; 5450 C9 50                    .P
        bcc L548A                               ; 5452 90 36                    .6
        lda $88C6                               ; 5454 AD C6 88                 ...
        and #$0F                                ; 5457 29 0F                    ).
        sta L548D                               ; 5459 8D 8D 54                 ..T
        lda $88C6                               ; 545C AD C6 88                 ...
        bpl L5464                               ; 545F 10 03                    ..
        jmp L54D4                               ; 5461 4C D4 54                 L.T

; ----------------------------------------------------------------------------
L5464:  cmp #$04                                ; 5464 C9 04                    ..
        bne L546B                               ; 5466 D0 03                    ..
        jmp L5875                               ; 5468 4C 75 58                 LuX

; ----------------------------------------------------------------------------
L546B:  lda L548D                               ; 546B AD 8D 54                 ..T
        cmp #$04                                ; 546E C9 04                    ..
        bne L5475                               ; 5470 D0 03                    ..
        jmp L57DC                               ; 5472 4C DC 57                 L.W

; ----------------------------------------------------------------------------
L5475:  cmp #$03                                ; 5475 C9 03                    ..
        bne L547C                               ; 5477 D0 03                    ..
        jmp L5632                               ; 5479 4C 32 56                 L2V

; ----------------------------------------------------------------------------
L547C:  cmp #$02                                ; 547C C9 02                    ..
        bne L5483                               ; 547E D0 03                    ..
        jmp L56E4                               ; 5480 4C E4 56                 L.V

; ----------------------------------------------------------------------------
L5483:  cmp #$01                                ; 5483 C9 01                    ..
        bne L548A                               ; 5485 D0 03                    ..
        jmp L57E2                               ; 5487 4C E2 57                 L.W

; ----------------------------------------------------------------------------
L548A:  ldx #$0D                                ; 548A A2 0D                    ..
        rts                                     ; 548C 60                       `

; ----------------------------------------------------------------------------
L548D:  brk                                     ; 548D 00                       .
L548E:  jsr L9050                               ; 548E 20 50 90                  P.
        txa                                     ; 5491 8A                       .
        bne L5498                               ; 5492 D0 04                    ..
        jsr L5032                               ; 5494 20 32 50                  2P
        txa                                     ; 5497 8A                       .
L5498:  pha                                     ; 5498 48                       H
        jsr ExitTurbo                           ; 5499 20 32 C2                  2.
        pla                                     ; 549C 68                       h
        tax                                     ; 549D AA                       .
        rts                                     ; 549E 60                       `

; ----------------------------------------------------------------------------
L549F:  lda random                              ; 549F AD 0A 85                 ...
        jsr L54B4                               ; 54A2 20 B4 54                  .T
        sta L54B2                               ; 54A5 8D B2 54                 ..T
        lda $850B                               ; 54A8 AD 0B 85                 ...
        jsr L54B4                               ; 54AB 20 B4 54                  .T
        sta L54B3                               ; 54AE 8D B3 54                 ..T
        rts                                     ; 54B1 60                       `

; ----------------------------------------------------------------------------
L54B2:  .byte$4D                                ; 54B2 4D                       M
L54B3:  .byte$52                                ; 54B3 52                       R
L54B4:  and #$7F                                ; 54B4 29 7F                    ).
        cmp #$5B                                ; 54B6 C9 5B                    .[
        bcc L54BD                               ; 54B8 90 03                    ..
        sec                                     ; 54BA 38                       8
        sbc #$20                                ; 54BB E9 20                    . 
L54BD:  cmp #$41                                ; 54BD C9 41                    .A
        bcs L54D3                               ; 54BF B0 12                    ..
L54C1:  cmp #$3A                                ; 54C1 C9 3A                    .:
        bcc L54CA                               ; 54C3 90 05                    ..
        sec                                     ; 54C5 38                       8
        sbc #$03                                ; 54C6 E9 03                    ..
        bcs L54C1                               ; 54C8 B0 F7                    ..
L54CA:  cmp #$30                                ; 54CA C9 30                    .0
        bcs L54D3                               ; 54CC B0 05                    ..
        clc                                     ; 54CE 18                       .
        adc #$03                                ; 54CF 69 03                    i.
        bcc L54CA                               ; 54D1 90 F7                    ..
L54D3:  rts                                     ; 54D3 60                       `

; ----------------------------------------------------------------------------
L54D4:  lda L548D                               ; 54D4 AD 8D 54                 ..T
        cmp #$04                                ; 54D7 C9 04                    ..
        bne L54DE                               ; 54D9 D0 03                    ..
        jmp L54F6                               ; 54DB 4C F6 54                 L.T

; ----------------------------------------------------------------------------
L54DE:  cmp #$03                                ; 54DE C9 03                    ..
        bne L54E5                               ; 54E0 D0 03                    ..
        jmp L5508                               ; 54E2 4C 08 55                 L.U

; ----------------------------------------------------------------------------
L54E5:  cmp #$02                                ; 54E5 C9 02                    ..
        bne L54EC                               ; 54E7 D0 03                    ..
        jmp L5513                               ; 54E9 4C 13 55                 L.U

; ----------------------------------------------------------------------------
L54EC:  cmp #$01                                ; 54EC C9 01                    ..
        bne L54F3                               ; 54EE D0 03                    ..
        jmp L551C                               ; 54F0 4C 1C 55                 L.U

; ----------------------------------------------------------------------------
L54F3:  ldx #$0D                                ; 54F3 A2 0D                    ..
        rts                                     ; 54F5 60                       `

; ----------------------------------------------------------------------------
L54F6:  jsr L549F                               ; 54F6 20 9F 54                  .T
        lda $9062                               ; 54F9 AD 62 90                 .b.
        sta L5DAD                               ; 54FC 8D AD 5D                 ..]
        sta L594A                               ; 54FF 8D 4A 59                 .JY
        jsr L58B6                               ; 5502 20 B6 58                  .X
        jmp L548E                               ; 5505 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L5508:  jsr L549F                               ; 5508 20 9F 54                  .T
        lda #$28                                ; 550B A9 28                    .(
        sta L5DAD                               ; 550D 8D AD 5D                 ..]
        jmp L5643                               ; 5510 4C 43 56                 LCV

; ----------------------------------------------------------------------------
L5513:  jsr L549F                               ; 5513 20 9F 54                  .T
        jsr L5775                               ; 5516 20 75 57                  uW
        clv                                     ; 5519 B8                       .
        bvc L5522                               ; 551A 50 06                    P.
L551C:  jsr L549F                               ; 551C 20 9F 54                  .T
        jsr L5786                               ; 551F 20 86 57                  .W
L5522:  jsr GetDirHead                          ; 5522 20 47 C2                  G.
        lda $8201                               ; 5525 AD 01 82                 ...
        sta r1H                                 ; 5528 85 05                    ..
        lda curDirHead                          ; 552A AD 00 82                 ...
        sta r1L                                 ; 552D 85 04                    ..
        jsr L5DAE                               ; 552F 20 AE 5D                  .]
        jsr L5CD9                               ; 5532 20 D9 5C                  .\
        jsr PutDirHead                          ; 5535 20 4A C2                  J.
        jmp L548E                               ; 5538 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L553B:  jsr L5562                               ; 553B 20 62 55                  bU
        bne L555F                               ; 553E D0 1F                    ..
        jsr L5573                               ; 5540 20 73 55                  sU
        lda L548D                               ; 5543 AD 8D 54                 ..T
        cmp L55DB                               ; 5546 CD DB 55                 ..U
        beq L555C                               ; 5549 F0 11                    ..
        lda L55DB                               ; 554B AD DB 55                 ..U
        bne L555F                               ; 554E D0 0F                    ..
        lda $88C6                               ; 5550 AD C6 88                 ...
        and #$F0                                ; 5553 29 F0                    ).
        cmp #$10                                ; 5555 C9 10                    ..
        bne L555C                               ; 5557 D0 03                    ..
        jsr L55E4                               ; 5559 20 E4 55                  .U
L555C:  ldx #$00                                ; 555C A2 00                    ..
        rts                                     ; 555E 60                       `

; ----------------------------------------------------------------------------
L555F:  ldx #$0D                                ; 555F A2 0D                    ..
        rts                                     ; 5561 60                       `

; ----------------------------------------------------------------------------
L5562:  lda $88C6                               ; 5562 AD C6 88                 ...
        and #$F0                                ; 5565 29 F0                    ).
        beq L5570                               ; 5567 F0 07                    ..
        cmp #$40                                ; 5569 C9 40                    .@
        bcs L5570                               ; 556B B0 03                    ..
        lda #$00                                ; 556D A9 00                    ..
        rts                                     ; 556F 60                       `

; ----------------------------------------------------------------------------
L5570:  lda #$80                                ; 5570 A9 80                    ..
        rts                                     ; 5572 60                       `

; ----------------------------------------------------------------------------
L5573:  jsr PurgeTurbo                          ; 5573 20 35 C2                  5.
        jsr InitForIO                           ; 5576 20 5C C2                  \.
        jsr L55A5                               ; 5579 20 A5 55                  .U
        lda $88C6                               ; 557C AD C6 88                 ...
        and #$F0                                ; 557F 29 F0                    ).
        cmp #$10                                ; 5581 C9 10                    ..
        bne L559F                               ; 5583 D0 1A                    ..
        lda L55DC                               ; 5585 AD DC 55                 ..U
        and #$20                                ; 5588 29 20                    ) 
        bne L559F                               ; 558A D0 13                    ..
        lda #$55                                ; 558C A9 55                    .U
        sta z8c                                 ; 558E 85 8C                    ..
        lda #$DD                                ; 5590 A9 DD                    ..
        sta z8b                                 ; 5592 85 8B                    ..
        ldy #$07                                ; 5594 A0 07                    ..
        lda curDrive                            ; 5596 AD 89 84                 ...
        jsr L5B6D                               ; 5599 20 6D 5B                  m[
        jsr L55A5                               ; 559C 20 A5 55                  .U
L559F:  jsr DoneWithIO                          ; 559F 20 5F C2                  _.
        jmp EnterTurbo                          ; 55A2 4C 14 C2                 L..

; ----------------------------------------------------------------------------
L55A5:  lda #$55                                ; 55A5 A9 55                    .U
        sta z8c                                 ; 55A7 85 8C                    ..
        lda #$D7                                ; 55A9 A9 D7                    ..
        sta z8b                                 ; 55AB 85 8B                    ..
        ldy #$04                                ; 55AD A0 04                    ..
        lda curDrive                            ; 55AF AD 89 84                 ...
        jsr L5B6D                               ; 55B2 20 6D 5B                  m[
        lda curDrive                            ; 55B5 AD 89 84                 ...
        jsr L5BD3                               ; 55B8 20 D3 5B                  .[
        ldx L5BAB                               ; 55BB AE AB 5B                 ..[
        cpx #$05                                ; 55BE E0 05                    ..
        bcc L55C5                               ; 55C0 90 03                    ..
        ldx #$0D                                ; 55C2 A2 0D                    ..
        rts                                     ; 55C4 60                       `

; ----------------------------------------------------------------------------
L55C5:  lda L55D2,x                             ; 55C5 BD D2 55                 ..U
        sta L55DB                               ; 55C8 8D DB 55                 ..U
        lda L5BAC                               ; 55CB AD AC 5B                 ..[
        sta L55DC                               ; 55CE 8D DC 55                 ..U
        rts                                     ; 55D1 60                       `

; ----------------------------------------------------------------------------
L55D2:  .byte$00,$04,$01,$02,$03,$47,$2D,$50    ; 55D2 00 04 01 02 03 47 2D 50  .....G-P
        .byte$FF                                ; 55DA FF                       .
L55DB:  .byte$00                                ; 55DB 00                       .
L55DC:  .byte$00                                ; 55DC 00                       .
; ----------------------------------------------------------------------------
        .byte"M-W"                              ; 55DD 4D 2D 57                 M-W
; ----------------------------------------------------------------------------
        .byte$25                                ; 55E0 25                       %
; ----------------------------------------------------------------------------
        .word$0100                              ; 55E1 00 01                    ..
; ----------------------------------------------------------------------------
        .byte$01                                ; 55E3 01                       .
; ----------------------------------------------------------------------------
L55E4:  lda #$38                                ; 55E4 A9 38                    .8
        sta L562F                               ; 55E6 8D 2F 56                 ./V
        lda #$31                                ; 55E9 A9 31                    .1
        sta L5630                               ; 55EB 8D 30 56                 .0V
        lda #$20                                ; 55EE A9 20                    . 
        sta L5631                               ; 55F0 8D 31 56                 .1V
        lda L55DC                               ; 55F3 AD DC 55                 ..U
        bmi L55FB                               ; 55F6 30 03                    0.
        ldx #$21                                ; 55F8 A2 21                    .!
        rts                                     ; 55FA 60                       `

; ----------------------------------------------------------------------------
L55FB:  and #$10                                ; 55FB 29 10                    ).
        bne L561F                               ; 55FD D0 20                    . 
        lda #$44                                ; 55FF A9 44                    .D
        sta L5630                               ; 5601 8D 30 56                 .0V
        lda L55DC                               ; 5604 AD DC 55                 ..U
        and #$07                                ; 5607 29 07                    ).
        tax                                     ; 5609 AA                       .
        lda L5628,x                             ; 560A BD 28 56                 .(V
        sta L562F                               ; 560D 8D 2F 56                 ./V
        lda L548D                               ; 5610 AD 8D 54                 ..T
        cmp #$03                                ; 5613 C9 03                    ..
        beq L561A                               ; 5615 F0 03                    ..
        lda #$4E                                ; 5617 A9 4E                    .N
        .byte$2C                                ; 5619 2C                       ,
L561A:  lda #$38                                ; 561A A9 38                    .8
        sta L5631                               ; 561C 8D 31 56                 .1V
L561F:  lda #$FF                                ; 561F A9 FF                    ..
        sta L5627                               ; 5621 8D 27 56                 .'V
        ldx #$00                                ; 5624 A2 00                    ..
        rts                                     ; 5626 60                       `

; ----------------------------------------------------------------------------
L5627:  .byte$00                                ; 5627 00                       .
L5628:  .byte"DDHEDHE"                          ; 5628 44 44 48 45 44 48 45     DDHEDHE
L562F:  .byte"8"                                ; 562F 38                       8
L5630:  .byte"1"                                ; 5630 31                       1
L5631:  .byte" "                                ; 5631 20                        
; ----------------------------------------------------------------------------
L5632:  jsr L553B                               ; 5632 20 3B 55                  ;U
        bne L563A                               ; 5635 D0 03                    ..
        jmp L57E2                               ; 5637 4C E2 57                 L.W

; ----------------------------------------------------------------------------
L563A:  jsr L549F                               ; 563A 20 9F 54                  .T
        jsr L5976                               ; 563D 20 76 59                  vY
        txa                                     ; 5640 8A                       .
        bne L564C                               ; 5641 D0 09                    ..
L5643:  jsr L5653                               ; 5643 20 53 56                  SV
        txa                                     ; 5646 8A                       .
        bne L564C                               ; 5647 D0 03                    ..
        jmp L5522                               ; 5649 4C 22 55                 L"U

; ----------------------------------------------------------------------------
L564C:  pha                                     ; 564C 48                       H
        jsr ExitTurbo                           ; 564D 20 32 C2                  2.
        pla                                     ; 5650 68                       h
        tax                                     ; 5651 AA                       .
        rts                                     ; 5652 60                       `

; ----------------------------------------------------------------------------
L5653:  ldy #$00                                ; 5653 A0 00                    ..
        tya                                     ; 5655 98                       .
L5656:  sta curDirHead,y                        ; 5656 99 00 82                 ...
        sta $8900,y                             ; 5659 99 00 89                 ...
        sta $9C80,y                             ; 565C 99 80 9C                 ...
        iny                                     ; 565F C8                       .
        bne L5656                               ; 5660 D0 F4                    ..
        ldy #$02                                ; 5662 A0 02                    ..
L5664:  lda L56AA,y                             ; 5664 B9 AA 56                 ..V
        sta curDirHead,y                        ; 5667 99 00 82                 ...
        dey                                     ; 566A 88                       .
        bpl L5664                               ; 566B 10 F7                    ..
        ldy #$04                                ; 566D A0 04                    ..
L566F:  lda L56AD,y                             ; 566F B9 AD 56                 ..V
        sta $82A4,y                             ; 5672 99 A4 82                 ...
        dey                                     ; 5675 88                       .
        bpl L566F                               ; 5676 10 F7                    ..
        jsr L56C0                               ; 5678 20 C0 56                  .V
        ldy #$06                                ; 567B A0 06                    ..
L567D:  lda L56B2,y                             ; 567D B9 B2 56                 ..V
        sta $8900,y                             ; 5680 99 00 89                 ...
        lda L56B9,y                             ; 5683 B9 B9 56                 ..V
        sta $9C80,y                             ; 5686 99 80 9C                 ...
        dey                                     ; 5689 88                       .
        bpl L567D                               ; 568A 10 F1                    ..
        lda L54B2                               ; 568C AD B2 54                 ..T
        sta $8904                               ; 568F 8D 04 89                 ...
        sta $9C84                               ; 5692 8D 84 9C                 ...
        sta $82A2                               ; 5695 8D A2 82                 ...
        lda L54B3                               ; 5698 AD B3 54                 ..T
        sta $8905                               ; 569B 8D 05 89                 ...
        sta $9C85                               ; 569E 8D 85 9C                 ...
        sta $82A3                               ; 56A1 8D A3 82                 ...
        jsr PutDirHead                          ; 56A4 20 4A C2                  J.
        jmp L5D09                               ; 56A7 4C 09 5D                 L.]

; ----------------------------------------------------------------------------
L56AA:  .byte$28,$03,$44                        ; 56AA 28 03 44                 (.D
L56AD:  .byte$A0,$33,$44,$A0,$A0                ; 56AD A0 33 44 A0 A0           .3D..
L56B2:  .byte$28,$02,$44,$BB,$00,$00,$C0        ; 56B2 28 02 44 BB 00 00 C0     (.D....
L56B9:  .byte$00,$FF,$44,$BB,$00,$00,$C0        ; 56B9 00 FF 44 BB 00 00 C0     ..D....
; ----------------------------------------------------------------------------
L56C0:  ldy #$00                                ; 56C0 A0 00                    ..
L56C2:  lda L500F,y                             ; 56C2 B9 0F 50                 ..P
        beq L56CF                               ; 56C5 F0 08                    ..
        sta $8290,y                             ; 56C7 99 90 82                 ...
        iny                                     ; 56CA C8                       .
        cpy #$10                                ; 56CB C0 10                    ..
        bne L56C2                               ; 56CD D0 F3                    ..
L56CF:  lda #$A0                                ; 56CF A9 A0                    ..
L56D1:  sta $8290,y                             ; 56D1 99 90 82                 ...
        iny                                     ; 56D4 C8                       .
        cpy #$12                                ; 56D5 C0 12                    ..
        bne L56D1                               ; 56D7 D0 F8                    ..
        rts                                     ; 56D9 60                       `

; ----------------------------------------------------------------------------
L56DA:  ldy #$00                                ; 56DA A0 00                    ..
        tya                                     ; 56DC 98                       .
L56DD:  sta diskBlkBuf,y                        ; 56DD 99 00 80                 ...
        iny                                     ; 56E0 C8                       .
        bne L56DD                               ; 56E1 D0 FA                    ..
        rts                                     ; 56E3 60                       `

; ----------------------------------------------------------------------------
L56E4:  jsr L549F                               ; 56E4 20 9F 54                  .T
        jsr PurgeTurbo                          ; 56E7 20 35 C2                  5.
        lda L571C                               ; 56EA AD 1C 57                 ..W
        cmp #$29                                ; 56ED C9 29                    .)
        bne L5701                               ; 56EF D0 10                    ..
        jsr L571D                               ; 56F1 20 1D 57                  .W
        jsr L57FB                               ; 56F4 20 FB 57                  .W
        txa                                     ; 56F7 8A                       .
        beq L5719                               ; 56F8 F0 1F                    ..
L56FA:  pha                                     ; 56FA 48                       H
        jsr EnterTurbo                          ; 56FB 20 14 C2                  ..
        pla                                     ; 56FE 68                       h
        tax                                     ; 56FF AA                       .
        rts                                     ; 5700 60                       `

; ----------------------------------------------------------------------------
L5701:  jsr L5738                               ; 5701 20 38 57                  8W
        txa                                     ; 5704 8A                       .
        bne L56FA                               ; 5705 D0 F3                    ..
        jsr InitForIO                           ; 5707 20 5C C2                  \.
        jsr L585B                               ; 570A 20 5B 58                  [X
        jsr DoneWithIO                          ; 570D 20 5F C2                  _.
        txa                                     ; 5710 8A                       .
        bne L56FA                               ; 5711 D0 E7                    ..
        jsr L5775                               ; 5713 20 75 57                  uW
        txa                                     ; 5716 8A                       .
        bne L56FA                               ; 5717 D0 E1                    ..
L5719:  jmp L5522                               ; 5719 4C 22 55                 L"U

; ----------------------------------------------------------------------------
L571C:  brk                                     ; 571C 00                       .
L571D:  jsr InitForIO                           ; 571D 20 5C C2                  \.
        lda #$57                                ; 5720 A9 57                    .W
        sta z8c                                 ; 5722 85 8C                    ..
        lda #$33                                ; 5724 A9 33                    .3
        sta z8b                                 ; 5726 85 8B                    ..
        ldy #$05                                ; 5728 A0 05                    ..
        lda curDrive                            ; 572A AD 89 84                 ...
        jsr L5B6D                               ; 572D 20 6D 5B                  m[
        jmp DoneWithIO                          ; 5730 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        .byte"U0>M0"                            ; 5733 55 30 3E 4D 30           U0>M0
; ----------------------------------------------------------------------------
L5738:  jsr InitForIO                           ; 5738 20 5C C2                  \.
        lda L54B3                               ; 573B AD B3 54                 ..T
        sta L5774                               ; 573E 8D 74 57                 .tW
        lda L54B2                               ; 5741 AD B2 54                 ..T
        sta L5773                               ; 5744 8D 73 57                 .sW
        lda #$57                                ; 5747 A9 57                    .W
        sta z8c                                 ; 5749 85 8C                    ..
        lda #$6C                                ; 574B A9 6C                    .l
        sta z8b                                 ; 574D 85 8B                    ..
        ldy #$03                                ; 574F A0 03                    ..
        lda curDrive                            ; 5751 AD 89 84                 ...
        jsr L5B6D                               ; 5754 20 6D 5B                  m[
        bne L5769                               ; 5757 D0 10                    ..
        lda #$57                                ; 5759 A9 57                    .W
        sta z8c                                 ; 575B 85 8C                    ..
        lda #$6F                                ; 575D A9 6F                    .o
        sta z8b                                 ; 575F 85 8B                    ..
        ldy #$06                                ; 5761 A0 06                    ..
        lda curDrive                            ; 5763 AD 89 84                 ...
        jsr L5B6D                               ; 5766 20 6D 5B                  m[
L5769:  jmp DoneWithIO                          ; 5769 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        .byte"U0"                               ; 576C 55 30                    U0
        .byte$04                                ; 576E 04                       .
        .byte"U0"                               ; 576F 55 30                    U0
        .byte$06,$00                            ; 5771 06 00                    ..
L5773:  .byte"M"                                ; 5773 4D                       M
L5774:  .byte"R"                                ; 5774 52                       R
; ----------------------------------------------------------------------------
L5775:  jsr L578C                               ; 5775 20 8C 57                  .W
        jsr GetDirHead                          ; 5778 20 47 C2                  G.
        lda #$80                                ; 577B A9 80                    ..
        sta $8203                               ; 577D 8D 03 82                 ...
        jsr L57B4                               ; 5780 20 B4 57                  .W
        jmp L5D52                               ; 5783 4C 52 5D                 LR]

; ----------------------------------------------------------------------------
L5786:  jsr L578C                               ; 5786 20 8C 57                  .W
        jmp L5D7E                               ; 5789 4C 7E 5D                 L~]

; ----------------------------------------------------------------------------
L578C:  jsr L57D2                               ; 578C 20 D2 57                  .W
        jsr L56C0                               ; 578F 20 C0 56                  .V
        lda L54B3                               ; 5792 AD B3 54                 ..T
        sta $82A3                               ; 5795 8D A3 82                 ...
        lda L54B2                               ; 5798 AD B2 54                 ..T
        sta $82A2                               ; 579B 8D A2 82                 ...
        ldy #$03                                ; 579E A0 03                    ..
L57A0:  lda L57C7,y                             ; 57A0 B9 C7 57                 ..W
        sta curDirHead,y                        ; 57A3 99 00 82                 ...
        dey                                     ; 57A6 88                       .
        bpl L57A0                               ; 57A7 10 F7                    ..
        ldy #$06                                ; 57A9 A0 06                    ..
L57AB:  lda L57CB,y                             ; 57AB B9 CB 57                 ..W
        sta $82A4,y                             ; 57AE 99 A4 82                 ...
        dey                                     ; 57B1 88                       .
        bpl L57AB                               ; 57B2 10 F7                    ..
L57B4:  lda #$82                                ; 57B4 A9 82                    ..
        sta r4H                                 ; 57B6 85 0B                    ..
        lda #$00                                ; 57B8 A9 00                    ..
        sta r4L                                 ; 57BA 85 0A                    ..
        lda #$12                                ; 57BC A9 12                    ..
        sta r1L                                 ; 57BE 85 04                    ..
        lda #$00                                ; 57C0 A9 00                    ..
        sta r1H                                 ; 57C2 85 05                    ..
        jmp PutBlock                            ; 57C4 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L57C7:  .byte$12,$01,$41,$00                    ; 57C7 12 01 41 00              ..A.
L57CB:  .byte$A0,$32,$41,$A0,$A0,$A0,$A0        ; 57CB A0 32 41 A0 A0 A0 A0     .2A....
; ----------------------------------------------------------------------------
L57D2:  ldy #$00                                ; 57D2 A0 00                    ..
        tya                                     ; 57D4 98                       .
L57D5:  sta curDirHead,y                        ; 57D5 99 00 82                 ...
        iny                                     ; 57D8 C8                       .
        bne L57D5                               ; 57D9 D0 FA                    ..
        rts                                     ; 57DB 60                       `

; ----------------------------------------------------------------------------
L57DC:  jsr L553B                               ; 57DC 20 3B 55                  ;U
        beq L57E2                               ; 57DF F0 01                    ..
        rts                                     ; 57E1 60                       `

; ----------------------------------------------------------------------------
L57E2:  jsr L549F                               ; 57E2 20 9F 54                  .T
        jsr PurgeTurbo                          ; 57E5 20 35 C2                  5.
        jsr L57FB                               ; 57E8 20 FB 57                  .W
        txa                                     ; 57EB 8A                       .
        bne L57FA                               ; 57EC D0 0C                    ..
        jsr GetDirHead                          ; 57EE 20 47 C2                  G.
        jsr L5CD9                               ; 57F1 20 D9 5C                  .\
        jsr PutDirHead                          ; 57F4 20 4A C2                  J.
        jmp L548E                               ; 57F7 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L57FA:  rts                                     ; 57FA 60                       `

; ----------------------------------------------------------------------------
L57FB:  jsr InitForIO                           ; 57FB 20 5C C2                  \.
        lda #$58                                ; 57FE A9 58                    .X
        sta z8c                                 ; 5800 85 8C                    ..
        lda #$58                                ; 5802 A9 58                    .X
        sta z8b                                 ; 5804 85 8B                    ..
        lda curDrive                            ; 5806 AD 89 84                 ...
        ldy #$03                                ; 5809 A0 03                    ..
        jsr L5B7D                               ; 580B 20 7D 5B                  }[
        beq L5813                               ; 580E F0 03                    ..
        jmp DoneWithIO                          ; 5810 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L5813:  ldy #$00                                ; 5813 A0 00                    ..
L5815:  lda L500F,y                             ; 5815 B9 0F 50                 ..P
        beq L5822                               ; 5818 F0 08                    ..
        jsr LFFA8                               ; 581A 20 A8 FF                  ..
        iny                                     ; 581D C8                       .
        cpy #$10                                ; 581E C0 10                    ..
        bne L5815                               ; 5820 D0 F3                    ..
L5822:  lda #$2C                                ; 5822 A9 2C                    .,
        jsr LFFA8                               ; 5824 20 A8 FF                  ..
        lda L54B2                               ; 5827 AD B2 54                 ..T
        jsr LFFA8                               ; 582A 20 A8 FF                  ..
        lda L54B3                               ; 582D AD B3 54                 ..T
        jsr LFFA8                               ; 5830 20 A8 FF                  ..
        bit L5627                               ; 5833 2C 27 56                 ,'V
        bpl L584A                               ; 5836 10 12                    ..
        lda #$2C                                ; 5838 A9 2C                    .,
        jsr LFFA8                               ; 583A 20 A8 FF                  ..
        ldy #$00                                ; 583D A0 00                    ..
L583F:  lda L562F,y                             ; 583F B9 2F 56                 ./V
        jsr LFFA8                               ; 5842 20 A8 FF                  ..
        iny                                     ; 5845 C8                       .
        cpy #$03                                ; 5846 C0 03                    ..
        bne L583F                               ; 5848 D0 F5                    ..
L584A:  lda #$0D                                ; 584A A9 0D                    ..
        jsr LFFA8                               ; 584C 20 A8 FF                  ..
        jsr LFFAE                               ; 584F 20 AE FF                  ..
        jsr L585B                               ; 5852 20 5B 58                  [X
        jmp DoneWithIO                          ; 5855 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        lsr $3A30                               ; 5858 4E 30 3A                 N0:
L585B:  lda curDrive                            ; 585B AD 89 84                 ...
        jsr L5BD3                               ; 585E 20 D3 5B                  .[
        bne L5872                               ; 5861 D0 0F                    ..
        lda L5BAB                               ; 5863 AD AB 5B                 ..[
        cmp #$30                                ; 5866 C9 30                    .0
        bne L5872                               ; 5868 D0 08                    ..
        cmp L5BAC                               ; 586A CD AC 5B                 ..[
        bne L5872                               ; 586D D0 03                    ..
        ldx #$00                                ; 586F A2 00                    ..
        .byte$2C                                ; 5871 2C                       ,
L5872:  ldx #$21                                ; 5872 A2 21                    .!
        rts                                     ; 5874 60                       `

; ----------------------------------------------------------------------------
L5875:  jsr EnterTurbo                          ; 5875 20 14 C2                  ..
        lda #$0C                                ; 5878 A9 0C                    ..
        sta L594A                               ; 587A 8D 4A 59                 .JY
        sta $9062                               ; 587D 8D 62 90                 .b.
        jsr L5962                               ; 5880 20 62 59                  bY
        txa                                     ; 5883 8A                       .
        bne L5895                               ; 5884 D0 0F                    ..
        jsr L589C                               ; 5886 20 9C 58                  .X
        txa                                     ; 5889 8A                       .
        bne L5895                               ; 588A D0 09                    ..
        jsr L58B6                               ; 588C 20 B6 58                  .X
        txa                                     ; 588F 8A                       .
        bne L5895                               ; 5890 D0 03                    ..
        jmp L548E                               ; 5892 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L5895:  pha                                     ; 5895 48                       H
        jsr ExitTurbo                           ; 5896 20 32 C2                  2.
        pla                                     ; 5899 68                       h
        tax                                     ; 589A AA                       .
        rts                                     ; 589B 60                       `

; ----------------------------------------------------------------------------
L589C:  jsr L56DA                               ; 589C 20 DA 56                  .V
        lda #$07                                ; 589F A9 07                    ..
        sta r1L                                 ; 58A1 85 04                    ..
        lda #$18                                ; 58A3 A9 18                    ..
        sta r1H                                 ; 58A5 85 05                    ..
L58A7:  jsr L903F                               ; 58A7 20 3F 90                  ?.
        txa                                     ; 58AA 8A                       .
        bne L58B5                               ; 58AB D0 08                    ..
        inc r1H                                 ; 58AD E6 05                    ..
        lda r1H                                 ; 58AF A5 05                    ..
        cmp #$1C                                ; 58B1 C9 1C                    ..
        bcc L58A7                               ; 58B3 90 F2                    ..
L58B5:  rts                                     ; 58B5 60                       `

; ----------------------------------------------------------------------------
L58B6:  lda L54B3                               ; 58B6 AD B3 54                 ..T
        sta L5947                               ; 58B9 8D 47 59                 .GY
        lda L54B2                               ; 58BC AD B2 54                 ..T
        sta L5946                               ; 58BF 8D 46 59                 .FY
        ldy #$00                                ; 58C2 A0 00                    ..
        lda #$FF                                ; 58C4 A9 FF                    ..
L58C6:  sta diskBlkBuf,y                        ; 58C6 99 00 80                 ...
        iny                                     ; 58C9 C8                       .
        bne L58C6                               ; 58CA D0 FA                    ..
        lda #$01                                ; 58CC A9 01                    ..
        sta r1L                                 ; 58CE 85 04                    ..
        lda #$03                                ; 58D0 A9 03                    ..
        sta r1H                                 ; 58D2 85 05                    ..
L58D4:  jsr L903F                               ; 58D4 20 3F 90                  ?.
        inc r1H                                 ; 58D7 E6 05                    ..
        lda r1H                                 ; 58D9 A5 05                    ..
        cmp #$22                                ; 58DB C9 22                    ."
        bcc L58D4                               ; 58DD 90 F5                    ..
        ldy #$1F                                ; 58DF A0 1F                    ..
L58E1:  lda L5942,y                             ; 58E1 B9 42 59                 .BY
        sta diskBlkBuf,y                        ; 58E4 99 00 80                 ...
        dey                                     ; 58E7 88                       .
        bpl L58E1                               ; 58E8 10 F7                    ..
        lda #$01                                ; 58EA A9 01                    ..
        sta r1L                                 ; 58EC 85 04                    ..
        lda #$02                                ; 58EE A9 02                    ..
        sta r1H                                 ; 58F0 85 05                    ..
        jsr L903F                               ; 58F2 20 3F 90                  ?.
        jsr L57D2                               ; 58F5 20 D2 57                  .W
        lda #$01                                ; 58F8 A9 01                    ..
        sta curDirHead                          ; 58FA 8D 00 82                 ...
        lda #$22                                ; 58FD A9 22                    ."
        sta $8201                               ; 58FF 8D 01 82                 ...
        lda #$48                                ; 5902 A9 48                    .H
        sta $8202                               ; 5904 8D 02 82                 ...
        lda #$01                                ; 5907 A9 01                    ..
        sta $8220                               ; 5909 8D 20 82                 . .
        sta $8221                               ; 590C 8D 21 82                 .!.
        jsr L56C0                               ; 590F 20 C0 56                  .V
        lda L54B3                               ; 5912 AD B3 54                 ..T
        sta $82A3                               ; 5915 8D A3 82                 ...
        lda L54B2                               ; 5918 AD B2 54                 ..T
        sta $82A2                               ; 591B 8D A2 82                 ...
        ldy #$04                                ; 591E A0 04                    ..
L5920:  lda L593D,y                             ; 5920 B9 3D 59                 .=Y
        sta $82A4,y                             ; 5923 99 A4 82                 ...
        dey                                     ; 5926 88                       .
        bpl L5920                               ; 5927 10 F7                    ..
        lda #$01                                ; 5929 A9 01                    ..
        sta r1L                                 ; 592B 85 04                    ..
        sta r1H                                 ; 592D 85 05                    ..
        lda #$82                                ; 592F A9 82                    ..
        sta r4H                                 ; 5931 85 0B                    ..
        lda #$00                                ; 5933 A9 00                    ..
        sta r4L                                 ; 5935 85 0A                    ..
        jsr PutBlock                            ; 5937 20 E7 C1                  ..
        jmp L5CE4                               ; 593A 4C E4 5C                 L.\

; ----------------------------------------------------------------------------
L593D:  .byte$A0,$31,$48,$A0,$A0                ; 593D A0 31 48 A0 A0           .1H..
L5942:  .byte$00,$00,$48,$B7                    ; 5942 00 00 48 B7              ..H.
L5946:  .byte$46                                ; 5946 46                       F
L5947:  .byte$44,$C0,$00                        ; 5947 44 C0 00                 D..
L594A:  .byte$0C,$00,$00,$00,$00,$00,$00,$00    ; 594A 0C 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5952 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 595A 00 00 00 00 00 00 00 00  ........
; ----------------------------------------------------------------------------
L5962:  lda #$46                                ; 5962 A9 46                    .F
        sta L54B2                               ; 5964 8D B2 54                 ..T
        lda #$44                                ; 5967 A9 44                    .D
        sta L54B3                               ; 5969 8D B3 54                 ..T
        jsr L5976                               ; 596C 20 76 59                  vY
        txa                                     ; 596F 8A                       .
        bne L5975                               ; 5970 D0 03                    ..
        jmp L5AE9                               ; 5972 4C E9 5A                 L.Z

; ----------------------------------------------------------------------------
L5975:  rts                                     ; 5975 60                       `

; ----------------------------------------------------------------------------
L5976:  jsr PurgeTurbo                          ; 5976 20 35 C2                  5.
        jsr InitForIO                           ; 5979 20 5C C2                  \.
        lda L54B3                               ; 597C AD B3 54                 ..T
        sta L59BB                               ; 597F 8D BB 59                 ..Y
        lda L54B2                               ; 5982 AD B2 54                 ..T
        sta L59BA                               ; 5985 8D BA 59                 ..Y
        lda #$59                                ; 5988 A9 59                    .Y
        sta z8c                                 ; 598A 85 8C                    ..
        lda #$B4                                ; 598C A9 B4                    ..
        sta z8b                                 ; 598E 85 8B                    ..
        ldy #$08                                ; 5990 A0 08                    ..
        lda curDrive                            ; 5992 AD 89 84                 ...
        jsr L5B6D                               ; 5995 20 6D 5B                  m[
        lda curDrive                            ; 5998 AD 89 84                 ...
        jsr L5BD3                               ; 599B 20 D3 5B                  .[
        bne L59B1                               ; 599E D0 11                    ..
        lda L5BAB                               ; 59A0 AD AB 5B                 ..[
        cmp #$30                                ; 59A3 C9 30                    .0
        bne L59AF                               ; 59A5 D0 08                    ..
        cmp L5BAC                               ; 59A7 CD AC 5B                 ..[
        bne L59AF                               ; 59AA D0 03                    ..
        ldx #$00                                ; 59AC A2 00                    ..
        .byte$2C                                ; 59AE 2C                       ,
L59AF:  ldx #$21                                ; 59AF A2 21                    .!
L59B1:  jmp DoneWithIO                          ; 59B1 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        .byte"N0:MR,"                           ; 59B4 4E 30 3A 4D 52 2C        N0:MR,
L59BA:  .byte"F"                                ; 59BA 46                       F
L59BB:  .byte"D"                                ; 59BB 44                       D
        .byte$00,$00,$01,$01,$00,$00,$00,$00    ; 59BC 00 00 01 01 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 59C4 00 00 00 00 00 00 00 00  ........
        .byte"CMD FD SERIES   "                 ; 59CC 43 4D 44 20 46 44 20 53  CMD FD S
                                                ; 59D4 45 52 49 45 53 20 20 20  ERIES   
        .byte$01,$01,$FF,$00,$00                ; 59DC 01 01 FF 00 00           .....
        .byte"SYSTEM"                           ; 59E1 53 59 53 54 45 4D        SYSTEM
        .byte$A0,$A0,$A0,$A0,$A0,$A0,$A0,$A0    ; 59E7 A0 A0 A0 A0 A0 A0 A0 A0  ........
        .byte$A0,$A0,$00,$00,$00,$00,$00,$00    ; 59EF A0 A0 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$01    ; 59F7 00 00 00 00 00 00 00 01  ........
        .byte$00,$00                            ; 59FF 00 00                    ..
        .byte"PARTITION 1"                      ; 5A01 50 41 52 54 49 54 49 4F  PARTITIO
                                                ; 5A09 4E 20 31                 N 1
        .byte$A0,$A0,$A0,$A0,$A0,$00,$00,$00    ; 5A0C A0 A0 A0 A0 A0 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$06,$00    ; 5A14 00 00 00 00 00 00 06 00  ........
        .byte$08                                ; 5A1C 08                       .
; ----------------------------------------------------------------------------
        sei                                     ; 5A1D 78                       x
        lda #$00                                ; 5A1E A9 00                    ..
L5A20:  sta $01CE                               ; 5A20 8D CE 01                 ...
        lda #$9C                                ; 5A23 A9 9C                    ..
        ldx #$00                                ; 5A25 A2 00                    ..
        jsr LFF54                               ; 5A27 20 54 FF                  T.
        lda #$50                                ; 5A2A A9 50                    .P
        sta $01BC                               ; 5A2C 8D BC 01                 ...
        lda #$8C                                ; 5A2F A9 8C                    ..
        ldx #$00                                ; 5A31 A2 00                    ..
        jsr LFF54                               ; 5A33 20 54 FF                  T.
        lda #$8E                                ; 5A36 A9 8E                    ..
        ldx #$00                                ; 5A38 A2 00                    ..
        jsr LFF54                               ; 5A3A 20 54 FF                  T.
        lda #$01                                ; 5A3D A9 01                    ..
        cmp $01CE                               ; 5A3F CD CE 01                 ...
        bne L5A20                               ; 5A42 D0 DC                    ..
        ldy #$00                                ; 5A44 A0 00                    ..
L5A46:  lda #$00                                ; 5A46 A9 00                    ..
        sta $0300,y                             ; 5A48 99 00 03                 ...
        lda #$FF                                ; 5A4B A9 FF                    ..
        sta APP_RAM,y                           ; 5A4D 99 00 04                 ...
        iny                                     ; 5A50 C8                       .
        bne L5A46                               ; 5A51 D0 F3                    ..
        tya                                     ; 5A53 98                       .
        sta APP_RAM                             ; 5A54 8D 00 04                 ...
        sta $0438                               ; 5A57 8D 38 04                 .8.
        sta $0439                               ; 5A5A 8D 39 04                 .9.
        sta $0470                               ; 5A5D 8D 70 04                 .p.
        sta $04A8                               ; 5A60 8D A8 04                 ...
        lda #$06                                ; 5A63 A9 06                    ..
        sta $0471                               ; 5A65 8D 71 04                 .q.
        lda #$40                                ; 5A68 A9 40                    .@
        sta $04A9                               ; 5A6A 8D A9 04                 ...
        lda #$01                                ; 5A6D A9 01                    ..
        sta $04E2                               ; 5A6F 8D E2 04                 ...
        sta $04E3                               ; 5A72 8D E3 04                 ...
        ldy #$1F                                ; 5A75 A0 1F                    ..
L5A77:  lda $0500,y                             ; 5A77 B9 00 05                 ...
        sta $04E0,y                             ; 5A7A 99 E0 04                 ...
        dey                                     ; 5A7D 88                       .
        bpl L5A77                               ; 5A7E 10 F7                    ..
        lda #$50                                ; 5A80 A9 50                    .P
        sta r4H                                 ; 5A82 85 0B                    ..
        lda #$03                                ; 5A84 A9 03                    ..
        sta r5L                                 ; 5A86 85 0C                    ..
        lda #$00                                ; 5A88 A9 00                    ..
        sta $01CE                               ; 5A8A 8D CE 01                 ...
        lda #$A6                                ; 5A8D A9 A6                    ..
        ldx #$00                                ; 5A8F A2 00                    ..
        jsr LFF54                               ; 5A91 20 54 FF                  T.
        ldy #$00                                ; 5A94 A0 00                    ..
        tya                                     ; 5A96 98                       .
L5A97:  sta $0300,y                             ; 5A97 99 00 03                 ...
        sta APP_RAM,y                           ; 5A9A 99 00 04                 ...
        iny                                     ; 5A9D C8                       .
        bne L5A97                               ; 5A9E D0 F7                    ..
        lda #$FF                                ; 5AA0 A9 FF                    ..
        sta $0401                               ; 5AA2 8D 01 04                 ...
        lda #$01                                ; 5AA5 A9 01                    ..
        sta $0300                               ; 5AA7 8D 00 03                 ...
        lda #$03                                ; 5AAA A9 03                    ..
        sta $0301                               ; 5AAC 8D 01 03                 ...
        lda #$50                                ; 5AAF A9 50                    .P
        sta r4H                                 ; 5AB1 85 0B                    ..
        lda #$06                                ; 5AB3 A9 06                    ..
        sta r5L                                 ; 5AB5 85 0C                    ..
        lda #$00                                ; 5AB7 A9 00                    ..
        sta $01CE                               ; 5AB9 8D CE 01                 ...
        lda #$A6                                ; 5ABC A9 A6                    ..
        ldx #$00                                ; 5ABE A2 00                    ..
        jsr LFF54                               ; 5AC0 20 54 FF                  T.
        ldy #$3F                                ; 5AC3 A0 3F                    .?
L5AC5:  lda $0520,y                             ; 5AC5 B9 20 05                 . .
        sta $0300,y                             ; 5AC8 99 00 03                 ...
        dey                                     ; 5ACB 88                       .
        bpl L5AC5                               ; 5ACC 10 F7                    ..
        lda #$02                                ; 5ACE A9 02                    ..
        sta $0401                               ; 5AD0 8D 01 04                 ...
        lda #$50                                ; 5AD3 A9 50                    .P
        sta r4H                                 ; 5AD5 85 0B                    ..
        lda #$05                                ; 5AD7 A9 05                    ..
        sta r5L                                 ; 5AD9 85 0C                    ..
        lda #$00                                ; 5ADB A9 00                    ..
        sta $01CE                               ; 5ADD 8D CE 01                 ...
        lda #$A6                                ; 5AE0 A9 A6                    ..
        ldx #$00                                ; 5AE2 A2 00                    ..
        jsr LFF54                               ; 5AE4 20 54 FF                  T.
        plp                                     ; 5AE7 28                       (
        rts                                     ; 5AE8 60                       `

; ----------------------------------------------------------------------------
L5AE9:  jsr PurgeTurbo                          ; 5AE9 20 35 C2                  5.
        jsr InitForIO                           ; 5AEC 20 5C C2                  \.
        lda #$00                                ; 5AEF A9 00                    ..
        sta L5B65                               ; 5AF1 8D 65 5B                 .e[
        lda #$05                                ; 5AF4 A9 05                    ..
        sta L5B66                               ; 5AF6 8D 66 5B                 .f[
        lda #$59                                ; 5AF9 A9 59                    .Y
        sta r0H                                 ; 5AFB 85 03                    ..
        lda #$BC                                ; 5AFD A9 BC                    ..
        sta r0L                                 ; 5AFF 85 02                    ..
L5B01:  ldy #$06                                ; 5B01 A0 06                    ..
        lda #$5B                                ; 5B03 A9 5B                    .[
        sta z8c                                 ; 5B05 85 8C                    ..
        lda #$62                                ; 5B07 A9 62                    .b
        sta z8b                                 ; 5B09 85 8B                    ..
        lda curDrive                            ; 5B0B AD 89 84                 ...
        jsr L5B7D                               ; 5B0E 20 7D 5B                  }[
        bne L5B5F                               ; 5B11 D0 4C                    .L
        ldy #$00                                ; 5B13 A0 00                    ..
L5B15:  lda (r0L),y                             ; 5B15 B1 02                    ..
        jsr LFFA8                               ; 5B17 20 A8 FF                  ..
        iny                                     ; 5B1A C8                       .
        cpy #$20                                ; 5B1B C0 20                    . 
        bcc L5B15                               ; 5B1D 90 F6                    ..
        lda #$0D                                ; 5B1F A9 0D                    ..
        jsr LFFA8                               ; 5B21 20 A8 FF                  ..
        jsr LFFAE                               ; 5B24 20 AE FF                  ..
        clc                                     ; 5B27 18                       .
        lda L5B65                               ; 5B28 AD 65 5B                 .e[
        adc #$20                                ; 5B2B 69 20                    i 
        sta L5B65                               ; 5B2D 8D 65 5B                 .e[
        bcc L5B35                               ; 5B30 90 03                    ..
        inc L5B66                               ; 5B32 EE 66 5B                 .f[
L5B35:  lda r0H                                 ; 5B35 A5 03                    ..
        cmp #$5A                                ; 5B37 C9 5A                    .Z
        bne L5B3F                               ; 5B39 D0 04                    ..
        lda r0L                                 ; 5B3B A5 02                    ..
        cmp #$E9                                ; 5B3D C9 E9                    ..
L5B3F:  bcs L5B4F                               ; 5B3F B0 0E                    ..
        clc                                     ; 5B41 18                       .
        lda #$20                                ; 5B42 A9 20                    . 
        adc r0L                                 ; 5B44 65 02                    e.
        sta r0L                                 ; 5B46 85 02                    ..
        bcc L5B4C                               ; 5B48 90 02                    ..
        inc r0H                                 ; 5B4A E6 03                    ..
L5B4C:  clv                                     ; 5B4C B8                       .
        bvc L5B01                               ; 5B4D 50 B2                    P.
L5B4F:  lda #$5B                                ; 5B4F A9 5B                    .[
        sta z8c                                 ; 5B51 85 8C                    ..
        lda #$68                                ; 5B53 A9 68                    .h
        sta z8b                                 ; 5B55 85 8B                    ..
        lda curDrive                            ; 5B57 AD 89 84                 ...
        ldy #$05                                ; 5B5A A0 05                    ..
        jsr L5B6D                               ; 5B5C 20 6D 5B                  m[
L5B5F:  jmp DoneWithIO                          ; 5B5F 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        .byte"M-W"                              ; 5B62 4D 2D 57                 M-W
; ----------------------------------------------------------------------------
L5B65:  .byte$00                                ; 5B65 00                       .
L5B66:  .byte$05,$20                            ; 5B66 05 20                    . 
; ----------------------------------------------------------------------------
        .byte"M-E"                              ; 5B68 4D 2D 45                 M-E
; ----------------------------------------------------------------------------
        .word$0560                              ; 5B6B 60 05                    `.
; ----------------------------------------------------------------------------
L5B6D:  jsr L5B7D                               ; 5B6D 20 7D 5B                  }[
        bne L5B7C                               ; 5B70 D0 0A                    ..
        lda #$0D                                ; 5B72 A9 0D                    ..
        jsr LFFA8                               ; 5B74 20 A8 FF                  ..
        jsr LFFAE                               ; 5B77 20 AE FF                  ..
        ldx #$00                                ; 5B7A A2 00                    ..
L5B7C:  rts                                     ; 5B7C 60                       `

; ----------------------------------------------------------------------------
L5B7D:  sty L5BAA                               ; 5B7D 8C AA 5B                 ..[
        ldy #$00                                ; 5B80 A0 00                    ..
        sty STATUS                              ; 5B82 84 90                    ..
        jsr LFFB1                               ; 5B84 20 B1 FF                  ..
        lda STATUS                              ; 5B87 A5 90                    ..
        bne L5BA4                               ; 5B89 D0 19                    ..
        lda #$6F                                ; 5B8B A9 6F                    .o
        jsr LFF93                               ; 5B8D 20 93 FF                  ..
        lda STATUS                              ; 5B90 A5 90                    ..
        bne L5BA4                               ; 5B92 D0 10                    ..
        ldy #$00                                ; 5B94 A0 00                    ..
L5B96:  lda (z8b),y                             ; 5B96 B1 8B                    ..
        jsr LFFA8                               ; 5B98 20 A8 FF                  ..
        iny                                     ; 5B9B C8                       .
        cpy L5BAA                               ; 5B9C CC AA 5B                 ..[
        bne L5B96                               ; 5B9F D0 F5                    ..
        ldx #$00                                ; 5BA1 A2 00                    ..
        rts                                     ; 5BA3 60                       `

; ----------------------------------------------------------------------------
L5BA4:  jsr LFFAE                               ; 5BA4 20 AE FF                  ..
        ldx #$0D                                ; 5BA7 A2 0D                    ..
        rts                                     ; 5BA9 60                       `

; ----------------------------------------------------------------------------
L5BAA:  .byte$00                                ; 5BAA 00                       .
L5BAB:  .byte$00                                ; 5BAB 00                       .
L5BAC:  .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5BAC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5BB4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5BBC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5BC4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00        ; 5BCC 00 00 00 00 00 00 00     .......
; ----------------------------------------------------------------------------
L5BD3:  ldy #$00                                ; 5BD3 A0 00                    ..
        sty STATUS                              ; 5BD5 84 90                    ..
        jsr LFFB4                               ; 5BD7 20 B4 FF                  ..
        lda STATUS                              ; 5BDA A5 90                    ..
        bne L5BFE                               ; 5BDC D0 20                    . 
        lda #$6F                                ; 5BDE A9 6F                    .o
        jsr LFF96                               ; 5BE0 20 96 FF                  ..
        lda STATUS                              ; 5BE3 A5 90                    ..
        bne L5BFE                               ; 5BE5 D0 17                    ..
        ldy #$00                                ; 5BE7 A0 00                    ..
L5BE9:  jsr LFFA5                               ; 5BE9 20 A5 FF                  ..
        ldx STATUS                              ; 5BEC A6 90                    ..
        bne L5BF8                               ; 5BEE D0 08                    ..
        sta L5BAB,y                             ; 5BF0 99 AB 5B                 ..[
        iny                                     ; 5BF3 C8                       .
        cpy #$28                                ; 5BF4 C0 28                    .(
        bcc L5BE9                               ; 5BF6 90 F1                    ..
L5BF8:  jsr LFFAB                               ; 5BF8 20 AB FF                  ..
        ldx #$00                                ; 5BFB A2 00                    ..
        rts                                     ; 5BFD 60                       `

; ----------------------------------------------------------------------------
L5BFE:  jsr LFFAB                               ; 5BFE 20 AB FF                  ..
        ldx #$0D                                ; 5C01 A2 0D                    ..
        rts                                     ; 5C03 60                       `

; ----------------------------------------------------------------------------
L5C04:  jsr L50FD                               ; 5C04 20 FD 50                  .P
        ldx #$01                                ; 5C07 A2 01                    ..
        jsr L519F                               ; 5C09 20 9F 51                  .Q
        jsr L50D7                               ; 5C0C 20 D7 50                  .P
        ldx L5430                               ; 5C0F AE 30 54                 .0T
        rts                                     ; 5C12 60                       `

; ----------------------------------------------------------------------------
L5C13:  jsr L9050                               ; 5C13 20 50 90                  P.
        lda #$00                                ; 5C16 A9 00                    ..
        sta r2L                                 ; 5C18 85 06                    ..
        jsr L9066                               ; 5C1A 20 66 90                  f.
        lda #$82                                ; 5C1D A9 82                    ..
        sta r0H                                 ; 5C1F 85 03                    ..
        lda #$90                                ; 5C21 A9 90                    ..
        sta r0L                                 ; 5C23 85 02                    ..
        lda #$50                                ; 5C25 A9 50                    .P
        sta r1H                                 ; 5C27 85 05                    ..
        lda #$0F                                ; 5C29 A9 0F                    ..
        sta r1L                                 ; 5C2B 85 04                    ..
        ldx #$02                                ; 5C2D A2 02                    ..
        ldy #$04                                ; 5C2F A0 04                    ..
        lda #$10                                ; 5C31 A9 10                    ..
        jsr CopyFString                         ; 5C33 20 68 C2                  h.
        lda $82A3                               ; 5C36 AD A3 82                 ...
        sta L54B3                               ; 5C39 8D B3 54                 ..T
        lda $82A2                               ; 5C3C AD A2 82                 ...
        sta L54B2                               ; 5C3F 8D B2 54                 ..T
        lda $82AC                               ; 5C42 AD AC 82                 ...
        sta L5C77                               ; 5C45 8D 77 5C                 .w\
        lda $82AB                               ; 5C48 AD AB 82                 ...
        sta L5C76                               ; 5C4B 8D 76 5C                 .v\
        jsr L5C78                               ; 5C4E 20 78 5C                  x\
        lda L5C77                               ; 5C51 AD 77 5C                 .w\
        sta $82AC                               ; 5C54 8D AC 82                 ...
        lda L5C76                               ; 5C57 AD 76 5C                 .v\
        sta $82AB                               ; 5C5A 8D AB 82                 ...
        jsr L5C9C                               ; 5C5D 20 9C 5C                  .\
        jsr L5CD9                               ; 5C60 20 D9 5C                  .\
        jsr PutDirHead                          ; 5C63 20 4A C2                  J.
        stx L5430                               ; 5C66 8E 30 54                 .0T
        beq L5C75                               ; 5C69 F0 0A                    ..
        lda #$54                                ; 5C6B A9 54                    .T
        sta L53D7                               ; 5C6D 8D D7 53                 ..S
        lda #$03                                ; 5C70 A9 03                    ..
        sta L53D6                               ; 5C72 8D D6 53                 ..S
L5C75:  rts                                     ; 5C75 60                       `

; ----------------------------------------------------------------------------
L5C76:  brk                                     ; 5C76 00                       .
L5C77:  brk                                     ; 5C77 00                       .
L5C78:  lda $88C6                               ; 5C78 AD C6 88                 ...
        and #$0F                                ; 5C7B 29 0F                    ).
        cmp #$04                                ; 5C7D C9 04                    ..
        bne L5C84                               ; 5C7F D0 03                    ..
        jmp L5CE4                               ; 5C81 4C E4 5C                 L.\

; ----------------------------------------------------------------------------
L5C84:  cmp #$03                                ; 5C84 C9 03                    ..
        bne L5C8B                               ; 5C86 D0 03                    ..
        jmp L5653                               ; 5C88 4C 53 56                 LSV

; ----------------------------------------------------------------------------
L5C8B:  cmp #$02                                ; 5C8B C9 02                    ..
        bne L5C92                               ; 5C8D D0 03                    ..
        jmp L5D52                               ; 5C8F 4C 52 5D                 LR]

; ----------------------------------------------------------------------------
L5C92:  cmp #$01                                ; 5C92 C9 01                    ..
        bne L5C99                               ; 5C94 D0 03                    ..
        jmp L5D7E                               ; 5C96 4C 7E 5D                 L~]

; ----------------------------------------------------------------------------
L5C99:  ldx #$0D                                ; 5C99 A2 0D                    ..
        rts                                     ; 5C9B 60                       `

; ----------------------------------------------------------------------------
L5C9C:  lda $82AC                               ; 5C9C AD AC 82                 ...
        sta r1H                                 ; 5C9F 85 05                    ..
        lda $82AB                               ; 5CA1 AD AB 82                 ...
        sta r1L                                 ; 5CA4 85 04                    ..
        bne L5CA9                               ; 5CA6 D0 01                    ..
        rts                                     ; 5CA8 60                       `

; ----------------------------------------------------------------------------
L5CA9:  lda r1H                                 ; 5CA9 A5 05                    ..
        sta r6H                                 ; 5CAB 85 0F                    ..
        lda r1L                                 ; 5CAD A5 04                    ..
        sta r6L                                 ; 5CAF 85 0E                    ..
        jsr L9048                               ; 5CB1 20 48 90                  H.
L5CB4:  jsr L903C                               ; 5CB4 20 3C 90                  <.
        stx $8002                               ; 5CB7 8E 02 80                 ...
        stx $8022                               ; 5CBA 8E 22 80                 .".
        stx $8042                               ; 5CBD 8E 42 80                 .B.
        stx $8062                               ; 5CC0 8E 62 80                 .b.
        stx $8082                               ; 5CC3 8E 82 80                 ...
        stx $80A2                               ; 5CC6 8E A2 80                 ...
        stx $80C2                               ; 5CC9 8E C2 80                 ...
        stx $80E2                               ; 5CCC 8E E2 80                 ...
        stx diskBlkBuf                          ; 5CCF 8E 00 80                 ...
        dex                                     ; 5CD2 CA                       .
        stx $8001                               ; 5CD3 8E 01 80                 ...
        jmp PutBlock                            ; 5CD6 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L5CD9:  lda #$01                                ; 5CD9 A9 01                    ..
        sta r6L                                 ; 5CDB 85 0E                    ..
        lda #$00                                ; 5CDD A9 00                    ..
        sta r6H                                 ; 5CDF 85 0F                    ..
        jmp L9048                               ; 5CE1 4C 48 90                 LH.

; ----------------------------------------------------------------------------
L5CE4:  jsr GetDirHead                          ; 5CE4 20 47 C2                  G.
        lda #$01                                ; 5CE7 A9 01                    ..
        sta r1L                                 ; 5CE9 85 04                    ..
        lda #$22                                ; 5CEB A9 22                    ."
        sta r1H                                 ; 5CED 85 05                    ..
        jsr L5DAE                               ; 5CEF 20 AE 5D                  .]
        lda $9062                               ; 5CF2 AD 62 90                 .b.
        sta L5DAD                               ; 5CF5 8D AD 5D                 ..]
        jsr L5D35                               ; 5CF8 20 35 5D                  5]
        lda #$01                                ; 5CFB A9 01                    ..
        sta r6L                                 ; 5CFD 85 0E                    ..
        lda #$22                                ; 5CFF A9 22                    ."
        sta r6H                                 ; 5D01 85 0F                    ..
        jsr L5D2D                               ; 5D03 20 2D 5D                  -]
        jmp PutDirHead                          ; 5D06 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D09:  jsr GetDirHead                          ; 5D09 20 47 C2                  G.
        lda #$28                                ; 5D0C A9 28                    .(
        sta r1L                                 ; 5D0E 85 04                    ..
        lda #$03                                ; 5D10 A9 03                    ..
        sta r1H                                 ; 5D12 85 05                    ..
        jsr L5DAE                               ; 5D14 20 AE 5D                  .]
        lda #$50                                ; 5D17 A9 50                    .P
        sta L5DAD                               ; 5D19 8D AD 5D                 ..]
        jsr L5D35                               ; 5D1C 20 35 5D                  5]
        lda #$28                                ; 5D1F A9 28                    .(
        sta r6L                                 ; 5D21 85 0E                    ..
        lda #$03                                ; 5D23 A9 03                    ..
        sta r6H                                 ; 5D25 85 0F                    ..
        jsr L5D2D                               ; 5D27 20 2D 5D                  -]
        jmp PutDirHead                          ; 5D2A 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D2D:  jsr L9048                               ; 5D2D 20 48 90                  H.
        dec r6H                                 ; 5D30 C6 0F                    ..
        bpl L5D2D                               ; 5D32 10 F9                    ..
        rts                                     ; 5D34 60                       `

; ----------------------------------------------------------------------------
L5D35:  lda #$01                                ; 5D35 A9 01                    ..
        sta r6L                                 ; 5D37 85 0E                    ..
L5D39:  lda #$00                                ; 5D39 A9 00                    ..
        sta r6H                                 ; 5D3B 85 0F                    ..
L5D3D:  jsr FreeBlock                           ; 5D3D 20 B9 C2                  ..
        cpx #$02                                ; 5D40 E0 02                    ..
        beq L5D48                               ; 5D42 F0 04                    ..
        inc r6H                                 ; 5D44 E6 0F                    ..
        bne L5D3D                               ; 5D46 D0 F5                    ..
L5D48:  inc r6L                                 ; 5D48 E6 0E                    ..
        lda L5DAD                               ; 5D4A AD AD 5D                 ..]
        cmp r6L                                 ; 5D4D C5 0E                    ..
        bcs L5D39                               ; 5D4F B0 E8                    ..
        rts                                     ; 5D51 60                       `

; ----------------------------------------------------------------------------
L5D52:  jsr GetDirHead                          ; 5D52 20 47 C2                  G.
        bit $8203                               ; 5D55 2C 03 82                 ,..
        bpl L5D89                               ; 5D58 10 2F                    ./
        ldy #$00                                ; 5D5A A0 00                    ..
        tya                                     ; 5D5C 98                       .
L5D5D:  sta $8900,y                             ; 5D5D 99 00 89                 ...
        iny                                     ; 5D60 C8                       .
        bne L5D5D                               ; 5D61 D0 FA                    ..
        ldy #$DD                                ; 5D63 A0 DD                    ..
L5D65:  sta curDirHead,y                        ; 5D65 99 00 82                 ...
        iny                                     ; 5D68 C8                       .
        bne L5D65                               ; 5D69 D0 FA                    ..
        lda #$46                                ; 5D6B A9 46                    .F
        jsr L5D91                               ; 5D6D 20 91 5D                  .]
        lda #$35                                ; 5D70 A9 35                    .5
        sta r6L                                 ; 5D72 85 0E                    ..
        lda #$12                                ; 5D74 A9 12                    ..
        sta r6H                                 ; 5D76 85 0F                    ..
        jsr L5D2D                               ; 5D78 20 2D 5D                  -]
        jmp PutDirHead                          ; 5D7B 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D7E:  jsr GetDirHead                          ; 5D7E 20 47 C2                  G.
        bit $8203                               ; 5D81 2C 03 82                 ,..
        bpl L5D89                               ; 5D84 10 03                    ..
        ldx #$06                                ; 5D86 A2 06                    ..
        rts                                     ; 5D88 60                       `

; ----------------------------------------------------------------------------
L5D89:  lda #$23                                ; 5D89 A9 23                    .#
        jsr L5D91                               ; 5D8B 20 91 5D                  .]
        jmp PutDirHead                          ; 5D8E 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D91:  sta L5DAD                               ; 5D91 8D AD 5D                 ..]
        lda #$12                                ; 5D94 A9 12                    ..
        sta r1L                                 ; 5D96 85 04                    ..
        lda #$01                                ; 5D98 A9 01                    ..
        sta r1H                                 ; 5D9A 85 05                    ..
        jsr L5DAE                               ; 5D9C 20 AE 5D                  .]
        jsr L5D35                               ; 5D9F 20 35 5D                  5]
        lda #$12                                ; 5DA2 A9 12                    ..
        sta r6L                                 ; 5DA4 85 0E                    ..
        lda #$01                                ; 5DA6 A9 01                    ..
        sta r6H                                 ; 5DA8 85 0F                    ..
        jmp L5D2D                               ; 5DAA 4C 2D 5D                 L-]

; ----------------------------------------------------------------------------
L5DAD:  brk                                     ; 5DAD 00                       .
L5DAE:  jsr ExitTurbo                           ; 5DAE 20 32 C2                  2.
        jsr EnterTurbo                          ; 5DB1 20 14 C2                  ..
        jsr L903C                               ; 5DB4 20 3C 90                  <.
        ldy #$00                                ; 5DB7 A0 00                    ..
L5DB9:  lda #$00                                ; 5DB9 A9 00                    ..
        sta $8002,y                             ; 5DBB 99 02 80                 ...
        tya                                     ; 5DBE 98                       .
        clc                                     ; 5DBF 18                       .
        adc #$20                                ; 5DC0 69 20                    i 
        tay                                     ; 5DC2 A8                       .
        bcc L5DB9                               ; 5DC3 90 F4                    ..
        ldx #$FF                                ; 5DC5 A2 FF                    ..
        stx $8001                               ; 5DC7 8E 01 80                 ...
        inx                                     ; 5DCA E8                       .
        stx diskBlkBuf                          ; 5DCB 8E 00 80                 ...
        jmp PutBlock                            ; 5DCE 4C E7 C1                 L..

; ----------------------------------------------------------------------------
