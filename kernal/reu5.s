; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu5.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L0000           := $0000
L0020           := $0020
L03C0           := $03C0
L2020           := $2020
L4000           := $4000
L4003           := $4003
L406F           := $406F
L4097           := $4097
L6564           := $6564
L6F73           := $6F73
L8003           := $8003
L8103           := $8103
L9030           := $9030
L9033           := $9033
L9050           := $9050
L9053           := $9053
L9063           := $9063
L9066           := $9066
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
LC316           := $C316
LCFD9           := $CFD9
LFF93           := $FF93
LFF96           := $FF96
LFFA5           := $FFA5
LFFA8           := $FFA8
LFFAB           := $FFAB
LFFAE           := $FFAE
LFFB1           := $FFB1
LFFB4           := $FFB4
; ----------------------------------------------------------------------------
        jmp     L502A                           ; 5000 4C 2A 50                 L*P

; ----------------------------------------------------------------------------
        jmp     L50DD                           ; 5003 4C DD 50                 L.P

; ----------------------------------------------------------------------------
        jmp     L57C5                           ; 5006 4C C5 57                 L.W

; ----------------------------------------------------------------------------
        jmp     L573F                           ; 5009 4C 3F 57                 L?W

; ----------------------------------------------------------------------------
        jmp     L5AB7                           ; 500C 4C B7 5A                 L.Z

; ----------------------------------------------------------------------------
        jmp     L5889                           ; 500F 4C 89 58                 L.X

; ----------------------------------------------------------------------------
        jmp     L587A                           ; 5012 4C 7A 58                 LzX

; ----------------------------------------------------------------------------
        jmp     L5864                           ; 5015 4C 64 58                 LdX

; ----------------------------------------------------------------------------
        jmp     L56C3                           ; 5018 4C C3 56                 L.V

; ----------------------------------------------------------------------------
        rts                                     ; 501B 60                       `

; ----------------------------------------------------------------------------
        nop                                     ; 501C EA                       .
        nop                                     ; 501D EA                       .
        jmp     L50D7                           ; 501E 4C D7 50                 L.P

; ----------------------------------------------------------------------------
        jmp     L51CC                           ; 5021 4C CC 51                 L.Q

; ----------------------------------------------------------------------------
        rts                                     ; 5024 60                       `

; ----------------------------------------------------------------------------
        nop                                     ; 5025 EA                       .
        nop                                     ; 5026 EA                       .
        jmp     L527C                           ; 5027 4C 7C 52                 L|R

; ----------------------------------------------------------------------------
L502A:  lda     $0A                             ; 502A A5 0A                    ..
        cmp     #$01                            ; 502C C9 01                    ..
        beq     L5037                           ; 502E F0 07                    ..
        cmp     #$04                            ; 5030 C9 04                    ..
        bne     L5047                           ; 5032 D0 13                    ..
        lda     #$03                            ; 5034 A9 03                    ..
        .byte   $2C                             ; 5036 2C                       ,
L5037:  lda     #$04                            ; 5037 A9 04                    ..
        sta     $0A                             ; 5039 85 0A                    ..
        lda     $88C6                           ; 503B AD C6 88                 ...
        and     #$0F                            ; 503E 29 0F                    ).
        cmp     $0A                             ; 5040 C5 0A                    ..
        beq     L50BC                           ; 5042 F0 78                    .x
        jsr     L5161                           ; 5044 20 61 51                  aQ
L5047:  bne     L50B8                           ; 5047 D0 6F                    .o
        jsr     PurgeTurbo                      ; 5049 20 35 C2                  5.
        lda     $88C6                           ; 504C AD C6 88                 ...
        and     #$F0                            ; 504F 29 F0                    ).
        ora     $0A                             ; 5051 05 0A                    ..
        sta     $0A                             ; 5053 85 0A                    ..
        ldx     #$05                            ; 5055 A2 05                    ..
L5057:  cmp     L50C9,x                         ; 5057 DD C9 50                 ..P
        beq     L5061                           ; 505A F0 05                    ..
        dex                                     ; 505C CA                       .
        bpl     L5057                           ; 505D 10 F8                    ..
        bmi     L50B8                           ; 505F 30 57                    0W
L5061:  lda     $9073                           ; 5061 AD 73 90                 .s.
        pha                                     ; 5064 48                       H
        lda     #$90                            ; 5065 A9 90                    ..
        sta     $03                             ; 5067 85 03                    ..
        lda     #$00                            ; 5069 A9 00                    ..
        sta     $02                             ; 506B 85 02                    ..
        lda     L50BD,x                         ; 506D BD BD 50                 ..P
        sta     $04                             ; 5070 85 04                    ..
        .byte   $BD                             ; 5072 BD                       .
        .byte   $C3                             ; 5073 C3                       .
L5074:  bvc     $4FFB                           ; 5074 50 85                    P.
        ora     $A9                             ; 5076 05 A9                    ..
        ora     $0785                           ; 5078 0D 85 07                 ...
        lda     #$80                            ; 507B A9 80                    ..
        sta     $06                             ; 507D 85 06                    ..
        lda     $0A                             ; 507F A5 0A                    ..
        and     #$0F                            ; 5081 29 0F                    ).
        cmp     #$03                            ; 5083 C9 03                    ..
        bne     L5089                           ; 5085 D0 02                    ..
        dec     $07                             ; 5087 C6 07                    ..
L5089:  lda     $88C3                           ; 5089 AD C3 88                 ...
        sta     $08                             ; 508C 85 08                    ..
        inc     $88C3                           ; 508E EE C3 88                 ...
        jsr     FetchRAM                        ; 5091 20 CB C2                  ..
        dec     $88C3                           ; 5094 CE C3 88                 ...
        ldy     $8489                           ; 5097 AC 89 84                 ...
        lda     $904E                           ; 509A AD 4E 90                 .N.
        sta     $8486,y                         ; 509D 99 86 84                 ...
        sta     $88C6                           ; 50A0 8D C6 88                 ...
        pla                                     ; 50A3 68                       h
        sta     $9073                           ; 50A4 8D 73 90                 .s.
        .byte   $B9                             ; 50A7 B9                       .
        .byte   $C7                             ; 50A8 C7                       .
L50A9:  bvc     $5030                           ; 50A9 50 85                    P.
        .byte   $04                             ; 50AB 04                       .
        lda     L50CB,y                         ; 50AC B9 CB 50                 ..P
        sta     $05                             ; 50AF 85 05                    ..
        lda     #$00                            ; 50B1 A9 00                    ..
        sta     $08                             ; 50B3 85 08                    ..
        jmp     StashRAM                        ; 50B5 4C C8 C2                 L..

; ----------------------------------------------------------------------------
L50B8:  lda     #$FF                            ; 50B8 A9 FF                    ..
        sta     $0A                             ; 50BA 85 0A                    ..
L50BC:  rts                                     ; 50BC 60                       `

; ----------------------------------------------------------------------------
L50BD:  brk                                     ; 50BD 00                       .
        .byte   $80                             ; 50BE 80                       .
        brk                                     ; 50BF 00                       .
        .byte   $80                             ; 50C0 80                       .
        brk                                     ; 50C1 00                       .
        brk                                     ; 50C2 00                       .
L50C3:  .byte   $B2                             ; 50C3 B2                       .
        ldx     $D8CC,y                         ; 50C4 BE CC D8                 ...
L50C7:  inc     $EE                             ; 50C7 E6 EE                    ..
L50C9:  .byte   $13                             ; 50C9 13                       .
        .byte   $14                             ; 50CA 14                       .
L50CB:  .byte   $23                             ; 50CB 23                       #
        bit     $33                             ; 50CC 24 33                    $3
        .byte   $34                             ; 50CE 34                       4
        brk                                     ; 50CF 00                       .
        .byte   $80                             ; 50D0 80                       .
        brk                                     ; 50D1 00                       .
        .byte   $80                             ; 50D2 80                       .
        .byte   $83                             ; 50D3 83                       .
        bcc     L5074                           ; 50D4 90 9E                    ..
        .byte   $AB                             ; 50D6 AB                       .
L50D7:  jsr     L9050                           ; 50D7 20 50 90                  P.
        lda     #$80                            ; 50DA A9 80                    ..
        .byte   $2C                             ; 50DC 2C                       ,
L50DD:  lda     #$00                            ; 50DD A9 00                    ..
        sta     L5134                           ; 50DF 8D 34 51                 .4Q
        jsr     L5161                           ; 50E2 20 61 51                  aQ
        beq     L50EA                           ; 50E5 F0 03                    ..
L50E7:  ldx     #$00                            ; 50E7 A2 00                    ..
        rts                                     ; 50E9 60                       `

; ----------------------------------------------------------------------------
L50EA:  jsr     L5149                           ; 50EA 20 49 51                  IQ
        ldx     #$00                            ; 50ED A2 00                    ..
        jsr     L580A                           ; 50EF 20 0A 58                  .X
        lda     $02                             ; 50F2 A5 02                    ..
        cmp     #$01                            ; 50F4 C9 01                    ..
        beq     L50E7                           ; 50F6 F0 EF                    ..
        cmp     #$05                            ; 50F8 C9 05                    ..
        bne     L512F                           ; 50FA D0 33                    .3
        lda     L518C                           ; 50FC AD 8C 51                 ..Q
        cmp     #$4E                            ; 50FF C9 4E                    .N
        beq     L510A                           ; 5101 F0 07                    ..
        cmp     #$38                            ; 5103 C9 38                    .8
        bne     L50EA                           ; 5105 D0 E3                    ..
        lda     #$04                            ; 5107 A9 04                    ..
        .byte   $2C                             ; 5109 2C                       ,
L510A:  lda     #$01                            ; 510A A9 01                    ..
        sta     $0A                             ; 510C 85 0A                    ..
        jsr     L502A                           ; 510E 20 2A 50                  *P
        jsr     L56F8                           ; 5111 20 F8 56                  .V
        bit     L5134                           ; 5114 2C 34 51                 ,4Q
        bpl     L5126                           ; 5117 10 0D                    ..
        jsr     L9050                           ; 5119 20 50 90                  P.
        txa                                     ; 511C 8A                       .
        bne     L5133                           ; 511D D0 14                    ..
        lda     #$00                            ; 511F A9 00                    ..
        sta     $06                             ; 5121 85 06                    ..
        jmp     L9066                           ; 5123 4C 66 90                 Lf.

; ----------------------------------------------------------------------------
L5126:  jsr     L9063                           ; 5126 20 63 90                  c.
        jsr     L9053                           ; 5129 20 53 90                  S.
L512C:  jmp     L57C5                           ; 512C 4C C5 57                 L.W

; ----------------------------------------------------------------------------
L512F:  cmp     #$32                            ; 512F C9 32                    .2
        beq     L512C                           ; 5131 F0 F9                    ..
L5133:  rts                                     ; 5133 60                       `

; ----------------------------------------------------------------------------
L5134:  brk                                     ; 5134 00                       .
L5135:  ldx     #$16                            ; 5135 A2 16                    ..
        .byte   $2C                             ; 5137 2C                       ,
L5138:  ldx     #$10                            ; 5138 A2 10                    ..
        lda     #$00                            ; 513A A9 00                    ..
        sta     L518C,x                         ; 513C 9D 8C 51                 ..Q
        dex                                     ; 513F CA                       .
        lda     #$20                            ; 5140 A9 20                    . 
L5142:  sta     L518C,x                         ; 5142 9D 8C 51                 ..Q
        dex                                     ; 5145 CA                       .
        bpl     L5142                           ; 5146 10 FA                    ..
        rts                                     ; 5148 60                       `

; ----------------------------------------------------------------------------
L5149:  jsr     L5174                           ; 5149 20 74 51                  tQ
        bne     L5153                           ; 514C D0 05                    ..
        bit     L5134                           ; 514E 2C 34 51                 ,4Q
        bpl     L5156                           ; 5151 10 03                    ..
L5153:  lda     #$00                            ; 5153 A9 00                    ..
        .byte   $2C                             ; 5155 2C                       ,
L5156:  lda     #$12                            ; 5156 A9 12                    ..
        sta     L51BE                           ; 5158 8D BE 51                 ..Q
        rts                                     ; 515B 60                       `

; ----------------------------------------------------------------------------
L515C:  jsr     L5174                           ; 515C 20 74 51                  tQ
        beq     L516E                           ; 515F F0 0D                    ..
L5161:  jsr     L517C                           ; 5161 20 7C 51                  |Q
        bcs     L516E                           ; 5164 B0 08                    ..
        and     #$F0                            ; 5166 29 F0                    ).
        beq     L5171                           ; 5168 F0 07                    ..
        cmp     #$40                            ; 516A C9 40                    .@
        bcs     L5171                           ; 516C B0 03                    ..
L516E:  lda     #$00                            ; 516E A9 00                    ..
        rts                                     ; 5170 60                       `

; ----------------------------------------------------------------------------
L5171:  lda     #$80                            ; 5171 A9 80                    ..
        rts                                     ; 5173 60                       `

; ----------------------------------------------------------------------------
L5174:  lda     $88C6                           ; 5174 AD C6 88                 ...
        and     #$0F                            ; 5177 29 0F                    ).
        cmp     #$04                            ; 5179 C9 04                    ..
        rts                                     ; 517B 60                       `

; ----------------------------------------------------------------------------
L517C:  lda     $88C6                           ; 517C AD C6 88                 ...
        cmp     #$83                            ; 517F C9 83                    ..
        bne     L518A                           ; 5181 D0 07                    ..
        bit     $9073                           ; 5183 2C 73 90                 ,s.
        bpl     L518A                           ; 5186 10 02                    ..
        sec                                     ; 5188 38                       8
        rts                                     ; 5189 60                       `

; ----------------------------------------------------------------------------
L518A:  clc                                     ; 518A 18                       .
        rts                                     ; 518B 60                       `

; ----------------------------------------------------------------------------
L518C:  brk                                     ; 518C 00                       .
        brk                                     ; 518D 00                       .
L518E:  brk                                     ; 518E 00                       .
        brk                                     ; 518F 00                       .
        brk                                     ; 5190 00                       .
        brk                                     ; 5191 00                       .
L5192:  brk                                     ; 5192 00                       .
        brk                                     ; 5193 00                       .
        brk                                     ; 5194 00                       .
        brk                                     ; 5195 00                       .
        brk                                     ; 5196 00                       .
        brk                                     ; 5197 00                       .
        brk                                     ; 5198 00                       .
        brk                                     ; 5199 00                       .
        brk                                     ; 519A 00                       .
        brk                                     ; 519B 00                       .
        brk                                     ; 519C 00                       .
        brk                                     ; 519D 00                       .
        brk                                     ; 519E 00                       .
        brk                                     ; 519F 00                       .
        brk                                     ; 51A0 00                       .
        brk                                     ; 51A1 00                       .
        brk                                     ; 51A2 00                       .
L51A3:  bit     $3D                             ; 51A3 24 3D                    $=
        bvc     L51B4                           ; 51A5 50 0D                    P.
        brk                                     ; 51A7 00                       .
L51A8:  brk                                     ; 51A8 00                       .
L51A9:  brk                                     ; 51A9 00                       .
L51AA:  brk                                     ; 51AA 00                       .
        brk                                     ; 51AB 00                       .
        jsr     L4097                           ; 51AC 20 97 40                  .@
        brk                                     ; 51AF 00                       .
        .byte   $FF                             ; 51B0 FF                       .
        brk                                     ; 51B1 00                       .
        .byte   $13                             ; 51B2 13                       .
        .byte   $3B                             ; 51B3 3B                       ;
L51B4:  .byte   $53                             ; 51B4 53                       S
        ora     $11                             ; 51B5 05 11                    ..
        sec                                     ; 51B7 38                       8
        ora     ($11,x)                         ; 51B8 01 11                    ..
        rts                                     ; 51BA 60                       `

; ----------------------------------------------------------------------------
        bpl     L51C3                           ; 51BB 10 06                    ..
        .byte   $1A                             ; 51BD 1A                       .
L51BE:  .byte   $12                             ; 51BE 12                       .
        ora     ($4C),y                         ; 51BF 11 4C                    .L
        cpy     $51                             ; 51C1 C4 51                    .Q
L51C3:  brk                                     ; 51C3 00                       .
        .byte   $0F                             ; 51C4 0F                       .
        .byte   $5A                             ; 51C5 5A                       Z
        brk                                     ; 51C6 00                       .
        brk                                     ; 51C7 00                       .
        asl     $10                             ; 51C8 06 10                    ..
        .byte   $14                             ; 51CA 14                       .
        .byte   $53                             ; 51CB 53                       S
L51CC:  lda     L51E7,x                         ; 51CC BD E7 51                 ..Q
        sta     L522B                           ; 51CF 8D 2B 52                 .+R
        lda     L51E9,x                         ; 51D2 BD E9 51                 ..Q
        sta     L522C                           ; 51D5 8D 2C 52                 .,R
        jsr     L51EB                           ; 51D8 20 EB 51                  .Q
        lda     $02                             ; 51DB A5 02                    ..
        cmp     #$01                            ; 51DD C9 01                    ..
        beq     L51E4                           ; 51DF F0 03                    ..
        ldx     #$0C                            ; 51E1 A2 0C                    ..
        rts                                     ; 51E3 60                       `

; ----------------------------------------------------------------------------
L51E4:  ldx     #$00                            ; 51E4 A2 00                    ..
        rts                                     ; 51E6 60                       `

; ----------------------------------------------------------------------------
L51E7:  .byte   $34                             ; 51E7 34                       4
        .byte   $49                             ; 51E8 49                       I
L51E9:  .byte   $52                             ; 51E9 52                       R
        .byte   $52                             ; 51EA 52                       R
L51EB:  jsr     L57B3                           ; 51EB 20 B3 57                  .W
        lda     $84B2                           ; 51EE AD B2 84                 ...
        sta     L521D                           ; 51F1 8D 1D 52                 ..R
        lda     $84B1                           ; 51F4 AD B1 84                 ...
        sta     L521C                           ; 51F7 8D 1C 52                 ..R
        lda     #$57                            ; 51FA A9 57                    .W
        sta     $84B2                           ; 51FC 8D B2 84                 ...
        lda     #$BC                            ; 51FF A9 BC                    ..
        sta     $84B1                           ; 5201 8D B1 84                 ...
        lda     #$52                            ; 5204 A9 52                    .R
        sta     $03                             ; 5206 85 03                    ..
        lda     #$1E                            ; 5208 A9 1E                    ..
        sta     $02                             ; 520A 85 02                    ..
        jsr     DoDlgBox                        ; 520C 20 56 C2                  V.
        lda     L521D                           ; 520F AD 1D 52                 ..R
        sta     $84B2                           ; 5212 8D B2 84                 ...
        lda     L521C                           ; 5215 AD 1C 52                 ..R
        sta     $84B1                           ; 5218 8D B1 84                 ...
        rts                                     ; 521B 60                       `

; ----------------------------------------------------------------------------
L521C:  brk                                     ; 521C 00                       .
L521D:  brk                                     ; 521D 00                       .
        brk                                     ; 521E 00                       .
        jsr     L406F                           ; 521F 20 6F 40                  o@
        brk                                     ; 5222 00                       .
        .byte   $FF                             ; 5223 FF                       .
        brk                                     ; 5224 00                       .
        .byte   $13                             ; 5225 13                       .
        .byte   $63                             ; 5226 63                       c
        .byte   $52                             ; 5227 52                       R
        .byte   $0B                             ; 5228 0B                       .
        bpl     L524B                           ; 5229 10 20                    . 
L522B:  .byte   $34                             ; 522B 34                       4
L522C:  .byte   $52                             ; 522C 52                       R
L522D:  ora     ($01,x)                         ; 522D 01 01                    ..
        sec                                     ; 522F 38                       8
        .byte   $02                             ; 5230 02                       .
        ora     ($38),y                         ; 5231 11 38                    .8
        brk                                     ; 5233 00                       .
        clc                                     ; 5234 18                       .
        eor     #$6E                            ; 5235 49 6E                    In
        .byte   $73                             ; 5237 73                       s
        adc     $72                             ; 5238 65 72                    er
        .byte   $74                             ; 523A 74                       t
        jsr     L6F73                           ; 523B 20 73 6F                  so
        adc     $72,x                           ; 523E 75 72                    ur
        .byte   $63                             ; 5240 63                       c
        adc     L0020                           ; 5241 65 20                    e 
        .byte   $64                             ; 5243 64                       d
        adc     #$73                            ; 5244 69 73                    is
        .byte   $6B                             ; 5246 6B                       k
        .byte   $1B                             ; 5247 1B                       .
        brk                                     ; 5248 00                       .
        clc                                     ; 5249 18                       .
        .byte   $49                             ; 524A 49                       I
L524B:  ror     $6573                           ; 524B 6E 73 65                 nse
        .byte   $72                             ; 524E 72                       r
        .byte   $74                             ; 524F 74                       t
        jsr     L6564                           ; 5250 20 64 65                  de
        .byte   $73                             ; 5253 73                       s
        .byte   $74                             ; 5254 74                       t
        adc     #$6E                            ; 5255 69 6E                    in
        adc     ($74,x)                         ; 5257 61 74                    at
        adc     #$6F                            ; 5259 69 6F                    io
        ror     $6420                           ; 525B 6E 20 64                 n d
        adc     #$73                            ; 525E 69 73                    is
        .byte   $6B                             ; 5260 6B                       k
        .byte   $1B                             ; 5261 1B                       .
        brk                                     ; 5262 00                       .
        lda     $9FE1                           ; 5263 AD E1 9F                 ...
        sta     L5270                           ; 5266 8D 70 52                 .pR
        jsr     LC316                           ; 5269 20 16 C3                  ..
        php                                     ; 526C 08                       .
        .byte   $04                             ; 526D 04                       .
        clc                                     ; 526E 18                       .
        asl     a                               ; 526F 0A                       .
L5270:  .byte   $B3                             ; 5270 B3                       .
        jsr     i_FrameRectangle                ; 5271 20 A2 C1                  ..
        .byte   $22                             ; 5274 22                       "
        ror     a:$42                           ; 5275 6E 42 00                 nB.
        inc     $FF00,x                         ; 5278 FE 00 FF                 ...
        rts                                     ; 527B 60                       `

; ----------------------------------------------------------------------------
L527C:  jsr     ExitTurbo                       ; 527C 20 32 C2                  2.
        jsr     InitForIO                       ; 527F 20 5C C2                  \.
        lda     #$08                            ; 5282 A9 08                    ..
        sta     L52E3                           ; 5284 8D E3 52                 ..R
L5287:  jsr     L52EA                           ; 5287 20 EA 52                  .R
        bmi     L52C3                           ; 528A 30 37                    07
        ldy     #$00                            ; 528C A0 00                    ..
L528E:  lda     L52E4,y                         ; 528E B9 E4 52                 ..R
        jsr     LFFA8                           ; 5291 20 A8 FF                  ..
        iny                                     ; 5294 C8                       .
        cpy     #$06                            ; 5295 C0 06                    ..
        bcc     L528E                           ; 5297 90 F5                    ..
        lda     #$0D                            ; 5299 A9 0D                    ..
        jsr     LFFA8                           ; 529B 20 A8 FF                  ..
        jsr     LFFAE                           ; 529E 20 AE FF                  ..
        lda     L52E3                           ; 52A1 AD E3 52                 ..R
        jsr     L52FF                           ; 52A4 20 FF 52                  .R
        bmi     L52C3                           ; 52A7 30 1A                    0.
        jsr     LFFA5                           ; 52A9 20 A5 FF                  ..
        pha                                     ; 52AC 48                       H
        jsr     LFFA5                           ; 52AD 20 A5 FF                  ..
        pha                                     ; 52B0 48                       H
        jsr     LFFAB                           ; 52B1 20 AB FF                  ..
        pla                                     ; 52B4 68                       h
        tax                                     ; 52B5 AA                       .
        pla                                     ; 52B6 68                       h
        cmp     #$52                            ; 52B7 C9 52                    .R
        bne     L52C3                           ; 52B9 D0 08                    ..
        cpx     #$4C                            ; 52BB E0 4C                    .L
        beq     L52DC                           ; 52BD F0 1D                    ..
        cpx     #$44                            ; 52BF E0 44                    .D
        beq     L52DC                           ; 52C1 F0 19                    ..
L52C3:  jsr     LFFAE                           ; 52C3 20 AE FF                  ..
        jsr     LFFAB                           ; 52C6 20 AB FF                  ..
L52C9:  inc     L52E3                           ; 52C9 EE E3 52                 ..R
        lda     L52E3                           ; 52CC AD E3 52                 ..R
        cmp     #$0E                            ; 52CF C9 0E                    ..
        beq     L52C9                           ; 52D1 F0 F6                    ..
        cmp     #$1F                            ; 52D3 C9 1F                    ..
        bcc     L5287                           ; 52D5 90 B0                    ..
        lda     #$00                            ; 52D7 A9 00                    ..
        sta     L52E3                           ; 52D9 8D E3 52                 ..R
L52DC:  jsr     DoneWithIO                      ; 52DC 20 5F C2                  _.
        ldx     L52E3                           ; 52DF AE E3 52                 ..R
        rts                                     ; 52E2 60                       `

; ----------------------------------------------------------------------------
L52E3:  brk                                     ; 52E3 00                       .
L52E4:  eor     L522D                           ; 52E4 4D 2D 52                 M-R
        ldy     $FE                             ; 52E7 A4 FE                    ..
        .byte   $02                             ; 52E9 02                       .
L52EA:  pha                                     ; 52EA 48                       H
        lda     #$00                            ; 52EB A9 00                    ..
        sta     $90                             ; 52ED 85 90                    ..
        pla                                     ; 52EF 68                       h
        jsr     LFFB1                           ; 52F0 20 B1 FF                  ..
        bit     $90                             ; 52F3 24 90                    $.
        bmi     L52FE                           ; 52F5 30 07                    0.
        lda     #$6F                            ; 52F7 A9 6F                    .o
        jsr     LFF93                           ; 52F9 20 93 FF                  ..
        bit     $90                             ; 52FC 24 90                    $.
L52FE:  rts                                     ; 52FE 60                       `

; ----------------------------------------------------------------------------
L52FF:  pha                                     ; 52FF 48                       H
        lda     #$00                            ; 5300 A9 00                    ..
        sta     $90                             ; 5302 85 90                    ..
        pla                                     ; 5304 68                       h
        jsr     LFFB4                           ; 5305 20 B4 FF                  ..
        bit     $90                             ; 5308 24 90                    $.
        bmi     L5313                           ; 530A 30 07                    0.
        lda     #$6F                            ; 530C A9 6F                    .o
        jsr     LFF96                           ; 530E 20 96 FF                  ..
        bit     $90                             ; 5311 24 90                    $.
L5313:  rts                                     ; 5313 60                       `

; ----------------------------------------------------------------------------
        lda     #$32                            ; 5314 A9 32                    .2
        .byte   $2C                             ; 5316 2C                       ,
L5317:  lda     #$50                            ; 5317 A9 50                    .P
        bit     L55A9                           ; 5319 2C A9 55                 ,.U
        sta     $851D                           ; 531C 8D 1D 85                 ...
        jmp     RstrFrmDialogue                 ; 531F 4C BF C2                 L..

; ----------------------------------------------------------------------------
L5322:  lda     $9FE1                           ; 5322 AD E1 9F                 ...
        sta     L532F                           ; 5325 8D 2F 53                 ./S
        jsr     LC316                           ; 5328 20 16 C3                  ..
        php                                     ; 532B 08                       .
        .byte   $04                             ; 532C 04                       .
        clc                                     ; 532D 18                       .
        .byte   $0F                             ; 532E 0F                       .
L532F:  .byte   $B3                             ; 532F B3                       .
        jsr     i_FrameRectangle                ; 5330 20 A2 C1                  ..
        .byte   $22                             ; 5333 22                       "
        stx     $42,y                           ; 5334 96 42                    .B
        brk                                     ; 5336 00                       .
        inc     $FF00,x                         ; 5337 FE 00 FF                 ...
        rts                                     ; 533A 60                       `

; ----------------------------------------------------------------------------
        jsr     L5322                           ; 533B 20 22 53                  "S
        jsr     OpenDisk                        ; 533E 20 A1 C2                  ..
        lda     $8489                           ; 5341 AD 89 84                 ...
        clc                                     ; 5344 18                       .
        adc     #$39                            ; 5345 69 39                    i9
        sta     L53C8                           ; 5347 8D C8 53                 ..S
        lda     #$53                            ; 534A A9 53                    .S
        sta     $05                             ; 534C 85 05                    ..
        lda     #$CB                            ; 534E A9 CB                    ..
        sta     $04                             ; 5350 85 04                    ..
        jsr     L53F4                           ; 5352 20 F4 53                  .S
        jsr     L5161                           ; 5355 20 61 51                  aQ
        bne     L5393                           ; 5358 D0 39                    .9
        lda     #$53                            ; 535A A9 53                    .S
        sta     $05                             ; 535C 85 05                    ..
        lda     #$B3                            ; 535E A9 B3                    ..
        sta     $04                             ; 5360 85 04                    ..
        jsr     L53DC                           ; 5362 20 DC 53                  .S
        lda     #$53                            ; 5365 A9 53                    .S
        sta     $05                             ; 5367 85 05                    ..
        lda     #$AF                            ; 5369 A9 AF                    ..
        sta     $04                             ; 536B 85 04                    ..
        ldy     #$03                            ; 536D A0 03                    ..
        lda     #$20                            ; 536F A9 20                    . 
L5371:  sta     ($04),y                         ; 5371 91 04                    ..
        dey                                     ; 5373 88                       .
        bpl     L5371                           ; 5374 10 FB                    ..
        lda     L54BA                           ; 5376 AD BA 54                 ..T
        jsr     L55AA                           ; 5379 20 AA 55                  .U
        lda     #$2D                            ; 537C A9 2D                    .-
        sta     $05                             ; 537E 85 05                    ..
        lda     #$00                            ; 5380 A9 00                    ..
        sta     $19                             ; 5382 85 19                    ..
        lda     #$46                            ; 5384 A9 46                    .F
        sta     $18                             ; 5386 85 18                    ..
        lda     #$53                            ; 5388 A9 53                    .S
        sta     $03                             ; 538A 85 03                    ..
        lda     #$AA                            ; 538C A9 AA                    ..
        sta     $02                             ; 538E 85 02                    ..
        jsr     PutString                       ; 5390 20 48 C1                  H.
L5393:  lda     #$37                            ; 5393 A9 37                    .7
        sta     $05                             ; 5395 85 05                    ..
        lda     #$00                            ; 5397 A9 00                    ..
        sta     $19                             ; 5399 85 19                    ..
        lda     #$46                            ; 539B A9 46                    .F
        sta     $18                             ; 539D 85 18                    ..
        lda     #$53                            ; 539F A9 53                    .S
        sta     $03                             ; 53A1 85 03                    ..
        lda     #$C4                            ; 53A3 A9 C4                    ..
        sta     $02                             ; 53A5 85 02                    ..
        jmp     PutString                       ; 53A7 4C 48 C1                 LH.

; ----------------------------------------------------------------------------
        bvc     L53ED                           ; 53AA 50 41                    PA
        .byte   $52                             ; 53AC 52                       R
        .byte   $54                             ; 53AD 54                       T
        jsr     L2020                           ; 53AE 20 20 20                    
        jsr     L0020                           ; 53B1 20 20 00                   .
        brk                                     ; 53B4 00                       .
        brk                                     ; 53B5 00                       .
        brk                                     ; 53B6 00                       .
        brk                                     ; 53B7 00                       .
        brk                                     ; 53B8 00                       .
        brk                                     ; 53B9 00                       .
        brk                                     ; 53BA 00                       .
        brk                                     ; 53BB 00                       .
        brk                                     ; 53BC 00                       .
        brk                                     ; 53BD 00                       .
        brk                                     ; 53BE 00                       .
        brk                                     ; 53BF 00                       .
        brk                                     ; 53C0 00                       .
        brk                                     ; 53C1 00                       .
        brk                                     ; 53C2 00                       .
        brk                                     ; 53C3 00                       .
        .byte   $44                             ; 53C4 44                       D
        .byte   $52                             ; 53C5 52                       R
        lsr     L0020,x                         ; 53C6 56 20                    V 
L53C8:  eor     ($3A,x)                         ; 53C8 41 3A                    A:
        jsr     L0000                           ; 53CA 20 00 00                  ..
        brk                                     ; 53CD 00                       .
        brk                                     ; 53CE 00                       .
        brk                                     ; 53CF 00                       .
        brk                                     ; 53D0 00                       .
        brk                                     ; 53D1 00                       .
        brk                                     ; 53D2 00                       .
        brk                                     ; 53D3 00                       .
        brk                                     ; 53D4 00                       .
        brk                                     ; 53D5 00                       .
        brk                                     ; 53D6 00                       .
        brk                                     ; 53D7 00                       .
        brk                                     ; 53D8 00                       .
        brk                                     ; 53D9 00                       .
        brk                                     ; 53DA 00                       .
        brk                                     ; 53DB 00                       .
L53DC:  ldx     #$FF                            ; 53DC A2 FF                    ..
        jsr     L5417                           ; 53DE 20 17 54                  .T
        lda     #$54                            ; 53E1 A9 54                    .T
        sta     $03                             ; 53E3 85 03                    ..
        lda     #$BB                            ; 53E5 A9 BB                    ..
        sta     $02                             ; 53E7 85 02                    ..
        lda     #$53                            ; 53E9 A9 53                    .S
        sta     $05                             ; 53EB 85 05                    ..
L53ED:  lda     #$B3                            ; 53ED A9 B3                    ..
        sta     $04                             ; 53EF 85 04                    ..
        jmp     L53F9                           ; 53F1 4C F9 53                 L.S

; ----------------------------------------------------------------------------
L53F4:  ldx     #$02                            ; 53F4 A2 02                    ..
        jsr     GetPtrCurDkNm                   ; 53F6 20 98 C2                  ..
L53F9:  ldy     #$00                            ; 53F9 A0 00                    ..
L53FB:  lda     ($02),y                         ; 53FB B1 02                    ..
        beq     L5412                           ; 53FD F0 13                    ..
        cmp     #$A0                            ; 53FF C9 A0                    ..
        beq     L5412                           ; 5401 F0 0F                    ..
        and     #$7F                            ; 5403 29 7F                    ).
        cmp     #$20                            ; 5405 C9 20                    . 
        bcs     L540B                           ; 5407 B0 02                    ..
        lda     #$3F                            ; 5409 A9 3F                    .?
L540B:  sta     ($04),y                         ; 540B 91 04                    ..
        iny                                     ; 540D C8                       .
        cpy     #$10                            ; 540E C0 10                    ..
        bcc     L53FB                           ; 5410 90 E9                    ..
L5412:  lda     #$00                            ; 5412 A9 00                    ..
        sta     ($04),y                         ; 5414 91 04                    ..
        rts                                     ; 5416 60                       `

; ----------------------------------------------------------------------------
L5417:  stx     L5463                           ; 5417 8E 63 54                 .cT
        lda     $8489                           ; 541A AD 89 84                 ...
        sta     L545F                           ; 541D 8D 5F 54                 ._T
        jsr     L517C                           ; 5420 20 7C 51                  |Q
        bcc     L542B                           ; 5423 90 06                    ..
        jsr     L527C                           ; 5425 20 7C 52                  |R
        stx     L545F                           ; 5428 8E 5F 54                 ._T
L542B:  jsr     PurgeTurbo                      ; 542B 20 35 C2                  5.
        jsr     InitForIO                       ; 542E 20 5C C2                  \.
        lda     #$54                            ; 5431 A9 54                    .T
        sta     $03                             ; 5433 85 03                    ..
        lda     #$60                            ; 5435 A9 60                    .`
        sta     $02                             ; 5437 85 02                    ..
        ldy     #$04                            ; 5439 A0 04                    ..
        lda     L545F                           ; 543B AD 5F 54                 ._T
        jsr     L5491                           ; 543E 20 91 54                  .T
        bne     L5454                           ; 5441 D0 11                    ..
        lda     L545F                           ; 5443 AD 5F 54                 ._T
        jsr     L5464                           ; 5446 20 64 54                  dT
        bne     L5454                           ; 5449 D0 09                    ..
        jsr     DoneWithIO                      ; 544B 20 5F C2                  _.
        jsr     EnterTurbo                      ; 544E 20 14 C2                  ..
        ldx     #$00                            ; 5451 A2 00                    ..
        rts                                     ; 5453 60                       `

; ----------------------------------------------------------------------------
L5454:  txa                                     ; 5454 8A                       .
        pha                                     ; 5455 48                       H
        jsr     DoneWithIO                      ; 5456 20 5F C2                  _.
        jsr     EnterTurbo                      ; 5459 20 14 C2                  ..
        pla                                     ; 545C 68                       h
        tax                                     ; 545D AA                       .
        rts                                     ; 545E 60                       `

; ----------------------------------------------------------------------------
L545F:  brk                                     ; 545F 00                       .
        .byte   $47                             ; 5460 47                       G
        .byte   $2D                             ; 5461 2D                       -
        .byte   $50                             ; 5462 50                       P
L5463:  .byte   $FF                             ; 5463 FF                       .
L5464:  jsr     L52FF                           ; 5464 20 FF 52                  .R
        bmi     L5483                           ; 5467 30 1A                    0.
        ldy     #$00                            ; 5469 A0 00                    ..
L546B:  jsr     LFFA5                           ; 546B 20 A5 FF                  ..
        ldx     $90                             ; 546E A6 90                    ..
        bne     L547D                           ; 5470 D0 0B                    ..
        sta     L54B8,y                         ; 5472 99 B8 54                 ..T
        iny                                     ; 5475 C8                       .
        cpy     #$20                            ; 5476 C0 20                    . 
        bcc     L546B                           ; 5478 90 F1                    ..
        jsr     L5489                           ; 547A 20 89 54                  .T
L547D:  jsr     LFFAB                           ; 547D 20 AB FF                  ..
        ldx     #$00                            ; 5480 A2 00                    ..
        rts                                     ; 5482 60                       `

; ----------------------------------------------------------------------------
L5483:  jsr     LFFAB                           ; 5483 20 AB FF                  ..
        ldx     #$0D                            ; 5486 A2 0D                    ..
        rts                                     ; 5488 60                       `

; ----------------------------------------------------------------------------
L5489:  jsr     LFFA5                           ; 5489 20 A5 FF                  ..
        ldx     $90                             ; 548C A6 90                    ..
        beq     L5489                           ; 548E F0 F9                    ..
        rts                                     ; 5490 60                       `

; ----------------------------------------------------------------------------
L5491:  sty     L54B7                           ; 5491 8C B7 54                 ..T
        jsr     L52EA                           ; 5494 20 EA 52                  .R
        bmi     L54B1                           ; 5497 30 18                    0.
        ldy     #$00                            ; 5499 A0 00                    ..
L549B:  lda     ($02),y                         ; 549B B1 02                    ..
        jsr     LFFA8                           ; 549D 20 A8 FF                  ..
        iny                                     ; 54A0 C8                       .
        cpy     L54B7                           ; 54A1 CC B7 54                 ..T
        bcc     L549B                           ; 54A4 90 F5                    ..
        lda     #$0D                            ; 54A6 A9 0D                    ..
        jsr     LFFA8                           ; 54A8 20 A8 FF                  ..
        jsr     LFFAE                           ; 54AB 20 AE FF                  ..
        ldx     #$00                            ; 54AE A2 00                    ..
        rts                                     ; 54B0 60                       `

; ----------------------------------------------------------------------------
L54B1:  jsr     LFFAE                           ; 54B1 20 AE FF                  ..
        ldx     #$0D                            ; 54B4 A2 0D                    ..
        rts                                     ; 54B6 60                       `

; ----------------------------------------------------------------------------
L54B7:  brk                                     ; 54B7 00                       .
L54B8:  brk                                     ; 54B8 00                       .
        brk                                     ; 54B9 00                       .
L54BA:  brk                                     ; 54BA 00                       .
        brk                                     ; 54BB 00                       .
        brk                                     ; 54BC 00                       .
        brk                                     ; 54BD 00                       .
        brk                                     ; 54BE 00                       .
        brk                                     ; 54BF 00                       .
        brk                                     ; 54C0 00                       .
        brk                                     ; 54C1 00                       .
        brk                                     ; 54C2 00                       .
        brk                                     ; 54C3 00                       .
        brk                                     ; 54C4 00                       .
        brk                                     ; 54C5 00                       .
        brk                                     ; 54C6 00                       .
        brk                                     ; 54C7 00                       .
        brk                                     ; 54C8 00                       .
        brk                                     ; 54C9 00                       .
        brk                                     ; 54CA 00                       .
        brk                                     ; 54CB 00                       .
        brk                                     ; 54CC 00                       .
        brk                                     ; 54CD 00                       .
        brk                                     ; 54CE 00                       .
        brk                                     ; 54CF 00                       .
        brk                                     ; 54D0 00                       .
        brk                                     ; 54D1 00                       .
        brk                                     ; 54D2 00                       .
        brk                                     ; 54D3 00                       .
        brk                                     ; 54D4 00                       .
        brk                                     ; 54D5 00                       .
        brk                                     ; 54D6 00                       .
        brk                                     ; 54D7 00                       .
        jsr     InitForIO                       ; 54D8 20 5C C2                  \.
        jsr     L5690                           ; 54DB 20 90 56                  .V
        bcs     L551B                           ; 54DE B0 3B                    .;
        bcc     L5539                           ; 54E0 90 57                    .W
        lda     #$00                            ; 54E2 A9 00                    ..
        sta     L5552                           ; 54E4 8D 52 55                 .RU
        lda     $8489                           ; 54E7 AD 89 84                 ...
        sta     L5553                           ; 54EA 8D 53 55                 .SU
        jsr     L517C                           ; 54ED 20 7C 51                  |Q
        bcc     L54FD                           ; 54F0 90 0B                    ..
        jsr     L527C                           ; 54F2 20 7C 52                  |R
        stx     L5553                           ; 54F5 8E 53 55                 .SU
        lda     #$80                            ; 54F8 A9 80                    ..
        sta     L5552                           ; 54FA 8D 52 55                 .RU
L54FD:  jsr     L5135                           ; 54FD 20 35 51                  5Q
        lda     $8489                           ; 5500 AD 89 84                 ...
        jsr     SetDevice                       ; 5503 20 B0 C2                  ..
        jsr     PurgeTurbo                      ; 5506 20 35 C2                  5.
        jsr     InitForIO                       ; 5509 20 5C C2                  \.
        jsr     L5662                           ; 550C 20 62 56                  bV
        bcc     L5539                           ; 550F 90 28                    .(
        jsr     L5690                           ; 5511 20 90 56                  .V
        bcc     L5539                           ; 5514 90 23                    .#
        jsr     L5561                           ; 5516 20 61 55                  aU
        bne     L5539                           ; 5519 D0 1E                    ..
L551B:  jsr     L5135                           ; 551B 20 35 51                  5Q
        jsr     L5584                           ; 551E 20 84 55                  .U
        lda     L518C                           ; 5521 AD 8C 51                 ..Q
        beq     L5539                           ; 5524 F0 13                    ..
        jsr     LFFAB                           ; 5526 20 AB FF                  ..
        jsr     DoneWithIO                      ; 5529 20 5F C2                  _.
        jsr     L5554                           ; 552C 20 54 55                  TU
        lda     #$54                            ; 552F A9 54                    .T
        sta     $0D                             ; 5531 85 0D                    ..
        lda     #$D8                            ; 5533 A9 D8                    ..
        sta     $0C                             ; 5535 85 0C                    ..
        clc                                     ; 5537 18                       .
        rts                                     ; 5538 60                       `

; ----------------------------------------------------------------------------
L5539:  jsr     LFFAE                           ; 5539 20 AE FF                  ..
        jsr     LFFAB                           ; 553C 20 AB FF                  ..
        jsr     L56A9                           ; 553F 20 A9 56                  .V
        jsr     DoneWithIO                      ; 5542 20 5F C2                  _.
        jsr     EnterTurbo                      ; 5545 20 14 C2                  ..
        lda     #$51                            ; 5548 A9 51                    .Q
        sta     $0D                             ; 554A 85 0D                    ..
        lda     #$8C                            ; 554C A9 8C                    ..
        sta     $0C                             ; 554E 85 0C                    ..
        sec                                     ; 5550 38                       8
        rts                                     ; 5551 60                       `

; ----------------------------------------------------------------------------
L5552:  brk                                     ; 5552 00                       .
L5553:  brk                                     ; 5553 00                       .
L5554:  ldy     #$00                            ; 5554 A0 00                    ..
L5556:  lda     L518C,y                         ; 5556 B9 8C 51                 ..Q
        sta     ($0E),y                         ; 5559 91 0E                    ..
        beq     L5560                           ; 555B F0 03                    ..
        iny                                     ; 555D C8                       .
        bne     L5556                           ; 555E D0 F6                    ..
L5560:  rts                                     ; 5560 60                       `

; ----------------------------------------------------------------------------
L5561:  jsr     L5576                           ; 5561 20 76 55                  vU
        jsr     L5576                           ; 5564 20 76 55                  vU
        jsr     L5576                           ; 5567 20 76 55                  vU
L556A:  jsr     LFFA5                           ; 556A 20 A5 FF                  ..
        ldx     $90                             ; 556D A6 90                    ..
        bne     L5575                           ; 556F D0 04                    ..
        cmp     #$00                            ; 5571 C9 00                    ..
        bne     L556A                           ; 5573 D0 F5                    ..
L5575:  rts                                     ; 5575 60                       `

; ----------------------------------------------------------------------------
L5576:  jsr     LFFA5                           ; 5576 20 A5 FF                  ..
        sta     L5583                           ; 5579 8D 83 55                 ..U
        jsr     LFFA5                           ; 557C 20 A5 FF                  ..
        ora     L5583                           ; 557F 0D 83 55                 ..U
        rts                                     ; 5582 60                       `

; ----------------------------------------------------------------------------
L5583:  brk                                     ; 5583 00                       .
L5584:  jsr     L55E2                           ; 5584 20 E2 55                  .U
        lda     L51AA                           ; 5587 AD AA 51                 ..Q
        beq     L55A4                           ; 558A F0 18                    ..
        bmi     L5584                           ; 558C 30 F6                    0.
        sta     L518C                           ; 558E 8D 8C 51                 ..Q
        lda     L51A9                           ; 5591 AD A9 51                 ..Q
        bne     L5584                           ; 5594 D0 EE                    ..
        lda     #$51                            ; 5596 A9 51                    .Q
        sta     $05                             ; 5598 85 05                    ..
        lda     #$8E                            ; 559A A9 8E                    ..
        sta     $04                             ; 559C 85 04                    ..
        lda     L51A8                           ; 559E AD A8 51                 ..Q
        jmp     L55AA                           ; 55A1 4C AA 55                 L.U

; ----------------------------------------------------------------------------
L55A4:  lda     #$00                            ; 55A4 A9 00                    ..
        sta     L518C                           ; 55A6 8D 8C 51                 ..Q
L55A9:  rts                                     ; 55A9 60                       `

; ----------------------------------------------------------------------------
L55AA:  ldx     #$30                            ; 55AA A2 30                    .0
        ldy     #$00                            ; 55AC A0 00                    ..
L55AE:  cmp     #$64                            ; 55AE C9 64                    .d
        bcc     L55B8                           ; 55B0 90 06                    ..
        sec                                     ; 55B2 38                       8
        sbc     #$64                            ; 55B3 E9 64                    .d
        inx                                     ; 55B5 E8                       .
        bne     L55AE                           ; 55B6 D0 F6                    ..
L55B8:  cpx     #$30                            ; 55B8 E0 30                    .0
        beq     L55C4                           ; 55BA F0 08                    ..
        pha                                     ; 55BC 48                       H
        txa                                     ; 55BD 8A                       .
        sta     ($04),y                         ; 55BE 91 04                    ..
        pla                                     ; 55C0 68                       h
        iny                                     ; 55C1 C8                       .
        ldx     #$30                            ; 55C2 A2 30                    .0
L55C4:  cmp     #$0A                            ; 55C4 C9 0A                    ..
        bcc     L55CE                           ; 55C6 90 06                    ..
        sec                                     ; 55C8 38                       8
        sbc     #$0A                            ; 55C9 E9 0A                    ..
        inx                                     ; 55CB E8                       .
        bne     L55C4                           ; 55CC D0 F6                    ..
L55CE:  cpx     #$30                            ; 55CE E0 30                    .0
        bne     L55D6                           ; 55D0 D0 04                    ..
        cpy     #$00                            ; 55D2 C0 00                    ..
        beq     L55DC                           ; 55D4 F0 06                    ..
L55D6:  pha                                     ; 55D6 48                       H
        txa                                     ; 55D7 8A                       .
        sta     ($04),y                         ; 55D8 91 04                    ..
        pla                                     ; 55DA 68                       h
        iny                                     ; 55DB C8                       .
L55DC:  clc                                     ; 55DC 18                       .
        adc     #$30                            ; 55DD 69 30                    i0
        sta     ($04),y                         ; 55DF 91 04                    ..
        rts                                     ; 55E1 60                       `

; ----------------------------------------------------------------------------
L55E2:  jsr     L5576                           ; 55E2 20 76 55                  vU
        beq     L565C                           ; 55E5 F0 75                    .u
        jsr     LFFA5                           ; 55E7 20 A5 FF                  ..
        sta     L51A8                           ; 55EA 8D A8 51                 ..Q
        ldx     $90                             ; 55ED A6 90                    ..
        bne     L565C                           ; 55EF D0 6B                    .k
        jsr     LFFA5                           ; 55F1 20 A5 FF                  ..
        sta     L51A9                           ; 55F4 8D A9 51                 ..Q
        ldx     $90                             ; 55F7 A6 90                    ..
        bne     L565C                           ; 55F9 D0 61                    .a
L55FB:  jsr     LFFA5                           ; 55FB 20 A5 FF                  ..
        ldx     $90                             ; 55FE A6 90                    ..
        bne     L565C                           ; 5600 D0 5A                    .Z
        cmp     #$00                            ; 5602 C9 00                    ..
        beq     L565C                           ; 5604 F0 56                    .V
        cmp     #$22                            ; 5606 C9 22                    ."
        bne     L55FB                           ; 5608 D0 F1                    ..
        ldy     #$00                            ; 560A A0 00                    ..
L560C:  jsr     LFFA5                           ; 560C 20 A5 FF                  ..
        ldx     $90                             ; 560F A6 90                    ..
        bne     L565C                           ; 5611 D0 49                    .I
        cmp     #$22                            ; 5613 C9 22                    ."
        beq     L561F                           ; 5615 F0 08                    ..
        sta     L5192,y                         ; 5617 99 92 51                 ..Q
        iny                                     ; 561A C8                       .
        cpy     #$10                            ; 561B C0 10                    ..
        bcc     L560C                           ; 561D 90 ED                    ..
L561F:  lda     #$00                            ; 561F A9 00                    ..
        sta     L5192,y                         ; 5621 99 92 51                 ..Q
L5624:  jsr     LFFA5                           ; 5624 20 A5 FF                  ..
        ldx     $90                             ; 5627 A6 90                    ..
        bne     L565C                           ; 5629 D0 31                    .1
        cmp     #$00                            ; 562B C9 00                    ..
        beq     L564D                           ; 562D F0 1E                    ..
        cmp     #$22                            ; 562F C9 22                    ."
        beq     L5624                           ; 5631 F0 F1                    ..
        cmp     #$20                            ; 5633 C9 20                    . 
        beq     L5624                           ; 5635 F0 ED                    ..
        cmp     #$A0                            ; 5637 C9 A0                    ..
        beq     L5624                           ; 5639 F0 E9                    ..
        bit     L5552                           ; 563B 2C 52 55                 ,RU
        bmi     L5644                           ; 563E 30 04                    0.
        cmp     #$4E                            ; 5640 C9 4E                    .N
        beq     L5653                           ; 5642 F0 0F                    ..
L5644:  cmp     #$38                            ; 5644 C9 38                    .8
        beq     L5653                           ; 5646 F0 0B                    ..
        jsr     L556A                           ; 5648 20 6A 55                  jU
        bne     L565C                           ; 564B D0 0F                    ..
L564D:  lda     #$FF                            ; 564D A9 FF                    ..
        sta     L51AA                           ; 564F 8D AA 51                 ..Q
        rts                                     ; 5652 60                       `

; ----------------------------------------------------------------------------
L5653:  sta     L51AA                           ; 5653 8D AA 51                 ..Q
        jsr     L556A                           ; 5656 20 6A 55                  jU
        bne     L565C                           ; 5659 D0 01                    ..
        rts                                     ; 565B 60                       `

; ----------------------------------------------------------------------------
L565C:  lda     #$00                            ; 565C A9 00                    ..
        sta     L51AA                           ; 565E 8D AA 51                 ..Q
        rts                                     ; 5661 60                       `

; ----------------------------------------------------------------------------
L5662:  lda     #$00                            ; 5662 A9 00                    ..
        sta     $90                             ; 5664 85 90                    ..
        lda     L5553                           ; 5666 AD 53 55                 .SU
        jsr     LFFB1                           ; 5669 20 B1 FF                  ..
        lda     $90                             ; 566C A5 90                    ..
        bne     L568B                           ; 566E D0 1B                    ..
        lda     #$F0                            ; 5670 A9 F0                    ..
        jsr     LFF93                           ; 5672 20 93 FF                  ..
        lda     $90                             ; 5675 A5 90                    ..
        bne     L568B                           ; 5677 D0 12                    ..
        ldy     #$00                            ; 5679 A0 00                    ..
L567B:  lda     L51A3,y                         ; 567B B9 A3 51                 ..Q
        beq     L5686                           ; 567E F0 06                    ..
        jsr     LFFA8                           ; 5680 20 A8 FF                  ..
        iny                                     ; 5683 C8                       .
        bne     L567B                           ; 5684 D0 F5                    ..
L5686:  jsr     LFFAE                           ; 5686 20 AE FF                  ..
        sec                                     ; 5689 38                       8
        rts                                     ; 568A 60                       `

; ----------------------------------------------------------------------------
L568B:  jsr     LFFAE                           ; 568B 20 AE FF                  ..
        clc                                     ; 568E 18                       .
        rts                                     ; 568F 60                       `

; ----------------------------------------------------------------------------
L5690:  lda     #$00                            ; 5690 A9 00                    ..
        sta     $90                             ; 5692 85 90                    ..
        lda     L5553                           ; 5694 AD 53 55                 .SU
        jsr     LFFB4                           ; 5697 20 B4 FF                  ..
        lda     $90                             ; 569A A5 90                    ..
        bne     L56A9                           ; 569C D0 0B                    ..
        lda     #$60                            ; 569E A9 60                    .`
        jsr     LFF96                           ; 56A0 20 96 FF                  ..
        lda     $90                             ; 56A3 A5 90                    ..
        bne     L56A9                           ; 56A5 D0 02                    ..
        sec                                     ; 56A7 38                       8
        rts                                     ; 56A8 60                       `

; ----------------------------------------------------------------------------
L56A9:  jsr     LFFAE                           ; 56A9 20 AE FF                  ..
        jsr     LFFAB                           ; 56AC 20 AB FF                  ..
        lda     #$00                            ; 56AF A9 00                    ..
        sta     $90                             ; 56B1 85 90                    ..
        lda     L5553                           ; 56B3 AD 53 55                 .SU
        jsr     LFFB1                           ; 56B6 20 B1 FF                  ..
        lda     #$E0                            ; 56B9 A9 E0                    ..
        jsr     LFF93                           ; 56BB 20 93 FF                  ..
        jsr     LFFAE                           ; 56BE 20 AE FF                  ..
        clc                                     ; 56C1 18                       .
        rts                                     ; 56C2 60                       `

; ----------------------------------------------------------------------------
L56C3:  stx     L56F7                           ; 56C3 8E F7 56                 ..V
        jsr     L5161                           ; 56C6 20 61 51                  aQ
        bne     L56F1                           ; 56C9 D0 26                    .&
        ldx     L56F7                           ; 56CB AE F7 56                 ..V
        jsr     L5417                           ; 56CE 20 17 54                  .T
        lda     L54B8                           ; 56D1 AD B8 54                 ..T
        sta     $0A                             ; 56D4 85 0A                    ..
        jsr     L502A                           ; 56D6 20 2A 50                  *P
        lda     $0A                             ; 56D9 A5 0A                    ..
        bmi     L56F4                           ; 56DB 30 17                    0.
        jsr     L5135                           ; 56DD 20 35 51                  5Q
        lda     #$51                            ; 56E0 A9 51                    .Q
        sta     $05                             ; 56E2 85 05                    ..
        lda     #$8E                            ; 56E4 A9 8E                    ..
        sta     $04                             ; 56E6 85 04                    ..
        lda     L56F7                           ; 56E8 AD F7 56                 ..V
        jsr     L55AA                           ; 56EB 20 AA 55                  .U
        jsr     L56F8                           ; 56EE 20 F8 56                  .V
L56F1:  ldx     #$00                            ; 56F1 A2 00                    ..
        rts                                     ; 56F3 60                       `

; ----------------------------------------------------------------------------
L56F4:  ldx     #$0D                            ; 56F4 A2 0D                    ..
        rts                                     ; 56F6 60                       `

; ----------------------------------------------------------------------------
L56F7:  brk                                     ; 56F7 00                       .
L56F8:  lda     $8489                           ; 56F8 AD 89 84                 ...
        sta     L573E                           ; 56FB 8D 3E 57                 .>W
        jsr     L517C                           ; 56FE 20 7C 51                  |Q
        bcc     L5709                           ; 5701 90 06                    ..
        jsr     L527C                           ; 5703 20 7C 52                  |R
        stx     L573E                           ; 5706 8E 3E 57                 .>W
L5709:  jsr     ExitTurbo                       ; 5709 20 32 C2                  2.
        jsr     InitForIO                       ; 570C 20 5C C2                  \.
        lda     L573E                           ; 570F AD 3E 57                 .>W
        jsr     L52EA                           ; 5712 20 EA 52                  .R
        lda     #$43                            ; 5715 A9 43                    .C
        jsr     LFFA8                           ; 5717 20 A8 FF                  ..
        lda     #$50                            ; 571A A9 50                    .P
        jsr     LFFA8                           ; 571C 20 A8 FF                  ..
        ldy     #$00                            ; 571F A0 00                    ..
L5721:  lda     L518E,y                         ; 5721 B9 8E 51                 ..Q
        cmp     #$20                            ; 5724 C9 20                    . 
        beq     L5730                           ; 5726 F0 08                    ..
        jsr     LFFA8                           ; 5728 20 A8 FF                  ..
        iny                                     ; 572B C8                       .
        cpy     #$03                            ; 572C C0 03                    ..
        bcc     L5721                           ; 572E 90 F1                    ..
L5730:  lda     #$0D                            ; 5730 A9 0D                    ..
        jsr     LFFA8                           ; 5732 20 A8 FF                  ..
        jsr     LFFAE                           ; 5735 20 AE FF                  ..
        jsr     DoneWithIO                      ; 5738 20 5F C2                  _.
        jmp     EnterTurbo                      ; 573B 4C 14 C2                 L..

; ----------------------------------------------------------------------------
L573E:  brk                                     ; 573E 00                       .
L573F:  jsr     L515C                           ; 573F 20 5C 51                  \Q
        beq     L5747                           ; 5742 F0 03                    ..
        ldx     #$00                            ; 5744 A2 00                    ..
        rts                                     ; 5746 60                       `

; ----------------------------------------------------------------------------
L5747:  jsr     L576F                           ; 5747 20 6F 57                  oW
        lda     $44                             ; 574A A5 44                    .D
        sta     L57B0                           ; 574C 8D B0 57                 ..W
        lda     $43                             ; 574F A5 43                    .C
        sta     L57AF                           ; 5751 8D AF 57                 ..W
        jsr     L5174                           ; 5754 20 74 51                  tQ
        bne     L575F                           ; 5757 D0 06                    ..
        jsr     L57C5                           ; 5759 20 C5 57                  .W
        clv                                     ; 575C B8                       .
        bvc     L5762                           ; 575D 50 03                    P.
L575F:  jsr     L50DD                           ; 575F 20 DD 50                  .P
L5762:  lda     L57B0                           ; 5762 AD B0 57                 ..W
        sta     $44                             ; 5765 85 44                    .D
        lda     L57AF                           ; 5767 AD AF 57                 ..W
        sta     $43                             ; 576A 85 43                    .C
        ldy     #$91                            ; 576C A0 91                    ..
        .byte   $2C                             ; 576E 2C                       ,
L576F:  ldy     #$90                            ; 576F A0 90                    ..
        tya                                     ; 5771 98                       .
        pha                                     ; 5772 48                       H
        lda     #$85                            ; 5773 A9 85                    ..
        sta     $03                             ; 5775 85 03                    ..
        lda     #$1F                            ; 5777 A9 1F                    ..
        sta     $02                             ; 5779 85 02                    ..
        lda     #$B9                            ; 577B A9 B9                    ..
        sta     $05                             ; 577D 85 05                    ..
        lda     #$00                            ; 577F A9 00                    ..
        sta     $04                             ; 5781 85 04                    ..
        lda     #$01                            ; 5783 A9 01                    ..
        sta     $07                             ; 5785 85 07                    ..
        lda     #$7A                            ; 5787 A9 7A                    .z
        sta     $06                             ; 5789 85 06                    ..
        lda     #$00                            ; 578B A9 00                    ..
        sta     $08                             ; 578D 85 08                    ..
        jsr     DoRAMOp                         ; 578F 20 D4 C2                  ..
        pla                                     ; 5792 68                       h
        tay                                     ; 5793 A8                       .
        lda     #$88                            ; 5794 A9 88                    ..
        sta     $03                             ; 5796 85 03                    ..
        lda     #$0C                            ; 5798 A9 0C                    ..
        sta     $02                             ; 579A 85 02                    ..
        lda     #$BA                            ; 579C A9 BA                    ..
        sta     $05                             ; 579E 85 05                    ..
        lda     #$7A                            ; 57A0 A9 7A                    .z
        sta     $04                             ; 57A2 85 04                    ..
        lda     #$00                            ; 57A4 A9 00                    ..
        sta     $07                             ; 57A6 85 07                    ..
        lda     #$51                            ; 57A8 A9 51                    .Q
        sta     $06                             ; 57AA 85 06                    ..
        jmp     DoRAMOp                         ; 57AC 4C D4 C2                 L..

; ----------------------------------------------------------------------------
L57AF:  brk                                     ; 57AF 00                       .
L57B0:  brk                                     ; 57B0 00                       .
L57B1:  brk                                     ; 57B1 00                       .
L57B2:  brk                                     ; 57B2 00                       .
L57B3:  jsr     LCFD9                           ; 57B3 20 D9 CF                  ..
        jsr     L4000                           ; 57B6 20 00 40                  .@
        jmp     LCFD9                           ; 57B9 4C D9 CF                 L..

; ----------------------------------------------------------------------------
        jsr     LCFD9                           ; 57BC 20 D9 CF                  ..
        jsr     L4003                           ; 57BF 20 03 40                  .@
        jmp     LCFD9                           ; 57C2 4C D9 CF                 L..

; ----------------------------------------------------------------------------
L57C5:  jsr     L5174                           ; 57C5 20 74 51                  tQ
        beq     L57CD                           ; 57C8 F0 03                    ..
        ldx     #$00                            ; 57CA A2 00                    ..
        rts                                     ; 57CC 60                       `

; ----------------------------------------------------------------------------
L57CD:  jsr     L57FD                           ; 57CD 20 FD 57                  .W
L57D0:  ldx     #$01                            ; 57D0 A2 01                    ..
        jsr     L580A                           ; 57D2 20 0A 58                  .X
        lda     $02                             ; 57D5 A5 02                    ..
        cmp     #$50                            ; 57D7 C9 50                    .P
        beq     L57D0                           ; 57D9 F0 F5                    ..
        cmp     #$55                            ; 57DB C9 55                    .U
        bne     L57E2                           ; 57DD D0 03                    ..
        jmp     L50DD                           ; 57DF 4C DD 50                 L.P

; ----------------------------------------------------------------------------
L57E2:  cmp     #$05                            ; 57E2 C9 05                    ..
        beq     L57E7                           ; 57E4 F0 01                    ..
L57E6:  rts                                     ; 57E6 60                       `

; ----------------------------------------------------------------------------
L57E7:  lda     L518C                           ; 57E7 AD 8C 51                 ..Q
        beq     L57E6                           ; 57EA F0 FA                    ..
        lda     #$51                            ; 57EC A9 51                    .Q
        sta     $0F                             ; 57EE 85 0F                    ..
        lda     #$8C                            ; 57F0 A9 8C                    ..
        sta     $0E                             ; 57F2 85 0E                    ..
        jsr     FindFile                        ; 57F4 20 0B C2                  ..
        jsr     L5864                           ; 57F7 20 64 58                  dX
        clv                                     ; 57FA B8                       .
        bvc     L57D0                           ; 57FB 50 D3                    P.
L57FD:  lda     $88C6                           ; 57FD AD C6 88                 ...
        and     #$70                            ; 5800 29 70                    )p
        beq     L5806                           ; 5802 F0 02                    ..
        lda     #$12                            ; 5804 A9 12                    ..
L5806:  sta     L5949                           ; 5806 8D 49 59                 .IY
        rts                                     ; 5809 60                       `

; ----------------------------------------------------------------------------
L580A:  txa                                     ; 580A 8A                       .
        pha                                     ; 580B 48                       H
        jsr     L57B3                           ; 580C 20 B3 57                  .W
        lda     $84B2                           ; 580F AD B2 84                 ...
        sta     L57B2                           ; 5812 8D B2 57                 ..W
        lda     $84B1                           ; 5815 AD B1 84                 ...
        sta     L57B1                           ; 5818 8D B1 57                 ..W
        lda     #$57                            ; 581B A9 57                    .W
        sta     $84B2                           ; 581D 8D B2 84                 ...
        lda     #$BC                            ; 5820 A9 BC                    ..
        sta     $84B1                           ; 5822 8D B1 84                 ...
        lda     #$05                            ; 5825 A9 05                    ..
        sta     $9FF1                           ; 5827 8D F1 9F                 ...
        pla                                     ; 582A 68                       h
        tax                                     ; 582B AA                       .
        lda     L585A,x                         ; 582C BD 5A 58                 .ZX
        sta     $0C                             ; 582F 85 0C                    ..
        lda     L585C,x                         ; 5831 BD 5C 58                 .\X
        sta     $0D                             ; 5834 85 0D                    ..
        lda     L585E,x                         ; 5836 BD 5E 58                 .^X
        sta     $10                             ; 5839 85 10                    ..
        lda     L5860,x                         ; 583B BD 60 58                 .`X
        sta     $02                             ; 583E 85 02                    ..
        lda     L5862,x                         ; 5840 BD 62 58                 .bX
        sta     $03                             ; 5843 85 03                    ..
        jsr     DoDlgBox                        ; 5845 20 56 C2                  V.
        lda     L57B2                           ; 5848 AD B2 57                 ..W
        sta     $84B2                           ; 584B 8D B2 84                 ...
        lda     L57B1                           ; 584E AD B1 57                 ..W
        sta     $84B1                           ; 5851 8D B1 84                 ...
        lda     #$00                            ; 5854 A9 00                    ..
        sta     $9FF1                           ; 5856 8D F1 9F                 ...
        rts                                     ; 5859 60                       `

; ----------------------------------------------------------------------------
L585A:  .byte   $E2                             ; 585A E2                       .
        .byte   $A1                             ; 585B A1                       .
L585C:  .byte   $54                             ; 585C 54                       T
        cli                                     ; 585D 58                       X
L585E:  .byte   $97                             ; 585E 97                       .
        .byte   $91                             ; 585F 91                       .
L5860:  .byte   $AB                             ; 5860 AB                       .
        .byte   $2C                             ; 5861 2C                       ,
L5862:  eor     ($59),y                         ; 5862 51 59                    QY
L5864:  lda     $8400                           ; 5864 AD 00 84                 ...
        and     #$BF                            ; 5867 29 BF                    ).
        cmp     #$86                            ; 5869 C9 86                    ..
        bne     L589E                           ; 586B D0 31                    .1
        lda     $8402                           ; 586D AD 02 84                 ...
        sta     $05                             ; 5870 85 05                    ..
        lda     $8401                           ; 5872 AD 01 84                 ...
        sta     $04                             ; 5875 85 04                    ..
        clv                                     ; 5877 B8                       .
        bvc     L588F                           ; 5878 50 15                    P.
L587A:  jsr     GetDirHead                      ; 587A 20 47 C2                  G.
        lda     $8223                           ; 587D AD 23 82                 .#.
        sta     $05                             ; 5880 85 05                    ..
        lda     $8222                           ; 5882 AD 22 82                 .".
        sta     $04                             ; 5885 85 04                    ..
        bne     L588F                           ; 5887 D0 06                    ..
L5889:  lda     #$01                            ; 5889 A9 01                    ..
        sta     $04                             ; 588B 85 04                    ..
        sta     $05                             ; 588D 85 05                    ..
L588F:  jsr     L5174                           ; 588F 20 74 51                  tQ
        bne     L589E                           ; 5892 D0 0A                    ..
        lda     #$00                            ; 5894 A9 00                    ..
        sta     $06                             ; 5896 85 06                    ..
        jsr     L9066                           ; 5898 20 66 90                  f.
        jmp     L9053                           ; 589B 4C 53 90                 LS.

; ----------------------------------------------------------------------------
L589E:  ldx     #$05                            ; 589E A2 05                    ..
        rts                                     ; 58A0 60                       `

; ----------------------------------------------------------------------------
        jsr     L5138                           ; 58A1 20 38 51                  8Q
        lda     $8489                           ; 58A4 AD 89 84                 ...
        jsr     SetDevice                       ; 58A7 20 B0 C2                  ..
        jsr     OpenDisk                        ; 58AA 20 A1 C2                  ..
        txa                                     ; 58AD 8A                       .
        bne     L5910                           ; 58AE D0 60                    .`
        jsr     L9030                           ; 58B0 20 30 90                  0.
        txa                                     ; 58B3 8A                       .
        bne     L5910                           ; 58B4 D0 5A                    .Z
L58B6:  ldy     #$00                            ; 58B6 A0 00                    ..
        lda     ($0C),y                         ; 58B8 B1 0C                    ..
        and     #$BF                            ; 58BA 29 BF                    ).
        cmp     #$86                            ; 58BC C9 86                    ..
        bne     L5907                           ; 58BE D0 47                    .G
        ldy     #$03                            ; 58C0 A0 03                    ..
        ldx     #$00                            ; 58C2 A2 00                    ..
L58C4:  lda     ($0C),y                         ; 58C4 B1 0C                    ..
        beq     L58D5                           ; 58C6 F0 0D                    ..
        cmp     #$A0                            ; 58C8 C9 A0                    ..
        beq     L58D5                           ; 58CA F0 09                    ..
        sta     L518C,x                         ; 58CC 9D 8C 51                 ..Q
        iny                                     ; 58CF C8                       .
        inx                                     ; 58D0 E8                       .
        cpx     #$10                            ; 58D1 E0 10                    ..
        bne     L58C4                           ; 58D3 D0 EF                    ..
L58D5:  lda     #$00                            ; 58D5 A9 00                    ..
        sta     L518C,x                         ; 58D7 9D 8C 51                 ..Q
        lda     #$51                            ; 58DA A9 51                    .Q
        sta     $03                             ; 58DC 85 03                    ..
        lda     #$8C                            ; 58DE A9 8C                    ..
        sta     $02                             ; 58E0 85 02                    ..
        ldx     #$02                            ; 58E2 A2 02                    ..
        ldy     #$0E                            ; 58E4 A0 0E                    ..
        jsr     CopyString                      ; 58E6 20 65 C2                  e.
        lda     $0D                             ; 58E9 A5 0D                    ..
        sta     L591B                           ; 58EB 8D 1B 59                 ..Y
        lda     $0C                             ; 58EE A5 0C                    ..
        sta     L591A                           ; 58F0 8D 1A 59                 ..Y
        lda     #$58                            ; 58F3 A9 58                    .X
        sta     $0D                             ; 58F5 85 0D                    ..
        lda     #$FD                            ; 58F7 A9 FD                    ..
        sta     $0C                             ; 58F9 85 0C                    ..
        clc                                     ; 58FB 18                       .
        rts                                     ; 58FC 60                       `

; ----------------------------------------------------------------------------
        lda     L591B                           ; 58FD AD 1B 59                 ..Y
        sta     $0D                             ; 5900 85 0D                    ..
        lda     L591A                           ; 5902 AD 1A 59                 ..Y
        sta     $0C                             ; 5905 85 0C                    ..
L5907:  jsr     L9033                           ; 5907 20 33 90                  3.
        txa                                     ; 590A 8A                       .
        bne     L5910                           ; 590B D0 03                    ..
        tya                                     ; 590D 98                       .
        beq     L58B6                           ; 590E F0 A6                    ..
L5910:  lda     #$51                            ; 5910 A9 51                    .Q
        sta     $0D                             ; 5912 85 0D                    ..
        lda     #$8C                            ; 5914 A9 8C                    ..
        sta     $0C                             ; 5916 85 0C                    ..
        sec                                     ; 5918 38                       8
        rts                                     ; 5919 60                       `

; ----------------------------------------------------------------------------
L591A:  brk                                     ; 591A 00                       .
L591B:  brk                                     ; 591B 00                       .
        jsr     L587A                           ; 591C 20 7A 58                  zX
        txa                                     ; 591F 8A                       .
        beq     L5929                           ; 5920 F0 07                    ..
L5922:  rts                                     ; 5922 60                       `

; ----------------------------------------------------------------------------
        jsr     L5889                           ; 5923 20 89 58                  .X
        txa                                     ; 5926 8A                       .
        bne     L5922                           ; 5927 D0 F9                    ..
L5929:  jmp     L5317                           ; 5929 4C 17 53                 L.S

; ----------------------------------------------------------------------------
        brk                                     ; 592C 00                       .
        jsr     L4097                           ; 592D 20 97 40                  .@
        brk                                     ; 5930 00                       .
        .byte   $FF                             ; 5931 FF                       .
        brk                                     ; 5932 00                       .
        .byte   $13                             ; 5933 13                       .
        .byte   $3B                             ; 5934 3B                       ;
        .byte   $53                             ; 5935 53                       S
        bpl     L593E                           ; 5936 10 06                    ..
        .byte   $1A                             ; 5938 1A                       .
        ora     $11                             ; 5939 05 11                    ..
        bpl     L593E                           ; 593B 10 01                    ..
        .byte   $11                             ; 593D 11                       .
L593E:  rts                                     ; 593E 60                       `

; ----------------------------------------------------------------------------
        .byte   $12                             ; 593F 12                       .
        ora     ($24),y                         ; 5940 11 24                    .$
        .byte   $4F                             ; 5942 4F                       O
        eor     $1112,y                         ; 5943 59 12 11                 Y..
        sec                                     ; 5946 38                       8
        .byte   $57                             ; 5947 57                       W
        .byte   $59                             ; 5948 59                       Y
L5949:  .byte   $12                             ; 5949 12                       .
        ora     ($4C),y                         ; 594A 11 4C                    .L
        .byte   $5F                             ; 594C 5F                       _
        eor     $BB00,y                         ; 594D 59 00 BB                 Y..
        eor     L0000,y                         ; 5950 59 00 00                 Y..
        asl     $10                             ; 5953 06 10                    ..
        .byte   $23                             ; 5955 23                       #
        eor     L5967,y                         ; 5956 59 67 59                 YgY
        brk                                     ; 5959 00                       .
        brk                                     ; 595A 00                       .
        asl     $10                             ; 595B 06 10                    ..
        .byte   $1C                             ; 595D 1C                       .
        eor     L5A63,y                         ; 595E 59 63 5A                 YcZ
        brk                                     ; 5961 00                       .
        brk                                     ; 5962 00                       .
        asl     $10                             ; 5963 06 10                    ..
        .byte   $1A                             ; 5965 1A                       .
        .byte   $53                             ; 5966 53                       S
L5967:  ora     $FF                             ; 5967 05 FF                    ..
        .byte   $82                             ; 5969 82                       .
        inc     $0480,x                         ; 596A FE 80 04                 ...
        brk                                     ; 596D 00                       .
        .byte   $82                             ; 596E 82                       .
        .byte   $03                             ; 596F 03                       .
        .byte   $80                             ; 5970 80                       .
        .byte   $04                             ; 5971 04                       .
        brk                                     ; 5972 00                       .
        clv                                     ; 5973 B8                       .
        .byte   $03                             ; 5974 03                       .
        .byte   $83                             ; 5975 83                       .
        beq     L5978                           ; 5976 F0 00                    ..
L5978:  brk                                     ; 5978 00                       .
        ora     ($83,x)                         ; 5979 01 83                    ..
        .byte   $83                             ; 597B 83                       .
        clc                                     ; 597C 18                       .
        brk                                     ; 597D 00                       .
        brk                                     ; 597E 00                       .
        ora     ($83,x)                         ; 597F 01 83                    ..
        .byte   $83                             ; 5981 83                       .
        ora     $9CC7,y                         ; 5982 19 C7 9C                 ...
        .byte   $F3                             ; 5985 F3                       .
        .byte   $C3                             ; 5986 C3                       .
        .byte   $83                             ; 5987 83                       .
        .byte   $1B                             ; 5988 1B                       .
        .byte   $67                             ; 5989 67                       g
        rol     $F9,x                           ; 598A 36 F9                    6.
        .byte   $83                             ; 598C 83                       .
        .byte   $83                             ; 598D 83                       .
        beq     L59F6                           ; 598E F0 66                    .f
        rol     $D9,x                           ; 5990 36 D9                    6.
        .byte   $83                             ; 5992 83                       .
        .byte   $83                             ; 5993 83                       .
        ora     ($E6,x)                         ; 5994 01 E6                    ..
        rol     $83D9,x                         ; 5996 3E D9 83                 >..
        .byte   $83                             ; 5999 83                       .
        .byte   $03                             ; 599A 03                       .
        ror     $30                             ; 599B 66 30                    f0
        cmp     $8383,y                         ; 599D D9 83 83                 ...
        .byte   $03                             ; 59A0 03                       .
        ror     $36                             ; 59A1 66 36                    f6
        cmp     $8383,y                         ; 59A3 D9 83 83                 ...
        ora     ($F6,x)                         ; 59A6 01 F6                    ..
        .byte   $1C                             ; 59A8 1C                       .
        cmp     $80C3,y                         ; 59A9 D9 C3 80                 ...
        .byte   $04                             ; 59AC 04                       .
        brk                                     ; 59AD 00                       .
        .byte   $82                             ; 59AE 82                       .
        .byte   $03                             ; 59AF 03                       .
        .byte   $80                             ; 59B0 80                       .
        .byte   $04                             ; 59B1 04                       .
        brk                                     ; 59B2 00                       .
        sta     ($03,x)                         ; 59B3 81 03                    ..
        asl     $FF                             ; 59B5 06 FF                    ..
        sta     ($7F,x)                         ; 59B7 81 7F                    ..
        ora     $FF                             ; 59B9 05 FF                    ..
        ora     $FF                             ; 59BB 05 FF                    ..
        .byte   $82                             ; 59BD 82                       .
        inc     $0480,x                         ; 59BE FE 80 04                 ...
        brk                                     ; 59C1 00                       .
        .byte   $82                             ; 59C2 82                       .
        .byte   $03                             ; 59C3 03                       .
        .byte   $80                             ; 59C4 80                       .
        .byte   $04                             ; 59C5 04                       .
        brk                                     ; 59C6 00                       .
        clv                                     ; 59C7 B8                       .
        .byte   $03                             ; 59C8 03                       .
        .byte   $80                             ; 59C9 80                       .
        .byte   $1F                             ; 59CA 1F                       .
        .byte   $80                             ; 59CB 80                       .
        brk                                     ; 59CC 00                       .
        cpy     #$03                            ; 59CD C0 03                    ..
        .byte   $80                             ; 59CF 80                       .
        clc                                     ; 59D0 18                       .
        cpy     #$00                            ; 59D1 C0 00                    ..
        cpy     #$03                            ; 59D3 C0 03                    ..
        .byte   $80                             ; 59D5 80                       .
        clc                                     ; 59D6 18                       .
        dec     $E039                           ; 59D7 CE 39 E0                 .9.
        .byte   $03                             ; 59DA 03                       .
        .byte   $80                             ; 59DB 80                       .
        clc                                     ; 59DC 18                       .
        .byte   $DB                             ; 59DD DB                       .
        jmp     (L03C0)                         ; 59DE 6C C0 03                 l..

; ----------------------------------------------------------------------------
        .byte   $80                             ; 59E1 80                       .
        .byte   $1F                             ; 59E2 1F                       .
        .byte   $9B                             ; 59E3 9B                       .
        jmp     (L03C0)                         ; 59E4 6C C0 03                 l..

; ----------------------------------------------------------------------------
        .byte   $80                             ; 59E7 80                       .
        ora     $6C9B,y                         ; 59E8 19 9B 6C                 ..l
        cpy     #$03                            ; 59EB C0 03                    ..
        .byte   $80                             ; 59ED 80                       .
        clc                                     ; 59EE 18                       .
        .byte   $DB                             ; 59EF DB                       .
        jmp     (L03C0)                         ; 59F0 6C C0 03                 l..

; ----------------------------------------------------------------------------
        .byte   $80                             ; 59F3 80                       .
        clc                                     ; 59F4 18                       .
        .byte   $DB                             ; 59F5 DB                       .
L59F6:  jmp     (L03C0)                         ; 59F6 6C C0 03                 l..

; ----------------------------------------------------------------------------
        .byte   $80                             ; 59F9 80                       .
        clc                                     ; 59FA 18                       .
        dec     $E038                           ; 59FB CE 38 E0                 .8.
        .byte   $03                             ; 59FE 03                       .
        .byte   $80                             ; 59FF 80                       .
        .byte   $04                             ; 5A00 04                       .
        brk                                     ; 5A01 00                       .
        .byte   $82                             ; 5A02 82                       .
        .byte   $03                             ; 5A03 03                       .
        .byte   $80                             ; 5A04 80                       .
        .byte   $04                             ; 5A05 04                       .
        brk                                     ; 5A06 00                       .
        sta     ($03,x)                         ; 5A07 81 03                    ..
        asl     $FF                             ; 5A09 06 FF                    ..
        sta     ($7F,x)                         ; 5A0B 81 7F                    ..
        ora     $FF                             ; 5A0D 05 FF                    ..
        ora     $FF                             ; 5A0F 05 FF                    ..
        .byte   $82                             ; 5A11 82                       .
        inc     $0480,x                         ; 5A12 FE 80 04                 ...
        brk                                     ; 5A15 00                       .
        .byte   $82                             ; 5A16 82                       .
        .byte   $03                             ; 5A17 03                       .
        .byte   $80                             ; 5A18 80                       .
        .byte   $04                             ; 5A19 04                       .
        brk                                     ; 5A1A 00                       .
        clv                                     ; 5A1B B8                       .
        .byte   $03                             ; 5A1C 03                       .
        .byte   $80                             ; 5A1D 80                       .
        sed                                     ; 5A1E F8                       .
        asl     $03                             ; 5A1F 06 03                    ..
        rts                                     ; 5A21 60                       `

; ----------------------------------------------------------------------------
        .byte   $03                             ; 5A22 03                       .
        sta     ($8C,x)                         ; 5A23 81 8C                    ..
        asl     $03                             ; 5A25 06 03                    ..
        brk                                     ; 5A27 00                       .
        .byte   $03                             ; 5A28 03                       .
        sta     ($8D,x)                         ; 5A29 81 8D                    ..
        .byte   $B7                             ; 5A2B B7                       .
        .byte   $8F                             ; 5A2C 8F                       .
        .byte   $6F                             ; 5A2D 6F                       o
        .byte   $03                             ; 5A2E 03                       .
        sta     ($81,x)                         ; 5A2F 81 81                    ..
        .byte   $B7                             ; 5A31 B7                       .
        .byte   $DF                             ; 5A32 DF                       .
        ror     L8003                           ; 5A33 6E 03 80                 n..
        sbc     $DBB6,y                         ; 5A36 F9 B6 DB                 ...
        jmp     (L8003)                         ; 5A39 6C 03 80                 l..

; ----------------------------------------------------------------------------
        ora     $DBB6                           ; 5A3C 0D B6 DB                 ...
        jmp     (L8103)                         ; 5A3F 6C 03 81                 l..

; ----------------------------------------------------------------------------
        sta     $DBB6                           ; 5A42 8D B6 DB                 ...
        jmp     (L8103)                         ; 5A45 6C 03 81                 l..

; ----------------------------------------------------------------------------
        sta     $DFF7                           ; 5A48 8D F7 DF                 ...
        jmp     (L8003)                         ; 5A4B 6C 03 80                 l..

; ----------------------------------------------------------------------------
L5A4E:  sed                                     ; 5A4E F8                       .
        .byte   $F7                             ; 5A4F F7                       .
        .byte   $8F                             ; 5A50 8F                       .
        jmp     (L8003)                         ; 5A51 6C 03 80                 l..

; ----------------------------------------------------------------------------
L5A54:  .byte   $04                             ; 5A54 04                       .
        brk                                     ; 5A55 00                       .
        .byte   $82                             ; 5A56 82                       .
        .byte   $03                             ; 5A57 03                       .
        .byte   $80                             ; 5A58 80                       .
        .byte   $04                             ; 5A59 04                       .
L5A5A:  brk                                     ; 5A5A 00                       .
        sta     ($03,x)                         ; 5A5B 81 03                    ..
        asl     $FF                             ; 5A5D 06 FF                    ..
        .byte   $81                             ; 5A5F 81                       .
L5A60:  .byte   $7F                             ; 5A60 7F                       .
        ora     $FF                             ; 5A61 05 FF                    ..
L5A63:  ora     $FF                             ; 5A63 05 FF                    ..
        .byte   $82                             ; 5A65 82                       .
        inc     $0480,x                         ; 5A66 FE 80 04                 ...
        brk                                     ; 5A69 00                       .
        .byte   $82                             ; 5A6A 82                       .
        .byte   $03                             ; 5A6B 03                       .
        .byte   $80                             ; 5A6C 80                       .
        .byte   $04                             ; 5A6D 04                       .
        brk                                     ; 5A6E 00                       .
        clv                                     ; 5A6F B8                       .
        .byte   $03                             ; 5A70 03                       .
        .byte   $80                             ; 5A71 80                       .
        .byte   $1F                             ; 5A72 1F                       .
        .byte   $80                             ; 5A73 80                       .
        brk                                     ; 5A74 00                       .
        cpy     #$03                            ; 5A75 C0 03                    ..
        .byte   $80                             ; 5A77 80                       .
        clc                                     ; 5A78 18                       .
        cpy     #$00                            ; 5A79 C0 00                    ..
        cpy     #$03                            ; 5A7B C0 03                    ..
        .byte   $80                             ; 5A7D 80                       .
        clc                                     ; 5A7E 18                       .
        dec     $E03D                           ; 5A7F CE 3D E0                 .=.
        .byte   $03                             ; 5A82 03                       .
        .byte   $80                             ; 5A83 80                       .
        clc                                     ; 5A84 18                       .
        .byte   $DB                             ; 5A85 DB                       .
        sec                                     ; 5A86 38                       8
        cpy     #$03                            ; 5A87 C0 03                    ..
        .byte   $80                             ; 5A89 80                       .
        .byte   $1F                             ; 5A8A 1F                       .
        .byte   $83                             ; 5A8B 83                       .
        bmi     L5A4E                           ; 5A8C 30 C0                    0.
        .byte   $03                             ; 5A8E 03                       .
        .byte   $80                             ; 5A8F 80                       .
        clc                                     ; 5A90 18                       .
        .byte   $0F                             ; 5A91 0F                       .
L5A92:  bmi     L5A54                           ; 5A92 30 C0                    0.
        .byte   $03                             ; 5A94 03                       .
        .byte   $80                             ; 5A95 80                       .
        clc                                     ; 5A96 18                       .
        .byte   $1B                             ; 5A97 1B                       .
        bmi     L5A5A                           ; 5A98 30 C0                    0.
        .byte   $03                             ; 5A9A 03                       .
        .byte   $80                             ; 5A9B 80                       .
        clc                                     ; 5A9C 18                       .
        .byte   $1B                             ; 5A9D 1B                       .
        bmi     L5A60                           ; 5A9E 30 C0                    0.
        .byte   $03                             ; 5AA0 03                       .
        .byte   $80                             ; 5AA1 80                       .
        clc                                     ; 5AA2 18                       .
        .byte   $0F                             ; 5AA3 0F                       .
        bcs     L5A92                           ; 5AA4 B0 EC                    ..
        .byte   $03                             ; 5AA6 03                       .
        .byte   $80                             ; 5AA7 80                       .
        .byte   $04                             ; 5AA8 04                       .
        brk                                     ; 5AA9 00                       .
        .byte   $82                             ; 5AAA 82                       .
        .byte   $03                             ; 5AAB 03                       .
        .byte   $80                             ; 5AAC 80                       .
        .byte   $04                             ; 5AAD 04                       .
        brk                                     ; 5AAE 00                       .
        sta     ($03,x)                         ; 5AAF 81 03                    ..
        asl     $FF                             ; 5AB1 06 FF                    ..
        sta     ($7F,x)                         ; 5AB3 81 7F                    ..
        ora     $FF                             ; 5AB5 05 FF                    ..
L5AB7:  lda     #$FF                            ; 5AB7 A9 FF                    ..
        sta     $11                             ; 5AB9 85 11                    ..
        lda     #$C3                            ; 5ABB A9 C3                    ..
        sta     $0D                             ; 5ABD 85 0D                    ..
        lda     #$0A                            ; 5ABF A9 0A                    ..
        sta     $0C                             ; 5AC1 85 0C                    ..
        lda     $10                             ; 5AC3 A5 10                    ..
        eor     #$80                            ; 5AC5 49 80                    I.
        sta     $9FF3                           ; 5AC7 8D F3 9F                 ...
        bmi     L5ADB                           ; 5ACA 30 0F                    0.
        lda     $885A                           ; 5ACC AD 5A 88                 .Z.
        sta     $0D                             ; 5ACF 85 0D                    ..
        lda     $8859                           ; 5AD1 AD 59 88                 .Y.
        sta     $0C                             ; 5AD4 85 0C                    ..
        lda     $10                             ; 5AD6 A5 10                    ..
        and     #$7F                            ; 5AD8 29 7F                    ).
        .byte   $2C                             ; 5ADA 2C                       ,
L5ADB:  lda     #$11                            ; 5ADB A9 11                    ..
        sta     $9FF2                           ; 5ADD 8D F2 9F                 ...
        lda     #$00                            ; 5AE0 A9 00                    ..
        sta     $8856                           ; 5AE2 8D 56 88                 .V.
        sta     $885B                           ; 5AE5 8D 5B 88                 .[.
L5AE8:  jsr     L5B58                           ; 5AE8 20 58 5B                  X[
        lda     #$05                            ; 5AEB A9 05                    ..
        sta     $885C                           ; 5AED 8D 5C 88                 .\.
        lda     #$83                            ; 5AF0 A9 83                    ..
        sta     $0F                             ; 5AF2 85 0F                    ..
        lda     #$00                            ; 5AF4 A9 00                    ..
        sta     $0E                             ; 5AF6 85 0E                    ..
L5AF8:  jsr     L5B51                           ; 5AF8 20 51 5B                  Q[
        bcs     L5B32                           ; 5AFB B0 35                    .5
        lda     $0E                             ; 5AFD A5 0E                    ..
        adc     $9FF2                           ; 5AFF 6D F2 9F                 m..
        sta     $0E                             ; 5B02 85 0E                    ..
        bcc     L5B08                           ; 5B04 90 02                    ..
        inc     $0F                             ; 5B06 E6 0F                    ..
L5B08:  inc     $8856                           ; 5B08 EE 56 88                 .V.
        dec     $885C                           ; 5B0B CE 5C 88                 .\.
        bne     L5AF8                           ; 5B0E D0 E8                    ..
        lda     $885B                           ; 5B10 AD 5B 88                 .[.
        jsr     L5B62                           ; 5B13 20 62 5B                  b[
        jsr     StashRAM                        ; 5B16 20 C8 C2                  ..
        lda     $8856                           ; 5B19 AD 56 88                 .V.
        sta     $885B                           ; 5B1C 8D 5B 88                 .[.
        cmp     #$FF                            ; 5B1F C9 FF                    ..
        bcc     L5AE8                           ; 5B21 90 C5                    ..
L5B23:  lda     #$83                            ; 5B23 A9 83                    ..
        sta     $0F                             ; 5B25 85 0F                    ..
        lda     #$00                            ; 5B27 A9 00                    ..
        sta     $0E                             ; 5B29 85 0E                    ..
        jsr     L5B51                           ; 5B2B 20 51 5B                  Q[
        bcc     L5B23                           ; 5B2E 90 F3                    ..
        bcs     L5B3B                           ; 5B30 B0 09                    ..
L5B32:  lda     $885B                           ; 5B32 AD 5B 88                 .[.
        jsr     L5B62                           ; 5B35 20 62 5B                  b[
        jsr     StashRAM                        ; 5B38 20 C8 C2                  ..
L5B3B:  bit     $9FF3                           ; 5B3B 2C F3 9F                 ,..
        bpl     L5B46                           ; 5B3E 10 06                    ..
        lda     #$00                            ; 5B40 A9 00                    ..
        sta     $9FF3                           ; 5B42 8D F3 9F                 ...
        rts                                     ; 5B45 60                       `

; ----------------------------------------------------------------------------
L5B46:  lda     $0D                             ; 5B46 A5 0D                    ..
        sta     $885A                           ; 5B48 8D 5A 88                 .Z.
        lda     $0C                             ; 5B4B A5 0C                    ..
        sta     $8859                           ; 5B4D 8D 59 88                 .Y.
        rts                                     ; 5B50 60                       `

; ----------------------------------------------------------------------------
L5B51:  lda     $0C                             ; 5B51 A5 0C                    ..
        ldx     $0D                             ; 5B53 A6 0D                    ..
        jmp     CallRoutine                     ; 5B55 4C D8 C1                 L..

; ----------------------------------------------------------------------------
L5B58:  ldx     #$00                            ; 5B58 A2 00                    ..
        txa                                     ; 5B5A 8A                       .
L5B5B:  sta     $8300,x                         ; 5B5B 9D 00 83                 ...
        inx                                     ; 5B5E E8                       .
        bne     L5B5B                           ; 5B5F D0 FA                    ..
        rts                                     ; 5B61 60                       `

; ----------------------------------------------------------------------------
L5B62:  sta     $04                             ; 5B62 85 04                    ..
        lda     $11                             ; 5B64 A5 11                    ..
        pha                                     ; 5B66 48                       H
        lda     $10                             ; 5B67 A5 10                    ..
        pha                                     ; 5B69 48                       H
        lda     #$05                            ; 5B6A A9 05                    ..
        sta     $02                             ; 5B6C 85 02                    ..
        lda     $9FF2                           ; 5B6E AD F2 9F                 ...
        sta     $06                             ; 5B71 85 06                    ..
        ldx     #$06                            ; 5B73 A2 06                    ..
        ldy     #$02                            ; 5B75 A0 02                    ..
        jsr     BBMult                          ; 5B77 20 60 C1                  `.
        lda     $9FF2                           ; 5B7A AD F2 9F                 ...
        sta     $02                             ; 5B7D 85 02                    ..
        ldx     #$04                            ; 5B7F A2 04                    ..
        ldy     #$02                            ; 5B81 A0 02                    ..
        jsr     BBMult                          ; 5B83 20 60 C1                  `.
        clc                                     ; 5B86 18                       .
        lda     $04                             ; 5B87 A5 04                    ..
        adc     #$80                            ; 5B89 69 80                    i.
        sta     $04                             ; 5B8B 85 04                    ..
        lda     $05                             ; 5B8D A5 05                    ..
        adc     #$E0                            ; 5B8F 69 E0                    i.
        sta     $05                             ; 5B91 85 05                    ..
        lda     #$83                            ; 5B93 A9 83                    ..
        sta     $03                             ; 5B95 85 03                    ..
        lda     #$00                            ; 5B97 A9 00                    ..
        sta     $02                             ; 5B99 85 02                    ..
        lda     #$00                            ; 5B9B A9 00                    ..
        sta     $08                             ; 5B9D 85 08                    ..
        pla                                     ; 5B9F 68                       h
        sta     $10                             ; 5BA0 85 10                    ..
        pla                                     ; 5BA2 68                       h
        sta     $11                             ; 5BA3 85 11                    ..
        rts                                     ; 5BA5 60                       `

; ----------------------------------------------------------------------------
