; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu11.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L8B42           := $8B42
L8B45           := $8B45
L8B48           := $8B48
L9D83           := $9D83
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
LC304           := $C304
LE395           := $E395
LE398           := $E398
LE39B           := $E39B
LE39D           := $E39D
LE4B7           := $E4B7
LFCF8           := $FCF8
LFF84           := $FF84
LFF93           := $FF93
LFFA8           := $FFA8
LFFAE           := $FFAE
LFFB1           := $FFB1
; ----------------------------------------------------------------------------
        sei                                     ; 5000 78                       x
        lda     $03                             ; 5001 A5 03                    ..
        sta     L5057                           ; 5003 8D 57 50                 .WP
        lda     $02                             ; 5006 A5 02                    ..
        sta     L5056                           ; 5008 8D 56 50                 .VP
        jsr     MouseOff                        ; 500B 20 8D C1                  ..
        jsr     LC304                           ; 500E 20 04 C3                  ..
        lda     $01                             ; 5011 A5 01                    ..
        pha                                     ; 5013 48                       H
        lda     #$35                            ; 5014 A9 35                    .5
        sta     $01                             ; 5016 85 01                    ..
        ldx     $D0BC                           ; 5018 AE BC D0                 ...
        pla                                     ; 501B 68                       h
        sta     $01                             ; 501C 85 01                    ..
        txa                                     ; 501E 8A                       .
        bmi     L5044                           ; 501F 30 23                    0#
        lda     $9FED                           ; 5021 AD ED 9F                 ...
        cmp     #$04                            ; 5024 C9 04                    ..
        bne     L5044                           ; 5026 D0 1C                    ..
        lda     $9FD6                           ; 5028 AD D6 9F                 ...
        .byte   $8F                             ; 502B 8F                       .
        .byte   $7C                             ; 502C 7C                       |
        .byte   $D2                             ; 502D D2                       .
        ora     ($AD,x)                         ; 502E 01 AD                    ..
        .byte   $D7                             ; 5030 D7                       .
        .byte   $9F                             ; 5031 9F                       .
        .byte   $8F                             ; 5032 8F                       .
        adc     $01D2,x                         ; 5033 7D D2 01                 }..
        lda     $9FD8                           ; 5036 AD D8 9F                 ...
        .byte   $8F                             ; 5039 8F                       .
        ror     $01D2,x                         ; 503A 7E D2 01                 ~..
        lda     $9FD9                           ; 503D AD D9 9F                 ...
        .byte   $8F                             ; 5040 8F                       .
        .byte   $7F                             ; 5041 7F                       .
        .byte   $D2                             ; 5042 D2                       .
        .byte   $01                             ; 5043 01                       .
L5044:  jsr     i_MoveData                      ; 5044 20 B7 C1                  ..
        bvc     L5099                           ; 5047 50 50                    PP
        brk                                     ; 5049 00                       .
        txa                                     ; 504A 8A                       .
        .byte   $DB                             ; 504B DB                       .
        ora     ($4C,x)                         ; 504C 01 4C                    .L
        brk                                     ; 504E 00                       .
        txa                                     ; 504F 8A                       .
        jsr     L9D83                           ; 5050 20 83 9D                  ..
        ldy     #$27                            ; 5053 A0 27                    .'
L5055:  .byte   $B9                             ; 5055 B9                       .
L5056:  brk                                     ; 5056 00                       .
L5057:  .byte   $04                             ; 5057 04                       .
        cmp     #$5B                            ; 5058 C9 5B                    .[
        bcs     L5062                           ; 505A B0 06                    ..
        cmp     #$41                            ; 505C C9 41                    .A
        bcc     L5062                           ; 505E 90 02                    ..
        sbc     #$40                            ; 5060 E9 40                    .@
L5062:  sta     $8BAB,y                         ; 5062 99 AB 8B                 ...
        dey                                     ; 5065 88                       .
        bpl     L5055                           ; 5066 10 ED                    ..
        lda     $0D                             ; 5068 A5 0D                    ..
        beq     L50B9                           ; 506A F0 4D                    .M
        iny                                     ; 506C C8                       .
        tya                                     ; 506D 98                       .
L506E:  sta     $0800,y                         ; 506E 99 00 08                 ...
        iny                                     ; 5071 C8                       .
        bne     L506E                           ; 5072 D0 FA                    ..
        sec                                     ; 5074 38                       8
        lda     $10                             ; 5075 A5 10                    ..
        sbc     #$02                            ; 5077 E9 02                    ..
        sta     $10                             ; 5079 85 10                    ..
        lda     $11                             ; 507B A5 11                    ..
        sbc     #$00                            ; 507D E9 00                    ..
        sta     $11                             ; 507F 85 11                    ..
        lda     ($10),y                         ; 5081 B1 10                    ..
        pha                                     ; 5083 48                       H
        iny                                     ; 5084 C8                       .
        lda     ($10),y                         ; 5085 B1 10                    ..
        pha                                     ; 5087 48                       H
        lda     $11                             ; 5088 A5 11                    ..
        pha                                     ; 508A 48                       H
        lda     $10                             ; 508B A5 10                    ..
        pha                                     ; 508D 48                       H
        lda     ($0C),y                         ; 508E B1 0C                    ..
        sta     $04                             ; 5090 85 04                    ..
        iny                                     ; 5092 C8                       .
        lda     ($0C),y                         ; 5093 B1 0C                    ..
        sta     $05                             ; 5095 85 05                    ..
        lda     #$FF                            ; 5097 A9 FF                    ..
L5099:  sta     $06                             ; 5099 85 06                    ..
        sta     $07                             ; 509B 85 07                    ..
        jsr     ReadFile                        ; 509D 20 FF C1                  ..
        lda     $11                             ; 50A0 A5 11                    ..
        sta     $8BD9                           ; 50A2 8D D9 8B                 ...
        lda     $10                             ; 50A5 A5 10                    ..
        sta     $8BD8                           ; 50A7 8D D8 8B                 ...
        pla                                     ; 50AA 68                       h
        sta     $02                             ; 50AB 85 02                    ..
        pla                                     ; 50AD 68                       h
        sta     $03                             ; 50AE 85 03                    ..
        ldy     #$01                            ; 50B0 A0 01                    ..
        pla                                     ; 50B2 68                       h
        sta     ($02),y                         ; 50B3 91 02                    ..
        dey                                     ; 50B5 88                       .
        pla                                     ; 50B6 68                       h
        sta     ($02),y                         ; 50B7 91 02                    ..
L50B9:  jsr     PurgeTurbo                      ; 50B9 20 35 C2                  5.
        jsr     InitForIO                       ; 50BC 20 5C C2                  \.
        lda     #$37                            ; 50BF A9 37                    .7
        sta     $01                             ; 50C1 85 01                    ..
        sei                                     ; 50C3 78                       x
        ldy     #$03                            ; 50C4 A0 03                    ..
L50C6:  lda     $0800,y                         ; 50C6 B9 00 08                 ...
        sta     $8BD4,y                         ; 50C9 99 D4 8B                 ...
        dey                                     ; 50CC 88                       .
        bpl     L50C6                           ; 50CD 10 F7                    ..
        lda     #$00                            ; 50CF A9 00                    ..
        sta     $90                             ; 50D1 85 90                    ..
        lda     $BA                             ; 50D3 A5 BA                    ..
        sta     $8BDA                           ; 50D5 8D DA 8B                 ...
        cmp     #$08                            ; 50D8 C9 08                    ..
        bcc     L5105                           ; 50DA 90 29                    .)
        cmp     #$0C                            ; 50DC C9 0C                    ..
        bcs     L5105                           ; 50DE B0 25                    .%
        jsr     LFFB1                           ; 50E0 20 B1 FF                  ..
        lda     $90                             ; 50E3 A5 90                    ..
        bne     L5102                           ; 50E5 D0 1B                    ..
        lda     #$6F                            ; 50E7 A9 6F                    .o
        jsr     LFF93                           ; 50E9 20 93 FF                  ..
        lda     $90                             ; 50EC A5 90                    ..
        bne     L5102                           ; 50EE D0 12                    ..
        lda     #$49                            ; 50F0 A9 49                    .I
        jsr     LFFA8                           ; 50F2 20 A8 FF                  ..
        lda     #$0D                            ; 50F5 A9 0D                    ..
        jsr     LFFA8                           ; 50F7 20 A8 FF                  ..
        jsr     LFFAE                           ; 50FA 20 AE FF                  ..
        lda     $BA                             ; 50FD A5 BA                    ..
        jsr     LFFB1                           ; 50FF 20 B1 FF                  ..
L5102:  jsr     LFFAE                           ; 5102 20 AE FF                  ..
L5105:  ldx     #$FF                            ; 5105 A2 FF                    ..
        txs                                     ; 5107 9A                       .
        cld                                     ; 5108 D8                       .
        lda     #$00                            ; 5109 A9 00                    ..
        sta     $D016                           ; 510B 8D 16 D0                 ...
        jsr     LFF84                           ; 510E 20 84 FF                  ..
        ldy     #$00                            ; 5111 A0 00                    ..
        tya                                     ; 5113 98                       .
L5114:  sta     $02,y                           ; 5114 99 02 00                 ...
        sta     $0200,y                         ; 5117 99 00 02                 ...
        sta     $0300,y                         ; 511A 99 00 03                 ...
        iny                                     ; 511D C8                       .
        bne     L5114                           ; 511E D0 F4                    ..
        lda     #$03                            ; 5120 A9 03                    ..
        sta     $B3                             ; 5122 85 B3                    ..
        lda     #$3C                            ; 5124 A9 3C                    .<
        sta     $B2                             ; 5126 85 B2                    ..
        lda     #$A0                            ; 5128 A9 A0                    ..
        sta     $0284                           ; 512A 8D 84 02                 ...
        lda     #$08                            ; 512D A9 08                    ..
        sta     $0282                           ; 512F 8D 82 02                 ...
        lda     #$04                            ; 5132 A9 04                    ..
        sta     $0288                           ; 5134 8D 88 02                 ...
        lda     #$36                            ; 5137 A9 36                    .6
        sta     $01                             ; 5139 85 01                    ..
        lda     #$8A                            ; 513B A9 8A                    ..
        sta     $A001                           ; 513D 8D 01 A0                 ...
        lda     #$F8                            ; 5140 A9 F8                    ..
        sta     $A000                           ; 5142 8D 00 A0                 ...
        jmp     LFCF8                           ; 5145 4C F8 FC                 L..

; ----------------------------------------------------------------------------
        lda     #$37                            ; 5148 A9 37                    .7
        sta     $01                             ; 514A 85 01                    ..
        jsr     L8B42                           ; 514C 20 42 8B                  B.
        jsr     L8B45                           ; 514F 20 45 8B                  E.
        jsr     L8B48                           ; 5152 20 48 8B                  H.
        lda     #$8B                            ; 5155 A9 8B                    ..
        sta     $0319                           ; 5157 8D 19 03                 ...
        lda     #$4B                            ; 515A A9 4B                    .K
        sta     $0318                           ; 515C 8D 18 03                 ...
        lda     #$06                            ; 515F A9 06                    ..
        sta     $8BD3                           ; 5161 8D D3 8B                 ...
        lda     $DD0D                           ; 5164 AD 0D DD                 ...
        lda     #$FF                            ; 5167 A9 FF                    ..
        sta     $DD04                           ; 5169 8D 04 DD                 ...
        sta     $DD05                           ; 516C 8D 05 DD                 ...
        lda     #$81                            ; 516F A9 81                    ..
        sta     $DD0D                           ; 5171 8D 0D DD                 ...
        lda     $DD0E                           ; 5174 AD 0E DD                 ...
        and     #$80                            ; 5177 29 80                    ).
        ora     #$11                            ; 5179 09 11                    ..
        sta     $DD0E                           ; 517B 8D 0E DD                 ...
        lda     #$2F                            ; 517E A9 2F                    ./
        sta     $00                             ; 5180 85 00                    ..
        lda     #$E7                            ; 5182 A9 E7                    ..
        sta     $01                             ; 5184 85 01                    ..
        sta     $D07B                           ; 5186 8D 7B D0                 .{.
        lda     $8BDA                           ; 5189 AD DA 8B                 ...
        sta     $BA                             ; 518C 85 BA                    ..
        cli                                     ; 518E 58                       X
        jmp     LE39D                           ; 518F 4C 9D E3                 L..

; ----------------------------------------------------------------------------
        jmp     (LE395)                         ; 5192 6C 95 E3                 l..

; ----------------------------------------------------------------------------
        jmp     (LE398)                         ; 5195 6C 98 E3                 l..

; ----------------------------------------------------------------------------
        jmp     (LE39B)                         ; 5198 6C 9B E3                 l..

; ----------------------------------------------------------------------------
        pha                                     ; 519B 48                       H
        tya                                     ; 519C 98                       .
        pha                                     ; 519D 48                       H
        cld                                     ; 519E D8                       .
        lda     $DD0D                           ; 519F AD 0D DD                 ...
        dec     $8BD3                           ; 51A2 CE D3 8B                 ...
        bne     L51F7                           ; 51A5 D0 50                    .P
        lda     #$7F                            ; 51A7 A9 7F                    ..
        sta     $DD0D                           ; 51A9 8D 0D DD                 ...
        lda     #$FE                            ; 51AC A9 FE                    ..
        sta     $0319                           ; 51AE 8D 19 03                 ...
        lda     #$47                            ; 51B1 A9 47                    .G
        sta     $0318                           ; 51B3 8D 18 03                 ...
        ldy     #$03                            ; 51B6 A0 03                    ..
L51B8:  lda     $8BD4,y                         ; 51B8 B9 D4 8B                 ...
        sta     $0800,y                         ; 51BB 99 00 08                 ...
        dey                                     ; 51BE 88                       .
        bpl     L51B8                           ; 51BF 10 F7                    ..
        lda     $8BD9                           ; 51C1 AD D9 8B                 ...
        sta     $2E                             ; 51C4 85 2E                    ..
        lda     $8BD8                           ; 51C6 AD D8 8B                 ...
        sta     $2D                             ; 51C9 85 2D                    .-
        iny                                     ; 51CB C8                       .
L51CC:  lda     $8BAB,y                         ; 51CC B9 AB 8B                 ...
        beq     L51DD                           ; 51CF F0 0C                    ..
        sta     ($D1),y                         ; 51D1 91 D1                    ..
        lda     $0286                           ; 51D3 AD 86 02                 ...
        sta     ($F3),y                         ; 51D6 91 F3                    ..
        iny                                     ; 51D8 C8                       .
        cpy     #$28                            ; 51D9 C0 28                    .(
        bcc     L51CC                           ; 51DB 90 EF                    ..
L51DD:  tya                                     ; 51DD 98                       .
        beq     L51ED                           ; 51DE F0 0D                    ..
        lda     #$28                            ; 51E0 A9 28                    .(
        sta     $D3                             ; 51E2 85 D3                    ..
        lda     #$01                            ; 51E4 A9 01                    ..
        sta     $C6                             ; 51E6 85 C6                    ..
        lda     #$0D                            ; 51E8 A9 0D                    ..
        sta     $0277                           ; 51EA 8D 77 02                 .w.
L51ED:  lda     $F0D9                           ; 51ED AD D9 F0                 ...
        cmp     #$50                            ; 51F0 C9 50                    .P
        beq     L51F7                           ; 51F2 F0 03                    ..
        jsr     LE4B7                           ; 51F4 20 B7 E4                  ..
L51F7:  pla                                     ; 51F7 68                       h
        tay                                     ; 51F8 A8                       .
        pla                                     ; 51F9 68                       h
        rti                                     ; 51FA 40                       @

; ----------------------------------------------------------------------------
        brk                                     ; 51FB 00                       .
        brk                                     ; 51FC 00                       .
        brk                                     ; 51FD 00                       .
        brk                                     ; 51FE 00                       .
        brk                                     ; 51FF 00                       .
        brk                                     ; 5200 00                       .
        brk                                     ; 5201 00                       .
        brk                                     ; 5202 00                       .
        brk                                     ; 5203 00                       .
        brk                                     ; 5204 00                       .
        brk                                     ; 5205 00                       .
        brk                                     ; 5206 00                       .
        brk                                     ; 5207 00                       .
        brk                                     ; 5208 00                       .
        brk                                     ; 5209 00                       .
        brk                                     ; 520A 00                       .
        brk                                     ; 520B 00                       .
        brk                                     ; 520C 00                       .
        brk                                     ; 520D 00                       .
        brk                                     ; 520E 00                       .
        brk                                     ; 520F 00                       .
        brk                                     ; 5210 00                       .
        brk                                     ; 5211 00                       .
        brk                                     ; 5212 00                       .
        brk                                     ; 5213 00                       .
        brk                                     ; 5214 00                       .
        brk                                     ; 5215 00                       .
        brk                                     ; 5216 00                       .
        brk                                     ; 5217 00                       .
        brk                                     ; 5218 00                       .
        brk                                     ; 5219 00                       .
        brk                                     ; 521A 00                       .
        brk                                     ; 521B 00                       .
        brk                                     ; 521C 00                       .
        brk                                     ; 521D 00                       .
        brk                                     ; 521E 00                       .
        brk                                     ; 521F 00                       .
        brk                                     ; 5220 00                       .
        brk                                     ; 5221 00                       .
        brk                                     ; 5222 00                       .
        brk                                     ; 5223 00                       .
        brk                                     ; 5224 00                       .
        brk                                     ; 5225 00                       .
        brk                                     ; 5226 00                       .
        brk                                     ; 5227 00                       .
        brk                                     ; 5228 00                       .
        brk                                     ; 5229 00                       .
        brk                                     ; 522A 00                       .
