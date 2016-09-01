; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu3.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
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
; ----------------------------------------------------------------------------
        jsr     EnterTurbo                      ; 5000 20 14 C2                  ..
        txa                                     ; 5003 8A                       .
        beq     L5007                           ; 5004 F0 01                    ..
        rts                                     ; 5006 60                       `

; ----------------------------------------------------------------------------
L5007:  jsr     InitForIO                       ; 5007 20 5C C2                  \.
        lda     $03                             ; 500A A5 03                    ..
        pha                                     ; 500C 48                       H
        lda     $02                             ; 500D A5 02                    ..
        pha                                     ; 500F 48                       H
        lda     #$80                            ; 5010 A9 80                    ..
        sta     $0B                             ; 5012 85 0B                    ..
        lda     #$00                            ; 5014 A9 00                    ..
        sta     $0A                             ; 5016 85 0A                    ..
        lda     #$02                            ; 5018 A9 02                    ..
        sta     $0C                             ; 501A 85 0C                    ..
        lda     $05                             ; 501C A5 05                    ..
        sta     $8303                           ; 501E 8D 03 83                 ...
        lda     $04                             ; 5021 A5 04                    ..
        sta     $8302                           ; 5023 8D 02 83                 ...
L5026:  jsr     ReadBlock                       ; 5026 20 1A C2                  ..
        txa                                     ; 5029 8A                       .
        bne     L509B                           ; 502A D0 6F                    .o
        ldy     #$FE                            ; 502C A0 FE                    ..
        lda     $8000                           ; 502E AD 00 80                 ...
        bne     L503B                           ; 5031 D0 08                    ..
        ldy     $8001                           ; 5033 AC 01 80                 ...
        beq     L5081                           ; 5036 F0 49                    .I
        dey                                     ; 5038 88                       .
        beq     L5081                           ; 5039 F0 46                    .F
L503B:  lda     $07                             ; 503B A5 07                    ..
        bne     L5049                           ; 503D D0 0A                    ..
        cpy     $06                             ; 503F C4 06                    ..
        bcc     L5049                           ; 5041 90 06                    ..
        beq     L5049                           ; 5043 F0 04                    ..
        ldx     #$0B                            ; 5045 A2 0B                    ..
        bne     L509B                           ; 5047 D0 52                    .R
L5049:  sty     $04                             ; 5049 84 04                    ..
        lda     #$30                            ; 504B A9 30                    .0
        sta     $01                             ; 504D 85 01                    ..
        lda     $11                             ; 504F A5 11                    ..
        cmp     #$4F                            ; 5051 C9 4F                    .O
        bcc     L505F                           ; 5053 90 0A                    ..
        cmp     #$52                            ; 5055 C9 52                    .R
        bcs     L505F                           ; 5057 B0 06                    ..
        jsr     L50A4                           ; 5059 20 A4 50                  .P
        clv                                     ; 505C B8                       .
        bvc     L5067                           ; 505D 50 08                    P.
L505F:  lda     $8001,y                         ; 505F B9 01 80                 ...
        dey                                     ; 5062 88                       .
        sta     ($10),y                         ; 5063 91 10                    ..
        bne     L505F                           ; 5065 D0 F8                    ..
L5067:  lda     #$36                            ; 5067 A9 36                    .6
        sta     $01                             ; 5069 85 01                    ..
        lda     $04                             ; 506B A5 04                    ..
        clc                                     ; 506D 18                       .
        adc     $10                             ; 506E 65 10                    e.
        sta     $10                             ; 5070 85 10                    ..
        bcc     L5076                           ; 5072 90 02                    ..
        inc     $11                             ; 5074 E6 11                    ..
L5076:  lda     $06                             ; 5076 A5 06                    ..
        sec                                     ; 5078 38                       8
        sbc     $04                             ; 5079 E5 04                    ..
        sta     $06                             ; 507B 85 06                    ..
        bcs     L5081                           ; 507D B0 02                    ..
        dec     $07                             ; 507F C6 07                    ..
L5081:  inc     $0C                             ; 5081 E6 0C                    ..
        inc     $0C                             ; 5083 E6 0C                    ..
        ldy     $0C                             ; 5085 A4 0C                    ..
        lda     $8001                           ; 5087 AD 01 80                 ...
        sta     $05                             ; 508A 85 05                    ..
        sta     $8301,y                         ; 508C 99 01 83                 ...
        lda     $8000                           ; 508F AD 00 80                 ...
        sta     $04                             ; 5092 85 04                    ..
        sta     $8300,y                         ; 5094 99 00 83                 ...
        bne     L5026                           ; 5097 D0 8D                    ..
        ldx     #$00                            ; 5099 A2 00                    ..
L509B:  pla                                     ; 509B 68                       h
        sta     $02                             ; 509C 85 02                    ..
        pla                                     ; 509E 68                       h
        sta     $03                             ; 509F 85 03                    ..
        jmp     DoneWithIO                      ; 50A1 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L50A4:  lda     $16                             ; 50A4 A5 16                    ..
        pha                                     ; 50A6 48                       H
        lda     $15                             ; 50A7 A5 15                    ..
        pha                                     ; 50A9 48                       H
        lda     $14                             ; 50AA A5 14                    ..
        pha                                     ; 50AC 48                       H
        lda     $09                             ; 50AD A5 09                    ..
        pha                                     ; 50AF 48                       H
        lda     $08                             ; 50B0 A5 08                    ..
        pha                                     ; 50B2 48                       H
        lda     $07                             ; 50B3 A5 07                    ..
        pha                                     ; 50B5 48                       H
        lda     $06                             ; 50B6 A5 06                    ..
        pha                                     ; 50B8 48                       H
        lda     $05                             ; 50B9 A5 05                    ..
        pha                                     ; 50BB 48                       H
        lda     $04                             ; 50BC A5 04                    ..
        pha                                     ; 50BE 48                       H
        lda     $03                             ; 50BF A5 03                    ..
        pha                                     ; 50C1 48                       H
        lda     $02                             ; 50C2 A5 02                    ..
        pha                                     ; 50C4 48                       H
        ldx     #$00                            ; 50C5 A2 00                    ..
        sty     $16                             ; 50C7 84 16                    ..
        lda     $11                             ; 50C9 A5 11                    ..
        sta     $15                             ; 50CB 85 15                    ..
        lda     $10                             ; 50CD A5 10                    ..
        sta     $14                             ; 50CF 85 14                    ..
L50D1:  lda     $15                             ; 50D1 A5 15                    ..
        cmp     #$50                            ; 50D3 C9 50                    .P
        bne     L50DB                           ; 50D5 D0 04                    ..
        lda     $14                             ; 50D7 A5 14                    ..
        cmp     #$00                            ; 50D9 C9 00                    ..
L50DB:  bcc     L50E9                           ; 50DB 90 0C                    ..
        lda     $15                             ; 50DD A5 15                    ..
        cmp     #$51                            ; 50DF C9 51                    .Q
        bne     L50E7                           ; 50E1 D0 04                    ..
        lda     $14                             ; 50E3 A5 14                    ..
        cmp     #$C2                            ; 50E5 C9 C2                    ..
L50E7:  bcc     L5102                           ; 50E7 90 19                    ..
L50E9:  ldy     #$00                            ; 50E9 A0 00                    ..
        lda     $8002,x                         ; 50EB BD 02 80                 ...
        sta     ($14),y                         ; 50EE 91 14                    ..
        clc                                     ; 50F0 18                       .
        lda     #$01                            ; 50F1 A9 01                    ..
        adc     $14                             ; 50F3 65 14                    e.
        sta     $14                             ; 50F5 85 14                    ..
        bcc     L50FB                           ; 50F7 90 02                    ..
        inc     $15                             ; 50F9 E6 15                    ..
L50FB:  inx                                     ; 50FB E8                       .
        cpx     $16                             ; 50FC E4 16                    ..
        bcc     L50D1                           ; 50FE 90 D1                    ..
        bcs     L512D                           ; 5100 B0 2B                    .+
L5102:  jsr     L514F                           ; 5102 20 4F 51                  OQ
        clc                                     ; 5105 18                       .
        lda     $14                             ; 5106 A5 14                    ..
        adc     $06                             ; 5108 65 06                    e.
        sta     $14                             ; 510A 85 14                    ..
        lda     $15                             ; 510C A5 15                    ..
        adc     $07                             ; 510E 65 07                    e.
        sta     $15                             ; 5110 85 15                    ..
        clc                                     ; 5112 18                       .
        lda     $02                             ; 5113 A5 02                    ..
        adc     $06                             ; 5115 65 06                    e.
        bcs     L512D                           ; 5117 B0 14                    ..
        tax                                     ; 5119 AA                       .
        dex                                     ; 511A CA                       .
        dex                                     ; 511B CA                       .
        cpx     $16                             ; 511C E4 16                    ..
        bcs     L512D                           ; 511E B0 0D                    ..
        ldy     #$00                            ; 5120 A0 00                    ..
L5122:  lda     $8002,x                         ; 5122 BD 02 80                 ...
        sta     ($14),y                         ; 5125 91 14                    ..
        iny                                     ; 5127 C8                       .
        inx                                     ; 5128 E8                       .
        cpx     $16                             ; 5129 E4 16                    ..
        bcc     L5122                           ; 512B 90 F5                    ..
L512D:  pla                                     ; 512D 68                       h
        sta     $02                             ; 512E 85 02                    ..
        pla                                     ; 5130 68                       h
        sta     $03                             ; 5131 85 03                    ..
        pla                                     ; 5133 68                       h
        sta     $04                             ; 5134 85 04                    ..
        pla                                     ; 5136 68                       h
        sta     $05                             ; 5137 85 05                    ..
        pla                                     ; 5139 68                       h
        sta     $06                             ; 513A 85 06                    ..
        pla                                     ; 513C 68                       h
        sta     $07                             ; 513D 85 07                    ..
        pla                                     ; 513F 68                       h
        sta     $08                             ; 5140 85 08                    ..
        pla                                     ; 5142 68                       h
        sta     $09                             ; 5143 85 09                    ..
        pla                                     ; 5145 68                       h
        sta     $14                             ; 5146 85 14                    ..
        pla                                     ; 5148 68                       h
        sta     $15                             ; 5149 85 15                    ..
        pla                                     ; 514B 68                       h
        sta     $16                             ; 514C 85 16                    ..
        rts                                     ; 514E 60                       `

; ----------------------------------------------------------------------------
L514F:  sec                                     ; 514F 38                       8
        lda     $14                             ; 5150 A5 14                    ..
        sbc     #$00                            ; 5152 E9 00                    ..
        sta     $04                             ; 5154 85 04                    ..
        lda     $15                             ; 5156 A5 15                    ..
        sbc     #$50                            ; 5158 E9 50                    .P
        sta     $05                             ; 515A 85 05                    ..
        txa                                     ; 515C 8A                       .
        clc                                     ; 515D 18                       .
        adc     #$02                            ; 515E 69 02                    i.
        sta     $02                             ; 5160 85 02                    ..
        lda     #$80                            ; 5162 A9 80                    ..
        sta     $03                             ; 5164 85 03                    ..
        stx     $06                             ; 5166 86 06                    ..
        sec                                     ; 5168 38                       8
        lda     $16                             ; 5169 A5 16                    ..
        sbc     $06                             ; 516B E5 06                    ..
        sta     $06                             ; 516D 85 06                    ..
        lda     #$00                            ; 516F A9 00                    ..
        sta     $07                             ; 5171 85 07                    ..
        clc                                     ; 5173 18                       .
        lda     $04                             ; 5174 A5 04                    ..
        adc     $06                             ; 5176 65 06                    e.
        sta     $08                             ; 5178 85 08                    ..
        lda     $05                             ; 517A A5 05                    ..
        adc     $07                             ; 517C 65 07                    e.
        sta     $09                             ; 517E 85 09                    ..
        lda     $09                             ; 5180 A5 09                    ..
        cmp     #$01                            ; 5182 C9 01                    ..
        bne     L518A                           ; 5184 D0 04                    ..
        lda     $08                             ; 5186 A5 08                    ..
        cmp     #$C2                            ; 5188 C9 C2                    ..
L518A:  bcc     L51A6                           ; 518A 90 1A                    ..
        sec                                     ; 518C 38                       8
        lda     $08                             ; 518D A5 08                    ..
        sbc     #$C2                            ; 518F E9 C2                    ..
        sta     $08                             ; 5191 85 08                    ..
        lda     $09                             ; 5193 A5 09                    ..
        sbc     #$01                            ; 5195 E9 01                    ..
        sta     $09                             ; 5197 85 09                    ..
        sec                                     ; 5199 38                       8
        lda     $06                             ; 519A A5 06                    ..
        sbc     $08                             ; 519C E5 08                    ..
        sta     $06                             ; 519E 85 06                    ..
        lda     $07                             ; 51A0 A5 07                    ..
        sbc     $09                             ; 51A2 E5 09                    ..
        sta     $07                             ; 51A4 85 07                    ..
L51A6:  clc                                     ; 51A6 18                       .
        lda     #$27                            ; 51A7 A9 27                    .'
        adc     $04                             ; 51A9 65 04                    e.
        sta     $04                             ; 51AB 85 04                    ..
        lda     #$06                            ; 51AD A9 06                    ..
        adc     $05                             ; 51AF 65 05                    e.
        sta     $05                             ; 51B1 85 05                    ..
        lda     $88C3                           ; 51B3 AD C3 88                 ...
        sta     $08                             ; 51B6 85 08                    ..
        inc     $88C3                           ; 51B8 EE C3 88                 ...
        jsr     StashRAM                        ; 51BB 20 C8 C2                  ..
        dec     $88C3                           ; 51BE CE C3 88                 ...
        rts                                     ; 51C1 60                       `

; ----------------------------------------------------------------------------
