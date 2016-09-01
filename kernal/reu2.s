; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu2.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L080B           := $080B
L100B           := $100B
L2020           := $2020
L2061           := $2061
L3156           := $3156
L4000           := $4000
L4003           := $4003
L4553           := $4553
L616E           := $616E
L6220           := $6220
L6E65           := $6E65
L6F66           := $6F66
L7264           := $7264
L7265           := $7265
L9036           := $9036
L903C           := $903C
L903F           := $903F
L9048           := $9048
L9050           := $9050
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
LFF54           := $FF54
LFF93           := $FF93
LFF96           := $FF96
LFFA5           := $FFA5
LFFA8           := $FFA8
LFFAB           := $FFAB
LFFAE           := $FFAE
LFFB1           := $FFB1
LFFB4           := $FFB4
; ----------------------------------------------------------------------------
        jmp     L5032                           ; 5000 4C 32 50                 L2P

; ----------------------------------------------------------------------------
        jmp     L50CA                           ; 5003 4C CA 50                 L.P

; ----------------------------------------------------------------------------
        jmp     L5431                           ; 5006 4C 31 54                 L1T

; ----------------------------------------------------------------------------
        jmp     L5C04                           ; 5009 4C 04 5C                 L.\

; ----------------------------------------------------------------------------
        jmp     L5C13                           ; 500C 4C 13 5C                 L.\

; ----------------------------------------------------------------------------
L500F:  brk                                     ; 500F 00                       .
        brk                                     ; 5010 00                       .
        brk                                     ; 5011 00                       .
        brk                                     ; 5012 00                       .
        brk                                     ; 5013 00                       .
        brk                                     ; 5014 00                       .
        brk                                     ; 5015 00                       .
        brk                                     ; 5016 00                       .
        brk                                     ; 5017 00                       .
        brk                                     ; 5018 00                       .
        brk                                     ; 5019 00                       .
        brk                                     ; 501A 00                       .
        brk                                     ; 501B 00                       .
        brk                                     ; 501C 00                       .
        brk                                     ; 501D 00                       .
        brk                                     ; 501E 00                       .
        brk                                     ; 501F 00                       .
L5020:  jsr     LCFD9                           ; 5020 20 D9 CF                  ..
        jsr     L4000                           ; 5023 20 00 40                  .@
        jmp     LCFD9                           ; 5026 4C D9 CF                 L..

; ----------------------------------------------------------------------------
        jsr     LCFD9                           ; 5029 20 D9 CF                  ..
        jsr     L4003                           ; 502C 20 03 40                  .@
        jmp     LCFD9                           ; 502F 4C D9 CF                 L..

; ----------------------------------------------------------------------------
L5032:  lda     #$31                            ; 5032 A9 31                    .1
        sta     L50C9                           ; 5034 8D C9 50                 ..P
        jsr     L9036                           ; 5037 20 36 90                  6.
        txa                                     ; 503A 8A                       .
        bne     L5068                           ; 503B D0 2B                    .+
        bit     $848B                           ; 503D 2C 8B 84                 ,..
        bmi     L5068                           ; 5040 30 26                    0&
        lda     $88C6                           ; 5042 AD C6 88                 ...
        and     #$0F                            ; 5045 29 0F                    ).
        cmp     #$04                            ; 5047 C9 04                    ..
        bne     L5073                           ; 5049 D0 28                    .(
        lda     $8223                           ; 504B AD 23 82                 .#.
        sta     $05                             ; 504E 85 05                    ..
        lda     $8222                           ; 5050 AD 22 82                 .".
        sta     $04                             ; 5053 85 04                    ..
        beq     L5069                           ; 5055 F0 12                    ..
        jsr     L903C                           ; 5057 20 3C 90                  <.
        bne     L5068                           ; 505A D0 0C                    ..
        lda     $80AC                           ; 505C AD AC 80                 ...
        sta     $05                             ; 505F 85 05                    ..
        lda     $80AB                           ; 5061 AD AB 80                 ...
        sta     $04                             ; 5064 85 04                    ..
        bne     L50A2                           ; 5066 D0 3A                    .:
L5068:  rts                                     ; 5068 60                       `

; ----------------------------------------------------------------------------
L5069:  lda     #$01                            ; 5069 A9 01                    ..
        sta     $08                             ; 506B 85 08                    ..
        lda     #$FE                            ; 506D A9 FE                    ..
        sta     $09                             ; 506F 85 09                    ..
        bne     L508E                           ; 5071 D0 1B                    ..
L5073:  cmp     #$03                            ; 5073 C9 03                    ..
        beq     L5086                           ; 5075 F0 0F                    ..
        lda     #$30                            ; 5077 A9 30                    .0
        sta     L50C9                           ; 5079 8D C9 50                 ..P
        lda     #$13                            ; 507C A9 13                    ..
        sta     $08                             ; 507E 85 08                    ..
        lda     #$0B                            ; 5080 A9 0B                    ..
        sta     $09                             ; 5082 85 09                    ..
        bne     L508E                           ; 5084 D0 08                    ..
L5086:  lda     #$29                            ; 5086 A9 29                    .)
        sta     $08                             ; 5088 85 08                    ..
        lda     #$13                            ; 508A A9 13                    ..
        sta     $09                             ; 508C 85 09                    ..
L508E:  jsr     SetNextFree                     ; 508E 20 92 C2                  ..
        txa                                     ; 5091 8A                       .
        bne     L5068                           ; 5092 D0 D4                    ..
        lda     $09                             ; 5094 A5 09                    ..
        sta     $05                             ; 5096 85 05                    ..
        lda     $08                             ; 5098 A5 08                    ..
        sta     $04                             ; 509A 85 04                    ..
        jsr     L5CB4                           ; 509C 20 B4 5C                  .\
        txa                                     ; 509F 8A                       .
        bne     L5068                           ; 50A0 D0 C6                    ..
L50A2:  lda     $05                             ; 50A2 A5 05                    ..
        sta     $82AC                           ; 50A4 8D AC 82                 ...
        lda     $04                             ; 50A7 A5 04                    ..
        sta     $82AB                           ; 50A9 8D AB 82                 ...
        ldy     #$0F                            ; 50AC A0 0F                    ..
L50AE:  lda     L50BA,y                         ; 50AE B9 BA 50                 ..P
        sta     $82AD,y                         ; 50B1 99 AD 82                 ...
        dey                                     ; 50B4 88                       .
        bpl     L50AE                           ; 50B5 10 F7                    ..
        jmp     PutDirHead                      ; 50B7 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L50BA:  .byte   $47                             ; 50BA 47                       G
        eor     $4F                             ; 50BB 45 4F                    EO
        .byte   $53                             ; 50BD 53                       S
        jsr     L6F66                           ; 50BE 20 66 6F                  fo
        .byte   $72                             ; 50C1 72                       r
        adc     $7461                           ; 50C2 6D 61 74                 mat
        jsr     L3156                           ; 50C5 20 56 31                  V1
        .byte   $2E                             ; 50C8 2E                       .
L50C9:  .byte   $30                             ; 50C9 30                       0
L50CA:  jsr     L50FD                           ; 50CA 20 FD 50                  .P
        jsr     L516B                           ; 50CD 20 6B 51                  kQ
        jsr     L50D7                           ; 50D0 20 D7 50                  .P
        ldx     L5430                           ; 50D3 AE 30 54                 .0T
        rts                                     ; 50D6 60                       `

; ----------------------------------------------------------------------------
L50D7:  lda     L516A                           ; 50D7 AD 6A 51                 .jQ
        sta     $84B2                           ; 50DA 8D B2 84                 ...
        lda     L5169                           ; 50DD AD 69 51                 .iQ
        sta     $84B1                           ; 50E0 8D B1 84                 ...
        lda     L5168                           ; 50E3 AD 68 51                 .hQ
        sta     $44                             ; 50E6 85 44                    .D
        lda     L5167                           ; 50E8 AD 67 51                 .gQ
        sta     $43                             ; 50EB 85 43                    .C
        jsr     L514A                           ; 50ED 20 4A 51                  JQ
        jsr     FetchRAM                        ; 50F0 20 CB C2                  ..
        jsr     L512D                           ; 50F3 20 2D 51                  -Q
        jsr     FetchRAM                        ; 50F6 20 CB C2                  ..
        ldx     L5430                           ; 50F9 AE 30 54                 .0T
        rts                                     ; 50FC 60                       `

; ----------------------------------------------------------------------------
L50FD:  jsr     L512D                           ; 50FD 20 2D 51                  -Q
        jsr     StashRAM                        ; 5100 20 C8 C2                  ..
        jsr     L514A                           ; 5103 20 4A 51                  JQ
        jsr     StashRAM                        ; 5106 20 C8 C2                  ..
        jsr     L5020                           ; 5109 20 20 50                   P
        lda     $44                             ; 510C A5 44                    .D
        sta     L5168                           ; 510E 8D 68 51                 .hQ
        lda     $43                             ; 5111 A5 43                    .C
        sta     L5167                           ; 5113 8D 67 51                 .gQ
        lda     $84B2                           ; 5116 AD B2 84                 ...
        sta     L516A                           ; 5119 8D 6A 51                 .jQ
        lda     $84B1                           ; 511C AD B1 84                 ...
        sta     L5169                           ; 511F 8D 69 51                 .iQ
        lda     #$50                            ; 5122 A9 50                    .P
        sta     $84B2                           ; 5124 8D B2 84                 ...
        lda     #$29                            ; 5127 A9 29                    .)
        sta     $84B1                           ; 5129 8D B1 84                 ...
        rts                                     ; 512C 60                       `

; ----------------------------------------------------------------------------
L512D:  lda     #$85                            ; 512D A9 85                    ..
        sta     $03                             ; 512F 85 03                    ..
        lda     #$1F                            ; 5131 A9 1F                    ..
        sta     $02                             ; 5133 85 02                    ..
        lda     #$B9                            ; 5135 A9 B9                    ..
        sta     $05                             ; 5137 85 05                    ..
        lda     #$00                            ; 5139 A9 00                    ..
        sta     $04                             ; 513B 85 04                    ..
        lda     #$01                            ; 513D A9 01                    ..
        sta     $07                             ; 513F 85 07                    ..
        lda     #$7A                            ; 5141 A9 7A                    .z
        sta     $06                             ; 5143 85 06                    ..
        lda     #$00                            ; 5145 A9 00                    ..
        sta     $08                             ; 5147 85 08                    ..
        rts                                     ; 5149 60                       `

; ----------------------------------------------------------------------------
L514A:  lda     #$88                            ; 514A A9 88                    ..
        sta     $03                             ; 514C 85 03                    ..
        lda     #$0C                            ; 514E A9 0C                    ..
        sta     $02                             ; 5150 85 02                    ..
        lda     #$BA                            ; 5152 A9 BA                    ..
        sta     $05                             ; 5154 85 05                    ..
        lda     #$7A                            ; 5156 A9 7A                    .z
        sta     $04                             ; 5158 85 04                    ..
        lda     #$00                            ; 515A A9 00                    ..
        sta     $07                             ; 515C 85 07                    ..
        lda     #$51                            ; 515E A9 51                    .Q
        sta     $06                             ; 5160 85 06                    ..
        lda     #$00                            ; 5162 A9 00                    ..
        sta     $08                             ; 5164 85 08                    ..
        rts                                     ; 5166 60                       `

; ----------------------------------------------------------------------------
L5167:  brk                                     ; 5167 00                       .
L5168:  brk                                     ; 5168 00                       .
L5169:  brk                                     ; 5169 00                       .
L516A:  brk                                     ; 516A 00                       .
L516B:  lda     $88C6                           ; 516B AD C6 88                 ...
        cmp     #$02                            ; 516E C9 02                    ..
        bne     L5175                           ; 5170 D0 03                    ..
        lda     #$12                            ; 5172 A9 12                    ..
        .byte   $2C                             ; 5174 2C                       ,
L5175:  lda     #$00                            ; 5175 A9 00                    ..
        sta     L51F9                           ; 5177 8D F9 51                 ..Q
        lda     #$00                            ; 517A A9 00                    ..
        sta     L500F                           ; 517C 8D 0F 50                 ..P
        lda     #$51                            ; 517F A9 51                    .Q
        sta     $03                             ; 5181 85 03                    ..
        lda     #$E2                            ; 5183 A9 E2                    ..
        sta     $02                             ; 5185 85 02                    ..
        lda     #$50                            ; 5187 A9 50                    .P
        sta     $0D                             ; 5189 85 0D                    ..
        lda     #$0F                            ; 518B A9 0F                    ..
        sta     $0C                             ; 518D 85 0C                    ..
        jsr     DoDlgBox                        ; 518F 20 56 C2                  V.
        lda     $02                             ; 5192 A5 02                    ..
        cmp     #$02                            ; 5194 C9 02                    ..
        beq     L51D8                           ; 5196 F0 40                    .@
        lda     L500F                           ; 5198 AD 0F 50                 ..P
        beq     L51D8                           ; 519B F0 3B                    .;
        ldx     #$00                            ; 519D A2 00                    ..
L519F:  lda     L51DE,x                         ; 519F BD DE 51                 ..Q
        sta     L53D1                           ; 51A2 8D D1 53                 ..S
        lda     L51E0,x                         ; 51A5 BD E0 51                 ..Q
        sta     L53D2                           ; 51A8 8D D2 53                 ..S
        jsr     L5242                           ; 51AB 20 42 52                  BR
        lda     #$52                            ; 51AE A9 52                    .R
        sta     $03                             ; 51B0 85 03                    ..
        lda     #$0E                            ; 51B2 A9 0E                    ..
        sta     $02                             ; 51B4 85 02                    ..
        jsr     DoDlgBox                        ; 51B6 20 56 C2                  V.
        lda     $02                             ; 51B9 A5 02                    ..
        cmp     #$04                            ; 51BB C9 04                    ..
        beq     L51D8                           ; 51BD F0 19                    ..
        lda     #$53                            ; 51BF A9 53                    .S
        sta     L53D7                           ; 51C1 8D D7 53                 ..S
        lda     #$ED                            ; 51C4 A9 ED                    ..
        sta     L53D6                           ; 51C6 8D D6 53                 ..S
        lda     #$53                            ; 51C9 A9 53                    .S
        sta     $03                             ; 51CB 85 03                    ..
        lda     #$C1                            ; 51CD A9 C1                    ..
        sta     $02                             ; 51CF 85 02                    ..
        jsr     DoDlgBox                        ; 51D1 20 56 C2                  V.
        ldx     L5430                           ; 51D4 AE 30 54                 .0T
        rts                                     ; 51D7 60                       `

; ----------------------------------------------------------------------------
L51D8:  ldx     #$0C                            ; 51D8 A2 0C                    ..
        stx     L5430                           ; 51DA 8E 30 54                 .0T
        rts                                     ; 51DD 60                       `

; ----------------------------------------------------------------------------
L51DE:  .byte   $1C                             ; 51DE 1C                       .
        .byte   $13                             ; 51DF 13                       .
L51E0:  .byte   $54                             ; 51E0 54                       T
        .byte   $5C                             ; 51E1 5C                       \
        brk                                     ; 51E2 00                       .
        plp                                     ; 51E3 28                       (
        .byte   $5F                             ; 51E4 5F                       _
        sec                                     ; 51E5 38                       8
        brk                                     ; 51E6 00                       .
        .byte   $07                             ; 51E7 07                       .
        ora     ($13,x)                         ; 51E8 01 13                    ..
        and     #$52                            ; 51EA 29 52                    )R
        .byte   $02                             ; 51EC 02                       .
        .byte   $13                             ; 51ED 13                       .
        jsr     L100B                           ; 51EE 20 0B 10                  ..
        asl     L52BB                           ; 51F1 0E BB 52                 ..R
        ora     $1818                           ; 51F4 0D 18 18                 ...
        .byte   $0C                             ; 51F7 0C                       .
        .byte   $10                             ; 51F8 10                       .
L51F9:  .byte   $12                             ; 51F9 12                       .
        .byte   $13                             ; 51FA 13                       .
        php                                     ; 51FB 08                       .
        lda     ($53,x)                         ; 51FC A1 53                    .S
        .byte   $0B                             ; 51FE 0B                       .
        ldx     $0F                             ; 51FF A6 0F                    ..
        .byte   $12                             ; 5201 12                       .
        .byte   $53                             ; 5202 53                       S
        .byte   $12                             ; 5203 12                       .
        .byte   $13                             ; 5204 13                       .
        .byte   $14                             ; 5205 14                       .
        lda     #$53                            ; 5206 A9 53                    .S
        .byte   $0B                             ; 5208 0B                       .
        ldx     $1B                             ; 5209 A6 1B                    ..
        .byte   $1A                             ; 520B 1A                       .
        .byte   $53                             ; 520C 53                       S
        brk                                     ; 520D 00                       .
        brk                                     ; 520E 00                       .
        plp                                     ; 520F 28                       (
        .byte   $5F                             ; 5210 5F                       _
        sec                                     ; 5211 38                       8
        brk                                     ; 5212 00                       .
        .byte   $07                             ; 5213 07                       .
        ora     ($13,x)                         ; 5214 01 13                    ..
        and     #$52                            ; 5216 29 52                    )R
        .byte   $03                             ; 5218 03                       .
        ora     ($20,x)                         ; 5219 01 20                    . 
        .byte   $04                             ; 521B 04                       .
        .byte   $13                             ; 521C 13                       .
        jsr     L080B                           ; 521D 20 0B 08                  ..
        asl     L52D2                           ; 5220 0E D2 52                 ..R
        .byte   $0B                             ; 5223 0B                       .
        .byte   $14                             ; 5224 14                       .
        clc                                     ; 5225 18                       .
L5226:  .byte   $F2                             ; 5226 F2                       .
L5227:  .byte   $52                             ; 5227 52                       R
        brk                                     ; 5228 00                       .
        lda     $9FE1                           ; 5229 AD E1 9F                 ...
        sta     L5236                           ; 522C 8D 36 52                 .6R
        jsr     LC316                           ; 522F 20 16 C3                  ..
        .byte   $07                             ; 5232 07                       .
        ora     $1A                             ; 5233 05 1A                    ..
        .byte   $07                             ; 5235 07                       .
L5236:  .byte   $B3                             ; 5236 B3                       .
        jsr     i_FrameRectangle                ; 5237 20 A2 C1                  ..
        rol     a                               ; 523A 2A                       *
        lsr     a:$3A,x                         ; 523B 5E 3A 00                 ^:.
        asl     $01                             ; 523E 06 01                    ..
        .byte   $FF                             ; 5240 FF                       .
        rts                                     ; 5241 60                       `

; ----------------------------------------------------------------------------
L5242:  ldy     #$02                            ; 5242 A0 02                    ..
        lda     #$20                            ; 5244 A9 20                    . 
L5246:  sta     L52FD,y                         ; 5246 99 FD 52                 ..R
        dey                                     ; 5249 88                       .
        bpl     L5246                           ; 524A 10 FA                    ..
        lda     $8489                           ; 524C AD 89 84                 ...
        clc                                     ; 524F 18                       .
        adc     #$39                            ; 5250 69 39                    i9
        sta     L52EE                           ; 5252 8D EE 52                 ..R
        lda     #$53                            ; 5255 A9 53                    .S
        sta     L5227                           ; 5257 8D 27 52                 .'R
        lda     #$03                            ; 525A A9 03                    ..
        sta     L5226                           ; 525C 8D 26 52                 .&R
        jsr     L5562                           ; 525F 20 62 55                  bU
        beq     L5271                           ; 5262 F0 0D                    ..
        lda     $88C6                           ; 5264 AD C6 88                 ...
        cmp     #$83                            ; 5267 C9 83                    ..
        bne     L5270                           ; 5269 D0 05                    ..
        bit     $9073                           ; 526B 2C 73 90                 ,s.
        bmi     L5271                           ; 526E 30 01                    0.
L5270:  rts                                     ; 5270 60                       `

; ----------------------------------------------------------------------------
L5271:  lda     #$52                            ; 5271 A9 52                    .R
        sta     L5227                           ; 5273 8D 27 52                 .'R
        lda     #$F2                            ; 5276 A9 F2                    ..
        sta     L5226                           ; 5278 8D 26 52                 .&R
        jsr     L9063                           ; 527B 20 63 90                  c.
        lda     $06                             ; 527E A5 06                    ..
        ldx     #$30                            ; 5280 A2 30                    .0
        ldy     #$00                            ; 5282 A0 00                    ..
L5284:  cmp     #$64                            ; 5284 C9 64                    .d
        bcc     L528E                           ; 5286 90 06                    ..
        sec                                     ; 5288 38                       8
        sbc     #$64                            ; 5289 E9 64                    .d
        inx                                     ; 528B E8                       .
        bne     L5284                           ; 528C D0 F6                    ..
L528E:  cpx     #$30                            ; 528E E0 30                    .0
        beq     L529B                           ; 5290 F0 09                    ..
        pha                                     ; 5292 48                       H
        txa                                     ; 5293 8A                       .
        sta     L52FD,y                         ; 5294 99 FD 52                 ..R
        pla                                     ; 5297 68                       h
        iny                                     ; 5298 C8                       .
        ldx     #$30                            ; 5299 A2 30                    .0
L529B:  cmp     #$0A                            ; 529B C9 0A                    ..
        bcc     L52A5                           ; 529D 90 06                    ..
        sec                                     ; 529F 38                       8
        sbc     #$0A                            ; 52A0 E9 0A                    ..
        inx                                     ; 52A2 E8                       .
        bne     L529B                           ; 52A3 D0 F6                    ..
L52A5:  cpx     #$30                            ; 52A5 E0 30                    .0
        bne     L52AD                           ; 52A7 D0 04                    ..
        cpy     #$00                            ; 52A9 C0 00                    ..
        beq     L52B4                           ; 52AB F0 07                    ..
L52AD:  pha                                     ; 52AD 48                       H
        txa                                     ; 52AE 8A                       .
        sta     L52FD,y                         ; 52AF 99 FD 52                 ..R
        pla                                     ; 52B2 68                       h
        iny                                     ; 52B3 C8                       .
L52B4:  clc                                     ; 52B4 18                       .
        adc     #$30                            ; 52B5 69 30                    i0
        sta     L52FD,y                         ; 52B7 99 FD 52                 ..R
        rts                                     ; 52BA 60                       `

; ----------------------------------------------------------------------------
L52BB:  clc                                     ; 52BB 18                       .
        eor     $6E                             ; 52BC 45 6E                    En
        .byte   $74                             ; 52BE 74                       t
        adc     $72                             ; 52BF 65 72                    er
        jsr     L2061                           ; 52C1 20 61 20                  a 
        .byte   $64                             ; 52C4 64                       d
        adc     #$73                            ; 52C5 69 73                    is
        .byte   $6B                             ; 52C7 6B                       k
        jsr     L616E                           ; 52C8 20 6E 61                  na
        adc     $2E65                           ; 52CB 6D 65 2E                 me.
        rol     $1B2E                           ; 52CE 2E 2E 1B                 ...
        brk                                     ; 52D1 00                       .
L52D2:  clc                                     ; 52D2 18                       .
        .byte   $4F                             ; 52D3 4F                       O
        bvs     L533B                           ; 52D4 70 65                    pe
        .byte   $72                             ; 52D6 72                       r
        adc     ($74,x)                         ; 52D7 61 74                    at
        adc     #$6F                            ; 52D9 69 6F                    io
        ror     $7720                           ; 52DB 6E 20 77                 n w
        adc     #$6C                            ; 52DE 69 6C                    il
        jmp     (L6220)                         ; 52E0 6C 20 62                 l b

; ----------------------------------------------------------------------------
        adc     $20                             ; 52E3 65 20                    e 
        .byte   $74                             ; 52E5 74                       t
        .byte   $6F                             ; 52E6 6F                       o
        jsr     L7264                           ; 52E7 20 64 72                  dr
        adc     #$76                            ; 52EA 69 76                    iv
        adc     $20                             ; 52EC 65 20                    e 
L52EE:  eor     ($2C,x)                         ; 52EE 41 2C                    A,
        .byte   $1B                             ; 52F0 1B                       .
        brk                                     ; 52F1 00                       .
        clc                                     ; 52F2 18                       .
        bvc     L5356                           ; 52F3 50 61                    Pa
        .byte   $72                             ; 52F5 72                       r
        .byte   $74                             ; 52F6 74                       t
        adc     #$74                            ; 52F7 69 74                    it
        adc     #$6F                            ; 52F9 69 6F                    io
        .byte   $6E                             ; 52FB 6E                       n
        .byte   $20                             ; 52FC 20                        
L52FD:  jsr     L2020                           ; 52FD 20 20 20                    
        jsr     L2020                           ; 5300 20 20 20                    
        clc                                     ; 5303 18                       .
        rol     $2E2E                           ; 5304 2E 2E 2E                 ...
        .byte   $43                             ; 5307 43                       C
        .byte   $6F                             ; 5308 6F                       o
        ror     $6974                           ; 5309 6E 74 69                 nti
        ror     $6575                           ; 530C 6E 75 65                 nue
        .byte   $3F                             ; 530F 3F                       ?
        .byte   $1B                             ; 5310 1B                       .
        brk                                     ; 5311 00                       .
        and     ($2D),y                         ; 5312 31 2D                    1-
        .byte   $73                             ; 5314 73                       s
        adc     #$64                            ; 5315 69 64                    id
        adc     $64                             ; 5317 65 64                    ed
        brk                                     ; 5319 00                       .
        .byte   $32                             ; 531A 32                       2
        and     $6973                           ; 531B 2D 73 69                 -si
        .byte   $64                             ; 531E 64                       d
        adc     $64                             ; 531F 65 64                    ed
        brk                                     ; 5321 00                       .
        ldx     L571C                           ; 5322 AE 1C 57                 ..W
        cpx     #$29                            ; 5325 E0 29                    .)
        bne     L532A                           ; 5327 D0 01                    ..
        rts                                     ; 5329 60                       `

; ----------------------------------------------------------------------------
L532A:  lda     #$29                            ; 532A A9 29                    .)
        sta     L571C                           ; 532C 8D 1C 57                 ..W
        lda     #$53                            ; 532F A9 53                    .S
        sta     L53A2                           ; 5331 8D A2 53                 ..S
        lda     #$B1                            ; 5334 A9 B1                    ..
        sta     L53A1                           ; 5336 8D A1 53                 ..S
        lda     #$53                            ; 5339 A9 53                    .S
L533B:  sta     L53AA                           ; 533B 8D AA 53                 ..S
        lda     #$BB                            ; 533E A9 BB                    ..
        sta     L53A9                           ; 5340 8D A9 53                 ..S
        jmp     L5367                           ; 5343 4C 67 53                 LgS

; ----------------------------------------------------------------------------
        ldx     L571C                           ; 5346 AE 1C 57                 ..W
        cpx     #$29                            ; 5349 E0 29                    .)
        beq     L534E                           ; 534B F0 01                    ..
        rts                                     ; 534D 60                       `

; ----------------------------------------------------------------------------
L534E:  lda     #$00                            ; 534E A9 00                    ..
        sta     L571C                           ; 5350 8D 1C 57                 ..W
        lda     #$53                            ; 5353 A9 53                    .S
        .byte   $8D                             ; 5355 8D                       .
L5356:  tax                                     ; 5356 AA                       .
        .byte   $53                             ; 5357 53                       S
        lda     #$B1                            ; 5358 A9 B1                    ..
        sta     L53A9                           ; 535A 8D A9 53                 ..S
        lda     #$53                            ; 535D A9 53                    .S
        sta     L53A2                           ; 535F 8D A2 53                 ..S
        lda     #$BB                            ; 5362 A9 BB                    ..
        sta     L53A1                           ; 5364 8D A1 53                 ..S
L5367:  lda     L53A2                           ; 5367 AD A2 53                 ..S
        sta     $03                             ; 536A 85 03                    ..
        lda     L53A1                           ; 536C AD A1 53                 ..S
        sta     $02                             ; 536F 85 02                    ..
        lda     #$1A                            ; 5371 A9 1A                    ..
        sta     $04                             ; 5373 85 04                    ..
        lda     #$30                            ; 5375 A9 30                    .0
        sta     $05                             ; 5377 85 05                    ..
        lda     #$01                            ; 5379 A9 01                    ..
        sta     $06                             ; 537B 85 06                    ..
        lda     #$08                            ; 537D A9 08                    ..
        sta     $07                             ; 537F 85 07                    ..
        jsr     BitmapUp                        ; 5381 20 42 C1                  B.
        lda     L53AA                           ; 5384 AD AA 53                 ..S
        sta     $03                             ; 5387 85 03                    ..
        lda     L53A9                           ; 5389 AD A9 53                 ..S
        sta     $02                             ; 538C 85 02                    ..
        lda     #$1A                            ; 538E A9 1A                    ..
        sta     $04                             ; 5390 85 04                    ..
        lda     #$3C                            ; 5392 A9 3C                    .<
        sta     $05                             ; 5394 85 05                    ..
        lda     #$01                            ; 5396 A9 01                    ..
        sta     $06                             ; 5398 85 06                    ..
        lda     #$08                            ; 539A A9 08                    ..
        sta     $07                             ; 539C 85 07                    ..
        jmp     BitmapUp                        ; 539E 4C 42 C1                 LB.

; ----------------------------------------------------------------------------
L53A1:  .byte   $BB                             ; 53A1 BB                       .
L53A2:  .byte   $53                             ; 53A2 53                       S
        brk                                     ; 53A3 00                       .
        brk                                     ; 53A4 00                       .
        ora     ($08,x)                         ; 53A5 01 08                    ..
        .byte   $22                             ; 53A7 22                       "
        .byte   $53                             ; 53A8 53                       S
L53A9:  .byte   $B1                             ; 53A9 B1                       .
L53AA:  .byte   $53                             ; 53AA 53                       S
        brk                                     ; 53AB 00                       .
        brk                                     ; 53AC 00                       .
        ora     ($08,x)                         ; 53AD 01 08                    ..
        lsr     $53                             ; 53AF 46 53                    FS
        .byte   $89                             ; 53B1 89                       .
        ror     $8181,x                         ; 53B2 7E 81 81                 ~..
        sta     $8199,y                         ; 53B5 99 99 81                 ...
        sta     ($7E,x)                         ; 53B8 81 7E                    .~
        .byte   $BF                             ; 53BA BF                       .
        sta     ($7E,x)                         ; 53BB 81 7E                    .~
        asl     $81                             ; 53BD 06 81                    ..
        sta     ($7E,x)                         ; 53BF 81 7E                    .~
        brk                                     ; 53C1 00                       .
        plp                                     ; 53C2 28                       (
        .byte   $5F                             ; 53C3 5F                       _
        sec                                     ; 53C4 38                       8
        brk                                     ; 53C5 00                       .
        .byte   $07                             ; 53C6 07                       .
        ora     ($13,x)                         ; 53C7 01 13                    ..
        and     #$52                            ; 53C9 29 52                    )R
        .byte   $0B                             ; 53CB 0B                       .
        php                                     ; 53CC 08                       .
        asl     L53DC                           ; 53CD 0E DC 53                 ..S
        .byte   $13                             ; 53D0 13                       .
L53D1:  .byte   $1C                             ; 53D1 1C                       .
L53D2:  .byte   $54                             ; 53D2 54                       T
        .byte   $0B                             ; 53D3 0B                       .
        php                                     ; 53D4 08                       .
        clc                                     ; 53D5 18                       .
L53D6:  .byte   $ED                             ; 53D6 ED                       .
L53D7:  .byte   $53                             ; 53D7 53                       S
        ora     ($13,x)                         ; 53D8 01 13                    ..
        .byte   $20                             ; 53DA 20                        
        brk                                     ; 53DB 00                       .
L53DC:  clc                                     ; 53DC 18                       .
        bvc     L544B                           ; 53DD 50 6C                    Pl
        adc     $61                             ; 53DF 65 61                    ea
        .byte   $73                             ; 53E1 73                       s
        .byte   $65                             ; 53E2 65                       e
L53E3:  jsr     $6157                           ; 53E3 20 57 61                  Wa
        adc     #$74                            ; 53E6 69 74                    it
        rol     $2E2E                           ; 53E8 2E 2E 2E                 ...
        .byte   $1B                             ; 53EB 1B                       .
        brk                                     ; 53EC 00                       .
        clc                                     ; 53ED 18                       .
        .byte   $4F                             ; 53EE 4F                       O
        bvs     L5456                           ; 53EF 70 65                    pe
        .byte   $72                             ; 53F1 72                       r
        adc     ($74,x)                         ; 53F2 61 74                    at
        adc     #$6F                            ; 53F4 69 6F                    io
        ror     $6320                           ; 53F6 6E 20 63                 n c
        .byte   $6F                             ; 53F9 6F                       o
        adc     $6C70                           ; 53FA 6D 70 6C                 mpl
        adc     $74                             ; 53FD 65 74                    et
        adc     $64                             ; 53FF 65 64                    ed
        .byte   $1B                             ; 5401 1B                       .
        brk                                     ; 5402 00                       .
        clc                                     ; 5403 18                       .
        .byte   $44                             ; 5404 44                       D
        adc     #$73                            ; 5405 69 73                    is
        .byte   $6B                             ; 5407 6B                       k
        jsr     L7265                           ; 5408 20 65 72                  er
        .byte   $72                             ; 540B 72                       r
        .byte   $6F                             ; 540C 6F                       o
        .byte   $72                             ; 540D 72                       r
        jsr     L6E65                           ; 540E 20 65 6E                  en
        .byte   $63                             ; 5411 63                       c
        .byte   $6F                             ; 5412 6F                       o
        adc     $6E,x                           ; 5413 75 6E                    un
        .byte   $74                             ; 5415 74                       t
        adc     $72                             ; 5416 65 72                    er
        adc     $64                             ; 5418 65 64                    ed
L541A:  .byte   $1B                             ; 541A 1B                       .
        brk                                     ; 541B 00                       .
        jsr     L5445                           ; 541C 20 45 54                  ET
        txa                                     ; 541F 8A                       .
        sta     L5430                           ; 5420 8D 30 54                 .0T
        beq     L542F                           ; 5423 F0 0A                    ..
        lda     #$54                            ; 5425 A9 54                    .T
        sta     L53D7                           ; 5427 8D D7 53                 ..S
        lda     #$03                            ; 542A A9 03                    ..
        sta     L53D6                           ; 542C 8D D6 53                 ..S
L542F:  rts                                     ; 542F 60                       `

; ----------------------------------------------------------------------------
L5430:  brk                                     ; 5430 00                       .
L5431:  stx     L571C                           ; 5431 8E 1C 57                 ..W
        lda     #$50                            ; 5434 A9 50                    .P
        sta     $05                             ; 5436 85 05                    ..
        lda     #$0F                            ; 5438 A9 0F                    ..
        sta     $04                             ; 543A 85 04                    ..
        ldx     #$02                            ; 543C A2 02                    ..
        ldy     #$04                            ; 543E A0 04                    ..
        lda     #$10                            ; 5440 A9 10                    ..
        jsr     CopyFString                     ; 5442 20 68 C2                  h.
L5445:  jsr     L9050                           ; 5445 20 50 90                  P.
        lda     #$00                            ; 5448 A9 00                    ..
        .byte   $8D                             ; 544A 8D                       .
L544B:  .byte   $27                             ; 544B 27                       '
        lsr     $AD,x                           ; 544C 56 AD                    V.
        .byte   $4F                             ; 544E 4F                       O
        bcc     L541A                           ; 544F 90 C9                    ..
        bvc     L53E3                           ; 5451 50 90                    P.
L5453:  rol     $AD,x                           ; 5453 36 AD                    6.
        .byte   $C6                             ; 5455 C6                       .
L5456:  dey                                     ; 5456 88                       .
        and     #$0F                            ; 5457 29 0F                    ).
        sta     L548D                           ; 5459 8D 8D 54                 ..T
        lda     $88C6                           ; 545C AD C6 88                 ...
        bpl     L5464                           ; 545F 10 03                    ..
        jmp     L54D4                           ; 5461 4C D4 54                 L.T

; ----------------------------------------------------------------------------
L5464:  cmp     #$04                            ; 5464 C9 04                    ..
        bne     L546B                           ; 5466 D0 03                    ..
        jmp     L5875                           ; 5468 4C 75 58                 LuX

; ----------------------------------------------------------------------------
L546B:  lda     L548D                           ; 546B AD 8D 54                 ..T
        cmp     #$04                            ; 546E C9 04                    ..
        bne     L5475                           ; 5470 D0 03                    ..
        jmp     L57DC                           ; 5472 4C DC 57                 L.W

; ----------------------------------------------------------------------------
L5475:  cmp     #$03                            ; 5475 C9 03                    ..
        bne     L547C                           ; 5477 D0 03                    ..
        jmp     L5632                           ; 5479 4C 32 56                 L2V

; ----------------------------------------------------------------------------
L547C:  cmp     #$02                            ; 547C C9 02                    ..
        bne     L5483                           ; 547E D0 03                    ..
        jmp     L56E4                           ; 5480 4C E4 56                 L.V

; ----------------------------------------------------------------------------
L5483:  cmp     #$01                            ; 5483 C9 01                    ..
        bne     L548A                           ; 5485 D0 03                    ..
        jmp     L57E2                           ; 5487 4C E2 57                 L.W

; ----------------------------------------------------------------------------
L548A:  ldx     #$0D                            ; 548A A2 0D                    ..
        rts                                     ; 548C 60                       `

; ----------------------------------------------------------------------------
L548D:  brk                                     ; 548D 00                       .
L548E:  jsr     L9050                           ; 548E 20 50 90                  P.
        txa                                     ; 5491 8A                       .
        bne     L5498                           ; 5492 D0 04                    ..
        jsr     L5032                           ; 5494 20 32 50                  2P
        txa                                     ; 5497 8A                       .
L5498:  pha                                     ; 5498 48                       H
        jsr     ExitTurbo                       ; 5499 20 32 C2                  2.
        pla                                     ; 549C 68                       h
        tax                                     ; 549D AA                       .
        rts                                     ; 549E 60                       `

; ----------------------------------------------------------------------------
L549F:  lda     $850A                           ; 549F AD 0A 85                 ...
        jsr     L54B4                           ; 54A2 20 B4 54                  .T
        sta     L54B2                           ; 54A5 8D B2 54                 ..T
        lda     $850B                           ; 54A8 AD 0B 85                 ...
        jsr     L54B4                           ; 54AB 20 B4 54                  .T
        sta     L54B3                           ; 54AE 8D B3 54                 ..T
        rts                                     ; 54B1 60                       `

; ----------------------------------------------------------------------------
L54B2:  .byte   $4D                             ; 54B2 4D                       M
L54B3:  .byte   $52                             ; 54B3 52                       R
L54B4:  and     #$7F                            ; 54B4 29 7F                    ).
        cmp     #$5B                            ; 54B6 C9 5B                    .[
        bcc     L54BD                           ; 54B8 90 03                    ..
        sec                                     ; 54BA 38                       8
        sbc     #$20                            ; 54BB E9 20                    . 
L54BD:  cmp     #$41                            ; 54BD C9 41                    .A
        bcs     L54D3                           ; 54BF B0 12                    ..
L54C1:  cmp     #$3A                            ; 54C1 C9 3A                    .:
        bcc     L54CA                           ; 54C3 90 05                    ..
        sec                                     ; 54C5 38                       8
        sbc     #$03                            ; 54C6 E9 03                    ..
        bcs     L54C1                           ; 54C8 B0 F7                    ..
L54CA:  cmp     #$30                            ; 54CA C9 30                    .0
        bcs     L54D3                           ; 54CC B0 05                    ..
        clc                                     ; 54CE 18                       .
        adc     #$03                            ; 54CF 69 03                    i.
        bcc     L54CA                           ; 54D1 90 F7                    ..
L54D3:  rts                                     ; 54D3 60                       `

; ----------------------------------------------------------------------------
L54D4:  lda     L548D                           ; 54D4 AD 8D 54                 ..T
        cmp     #$04                            ; 54D7 C9 04                    ..
        bne     L54DE                           ; 54D9 D0 03                    ..
        jmp     L54F6                           ; 54DB 4C F6 54                 L.T

; ----------------------------------------------------------------------------
L54DE:  cmp     #$03                            ; 54DE C9 03                    ..
        bne     L54E5                           ; 54E0 D0 03                    ..
        jmp     L5508                           ; 54E2 4C 08 55                 L.U

; ----------------------------------------------------------------------------
L54E5:  cmp     #$02                            ; 54E5 C9 02                    ..
        bne     L54EC                           ; 54E7 D0 03                    ..
        jmp     L5513                           ; 54E9 4C 13 55                 L.U

; ----------------------------------------------------------------------------
L54EC:  cmp     #$01                            ; 54EC C9 01                    ..
        bne     L54F3                           ; 54EE D0 03                    ..
        jmp     L551C                           ; 54F0 4C 1C 55                 L.U

; ----------------------------------------------------------------------------
L54F3:  ldx     #$0D                            ; 54F3 A2 0D                    ..
        rts                                     ; 54F5 60                       `

; ----------------------------------------------------------------------------
L54F6:  jsr     L549F                           ; 54F6 20 9F 54                  .T
        lda     $9062                           ; 54F9 AD 62 90                 .b.
        sta     L5DAD                           ; 54FC 8D AD 5D                 ..]
        sta     L594A                           ; 54FF 8D 4A 59                 .JY
        jsr     L58B6                           ; 5502 20 B6 58                  .X
        jmp     L548E                           ; 5505 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L5508:  jsr     L549F                           ; 5508 20 9F 54                  .T
        lda     #$28                            ; 550B A9 28                    .(
        sta     L5DAD                           ; 550D 8D AD 5D                 ..]
        jmp     L5643                           ; 5510 4C 43 56                 LCV

; ----------------------------------------------------------------------------
L5513:  jsr     L549F                           ; 5513 20 9F 54                  .T
        jsr     L5775                           ; 5516 20 75 57                  uW
        clv                                     ; 5519 B8                       .
        bvc     L5522                           ; 551A 50 06                    P.
L551C:  jsr     L549F                           ; 551C 20 9F 54                  .T
        jsr     L5786                           ; 551F 20 86 57                  .W
L5522:  jsr     GetDirHead                      ; 5522 20 47 C2                  G.
        lda     $8201                           ; 5525 AD 01 82                 ...
        sta     $05                             ; 5528 85 05                    ..
        lda     $8200                           ; 552A AD 00 82                 ...
        sta     $04                             ; 552D 85 04                    ..
        jsr     L5DAE                           ; 552F 20 AE 5D                  .]
        jsr     L5CD9                           ; 5532 20 D9 5C                  .\
        jsr     PutDirHead                      ; 5535 20 4A C2                  J.
        jmp     L548E                           ; 5538 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L553B:  jsr     L5562                           ; 553B 20 62 55                  bU
        bne     L555F                           ; 553E D0 1F                    ..
        jsr     L5573                           ; 5540 20 73 55                  sU
        lda     L548D                           ; 5543 AD 8D 54                 ..T
        cmp     L55DB                           ; 5546 CD DB 55                 ..U
        beq     L555C                           ; 5549 F0 11                    ..
        lda     L55DB                           ; 554B AD DB 55                 ..U
        bne     L555F                           ; 554E D0 0F                    ..
        lda     $88C6                           ; 5550 AD C6 88                 ...
        and     #$F0                            ; 5553 29 F0                    ).
        cmp     #$10                            ; 5555 C9 10                    ..
        bne     L555C                           ; 5557 D0 03                    ..
        jsr     L55E4                           ; 5559 20 E4 55                  .U
L555C:  ldx     #$00                            ; 555C A2 00                    ..
        rts                                     ; 555E 60                       `

; ----------------------------------------------------------------------------
L555F:  ldx     #$0D                            ; 555F A2 0D                    ..
        rts                                     ; 5561 60                       `

; ----------------------------------------------------------------------------
L5562:  lda     $88C6                           ; 5562 AD C6 88                 ...
        and     #$F0                            ; 5565 29 F0                    ).
        beq     L5570                           ; 5567 F0 07                    ..
        cmp     #$40                            ; 5569 C9 40                    .@
        bcs     L5570                           ; 556B B0 03                    ..
        lda     #$00                            ; 556D A9 00                    ..
        rts                                     ; 556F 60                       `

; ----------------------------------------------------------------------------
L5570:  lda     #$80                            ; 5570 A9 80                    ..
        rts                                     ; 5572 60                       `

; ----------------------------------------------------------------------------
L5573:  jsr     PurgeTurbo                      ; 5573 20 35 C2                  5.
        jsr     InitForIO                       ; 5576 20 5C C2                  \.
        jsr     L55A5                           ; 5579 20 A5 55                  .U
        lda     $88C6                           ; 557C AD C6 88                 ...
        and     #$F0                            ; 557F 29 F0                    ).
        cmp     #$10                            ; 5581 C9 10                    ..
        bne     L559F                           ; 5583 D0 1A                    ..
        lda     L55DC                           ; 5585 AD DC 55                 ..U
        and     #$20                            ; 5588 29 20                    ) 
        bne     L559F                           ; 558A D0 13                    ..
        lda     #$55                            ; 558C A9 55                    .U
        sta     $8C                             ; 558E 85 8C                    ..
        lda     #$DD                            ; 5590 A9 DD                    ..
        sta     $8B                             ; 5592 85 8B                    ..
        ldy     #$07                            ; 5594 A0 07                    ..
        lda     $8489                           ; 5596 AD 89 84                 ...
        jsr     L5B6D                           ; 5599 20 6D 5B                  m[
        jsr     L55A5                           ; 559C 20 A5 55                  .U
L559F:  jsr     DoneWithIO                      ; 559F 20 5F C2                  _.
        jmp     EnterTurbo                      ; 55A2 4C 14 C2                 L..

; ----------------------------------------------------------------------------
L55A5:  lda     #$55                            ; 55A5 A9 55                    .U
        sta     $8C                             ; 55A7 85 8C                    ..
        lda     #$D7                            ; 55A9 A9 D7                    ..
        sta     $8B                             ; 55AB 85 8B                    ..
        ldy     #$04                            ; 55AD A0 04                    ..
        lda     $8489                           ; 55AF AD 89 84                 ...
        jsr     L5B6D                           ; 55B2 20 6D 5B                  m[
        lda     $8489                           ; 55B5 AD 89 84                 ...
        jsr     L5BD3                           ; 55B8 20 D3 5B                  .[
        ldx     L5BAB                           ; 55BB AE AB 5B                 ..[
        cpx     #$05                            ; 55BE E0 05                    ..
        bcc     L55C5                           ; 55C0 90 03                    ..
        ldx     #$0D                            ; 55C2 A2 0D                    ..
        rts                                     ; 55C4 60                       `

; ----------------------------------------------------------------------------
L55C5:  lda     L55D2,x                         ; 55C5 BD D2 55                 ..U
        sta     L55DB                           ; 55C8 8D DB 55                 ..U
        lda     L5BAC                           ; 55CB AD AC 5B                 ..[
        sta     L55DC                           ; 55CE 8D DC 55                 ..U
        rts                                     ; 55D1 60                       `

; ----------------------------------------------------------------------------
L55D2:  brk                                     ; 55D2 00                       .
        .byte   $04                             ; 55D3 04                       .
        ora     ($02,x)                         ; 55D4 01 02                    ..
        .byte   $03                             ; 55D6 03                       .
        .byte   $47                             ; 55D7 47                       G
        and     $FF50                           ; 55D8 2D 50 FF                 -P.
L55DB:  brk                                     ; 55DB 00                       .
L55DC:  brk                                     ; 55DC 00                       .
        eor     L572D                           ; 55DD 4D 2D 57                 M-W
        and     $00                             ; 55E0 25 00                    %.
        ora     ($01,x)                         ; 55E2 01 01                    ..
L55E4:  lda     #$38                            ; 55E4 A9 38                    .8
        sta     L562F                           ; 55E6 8D 2F 56                 ./V
        lda     #$31                            ; 55E9 A9 31                    .1
        sta     L5630                           ; 55EB 8D 30 56                 .0V
        lda     #$20                            ; 55EE A9 20                    . 
        sta     L5631                           ; 55F0 8D 31 56                 .1V
        lda     L55DC                           ; 55F3 AD DC 55                 ..U
        bmi     L55FB                           ; 55F6 30 03                    0.
        ldx     #$21                            ; 55F8 A2 21                    .!
        rts                                     ; 55FA 60                       `

; ----------------------------------------------------------------------------
L55FB:  and     #$10                            ; 55FB 29 10                    ).
        bne     L561F                           ; 55FD D0 20                    . 
        lda     #$44                            ; 55FF A9 44                    .D
        sta     L5630                           ; 5601 8D 30 56                 .0V
        lda     L55DC                           ; 5604 AD DC 55                 ..U
        and     #$07                            ; 5607 29 07                    ).
        tax                                     ; 5609 AA                       .
        lda     L5628,x                         ; 560A BD 28 56                 .(V
        sta     L562F                           ; 560D 8D 2F 56                 ./V
        lda     L548D                           ; 5610 AD 8D 54                 ..T
        cmp     #$03                            ; 5613 C9 03                    ..
        beq     L561A                           ; 5615 F0 03                    ..
        lda     #$4E                            ; 5617 A9 4E                    .N
        .byte   $2C                             ; 5619 2C                       ,
L561A:  lda     #$38                            ; 561A A9 38                    .8
        sta     L5631                           ; 561C 8D 31 56                 .1V
L561F:  lda     #$FF                            ; 561F A9 FF                    ..
        sta     L5627                           ; 5621 8D 27 56                 .'V
        ldx     #$00                            ; 5624 A2 00                    ..
        rts                                     ; 5626 60                       `

; ----------------------------------------------------------------------------
L5627:  brk                                     ; 5627 00                       .
L5628:  .byte   $44                             ; 5628 44                       D
        .byte   $44                             ; 5629 44                       D
        pha                                     ; 562A 48                       H
        eor     $44                             ; 562B 45 44                    ED
        pha                                     ; 562D 48                       H
        .byte   $45                             ; 562E 45                       E
L562F:  sec                                     ; 562F 38                       8
L5630:  .byte   $31                             ; 5630 31                       1
L5631:  .byte   $20                             ; 5631 20                        
L5632:  jsr     L553B                           ; 5632 20 3B 55                  ;U
        bne     L563A                           ; 5635 D0 03                    ..
        jmp     L57E2                           ; 5637 4C E2 57                 L.W

; ----------------------------------------------------------------------------
L563A:  jsr     L549F                           ; 563A 20 9F 54                  .T
        jsr     L5976                           ; 563D 20 76 59                  vY
        txa                                     ; 5640 8A                       .
        bne     L564C                           ; 5641 D0 09                    ..
L5643:  jsr     L5653                           ; 5643 20 53 56                  SV
        txa                                     ; 5646 8A                       .
        bne     L564C                           ; 5647 D0 03                    ..
        jmp     L5522                           ; 5649 4C 22 55                 L"U

; ----------------------------------------------------------------------------
L564C:  pha                                     ; 564C 48                       H
        jsr     ExitTurbo                       ; 564D 20 32 C2                  2.
        pla                                     ; 5650 68                       h
        tax                                     ; 5651 AA                       .
        rts                                     ; 5652 60                       `

; ----------------------------------------------------------------------------
L5653:  ldy     #$00                            ; 5653 A0 00                    ..
        tya                                     ; 5655 98                       .
L5656:  sta     $8200,y                         ; 5656 99 00 82                 ...
        sta     $8900,y                         ; 5659 99 00 89                 ...
        sta     $9C80,y                         ; 565C 99 80 9C                 ...
        iny                                     ; 565F C8                       .
        bne     L5656                           ; 5660 D0 F4                    ..
        ldy     #$02                            ; 5662 A0 02                    ..
L5664:  lda     L56AA,y                         ; 5664 B9 AA 56                 ..V
        sta     $8200,y                         ; 5667 99 00 82                 ...
        dey                                     ; 566A 88                       .
        bpl     L5664                           ; 566B 10 F7                    ..
        ldy     #$04                            ; 566D A0 04                    ..
L566F:  lda     L56AD,y                         ; 566F B9 AD 56                 ..V
        sta     $82A4,y                         ; 5672 99 A4 82                 ...
        dey                                     ; 5675 88                       .
        bpl     L566F                           ; 5676 10 F7                    ..
        jsr     L56C0                           ; 5678 20 C0 56                  .V
        ldy     #$06                            ; 567B A0 06                    ..
L567D:  lda     L56B2,y                         ; 567D B9 B2 56                 ..V
        sta     $8900,y                         ; 5680 99 00 89                 ...
        lda     L56B9,y                         ; 5683 B9 B9 56                 ..V
        sta     $9C80,y                         ; 5686 99 80 9C                 ...
        dey                                     ; 5689 88                       .
        bpl     L567D                           ; 568A 10 F1                    ..
        lda     L54B2                           ; 568C AD B2 54                 ..T
        sta     $8904                           ; 568F 8D 04 89                 ...
        sta     $9C84                           ; 5692 8D 84 9C                 ...
        sta     $82A2                           ; 5695 8D A2 82                 ...
        lda     L54B3                           ; 5698 AD B3 54                 ..T
        sta     $8905                           ; 569B 8D 05 89                 ...
        sta     $9C85                           ; 569E 8D 85 9C                 ...
        sta     $82A3                           ; 56A1 8D A3 82                 ...
        jsr     PutDirHead                      ; 56A4 20 4A C2                  J.
        jmp     L5D09                           ; 56A7 4C 09 5D                 L.]

; ----------------------------------------------------------------------------
L56AA:  plp                                     ; 56AA 28                       (
        .byte   $03                             ; 56AB 03                       .
        .byte   $44                             ; 56AC 44                       D
L56AD:  ldy     #$33                            ; 56AD A0 33                    .3
        .byte   $44                             ; 56AF 44                       D
        ldy     #$A0                            ; 56B0 A0 A0                    ..
L56B2:  plp                                     ; 56B2 28                       (
        .byte   $02                             ; 56B3 02                       .
        .byte   $44                             ; 56B4 44                       D
        .byte   $BB                             ; 56B5 BB                       .
        brk                                     ; 56B6 00                       .
        brk                                     ; 56B7 00                       .
        .byte   $C0                             ; 56B8 C0                       .
L56B9:  brk                                     ; 56B9 00                       .
        .byte   $FF                             ; 56BA FF                       .
        .byte   $44                             ; 56BB 44                       D
        .byte   $BB                             ; 56BC BB                       .
        brk                                     ; 56BD 00                       .
        brk                                     ; 56BE 00                       .
        .byte   $C0                             ; 56BF C0                       .
L56C0:  ldy     #$00                            ; 56C0 A0 00                    ..
L56C2:  lda     L500F,y                         ; 56C2 B9 0F 50                 ..P
        beq     L56CF                           ; 56C5 F0 08                    ..
        sta     $8290,y                         ; 56C7 99 90 82                 ...
        iny                                     ; 56CA C8                       .
        cpy     #$10                            ; 56CB C0 10                    ..
        bne     L56C2                           ; 56CD D0 F3                    ..
L56CF:  lda     #$A0                            ; 56CF A9 A0                    ..
L56D1:  sta     $8290,y                         ; 56D1 99 90 82                 ...
        iny                                     ; 56D4 C8                       .
        cpy     #$12                            ; 56D5 C0 12                    ..
        bne     L56D1                           ; 56D7 D0 F8                    ..
        rts                                     ; 56D9 60                       `

; ----------------------------------------------------------------------------
L56DA:  ldy     #$00                            ; 56DA A0 00                    ..
        tya                                     ; 56DC 98                       .
L56DD:  sta     $8000,y                         ; 56DD 99 00 80                 ...
        iny                                     ; 56E0 C8                       .
        bne     L56DD                           ; 56E1 D0 FA                    ..
        rts                                     ; 56E3 60                       `

; ----------------------------------------------------------------------------
L56E4:  jsr     L549F                           ; 56E4 20 9F 54                  .T
        jsr     PurgeTurbo                      ; 56E7 20 35 C2                  5.
        lda     L571C                           ; 56EA AD 1C 57                 ..W
        cmp     #$29                            ; 56ED C9 29                    .)
        bne     L5701                           ; 56EF D0 10                    ..
        jsr     L571D                           ; 56F1 20 1D 57                  .W
        jsr     L57FB                           ; 56F4 20 FB 57                  .W
        txa                                     ; 56F7 8A                       .
        beq     L5719                           ; 56F8 F0 1F                    ..
L56FA:  pha                                     ; 56FA 48                       H
        jsr     EnterTurbo                      ; 56FB 20 14 C2                  ..
        pla                                     ; 56FE 68                       h
        tax                                     ; 56FF AA                       .
        rts                                     ; 5700 60                       `

; ----------------------------------------------------------------------------
L5701:  jsr     L5738                           ; 5701 20 38 57                  8W
        txa                                     ; 5704 8A                       .
        bne     L56FA                           ; 5705 D0 F3                    ..
        jsr     InitForIO                       ; 5707 20 5C C2                  \.
        jsr     L585B                           ; 570A 20 5B 58                  [X
        jsr     DoneWithIO                      ; 570D 20 5F C2                  _.
        txa                                     ; 5710 8A                       .
        bne     L56FA                           ; 5711 D0 E7                    ..
        jsr     L5775                           ; 5713 20 75 57                  uW
        txa                                     ; 5716 8A                       .
        bne     L56FA                           ; 5717 D0 E1                    ..
L5719:  jmp     L5522                           ; 5719 4C 22 55                 L"U

; ----------------------------------------------------------------------------
L571C:  brk                                     ; 571C 00                       .
L571D:  jsr     InitForIO                       ; 571D 20 5C C2                  \.
        lda     #$57                            ; 5720 A9 57                    .W
        sta     $8C                             ; 5722 85 8C                    ..
        lda     #$33                            ; 5724 A9 33                    .3
        sta     $8B                             ; 5726 85 8B                    ..
        ldy     #$05                            ; 5728 A0 05                    ..
        lda     $8489                           ; 572A AD 89 84                 ...
L572D:  jsr     L5B6D                           ; 572D 20 6D 5B                  m[
        jmp     DoneWithIO                      ; 5730 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        eor     $30,x                           ; 5733 55 30                    U0
        rol     $304D,x                         ; 5735 3E 4D 30                 >M0
L5738:  jsr     InitForIO                       ; 5738 20 5C C2                  \.
        lda     L54B3                           ; 573B AD B3 54                 ..T
        sta     L5774                           ; 573E 8D 74 57                 .tW
        lda     L54B2                           ; 5741 AD B2 54                 ..T
        sta     L5773                           ; 5744 8D 73 57                 .sW
        lda     #$57                            ; 5747 A9 57                    .W
        sta     $8C                             ; 5749 85 8C                    ..
        lda     #$6C                            ; 574B A9 6C                    .l
        sta     $8B                             ; 574D 85 8B                    ..
        ldy     #$03                            ; 574F A0 03                    ..
        lda     $8489                           ; 5751 AD 89 84                 ...
        jsr     L5B6D                           ; 5754 20 6D 5B                  m[
        bne     L5769                           ; 5757 D0 10                    ..
        lda     #$57                            ; 5759 A9 57                    .W
        sta     $8C                             ; 575B 85 8C                    ..
        lda     #$6F                            ; 575D A9 6F                    .o
        sta     $8B                             ; 575F 85 8B                    ..
        ldy     #$06                            ; 5761 A0 06                    ..
        lda     $8489                           ; 5763 AD 89 84                 ...
        jsr     L5B6D                           ; 5766 20 6D 5B                  m[
L5769:  jmp     DoneWithIO                      ; 5769 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        eor     $30,x                           ; 576C 55 30                    U0
        .byte   $04                             ; 576E 04                       .
        eor     $30,x                           ; 576F 55 30                    U0
        asl     $00                             ; 5771 06 00                    ..
L5773:  .byte   $4D                             ; 5773 4D                       M
L5774:  .byte   $52                             ; 5774 52                       R
L5775:  jsr     L578C                           ; 5775 20 8C 57                  .W
        jsr     GetDirHead                      ; 5778 20 47 C2                  G.
        lda     #$80                            ; 577B A9 80                    ..
        sta     $8203                           ; 577D 8D 03 82                 ...
        jsr     L57B4                           ; 5780 20 B4 57                  .W
        jmp     L5D52                           ; 5783 4C 52 5D                 LR]

; ----------------------------------------------------------------------------
L5786:  jsr     L578C                           ; 5786 20 8C 57                  .W
        jmp     L5D7E                           ; 5789 4C 7E 5D                 L~]

; ----------------------------------------------------------------------------
L578C:  jsr     L57D2                           ; 578C 20 D2 57                  .W
        jsr     L56C0                           ; 578F 20 C0 56                  .V
        lda     L54B3                           ; 5792 AD B3 54                 ..T
        sta     $82A3                           ; 5795 8D A3 82                 ...
        lda     L54B2                           ; 5798 AD B2 54                 ..T
        sta     $82A2                           ; 579B 8D A2 82                 ...
        ldy     #$03                            ; 579E A0 03                    ..
L57A0:  lda     L57C7,y                         ; 57A0 B9 C7 57                 ..W
        sta     $8200,y                         ; 57A3 99 00 82                 ...
        dey                                     ; 57A6 88                       .
        bpl     L57A0                           ; 57A7 10 F7                    ..
        ldy     #$06                            ; 57A9 A0 06                    ..
L57AB:  lda     L57CB,y                         ; 57AB B9 CB 57                 ..W
        sta     $82A4,y                         ; 57AE 99 A4 82                 ...
        dey                                     ; 57B1 88                       .
        bpl     L57AB                           ; 57B2 10 F7                    ..
L57B4:  lda     #$82                            ; 57B4 A9 82                    ..
        sta     $0B                             ; 57B6 85 0B                    ..
        lda     #$00                            ; 57B8 A9 00                    ..
        sta     $0A                             ; 57BA 85 0A                    ..
        lda     #$12                            ; 57BC A9 12                    ..
        sta     $04                             ; 57BE 85 04                    ..
        lda     #$00                            ; 57C0 A9 00                    ..
        sta     $05                             ; 57C2 85 05                    ..
        jmp     PutBlock                        ; 57C4 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L57C7:  .byte   $12                             ; 57C7 12                       .
        ora     ($41,x)                         ; 57C8 01 41                    .A
        brk                                     ; 57CA 00                       .
L57CB:  ldy     #$32                            ; 57CB A0 32                    .2
        eor     ($A0,x)                         ; 57CD 41 A0                    A.
        ldy     #$A0                            ; 57CF A0 A0                    ..
        .byte   $A0                             ; 57D1 A0                       .
L57D2:  ldy     #$00                            ; 57D2 A0 00                    ..
        tya                                     ; 57D4 98                       .
L57D5:  sta     $8200,y                         ; 57D5 99 00 82                 ...
        iny                                     ; 57D8 C8                       .
        bne     L57D5                           ; 57D9 D0 FA                    ..
        rts                                     ; 57DB 60                       `

; ----------------------------------------------------------------------------
L57DC:  jsr     L553B                           ; 57DC 20 3B 55                  ;U
        beq     L57E2                           ; 57DF F0 01                    ..
        rts                                     ; 57E1 60                       `

; ----------------------------------------------------------------------------
L57E2:  jsr     L549F                           ; 57E2 20 9F 54                  .T
        jsr     PurgeTurbo                      ; 57E5 20 35 C2                  5.
        jsr     L57FB                           ; 57E8 20 FB 57                  .W
        txa                                     ; 57EB 8A                       .
        bne     L57FA                           ; 57EC D0 0C                    ..
        jsr     GetDirHead                      ; 57EE 20 47 C2                  G.
        jsr     L5CD9                           ; 57F1 20 D9 5C                  .\
        jsr     PutDirHead                      ; 57F4 20 4A C2                  J.
        jmp     L548E                           ; 57F7 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L57FA:  rts                                     ; 57FA 60                       `

; ----------------------------------------------------------------------------
L57FB:  jsr     InitForIO                       ; 57FB 20 5C C2                  \.
        lda     #$58                            ; 57FE A9 58                    .X
        sta     $8C                             ; 5800 85 8C                    ..
        lda     #$58                            ; 5802 A9 58                    .X
        sta     $8B                             ; 5804 85 8B                    ..
        lda     $8489                           ; 5806 AD 89 84                 ...
        ldy     #$03                            ; 5809 A0 03                    ..
        jsr     L5B7D                           ; 580B 20 7D 5B                  }[
        beq     L5813                           ; 580E F0 03                    ..
        jmp     DoneWithIO                      ; 5810 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L5813:  ldy     #$00                            ; 5813 A0 00                    ..
L5815:  lda     L500F,y                         ; 5815 B9 0F 50                 ..P
        beq     L5822                           ; 5818 F0 08                    ..
        jsr     LFFA8                           ; 581A 20 A8 FF                  ..
        iny                                     ; 581D C8                       .
        cpy     #$10                            ; 581E C0 10                    ..
        bne     L5815                           ; 5820 D0 F3                    ..
L5822:  lda     #$2C                            ; 5822 A9 2C                    .,
        jsr     LFFA8                           ; 5824 20 A8 FF                  ..
        lda     L54B2                           ; 5827 AD B2 54                 ..T
        jsr     LFFA8                           ; 582A 20 A8 FF                  ..
        lda     L54B3                           ; 582D AD B3 54                 ..T
        jsr     LFFA8                           ; 5830 20 A8 FF                  ..
        bit     L5627                           ; 5833 2C 27 56                 ,'V
        bpl     L584A                           ; 5836 10 12                    ..
        lda     #$2C                            ; 5838 A9 2C                    .,
        jsr     LFFA8                           ; 583A 20 A8 FF                  ..
        ldy     #$00                            ; 583D A0 00                    ..
L583F:  lda     L562F,y                         ; 583F B9 2F 56                 ./V
        jsr     LFFA8                           ; 5842 20 A8 FF                  ..
        iny                                     ; 5845 C8                       .
        cpy     #$03                            ; 5846 C0 03                    ..
        bne     L583F                           ; 5848 D0 F5                    ..
L584A:  lda     #$0D                            ; 584A A9 0D                    ..
        jsr     LFFA8                           ; 584C 20 A8 FF                  ..
        jsr     LFFAE                           ; 584F 20 AE FF                  ..
        jsr     L585B                           ; 5852 20 5B 58                  [X
        jmp     DoneWithIO                      ; 5855 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        lsr     $3A30                           ; 5858 4E 30 3A                 N0:
L585B:  lda     $8489                           ; 585B AD 89 84                 ...
        jsr     L5BD3                           ; 585E 20 D3 5B                  .[
        bne     L5872                           ; 5861 D0 0F                    ..
        lda     L5BAB                           ; 5863 AD AB 5B                 ..[
        cmp     #$30                            ; 5866 C9 30                    .0
        bne     L5872                           ; 5868 D0 08                    ..
        cmp     L5BAC                           ; 586A CD AC 5B                 ..[
        bne     L5872                           ; 586D D0 03                    ..
        ldx     #$00                            ; 586F A2 00                    ..
        .byte   $2C                             ; 5871 2C                       ,
L5872:  ldx     #$21                            ; 5872 A2 21                    .!
        rts                                     ; 5874 60                       `

; ----------------------------------------------------------------------------
L5875:  jsr     EnterTurbo                      ; 5875 20 14 C2                  ..
        lda     #$0C                            ; 5878 A9 0C                    ..
        sta     L594A                           ; 587A 8D 4A 59                 .JY
        sta     $9062                           ; 587D 8D 62 90                 .b.
        jsr     L5962                           ; 5880 20 62 59                  bY
        txa                                     ; 5883 8A                       .
        bne     L5895                           ; 5884 D0 0F                    ..
        jsr     L589C                           ; 5886 20 9C 58                  .X
        txa                                     ; 5889 8A                       .
        bne     L5895                           ; 588A D0 09                    ..
        jsr     L58B6                           ; 588C 20 B6 58                  .X
        txa                                     ; 588F 8A                       .
        bne     L5895                           ; 5890 D0 03                    ..
        jmp     L548E                           ; 5892 4C 8E 54                 L.T

; ----------------------------------------------------------------------------
L5895:  pha                                     ; 5895 48                       H
        jsr     ExitTurbo                       ; 5896 20 32 C2                  2.
        pla                                     ; 5899 68                       h
        tax                                     ; 589A AA                       .
        rts                                     ; 589B 60                       `

; ----------------------------------------------------------------------------
L589C:  jsr     L56DA                           ; 589C 20 DA 56                  .V
        lda     #$07                            ; 589F A9 07                    ..
        sta     $04                             ; 58A1 85 04                    ..
        lda     #$18                            ; 58A3 A9 18                    ..
        sta     $05                             ; 58A5 85 05                    ..
L58A7:  jsr     L903F                           ; 58A7 20 3F 90                  ?.
        txa                                     ; 58AA 8A                       .
        bne     L58B5                           ; 58AB D0 08                    ..
        inc     $05                             ; 58AD E6 05                    ..
        lda     $05                             ; 58AF A5 05                    ..
        cmp     #$1C                            ; 58B1 C9 1C                    ..
        bcc     L58A7                           ; 58B3 90 F2                    ..
L58B5:  rts                                     ; 58B5 60                       `

; ----------------------------------------------------------------------------
L58B6:  lda     L54B3                           ; 58B6 AD B3 54                 ..T
        sta     L5947                           ; 58B9 8D 47 59                 .GY
        lda     L54B2                           ; 58BC AD B2 54                 ..T
        sta     L5946                           ; 58BF 8D 46 59                 .FY
        ldy     #$00                            ; 58C2 A0 00                    ..
        lda     #$FF                            ; 58C4 A9 FF                    ..
L58C6:  sta     $8000,y                         ; 58C6 99 00 80                 ...
        iny                                     ; 58C9 C8                       .
        bne     L58C6                           ; 58CA D0 FA                    ..
        lda     #$01                            ; 58CC A9 01                    ..
        sta     $04                             ; 58CE 85 04                    ..
        lda     #$03                            ; 58D0 A9 03                    ..
        sta     $05                             ; 58D2 85 05                    ..
L58D4:  jsr     L903F                           ; 58D4 20 3F 90                  ?.
        inc     $05                             ; 58D7 E6 05                    ..
        lda     $05                             ; 58D9 A5 05                    ..
        cmp     #$22                            ; 58DB C9 22                    ."
        bcc     L58D4                           ; 58DD 90 F5                    ..
        ldy     #$1F                            ; 58DF A0 1F                    ..
L58E1:  lda     L5942,y                         ; 58E1 B9 42 59                 .BY
        sta     $8000,y                         ; 58E4 99 00 80                 ...
        dey                                     ; 58E7 88                       .
        bpl     L58E1                           ; 58E8 10 F7                    ..
        lda     #$01                            ; 58EA A9 01                    ..
        sta     $04                             ; 58EC 85 04                    ..
        lda     #$02                            ; 58EE A9 02                    ..
        sta     $05                             ; 58F0 85 05                    ..
        jsr     L903F                           ; 58F2 20 3F 90                  ?.
        jsr     L57D2                           ; 58F5 20 D2 57                  .W
        lda     #$01                            ; 58F8 A9 01                    ..
        sta     $8200                           ; 58FA 8D 00 82                 ...
        lda     #$22                            ; 58FD A9 22                    ."
        sta     $8201                           ; 58FF 8D 01 82                 ...
        lda     #$48                            ; 5902 A9 48                    .H
        sta     $8202                           ; 5904 8D 02 82                 ...
        lda     #$01                            ; 5907 A9 01                    ..
        sta     $8220                           ; 5909 8D 20 82                 . .
        sta     $8221                           ; 590C 8D 21 82                 .!.
        jsr     L56C0                           ; 590F 20 C0 56                  .V
        lda     L54B3                           ; 5912 AD B3 54                 ..T
        sta     $82A3                           ; 5915 8D A3 82                 ...
        lda     L54B2                           ; 5918 AD B2 54                 ..T
        sta     $82A2                           ; 591B 8D A2 82                 ...
        ldy     #$04                            ; 591E A0 04                    ..
L5920:  lda     L593D,y                         ; 5920 B9 3D 59                 .=Y
        sta     $82A4,y                         ; 5923 99 A4 82                 ...
        dey                                     ; 5926 88                       .
        bpl     L5920                           ; 5927 10 F7                    ..
        lda     #$01                            ; 5929 A9 01                    ..
        sta     $04                             ; 592B 85 04                    ..
        sta     $05                             ; 592D 85 05                    ..
        lda     #$82                            ; 592F A9 82                    ..
        sta     $0B                             ; 5931 85 0B                    ..
        lda     #$00                            ; 5933 A9 00                    ..
        sta     $0A                             ; 5935 85 0A                    ..
        jsr     PutBlock                        ; 5937 20 E7 C1                  ..
        jmp     L5CE4                           ; 593A 4C E4 5C                 L.\

; ----------------------------------------------------------------------------
L593D:  ldy     #$31                            ; 593D A0 31                    .1
        pha                                     ; 593F 48                       H
        ldy     #$A0                            ; 5940 A0 A0                    ..
L5942:  brk                                     ; 5942 00                       .
        brk                                     ; 5943 00                       .
        pha                                     ; 5944 48                       H
        .byte   $B7                             ; 5945 B7                       .
L5946:  .byte   $46                             ; 5946 46                       F
L5947:  .byte   $44                             ; 5947 44                       D
        cpy     #$00                            ; 5948 C0 00                    ..
L594A:  .byte   $0C                             ; 594A 0C                       .
        brk                                     ; 594B 00                       .
        brk                                     ; 594C 00                       .
        brk                                     ; 594D 00                       .
        brk                                     ; 594E 00                       .
        brk                                     ; 594F 00                       .
        brk                                     ; 5950 00                       .
        brk                                     ; 5951 00                       .
        brk                                     ; 5952 00                       .
        brk                                     ; 5953 00                       .
        brk                                     ; 5954 00                       .
        brk                                     ; 5955 00                       .
        brk                                     ; 5956 00                       .
        brk                                     ; 5957 00                       .
        brk                                     ; 5958 00                       .
        brk                                     ; 5959 00                       .
        brk                                     ; 595A 00                       .
        brk                                     ; 595B 00                       .
        brk                                     ; 595C 00                       .
        brk                                     ; 595D 00                       .
        brk                                     ; 595E 00                       .
        brk                                     ; 595F 00                       .
        brk                                     ; 5960 00                       .
        brk                                     ; 5961 00                       .
L5962:  lda     #$46                            ; 5962 A9 46                    .F
        sta     L54B2                           ; 5964 8D B2 54                 ..T
        lda     #$44                            ; 5967 A9 44                    .D
        sta     L54B3                           ; 5969 8D B3 54                 ..T
        jsr     L5976                           ; 596C 20 76 59                  vY
        txa                                     ; 596F 8A                       .
        bne     L5975                           ; 5970 D0 03                    ..
        jmp     L5AE9                           ; 5972 4C E9 5A                 L.Z

; ----------------------------------------------------------------------------
L5975:  rts                                     ; 5975 60                       `

; ----------------------------------------------------------------------------
L5976:  jsr     PurgeTurbo                      ; 5976 20 35 C2                  5.
        jsr     InitForIO                       ; 5979 20 5C C2                  \.
        lda     L54B3                           ; 597C AD B3 54                 ..T
        sta     L59BB                           ; 597F 8D BB 59                 ..Y
        lda     L54B2                           ; 5982 AD B2 54                 ..T
        sta     L59BA                           ; 5985 8D BA 59                 ..Y
        lda     #$59                            ; 5988 A9 59                    .Y
        sta     $8C                             ; 598A 85 8C                    ..
        lda     #$B4                            ; 598C A9 B4                    ..
        sta     $8B                             ; 598E 85 8B                    ..
        ldy     #$08                            ; 5990 A0 08                    ..
        lda     $8489                           ; 5992 AD 89 84                 ...
        jsr     L5B6D                           ; 5995 20 6D 5B                  m[
        lda     $8489                           ; 5998 AD 89 84                 ...
        jsr     L5BD3                           ; 599B 20 D3 5B                  .[
        bne     L59B1                           ; 599E D0 11                    ..
        lda     L5BAB                           ; 59A0 AD AB 5B                 ..[
        cmp     #$30                            ; 59A3 C9 30                    .0
        bne     L59AF                           ; 59A5 D0 08                    ..
        cmp     L5BAC                           ; 59A7 CD AC 5B                 ..[
        bne     L59AF                           ; 59AA D0 03                    ..
        ldx     #$00                            ; 59AC A2 00                    ..
        .byte   $2C                             ; 59AE 2C                       ,
L59AF:  ldx     #$21                            ; 59AF A2 21                    .!
L59B1:  jmp     DoneWithIO                      ; 59B1 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        lsr     $3A30                           ; 59B4 4E 30 3A                 N0:
        eor     $2C52                           ; 59B7 4D 52 2C                 MR,
L59BA:  .byte   $46                             ; 59BA 46                       F
L59BB:  .byte   $44                             ; 59BB 44                       D
        brk                                     ; 59BC 00                       .
        brk                                     ; 59BD 00                       .
        ora     ($01,x)                         ; 59BE 01 01                    ..
        brk                                     ; 59C0 00                       .
        brk                                     ; 59C1 00                       .
        brk                                     ; 59C2 00                       .
        brk                                     ; 59C3 00                       .
        brk                                     ; 59C4 00                       .
        brk                                     ; 59C5 00                       .
        brk                                     ; 59C6 00                       .
        brk                                     ; 59C7 00                       .
        brk                                     ; 59C8 00                       .
        brk                                     ; 59C9 00                       .
        brk                                     ; 59CA 00                       .
        brk                                     ; 59CB 00                       .
        .byte   $43                             ; 59CC 43                       C
        eor     $2044                           ; 59CD 4D 44 20                 MD 
        lsr     $44                             ; 59D0 46 44                    FD
        jsr     L4553                           ; 59D2 20 53 45                  SE
        .byte   $52                             ; 59D5 52                       R
        eor     #$45                            ; 59D6 49 45                    IE
        .byte   $53                             ; 59D8 53                       S
        jsr     L2020                           ; 59D9 20 20 20                    
        ora     ($01,x)                         ; 59DC 01 01                    ..
        .byte   $FF                             ; 59DE FF                       .
        brk                                     ; 59DF 00                       .
        brk                                     ; 59E0 00                       .
        .byte   $53                             ; 59E1 53                       S
        eor     L5453,y                         ; 59E2 59 53 54                 YST
        eor     $4D                             ; 59E5 45 4D                    EM
        ldy     #$A0                            ; 59E7 A0 A0                    ..
        ldy     #$A0                            ; 59E9 A0 A0                    ..
        ldy     #$A0                            ; 59EB A0 A0                    ..
        ldy     #$A0                            ; 59ED A0 A0                    ..
        ldy     #$A0                            ; 59EF A0 A0                    ..
        brk                                     ; 59F1 00                       .
        brk                                     ; 59F2 00                       .
        brk                                     ; 59F3 00                       .
        brk                                     ; 59F4 00                       .
        brk                                     ; 59F5 00                       .
        brk                                     ; 59F6 00                       .
        brk                                     ; 59F7 00                       .
        brk                                     ; 59F8 00                       .
        brk                                     ; 59F9 00                       .
        brk                                     ; 59FA 00                       .
        brk                                     ; 59FB 00                       .
        brk                                     ; 59FC 00                       .
        brk                                     ; 59FD 00                       .
        ora     ($00,x)                         ; 59FE 01 00                    ..
        brk                                     ; 5A00 00                       .
        bvc     L5A44                           ; 5A01 50 41                    PA
        .byte   $52                             ; 5A03 52                       R
        .byte   $54                             ; 5A04 54                       T
        eor     #$54                            ; 5A05 49 54                    IT
        eor     #$4F                            ; 5A07 49 4F                    IO
        lsr     $3120                           ; 5A09 4E 20 31                 N 1
        ldy     #$A0                            ; 5A0C A0 A0                    ..
        ldy     #$A0                            ; 5A0E A0 A0                    ..
        ldy     #$00                            ; 5A10 A0 00                    ..
        brk                                     ; 5A12 00                       .
        brk                                     ; 5A13 00                       .
        brk                                     ; 5A14 00                       .
        brk                                     ; 5A15 00                       .
        brk                                     ; 5A16 00                       .
        brk                                     ; 5A17 00                       .
        brk                                     ; 5A18 00                       .
        brk                                     ; 5A19 00                       .
        asl     $00                             ; 5A1A 06 00                    ..
        php                                     ; 5A1C 08                       .
        sei                                     ; 5A1D 78                       x
        lda     #$00                            ; 5A1E A9 00                    ..
L5A20:  sta     $01CE                           ; 5A20 8D CE 01                 ...
        lda     #$9C                            ; 5A23 A9 9C                    ..
        ldx     #$00                            ; 5A25 A2 00                    ..
        jsr     LFF54                           ; 5A27 20 54 FF                  T.
        lda     #$50                            ; 5A2A A9 50                    .P
        sta     $01BC                           ; 5A2C 8D BC 01                 ...
        lda     #$8C                            ; 5A2F A9 8C                    ..
        ldx     #$00                            ; 5A31 A2 00                    ..
        jsr     LFF54                           ; 5A33 20 54 FF                  T.
        lda     #$8E                            ; 5A36 A9 8E                    ..
        ldx     #$00                            ; 5A38 A2 00                    ..
        jsr     LFF54                           ; 5A3A 20 54 FF                  T.
        lda     #$01                            ; 5A3D A9 01                    ..
        cmp     $01CE                           ; 5A3F CD CE 01                 ...
        bne     L5A20                           ; 5A42 D0 DC                    ..
L5A44:  ldy     #$00                            ; 5A44 A0 00                    ..
L5A46:  lda     #$00                            ; 5A46 A9 00                    ..
        sta     $0300,y                         ; 5A48 99 00 03                 ...
        lda     #$FF                            ; 5A4B A9 FF                    ..
        sta     $0400,y                         ; 5A4D 99 00 04                 ...
        iny                                     ; 5A50 C8                       .
        bne     L5A46                           ; 5A51 D0 F3                    ..
        tya                                     ; 5A53 98                       .
        sta     $0400                           ; 5A54 8D 00 04                 ...
        sta     $0438                           ; 5A57 8D 38 04                 .8.
        sta     $0439                           ; 5A5A 8D 39 04                 .9.
        sta     $0470                           ; 5A5D 8D 70 04                 .p.
        sta     $04A8                           ; 5A60 8D A8 04                 ...
        lda     #$06                            ; 5A63 A9 06                    ..
        sta     $0471                           ; 5A65 8D 71 04                 .q.
        lda     #$40                            ; 5A68 A9 40                    .@
        sta     $04A9                           ; 5A6A 8D A9 04                 ...
        lda     #$01                            ; 5A6D A9 01                    ..
        sta     $04E2                           ; 5A6F 8D E2 04                 ...
        sta     $04E3                           ; 5A72 8D E3 04                 ...
        ldy     #$1F                            ; 5A75 A0 1F                    ..
L5A77:  lda     $0500,y                         ; 5A77 B9 00 05                 ...
        sta     $04E0,y                         ; 5A7A 99 E0 04                 ...
        dey                                     ; 5A7D 88                       .
        bpl     L5A77                           ; 5A7E 10 F7                    ..
        lda     #$50                            ; 5A80 A9 50                    .P
        sta     $0B                             ; 5A82 85 0B                    ..
        lda     #$03                            ; 5A84 A9 03                    ..
        sta     $0C                             ; 5A86 85 0C                    ..
        lda     #$00                            ; 5A88 A9 00                    ..
        sta     $01CE                           ; 5A8A 8D CE 01                 ...
        lda     #$A6                            ; 5A8D A9 A6                    ..
        ldx     #$00                            ; 5A8F A2 00                    ..
        jsr     LFF54                           ; 5A91 20 54 FF                  T.
        ldy     #$00                            ; 5A94 A0 00                    ..
        tya                                     ; 5A96 98                       .
L5A97:  sta     $0300,y                         ; 5A97 99 00 03                 ...
        sta     $0400,y                         ; 5A9A 99 00 04                 ...
        iny                                     ; 5A9D C8                       .
        bne     L5A97                           ; 5A9E D0 F7                    ..
        lda     #$FF                            ; 5AA0 A9 FF                    ..
        sta     $0401                           ; 5AA2 8D 01 04                 ...
        lda     #$01                            ; 5AA5 A9 01                    ..
        sta     $0300                           ; 5AA7 8D 00 03                 ...
        lda     #$03                            ; 5AAA A9 03                    ..
        sta     $0301                           ; 5AAC 8D 01 03                 ...
        lda     #$50                            ; 5AAF A9 50                    .P
        sta     $0B                             ; 5AB1 85 0B                    ..
        lda     #$06                            ; 5AB3 A9 06                    ..
        sta     $0C                             ; 5AB5 85 0C                    ..
        lda     #$00                            ; 5AB7 A9 00                    ..
        sta     $01CE                           ; 5AB9 8D CE 01                 ...
        lda     #$A6                            ; 5ABC A9 A6                    ..
        ldx     #$00                            ; 5ABE A2 00                    ..
        jsr     LFF54                           ; 5AC0 20 54 FF                  T.
        ldy     #$3F                            ; 5AC3 A0 3F                    .?
L5AC5:  lda     $0520,y                         ; 5AC5 B9 20 05                 . .
        sta     $0300,y                         ; 5AC8 99 00 03                 ...
        dey                                     ; 5ACB 88                       .
        bpl     L5AC5                           ; 5ACC 10 F7                    ..
        lda     #$02                            ; 5ACE A9 02                    ..
        sta     $0401                           ; 5AD0 8D 01 04                 ...
        lda     #$50                            ; 5AD3 A9 50                    .P
        sta     $0B                             ; 5AD5 85 0B                    ..
        lda     #$05                            ; 5AD7 A9 05                    ..
        sta     $0C                             ; 5AD9 85 0C                    ..
        lda     #$00                            ; 5ADB A9 00                    ..
        sta     $01CE                           ; 5ADD 8D CE 01                 ...
        lda     #$A6                            ; 5AE0 A9 A6                    ..
        ldx     #$00                            ; 5AE2 A2 00                    ..
        jsr     LFF54                           ; 5AE4 20 54 FF                  T.
        plp                                     ; 5AE7 28                       (
        rts                                     ; 5AE8 60                       `

; ----------------------------------------------------------------------------
L5AE9:  jsr     PurgeTurbo                      ; 5AE9 20 35 C2                  5.
        jsr     InitForIO                       ; 5AEC 20 5C C2                  \.
        lda     #$00                            ; 5AEF A9 00                    ..
        sta     L5B65                           ; 5AF1 8D 65 5B                 .e[
        lda     #$05                            ; 5AF4 A9 05                    ..
        sta     L5B66                           ; 5AF6 8D 66 5B                 .f[
        lda     #$59                            ; 5AF9 A9 59                    .Y
        sta     $03                             ; 5AFB 85 03                    ..
        lda     #$BC                            ; 5AFD A9 BC                    ..
        sta     $02                             ; 5AFF 85 02                    ..
L5B01:  ldy     #$06                            ; 5B01 A0 06                    ..
        lda     #$5B                            ; 5B03 A9 5B                    .[
        sta     $8C                             ; 5B05 85 8C                    ..
        lda     #$62                            ; 5B07 A9 62                    .b
        sta     $8B                             ; 5B09 85 8B                    ..
        lda     $8489                           ; 5B0B AD 89 84                 ...
        jsr     L5B7D                           ; 5B0E 20 7D 5B                  }[
        bne     L5B5F                           ; 5B11 D0 4C                    .L
        ldy     #$00                            ; 5B13 A0 00                    ..
L5B15:  lda     ($02),y                         ; 5B15 B1 02                    ..
        jsr     LFFA8                           ; 5B17 20 A8 FF                  ..
        iny                                     ; 5B1A C8                       .
        cpy     #$20                            ; 5B1B C0 20                    . 
        bcc     L5B15                           ; 5B1D 90 F6                    ..
        lda     #$0D                            ; 5B1F A9 0D                    ..
        jsr     LFFA8                           ; 5B21 20 A8 FF                  ..
        jsr     LFFAE                           ; 5B24 20 AE FF                  ..
        clc                                     ; 5B27 18                       .
        lda     L5B65                           ; 5B28 AD 65 5B                 .e[
        adc     #$20                            ; 5B2B 69 20                    i 
        sta     L5B65                           ; 5B2D 8D 65 5B                 .e[
        bcc     L5B35                           ; 5B30 90 03                    ..
        inc     L5B66                           ; 5B32 EE 66 5B                 .f[
L5B35:  lda     $03                             ; 5B35 A5 03                    ..
        cmp     #$5A                            ; 5B37 C9 5A                    .Z
        bne     L5B3F                           ; 5B39 D0 04                    ..
        lda     $02                             ; 5B3B A5 02                    ..
        cmp     #$E9                            ; 5B3D C9 E9                    ..
L5B3F:  bcs     L5B4F                           ; 5B3F B0 0E                    ..
        clc                                     ; 5B41 18                       .
        lda     #$20                            ; 5B42 A9 20                    . 
        adc     $02                             ; 5B44 65 02                    e.
        sta     $02                             ; 5B46 85 02                    ..
        bcc     L5B4C                           ; 5B48 90 02                    ..
        inc     $03                             ; 5B4A E6 03                    ..
L5B4C:  clv                                     ; 5B4C B8                       .
        bvc     L5B01                           ; 5B4D 50 B2                    P.
L5B4F:  lda     #$5B                            ; 5B4F A9 5B                    .[
        sta     $8C                             ; 5B51 85 8C                    ..
        lda     #$68                            ; 5B53 A9 68                    .h
        sta     $8B                             ; 5B55 85 8B                    ..
        lda     $8489                           ; 5B57 AD 89 84                 ...
        ldy     #$05                            ; 5B5A A0 05                    ..
        jsr     L5B6D                           ; 5B5C 20 6D 5B                  m[
L5B5F:  jmp     DoneWithIO                      ; 5B5F 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        eor     L572D                           ; 5B62 4D 2D 57                 M-W
L5B65:  brk                                     ; 5B65 00                       .
L5B66:  ora     $20                             ; 5B66 05 20                    . 
        eor     $452D                           ; 5B68 4D 2D 45                 M-E
        rts                                     ; 5B6B 60                       `

; ----------------------------------------------------------------------------
        .byte   $05                             ; 5B6C 05                       .
L5B6D:  jsr     L5B7D                           ; 5B6D 20 7D 5B                  }[
        bne     L5B7C                           ; 5B70 D0 0A                    ..
        lda     #$0D                            ; 5B72 A9 0D                    ..
        jsr     LFFA8                           ; 5B74 20 A8 FF                  ..
        jsr     LFFAE                           ; 5B77 20 AE FF                  ..
        ldx     #$00                            ; 5B7A A2 00                    ..
L5B7C:  rts                                     ; 5B7C 60                       `

; ----------------------------------------------------------------------------
L5B7D:  sty     L5BAA                           ; 5B7D 8C AA 5B                 ..[
        ldy     #$00                            ; 5B80 A0 00                    ..
        sty     $90                             ; 5B82 84 90                    ..
        jsr     LFFB1                           ; 5B84 20 B1 FF                  ..
        lda     $90                             ; 5B87 A5 90                    ..
        bne     L5BA4                           ; 5B89 D0 19                    ..
        lda     #$6F                            ; 5B8B A9 6F                    .o
        jsr     LFF93                           ; 5B8D 20 93 FF                  ..
        lda     $90                             ; 5B90 A5 90                    ..
        bne     L5BA4                           ; 5B92 D0 10                    ..
        ldy     #$00                            ; 5B94 A0 00                    ..
L5B96:  lda     ($8B),y                         ; 5B96 B1 8B                    ..
        jsr     LFFA8                           ; 5B98 20 A8 FF                  ..
        iny                                     ; 5B9B C8                       .
        cpy     L5BAA                           ; 5B9C CC AA 5B                 ..[
        bne     L5B96                           ; 5B9F D0 F5                    ..
        ldx     #$00                            ; 5BA1 A2 00                    ..
        rts                                     ; 5BA3 60                       `

; ----------------------------------------------------------------------------
L5BA4:  jsr     LFFAE                           ; 5BA4 20 AE FF                  ..
        ldx     #$0D                            ; 5BA7 A2 0D                    ..
        rts                                     ; 5BA9 60                       `

; ----------------------------------------------------------------------------
L5BAA:  brk                                     ; 5BAA 00                       .
L5BAB:  brk                                     ; 5BAB 00                       .
L5BAC:  brk                                     ; 5BAC 00                       .
        brk                                     ; 5BAD 00                       .
        brk                                     ; 5BAE 00                       .
        brk                                     ; 5BAF 00                       .
        brk                                     ; 5BB0 00                       .
        brk                                     ; 5BB1 00                       .
        brk                                     ; 5BB2 00                       .
        brk                                     ; 5BB3 00                       .
        brk                                     ; 5BB4 00                       .
        brk                                     ; 5BB5 00                       .
        brk                                     ; 5BB6 00                       .
        brk                                     ; 5BB7 00                       .
        brk                                     ; 5BB8 00                       .
        brk                                     ; 5BB9 00                       .
        brk                                     ; 5BBA 00                       .
        brk                                     ; 5BBB 00                       .
        brk                                     ; 5BBC 00                       .
        brk                                     ; 5BBD 00                       .
        brk                                     ; 5BBE 00                       .
        brk                                     ; 5BBF 00                       .
        brk                                     ; 5BC0 00                       .
        brk                                     ; 5BC1 00                       .
        brk                                     ; 5BC2 00                       .
        brk                                     ; 5BC3 00                       .
        brk                                     ; 5BC4 00                       .
        brk                                     ; 5BC5 00                       .
        brk                                     ; 5BC6 00                       .
        brk                                     ; 5BC7 00                       .
        brk                                     ; 5BC8 00                       .
        brk                                     ; 5BC9 00                       .
        brk                                     ; 5BCA 00                       .
        brk                                     ; 5BCB 00                       .
        brk                                     ; 5BCC 00                       .
        brk                                     ; 5BCD 00                       .
        brk                                     ; 5BCE 00                       .
        brk                                     ; 5BCF 00                       .
        brk                                     ; 5BD0 00                       .
        brk                                     ; 5BD1 00                       .
        brk                                     ; 5BD2 00                       .
L5BD3:  ldy     #$00                            ; 5BD3 A0 00                    ..
        sty     $90                             ; 5BD5 84 90                    ..
        jsr     LFFB4                           ; 5BD7 20 B4 FF                  ..
        lda     $90                             ; 5BDA A5 90                    ..
        bne     L5BFE                           ; 5BDC D0 20                    . 
        lda     #$6F                            ; 5BDE A9 6F                    .o
        jsr     LFF96                           ; 5BE0 20 96 FF                  ..
        lda     $90                             ; 5BE3 A5 90                    ..
        bne     L5BFE                           ; 5BE5 D0 17                    ..
        ldy     #$00                            ; 5BE7 A0 00                    ..
L5BE9:  jsr     LFFA5                           ; 5BE9 20 A5 FF                  ..
        ldx     $90                             ; 5BEC A6 90                    ..
        bne     L5BF8                           ; 5BEE D0 08                    ..
        sta     L5BAB,y                         ; 5BF0 99 AB 5B                 ..[
        iny                                     ; 5BF3 C8                       .
        cpy     #$28                            ; 5BF4 C0 28                    .(
        bcc     L5BE9                           ; 5BF6 90 F1                    ..
L5BF8:  jsr     LFFAB                           ; 5BF8 20 AB FF                  ..
        ldx     #$00                            ; 5BFB A2 00                    ..
        rts                                     ; 5BFD 60                       `

; ----------------------------------------------------------------------------
L5BFE:  jsr     LFFAB                           ; 5BFE 20 AB FF                  ..
        ldx     #$0D                            ; 5C01 A2 0D                    ..
        rts                                     ; 5C03 60                       `

; ----------------------------------------------------------------------------
L5C04:  jsr     L50FD                           ; 5C04 20 FD 50                  .P
        ldx     #$01                            ; 5C07 A2 01                    ..
        jsr     L519F                           ; 5C09 20 9F 51                  .Q
        jsr     L50D7                           ; 5C0C 20 D7 50                  .P
        ldx     L5430                           ; 5C0F AE 30 54                 .0T
        rts                                     ; 5C12 60                       `

; ----------------------------------------------------------------------------
L5C13:  jsr     L9050                           ; 5C13 20 50 90                  P.
        lda     #$00                            ; 5C16 A9 00                    ..
        sta     $06                             ; 5C18 85 06                    ..
        jsr     L9066                           ; 5C1A 20 66 90                  f.
        lda     #$82                            ; 5C1D A9 82                    ..
        sta     $03                             ; 5C1F 85 03                    ..
        lda     #$90                            ; 5C21 A9 90                    ..
        sta     $02                             ; 5C23 85 02                    ..
        lda     #$50                            ; 5C25 A9 50                    .P
        sta     $05                             ; 5C27 85 05                    ..
        lda     #$0F                            ; 5C29 A9 0F                    ..
        sta     $04                             ; 5C2B 85 04                    ..
        ldx     #$02                            ; 5C2D A2 02                    ..
        ldy     #$04                            ; 5C2F A0 04                    ..
        lda     #$10                            ; 5C31 A9 10                    ..
        jsr     CopyFString                     ; 5C33 20 68 C2                  h.
        lda     $82A3                           ; 5C36 AD A3 82                 ...
        sta     L54B3                           ; 5C39 8D B3 54                 ..T
        lda     $82A2                           ; 5C3C AD A2 82                 ...
        sta     L54B2                           ; 5C3F 8D B2 54                 ..T
        lda     $82AC                           ; 5C42 AD AC 82                 ...
        sta     L5C77                           ; 5C45 8D 77 5C                 .w\
        lda     $82AB                           ; 5C48 AD AB 82                 ...
        sta     L5C76                           ; 5C4B 8D 76 5C                 .v\
        jsr     L5C78                           ; 5C4E 20 78 5C                  x\
        lda     L5C77                           ; 5C51 AD 77 5C                 .w\
        sta     $82AC                           ; 5C54 8D AC 82                 ...
        lda     L5C76                           ; 5C57 AD 76 5C                 .v\
        sta     $82AB                           ; 5C5A 8D AB 82                 ...
        jsr     L5C9C                           ; 5C5D 20 9C 5C                  .\
        jsr     L5CD9                           ; 5C60 20 D9 5C                  .\
        jsr     PutDirHead                      ; 5C63 20 4A C2                  J.
        stx     L5430                           ; 5C66 8E 30 54                 .0T
        beq     L5C75                           ; 5C69 F0 0A                    ..
        lda     #$54                            ; 5C6B A9 54                    .T
        sta     L53D7                           ; 5C6D 8D D7 53                 ..S
        lda     #$03                            ; 5C70 A9 03                    ..
        sta     L53D6                           ; 5C72 8D D6 53                 ..S
L5C75:  rts                                     ; 5C75 60                       `

; ----------------------------------------------------------------------------
L5C76:  brk                                     ; 5C76 00                       .
L5C77:  brk                                     ; 5C77 00                       .
L5C78:  lda     $88C6                           ; 5C78 AD C6 88                 ...
        and     #$0F                            ; 5C7B 29 0F                    ).
        cmp     #$04                            ; 5C7D C9 04                    ..
        bne     L5C84                           ; 5C7F D0 03                    ..
        jmp     L5CE4                           ; 5C81 4C E4 5C                 L.\

; ----------------------------------------------------------------------------
L5C84:  cmp     #$03                            ; 5C84 C9 03                    ..
        bne     L5C8B                           ; 5C86 D0 03                    ..
        jmp     L5653                           ; 5C88 4C 53 56                 LSV

; ----------------------------------------------------------------------------
L5C8B:  cmp     #$02                            ; 5C8B C9 02                    ..
        bne     L5C92                           ; 5C8D D0 03                    ..
        jmp     L5D52                           ; 5C8F 4C 52 5D                 LR]

; ----------------------------------------------------------------------------
L5C92:  cmp     #$01                            ; 5C92 C9 01                    ..
        bne     L5C99                           ; 5C94 D0 03                    ..
        jmp     L5D7E                           ; 5C96 4C 7E 5D                 L~]

; ----------------------------------------------------------------------------
L5C99:  ldx     #$0D                            ; 5C99 A2 0D                    ..
        rts                                     ; 5C9B 60                       `

; ----------------------------------------------------------------------------
L5C9C:  lda     $82AC                           ; 5C9C AD AC 82                 ...
        sta     $05                             ; 5C9F 85 05                    ..
        lda     $82AB                           ; 5CA1 AD AB 82                 ...
        sta     $04                             ; 5CA4 85 04                    ..
        bne     L5CA9                           ; 5CA6 D0 01                    ..
        rts                                     ; 5CA8 60                       `

; ----------------------------------------------------------------------------
L5CA9:  lda     $05                             ; 5CA9 A5 05                    ..
        sta     $0F                             ; 5CAB 85 0F                    ..
        lda     $04                             ; 5CAD A5 04                    ..
        sta     $0E                             ; 5CAF 85 0E                    ..
        jsr     L9048                           ; 5CB1 20 48 90                  H.
L5CB4:  jsr     L903C                           ; 5CB4 20 3C 90                  <.
        stx     $8002                           ; 5CB7 8E 02 80                 ...
        stx     $8022                           ; 5CBA 8E 22 80                 .".
        stx     $8042                           ; 5CBD 8E 42 80                 .B.
        stx     $8062                           ; 5CC0 8E 62 80                 .b.
        stx     $8082                           ; 5CC3 8E 82 80                 ...
        stx     $80A2                           ; 5CC6 8E A2 80                 ...
        stx     $80C2                           ; 5CC9 8E C2 80                 ...
        stx     $80E2                           ; 5CCC 8E E2 80                 ...
        stx     $8000                           ; 5CCF 8E 00 80                 ...
        dex                                     ; 5CD2 CA                       .
        stx     $8001                           ; 5CD3 8E 01 80                 ...
        jmp     PutBlock                        ; 5CD6 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L5CD9:  lda     #$01                            ; 5CD9 A9 01                    ..
        sta     $0E                             ; 5CDB 85 0E                    ..
        lda     #$00                            ; 5CDD A9 00                    ..
        sta     $0F                             ; 5CDF 85 0F                    ..
        jmp     L9048                           ; 5CE1 4C 48 90                 LH.

; ----------------------------------------------------------------------------
L5CE4:  jsr     GetDirHead                      ; 5CE4 20 47 C2                  G.
        lda     #$01                            ; 5CE7 A9 01                    ..
        sta     $04                             ; 5CE9 85 04                    ..
        lda     #$22                            ; 5CEB A9 22                    ."
        sta     $05                             ; 5CED 85 05                    ..
        jsr     L5DAE                           ; 5CEF 20 AE 5D                  .]
        lda     $9062                           ; 5CF2 AD 62 90                 .b.
        sta     L5DAD                           ; 5CF5 8D AD 5D                 ..]
        jsr     L5D35                           ; 5CF8 20 35 5D                  5]
        lda     #$01                            ; 5CFB A9 01                    ..
        sta     $0E                             ; 5CFD 85 0E                    ..
        lda     #$22                            ; 5CFF A9 22                    ."
        sta     $0F                             ; 5D01 85 0F                    ..
        jsr     L5D2D                           ; 5D03 20 2D 5D                  -]
        jmp     PutDirHead                      ; 5D06 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D09:  jsr     GetDirHead                      ; 5D09 20 47 C2                  G.
        lda     #$28                            ; 5D0C A9 28                    .(
        sta     $04                             ; 5D0E 85 04                    ..
        lda     #$03                            ; 5D10 A9 03                    ..
        sta     $05                             ; 5D12 85 05                    ..
        jsr     L5DAE                           ; 5D14 20 AE 5D                  .]
        lda     #$50                            ; 5D17 A9 50                    .P
        sta     L5DAD                           ; 5D19 8D AD 5D                 ..]
        jsr     L5D35                           ; 5D1C 20 35 5D                  5]
        lda     #$28                            ; 5D1F A9 28                    .(
        sta     $0E                             ; 5D21 85 0E                    ..
        lda     #$03                            ; 5D23 A9 03                    ..
        sta     $0F                             ; 5D25 85 0F                    ..
        jsr     L5D2D                           ; 5D27 20 2D 5D                  -]
        jmp     PutDirHead                      ; 5D2A 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D2D:  jsr     L9048                           ; 5D2D 20 48 90                  H.
        dec     $0F                             ; 5D30 C6 0F                    ..
        bpl     L5D2D                           ; 5D32 10 F9                    ..
        rts                                     ; 5D34 60                       `

; ----------------------------------------------------------------------------
L5D35:  lda     #$01                            ; 5D35 A9 01                    ..
        sta     $0E                             ; 5D37 85 0E                    ..
L5D39:  lda     #$00                            ; 5D39 A9 00                    ..
        sta     $0F                             ; 5D3B 85 0F                    ..
L5D3D:  jsr     FreeBlock                       ; 5D3D 20 B9 C2                  ..
        cpx     #$02                            ; 5D40 E0 02                    ..
        beq     L5D48                           ; 5D42 F0 04                    ..
        inc     $0F                             ; 5D44 E6 0F                    ..
        bne     L5D3D                           ; 5D46 D0 F5                    ..
L5D48:  inc     $0E                             ; 5D48 E6 0E                    ..
        lda     L5DAD                           ; 5D4A AD AD 5D                 ..]
        cmp     $0E                             ; 5D4D C5 0E                    ..
        bcs     L5D39                           ; 5D4F B0 E8                    ..
        rts                                     ; 5D51 60                       `

; ----------------------------------------------------------------------------
L5D52:  jsr     GetDirHead                      ; 5D52 20 47 C2                  G.
        bit     $8203                           ; 5D55 2C 03 82                 ,..
        bpl     L5D89                           ; 5D58 10 2F                    ./
        ldy     #$00                            ; 5D5A A0 00                    ..
        tya                                     ; 5D5C 98                       .
L5D5D:  sta     $8900,y                         ; 5D5D 99 00 89                 ...
        iny                                     ; 5D60 C8                       .
        bne     L5D5D                           ; 5D61 D0 FA                    ..
        ldy     #$DD                            ; 5D63 A0 DD                    ..
L5D65:  sta     $8200,y                         ; 5D65 99 00 82                 ...
        iny                                     ; 5D68 C8                       .
        bne     L5D65                           ; 5D69 D0 FA                    ..
        lda     #$46                            ; 5D6B A9 46                    .F
        jsr     L5D91                           ; 5D6D 20 91 5D                  .]
        lda     #$35                            ; 5D70 A9 35                    .5
        sta     $0E                             ; 5D72 85 0E                    ..
        lda     #$12                            ; 5D74 A9 12                    ..
        sta     $0F                             ; 5D76 85 0F                    ..
        jsr     L5D2D                           ; 5D78 20 2D 5D                  -]
        jmp     PutDirHead                      ; 5D7B 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D7E:  jsr     GetDirHead                      ; 5D7E 20 47 C2                  G.
        bit     $8203                           ; 5D81 2C 03 82                 ,..
        bpl     L5D89                           ; 5D84 10 03                    ..
        ldx     #$06                            ; 5D86 A2 06                    ..
        rts                                     ; 5D88 60                       `

; ----------------------------------------------------------------------------
L5D89:  lda     #$23                            ; 5D89 A9 23                    .#
        jsr     L5D91                           ; 5D8B 20 91 5D                  .]
        jmp     PutDirHead                      ; 5D8E 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5D91:  sta     L5DAD                           ; 5D91 8D AD 5D                 ..]
        lda     #$12                            ; 5D94 A9 12                    ..
        sta     $04                             ; 5D96 85 04                    ..
        lda     #$01                            ; 5D98 A9 01                    ..
        sta     $05                             ; 5D9A 85 05                    ..
        jsr     L5DAE                           ; 5D9C 20 AE 5D                  .]
        jsr     L5D35                           ; 5D9F 20 35 5D                  5]
        lda     #$12                            ; 5DA2 A9 12                    ..
        sta     $0E                             ; 5DA4 85 0E                    ..
        lda     #$01                            ; 5DA6 A9 01                    ..
        sta     $0F                             ; 5DA8 85 0F                    ..
        jmp     L5D2D                           ; 5DAA 4C 2D 5D                 L-]

; ----------------------------------------------------------------------------
L5DAD:  brk                                     ; 5DAD 00                       .
L5DAE:  jsr     ExitTurbo                       ; 5DAE 20 32 C2                  2.
        jsr     EnterTurbo                      ; 5DB1 20 14 C2                  ..
        jsr     L903C                           ; 5DB4 20 3C 90                  <.
        ldy     #$00                            ; 5DB7 A0 00                    ..
L5DB9:  lda     #$00                            ; 5DB9 A9 00                    ..
        sta     $8002,y                         ; 5DBB 99 02 80                 ...
        tya                                     ; 5DBE 98                       .
        clc                                     ; 5DBF 18                       .
        adc     #$20                            ; 5DC0 69 20                    i 
        tay                                     ; 5DC2 A8                       .
        bcc     L5DB9                           ; 5DC3 90 F4                    ..
        ldx     #$FF                            ; 5DC5 A2 FF                    ..
        stx     $8001                           ; 5DC7 8E 01 80                 ...
        inx                                     ; 5DCA E8                       .
        stx     $8000                           ; 5DCB 8E 00 80                 ...
        jmp     PutBlock                        ; 5DCE 4C E7 C1                 L..

; ----------------------------------------------------------------------------
