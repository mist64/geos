; da65 V2.15
; Created:    2016-09-01 03:50:44
; Input file: reu0.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L0810           := $0810
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
        jmp     L51B6                           ; 5000 4C B6 51                 L.Q

; ----------------------------------------------------------------------------
        jmp     L51D8                           ; 5003 4C D8 51                 L.Q

; ----------------------------------------------------------------------------
        jmp     L51E6                           ; 5006 4C E6 51                 L.Q

; ----------------------------------------------------------------------------
        jmp     L51F3                           ; 5009 4C F3 51                 L.Q

; ----------------------------------------------------------------------------
        jmp     L5208                           ; 500C 4C 08 52                 L.R

; ----------------------------------------------------------------------------
        jmp     L5235                           ; 500F 4C 35 52                 L5R

; ----------------------------------------------------------------------------
        jmp     L5266                           ; 5012 4C 66 52                 LfR

; ----------------------------------------------------------------------------
        jmp     L52C8                           ; 5015 4C C8 52                 L.R

; ----------------------------------------------------------------------------
        jmp     L5325                           ; 5018 4C 25 53                 L%S

; ----------------------------------------------------------------------------
        jmp     L5374                           ; 501B 4C 74 53                 LtS

; ----------------------------------------------------------------------------
        jmp     L52F4                           ; 501E 4C F4 52                 L.R

; ----------------------------------------------------------------------------
        eor     $2252                           ; 5021 4D 52 22                 MR"
L5024:  brk                                     ; 5024 00                       .
L5025:  ror     a:$00,x                         ; 5025 7E 00 00                 ~..
        brk                                     ; 5028 00                       .
        brk                                     ; 5029 00                       .
        brk                                     ; 502A 00                       .
        brk                                     ; 502B 00                       .
        brk                                     ; 502C 00                       .
        brk                                     ; 502D 00                       .
        brk                                     ; 502E 00                       .
        brk                                     ; 502F 00                       .
        brk                                     ; 5030 00                       .
        brk                                     ; 5031 00                       .
        brk                                     ; 5032 00                       .
        brk                                     ; 5033 00                       .
        brk                                     ; 5034 00                       .
        brk                                     ; 5035 00                       .
        brk                                     ; 5036 00                       .
        brk                                     ; 5037 00                       .
        brk                                     ; 5038 00                       .
        brk                                     ; 5039 00                       .
        brk                                     ; 503A 00                       .
        brk                                     ; 503B 00                       .
        brk                                     ; 503C 00                       .
        brk                                     ; 503D 00                       .
        brk                                     ; 503E 00                       .
        brk                                     ; 503F 00                       .
        brk                                     ; 5040 00                       .
        brk                                     ; 5041 00                       .
        brk                                     ; 5042 00                       .
        brk                                     ; 5043 00                       .
        brk                                     ; 5044 00                       .
L5045:  ror     a:$00,x                         ; 5045 7E 00 00                 ~..
        brk                                     ; 5048 00                       .
        brk                                     ; 5049 00                       .
        brk                                     ; 504A 00                       .
        brk                                     ; 504B 00                       .
        brk                                     ; 504C 00                       .
        brk                                     ; 504D 00                       .
        brk                                     ; 504E 00                       .
        brk                                     ; 504F 00                       .
        brk                                     ; 5050 00                       .
        brk                                     ; 5051 00                       .
        brk                                     ; 5052 00                       .
        brk                                     ; 5053 00                       .
        brk                                     ; 5054 00                       .
        brk                                     ; 5055 00                       .
        brk                                     ; 5056 00                       .
        brk                                     ; 5057 00                       .
        brk                                     ; 5058 00                       .
        brk                                     ; 5059 00                       .
        brk                                     ; 505A 00                       .
        brk                                     ; 505B 00                       .
        brk                                     ; 505C 00                       .
        brk                                     ; 505D 00                       .
        brk                                     ; 505E 00                       .
        brk                                     ; 505F 00                       .
        brk                                     ; 5060 00                       .
        brk                                     ; 5061 00                       .
        brk                                     ; 5062 00                       .
        brk                                     ; 5063 00                       .
L5064:  brk                                     ; 5064 00                       .
        brk                                     ; 5065 00                       .
        brk                                     ; 5066 00                       .
        brk                                     ; 5067 00                       .
        brk                                     ; 5068 00                       .
        brk                                     ; 5069 00                       .
        brk                                     ; 506A 00                       .
        brk                                     ; 506B 00                       .
L506C:  brk                                     ; 506C 00                       .
        brk                                     ; 506D 00                       .
        brk                                     ; 506E 00                       .
        brk                                     ; 506F 00                       .
        brk                                     ; 5070 00                       .
        brk                                     ; 5071 00                       .
        brk                                     ; 5072 00                       .
        brk                                     ; 5073 00                       .
L5074:  brk                                     ; 5074 00                       .
        brk                                     ; 5075 00                       .
        brk                                     ; 5076 00                       .
        brk                                     ; 5077 00                       .
        brk                                     ; 5078 00                       .
        brk                                     ; 5079 00                       .
        brk                                     ; 507A 00                       .
        brk                                     ; 507B 00                       .
        brk                                     ; 507C 00                       .
        brk                                     ; 507D 00                       .
        brk                                     ; 507E 00                       .
        brk                                     ; 507F 00                       .
        brk                                     ; 5080 00                       .
        brk                                     ; 5081 00                       .
        brk                                     ; 5082 00                       .
        brk                                     ; 5083 00                       .
        brk                                     ; 5084 00                       .
        brk                                     ; 5085 00                       .
        brk                                     ; 5086 00                       .
        brk                                     ; 5087 00                       .
        brk                                     ; 5088 00                       .
        brk                                     ; 5089 00                       .
        brk                                     ; 508A 00                       .
        brk                                     ; 508B 00                       .
        brk                                     ; 508C 00                       .
        brk                                     ; 508D 00                       .
        brk                                     ; 508E 00                       .
        brk                                     ; 508F 00                       .
        brk                                     ; 5090 00                       .
        brk                                     ; 5091 00                       .
        brk                                     ; 5092 00                       .
        brk                                     ; 5093 00                       .
        brk                                     ; 5094 00                       .
        brk                                     ; 5095 00                       .
        brk                                     ; 5096 00                       .
        brk                                     ; 5097 00                       .
        brk                                     ; 5098 00                       .
        brk                                     ; 5099 00                       .
        brk                                     ; 509A 00                       .
        brk                                     ; 509B 00                       .
        brk                                     ; 509C 00                       .
        brk                                     ; 509D 00                       .
        brk                                     ; 509E 00                       .
        brk                                     ; 509F 00                       .
        brk                                     ; 50A0 00                       .
        brk                                     ; 50A1 00                       .
        brk                                     ; 50A2 00                       .
        brk                                     ; 50A3 00                       .
        brk                                     ; 50A4 00                       .
        brk                                     ; 50A5 00                       .
        brk                                     ; 50A6 00                       .
        brk                                     ; 50A7 00                       .
        brk                                     ; 50A8 00                       .
        brk                                     ; 50A9 00                       .
        brk                                     ; 50AA 00                       .
        brk                                     ; 50AB 00                       .
        brk                                     ; 50AC 00                       .
        brk                                     ; 50AD 00                       .
        brk                                     ; 50AE 00                       .
        brk                                     ; 50AF 00                       .
        brk                                     ; 50B0 00                       .
        brk                                     ; 50B1 00                       .
        brk                                     ; 50B2 00                       .
        brk                                     ; 50B3 00                       .
        brk                                     ; 50B4 00                       .
        brk                                     ; 50B5 00                       .
        brk                                     ; 50B6 00                       .
        brk                                     ; 50B7 00                       .
        brk                                     ; 50B8 00                       .
        brk                                     ; 50B9 00                       .
        brk                                     ; 50BA 00                       .
        brk                                     ; 50BB 00                       .
        brk                                     ; 50BC 00                       .
        brk                                     ; 50BD 00                       .
        brk                                     ; 50BE 00                       .
        brk                                     ; 50BF 00                       .
        brk                                     ; 50C0 00                       .
        brk                                     ; 50C1 00                       .
        brk                                     ; 50C2 00                       .
        brk                                     ; 50C3 00                       .
        brk                                     ; 50C4 00                       .
        brk                                     ; 50C5 00                       .
        brk                                     ; 50C6 00                       .
        brk                                     ; 50C7 00                       .
        brk                                     ; 50C8 00                       .
        brk                                     ; 50C9 00                       .
        brk                                     ; 50CA 00                       .
        brk                                     ; 50CB 00                       .
        brk                                     ; 50CC 00                       .
        brk                                     ; 50CD 00                       .
        brk                                     ; 50CE 00                       .
        brk                                     ; 50CF 00                       .
        brk                                     ; 50D0 00                       .
        brk                                     ; 50D1 00                       .
        brk                                     ; 50D2 00                       .
        brk                                     ; 50D3 00                       .
        brk                                     ; 50D4 00                       .
        brk                                     ; 50D5 00                       .
        brk                                     ; 50D6 00                       .
        brk                                     ; 50D7 00                       .
        brk                                     ; 50D8 00                       .
        brk                                     ; 50D9 00                       .
        brk                                     ; 50DA 00                       .
        brk                                     ; 50DB 00                       .
        brk                                     ; 50DC 00                       .
        brk                                     ; 50DD 00                       .
        brk                                     ; 50DE 00                       .
        brk                                     ; 50DF 00                       .
        brk                                     ; 50E0 00                       .
        brk                                     ; 50E1 00                       .
        brk                                     ; 50E2 00                       .
        brk                                     ; 50E3 00                       .
        brk                                     ; 50E4 00                       .
        brk                                     ; 50E5 00                       .
        brk                                     ; 50E6 00                       .
        brk                                     ; 50E7 00                       .
        brk                                     ; 50E8 00                       .
        brk                                     ; 50E9 00                       .
        brk                                     ; 50EA 00                       .
        brk                                     ; 50EB 00                       .
        brk                                     ; 50EC 00                       .
        brk                                     ; 50ED 00                       .
        brk                                     ; 50EE 00                       .
        brk                                     ; 50EF 00                       .
        brk                                     ; 50F0 00                       .
        brk                                     ; 50F1 00                       .
        brk                                     ; 50F2 00                       .
        brk                                     ; 50F3 00                       .
        brk                                     ; 50F4 00                       .
        brk                                     ; 50F5 00                       .
        brk                                     ; 50F6 00                       .
        brk                                     ; 50F7 00                       .
        brk                                     ; 50F8 00                       .
        brk                                     ; 50F9 00                       .
        brk                                     ; 50FA 00                       .
        brk                                     ; 50FB 00                       .
        brk                                     ; 50FC 00                       .
        brk                                     ; 50FD 00                       .
        brk                                     ; 50FE 00                       .
        brk                                     ; 50FF 00                       .
        brk                                     ; 5100 00                       .
        brk                                     ; 5101 00                       .
        brk                                     ; 5102 00                       .
        brk                                     ; 5103 00                       .
        brk                                     ; 5104 00                       .
        .byte   $42                             ; 5105 42                       B
        eor     ($7B),y                         ; 5106 51 7B                    Q{
        .byte   $51                             ; 5108 51                       Q
L5109:  eor     $3517,y                         ; 5109 59 17 35                 Y.5
        .byte   $1F                             ; 510C 1F                       .
        .byte   $2F                             ; 510D 2F                       /
        and     $FFFF,x                         ; 510E 3D FF FF                 =..
        .byte   $FF                             ; 5111 FF                       .
        .byte   $FF                             ; 5112 FF                       .
        .byte   $FF                             ; 5113 FF                       .
        .byte   $FF                             ; 5114 FF                       .
        .byte   $FF                             ; 5115 FF                       .
        .byte   $FF                             ; 5116 FF                       .
        .byte   $FF                             ; 5117 FF                       .
        .byte   $FF                             ; 5118 FF                       .
        .byte   $FF                             ; 5119 FF                       .
        adc     #$15                            ; 511A 69 15                    i.
        .byte   $1F                             ; 511C 1F                       .
        .byte   $33                             ; 511D 33                       3
        and     $1B,x                           ; 511E 35 1B                    5.
        .byte   $FF                             ; 5120 FF                       .
        .byte   $FF                             ; 5121 FF                       .
        .byte   $FF                             ; 5122 FF                       .
        .byte   $FF                             ; 5123 FF                       .
        .byte   $FF                             ; 5124 FF                       .
        .byte   $FF                             ; 5125 FF                       .
        .byte   $FF                             ; 5126 FF                       .
        .byte   $FF                             ; 5127 FF                       .
        .byte   $FF                             ; 5128 FF                       .
        .byte   $FF                             ; 5129 FF                       .
        .byte   $FF                             ; 512A FF                       .
        eor     ($6F),y                         ; 512B 51 6F                    Qo
        lda     $9D                             ; 512D A5 9D                    ..
        .byte   $9B                             ; 512F 9B                       .
        sta     $7D9B,y                         ; 5130 99 9B 7D                 ..}
        .byte   $FF                             ; 5133 FF                       .
        adc     ($11,x)                         ; 5134 61 11                    a.
        .byte   $23                             ; 5136 23                       #
        and     $1B,x                           ; 5137 35 1B                    5.
        .byte   $8B                             ; 5139 8B                       .
        .byte   $BF                             ; 513A BF                       .
        .byte   $FF                             ; 513B FF                       .
        .byte   $53                             ; 513C 53                       S
        adc     $8B63                           ; 513D 6D 63 8B                 mc.
        .byte   $BF                             ; 5140 BF                       .
        .byte   $FF                             ; 5141 FF                       .
        jsr     L51A7                           ; 5142 20 A7 51                  .Q
        lda     $19                             ; 5145 A5 19                    ..
        pha                                     ; 5147 48                       H
        lda     $18                             ; 5148 A5 18                    ..
        pha                                     ; 514A 48                       H
        jsr     L5194                           ; 514B 20 94 51                  .Q
        jsr     L518B                           ; 514E 20 8B 51                  .Q
        lda     #$20                            ; 5151 A9 20                    . 
        jsr     PutChar                         ; 5153 20 45 C1                  E.
        jsr     L518E                           ; 5156 20 8E 51                  .Q
        pla                                     ; 5159 68                       h
        sta     $18                             ; 515A 85 18                    ..
        pla                                     ; 515C 68                       h
        sta     $19                             ; 515D 85 19                    ..
        clc                                     ; 515F 18                       .
        lda     $05                             ; 5160 A5 05                    ..
        adc     #$0A                            ; 5162 69 0A                    i.
        sta     $05                             ; 5164 85 05                    ..
        jsr     L5197                           ; 5166 20 97 51                  .Q
        jsr     L5191                           ; 5169 20 91 51                  .Q
L516C:  ldx     #$38                            ; 516C A2 38                    .8
L516E:  lda     L5109,x                         ; 516E BD 09 51                 ..Q
        asl     a                               ; 5171 0A                       .
        eor     #$FF                            ; 5172 49 FF                    I.
        sta     L5109,x                         ; 5174 9D 09 51                 ..Q
        dex                                     ; 5177 CA                       .
        bpl     L516E                           ; 5178 10 F4                    ..
        rts                                     ; 517A 60                       `

; ----------------------------------------------------------------------------
        jsr     L51A7                           ; 517B 20 A7 51                  .Q
        ldy     #$2A                            ; 517E A0 2A                    .*
L5180:  lda     L5109,y                         ; 5180 B9 09 51                 ..Q
        sta     ($02),y                         ; 5183 91 02                    ..
        dey                                     ; 5185 88                       .
        bpl     L5180                           ; 5186 10 F8                    ..
        jmp     L516C                           ; 5188 4C 6C 51                 LlQ

; ----------------------------------------------------------------------------
L518B:  lda     #$00                            ; 518B A9 00                    ..
        .byte   $2C                             ; 518D 2C                       ,
L518E:  lda     #$11                            ; 518E A9 11                    ..
        .byte   $2C                             ; 5190 2C                       ,
L5191:  lda     #$22                            ; 5191 A9 22                    ."
        .byte   $2C                             ; 5193 2C                       ,
L5194:  lda     #$2B                            ; 5194 A9 2B                    .+
        .byte   $2C                             ; 5196 2C                       ,
L5197:  lda     #$33                            ; 5197 A9 33                    .3
        clc                                     ; 5199 18                       .
        adc     #$09                            ; 519A 69 09                    i.
        sta     $02                             ; 519C 85 02                    ..
        lda     #$51                            ; 519E A9 51                    .Q
        adc     #$00                            ; 51A0 69 00                    i.
        sta     $03                             ; 51A2 85 03                    ..
        jmp     PutString                       ; 51A4 4C 48 C1                 LH.

; ----------------------------------------------------------------------------
L51A7:  ldx     #$38                            ; 51A7 A2 38                    .8
L51A9:  lda     L5109,x                         ; 51A9 BD 09 51                 ..Q
        eor     #$FF                            ; 51AC 49 FF                    I.
        lsr     a                               ; 51AE 4A                       J
        sta     L5109,x                         ; 51AF 9D 09 51                 ..Q
        dex                                     ; 51B2 CA                       .
        bpl     L51A9                           ; 51B3 10 F4                    ..
        rts                                     ; 51B5 60                       `

; ----------------------------------------------------------------------------
L51B6:  ldy     #$1F                            ; 51B6 A0 1F                    ..
L51B8:  lda     L5025,y                         ; 51B8 B9 25 50                 .%P
        sta     L5045,y                         ; 51BB 99 45 50                 .EP
        dey                                     ; 51BE 88                       .
        bpl     L51B8                           ; 51BF 10 F7                    ..
L51C1:  tya                                     ; 51C1 98                       .
        pha                                     ; 51C2 48                       H
        ldy     #$00                            ; 51C3 A0 00                    ..
        tya                                     ; 51C5 98                       .
L51C6:  eor     L5025,y                         ; 51C6 59 25 50                 Y%P
        clc                                     ; 51C9 18                       .
        adc     L5025,y                         ; 51CA 79 25 50                 y%P
        iny                                     ; 51CD C8                       .
        cpy     #$E0                            ; 51CE C0 E0                    ..
        bcc     L51C6                           ; 51D0 90 F4                    ..
        sta     L5024                           ; 51D2 8D 24 50                 .$P
        pla                                     ; 51D5 68                       h
        tay                                     ; 51D6 A8                       .
        rts                                     ; 51D7 60                       `

; ----------------------------------------------------------------------------
L51D8:  ldy     #$1F                            ; 51D8 A0 1F                    ..
L51DA:  lda     L5045,y                         ; 51DA B9 45 50                 .EP
        sta     L5025,y                         ; 51DD 99 25 50                 .%P
        dey                                     ; 51E0 88                       .
        bpl     L51DA                           ; 51E1 10 F7                    ..
        jmp     L51C1                           ; 51E3 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L51E6:  ldy     #$1F                            ; 51E6 A0 1F                    ..
        lda     #$00                            ; 51E8 A9 00                    ..
L51EA:  sta     L5045,y                         ; 51EA 99 45 50                 .EP
        dey                                     ; 51ED 88                       .
        bpl     L51EA                           ; 51EE 10 FA                    ..
        jmp     L51C1                           ; 51F0 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L51F3:  jsr     L5212                           ; 51F3 20 12 52                  .R
        bcs     L520F                           ; 51F6 B0 17                    ..
        beq     L520F                           ; 51F8 F0 15                    ..
L51FA:  lda     L522D,x                         ; 51FA BD 2D 52                 .-R
        eor     L5045,y                         ; 51FD 59 45 50                 YEP
        sta     L5045,y                         ; 5200 99 45 50                 .EP
        ldx     #$00                            ; 5203 A2 00                    ..
        jmp     L51C1                           ; 5205 4C C1 51                 L.Q

; ----------------------------------------------------------------------------
L5208:  jsr     L5212                           ; 5208 20 12 52                  .R
        bcs     L520F                           ; 520B B0 02                    ..
        beq     L51FA                           ; 520D F0 EB                    ..
L520F:  ldx     #$06                            ; 520F A2 06                    ..
        rts                                     ; 5211 60                       `

; ----------------------------------------------------------------------------
L5212:  sec                                     ; 5212 38                       8
        lda     $0E                             ; 5213 A5 0E                    ..
        beq     L522C                           ; 5215 F0 15                    ..
        cmp     $88C3                           ; 5217 CD C3 88                 ...
        bcs     L522C                           ; 521A B0 10                    ..
        pha                                     ; 521C 48                       H
        lsr     a                               ; 521D 4A                       J
        lsr     a                               ; 521E 4A                       J
        lsr     a                               ; 521F 4A                       J
        tay                                     ; 5220 A8                       .
        pla                                     ; 5221 68                       h
        and     #$07                            ; 5222 29 07                    ).
        tax                                     ; 5224 AA                       .
        lda     L522D,x                         ; 5225 BD 2D 52                 .-R
        and     L5045,y                         ; 5228 39 45 50                 9EP
        clc                                     ; 522B 18                       .
L522C:  rts                                     ; 522C 60                       `

; ----------------------------------------------------------------------------
L522D:  .byte   $80                             ; 522D 80                       .
        rti                                     ; 522E 40                       @

; ----------------------------------------------------------------------------
        jsr     L0810                           ; 522F 20 10 08                  ..
        .byte   $04                             ; 5232 04                       .
        .byte   $02                             ; 5233 02                       .
        .byte   $01                             ; 5234 01                       .
L5235:  jsr     L51B6                           ; 5235 20 B6 51                  .Q
        ldx     $88C3                           ; 5238 AE C3 88                 ...
        dex                                     ; 523B CA                       .
        stx     $06                             ; 523C 86 06                    ..
        lda     #$00                            ; 523E A9 00                    ..
        sta     $08                             ; 5240 85 08                    ..
        jsr     L5266                           ; 5242 20 66 52                  fR
        lda     $0F                             ; 5245 A5 0F                    ..
        sta     $06                             ; 5247 85 06                    ..
        jsr     L51B6                           ; 5249 20 B6 51                  .Q
        lda     #$00                            ; 524C A9 00                    ..
        sta     $0A                             ; 524E 85 0A                    ..
        sta     $0B                             ; 5250 85 0B                    ..
        lda     #$01                            ; 5252 A9 01                    ..
        sta     $0E                             ; 5254 85 0E                    ..
L5256:  jsr     L5212                           ; 5256 20 12 52                  .R
        bcs     L5263                           ; 5259 B0 08                    ..
        beq     L525F                           ; 525B F0 02                    ..
        inc     $0B                             ; 525D E6 0B                    ..
L525F:  inc     $0E                             ; 525F E6 0E                    ..
        bne     L5256                           ; 5261 D0 F3                    ..
L5263:  jmp     L51B6                           ; 5263 4C B6 51                 L.Q

; ----------------------------------------------------------------------------
L5266:  ldx     $08                             ; 5266 A6 08                    ..
        stx     L52C7                           ; 5268 8E C7 52                 ..R
        bne     L526E                           ; 526B D0 01                    ..
        inx                                     ; 526D E8                       .
L526E:  stx     $0E                             ; 526E 86 0E                    ..
        stx     $08                             ; 5270 86 08                    ..
        stx     $14                             ; 5272 86 14                    ..
        lda     #$00                            ; 5274 A9 00                    ..
        sta     $0F                             ; 5276 85 0F                    ..
        lda     $06                             ; 5278 A5 06                    ..
        sta     $09                             ; 527A 85 09                    ..
L527C:  lda     #$00                            ; 527C A9 00                    ..
        sta     $07                             ; 527E 85 07                    ..
L5280:  jsr     L5212                           ; 5280 20 12 52                  .R
        bcs     L52C4                           ; 5283 B0 3F                    .?
        bne     L5293                           ; 5285 D0 0C                    ..
        lda     $06                             ; 5287 A5 06                    ..
        sta     $09                             ; 5289 85 09                    ..
        inc     $0E                             ; 528B E6 0E                    ..
        lda     $0E                             ; 528D A5 0E                    ..
        sta     $14                             ; 528F 85 14                    ..
        bne     L527C                           ; 5291 D0 E9                    ..
L5293:  inc     $07                             ; 5293 E6 07                    ..
        lda     $07                             ; 5295 A5 07                    ..
        cmp     $0F                             ; 5297 C5 0F                    ..
        bcc     L52A1                           ; 5299 90 06                    ..
        sta     $0F                             ; 529B 85 0F                    ..
        lda     $14                             ; 529D A5 14                    ..
        sta     $08                             ; 529F 85 08                    ..
L52A1:  inc     $0E                             ; 52A1 E6 0E                    ..
        dec     $09                             ; 52A3 C6 09                    ..
        bne     L5280                           ; 52A5 D0 D9                    ..
        lda     $07                             ; 52A7 A5 07                    ..
        sta     $09                             ; 52A9 85 09                    ..
        lda     $14                             ; 52AB A5 14                    ..
        sta     $0E                             ; 52AD 85 0E                    ..
        lda     L52C7                           ; 52AF AD C7 52                 ..R
        beq     L52B8                           ; 52B2 F0 04                    ..
        cmp     $08                             ; 52B4 C5 08                    ..
        bne     L52C4                           ; 52B6 D0 0C                    ..
L52B8:  jsr     L51F3                           ; 52B8 20 F3 51                  .Q
        inc     $0E                             ; 52BB E6 0E                    ..
        dec     $09                             ; 52BD C6 09                    ..
        bne     L52B8                           ; 52BF D0 F7                    ..
        ldx     #$00                            ; 52C1 A2 00                    ..
        rts                                     ; 52C3 60                       `

; ----------------------------------------------------------------------------
L52C4:  ldx     #$03                            ; 52C4 A2 03                    ..
        rts                                     ; 52C6 60                       `

; ----------------------------------------------------------------------------
L52C7:  .byte   $01                             ; 52C7 01                       .
L52C8:  lda     $848D                           ; 52C8 AD 8D 84                 ...
        cmp     #$02                            ; 52CB C9 02                    ..
        bcc     L52F3                           ; 52CD 90 24                    .$
        ldy     $0A                             ; 52CF A4 0A                    ..
        lda     $8486,y                         ; 52D1 B9 86 84                 ...
        beq     L52F3                           ; 52D4 F0 1D                    ..
        tya                                     ; 52D6 98                       .
        jsr     SetDevice                       ; 52D7 20 B0 C2                  ..
        jsr     PurgeTurbo                      ; 52DA 20 35 C2                  5.
        lda     #$00                            ; 52DD A9 00                    ..
        ldy     $8489                           ; 52DF AC 89 84                 ...
        sta     $8486,y                         ; 52E2 99 86 84                 ...
        sta     $88BF,y                         ; 52E5 99 BF 88                 ...
        sta     $88C6                           ; 52E8 8D C6 88                 ...
        sta     $8489                           ; 52EB 8D 89 84                 ...
        sta     $BA                             ; 52EE 85 BA                    ..
        dec     $848D                           ; 52F0 CE 8D 84                 ...
L52F3:  rts                                     ; 52F3 60                       `

; ----------------------------------------------------------------------------
L52F4:  tya                                     ; 52F4 98                       .
        pha                                     ; 52F5 48                       H
        lda     L5064,y                         ; 52F6 B9 64 50                 .dP
        sta     $10                             ; 52F9 85 10                    ..
        lda     L5074,y                         ; 52FB B9 74 50                 .tP
        sta     $06                             ; 52FE 85 06                    ..
        lda     L506C,y                         ; 5300 B9 6C 50                 .lP
        sta     $08                             ; 5303 85 08                    ..
        jsr     L530B                           ; 5305 20 0B 53                  .S
        pla                                     ; 5308 68                       h
        tay                                     ; 5309 A8                       .
        rts                                     ; 530A 60                       `

; ----------------------------------------------------------------------------
L530B:  lda     #$50                            ; 530B A9 50                    .P
        sta     $05                             ; 530D 85 05                    ..
        lda     #$7D                            ; 530F A9 7D                    .}
        sta     $04                             ; 5311 85 04                    ..
        dey                                     ; 5313 88                       .
        beq     L5324                           ; 5314 F0 0E                    ..
L5316:  clc                                     ; 5316 18                       .
        lda     #$11                            ; 5317 A9 11                    ..
        adc     $04                             ; 5319 65 04                    e.
        sta     $04                             ; 531B 85 04                    ..
        bcc     L5321                           ; 531D 90 02                    ..
        inc     $05                             ; 531F E6 05                    ..
L5321:  dey                                     ; 5321 88                       .
        bne     L5316                           ; 5322 D0 F2                    ..
L5324:  rts                                     ; 5324 60                       `

; ----------------------------------------------------------------------------
L5325:  ldx     #$04                            ; 5325 A2 04                    ..
        tya                                     ; 5327 98                       .
        beq     L5334                           ; 5328 F0 0A                    ..
        cpy     #$09                            ; 532A C0 09                    ..
        bcs     L5372                           ; 532C B0 44                    .D
        lda     L506C,y                         ; 532E B9 6C 50                 .lP
        beq     L5340                           ; 5331 F0 0D                    ..
        rts                                     ; 5333 60                       `

; ----------------------------------------------------------------------------
L5334:  iny                                     ; 5334 C8                       .
L5335:  lda     L506C,y                         ; 5335 B9 6C 50                 .lP
        beq     L5340                           ; 5338 F0 06                    ..
        iny                                     ; 533A C8                       .
        cpy     #$09                            ; 533B C0 09                    ..
        bcc     L5335                           ; 533D 90 F6                    ..
        rts                                     ; 533F 60                       `

; ----------------------------------------------------------------------------
L5340:  sty     L5373                           ; 5340 8C 73 53                 .sS
        jsr     L51B6                           ; 5343 20 B6 51                  .Q
        jsr     L5266                           ; 5346 20 66 52                  fR
        txa                                     ; 5349 8A                       .
        bne     L5372                           ; 534A D0 26                    .&
        ldy     L5373                           ; 534C AC 73 53                 .sS
        lda     $08                             ; 534F A5 08                    ..
        sta     L506C,y                         ; 5351 99 6C 50                 .lP
        lda     $06                             ; 5354 A5 06                    ..
        sta     L5074,y                         ; 5356 99 74 50                 .tP
        lda     $10                             ; 5359 A5 10                    ..
        sta     L5064,y                         ; 535B 99 64 50                 .dP
        jsr     L530B                           ; 535E 20 0B 53                  .S
        ldy     #$10                            ; 5361 A0 10                    ..
L5363:  lda     ($02),y                         ; 5363 B1 02                    ..
        sta     ($04),y                         ; 5365 91 04                    ..
        dey                                     ; 5367 88                       .
        bpl     L5363                           ; 5368 10 F9                    ..
        jsr     L51D8                           ; 536A 20 D8 51                  .Q
        ldy     L5373                           ; 536D AC 73 53                 .sS
        ldx     #$00                            ; 5370 A2 00                    ..
L5372:  rts                                     ; 5372 60                       `

; ----------------------------------------------------------------------------
L5373:  .byte   $01                             ; 5373 01                       .
L5374:  ldx     #$0D                            ; 5374 A2 0D                    ..
        tya                                     ; 5376 98                       .
        beq     L5382                           ; 5377 F0 09                    ..
        cpy     #$09                            ; 5379 C0 09                    ..
        bcs     L5382                           ; 537B B0 05                    ..
        lda     L506C,y                         ; 537D B9 6C 50                 .lP
        bne     L5383                           ; 5380 D0 01                    ..
L5382:  rts                                     ; 5382 60                       `

; ----------------------------------------------------------------------------
L5383:  sty     L5373                           ; 5383 8C 73 53                 .sS
        jsr     L51B6                           ; 5386 20 B6 51                  .Q
        ldy     L5373                           ; 5389 AC 73 53                 .sS
        lda     L506C,y                         ; 538C B9 6C 50                 .lP
        sta     $0E                             ; 538F 85 0E                    ..
        lda     L5074,y                         ; 5391 B9 74 50                 .tP
        sta     $09                             ; 5394 85 09                    ..
        beq     L53A1                           ; 5396 F0 09                    ..
L5398:  jsr     L5208                           ; 5398 20 08 52                  .R
        inc     $0E                             ; 539B E6 0E                    ..
        dec     $09                             ; 539D C6 09                    ..
        bne     L5398                           ; 539F D0 F7                    ..
L53A1:  ldy     L5373                           ; 53A1 AC 73 53                 .sS
        lda     #$00                            ; 53A4 A9 00                    ..
        sta     L5064,y                         ; 53A6 99 64 50                 .dP
        sta     L5074,y                         ; 53A9 99 74 50                 .tP
        sta     L506C,y                         ; 53AC 99 6C 50                 .lP
        jsr     L530B                           ; 53AF 20 0B 53                  .S
        ldy     #$00                            ; 53B2 A0 00                    ..
        tya                                     ; 53B4 98                       .
        sta     ($04),y                         ; 53B5 91 04                    ..
        jsr     L51D8                           ; 53B7 20 D8 51                  .Q
        ldx     #$00                            ; 53BA A2 00                    ..
        rts                                     ; 53BC 60                       `

; ----------------------------------------------------------------------------
