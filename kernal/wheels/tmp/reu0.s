; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu0.bin
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
L0810       := $0810
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
        jmp L51B6                               ; 5000 4C B6 51                 L.Q

; ----------------------------------------------------------------------------
        jmp L51D8                               ; 5003 4C D8 51                 L.Q

; ----------------------------------------------------------------------------
        jmp L51E6                               ; 5006 4C E6 51                 L.Q

; ----------------------------------------------------------------------------
        jmp L51F3                               ; 5009 4C F3 51                 L.Q

; ----------------------------------------------------------------------------
        jmp L5208                               ; 500C 4C 08 52                 L.R

; ----------------------------------------------------------------------------
        jmp L5235                               ; 500F 4C 35 52                 L5R

; ----------------------------------------------------------------------------
        jmp L5266                               ; 5012 4C 66 52                 LfR

; ----------------------------------------------------------------------------
        jmp L52C8                               ; 5015 4C C8 52                 L.R

; ----------------------------------------------------------------------------
        jmp L5325                               ; 5018 4C 25 53                 L%S

; ----------------------------------------------------------------------------
        jmp L5374                               ; 501B 4C 74 53                 LtS

; ----------------------------------------------------------------------------
        jmp L52F4                               ; 501E 4C F4 52                 L.R

; ----------------------------------------------------------------------------
        .byte"MR"                               ; 5021 4D 52                    MR
        .byte$22                                ; 5023 22                       "
; ----------------------------------------------------------------------------
L5024:  .byte$00                                ; 5024 00                       .
L5025:  .byte$7E,$00,$00,$00,$00,$00,$00,$00    ; 5025 7E 00 00 00 00 00 00 00  ~.......
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 502D 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5035 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 503D 00 00 00 00 00 00 00 00  ........
L5045:  .byte$7E,$00,$00,$00,$00,$00,$00,$00    ; 5045 7E 00 00 00 00 00 00 00  ~.......
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 504D 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5055 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00        ; 505D 00 00 00 00 00 00 00     .......
L5064:  .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5064 00 00 00 00 00 00 00 00  ........
L506C:  .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 506C 00 00 00 00 00 00 00 00  ........
L5074:  .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5074 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 507C 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5084 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 508C 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 5094 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 509C 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50A4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50AC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50B4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50BC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50C4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50CC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50D4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50DC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50E4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50EC 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50F4 00 00 00 00 00 00 00 00  ........
        .byte$00,$00,$00,$00,$00,$00,$00,$00    ; 50FC 00 00 00 00 00 00 00 00  ........
        .byte$00,$42,$51,$7B,$51                ; 5104 00 42 51 7B 51           .BQ{Q
L5109:  .byte$59,$17,$35,$1F,$2F,$3D,$FF,$FF    ; 5109 59 17 35 1F 2F 3D FF FF  Y.5./=..
        .byte$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF    ; 5111 FF FF FF FF FF FF FF FF  ........
        .byte$FF,$69,$15,$1F,$33,$35,$1B,$FF    ; 5119 FF 69 15 1F 33 35 1B FF  .i..35..
        .byte$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF    ; 5121 FF FF FF FF FF FF FF FF  ........
        .byte$FF,$FF,$51,$6F,$A5,$9D,$9B,$99    ; 5129 FF FF 51 6F A5 9D 9B 99  ..Qo....
        .byte$9B,$7D,$FF,$61,$11,$23,$35,$1B    ; 5131 9B 7D FF 61 11 23 35 1B  .}.a.#5.
        .byte$8B,$BF,$FF,$53,$6D,$63,$8B,$BF    ; 5139 8B BF FF 53 6D 63 8B BF  ...Smc..
        .byte$FF                                ; 5141 FF                       .
; ----------------------------------------------------------------------------
        jsr L51A7                               ; 5142 20 A7 51                  .Q
        lda r11H                                ; 5145 A5 19                    ..
        pha                                     ; 5147 48                       H
        lda r11L                                ; 5148 A5 18                    ..
        pha                                     ; 514A 48                       H
        jsr L5194                               ; 514B 20 94 51                  .Q
        jsr L518B                               ; 514E 20 8B 51                  .Q
        lda #$20                                ; 5151 A9 20                    . 
        jsr PutChar                             ; 5153 20 45 C1                  E.
        jsr L518E                               ; 5156 20 8E 51                  .Q
        pla                                     ; 5159 68                       h
        sta r11L                                ; 515A 85 18                    ..
        pla                                     ; 515C 68                       h
        sta r11H                                ; 515D 85 19                    ..
        clc                                     ; 515F 18                       .
        lda r1H                                 ; 5160 A5 05                    ..
        adc #$0A                                ; 5162 69 0A                    i.
        sta r1H                                 ; 5164 85 05                    ..
        jsr L5197                               ; 5166 20 97 51                  .Q
        jsr L5191                               ; 5169 20 91 51                  .Q
L516C:  ldx #$38                                ; 516C A2 38                    .8
L516E:  lda L5109,x                             ; 516E BD 09 51                 ..Q
        asl a                                   ; 5171 0A                       .
        eor #$FF                                ; 5172 49 FF                    I.
        sta L5109,x                             ; 5174 9D 09 51                 ..Q
        dex                                     ; 5177 CA                       .
        bpl L516E                               ; 5178 10 F4                    ..
        rts                                     ; 517A 60                       `

; ----------------------------------------------------------------------------
        jsr L51A7                               ; 517B 20 A7 51                  .Q
        ldy #$2A                                ; 517E A0 2A                    .*
L5180:  lda L5109,y                             ; 5180 B9 09 51                 ..Q
        sta (r0L),y                             ; 5183 91 02                    ..
        dey                                     ; 5185 88                       .
        bpl L5180                               ; 5186 10 F8                    ..
        jmp L516C                               ; 5188 4C 6C 51                 LlQ

; ----------------------------------------------------------------------------
L518B:  lda #$00                                ; 518B A9 00                    ..
        .byte$2C                                ; 518D 2C                       ,
L518E:  lda #$11                                ; 518E A9 11                    ..
        .byte$2C                                ; 5190 2C                       ,
L5191:  lda #$22                                ; 5191 A9 22                    ."
        .byte$2C                                ; 5193 2C                       ,
L5194:  lda #$2B                                ; 5194 A9 2B                    .+
        .byte$2C                                ; 5196 2C                       ,
L5197:  lda #$33                                ; 5197 A9 33                    .3
        clc                                     ; 5199 18                       .
        adc #$09                                ; 519A 69 09                    i.
        sta r0L                                 ; 519C 85 02                    ..
        lda #$51                                ; 519E A9 51                    .Q
        adc #$00                                ; 51A0 69 00                    i.
        sta r0H                                 ; 51A2 85 03                    ..
        jmp PutString                           ; 51A4 4C 48 C1                 LH.

; ----------------------------------------------------------------------------
L51A7:  ldx #$38                                ; 51A7 A2 38                    .8
L51A9:  lda L5109,x                             ; 51A9 BD 09 51                 ..Q
        eor #$FF                                ; 51AC 49 FF                    I.
        lsr a                                   ; 51AE 4A                       J
        sta L5109,x                             ; 51AF 9D 09 51                 ..Q
        dex                                     ; 51B2 CA                       .
        bpl L51A9                               ; 51B3 10 F4                    ..
        rts                                     ; 51B5 60                       `

; ----------------------------------------------------------------------------
L51B6:  ldy #$1F                                ; 51B6 A0 1F                    ..
L51B8:  lda L5025,y                             ; 51B8 B9 25 50                 .%P
        sta L5045,y                             ; 51BB 99 45 50                 .EP
        dey                                     ; 51BE 88                       .
        bpl L51B8                               ; 51BF 10 F7                    ..
L51C1:  tya                                     ; 51C1 98                       .
        pha                                     ; 51C2 48                       H
        ldy #$00                                ; 51C3 A0 00                    ..
        tya                                     ; 51C5 98                       .
L51C6:  eor L5025,y                             ; 51C6 59 25 50                 Y%P
        clc                                     ; 51C9 18                       .
        adc L5025,y                             ; 51CA 79 25 50                 y%P
        iny                                     ; 51CD C8                       .
        cpy #$E0                                ; 51CE C0 E0                    ..
        bcc L51C6                               ; 51D0 90 F4                    ..
        sta L5024                               ; 51D2 8D 24 50                 .$P
        pla                                     ; 51D5 68                       h
        tay                                     ; 51D6 A8                       .
        rts                                     ; 51D7 60                       `

; ----------------------------------------------------------------------------
L51D8:  ldy #$1F                                ; 51D8 A0 1F                    ..
L51DA:  lda L5045,y                             ; 51DA B9 45 50                 .EP
        sta L5025,y                             ; 51DD 99 25 50                 .%P
        dey                                     ; 51E0 88                       .
        bpl L51DA                               ; 51E1 10 F7                    ..
        jmp L51C1                               ; 51E3 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L51E6:  ldy #$1F                                ; 51E6 A0 1F                    ..
        lda #$00                                ; 51E8 A9 00                    ..
L51EA:  sta L5045,y                             ; 51EA 99 45 50                 .EP
        dey                                     ; 51ED 88                       .
        bpl L51EA                               ; 51EE 10 FA                    ..
        jmp L51C1                               ; 51F0 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L51F3:  jsr L5212                               ; 51F3 20 12 52                  .R
        bcs L520F                               ; 51F6 B0 17                    ..
        beq L520F                               ; 51F8 F0 15                    ..
L51FA:  lda L522D,x                             ; 51FA BD 2D 52                 .-R
        eor L5045,y                             ; 51FD 59 45 50                 YEP
        sta L5045,y                             ; 5200 99 45 50                 .EP
        ldx #$00                                ; 5203 A2 00                    ..
        jmp L51C1                               ; 5205 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L5208:  jsr L5212                               ; 5208 20 12 52                  .R
        bcs L520F                               ; 520B B0 02                    ..
        beq L51FA                               ; 520D F0 EB                    ..
L520F:  ldx #$06                                ; 520F A2 06                    ..
        rts                                     ; 5211 60                       `

; ----------------------------------------------------------------------------
L5212:  sec                                     ; 5212 38                       8
        lda r6L                                 ; 5213 A5 0E                    ..
        beq L522C                               ; 5215 F0 15                    ..
        cmp $88C3                               ; 5217 CD C3 88                 ...
        bcs L522C                               ; 521A B0 10                    ..
        pha                                     ; 521C 48                       H
        lsr a                                   ; 521D 4A                       J
        lsr a                                   ; 521E 4A                       J
        lsr a                                   ; 521F 4A                       J
        tay                                     ; 5220 A8                       .
        pla                                     ; 5221 68                       h
        and #$07                                ; 5222 29 07                    ).
        tax                                     ; 5224 AA                       .
        lda L522D,x                             ; 5225 BD 2D 52                 .-R
        and L5045,y                             ; 5228 39 45 50                 9EP
        clc                                     ; 522B 18                       .
L522C:  rts                                     ; 522C 60                       `

; ----------------------------------------------------------------------------
L522D:  .byte$80                                ; 522D 80                       .
        rti                                     ; 522E 40                       @

; ----------------------------------------------------------------------------
        jsr L0810                               ; 522F 20 10 08                  ..
        .byte$04                                ; 5232 04                       .
        .byte$02                                ; 5233 02                       .
        .byte$01                                ; 5234 01                       .
L5235:  jsr L51B6                               ; 5235 20 B6 51                  .Q
        ldx $88C3                               ; 5238 AE C3 88                 ...
        dex                                     ; 523B CA                       .
        stx r2L                                 ; 523C 86 06                    ..
        lda #$00                                ; 523E A9 00                    ..
        sta r3L                                 ; 5240 85 08                    ..
        jsr L5266                               ; 5242 20 66 52                  fR
        lda r6H                                 ; 5245 A5 0F                    ..
        sta r2L                                 ; 5247 85 06                    ..
        jsr L51B6                               ; 5249 20 B6 51                  .Q
        lda #$00                                ; 524C A9 00                    ..
        sta r4L                                 ; 524E 85 0A                    ..
        sta r4H                                 ; 5250 85 0B                    ..
        lda #$01                                ; 5252 A9 01                    ..
        sta r6L                                 ; 5254 85 0E                    ..
L5256:  jsr L5212                               ; 5256 20 12 52                  .R
        bcs L5263                               ; 5259 B0 08                    ..
        beq L525F                               ; 525B F0 02                    ..
        inc r4H                                 ; 525D E6 0B                    ..
L525F:  inc r6L                                 ; 525F E6 0E                    ..
        bne L5256                               ; 5261 D0 F3                    ..
L5263:  jmp L51B6                               ; 5263 4C B6 51                 L.Q

; ----------------------------------------------------------------------------
L5266:  ldx r3L                                 ; 5266 A6 08                    ..
        stx L52C7                               ; 5268 8E C7 52                 ..R
        bne L526E                               ; 526B D0 01                    ..
        inx                                     ; 526D E8                       .
L526E:  stx r6L                                 ; 526E 86 0E                    ..
        stx r3L                                 ; 5270 86 08                    ..
        stx r9L                                 ; 5272 86 14                    ..
        lda #$00                                ; 5274 A9 00                    ..
        sta r6H                                 ; 5276 85 0F                    ..
        lda r2L                                 ; 5278 A5 06                    ..
        sta r3H                                 ; 527A 85 09                    ..
L527C:  lda #$00                                ; 527C A9 00                    ..
        sta r2H                                 ; 527E 85 07                    ..
L5280:  jsr L5212                               ; 5280 20 12 52                  .R
        bcs L52C4                               ; 5283 B0 3F                    .?
        bne L5293                               ; 5285 D0 0C                    ..
        lda r2L                                 ; 5287 A5 06                    ..
        sta r3H                                 ; 5289 85 09                    ..
        inc r6L                                 ; 528B E6 0E                    ..
        lda r6L                                 ; 528D A5 0E                    ..
        sta r9L                                 ; 528F 85 14                    ..
        bne L527C                               ; 5291 D0 E9                    ..
L5293:  inc r2H                                 ; 5293 E6 07                    ..
        lda r2H                                 ; 5295 A5 07                    ..
        cmp r6H                                 ; 5297 C5 0F                    ..
        bcc L52A1                               ; 5299 90 06                    ..
        sta r6H                                 ; 529B 85 0F                    ..
        lda r9L                                 ; 529D A5 14                    ..
        sta r3L                                 ; 529F 85 08                    ..
L52A1:  inc r6L                                 ; 52A1 E6 0E                    ..
        dec r3H                                 ; 52A3 C6 09                    ..
        bne L5280                               ; 52A5 D0 D9                    ..
        lda r2H                                 ; 52A7 A5 07                    ..
        sta r3H                                 ; 52A9 85 09                    ..
        lda r9L                                 ; 52AB A5 14                    ..
        sta r6L                                 ; 52AD 85 0E                    ..
        lda L52C7                               ; 52AF AD C7 52                 ..R
        beq L52B8                               ; 52B2 F0 04                    ..
        cmp r3L                                 ; 52B4 C5 08                    ..
        bne L52C4                               ; 52B6 D0 0C                    ..
L52B8:  jsr L51F3                               ; 52B8 20 F3 51                  .Q
        inc r6L                                 ; 52BB E6 0E                    ..
        dec r3H                                 ; 52BD C6 09                    ..
        bne L52B8                               ; 52BF D0 F7                    ..
        ldx #$00                                ; 52C1 A2 00                    ..
        rts                                     ; 52C3 60                       `

; ----------------------------------------------------------------------------
L52C4:  ldx #$03                                ; 52C4 A2 03                    ..
        rts                                     ; 52C6 60                       `

; ----------------------------------------------------------------------------
L52C7:  .byte$01                                ; 52C7 01                       .
L52C8:  lda NUMDRV                              ; 52C8 AD 8D 84                 ...
        cmp #$02                                ; 52CB C9 02                    ..
        bcc L52F3                               ; 52CD 90 24                    .$
        ldy r4L                                 ; 52CF A4 0A                    ..
        lda $8486,y                             ; 52D1 B9 86 84                 ...
        beq L52F3                               ; 52D4 F0 1D                    ..
        tya                                     ; 52D6 98                       .
        jsr SetDevice                           ; 52D7 20 B0 C2                  ..
        jsr PurgeTurbo                          ; 52DA 20 35 C2                  5.
        lda #$00                                ; 52DD A9 00                    ..
        ldy curDrive                            ; 52DF AC 89 84                 ...
        sta $8486,y                             ; 52E2 99 86 84                 ...
        sta $88BF,y                             ; 52E5 99 BF 88                 ...
        sta $88C6                               ; 52E8 8D C6 88                 ...
        sta curDrive                            ; 52EB 8D 89 84                 ...
        sta curDevice                           ; 52EE 85 BA                    ..
        dec NUMDRV                              ; 52F0 CE 8D 84                 ...
L52F3:  rts                                     ; 52F3 60                       `

; ----------------------------------------------------------------------------
L52F4:  tya                                     ; 52F4 98                       .
        pha                                     ; 52F5 48                       H
        lda L5064,y                             ; 52F6 B9 64 50                 .dP
        sta r7L                                 ; 52F9 85 10                    ..
        lda L5074,y                             ; 52FB B9 74 50                 .tP
        sta r2L                                 ; 52FE 85 06                    ..
        lda L506C,y                             ; 5300 B9 6C 50                 .lP
        sta r3L                                 ; 5303 85 08                    ..
        jsr L530B                               ; 5305 20 0B 53                  .S
        pla                                     ; 5308 68                       h
        tay                                     ; 5309 A8                       .
        rts                                     ; 530A 60                       `

; ----------------------------------------------------------------------------
L530B:  lda #$50                                ; 530B A9 50                    .P
        sta r1H                                 ; 530D 85 05                    ..
        lda #$7D                                ; 530F A9 7D                    .}
        sta r1L                                 ; 5311 85 04                    ..
        dey                                     ; 5313 88                       .
        beq L5324                               ; 5314 F0 0E                    ..
L5316:  clc                                     ; 5316 18                       .
        lda #$11                                ; 5317 A9 11                    ..
        adc r1L                                 ; 5319 65 04                    e.
        sta r1L                                 ; 531B 85 04                    ..
        bcc L5321                               ; 531D 90 02                    ..
        inc r1H                                 ; 531F E6 05                    ..
L5321:  dey                                     ; 5321 88                       .
        bne L5316                               ; 5322 D0 F2                    ..
L5324:  rts                                     ; 5324 60                       `

; ----------------------------------------------------------------------------
L5325:  ldx #$04                                ; 5325 A2 04                    ..
        tya                                     ; 5327 98                       .
        beq L5334                               ; 5328 F0 0A                    ..
        cpy #$09                                ; 532A C0 09                    ..
        bcs L5372                               ; 532C B0 44                    .D
        lda L506C,y                             ; 532E B9 6C 50                 .lP
        beq L5340                               ; 5331 F0 0D                    ..
        rts                                     ; 5333 60                       `

; ----------------------------------------------------------------------------
L5334:  iny                                     ; 5334 C8                       .
L5335:  lda L506C,y                             ; 5335 B9 6C 50                 .lP
        beq L5340                               ; 5338 F0 06                    ..
        iny                                     ; 533A C8                       .
        cpy #$09                                ; 533B C0 09                    ..
        bcc L5335                               ; 533D 90 F6                    ..
        rts                                     ; 533F 60                       `

; ----------------------------------------------------------------------------
L5340:  sty L5373                               ; 5340 8C 73 53                 .sS
        jsr L51B6                               ; 5343 20 B6 51                  .Q
        jsr L5266                               ; 5346 20 66 52                  fR
        txa                                     ; 5349 8A                       .
        bne L5372                               ; 534A D0 26                    .&
        ldy L5373                               ; 534C AC 73 53                 .sS
        lda r3L                                 ; 534F A5 08                    ..
        sta L506C,y                             ; 5351 99 6C 50                 .lP
        lda r2L                                 ; 5354 A5 06                    ..
        sta L5074,y                             ; 5356 99 74 50                 .tP
        lda r7L                                 ; 5359 A5 10                    ..
        sta L5064,y                             ; 535B 99 64 50                 .dP
        jsr L530B                               ; 535E 20 0B 53                  .S
        ldy #$10                                ; 5361 A0 10                    ..
L5363:  lda (r0L),y                             ; 5363 B1 02                    ..
        sta (r1L),y                             ; 5365 91 04                    ..
        dey                                     ; 5367 88                       .
        bpl L5363                               ; 5368 10 F9                    ..
        jsr L51D8                               ; 536A 20 D8 51                  .Q
        ldy L5373                               ; 536D AC 73 53                 .sS
        ldx #$00                                ; 5370 A2 00                    ..
L5372:  rts                                     ; 5372 60                       `

; ----------------------------------------------------------------------------
L5373:  .byte$01                                ; 5373 01                       .
L5374:  ldx #$0D                                ; 5374 A2 0D                    ..
        tya                                     ; 5376 98                       .
        beq L5382                               ; 5377 F0 09                    ..
        cpy #$09                                ; 5379 C0 09                    ..
        bcs L5382                               ; 537B B0 05                    ..
        lda L506C,y                             ; 537D B9 6C 50                 .lP
        bne L5383                               ; 5380 D0 01                    ..
L5382:  rts                                     ; 5382 60                       `

; ----------------------------------------------------------------------------
L5383:  sty L5373                               ; 5383 8C 73 53                 .sS
        jsr L51B6                               ; 5386 20 B6 51                  .Q
        ldy L5373                               ; 5389 AC 73 53                 .sS
        lda L506C,y                             ; 538C B9 6C 50                 .lP
        sta r6L                                 ; 538F 85 0E                    ..
        lda L5074,y                             ; 5391 B9 74 50                 .tP
        sta r3H                                 ; 5394 85 09                    ..
        beq L53A1                               ; 5396 F0 09                    ..
L5398:  jsr L5208                               ; 5398 20 08 52                  .R
        inc r6L                                 ; 539B E6 0E                    ..
        dec r3H                                 ; 539D C6 09                    ..
        bne L5398                               ; 539F D0 F7                    ..
L53A1:  ldy L5373                               ; 53A1 AC 73 53                 .sS
        lda #$00                                ; 53A4 A9 00                    ..
        sta L5064,y                             ; 53A6 99 64 50                 .dP
        sta L5074,y                             ; 53A9 99 74 50                 .tP
        sta L506C,y                             ; 53AC 99 6C 50                 .lP
        jsr L530B                               ; 53AF 20 0B 53                  .S
        ldy #$00                                ; 53B2 A0 00                    ..
        tya                                     ; 53B4 98                       .
        sta (r1L),y                             ; 53B5 91 04                    ..
        jsr L51D8                               ; 53B7 20 D8 51                  .Q
        ldx #$00                                ; 53BA A2 00                    ..
        rts                                     ; 53BC 60                       `

; ----------------------------------------------------------------------------
