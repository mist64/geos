; da65 V2.15
; Created:    2016-09-01 21:51:58
; Input file: reu0.bin
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
L0810           := $0810
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
        jmp     L51B6

        jmp     L51D8

        jmp     L51E6

        jmp     L51F3

        jmp     L5208

        jmp     L5235

        jmp     L5266

        jmp     L52C8

        jmp     L5325

        jmp     L5374

        jmp     L52F4

        .byte   "MR"
        .byte   $22
L5024:  .byte   $00
L5025:  .byte   $7E,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
L5045:  .byte   $7E,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00
L5064:  .byte   $00,$00,$00,$00,$00,$00,$00,$00
L506C:  .byte   $00,$00,$00,$00,$00,$00,$00,$00
L5074:  .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$00,$00,$00,$00,$00,$00,$00
        .byte   $00,$42,$51,$7B,$51
L5109:  .byte   $59,$17,$35,$1F,$2F,$3D,$FF,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$69,$15,$1F,$33,$35,$1B,$FF
        .byte   $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF
        .byte   $FF,$FF,$51,$6F,$A5,$9D,$9B,$99
        .byte   $9B,$7D,$FF,$61,$11,$23,$35,$1B
        .byte   $8B,$BF,$FF,$53,$6D,$63,$8B,$BF
        .byte   $FF
        jsr     L51A7
        lda     r11H
        pha
        lda     r11L
        pha
        jsr     L5194
        jsr     L518B
        lda     #$20
        jsr     PutChar
        jsr     L518E
        pla
        sta     r11L
        pla
        sta     r11H
        clc
        lda     r1H
        adc     #$0A
        sta     r1H
        jsr     L5197
        jsr     L5191
L516C:  ldx     #$38
L516E:  lda     L5109,x
        asl     a
        eor     #$FF
        sta     L5109,x
        dex
        bpl     L516E
        rts

        jsr     L51A7
        ldy     #$2A
L5180:  lda     L5109,y
        sta     (r0L),y
        dey
        bpl     L5180
        jmp     L516C

L518B:  lda     #$00
        .byte   $2C
L518E:  lda     #$11
        .byte   $2C
L5191:  lda     #$22
        .byte   $2C
L5194:  lda     #$2B
        .byte   $2C
L5197:  lda     #$33
        clc
        adc     #$09
        sta     r0L
        lda     #$51
        adc     #$00
        sta     r0H
        jmp     PutString

L51A7:  ldx     #$38
L51A9:  lda     L5109,x
        eor     #$FF
        lsr     a
        sta     L5109,x
        dex
        bpl     L51A9
        rts

L51B6:  ldy     #$1F
L51B8:  lda     L5025,y
        sta     L5045,y
        dey
        bpl     L51B8
L51C1:  tya
        pha
        ldy     #$00
        tya
L51C6:  eor     L5025,y
        clc
        adc     L5025,y
        iny
        cpy     #$E0
        bcc     L51C6
        sta     L5024
        pla
        tay
        rts

L51D8:  ldy     #$1F
L51DA:  lda     L5045,y
        sta     L5025,y
        dey
        bpl     L51DA
        jmp     L51C1

L51E6:  ldy     #$1F
        lda     #$00
L51EA:  sta     L5045,y
        dey
        bpl     L51EA
        jmp     L51C1

L51F3:  jsr     L5212
        bcs     L520F
        beq     L520F
L51FA:  lda     L522D,x
        eor     L5045,y
        sta     L5045,y
        ldx     #$00
        jmp     L51C1

L5208:  jsr     L5212
        bcs     L520F
        beq     L51FA
L520F:  ldx     #$06
        rts

L5212:  sec
        lda     r6L
        beq     L522C
        cmp     $88C3
        bcs     L522C
        pha
        lsr     a
        lsr     a
        lsr     a
        tay
        pla
        and     #$07
        tax
        lda     L522D,x
        and     L5045,y
        clc
L522C:  rts

L522D:  .byte   $80
        rti

        jsr     L0810
        .byte   $04
        .byte   $02
        .byte   $01
L5235:  jsr     L51B6
        ldx     $88C3
        dex
        stx     r2L
        lda     #$00
        sta     r3L
        jsr     L5266
        lda     r6H
        sta     r2L
        jsr     L51B6
        lda     #$00
        sta     r4L
        sta     r4H
        lda     #$01
        sta     r6L
L5256:  jsr     L5212
        bcs     L5263
        beq     L525F
        inc     r4H
L525F:  inc     r6L
        bne     L5256
L5263:  jmp     L51B6

L5266:  ldx     r3L
        stx     L52C7
        bne     L526E
        inx
L526E:  stx     r6L
        stx     r3L
        stx     r9L
        lda     #$00
        sta     r6H
        lda     r2L
        sta     r3H
L527C:  lda     #$00
        sta     r2H
L5280:  jsr     L5212
        bcs     L52C4
        bne     L5293
        lda     r2L
        sta     r3H
        inc     r6L
        lda     r6L
        sta     r9L
        bne     L527C
L5293:  inc     r2H
        lda     r2H
        cmp     r6H
        bcc     L52A1
        sta     r6H
        lda     r9L
        sta     r3L
L52A1:  inc     r6L
        dec     r3H
        bne     L5280
        lda     r2H
        sta     r3H
        lda     r9L
        sta     r6L
        lda     L52C7
        beq     L52B8
        cmp     r3L
        bne     L52C4
L52B8:  jsr     L51F3
        inc     r6L
        dec     r3H
        bne     L52B8
        ldx     #$00
        rts

L52C4:  ldx     #$03
        rts

L52C7:  .byte   $01
L52C8:  lda     NUMDRV
        cmp     #$02
        bcc     L52F3
        ldy     r4L
        lda     $8486,y
        beq     L52F3
        tya
        jsr     SetDevice
        jsr     PurgeTurbo
        lda     #$00
        ldy     curDrive
        sta     $8486,y
        sta     $88BF,y
        sta     $88C6
        sta     curDrive
        sta     curDevice
        dec     NUMDRV
L52F3:  rts

L52F4:  tya
        pha
        lda     L5064,y
        sta     r7L
        lda     L5074,y
        sta     r2L
        lda     L506C,y
        sta     r3L
        jsr     L530B
        pla
        tay
        rts

L530B:  lda     #$50
        sta     r1H
        lda     #$7D
        sta     r1L
        dey
        beq     L5324
L5316:  clc
        lda     #$11
        adc     r1L
        sta     r1L
        bcc     L5321
        inc     r1H
L5321:  dey
        bne     L5316
L5324:  rts

L5325:  ldx     #$04
        tya
        beq     L5334
        cpy     #$09
        bcs     L5372
        lda     L506C,y
        beq     L5340
        rts

L5334:  iny
L5335:  lda     L506C,y
        beq     L5340
        iny
        cpy     #$09
        bcc     L5335
        rts

L5340:  sty     L5373
        jsr     L51B6
        jsr     L5266
        txa
        bne     L5372
        ldy     L5373
        lda     r3L
        sta     L506C,y
        lda     r2L
        sta     L5074,y
        lda     r7L
        sta     L5064,y
        jsr     L530B
        ldy     #$10
L5363:  lda     (r0L),y
        sta     (r1L),y
        dey
        bpl     L5363
        jsr     L51D8
        ldy     L5373
        ldx     #$00
L5372:  rts

L5373:  .byte   $01
L5374:  ldx     #$0D
        tya
        beq     L5382
        cpy     #$09
        bcs     L5382
        lda     L506C,y
        bne     L5383
L5382:  rts

L5383:  sty     L5373
        jsr     L51B6
        ldy     L5373
        lda     L506C,y
        sta     r6L
        lda     L5074,y
        sta     r3H
        beq     L53A1
L5398:  jsr     L5208
        inc     r6L
        dec     r3H
        bne     L5398
L53A1:  ldy     L5373
        lda     #$00
        sta     L5064,y
        sta     L5074,y
        sta     L506C,y
        jsr     L530B
        ldy     #$00
        tya
        sta     (r1L),y
        jsr     L51D8
        ldx     #$00
        rts

