; da65 V2.15
; Created:    2016-09-01 21:51:58
; Input file: reu10.bin
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
L4000           := $4000
L4003           := $4003
BACK_SCR_BASE   := $6000
PRINTBASE       := $7900
L7909           := $7909
L795E           := $795E
L79BC           := $79BC
L79C9           := $79C9
L7A3A           := $7A3A
L7A85           := $7A85
L7A97           := $7A97
L7AA9           := $7AA9
L7B11           := $7B11
L7B57           := $7B57
L7BA4           := $7BA4
L7BD8           := $7BD8
L7C00           := $7C00
L7C9E           := $7C9E
L7CB7           := $7CB7
L7CEC           := $7CEC
L7D17           := $7D17
L7D2A           := $7D2A
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
L9050           := $9050
L9053           := $9053
L9063           := $9063
L9D80           := $9D80
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
LC313           := $C313
LCFD9           := $CFD9
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
        jmp     L5021

        lda     #$00
        bit     $80A9
        bit     $03A9
        bit     $06A9
        tax
        bmi     L5034
        pha
        jsr     i_MoveData
L5015:  .addr   L5137
        .addr   PRINTBASE
        .word   $045B
        ldx     #$79
        pla
        jmp     CallRoutine

L5021:  lda     #$C3
        sta     r1H
        lda     #$CF
        sta     r1L
        lda     #$00
        sta     r2H
        lda     #$09
        sta     r2L
        jmp     MoveData

L5034:  lda     $8416
        cmp     #$09
        beq     L506D
        cmp     #$0A
        beq     L5042
        ldx     #$05
L5041:  rts

L5042:  lda     $8402
        sta     r1H
        lda     $8401
        sta     r1L
        lda     #$FE
        sta     r7H
        lda     #$80
        sta     r7L
        lda     #$01
        sta     r2H
        lda     #$7A
        sta     r2L
        jsr     L5195
        txa
        bne     L5041
        lda     #$88
        sta     r2H
        lda     #$CB
        sta     r2L
        jmp     L5112

L506D:  lda     #$84
        sta     r9H
        lda     #$00
        sta     r9L
        jsr     GetFHdrInfo
        txa
        bne     L5041
        ldx     curDrive
        lda     L5127,x
        sta     r0L
        lda     L512B,x
        sta     r0H
        lda     #$84
        sta     r2H
        lda     #$76
        sta     r2L
        ldx     #$02
        ldy     #$06
        lda     #$12
        jsr     CopyFString
        ldy     #$90
        lda     #$81
        sta     r0H
        lda     #$F7
        sta     r1H
        lda     #$01
        sta     r2H
        lda     #$00
        sta     r0L
        sta     r1L
        sta     r2L
        jsr     L5103
        lda     $8402
        sta     r1H
        .byte   $AD
        .byte   $01
L50B9:  sty     DTOP_CHAIN
        .byte   $04
        lda     #$79
        sta     r7H
        lda     #$00
        sta     r7L
        lda     #$06
        sta     r2H
        lda     #$40
        sta     r2L
        jsr     L5195
        txa
        bne     L5102
        ldy     #$90
        lda     #$79
        sta     r0H
        lda     #$F8
        sta     r1H
        lda     #$00
        sta     r0L
        sta     r1L
        lda     #$06
        sta     r2H
        lda     #$40
        sta     r2L
        jsr     L5103
        lda     #$84
        sta     r2H
        lda     #$65
        sta     r2L
        jsr     L5112
        lda     $88C4
        ora     #$10
        sta     $88C4
        ldx     #$00
L5102:  rts

L5103:  lda     $88C3
        sta     r3L
        inc     $88C3
        jsr     DoRAMOp
        dec     $88C3
        rts

L5112:  ldy     #$00
        lda     $8403,y
        cmp     #$A0
        beq     L512A
        and     #$7F
        cmp     #$20
        bcs     L5123
        lda     #$3F
L5123:  sta     (r2L),y
        iny
        .byte   $C0
L5127:  bpl     L50B9
        nop
L512A:  .byte   $A9
L512B:  brk
        sta     (r2L),y
        rts

        asl     $DC30,x
        inc     $8484
        dey
        dey
L5137:  jmp     L7909

        jmp     L79C9

        jmp     L79BC

        sei
        cld
        lda     #$C0
        sta     dispBufferOn
        bit     $88C5
        bpl     L5160
        lda     curDrive
        jsr     SetDevice
        bne     L5177
        lda     $88C6
        bmi     L5168
        and     #$F0
        cmp     #$30
        beq     L5168
        bne     L5177
L5160:  lda     TempCurDrive
        jsr     SetDevice
        bne     L5177
L5168:  jsr     NewDisk
        bne     L5177
        jsr     GetDirHead
        bne     L5177
        jsr     L7D2A
        beq     L518A
L5177:  lda     #$00
        sta     r4L
        jsr     L79C9
        lda     $886B
        bpl     L518A
        jsr     L7C9E
        bcc     L5177
        bcs     L518F
L518A:  jsr     L7B11
        bcc     L5177
L518F:  ldx     #$FF
        stx     $88C5
        rts

L5195:  jsr     InitForIO
        lda     #$80
        sta     r4H
        lda     #$00
        sta     r4L
L51A0:  jsr     ReadBlock
        bne     L51F0
        ldy     #$FE
        lda     diskBlkBuf
        bne     L51B4
        ldy     $8001
        beq     L51E2
        dey
        beq     L51E2
L51B4:  lda     r2H
        bne     L51C2
        cpy     r2L
        bcc     L51C2
        beq     L51C2
        ldx     #$0B
        bne     L51F0
L51C2:  sty     r1L
L51C4:  lda     $8001,y
        dey
        sta     (r7L),y
        bne     L51C4
        lda     r1L
        clc
        adc     r7L
        sta     r7L
        bcc     L51D7
        inc     r7H
L51D7:  lda     r2L
        sec
        sbc     r1L
        sta     r2L
        bcs     L51E2
        dec     r2H
L51E2:  lda     $8001
        sta     r1H
        lda     diskBlkBuf
        sta     r1L
        bne     L51A0
        ldx     #$00
L51F0:  jmp     DoneWithIO

        lda     r6H
        sta     $7C67
        lda     r6L
        sta     $7C66
        lda     #$80
        bit     a:$A9
        sta     $7C68
        lda     #$00
        sta     $886B
        lda     r4L
        sta     $7A37
L520F:  lda     #$80
        sta     $7A38
L5214:  ldy     #$08
        sty     $7A39
L5219:  lda     $8486,y
        beq     L5229
        eor     $7A38
        bmi     L5229
        jsr     L7AA9
        bcc     L5229
        rts

L5229:  inc     $7A39
        ldy     $7A39
        cpy     #$0C
        bcc     L5219
        lda     $7A38
        eor     #$80
        sta     $7A38
        bmi     L5248
        jsr     L7A97
        bcs     L5247
        jsr     L7B57
        bcc     L5214
L5247:  rts

L5248:  bit     $7C68
        bmi     L5247
        bit     $7A37
        bmi     L5247
        jsr     L7A3A
        lda     #$08
        sta     $7A39
L525A:  jsr     SetDevice
        bne     L5262
        jsr     OpenDisk
L5262:  inc     $7A39
        lda     $7A39
        cmp     #$0C
        bcc     L525A
        bcs     L520F
        brk
        brk
        brk
        jsr     L7A85
        lda     #$08
        sta     r1L
        lda     #$04
        sta     r1H
        lda     #$18
        sta     r2L
        lda     #$0C
        sta     r2H
        lda     $9FE1
        sta     r4H
        jsr     LC313
        lda     $84B2
        sta     $7A84
        lda     RecoverVector
        sta     $7A83
        lda     #$7A
        sta     $84B2
        lda     #$8E
        sta     RecoverVector
        lda     #$7C
        sta     r0H
        lda     #$96
        sta     r0L
        jsr     DoDlgBox
        lda     $7A84
        sta     $84B2
        lda     $7A83
        sta     RecoverVector
        rts

        brk
        brk
        jsr     LCFD9
        jsr     L4000
        jmp     LCFD9

        jsr     LCFD9
        jsr     L4003
        jmp     LCFD9

        ldy     #$08
L52D0:  lda     $8486,y
        and     #$F0
        cmp     #$30
        beq     L52E0
        iny
        cpy     #$0C
        bcc     L52D0
        clc
        rts

L52E0:  tya
        and     #$7F
        jsr     SetDevice
        bne     L5346
        jsr     NewDisk
        txa
        bne     L5346
        jsr     GetDirHead
        bne     L5346
        jsr     L7D2A
        bne     L5300
        lda     curDrive
        sta     $886B
        sec
        rts

L5300:  lda     $88C6
        and     #$0F
        cmp     #$04
        bne     L5346
        lda     $905C
        cmp     #$01
        bne     L5315
        cmp     $905D
        beq     L5346
L5315:  lda     $905D
        pha
        lda     $905C
        pha
        lda     #$01
        sta     $905C
        sta     $905D
        jsr     GetDirHead
        bne     L533B
        jsr     L7D2A
        bne     L533B
        pla
        pla
        lda     curDrive
        ora     #$40
        sta     $886B
        sec
        rts

L533B:  pla
        sta     $905C
        pla
        sta     $905D
        jsr     GetDirHead
L5346:  clc
        rts

        sec
        lda     #$00
        sbc     r7L
        sta     r2L
        lda     #$79
        sbc     r7H
        sta     r2H
        lda     $8402
        sta     r1H
        lda     $8401
        sta     r1L
        lda     $8146
        cmp     #$01
        bne     L5376
        jsr     L903C
        txa
        bne     L538C
        lda     $8003
        sta     r1H
        lda     $8002
        sta     r1L
L5376:  jsr     L795E
        txa
        bne     L538C
        lda     #$00
        sta     r0L
        lda     $814C
        sta     r7H
        lda     $814B
        sta     r7L
        sec
        rts

L538C:  clc
        rts

        lda     $886A
        and     #$F0
        beq     L539D
        cmp     #$40
        bcc     L539F
        cmp     #$80
        beq     L539F
L539D:  clc
        rts

L539F:  sta     $7D13
        lda     TempCurDrive
        jsr     SetDevice
        bne     L53B5
        jsr     L7BD8
        bcc     L53B5
        jsr     L7BA4
        bcc     L53B5
        rts

L53B5:  lda     #$08
        sta     $7BA3
L53BA:  jsr     SetDevice
        bne     L53C9
        jsr     L7BD8
        bcc     L53C9
        jsr     L7BA4
        bcs     L53D9
L53C9:  inc     $7BA3
        lda     $7BA3
        cmp     TempCurDrive
        beq     L53C9
        cmp     #$0C
        bcc     L53BA
        clc
L53D9:  rts

        brk
        lda     $905D
        sta     $7D16
        lda     $905C
        sta     $7D15
        jsr     L9063
        lda     r2L
        sta     $7D14
        cmp     $8869
        bne     L53FD
        lda     $88C6
        and     #$F0
        cmp     #$10
        bne     L540C
L53FD:  jsr     L7CB7
        bcc     L5403
L5402:  rts

L5403:  lda     $88C6
        and     #$F0
        cmp     #$10
        bne     L5402
L540C:  jmp     L7CEC

        lda     $7D13
        bpl     L541F
        lda     $88C6
        and     #$F0
        cmp     #$30
        bne     L542B
L541D:  sec
        rts

L541F:  cmp     #$30
        bne     L542B
        lda     $88C6
        and     $9073
        bmi     L541D
L542B:  lda     $88C6
        and     #$F0
        cmp     $7D13
        beq     L541D
        clc
        rts

        ldx     #$01
        lda     $7C67
        sta     r6H
        lda     $7C66
        sta     r6L
        bit     $7C68
        bmi     L5478
        lda     #$C3
        sta     r6H
        lda     #$CF
        sta     r6L
        lda     #$7C
        sta     r2H
        lda     #$69
        sta     r2L
        ldx     #$0E
        ldy     #$06
        jsr     CmpString
        bne     L546C
        lda     #$7C
        sta     r6H
        lda     #$85
        sta     r6L
        ldx     #$00
        .byte   $2C
L546C:  ldx     #$01
        lda     $7C92,x
        sta     r0L
        lda     $7C94,x
        sta     r0H
L5478:  stx     $7C65
        rts

        jsr     i_PutString
        .byte   "P"
        .byte   $00
        .byte   "6Insert a disk with "


        .byte   $00
        jsr     L7C00
        jmp     PutString

        .byte   $00,$00,$00,$00
        .byte   "DESKTOP"
        .byte   $00
        .byte   "Insert a disk with "


        .byte   $00
        .byte   "Dashboard 64"

        .byte   $00
        .byte   $85,$CF,$7C,$C3,$80,$13,$45,$7C
        .byte   $01,$11,$48
        brk
        jsr     L7B11
        php
        ldx     $7D14
        jsr     L7D17
        lda     $7D16
        sta     r1H
        lda     $7D15
        sta     r1L
        jsr     L9053
        plp
        rts

        ldx     $8869
        jsr     L7D17
        jsr     L9050
        jsr     L7D2A
        bne     L550E
        lda     curDrive
        bit     $7C68
        bmi     L5507
        sta     TempCurDrive
L5507:  ora     #$80
        sta     $886B
        sec
        rts

L550E:  ldx     $7D14
        jsr     L7D17
        lda     $7D16
        sta     r1H
        lda     $7D15
        sta     r1L
        jsr     L9053
        clc
        rts

        jsr     L9050
        jsr     L7D2A
        bne     L553B
        lda     curDrive
        bit     $7C68
        bmi     L5536
        sta     TempCurDrive
L5536:  sta     $886B
        sec
        rts

L553B:  lda     $7D16
        sta     r1H
        lda     $7D15
        sta     r1L
        jsr     L9053
        clc
        rts

        brk
        brk
        brk
        brk
        jsr     L9D83
        lda     #$45
        jsr     L9D80
        jsr     L5015+3
        jsr     L9D83
        lda     #$4A
        jmp     L9D80

        jsr     L7C00
        jsr     FindFile
        txa
        bne     L5591
        lda     #$84
        sta     r9H
        lda     #$00
        sta     r9L
        jsr     GetFHdrInfo
        txa
        bne     L5591
        ldx     $7C65
        dex
        beq     L5591
        lda     $815A
        cmp     #$35
        bcs     L558F
        lda     $815C
        cmp     #$30
        bne     L558F
        ldx     #$05
        rts

L558F:  ldx     #$00
L5591:  rts

