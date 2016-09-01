; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu1.bin
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
LFF93           := $FF93
LFFA8           := $FFA8
LFFAE           := $FFAE
LFFB1           := $FFB1
; ----------------------------------------------------------------------------
        jmp     L5006                           ; 5000 4C 06 50                 L.P

; ----------------------------------------------------------------------------
        jmp     L5098                           ; 5003 4C 98 50                 L.P

; ----------------------------------------------------------------------------
L5006:  stx     L5061                           ; 5006 8E 61 50                 .aP
        txa                                     ; 5009 8A                       .
        ora     #$20                            ; 500A 09 20                    . 
        sta     L505C                           ; 500C 8D 5C 50                 .\P
        and     #$1F                            ; 500F 29 1F                    ).
        ora     #$40                            ; 5011 09 40                    .@
        sta     L505D                           ; 5013 8D 5D 50                 .]P
        jsr     PurgeTurbo                      ; 5016 20 35 C2                  5.
        jsr     InitForIO                       ; 5019 20 5C C2                  \.
        lda     #$50                            ; 501C A9 50                    .P
        sta     $8C                             ; 501E 85 8C                    ..
        lda     #$56                            ; 5020 A9 56                    .V
        sta     $8B                             ; 5022 85 8B                    ..
        ldy     #$08                            ; 5024 A0 08                    ..
        lda     $88C6                           ; 5026 AD C6 88                 ...
        bmi     L503E                           ; 5029 30 13                    0.
        cmp     #$01                            ; 502B C9 01                    ..
        beq     L5039                           ; 502D F0 0A                    ..
        lda     #$50                            ; 502F A9 50                    .P
        sta     $8C                             ; 5031 85 8C                    ..
        lda     #$5E                            ; 5033 A9 5E                    .^
        sta     $8B                             ; 5035 85 8B                    ..
        ldy     #$04                            ; 5037 A0 04                    ..
L5039:  jsr     L5062                           ; 5039 20 62 50                  bP
        bne     L5053                           ; 503C D0 15                    ..
L503E:  ldy     L5061                           ; 503E AC 61 50                 .aP
        cpy     #$08                            ; 5041 C0 08                    ..
        bcc     L5053                           ; 5043 90 0E                    ..
        cpy     #$0C                            ; 5045 C0 0C                    ..
        bcs     L5053                           ; 5047 B0 0A                    ..
        lda     #$00                            ; 5049 A9 00                    ..
        sta     $848A,y                         ; 504B 99 8A 84                 ...
        sty     $8489                           ; 504E 8C 89 84                 ...
        sty     $BA                             ; 5051 84 BA                    ..
L5053:  jmp     DoneWithIO                      ; 5053 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        eor     $572D                           ; 5056 4D 2D 57                 M-W
        .byte   $77                             ; 5059 77                       w
        brk                                     ; 505A 00                       .
        .byte   $02                             ; 505B 02                       .
L505C:  plp                                     ; 505C 28                       (
L505D:  pha                                     ; 505D 48                       H
        eor     $30,x                           ; 505E 55 30                    U0
        .byte   $3E                             ; 5060 3E                       >
L5061:  php                                     ; 5061 08                       .
L5062:  sty     L5097                           ; 5062 8C 97 50                 ..P
        jsr     LFFAE                           ; 5065 20 AE FF                  ..
        lda     #$00                            ; 5068 A9 00                    ..
        sta     $90                             ; 506A 85 90                    ..
        lda     $BA                             ; 506C A5 BA                    ..
        jsr     LFFB1                           ; 506E 20 B1 FF                  ..
        lda     $90                             ; 5071 A5 90                    ..
        bne     L5091                           ; 5073 D0 1C                    ..
        lda     #$6F                            ; 5075 A9 6F                    .o
        jsr     LFF93                           ; 5077 20 93 FF                  ..
        lda     $90                             ; 507A A5 90                    ..
        bne     L5091                           ; 507C D0 13                    ..
        ldy     #$00                            ; 507E A0 00                    ..
L5080:  lda     ($8B),y                         ; 5080 B1 8B                    ..
        jsr     LFFA8                           ; 5082 20 A8 FF                  ..
        iny                                     ; 5085 C8                       .
        cpy     L5097                           ; 5086 CC 97 50                 ..P
        bcc     L5080                           ; 5089 90 F5                    ..
        jsr     LFFAE                           ; 508B 20 AE FF                  ..
        ldx     #$00                            ; 508E A2 00                    ..
        rts                                     ; 5090 60                       `

; ----------------------------------------------------------------------------
L5091:  jsr     LFFAE                           ; 5091 20 AE FF                  ..
        ldx     #$0D                            ; 5094 A2 0D                    ..
        rts                                     ; 5096 60                       `

; ----------------------------------------------------------------------------
L5097:  brk                                     ; 5097 00                       .
L5098:  lda     $8489                           ; 5098 AD 89 84                 ...
        pha                                     ; 509B 48                       H
        ldx     $0C                             ; 509C A6 0C                    ..
        lda     $8486,x                         ; 509E BD 86 84                 ...
        sta     L5168                           ; 50A1 8D 68 51                 .hQ
        beq     L50B9                           ; 50A4 F0 13                    ..
        txa                                     ; 50A6 8A                       .
        jsr     SetDevice                       ; 50A7 20 B0 C2                  ..
        ldx     #$19                            ; 50AA A2 19                    ..
        jsr     L5006                           ; 50AC 20 06 50                  .P
        ldx     $0C                             ; 50AF A6 0C                    ..
        lda     #$00                            ; 50B1 A9 00                    ..
        sta     $8486,x                         ; 50B3 9D 86 84                 ...
        sta     $88C6                           ; 50B6 8D C6 88                 ...
L50B9:  ldx     $0D                             ; 50B9 A6 0D                    ..
        lda     $8486,x                         ; 50BB BD 86 84                 ...
        sta     L5169                           ; 50BE 8D 69 51                 .iQ
        beq     L50D6                           ; 50C1 F0 13                    ..
        txa                                     ; 50C3 8A                       .
        jsr     SetDevice                       ; 50C4 20 B0 C2                  ..
        ldx     $0C                             ; 50C7 A6 0C                    ..
        jsr     L5006                           ; 50C9 20 06 50                  .P
        ldx     $0D                             ; 50CC A6 0D                    ..
        lda     #$00                            ; 50CE A9 00                    ..
        sta     $8486,x                         ; 50D0 9D 86 84                 ...
        sta     $88C6                           ; 50D3 8D C6 88                 ...
L50D6:  ldx     $0C                             ; 50D6 A6 0C                    ..
        jsr     L513F                           ; 50D8 20 3F 51                  ?Q
        ldx     $0D                             ; 50DB A6 0D                    ..
        jsr     L513F                           ; 50DD 20 3F 51                  ?Q
        ldx     $0C                             ; 50E0 A6 0C                    ..
        jsr     L513F                           ; 50E2 20 3F 51                  ?Q
        lda     #$00                            ; 50E5 A9 00                    ..
        sta     $8489                           ; 50E7 8D 89 84                 ...
        ldx     $0C                             ; 50EA A6 0C                    ..
        lda     L5169                           ; 50EC AD 69 51                 .iQ
        sta     $8486,x                         ; 50EF 9D 86 84                 ...
        ldx     $0D                             ; 50F2 A6 0D                    ..
        lda     $88BF,x                         ; 50F4 BD BF 88                 ...
        pha                                     ; 50F7 48                       H
        lda     $88B7,x                         ; 50F8 BD B7 88                 ...
        pha                                     ; 50FB 48                       H
        ldy     $0C                             ; 50FC A4 0C                    ..
        lda     $88BF,y                         ; 50FE B9 BF 88                 ...
        sta     $88BF,x                         ; 5101 9D BF 88                 ...
        .byte   $B9                             ; 5104 B9                       .
L5105:  .byte   $B7                             ; 5105 B7                       .
        dey                                     ; 5106 88                       .
        sta     $88B7,x                         ; 5107 9D B7 88                 ...
        pla                                     ; 510A 68                       h
        sta     $88B7,y                         ; 510B 99 B7 88                 ...
        pla                                     ; 510E 68                       h
        sta     $88BF,y                         ; 510F 99 BF 88                 ...
        lda     L5168                           ; 5112 AD 68 51                 .hQ
        sta     $8486,x                         ; 5115 9D 86 84                 ...
        beq     L5127                           ; 5118 F0 0D                    ..
        txa                                     ; 511A 8A                       .
        jsr     SetDevice                       ; 511B 20 B0 C2                  ..
        lda     #$19                            ; 511E A9 19                    ..
        sta     $BA                             ; 5120 85 BA                    ..
        ldx     $0D                             ; 5122 A6 0D                    ..
        jsr     L5006                           ; 5124 20 06 50                  .P
L5127:  pla                                     ; 5127 68                       h
        cmp     $0C                             ; 5128 C5 0C                    ..
        beq     L5131                           ; 512A F0 05                    ..
        cmp     $0D                             ; 512C C5 0D                    ..
        beq     L5134                           ; 512E F0 04                    ..
        .byte   $2C                             ; 5130 2C                       ,
L5131:  lda     $0D                             ; 5131 A5 0D                    ..
        .byte   $2C                             ; 5133 2C                       ,
L5134:  lda     $0C                             ; 5134 A5 0C                    ..
        jsr     SetDevice                       ; 5136 20 B0 C2                  ..
        bne     L513E                           ; 5139 D0 03                    ..
        jsr     EnterTurbo                      ; 513B 20 14 C2                  ..
L513E:  rts                                     ; 513E 60                       `

; ----------------------------------------------------------------------------
L513F:  lda     #$90                            ; 513F A9 90                    ..
        sta     $03                             ; 5141 85 03                    ..
        lda     #$00                            ; 5143 A9 00                    ..
        sta     $02                             ; 5145 85 02                    ..
        lda     L5158,x                         ; 5147 BD 58 51                 .XQ
        sta     $04                             ; 514A 85 04                    ..
        lda     L515C,x                         ; 514C BD 5C 51                 .\Q
        sta     $05                             ; 514F 85 05                    ..
        lda     #$0D                            ; 5151 A9 0D                    ..
        sta     $07                             ; 5153 85 07                    ..
        lda     #$80                            ; 5155 A9 80                    ..
        .byte   $85                             ; 5157 85                       .
L5158:  asl     $A9                             ; 5158 06 A9                    ..
        brk                                     ; 515A 00                       .
        .byte   $85                             ; 515B 85                       .
L515C:  php                                     ; 515C 08                       .
        jmp     SwapRAM                         ; 515D 4C CE C2                 L..

; ----------------------------------------------------------------------------
        brk                                     ; 5160 00                       .
        .byte   $80                             ; 5161 80                       .
        brk                                     ; 5162 00                       .
        .byte   $80                             ; 5163 80                       .
        .byte   $83                             ; 5164 83                       .
        bcc     L5105                           ; 5165 90 9E                    ..
        .byte   $AB                             ; 5167 AB                       .
L5168:  brk                                     ; 5168 00                       .
L5169:  brk                                     ; 5169 00                       .
