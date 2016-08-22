; da65 V2.15
; Created:    2016-09-01 22:20:21
; Input file: reu10.bin
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
L7909       := $7909
L795E       := $795E
L79BC       := $79BC
L79C9       := $79C9
L7A3A       := $7A3A
L7A85       := $7A85
L7A97       := $7A97
L7AA9       := $7AA9
L7B11       := $7B11
L7B57       := $7B57
L7BA4       := $7BA4
L7BD8       := $7BD8
L7C00       := $7C00
L7C9E       := $7C9E
L7CB7       := $7CB7
L7CEC       := $7CEC
L7D17       := $7D17
L7D2A       := $7D2A
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
L9050       := $9050
L9053       := $9053
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
LC313       := $C313
LCFD9       := $CFD9
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
        jmp L5021                               ; 5000 4C 21 50                 L!P

; ----------------------------------------------------------------------------
        lda #$00                                ; 5003 A9 00                    ..
        bit $80A9                               ; 5005 2C A9 80                 ,..
        bit $03A9                               ; 5008 2C A9 03                 ,..
        bit $06A9                               ; 500B 2C A9 06                 ,..
        tax                                     ; 500E AA                       .
        bmi L5034                               ; 500F 30 23                    0#
        pha                                     ; 5011 48                       H
        jsr i_MoveData                          ; 5012 20 B7 C1                  ..
L5015:  .addrL5137                              ; 5015 37 51                    7Q
        .addrPRINTBASE                          ; 5017 00 79                    .y
; ----------------------------------------------------------------------------
        .word$045B                              ; 5019 5B 04                    [.
; ----------------------------------------------------------------------------
        ldx #$79                                ; 501B A2 79                    .y
        pla                                     ; 501D 68                       h
        jmp CallRoutine                         ; 501E 4C D8 C1                 L..

; ----------------------------------------------------------------------------
L5021:  lda #$C3                                ; 5021 A9 C3                    ..
        sta r1H                                 ; 5023 85 05                    ..
        lda #$CF                                ; 5025 A9 CF                    ..
        sta r1L                                 ; 5027 85 04                    ..
        lda #$00                                ; 5029 A9 00                    ..
        sta r2H                                 ; 502B 85 07                    ..
        lda #$09                                ; 502D A9 09                    ..
        sta r2L                                 ; 502F 85 06                    ..
        jmp MoveData                            ; 5031 4C 7E C1                 L~.

; ----------------------------------------------------------------------------
L5034:  lda $8416                               ; 5034 AD 16 84                 ...
        cmp #$09                                ; 5037 C9 09                    ..
        beq L506D                               ; 5039 F0 32                    .2
        cmp #$0A                                ; 503B C9 0A                    ..
        beq L5042                               ; 503D F0 03                    ..
        ldx #$05                                ; 503F A2 05                    ..
L5041:  rts                                     ; 5041 60                       `

; ----------------------------------------------------------------------------
L5042:  lda $8402                               ; 5042 AD 02 84                 ...
        sta r1H                                 ; 5045 85 05                    ..
        lda $8401                               ; 5047 AD 01 84                 ...
        sta r1L                                 ; 504A 85 04                    ..
        lda #$FE                                ; 504C A9 FE                    ..
        sta r7H                                 ; 504E 85 11                    ..
        lda #$80                                ; 5050 A9 80                    ..
        sta r7L                                 ; 5052 85 10                    ..
        lda #$01                                ; 5054 A9 01                    ..
        sta r2H                                 ; 5056 85 07                    ..
        lda #$7A                                ; 5058 A9 7A                    .z
        sta r2L                                 ; 505A 85 06                    ..
        jsr L5195                               ; 505C 20 95 51                  .Q
        txa                                     ; 505F 8A                       .
        bne L5041                               ; 5060 D0 DF                    ..
        lda #$88                                ; 5062 A9 88                    ..
        sta r2H                                 ; 5064 85 07                    ..
        lda #$CB                                ; 5066 A9 CB                    ..
        sta r2L                                 ; 5068 85 06                    ..
        jmp L5112                               ; 506A 4C 12 51                 L.Q

; ----------------------------------------------------------------------------
L506D:  lda #$84                                ; 506D A9 84                    ..
        sta r9H                                 ; 506F 85 15                    ..
        lda #$00                                ; 5071 A9 00                    ..
        sta r9L                                 ; 5073 85 14                    ..
        jsr GetFHdrInfo                         ; 5075 20 29 C2                  ).
        txa                                     ; 5078 8A                       .
        bne L5041                               ; 5079 D0 C6                    ..
        ldx curDrive                            ; 507B AE 89 84                 ...
        lda L5127,x                             ; 507E BD 27 51                 .'Q
        sta r0L                                 ; 5081 85 02                    ..
        lda L512B,x                             ; 5083 BD 2B 51                 .+Q
        sta r0H                                 ; 5086 85 03                    ..
        lda #$84                                ; 5088 A9 84                    ..
        sta r2H                                 ; 508A 85 07                    ..
        lda #$76                                ; 508C A9 76                    .v
        sta r2L                                 ; 508E 85 06                    ..
        ldx #$02                                ; 5090 A2 02                    ..
        ldy #$06                                ; 5092 A0 06                    ..
        lda #$12                                ; 5094 A9 12                    ..
        jsr CopyFString                         ; 5096 20 68 C2                  h.
        ldy #$90                                ; 5099 A0 90                    ..
        lda #$81                                ; 509B A9 81                    ..
        sta r0H                                 ; 509D 85 03                    ..
        lda #$F7                                ; 509F A9 F7                    ..
        sta r1H                                 ; 50A1 85 05                    ..
        lda #$01                                ; 50A3 A9 01                    ..
        sta r2H                                 ; 50A5 85 07                    ..
        lda #$00                                ; 50A7 A9 00                    ..
        sta r0L                                 ; 50A9 85 02                    ..
        sta r1L                                 ; 50AB 85 04                    ..
        sta r2L                                 ; 50AD 85 06                    ..
        jsr L5103                               ; 50AF 20 03 51                  .Q
        lda $8402                               ; 50B2 AD 02 84                 ...
        sta r1H                                 ; 50B5 85 05                    ..
        .byte$AD                                ; 50B7 AD                       .
        .byte$01                                ; 50B8 01                       .
L50B9:  sty DTOP_CHAIN                          ; 50B9 84 85                    ..
        .byte$04                                ; 50BB 04                       .
        lda #$79                                ; 50BC A9 79                    .y
        sta r7H                                 ; 50BE 85 11                    ..
        lda #$00                                ; 50C0 A9 00                    ..
        sta r7L                                 ; 50C2 85 10                    ..
        lda #$06                                ; 50C4 A9 06                    ..
        sta r2H                                 ; 50C6 85 07                    ..
        lda #$40                                ; 50C8 A9 40                    .@
        sta r2L                                 ; 50CA 85 06                    ..
        jsr L5195                               ; 50CC 20 95 51                  .Q
        txa                                     ; 50CF 8A                       .
        bne L5102                               ; 50D0 D0 30                    .0
        ldy #$90                                ; 50D2 A0 90                    ..
        lda #$79                                ; 50D4 A9 79                    .y
        sta r0H                                 ; 50D6 85 03                    ..
        lda #$F8                                ; 50D8 A9 F8                    ..
        sta r1H                                 ; 50DA 85 05                    ..
        lda #$00                                ; 50DC A9 00                    ..
        sta r0L                                 ; 50DE 85 02                    ..
        sta r1L                                 ; 50E0 85 04                    ..
        lda #$06                                ; 50E2 A9 06                    ..
        sta r2H                                 ; 50E4 85 07                    ..
        lda #$40                                ; 50E6 A9 40                    .@
        sta r2L                                 ; 50E8 85 06                    ..
        jsr L5103                               ; 50EA 20 03 51                  .Q
        lda #$84                                ; 50ED A9 84                    ..
        sta r2H                                 ; 50EF 85 07                    ..
        lda #$65                                ; 50F1 A9 65                    .e
        sta r2L                                 ; 50F3 85 06                    ..
        jsr L5112                               ; 50F5 20 12 51                  .Q
        lda $88C4                               ; 50F8 AD C4 88                 ...
        ora #$10                                ; 50FB 09 10                    ..
        sta $88C4                               ; 50FD 8D C4 88                 ...
        ldx #$00                                ; 5100 A2 00                    ..
L5102:  rts                                     ; 5102 60                       `

; ----------------------------------------------------------------------------
L5103:  lda $88C3                               ; 5103 AD C3 88                 ...
        sta r3L                                 ; 5106 85 08                    ..
        inc $88C3                               ; 5108 EE C3 88                 ...
        jsr DoRAMOp                             ; 510B 20 D4 C2                  ..
        dec $88C3                               ; 510E CE C3 88                 ...
        rts                                     ; 5111 60                       `

; ----------------------------------------------------------------------------
L5112:  ldy #$00                                ; 5112 A0 00                    ..
        lda $8403,y                             ; 5114 B9 03 84                 ...
        cmp #$A0                                ; 5117 C9 A0                    ..
        beq L512A                               ; 5119 F0 0F                    ..
        and #$7F                                ; 511B 29 7F                    ).
        cmp #$20                                ; 511D C9 20                    . 
        bcs L5123                               ; 511F B0 02                    ..
        lda #$3F                                ; 5121 A9 3F                    .?
L5123:  sta (r2L),y                             ; 5123 91 06                    ..
        iny                                     ; 5125 C8                       .
        .byte$C0                                ; 5126 C0                       .
L5127:  bpl L50B9                               ; 5127 10 90                    ..
        nop                                     ; 5129 EA                       .
L512A:  .byte$A9                                ; 512A A9                       .
L512B:  brk                                     ; 512B 00                       .
        sta (r2L),y                             ; 512C 91 06                    ..
        rts                                     ; 512E 60                       `

; ----------------------------------------------------------------------------
        asl $DC30,x                             ; 512F 1E 30 DC                 .0.
        inc $8484                               ; 5132 EE 84 84                 ...
        dey                                     ; 5135 88                       .
        dey                                     ; 5136 88                       .
L5137:  jmp L7909                               ; 5137 4C 09 79                 L.y

; ----------------------------------------------------------------------------
        jmp L79C9                               ; 513A 4C C9 79                 L.y

; ----------------------------------------------------------------------------
        jmp L79BC                               ; 513D 4C BC 79                 L.y

; ----------------------------------------------------------------------------
        sei                                     ; 5140 78                       x
        cld                                     ; 5141 D8                       .
        lda #$C0                                ; 5142 A9 C0                    ..
        sta dispBufferOn                        ; 5144 85 2F                    ./
        bit $88C5                               ; 5146 2C C5 88                 ,..
        bpl L5160                               ; 5149 10 15                    ..
        lda curDrive                            ; 514B AD 89 84                 ...
        jsr SetDevice                           ; 514E 20 B0 C2                  ..
        bne L5177                               ; 5151 D0 24                    .$
        lda $88C6                               ; 5153 AD C6 88                 ...
        bmi L5168                               ; 5156 30 10                    0.
        and #$F0                                ; 5158 29 F0                    ).
        cmp #$30                                ; 515A C9 30                    .0
        beq L5168                               ; 515C F0 0A                    ..
        bne L5177                               ; 515E D0 17                    ..
L5160:  lda TempCurDrive                        ; 5160 AD 68 88                 .h.
        jsr SetDevice                           ; 5163 20 B0 C2                  ..
        bne L5177                               ; 5166 D0 0F                    ..
L5168:  jsr NewDisk                             ; 5168 20 E1 C1                  ..
        bne L5177                               ; 516B D0 0A                    ..
        jsr GetDirHead                          ; 516D 20 47 C2                  G.
        bne L5177                               ; 5170 D0 05                    ..
        jsr L7D2A                               ; 5172 20 2A 7D                  *}
        beq L518A                               ; 5175 F0 13                    ..
L5177:  lda #$00                                ; 5177 A9 00                    ..
        sta r4L                                 ; 5179 85 0A                    ..
        jsr L79C9                               ; 517B 20 C9 79                  .y
        lda $886B                               ; 517E AD 6B 88                 .k.
        bpl L518A                               ; 5181 10 07                    ..
        jsr L7C9E                               ; 5183 20 9E 7C                  .|
        bcc L5177                               ; 5186 90 EF                    ..
        bcs L518F                               ; 5188 B0 05                    ..
L518A:  jsr L7B11                               ; 518A 20 11 7B                  .{
        bcc L5177                               ; 518D 90 E8                    ..
L518F:  ldx #$FF                                ; 518F A2 FF                    ..
        stx $88C5                               ; 5191 8E C5 88                 ...
        rts                                     ; 5194 60                       `

; ----------------------------------------------------------------------------
L5195:  jsr InitForIO                           ; 5195 20 5C C2                  \.
        lda #$80                                ; 5198 A9 80                    ..
        sta r4H                                 ; 519A 85 0B                    ..
        lda #$00                                ; 519C A9 00                    ..
        sta r4L                                 ; 519E 85 0A                    ..
L51A0:  jsr ReadBlock                           ; 51A0 20 1A C2                  ..
        bne L51F0                               ; 51A3 D0 4B                    .K
        ldy #$FE                                ; 51A5 A0 FE                    ..
        lda diskBlkBuf                          ; 51A7 AD 00 80                 ...
        bne L51B4                               ; 51AA D0 08                    ..
        ldy $8001                               ; 51AC AC 01 80                 ...
        beq L51E2                               ; 51AF F0 31                    .1
        dey                                     ; 51B1 88                       .
        beq L51E2                               ; 51B2 F0 2E                    ..
L51B4:  lda r2H                                 ; 51B4 A5 07                    ..
        bne L51C2                               ; 51B6 D0 0A                    ..
        cpy r2L                                 ; 51B8 C4 06                    ..
        bcc L51C2                               ; 51BA 90 06                    ..
        beq L51C2                               ; 51BC F0 04                    ..
        ldx #$0B                                ; 51BE A2 0B                    ..
        bne L51F0                               ; 51C0 D0 2E                    ..
L51C2:  sty r1L                                 ; 51C2 84 04                    ..
L51C4:  lda $8001,y                             ; 51C4 B9 01 80                 ...
        dey                                     ; 51C7 88                       .
        sta (r7L),y                             ; 51C8 91 10                    ..
        bne L51C4                               ; 51CA D0 F8                    ..
        lda r1L                                 ; 51CC A5 04                    ..
        clc                                     ; 51CE 18                       .
        adc r7L                                 ; 51CF 65 10                    e.
        sta r7L                                 ; 51D1 85 10                    ..
        bcc L51D7                               ; 51D3 90 02                    ..
        inc r7H                                 ; 51D5 E6 11                    ..
L51D7:  lda r2L                                 ; 51D7 A5 06                    ..
        sec                                     ; 51D9 38                       8
        sbc r1L                                 ; 51DA E5 04                    ..
        sta r2L                                 ; 51DC 85 06                    ..
        bcs L51E2                               ; 51DE B0 02                    ..
        dec r2H                                 ; 51E0 C6 07                    ..
L51E2:  lda $8001                               ; 51E2 AD 01 80                 ...
        sta r1H                                 ; 51E5 85 05                    ..
        lda diskBlkBuf                          ; 51E7 AD 00 80                 ...
        sta r1L                                 ; 51EA 85 04                    ..
        bne L51A0                               ; 51EC D0 B2                    ..
        ldx #$00                                ; 51EE A2 00                    ..
L51F0:  jmp DoneWithIO                          ; 51F0 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        lda r6H                                 ; 51F3 A5 0F                    ..
        sta $7C67                               ; 51F5 8D 67 7C                 .g|
        lda r6L                                 ; 51F8 A5 0E                    ..
        sta $7C66                               ; 51FA 8D 66 7C                 .f|
        lda #$80                                ; 51FD A9 80                    ..
        bit a:$A9                               ; 51FF 2C A9 00                 ,..
        sta $7C68                               ; 5202 8D 68 7C                 .h|
        lda #$00                                ; 5205 A9 00                    ..
        sta $886B                               ; 5207 8D 6B 88                 .k.
        lda r4L                                 ; 520A A5 0A                    ..
        sta $7A37                               ; 520C 8D 37 7A                 .7z
L520F:  lda #$80                                ; 520F A9 80                    ..
        sta $7A38                               ; 5211 8D 38 7A                 .8z
L5214:  ldy #$08                                ; 5214 A0 08                    ..
        sty $7A39                               ; 5216 8C 39 7A                 .9z
L5219:  lda $8486,y                             ; 5219 B9 86 84                 ...
        beq L5229                               ; 521C F0 0B                    ..
        eor $7A38                               ; 521E 4D 38 7A                 M8z
        bmi L5229                               ; 5221 30 06                    0.
        jsr L7AA9                               ; 5223 20 A9 7A                  .z
        bcc L5229                               ; 5226 90 01                    ..
        rts                                     ; 5228 60                       `

; ----------------------------------------------------------------------------
L5229:  inc $7A39                               ; 5229 EE 39 7A                 .9z
        ldy $7A39                               ; 522C AC 39 7A                 .9z
        cpy #$0C                                ; 522F C0 0C                    ..
        bcc L5219                               ; 5231 90 E6                    ..
        lda $7A38                               ; 5233 AD 38 7A                 .8z
        eor #$80                                ; 5236 49 80                    I.
        sta $7A38                               ; 5238 8D 38 7A                 .8z
        bmi L5248                               ; 523B 30 0B                    0.
        jsr L7A97                               ; 523D 20 97 7A                  .z
        bcs L5247                               ; 5240 B0 05                    ..
        jsr L7B57                               ; 5242 20 57 7B                  W{
        bcc L5214                               ; 5245 90 CD                    ..
L5247:  rts                                     ; 5247 60                       `

; ----------------------------------------------------------------------------
L5248:  bit $7C68                               ; 5248 2C 68 7C                 ,h|
        bmi L5247                               ; 524B 30 FA                    0.
        bit $7A37                               ; 524D 2C 37 7A                 ,7z
        bmi L5247                               ; 5250 30 F5                    0.
        jsr L7A3A                               ; 5252 20 3A 7A                  :z
        lda #$08                                ; 5255 A9 08                    ..
        sta $7A39                               ; 5257 8D 39 7A                 .9z
L525A:  jsr SetDevice                           ; 525A 20 B0 C2                  ..
        bne L5262                               ; 525D D0 03                    ..
        jsr OpenDisk                            ; 525F 20 A1 C2                  ..
L5262:  inc $7A39                               ; 5262 EE 39 7A                 .9z
        lda $7A39                               ; 5265 AD 39 7A                 .9z
        cmp #$0C                                ; 5268 C9 0C                    ..
        bcc L525A                               ; 526A 90 EE                    ..
        bcs L520F                               ; 526C B0 A1                    ..
        brk                                     ; 526E 00                       .
        brk                                     ; 526F 00                       .
        brk                                     ; 5270 00                       .
        jsr L7A85                               ; 5271 20 85 7A                  .z
        lda #$08                                ; 5274 A9 08                    ..
        sta r1L                                 ; 5276 85 04                    ..
        lda #$04                                ; 5278 A9 04                    ..
        sta r1H                                 ; 527A 85 05                    ..
        lda #$18                                ; 527C A9 18                    ..
        sta r2L                                 ; 527E 85 06                    ..
        lda #$0C                                ; 5280 A9 0C                    ..
        sta r2H                                 ; 5282 85 07                    ..
        lda $9FE1                               ; 5284 AD E1 9F                 ...
        sta r4H                                 ; 5287 85 0B                    ..
        jsr LC313                               ; 5289 20 13 C3                  ..
        lda $84B2                               ; 528C AD B2 84                 ...
        sta $7A84                               ; 528F 8D 84 7A                 ..z
        lda RecoverVector                       ; 5292 AD B1 84                 ...
        sta $7A83                               ; 5295 8D 83 7A                 ..z
        lda #$7A                                ; 5298 A9 7A                    .z
        sta $84B2                               ; 529A 8D B2 84                 ...
        lda #$8E                                ; 529D A9 8E                    ..
        sta RecoverVector                       ; 529F 8D B1 84                 ...
        lda #$7C                                ; 52A2 A9 7C                    .|
        sta r0H                                 ; 52A4 85 03                    ..
        lda #$96                                ; 52A6 A9 96                    ..
        sta r0L                                 ; 52A8 85 02                    ..
        jsr DoDlgBox                            ; 52AA 20 56 C2                  V.
        lda $7A84                               ; 52AD AD 84 7A                 ..z
        sta $84B2                               ; 52B0 8D B2 84                 ...
        lda $7A83                               ; 52B3 AD 83 7A                 ..z
        sta RecoverVector                       ; 52B6 8D B1 84                 ...
        rts                                     ; 52B9 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 52BA 00                       .
        brk                                     ; 52BB 00                       .
        jsr LCFD9                               ; 52BC 20 D9 CF                  ..
        jsr L4000                               ; 52BF 20 00 40                  .@
        jmp LCFD9                               ; 52C2 4C D9 CF                 L..

; ----------------------------------------------------------------------------
        jsr LCFD9                               ; 52C5 20 D9 CF                  ..
        jsr L4003                               ; 52C8 20 03 40                  .@
        jmp LCFD9                               ; 52CB 4C D9 CF                 L..

; ----------------------------------------------------------------------------
        ldy #$08                                ; 52CE A0 08                    ..
L52D0:  lda $8486,y                             ; 52D0 B9 86 84                 ...
        and #$F0                                ; 52D3 29 F0                    ).
        cmp #$30                                ; 52D5 C9 30                    .0
        beq L52E0                               ; 52D7 F0 07                    ..
        iny                                     ; 52D9 C8                       .
        cpy #$0C                                ; 52DA C0 0C                    ..
        bcc L52D0                               ; 52DC 90 F2                    ..
        clc                                     ; 52DE 18                       .
        rts                                     ; 52DF 60                       `

; ----------------------------------------------------------------------------
L52E0:  tya                                     ; 52E0 98                       .
        and #$7F                                ; 52E1 29 7F                    ).
        jsr SetDevice                           ; 52E3 20 B0 C2                  ..
        bne L5346                               ; 52E6 D0 5E                    .^
        jsr NewDisk                             ; 52E8 20 E1 C1                  ..
        txa                                     ; 52EB 8A                       .
        bne L5346                               ; 52EC D0 58                    .X
        jsr GetDirHead                          ; 52EE 20 47 C2                  G.
        bne L5346                               ; 52F1 D0 53                    .S
        jsr L7D2A                               ; 52F3 20 2A 7D                  *}
        bne L5300                               ; 52F6 D0 08                    ..
        lda curDrive                            ; 52F8 AD 89 84                 ...
        sta $886B                               ; 52FB 8D 6B 88                 .k.
        sec                                     ; 52FE 38                       8
        rts                                     ; 52FF 60                       `

; ----------------------------------------------------------------------------
L5300:  lda $88C6                               ; 5300 AD C6 88                 ...
        and #$0F                                ; 5303 29 0F                    ).
        cmp #$04                                ; 5305 C9 04                    ..
        bne L5346                               ; 5307 D0 3D                    .=
        lda $905C                               ; 5309 AD 5C 90                 .\.
        cmp #$01                                ; 530C C9 01                    ..
        bne L5315                               ; 530E D0 05                    ..
        cmp $905D                               ; 5310 CD 5D 90                 .].
        beq L5346                               ; 5313 F0 31                    .1
L5315:  lda $905D                               ; 5315 AD 5D 90                 .].
        pha                                     ; 5318 48                       H
        lda $905C                               ; 5319 AD 5C 90                 .\.
        pha                                     ; 531C 48                       H
        lda #$01                                ; 531D A9 01                    ..
        sta $905C                               ; 531F 8D 5C 90                 .\.
        sta $905D                               ; 5322 8D 5D 90                 .].
        jsr GetDirHead                          ; 5325 20 47 C2                  G.
        bne L533B                               ; 5328 D0 11                    ..
        jsr L7D2A                               ; 532A 20 2A 7D                  *}
        bne L533B                               ; 532D D0 0C                    ..
        pla                                     ; 532F 68                       h
        pla                                     ; 5330 68                       h
        lda curDrive                            ; 5331 AD 89 84                 ...
        ora #$40                                ; 5334 09 40                    .@
        sta $886B                               ; 5336 8D 6B 88                 .k.
        sec                                     ; 5339 38                       8
        rts                                     ; 533A 60                       `

; ----------------------------------------------------------------------------
L533B:  pla                                     ; 533B 68                       h
        sta $905C                               ; 533C 8D 5C 90                 .\.
        pla                                     ; 533F 68                       h
        sta $905D                               ; 5340 8D 5D 90                 .].
        jsr GetDirHead                          ; 5343 20 47 C2                  G.
L5346:  clc                                     ; 5346 18                       .
        rts                                     ; 5347 60                       `

; ----------------------------------------------------------------------------
        sec                                     ; 5348 38                       8
        lda #$00                                ; 5349 A9 00                    ..
        sbc r7L                                 ; 534B E5 10                    ..
        sta r2L                                 ; 534D 85 06                    ..
        lda #$79                                ; 534F A9 79                    .y
        sbc r7H                                 ; 5351 E5 11                    ..
        sta r2H                                 ; 5353 85 07                    ..
        lda $8402                               ; 5355 AD 02 84                 ...
        sta r1H                                 ; 5358 85 05                    ..
        lda $8401                               ; 535A AD 01 84                 ...
        sta r1L                                 ; 535D 85 04                    ..
        lda $8146                               ; 535F AD 46 81                 .F.
        cmp #$01                                ; 5362 C9 01                    ..
        bne L5376                               ; 5364 D0 10                    ..
        jsr L903C                               ; 5366 20 3C 90                  <.
        txa                                     ; 5369 8A                       .
        bne L538C                               ; 536A D0 20                    . 
        lda $8003                               ; 536C AD 03 80                 ...
        sta r1H                                 ; 536F 85 05                    ..
        lda $8002                               ; 5371 AD 02 80                 ...
        sta r1L                                 ; 5374 85 04                    ..
L5376:  jsr L795E                               ; 5376 20 5E 79                  ^y
        txa                                     ; 5379 8A                       .
        bne L538C                               ; 537A D0 10                    ..
        lda #$00                                ; 537C A9 00                    ..
        sta r0L                                 ; 537E 85 02                    ..
        lda $814C                               ; 5380 AD 4C 81                 .L.
        sta r7H                                 ; 5383 85 11                    ..
        lda $814B                               ; 5385 AD 4B 81                 .K.
        sta r7L                                 ; 5388 85 10                    ..
        sec                                     ; 538A 38                       8
        rts                                     ; 538B 60                       `

; ----------------------------------------------------------------------------
L538C:  clc                                     ; 538C 18                       .
        rts                                     ; 538D 60                       `

; ----------------------------------------------------------------------------
        lda $886A                               ; 538E AD 6A 88                 .j.
        and #$F0                                ; 5391 29 F0                    ).
        beq L539D                               ; 5393 F0 08                    ..
        cmp #$40                                ; 5395 C9 40                    .@
        bcc L539F                               ; 5397 90 06                    ..
        cmp #$80                                ; 5399 C9 80                    ..
        beq L539F                               ; 539B F0 02                    ..
L539D:  clc                                     ; 539D 18                       .
        rts                                     ; 539E 60                       `

; ----------------------------------------------------------------------------
L539F:  sta $7D13                               ; 539F 8D 13 7D                 ..}
        lda TempCurDrive                        ; 53A2 AD 68 88                 .h.
        jsr SetDevice                           ; 53A5 20 B0 C2                  ..
        bne L53B5                               ; 53A8 D0 0B                    ..
        jsr L7BD8                               ; 53AA 20 D8 7B                  .{
        bcc L53B5                               ; 53AD 90 06                    ..
        jsr L7BA4                               ; 53AF 20 A4 7B                  .{
        bcc L53B5                               ; 53B2 90 01                    ..
        rts                                     ; 53B4 60                       `

; ----------------------------------------------------------------------------
L53B5:  lda #$08                                ; 53B5 A9 08                    ..
        sta $7BA3                               ; 53B7 8D A3 7B                 ..{
L53BA:  jsr SetDevice                           ; 53BA 20 B0 C2                  ..
        bne L53C9                               ; 53BD D0 0A                    ..
        jsr L7BD8                               ; 53BF 20 D8 7B                  .{
        bcc L53C9                               ; 53C2 90 05                    ..
        jsr L7BA4                               ; 53C4 20 A4 7B                  .{
        bcs L53D9                               ; 53C7 B0 10                    ..
L53C9:  inc $7BA3                               ; 53C9 EE A3 7B                 ..{
        lda $7BA3                               ; 53CC AD A3 7B                 ..{
        cmp TempCurDrive                        ; 53CF CD 68 88                 .h.
        beq L53C9                               ; 53D2 F0 F5                    ..
        cmp #$0C                                ; 53D4 C9 0C                    ..
        bcc L53BA                               ; 53D6 90 E2                    ..
        clc                                     ; 53D8 18                       .
L53D9:  rts                                     ; 53D9 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 53DA 00                       .
        lda $905D                               ; 53DB AD 5D 90                 .].
        sta $7D16                               ; 53DE 8D 16 7D                 ..}
        lda $905C                               ; 53E1 AD 5C 90                 .\.
        sta $7D15                               ; 53E4 8D 15 7D                 ..}
        jsr L9063                               ; 53E7 20 63 90                  c.
        lda r2L                                 ; 53EA A5 06                    ..
        sta $7D14                               ; 53EC 8D 14 7D                 ..}
        cmp $8869                               ; 53EF CD 69 88                 .i.
        bne L53FD                               ; 53F2 D0 09                    ..
        lda $88C6                               ; 53F4 AD C6 88                 ...
        and #$F0                                ; 53F7 29 F0                    ).
        cmp #$10                                ; 53F9 C9 10                    ..
        bne L540C                               ; 53FB D0 0F                    ..
L53FD:  jsr L7CB7                               ; 53FD 20 B7 7C                  .|
        bcc L5403                               ; 5400 90 01                    ..
L5402:  rts                                     ; 5402 60                       `

; ----------------------------------------------------------------------------
L5403:  lda $88C6                               ; 5403 AD C6 88                 ...
        and #$F0                                ; 5406 29 F0                    ).
        cmp #$10                                ; 5408 C9 10                    ..
        bne L5402                               ; 540A D0 F6                    ..
L540C:  jmp L7CEC                               ; 540C 4C EC 7C                 L.|

; ----------------------------------------------------------------------------
        lda $7D13                               ; 540F AD 13 7D                 ..}
        bpl L541F                               ; 5412 10 0B                    ..
        lda $88C6                               ; 5414 AD C6 88                 ...
        and #$F0                                ; 5417 29 F0                    ).
        cmp #$30                                ; 5419 C9 30                    .0
        bne L542B                               ; 541B D0 0E                    ..
L541D:  sec                                     ; 541D 38                       8
        rts                                     ; 541E 60                       `

; ----------------------------------------------------------------------------
L541F:  cmp #$30                                ; 541F C9 30                    .0
        bne L542B                               ; 5421 D0 08                    ..
        lda $88C6                               ; 5423 AD C6 88                 ...
        and $9073                               ; 5426 2D 73 90                 -s.
        bmi L541D                               ; 5429 30 F2                    0.
L542B:  lda $88C6                               ; 542B AD C6 88                 ...
        and #$F0                                ; 542E 29 F0                    ).
        cmp $7D13                               ; 5430 CD 13 7D                 ..}
        beq L541D                               ; 5433 F0 E8                    ..
        clc                                     ; 5435 18                       .
        rts                                     ; 5436 60                       `

; ----------------------------------------------------------------------------
        ldx #$01                                ; 5437 A2 01                    ..
        lda $7C67                               ; 5439 AD 67 7C                 .g|
        sta r6H                                 ; 543C 85 0F                    ..
        lda $7C66                               ; 543E AD 66 7C                 .f|
        sta r6L                                 ; 5441 85 0E                    ..
        bit $7C68                               ; 5443 2C 68 7C                 ,h|
        bmi L5478                               ; 5446 30 30                    00
        lda #$C3                                ; 5448 A9 C3                    ..
        sta r6H                                 ; 544A 85 0F                    ..
        lda #$CF                                ; 544C A9 CF                    ..
        sta r6L                                 ; 544E 85 0E                    ..
        lda #$7C                                ; 5450 A9 7C                    .|
        sta r2H                                 ; 5452 85 07                    ..
        lda #$69                                ; 5454 A9 69                    .i
        sta r2L                                 ; 5456 85 06                    ..
        ldx #$0E                                ; 5458 A2 0E                    ..
        ldy #$06                                ; 545A A0 06                    ..
        jsr CmpString                           ; 545C 20 6B C2                  k.
        bne L546C                               ; 545F D0 0B                    ..
        lda #$7C                                ; 5461 A9 7C                    .|
        sta r6H                                 ; 5463 85 0F                    ..
        lda #$85                                ; 5465 A9 85                    ..
        sta r6L                                 ; 5467 85 0E                    ..
        ldx #$00                                ; 5469 A2 00                    ..
        .byte$2C                                ; 546B 2C                       ,
L546C:  ldx #$01                                ; 546C A2 01                    ..
        lda $7C92,x                             ; 546E BD 92 7C                 ..|
        sta r0L                                 ; 5471 85 02                    ..
        lda $7C94,x                             ; 5473 BD 94 7C                 ..|
        sta r0H                                 ; 5476 85 03                    ..
L5478:  stx $7C65                               ; 5478 8E 65 7C                 .e|
        rts                                     ; 547B 60                       `

; ----------------------------------------------------------------------------
        jsr i_PutString                         ; 547C 20 AE C1                  ..
        .byte"P"                                ; 547F 50                       P
        .byte$00                                ; 5480 00                       .
        .byte"6Insert a disk with "             ; 5481 36 49 6E 73 65 72 74 20  6Insert 
                                                ; 5489 61 20 64 69 73 6B 20 77  a disk w
                                                ; 5491 69 74 68 20              ith 
        .byte$00                                ; 5495 00                       .
; ----------------------------------------------------------------------------
        jsr L7C00                               ; 5496 20 00 7C                  .|
        jmp PutString                           ; 5499 4C 48 C1                 LH.

; ----------------------------------------------------------------------------
        .byte$00,$00,$00,$00                    ; 549C 00 00 00 00              ....
        .byte"DESKTOP"                          ; 54A0 44 45 53 4B 54 4F 50     DESKTOP
        .byte$00                                ; 54A7 00                       .
        .byte"Insert a disk with "              ; 54A8 49 6E 73 65 72 74 20 61  Insert a
                                                ; 54B0 20 64 69 73 6B 20 77 69   disk wi
                                                ; 54B8 74 68 20                 th 
        .byte$00                                ; 54BB 00                       .
        .byte"Dashboard 64"                     ; 54BC 44 61 73 68 62 6F 61 72  Dashboar
                                                ; 54C4 64 20 36 34              d 64
        .byte$00                                ; 54C8 00                       .
; ----------------------------------------------------------------------------
        .byte$85,$CF,$7C,$C3,$80,$13,$45,$7C    ; 54C9 85 CF 7C C3 80 13 45 7C  ..|...E|
        .byte$01,$11,$48                        ; 54D1 01 11 48                 ..H
; ----------------------------------------------------------------------------
        brk                                     ; 54D4 00                       .
        jsr L7B11                               ; 54D5 20 11 7B                  .{
        php                                     ; 54D8 08                       .
        ldx $7D14                               ; 54D9 AE 14 7D                 ..}
        jsr L7D17                               ; 54DC 20 17 7D                  .}
        lda $7D16                               ; 54DF AD 16 7D                 ..}
        sta r1H                                 ; 54E2 85 05                    ..
        lda $7D15                               ; 54E4 AD 15 7D                 ..}
        sta r1L                                 ; 54E7 85 04                    ..
        jsr L9053                               ; 54E9 20 53 90                  S.
        plp                                     ; 54EC 28                       (
        rts                                     ; 54ED 60                       `

; ----------------------------------------------------------------------------
        ldx $8869                               ; 54EE AE 69 88                 .i.
        jsr L7D17                               ; 54F1 20 17 7D                  .}
        jsr L9050                               ; 54F4 20 50 90                  P.
        jsr L7D2A                               ; 54F7 20 2A 7D                  *}
        bne L550E                               ; 54FA D0 12                    ..
        lda curDrive                            ; 54FC AD 89 84                 ...
        bit $7C68                               ; 54FF 2C 68 7C                 ,h|
        bmi L5507                               ; 5502 30 03                    0.
        sta TempCurDrive                        ; 5504 8D 68 88                 .h.
L5507:  ora #$80                                ; 5507 09 80                    ..
        sta $886B                               ; 5509 8D 6B 88                 .k.
        sec                                     ; 550C 38                       8
        rts                                     ; 550D 60                       `

; ----------------------------------------------------------------------------
L550E:  ldx $7D14                               ; 550E AE 14 7D                 ..}
        jsr L7D17                               ; 5511 20 17 7D                  .}
        lda $7D16                               ; 5514 AD 16 7D                 ..}
        sta r1H                                 ; 5517 85 05                    ..
        lda $7D15                               ; 5519 AD 15 7D                 ..}
        sta r1L                                 ; 551C 85 04                    ..
        jsr L9053                               ; 551E 20 53 90                  S.
        clc                                     ; 5521 18                       .
        rts                                     ; 5522 60                       `

; ----------------------------------------------------------------------------
        jsr L9050                               ; 5523 20 50 90                  P.
        jsr L7D2A                               ; 5526 20 2A 7D                  *}
        bne L553B                               ; 5529 D0 10                    ..
        lda curDrive                            ; 552B AD 89 84                 ...
        bit $7C68                               ; 552E 2C 68 7C                 ,h|
        bmi L5536                               ; 5531 30 03                    0.
        sta TempCurDrive                        ; 5533 8D 68 88                 .h.
L5536:  sta $886B                               ; 5536 8D 6B 88                 .k.
        sec                                     ; 5539 38                       8
        rts                                     ; 553A 60                       `

; ----------------------------------------------------------------------------
L553B:  lda $7D16                               ; 553B AD 16 7D                 ..}
        sta r1H                                 ; 553E 85 05                    ..
        lda $7D15                               ; 5540 AD 15 7D                 ..}
        sta r1L                                 ; 5543 85 04                    ..
        jsr L9053                               ; 5545 20 53 90                  S.
        clc                                     ; 5548 18                       .
        rts                                     ; 5549 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 554A 00                       .
        brk                                     ; 554B 00                       .
        brk                                     ; 554C 00                       .
        brk                                     ; 554D 00                       .
        jsr L9D83                               ; 554E 20 83 9D                  ..
        lda #$45                                ; 5551 A9 45                    .E
        jsr L9D80                               ; 5553 20 80 9D                  ..
        jsr L5015+3                             ; 5556 20 18 50                  .P
        jsr L9D83                               ; 5559 20 83 9D                  ..
        lda #$4A                                ; 555C A9 4A                    .J
        jmp L9D80                               ; 555E 4C 80 9D                 L..

; ----------------------------------------------------------------------------
        jsr L7C00                               ; 5561 20 00 7C                  .|
        jsr FindFile                            ; 5564 20 0B C2                  ..
        txa                                     ; 5567 8A                       .
        bne L5591                               ; 5568 D0 27                    .'
        lda #$84                                ; 556A A9 84                    ..
        sta r9H                                 ; 556C 85 15                    ..
        lda #$00                                ; 556E A9 00                    ..
        sta r9L                                 ; 5570 85 14                    ..
        jsr GetFHdrInfo                         ; 5572 20 29 C2                  ).
        txa                                     ; 5575 8A                       .
        bne L5591                               ; 5576 D0 19                    ..
        ldx $7C65                               ; 5578 AE 65 7C                 .e|
        dex                                     ; 557B CA                       .
        beq L5591                               ; 557C F0 13                    ..
        lda $815A                               ; 557E AD 5A 81                 .Z.
        cmp #$35                                ; 5581 C9 35                    .5
        bcs L558F                               ; 5583 B0 0A                    ..
        lda $815C                               ; 5585 AD 5C 81                 .\.
        cmp #$30                                ; 5588 C9 30                    .0
        bne L558F                               ; 558A D0 03                    ..
        ldx #$05                                ; 558C A2 05                    ..
        rts                                     ; 558E 60                       `

; ----------------------------------------------------------------------------
L558F:  ldx #$00                                ; 558F A2 00                    ..
L5591:  rts                                     ; 5591 60                       `

; ----------------------------------------------------------------------------
