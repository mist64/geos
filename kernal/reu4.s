; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu4.bin
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
        lda     #$80                            ; 500A A9 80                    ..
        sta     $0B                             ; 500C 85 0B                    ..
        lda     #$00                            ; 500E A9 00                    ..
        sta     $0A                             ; 5010 85 0A                    ..
        lda     $0F                             ; 5012 A5 0F                    ..
        pha                                     ; 5014 48                       H
        lda     $0E                             ; 5015 A5 0E                    ..
        pha                                     ; 5017 48                       H
        lda     $11                             ; 5018 A5 11                    ..
        pha                                     ; 501A 48                       H
        lda     $10                             ; 501B A5 10                    ..
        pha                                     ; 501D 48                       H
L501E:  ldy     #$00                            ; 501E A0 00                    ..
        lda     ($0E),y                         ; 5020 B1 0E                    ..
        beq     L5076                           ; 5022 F0 52                    .R
        sta     $04                             ; 5024 85 04                    ..
        iny                                     ; 5026 C8                       .
        lda     ($0E),y                         ; 5027 B1 0E                    ..
        sta     $05                             ; 5029 85 05                    ..
        dey                                     ; 502B 88                       .
        clc                                     ; 502C 18                       .
        lda     #$02                            ; 502D A9 02                    ..
        adc     $0E                             ; 502F 65 0E                    e.
        sta     $0E                             ; 5031 85 0E                    ..
        bcc     L5037                           ; 5033 90 02                    ..
        inc     $0F                             ; 5035 E6 0F                    ..
L5037:  lda     ($0E),y                         ; 5037 B1 0E                    ..
        sta     ($0A),y                         ; 5039 91 0A                    ..
        iny                                     ; 503B C8                       .
        lda     ($0E),y                         ; 503C B1 0E                    ..
        sta     ($0A),y                         ; 503E 91 0A                    ..
        ldy     #$FE                            ; 5040 A0 FE                    ..
        lda     #$30                            ; 5042 A9 30                    .0
        sta     $01                             ; 5044 85 01                    ..
        lda     $11                             ; 5046 A5 11                    ..
        cmp     #$4F                            ; 5048 C9 4F                    .O
        bcc     L5056                           ; 504A 90 0A                    ..
        cmp     #$52                            ; 504C C9 52                    .R
        bcs     L5056                           ; 504E B0 06                    ..
        jsr     L5086                           ; 5050 20 86 50                  .P
        clv                                     ; 5053 B8                       .
        bvc     L505F                           ; 5054 50 09                    P.
L5056:  dey                                     ; 5056 88                       .
        lda     ($10),y                         ; 5057 B1 10                    ..
        sta     $8002,y                         ; 5059 99 02 80                 ...
        tya                                     ; 505C 98                       .
        bne     L5056                           ; 505D D0 F7                    ..
L505F:  lda     #$36                            ; 505F A9 36                    .6
        sta     $01                             ; 5061 85 01                    ..
        jsr     WriteBlock                      ; 5063 20 20 C2                   .
        txa                                     ; 5066 8A                       .
        bne     L5077                           ; 5067 D0 0E                    ..
        clc                                     ; 5069 18                       .
        lda     #$FE                            ; 506A A9 FE                    ..
        adc     $10                             ; 506C 65 10                    e.
        sta     $10                             ; 506E 85 10                    ..
        bcc     L501E                           ; 5070 90 AC                    ..
        inc     $11                             ; 5072 E6 11                    ..
        bne     L501E                           ; 5074 D0 A8                    ..
L5076:  tax                                     ; 5076 AA                       .
L5077:  pla                                     ; 5077 68                       h
        sta     $10                             ; 5078 85 10                    ..
        pla                                     ; 507A 68                       h
        sta     $11                             ; 507B 85 11                    ..
        pla                                     ; 507D 68                       h
        sta     $0E                             ; 507E 85 0E                    ..
        pla                                     ; 5080 68                       h
        sta     $0F                             ; 5081 85 0F                    ..
        jmp     DoneWithIO                      ; 5083 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L5086:  lda     $15                             ; 5086 A5 15                    ..
        pha                                     ; 5088 48                       H
        lda     $14                             ; 5089 A5 14                    ..
        pha                                     ; 508B 48                       H
        lda     $09                             ; 508C A5 09                    ..
        pha                                     ; 508E 48                       H
        lda     $08                             ; 508F A5 08                    ..
        pha                                     ; 5091 48                       H
        lda     $07                             ; 5092 A5 07                    ..
        pha                                     ; 5094 48                       H
        lda     $06                             ; 5095 A5 06                    ..
        pha                                     ; 5097 48                       H
        lda     $05                             ; 5098 A5 05                    ..
        pha                                     ; 509A 48                       H
        lda     $04                             ; 509B A5 04                    ..
        pha                                     ; 509D 48                       H
        lda     $03                             ; 509E A5 03                    ..
        pha                                     ; 50A0 48                       H
        lda     $02                             ; 50A1 A5 02                    ..
        pha                                     ; 50A3 48                       H
        ldx     #$02                            ; 50A4 A2 02                    ..
        lda     $11                             ; 50A6 A5 11                    ..
        sta     $15                             ; 50A8 85 15                    ..
        lda     $10                             ; 50AA A5 10                    ..
        sta     $14                             ; 50AC 85 14                    ..
L50AE:  lda     $15                             ; 50AE A5 15                    ..
        cmp     #$50                            ; 50B0 C9 50                    .P
        bne     L50B8                           ; 50B2 D0 04                    ..
        lda     $14                             ; 50B4 A5 14                    ..
        cmp     #$00                            ; 50B6 C9 00                    ..
L50B8:  bcc     L50C6                           ; 50B8 90 0C                    ..
        lda     $15                             ; 50BA A5 15                    ..
        cmp     #$51                            ; 50BC C9 51                    .Q
        bne     L50C4                           ; 50BE D0 04                    ..
        lda     $14                             ; 50C0 A5 14                    ..
        cmp     #$5F                            ; 50C2 C9 5F                    ._
L50C4:  bcc     L50DD                           ; 50C4 90 17                    ..
L50C6:  ldy     #$00                            ; 50C6 A0 00                    ..
        lda     ($14),y                         ; 50C8 B1 14                    ..
        sta     $8000,x                         ; 50CA 9D 00 80                 ...
        clc                                     ; 50CD 18                       .
        lda     #$01                            ; 50CE A9 01                    ..
        adc     $14                             ; 50D0 65 14                    e.
        sta     $14                             ; 50D2 85 14                    ..
        bcc     L50D8                           ; 50D4 90 02                    ..
        inc     $15                             ; 50D6 E6 15                    ..
L50D8:  inx                                     ; 50D8 E8                       .
        bne     L50AE                           ; 50D9 D0 D3                    ..
        beq     L5107                           ; 50DB F0 2A                    .*
L50DD:  jsr     L5126                           ; 50DD 20 26 51                  &Q
        ldx     $02                             ; 50E0 A6 02                    ..
L50E2:  clc                                     ; 50E2 18                       .
        lda     #$01                            ; 50E3 A9 01                    ..
        adc     $14                             ; 50E5 65 14                    e.
        sta     $14                             ; 50E7 85 14                    ..
        bcc     L50ED                           ; 50E9 90 02                    ..
        inc     $15                             ; 50EB E6 15                    ..
L50ED:  inx                                     ; 50ED E8                       .
        beq     L5107                           ; 50EE F0 17                    ..
        lda     $15                             ; 50F0 A5 15                    ..
        cmp     #$51                            ; 50F2 C9 51                    .Q
        bne     L50FA                           ; 50F4 D0 04                    ..
        lda     $14                             ; 50F6 A5 14                    ..
        cmp     #$5F                            ; 50F8 C9 5F                    ._
L50FA:  bcc     L50E2                           ; 50FA 90 E6                    ..
        ldy     #$00                            ; 50FC A0 00                    ..
L50FE:  lda     ($14),y                         ; 50FE B1 14                    ..
        sta     $8000,x                         ; 5100 9D 00 80                 ...
        iny                                     ; 5103 C8                       .
        inx                                     ; 5104 E8                       .
        bne     L50FE                           ; 5105 D0 F7                    ..
L5107:  pla                                     ; 5107 68                       h
        sta     $02                             ; 5108 85 02                    ..
        pla                                     ; 510A 68                       h
        sta     $03                             ; 510B 85 03                    ..
        pla                                     ; 510D 68                       h
        sta     $04                             ; 510E 85 04                    ..
        pla                                     ; 5110 68                       h
        sta     $05                             ; 5111 85 05                    ..
        pla                                     ; 5113 68                       h
        sta     $06                             ; 5114 85 06                    ..
        pla                                     ; 5116 68                       h
        sta     $07                             ; 5117 85 07                    ..
        pla                                     ; 5119 68                       h
        sta     $08                             ; 511A 85 08                    ..
        pla                                     ; 511C 68                       h
        sta     $09                             ; 511D 85 09                    ..
        pla                                     ; 511F 68                       h
        sta     $14                             ; 5120 85 14                    ..
        pla                                     ; 5122 68                       h
        sta     $15                             ; 5123 85 15                    ..
        rts                                     ; 5125 60                       `

; ----------------------------------------------------------------------------
L5126:  sec                                     ; 5126 38                       8
        lda     $14                             ; 5127 A5 14                    ..
        sbc     #$00                            ; 5129 E9 00                    ..
        sta     $04                             ; 512B 85 04                    ..
        lda     $15                             ; 512D A5 15                    ..
        sbc     #$50                            ; 512F E9 50                    .P
        sta     $05                             ; 5131 85 05                    ..
        stx     $02                             ; 5133 86 02                    ..
        lda     #$80                            ; 5135 A9 80                    ..
        sta     $03                             ; 5137 85 03                    ..
        dex                                     ; 5139 CA                       .
        txa                                     ; 513A 8A                       .
        eor     #$FF                            ; 513B 49 FF                    I.
        sta     $06                             ; 513D 85 06                    ..
        lda     #$00                            ; 513F A9 00                    ..
        sta     $07                             ; 5141 85 07                    ..
        clc                                     ; 5143 18                       .
        lda     #$7B                            ; 5144 A9 7B                    .{
        adc     $04                             ; 5146 65 04                    e.
        sta     $04                             ; 5148 85 04                    ..
        lda     #$0D                            ; 514A A9 0D                    ..
        adc     $05                             ; 514C 65 05                    e.
        sta     $05                             ; 514E 85 05                    ..
        lda     $88C3                           ; 5150 AD C3 88                 ...
        sta     $08                             ; 5153 85 08                    ..
        inc     $88C3                           ; 5155 EE C3 88                 ...
        jsr     FetchRAM                        ; 5158 20 CB C2                  ..
        dec     $88C3                           ; 515B CE C3 88                 ...
        rts                                     ; 515E 60                       `

; ----------------------------------------------------------------------------
