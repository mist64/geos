; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu7.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L903C           := $903C
L9048           := $9048
L904B           := $904B
L9050           := $9050
L9053           := $9053
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
        lda     #$00                            ; 5000 A9 00                    ..
        sta     L54CF                           ; 5002 8D CF 54                 ..T
        sta     L54D0                           ; 5005 8D D0 54                 ..T
        jsr     GetDirHead                      ; 5008 20 47 C2                  G.
        bne     L5033                           ; 500B D0 26                    .&
        lda     $88C6                           ; 500D AD C6 88                 ...
        and     #$0F                            ; 5010 29 0F                    ).
        beq     L5031                           ; 5012 F0 1D                    ..
        cmp     #$05                            ; 5014 C9 05                    ..
        bcs     L5031                           ; 5016 B0 19                    ..
        tax                                     ; 5018 AA                       .
        lda     L5035,x                         ; 5019 BD 35 50                 .5P
        pha                                     ; 501C 48                       H
        lda     L5039,x                         ; 501D BD 39 50                 .9P
        tax                                     ; 5020 AA                       .
        pla                                     ; 5021 68                       h
        jsr     CallRoutine                     ; 5022 20 D8 C1                  ..
        ldy     L54D0                           ; 5025 AC D0 54                 ..T
        beq     L502D                           ; 5028 F0 03                    ..
        ldy     #$FF                            ; 502A A0 FF                    ..
        rts                                     ; 502C 60                       `

; ----------------------------------------------------------------------------
L502D:  ldy     L54CF                           ; 502D AC CF 54                 ..T
        rts                                     ; 5030 60                       `

; ----------------------------------------------------------------------------
L5031:  ldx     #$0D                            ; 5031 A2 0D                    ..
L5033:  ldy     #$00                            ; 5033 A0 00                    ..
L5035:  rts                                     ; 5035 60                       `

; ----------------------------------------------------------------------------
        .byte   $FB                             ; 5036 FB                       .
        .byte   $BE                             ; 5037 BE                       .
        .byte   $2B                             ; 5038 2B                       +
L5039:  rol     L5151,x                         ; 5039 3E 51 51                 >QQ
        eor     ($50),y                         ; 503C 51 50                    QP
        jsr     L507E                           ; 503E 20 7E 50                  ~P
        jsr     L509A                           ; 5041 20 9A 50                  .P
        txa                                     ; 5044 8A                       .
        beq     L5048                           ; 5045 F0 01                    ..
        rts                                     ; 5047 60                       `

; ----------------------------------------------------------------------------
L5048:  jsr     L549C                           ; 5048 20 9C 54                  .T
        txa                                     ; 504B 8A                       .
        bne     L5074                           ; 504C D0 26                    .&
        lda     #$01                            ; 504E A9 01                    ..
        sta     $0E                             ; 5050 85 0E                    ..
        lda     #$21                            ; 5052 A9 21                    .!
        sta     $0F                             ; 5054 85 0F                    ..
        jsr     L547A                           ; 5056 20 7A 54                  zT
        txa                                     ; 5059 8A                       .
        bne     L5074                           ; 505A D0 18                    ..
        jsr     PutDirHead                      ; 505C 20 4A C2                  J.
        txa                                     ; 505F 8A                       .
        bne     L5074                           ; 5060 D0 12                    ..
        jsr     L9050                           ; 5062 20 50 90                  P.
        jsr     L5228                           ; 5065 20 28 52                  (R
        txa                                     ; 5068 8A                       .
        bne     L5074                           ; 5069 D0 09                    ..
        jsr     PutDirHead                      ; 506B 20 4A C2                  J.
        txa                                     ; 506E 8A                       .
        bne     L5074                           ; 506F D0 03                    ..
        jmp     L508B                           ; 5071 4C 8B 50                 L.P

; ----------------------------------------------------------------------------
L5074:  pha                                     ; 5074 48                       H
        jsr     L50F9                           ; 5075 20 F9 50                  .P
        jsr     L508B                           ; 5078 20 8B 50                  .P
        pla                                     ; 507B 68                       h
        tax                                     ; 507C AA                       .
        rts                                     ; 507D 60                       `

; ----------------------------------------------------------------------------
L507E:  lda     $905C                           ; 507E AD 5C 90                 .\.
        sta     L5098                           ; 5081 8D 98 50                 ..P
        lda     $905D                           ; 5084 AD 5D 90                 .].
        sta     L5099                           ; 5087 8D 99 50                 ..P
        rts                                     ; 508A 60                       `

; ----------------------------------------------------------------------------
L508B:  lda     L5098                           ; 508B AD 98 50                 ..P
        sta     $04                             ; 508E 85 04                    ..
        lda     L5099                           ; 5090 AD 99 50                 ..P
        sta     $05                             ; 5093 85 05                    ..
        jmp     L9053                           ; 5095 4C 53 90                 LS.

; ----------------------------------------------------------------------------
L5098:  brk                                     ; 5098 00                       .
L5099:  brk                                     ; 5099 00                       .
L509A:  lda     $8489                           ; 509A AD 89 84                 ...
        jsr     SetDevice                       ; 509D 20 B0 C2                  ..
        beq     L50A3                           ; 50A0 F0 01                    ..
        rts                                     ; 50A2 60                       `

; ----------------------------------------------------------------------------
L50A3:  jsr     L50C6                           ; 50A3 20 C6 50                  .P
L50A6:  lda     $0E                             ; 50A6 A5 0E                    ..
        sta     $04                             ; 50A8 85 04                    ..
        lda     $0F                             ; 50AA A5 0F                    ..
        sta     $05                             ; 50AC 85 05                    ..
        jsr     ReadBlock                       ; 50AE 20 1A C2                  ..
        bne     L50C3                           ; 50B1 D0 10                    ..
        jsr     L50E6                           ; 50B3 20 E6 50                  .P
        jsr     StashRAM                        ; 50B6 20 C8 C2                  ..
        inc     $11                             ; 50B9 E6 11                    ..
        inc     $0F                             ; 50BB E6 0F                    ..
        lda     $0F                             ; 50BD A5 0F                    ..
        cmp     #$22                            ; 50BF C9 22                    ."
        bcc     L50A6                           ; 50C1 90 E3                    ..
L50C3:  jmp     DoneWithIO                      ; 50C3 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L50C6:  jsr     InitForIO                       ; 50C6 20 5C C2                  \.
        lda     #$01                            ; 50C9 A9 01                    ..
        sta     $0E                             ; 50CB 85 0E                    ..
        lda     #$02                            ; 50CD A9 02                    ..
        sta     $0F                             ; 50CF 85 0F                    ..
        lda     #$B9                            ; 50D1 A9 B9                    ..
        sta     $11                             ; 50D3 85 11                    ..
        lda     #$00                            ; 50D5 A9 00                    ..
        sta     $10                             ; 50D7 85 10                    ..
        lda     #$00                            ; 50D9 A9 00                    ..
        sta     $0A                             ; 50DB 85 0A                    ..
        sta     $02                             ; 50DD 85 02                    ..
        lda     #$80                            ; 50DF A9 80                    ..
        sta     $0B                             ; 50E1 85 0B                    ..
        sta     $03                             ; 50E3 85 03                    ..
        rts                                     ; 50E5 60                       `

; ----------------------------------------------------------------------------
L50E6:  lda     $11                             ; 50E6 A5 11                    ..
        sta     $05                             ; 50E8 85 05                    ..
        lda     $10                             ; 50EA A5 10                    ..
        sta     $04                             ; 50EC 85 04                    ..
L50EE:  lda     #$00                            ; 50EE A9 00                    ..
        sta     $06                             ; 50F0 85 06                    ..
        sta     $08                             ; 50F2 85 08                    ..
        lda     #$01                            ; 50F4 A9 01                    ..
        sta     $07                             ; 50F6 85 07                    ..
        rts                                     ; 50F8 60                       `

; ----------------------------------------------------------------------------
L50F9:  lda     $8489                           ; 50F9 AD 89 84                 ...
        jsr     SetDevice                       ; 50FC 20 B0 C2                  ..
        jsr     EnterTurbo                      ; 50FF 20 14 C2                  ..
        jsr     L50C6                           ; 5102 20 C6 50                  .P
L5105:  jsr     L50E6                           ; 5105 20 E6 50                  .P
        jsr     FetchRAM                        ; 5108 20 CB C2                  ..
        lda     #$80                            ; 510B A9 80                    ..
        sta     $0B                             ; 510D 85 0B                    ..
        lda     #$00                            ; 510F A9 00                    ..
        sta     $0A                             ; 5111 85 0A                    ..
        lda     $0E                             ; 5113 A5 0E                    ..
        sta     $04                             ; 5115 85 04                    ..
        lda     $0F                             ; 5117 A5 0F                    ..
        sta     $05                             ; 5119 85 05                    ..
        jsr     WriteBlock                      ; 511B 20 20 C2                   .
        inc     $11                             ; 511E E6 11                    ..
        inc     $0F                             ; 5120 E6 0F                    ..
        lda     $0F                             ; 5122 A5 0F                    ..
        cmp     #$22                            ; 5124 C9 22                    ."
        bcc     L5105                           ; 5126 90 DD                    ..
        jmp     DoneWithIO                      ; 5128 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        jsr     L5158                           ; 512B 20 58 51                  XQ
        jsr     L54A1                           ; 512E 20 A1 54                  .T
        txa                                     ; 5131 8A                       .
        bne     L5151                           ; 5132 D0 1D                    ..
        lda     #$28                            ; 5134 A9 28                    .(
        sta     $0E                             ; 5136 85 0E                    ..
        lda     #$02                            ; 5138 A9 02                    ..
        sta     $0F                             ; 513A 85 0F                    ..
        jsr     L547A                           ; 513C 20 7A 54                  zT
        jsr     L5228                           ; 513F 20 28 52                  (R
        txa                                     ; 5142 8A                       .
        bne     L5151                           ; 5143 D0 0C                    ..
        jsr     L546C                           ; 5145 20 6C 54                  lT
        jsr     PutDirHead                      ; 5148 20 4A C2                  J.
        txa                                     ; 514B 8A                       .
        bne     L5151                           ; 514C D0 03                    ..
        jmp     OpenDisk                        ; 514E 4C A1 C2                 L..

; ----------------------------------------------------------------------------
L5151:  pha                                     ; 5151 48                       H
        jsr     L516A                           ; 5152 20 6A 51                  jQ
        pla                                     ; 5155 68                       h
        tax                                     ; 5156 AA                       .
        rts                                     ; 5157 60                       `

; ----------------------------------------------------------------------------
L5158:  jsr     L517F                           ; 5158 20 7F 51                  .Q
        jsr     L51B2                           ; 515B 20 B2 51                  .Q
L515E:  jsr     L5190                           ; 515E 20 90 51                  .Q
        jsr     L51B2                           ; 5161 20 B2 51                  .Q
L5164:  jsr     L51A1                           ; 5164 20 A1 51                  .Q
        jmp     L51B2                           ; 5167 4C B2 51                 L.Q

; ----------------------------------------------------------------------------
L516A:  jsr     L517F                           ; 516A 20 7F 51                  .Q
        jsr     L51B8                           ; 516D 20 B8 51                  .Q
L5170:  jsr     L5190                           ; 5170 20 90 51                  .Q
        jsr     L51B8                           ; 5173 20 B8 51                  .Q
L5176:  jsr     L51A1                           ; 5176 20 A1 51                  .Q
        jsr     L51B8                           ; 5179 20 B8 51                  .Q
        jmp     PutDirHead                      ; 517C 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L517F:  lda     #$9C                            ; 517F A9 9C                    ..
        sta     $03                             ; 5181 85 03                    ..
        lda     #$80                            ; 5183 A9 80                    ..
        sta     $02                             ; 5185 85 02                    ..
        lda     #$BB                            ; 5187 A9 BB                    ..
        sta     $05                             ; 5189 85 05                    ..
        lda     #$00                            ; 518B A9 00                    ..
        sta     $04                             ; 518D 85 04                    ..
        rts                                     ; 518F 60                       `

; ----------------------------------------------------------------------------
L5190:  lda     #$89                            ; 5190 A9 89                    ..
        sta     $03                             ; 5192 85 03                    ..
        lda     #$00                            ; 5194 A9 00                    ..
        sta     $02                             ; 5196 85 02                    ..
        lda     #$BA                            ; 5198 A9 BA                    ..
        sta     $05                             ; 519A 85 05                    ..
        lda     #$00                            ; 519C A9 00                    ..
        sta     $04                             ; 519E 85 04                    ..
        rts                                     ; 51A0 60                       `

; ----------------------------------------------------------------------------
L51A1:  lda     #$82                            ; 51A1 A9 82                    ..
        sta     $03                             ; 51A3 85 03                    ..
        lda     #$00                            ; 51A5 A9 00                    ..
        sta     $02                             ; 51A7 85 02                    ..
        lda     #$B9                            ; 51A9 A9 B9                    ..
        sta     $05                             ; 51AB 85 05                    ..
        lda     #$00                            ; 51AD A9 00                    ..
        sta     $04                             ; 51AF 85 04                    ..
        rts                                     ; 51B1 60                       `

; ----------------------------------------------------------------------------
L51B2:  jsr     L50EE                           ; 51B2 20 EE 50                  .P
        jmp     StashRAM                        ; 51B5 4C C8 C2                 L..

; ----------------------------------------------------------------------------
L51B8:  jsr     L50EE                           ; 51B8 20 EE 50                  .P
        jmp     FetchRAM                        ; 51BB 4C CB C2                 L..

; ----------------------------------------------------------------------------
        jsr     L515E                           ; 51BE 20 5E 51                  ^Q
        jsr     L548B                           ; 51C1 20 8B 54                  .T
        txa                                     ; 51C4 8A                       .
        bne     L51F4                           ; 51C5 D0 2D                    .-
        lda     #$12                            ; 51C7 A9 12                    ..
        sta     $0E                             ; 51C9 85 0E                    ..
        lda     #$00                            ; 51CB A9 00                    ..
        sta     $0F                             ; 51CD 85 0F                    ..
        jsr     L547A                           ; 51CF 20 7A 54                  zT
        bit     $8203                           ; 51D2 2C 03 82                 ,..
        bpl     L51E2                           ; 51D5 10 0B                    ..
        lda     #$35                            ; 51D7 A9 35                    .5
        sta     $0E                             ; 51D9 85 0E                    ..
        lda     #$12                            ; 51DB A9 12                    ..
        sta     $0F                             ; 51DD 85 0F                    ..
        jsr     L547A                           ; 51DF 20 7A 54                  zT
L51E2:  jsr     L5228                           ; 51E2 20 28 52                  (R
        txa                                     ; 51E5 8A                       .
        bne     L51F4                           ; 51E6 D0 0C                    ..
        jsr     L546C                           ; 51E8 20 6C 54                  lT
        jsr     PutDirHead                      ; 51EB 20 4A C2                  J.
        txa                                     ; 51EE 8A                       .
        bne     L51F4                           ; 51EF D0 03                    ..
        jmp     OpenDisk                        ; 51F1 4C A1 C2                 L..

; ----------------------------------------------------------------------------
L51F4:  pha                                     ; 51F4 48                       H
        jsr     L5170                           ; 51F5 20 70 51                  pQ
        pla                                     ; 51F8 68                       h
        tax                                     ; 51F9 AA                       .
        rts                                     ; 51FA 60                       `

; ----------------------------------------------------------------------------
        jsr     L5164                           ; 51FB 20 64 51                  dQ
        jsr     L5492                           ; 51FE 20 92 54                  .T
        txa                                     ; 5201 8A                       .
        bne     L5221                           ; 5202 D0 1D                    ..
        lda     #$12                            ; 5204 A9 12                    ..
        sta     $0E                             ; 5206 85 0E                    ..
        lda     #$00                            ; 5208 A9 00                    ..
        sta     $0F                             ; 520A 85 0F                    ..
        jsr     L547A                           ; 520C 20 7A 54                  zT
        jsr     L5228                           ; 520F 20 28 52                  (R
        txa                                     ; 5212 8A                       .
        bne     L5221                           ; 5213 D0 0C                    ..
        jsr     L546C                           ; 5215 20 6C 54                  lT
        jsr     PutDirHead                      ; 5218 20 4A C2                  J.
        txa                                     ; 521B 8A                       .
        bne     L5221                           ; 521C D0 03                    ..
        jmp     OpenDisk                        ; 521E 4C A1 C2                 L..

; ----------------------------------------------------------------------------
L5221:  pha                                     ; 5221 48                       H
        jsr     L5176                           ; 5222 20 76 51                  vQ
        pla                                     ; 5225 68                       h
        tax                                     ; 5226 AA                       .
        rts                                     ; 5227 60                       `

; ----------------------------------------------------------------------------
L5228:  lda     $8201                           ; 5228 AD 01 82                 ...
        sta     $0F                             ; 522B 85 0F                    ..
        lda     $8200                           ; 522D AD 00 82                 ...
        sta     $0E                             ; 5230 85 0E                    ..
L5232:  jsr     L9048                           ; 5232 20 48 90                  H.
        lda     $0F                             ; 5235 A5 0F                    ..
        sta     $05                             ; 5237 85 05                    ..
        lda     $0E                             ; 5239 A5 0E                    ..
        sta     $04                             ; 523B 85 04                    ..
        jsr     L903C                           ; 523D 20 3C 90                  <.
        txa                                     ; 5240 8A                       .
        beq     L5244                           ; 5241 F0 01                    ..
        rts                                     ; 5243 60                       `

; ----------------------------------------------------------------------------
L5244:  lda     #$80                            ; 5244 A9 80                    ..
        sta     $0D                             ; 5246 85 0D                    ..
        lda     #$02                            ; 5248 A9 02                    ..
        sta     $0C                             ; 524A 85 0C                    ..
L524C:  jsr     L5436                           ; 524C 20 36 54                  6T
        ldy     #$00                            ; 524F A0 00                    ..
        lda     ($0C),y                         ; 5251 B1 0C                    ..
        and     #$BF                            ; 5253 29 BF                    ).
        cmp     #$86                            ; 5255 C9 86                    ..
        bne     L525F                           ; 5257 D0 06                    ..
        jsr     L52D5                           ; 5259 20 D5 52                  .R
        jmp     L5228                           ; 525C 4C 28 52                 L(R

; ----------------------------------------------------------------------------
L525F:  jsr     L530A                           ; 525F 20 0A 53                  .S
        txa                                     ; 5262 8A                       .
        bne     L52A0                           ; 5263 D0 3B                    .;
L5265:  jsr     L544B                           ; 5265 20 4B 54                  KT
        clc                                     ; 5268 18                       .
        lda     $0C                             ; 5269 A5 0C                    ..
        adc     #$20                            ; 526B 69 20                    i 
        sta     $0C                             ; 526D 85 0C                    ..
        bcc     L524C                           ; 526F 90 DB                    ..
        lda     $8001                           ; 5271 AD 01 80                 ...
        sta     $0F                             ; 5274 85 0F                    ..
        lda     $8000                           ; 5276 AD 00 80                 ...
        sta     $0E                             ; 5279 85 0E                    ..
        bne     L5232                           ; 527B D0 B5                    ..
        bit     L5435                           ; 527D 2C 35 54                 ,5T
        bmi     L528D                           ; 5280 30 0B                    0.
        jsr     L53FF                           ; 5282 20 FF 53                  .S
        txa                                     ; 5285 8A                       .
        bne     L52D4                           ; 5286 D0 4C                    .L
        bit     L5435                           ; 5288 2C 35 54                 ,5T
        bmi     L524C                           ; 528B 30 BF                    0.
L528D:  lda     #$00                            ; 528D A9 00                    ..
        sta     L5435                           ; 528F 8D 35 54                 .5T
        lda     $88C6                           ; 5292 AD C6 88                 ...
        and     #$0F                            ; 5295 29 0F                    ).
        cmp     #$04                            ; 5297 C9 04                    ..
        bne     L52A0                           ; 5299 D0 05                    ..
        lda     $8222                           ; 529B AD 22 82                 .".
        bne     L52A3                           ; 529E D0 03                    ..
L52A0:  rts                                     ; 52A0 60                       `

; ----------------------------------------------------------------------------
L52A1:  beq     L5265                           ; 52A1 F0 C2                    ..
L52A3:  lda     $8225                           ; 52A3 AD 25 82                 .%.
        sta     $05                             ; 52A6 85 05                    ..
        lda     $8224                           ; 52A8 AD 24 82                 .$.
        sta     $04                             ; 52AB 85 04                    ..
        lda     $8226                           ; 52AD AD 26 82                 .&.
        sta     $0C                             ; 52B0 85 0C                    ..
        lda     #$80                            ; 52B2 A9 80                    ..
        sta     $0D                             ; 52B4 85 0D                    ..
        jsr     L5436                           ; 52B6 20 36 54                  6T
        jsr     L544B                           ; 52B9 20 4B 54                  KT
        jsr     GetBlock                        ; 52BC 20 E4 C1                  ..
        bne     L52D4                           ; 52BF D0 13                    ..
        jsr     PutDirHead                      ; 52C1 20 4A C2                  J.
        lda     $8223                           ; 52C4 AD 23 82                 .#.
        sta     $05                             ; 52C7 85 05                    ..
        lda     $8222                           ; 52C9 AD 22 82                 .".
        sta     $04                             ; 52CC 85 04                    ..
        jsr     L9053                           ; 52CE 20 53 90                  S.
        txa                                     ; 52D1 8A                       .
        beq     L52A1                           ; 52D2 F0 CD                    ..
L52D4:  rts                                     ; 52D4 60                       `

; ----------------------------------------------------------------------------
L52D5:  jsr     L544B                           ; 52D5 20 4B 54                  KT
        ldy     #$01                            ; 52D8 A0 01                    ..
        lda     ($0C),y                         ; 52DA B1 0C                    ..
        sta     $0E                             ; 52DC 85 0E                    ..
        iny                                     ; 52DE C8                       .
        lda     ($0C),y                         ; 52DF B1 0C                    ..
        sta     $0F                             ; 52E1 85 0F                    ..
        jsr     L9048                           ; 52E3 20 48 90                  H.
        jsr     PutDirHead                      ; 52E6 20 4A C2                  J.
        jsr     L544B                           ; 52E9 20 4B 54                  KT
        ldy     #$01                            ; 52EC A0 01                    ..
        lda     ($0C),y                         ; 52EE B1 0C                    ..
        sta     $04                             ; 52F0 85 04                    ..
        iny                                     ; 52F2 C8                       .
        lda     ($0C),y                         ; 52F3 B1 0C                    ..
        sta     $05                             ; 52F5 85 05                    ..
        jsr     L9053                           ; 52F7 20 53 90                  S.
        lda     $8201                           ; 52FA AD 01 82                 ...
        sta     $0F                             ; 52FD 85 0F                    ..
        lda     $8200                           ; 52FF AD 00 82                 ...
        sta     $0E                             ; 5302 85 0E                    ..
        jsr     L9048                           ; 5304 20 48 90                  H.
        jmp     PutDirHead                      ; 5307 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L530A:  ldy     #$00                            ; 530A A0 00                    ..
        lda     ($0C),y                         ; 530C B1 0C                    ..
        beq     L5320                           ; 530E F0 10                    ..
        and     #$BF                            ; 5310 29 BF                    ).
        cmp     #$81                            ; 5312 C9 81                    ..
        bcs     L5322                           ; 5314 B0 0C                    ..
        lda     #$00                            ; 5316 A9 00                    ..
        sta     ($0C),y                         ; 5318 91 0C                    ..
        jsr     L544B                           ; 531A 20 4B 54                  KT
        jmp     PutBlock                        ; 531D 4C E7 C1                 L..

; ----------------------------------------------------------------------------
L5320:  tax                                     ; 5320 AA                       .
        rts                                     ; 5321 60                       `

; ----------------------------------------------------------------------------
L5322:  and     #$3F                            ; 5322 29 3F                    )?
        cmp     #$04                            ; 5324 C9 04                    ..
        beq     L533A                           ; 5326 F0 12                    ..
        ldy     #$13                            ; 5328 A0 13                    ..
        lda     ($0C),y                         ; 532A B1 0C                    ..
        bne     L5331                           ; 532C D0 03                    ..
L532E:  jmp     L533D                           ; 532E 4C 3D 53                 L=S

; ----------------------------------------------------------------------------
L5331:  ldy     #$16                            ; 5331 A0 16                    ..
        lda     ($0C),y                         ; 5333 B1 0C                    ..
        beq     L532E                           ; 5335 F0 F7                    ..
        jmp     L5379                           ; 5337 4C 79 53                 LyS

; ----------------------------------------------------------------------------
L533A:  jmp     L53E0                           ; 533A 4C E0 53                 L.S

; ----------------------------------------------------------------------------
L533D:  ldy     #$01                            ; 533D A0 01                    ..
        lda     ($0C),y                         ; 533F B1 0C                    ..
        sta     $04                             ; 5341 85 04                    ..
        iny                                     ; 5343 C8                       .
        lda     ($0C),y                         ; 5344 B1 0C                    ..
        sta     $05                             ; 5346 85 05                    ..
L5348:  jsr     InitForIO                       ; 5348 20 5C C2                  \.
        lda     $05                             ; 534B A5 05                    ..
        sta     $0F                             ; 534D 85 0F                    ..
        lda     $04                             ; 534F A5 04                    ..
        sta     $0E                             ; 5351 85 0E                    ..
L5353:  jsr     L9048                           ; 5353 20 48 90                  H.
        jsr     L53F1                           ; 5356 20 F1 53                  .S
        lda     #$54                            ; 5359 A9 54                    .T
        sta     $0B                             ; 535B 85 0B                    ..
        lda     #$CD                            ; 535D A9 CD                    ..
        sta     $0A                             ; 535F 85 0A                    ..
        jsr     L904B                           ; 5361 20 4B 90                  K.
        bne     L5376                           ; 5364 D0 10                    ..
        lda     L54CE                           ; 5366 AD CE 54                 ..T
        sta     $05                             ; 5369 85 05                    ..
        sta     $0F                             ; 536B 85 0F                    ..
        lda     L54CD                           ; 536D AD CD 54                 ..T
        sta     $04                             ; 5370 85 04                    ..
        sta     $0E                             ; 5372 85 0E                    ..
        bne     L5353                           ; 5374 D0 DD                    ..
L5376:  jmp     DoneWithIO                      ; 5376 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L5379:  ldy     #$13                            ; 5379 A0 13                    ..
        lda     ($0C),y                         ; 537B B1 0C                    ..
        sta     $0E                             ; 537D 85 0E                    ..
        iny                                     ; 537F C8                       .
        lda     ($0C),y                         ; 5380 B1 0C                    ..
        sta     $0F                             ; 5382 85 0F                    ..
        jsr     L9048                           ; 5384 20 48 90                  H.
        jsr     L53F1                           ; 5387 20 F1 53                  .S
        ldy     #$01                            ; 538A A0 01                    ..
        lda     ($0C),y                         ; 538C B1 0C                    ..
        sta     $04                             ; 538E 85 04                    ..
        iny                                     ; 5390 C8                       .
        lda     ($0C),y                         ; 5391 B1 0C                    ..
        sta     $05                             ; 5393 85 05                    ..
        ldy     #$15                            ; 5395 A0 15                    ..
        lda     ($0C),y                         ; 5397 B1 0C                    ..
        cmp     #$01                            ; 5399 C9 01                    ..
        beq     L53A0                           ; 539B F0 03                    ..
        jmp     L5348                           ; 539D 4C 48 53                 LHS

; ----------------------------------------------------------------------------
L53A0:  lda     #$81                            ; 53A0 A9 81                    ..
        sta     $0B                             ; 53A2 85 0B                    ..
        lda     #$00                            ; 53A4 A9 00                    ..
        sta     $0A                             ; 53A6 85 0A                    ..
        jsr     GetBlock                        ; 53A8 20 E4 C1                  ..
        bne     L53DE                           ; 53AB D0 31                    .1
        lda     $05                             ; 53AD A5 05                    ..
        sta     $0F                             ; 53AF 85 0F                    ..
        lda     $04                             ; 53B1 A5 04                    ..
        sta     $0E                             ; 53B3 85 0E                    ..
        jsr     L9048                           ; 53B5 20 48 90                  H.
        jsr     L53F1                           ; 53B8 20 F1 53                  .S
        ldy     #$02                            ; 53BB A0 02                    ..
        sty     L53DF                           ; 53BD 8C DF 53                 ..S
L53C0:  lda     $8101,y                         ; 53C0 B9 01 81                 ...
        sta     $05                             ; 53C3 85 05                    ..
        lda     $8100,y                         ; 53C5 B9 00 81                 ...
        sta     $04                             ; 53C8 85 04                    ..
        beq     L53D2                           ; 53CA F0 06                    ..
        jsr     L5348                           ; 53CC 20 48 53                  HS
        txa                                     ; 53CF 8A                       .
        bne     L53DE                           ; 53D0 D0 0C                    ..
L53D2:  ldy     L53DF                           ; 53D2 AC DF 53                 ..S
        iny                                     ; 53D5 C8                       .
        iny                                     ; 53D6 C8                       .
        sty     L53DF                           ; 53D7 8C DF 53                 ..S
        bne     L53C0                           ; 53DA D0 E4                    ..
        ldx     #$00                            ; 53DC A2 00                    ..
L53DE:  rts                                     ; 53DE 60                       `

; ----------------------------------------------------------------------------
L53DF:  brk                                     ; 53DF 00                       .
L53E0:  jsr     L533D                           ; 53E0 20 3D 53                  =S
        ldy     #$13                            ; 53E3 A0 13                    ..
        lda     ($0C),y                         ; 53E5 B1 0C                    ..
        sta     $04                             ; 53E7 85 04                    ..
        iny                                     ; 53E9 C8                       .
        lda     ($0C),y                         ; 53EA B1 0C                    ..
        sta     $05                             ; 53EC 85 05                    ..
        jmp     L5348                           ; 53EE 4C 48 53                 LHS

; ----------------------------------------------------------------------------
L53F1:  txa                                     ; 53F1 8A                       .
        beq     L53FE                           ; 53F2 F0 0A                    ..
        inc     L54CF                           ; 53F4 EE CF 54                 ..T
        bne     L53FC                           ; 53F7 D0 03                    ..
        inc     L54D0                           ; 53F9 EE D0 54                 ..T
L53FC:  ldx     #$00                            ; 53FC A2 00                    ..
L53FE:  rts                                     ; 53FE 60                       `

; ----------------------------------------------------------------------------
L53FF:  lda     $82AC                           ; 53FF AD AC 82                 ...
        sta     $0F                             ; 5402 85 0F                    ..
        sta     $05                             ; 5404 85 05                    ..
        lda     $82AB                           ; 5406 AD AB 82                 ...
        sta     $0E                             ; 5409 85 0E                    ..
        sta     $04                             ; 540B 85 04                    ..
        beq     L542D                           ; 540D F0 1E                    ..
        jsr     L9048                           ; 540F 20 48 90                  H.
        cpx     #$06                            ; 5412 E0 06                    ..
        beq     L542D                           ; 5414 F0 17                    ..
        txa                                     ; 5416 8A                       .
        bne     L542F                           ; 5417 D0 16                    ..
        jsr     L903C                           ; 5419 20 3C 90                  <.
        lda     #$80                            ; 541C A9 80                    ..
        sta     $0D                             ; 541E 85 0D                    ..
        lda     #$02                            ; 5420 A9 02                    ..
        sta     $0C                             ; 5422 85 0C                    ..
        txa                                     ; 5424 8A                       .
        bne     L542F                           ; 5425 D0 08                    ..
        lda     #$FF                            ; 5427 A9 FF                    ..
        sta     L5435                           ; 5429 8D 35 54                 .5T
        rts                                     ; 542C 60                       `

; ----------------------------------------------------------------------------
L542D:  ldx     #$00                            ; 542D A2 00                    ..
L542F:  lda     #$00                            ; 542F A9 00                    ..
        sta     L5435                           ; 5431 8D 35 54                 .5T
        rts                                     ; 5434 60                       `

; ----------------------------------------------------------------------------
L5435:  brk                                     ; 5435 00                       .
L5436:  lda     $05                             ; 5436 A5 05                    ..
        sta     L5469                           ; 5438 8D 69 54                 .iT
        lda     $04                             ; 543B A5 04                    ..
        sta     L5468                           ; 543D 8D 68 54                 .hT
        lda     $0D                             ; 5440 A5 0D                    ..
        sta     L546B                           ; 5442 8D 6B 54                 .kT
        lda     $0C                             ; 5445 A5 0C                    ..
        sta     L546A                           ; 5447 8D 6A 54                 .jT
        rts                                     ; 544A 60                       `

; ----------------------------------------------------------------------------
L544B:  lda     L5469                           ; 544B AD 69 54                 .iT
        sta     $05                             ; 544E 85 05                    ..
        lda     L5468                           ; 5450 AD 68 54                 .hT
        sta     $04                             ; 5453 85 04                    ..
        lda     L546B                           ; 5455 AD 6B 54                 .kT
        sta     $0D                             ; 5458 85 0D                    ..
        lda     L546A                           ; 545A AD 6A 54                 .jT
        sta     $0C                             ; 545D 85 0C                    ..
        lda     #$80                            ; 545F A9 80                    ..
        sta     $0B                             ; 5461 85 0B                    ..
        lda     #$00                            ; 5463 A9 00                    ..
        sta     $0A                             ; 5465 85 0A                    ..
        rts                                     ; 5467 60                       `

; ----------------------------------------------------------------------------
L5468:  brk                                     ; 5468 00                       .
L5469:  brk                                     ; 5469 00                       .
L546A:  brk                                     ; 546A 00                       .
L546B:  brk                                     ; 546B 00                       .
L546C:  lda     #$01                            ; 546C A9 01                    ..
        sta     $0E                             ; 546E 85 0E                    ..
        lda     #$00                            ; 5470 A9 00                    ..
        sta     $0F                             ; 5472 85 0F                    ..
        jsr     L9048                           ; 5474 20 48 90                  H.
        ldx     #$00                            ; 5477 A2 00                    ..
        rts                                     ; 5479 60                       `

; ----------------------------------------------------------------------------
L547A:  jsr     L9048                           ; 547A 20 48 90                  H.
        txa                                     ; 547D 8A                       .
        beq     L5484                           ; 547E F0 04                    ..
        cpx     #$06                            ; 5480 E0 06                    ..
        bne     L548A                           ; 5482 D0 06                    ..
L5484:  dec     $0F                             ; 5484 C6 0F                    ..
        bpl     L547A                           ; 5486 10 F2                    ..
        ldx     #$00                            ; 5488 A2 00                    ..
L548A:  rts                                     ; 548A 60                       `

; ----------------------------------------------------------------------------
L548B:  ldx     #$47                            ; 548B A2 47                    .G
        bit     $8203                           ; 548D 2C 03 82                 ,..
        bmi     L54A3                           ; 5490 30 11                    0.
L5492:  ldx     #$24                            ; 5492 A2 24                    .$
        bit     $8203                           ; 5494 2C 03 82                 ,..
        bpl     L54A3                           ; 5497 10 0A                    ..
        ldx     #$06                            ; 5499 A2 06                    ..
        rts                                     ; 549B 60                       `

; ----------------------------------------------------------------------------
L549C:  ldx     $9062                           ; 549C AE 62 90                 .b.
        inx                                     ; 549F E8                       .
        .byte   $2C                             ; 54A0 2C                       ,
L54A1:  ldx     #$51                            ; 54A1 A2 51                    .Q
L54A3:  stx     L54CC                           ; 54A3 8E CC 54                 ..T
        lda     #$01                            ; 54A6 A9 01                    ..
        sta     $0E                             ; 54A8 85 0E                    ..
L54AA:  lda     #$00                            ; 54AA A9 00                    ..
        sta     $0F                             ; 54AC 85 0F                    ..
L54AE:  jsr     FreeBlock                       ; 54AE 20 B9 C2                  ..
        txa                                     ; 54B1 8A                       .
        beq     L54BC                           ; 54B2 F0 08                    ..
        cpx     #$02                            ; 54B4 E0 02                    ..
        beq     L54C0                           ; 54B6 F0 08                    ..
        cpx     #$06                            ; 54B8 E0 06                    ..
        bne     L54CB                           ; 54BA D0 0F                    ..
L54BC:  inc     $0F                             ; 54BC E6 0F                    ..
        bne     L54AE                           ; 54BE D0 EE                    ..
L54C0:  inc     $0E                             ; 54C0 E6 0E                    ..
        lda     $0E                             ; 54C2 A5 0E                    ..
        cmp     L54CC                           ; 54C4 CD CC 54                 ..T
        bne     L54AA                           ; 54C7 D0 E1                    ..
        ldx     #$00                            ; 54C9 A2 00                    ..
L54CB:  rts                                     ; 54CB 60                       `

; ----------------------------------------------------------------------------
L54CC:  brk                                     ; 54CC 00                       .
L54CD:  brk                                     ; 54CD 00                       .
L54CE:  brk                                     ; 54CE 00                       .
L54CF:  brk                                     ; 54CF 00                       .
L54D0:  brk                                     ; 54D0 00                       .
