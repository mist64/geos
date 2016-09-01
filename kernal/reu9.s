; da65 V2.15
; Created:    2016-09-01 03:54:00
; Input file: reu9.bin
; Page:       1


        .setcpu "6502"

; ----------------------------------------------------------------------------
L7900           := $7900
L7945           := $7945
L7948           := $7948
L7951           := $7951
L7964           := $7964
L7977           := $7977
L797A           := $797A
L79BC           := $79BC
L79EE           := $79EE
L7A6E           := $7A6E
L7AB4           := $7AB4
L7AFC           := $7AFC
L7B31           := $7B31
L7B49           := $7B49
L7B67           := $7B67
L7B76           := $7B76
L7B79           := $7B79
L7BFB           := $7BFB
L7C08           := $7C08
L7C16           := $7C16
L7C4D           := $7C4D
L7C56           := $7C56
L7C59           := $7C59
L7C69           := $7C69
L7C6C           := $7C6C
L7C87           := $7C87
L7D1F           := $7D1F
L7D9C           := $7D9C
L7E14           := $7E14
L7E5B           := $7E5B
L7E7B           := $7E7B
L7EAF           := $7EAF
L9033           := $9033
L903C           := $903C
L903F           := $903F
L9063           := $9063
L906C           := $906C
L9D80           := $9D80
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
; ----------------------------------------------------------------------------
        ldx     #$05                            ; 5000 A2 05                    ..
        lda     $8400                           ; 5002 AD 00 84                 ...
        and     #$BF                            ; 5005 29 BF                    ).
        cmp     #$84                            ; 5007 C9 84                    ..
        bne     L500C                           ; 5009 D0 01                    ..
        rts                                     ; 500B 60                       `

; ----------------------------------------------------------------------------
L500C:  ldx     #$07                            ; 500C A2 07                    ..
L500E:  lda     $02,x                           ; 500E B5 02                    ..
        sta     L5726,x                         ; 5010 9D 26 57                 .&W
        dex                                     ; 5013 CA                       .
        bpl     L500E                           ; 5014 10 F8                    ..
        lda     $08                             ; 5016 A5 08                    ..
L5018:  and     #$3F                            ; 5018 29 3F                    )?
        sta     L5704                           ; 501A 8D 04 57                 ..W
        ldx     #$1D                            ; 501D A2 1D                    ..
L501F:  .byte   $BD                             ; 501F BD                       .
        brk                                     ; 5020 00                       .
L5021:  sty     $9D                             ; 5021 84 9D                    ..
        php                                     ; 5023 08                       .
        .byte   $57                             ; 5024 57                       W
        dex                                     ; 5025 CA                       .
        bpl     L501F                           ; 5026 10 F7                    ..
        ldy     #$00                            ; 5028 A0 00                    ..
L502A:  lda     ($02),y                         ; 502A B1 02                    ..
        beq     L5036                           ; 502C F0 08                    ..
        sta     L570B,y                         ; 502E 99 0B 57                 ..W
        iny                                     ; 5031 C8                       .
        cpy     #$10                            ; 5032 C0 10                    ..
        bcc     L502A                           ; 5034 90 F4                    ..
L5036:  lda     #$A0                            ; 5036 A9 A0                    ..
L5038:  cpy     #$10                            ; 5038 C0 10                    ..
        bcs     L5042                           ; 503A B0 06                    ..
        sta     L570B,y                         ; 503C 99 0B 57                 ..W
        iny                                     ; 503F C8                       .
        bne     L5038                           ; 5040 D0 F6                    ..
L5042:  jsr     i_MoveData                      ; 5042 20 B7 C1                  ..
        .byte   $FA                             ; 5045 FA                       .
        bvc     L5048                           ; 5046 50 00                    P.
L5048:  adc     $0634,y                         ; 5048 79 34 06                 y4.
        lda     $8489                           ; 504B AD 89 84                 ...
        sta     $7F09                           ; 504E 8D 09 7F                 ...
        jsr     L9063                           ; 5051 20 63 90                  c.
        lda     $06                             ; 5054 A5 06                    ..
        sta     $7F0B                           ; 5056 8D 0B 7F                 ...
        jsr     GetDirHead                      ; 5059 20 47 C2                  G.
        bne     L509C                           ; 505C D0 3E                    .>
        lda     $05                             ; 505E A5 05                    ..
        sta     $7F0D                           ; 5060 8D 0D 7F                 ...
        lda     $04                             ; 5063 A5 04                    ..
        sta     $7F0C                           ; 5065 8D 0C 7F                 ...
        lda     $82AB                           ; 5068 AD AB 82                 ...
        sta     $7AF8                           ; 506B 8D F8 7A                 ..z
        lda     $82AC                           ; 506E AD AC 82                 ...
        sta     $7AF9                           ; 5071 8D F9 7A                 ..z
        lda     #$00                            ; 5074 A9 00                    ..
        sta     $7F01                           ; 5076 8D 01 7F                 ...
        sta     $7EFE                           ; 5079 8D FE 7E                 ..~
        lda     #$84                            ; 507C A9 84                    ..
        sta     $0F                             ; 507E 85 0F                    ..
        lda     #$00                            ; 5080 A9 00                    ..
        sta     $0E                             ; 5082 85 0E                    ..
        jsr     L50A7                           ; 5084 20 A7 50                  .P
        txa                                     ; 5087 8A                       .
        bne     L509C                           ; 5088 D0 12                    ..
        lda     $04                             ; 508A A5 04                    ..
        sta     $7EFA                           ; 508C 8D FA 7E                 ..~
        lda     $05                             ; 508F A5 05                    ..
        sta     $7EFB                           ; 5091 8D FB 7E                 ..~
        lda     $0C                             ; 5094 A5 0C                    ..
        sta     $7EFC                           ; 5096 8D FC 7E                 ..~
        jmp     L7900                           ; 5099 4C 00 79                 L.y

; ----------------------------------------------------------------------------
L509C:  rts                                     ; 509C 60                       `

; ----------------------------------------------------------------------------
L509D:  ldx     $82AB                           ; 509D AE AB 82                 ...
        ldy     $82AC                           ; 50A0 AC AC 82                 ...
        lda     #$FF                            ; 50A3 A9 FF                    ..
        bne     L50AF                           ; 50A5 D0 08                    ..
L50A7:  ldx     $8200                           ; 50A7 AE 00 82                 ...
        ldy     $8201                           ; 50AA AC 01 82                 ...
        lda     #$00                            ; 50AD A9 00                    ..
L50AF:  stx     $04                             ; 50AF 86 04                    ..
        sty     $05                             ; 50B1 84 05                    ..
        sta     $7EF9                           ; 50B3 8D F9 7E                 ..~
        txa                                     ; 50B6 8A                       .
        beq     L50F7                           ; 50B7 F0 3E                    .>
L50B9:  jsr     L903C                           ; 50B9 20 3C 90                  <.
        bne     L50F9                           ; 50BC D0 3B                    .;
        lda     #$80                            ; 50BE A9 80                    ..
        sta     $0D                             ; 50C0 85 0D                    ..
        lda     #$02                            ; 50C2 A9 02                    ..
        sta     $0C                             ; 50C4 85 0C                    ..
L50C6:  ldy     #$00                            ; 50C6 A0 00                    ..
        lda     ($0C),y                         ; 50C8 B1 0C                    ..
        beq     L50DA                           ; 50CA F0 0E                    ..
        ldy     #$03                            ; 50CC A0 03                    ..
L50CE:  lda     ($0E),y                         ; 50CE B1 0E                    ..
        cmp     ($0C),y                         ; 50D0 D1 0C                    ..
        bne     L50DA                           ; 50D2 D0 06                    ..
        iny                                     ; 50D4 C8                       .
        cpy     #$13                            ; 50D5 C0 13                    ..
        bcc     L50CE                           ; 50D7 90 F5                    ..
        rts                                     ; 50D9 60                       `

; ----------------------------------------------------------------------------
L50DA:  clc                                     ; 50DA 18                       .
        lda     $0C                             ; 50DB A5 0C                    ..
        adc     #$20                            ; 50DD 69 20                    i 
        sta     $0C                             ; 50DF 85 0C                    ..
        bcc     L50C6                           ; 50E1 90 E3                    ..
        lda     $8001                           ; 50E3 AD 01 80                 ...
        sta     $05                             ; 50E6 85 05                    ..
        lda     $8000                           ; 50E8 AD 00 80                 ...
        sta     $04                             ; 50EB 85 04                    ..
        bne     L50B9                           ; 50ED D0 CA                    ..
        bit     $7EF9                           ; 50EF 2C F9 7E                 ,.~
        bmi     L50F7                           ; 50F2 30 03                    0.
        jmp     L509D                           ; 50F4 4C 9D 50                 L.P

; ----------------------------------------------------------------------------
L50F7:  ldx     #$05                            ; 50F7 A2 05                    ..
L50F9:  rts                                     ; 50F9 60                       `

; ----------------------------------------------------------------------------
        jsr     L7945                           ; 50FA 20 45 79                  Ey
        jsr     L7951                           ; 50FD 20 51 79                  Qy
        lda     $8414                           ; 5100 AD 14 84                 ...
        sta     $05                             ; 5103 85 05                    ..
        lda     $8413                           ; 5105 AD 13 84                 ...
        sta     $04                             ; 5108 85 04                    ..
        beq     L5126                           ; 510A F0 1A                    ..
        jsr     L903C                           ; 510C 20 3C 90                  <.
        bne     L5126                           ; 510F D0 15                    ..
        inc     $7F01                           ; 5111 EE 01 7F                 ...
        jsr     L7C56                           ; 5114 20 56 7C                  V|
        lda     $7F23                           ; 5117 AD 23 7F                 .#.
        cmp     #$01                            ; 511A C9 01                    ..
        bne     L5129                           ; 511C D0 0B                    ..
        cmp     $8046                           ; 511E CD 46 80                 .F.
        bne     L5129                           ; 5121 D0 06                    ..
        lda     #$C0                            ; 5123 A9 C0                    ..
        .byte   $2C                             ; 5125 2C                       ,
L5126:  lda     #$00                            ; 5126 A9 00                    ..
        .byte   $2C                             ; 5128 2C                       ,
L5129:  lda     #$80                            ; 5129 A9 80                    ..
        sta     $7EF8                           ; 512B 8D F8 7E                 ..~
        jsr     L79BC                           ; 512E 20 BC 79                  .y
        txa                                     ; 5131 8A                       .
        pha                                     ; 5132 48                       H
        jsr     L7B76                           ; 5133 20 76 7B                  v{
        jsr     L7964                           ; 5136 20 64 79                  dy
        jsr     L7948                           ; 5139 20 48 79                  Hy
        pla                                     ; 513C 68                       h
        tax                                     ; 513D AA                       .
        rts                                     ; 513E 60                       `

; ----------------------------------------------------------------------------
        ldx     #$45                            ; 513F A2 45                    .E
        bit     $49A2                           ; 5141 2C A2 49                 ,.I
        jsr     L9D83                           ; 5144 20 83 9D                  ..
        txa                                     ; 5147 8A                       .
        jmp     L9D80                           ; 5148 4C 80 9D                 L..

; ----------------------------------------------------------------------------
        bit     $7F32                           ; 514B 2C 32 7F                 ,2.
        bvc     L515D                           ; 514E 50 0D                    P.
        jsr     L797A                           ; 5150 20 7A 79                  zy
        lda     $44                             ; 5153 A5 44                    .D
        sta     $79BB                           ; 5155 8D BB 79                 ..y
        lda     $43                             ; 5158 A5 43                    .C
        sta     $79BA                           ; 515A 8D BA 79                 ..y
L515D:  rts                                     ; 515D 60                       `

; ----------------------------------------------------------------------------
        bit     $7F32                           ; 515E 2C 32 7F                 ,2.
        bvc     L5170                           ; 5161 50 0D                    P.
        lda     $79BB                           ; 5163 AD BB 79                 ..y
        sta     $44                             ; 5166 85 44                    .D
        lda     $79BA                           ; 5168 AD BA 79                 ..y
        sta     $43                             ; 516B 85 43                    .C
        jsr     L7977                           ; 516D 20 77 79                  wy
L5170:  rts                                     ; 5170 60                       `

; ----------------------------------------------------------------------------
        ldy     #$91                            ; 5171 A0 91                    ..
        bit     $90A0                           ; 5173 2C A0 90                 ,..
        tya                                     ; 5176 98                       .
        pha                                     ; 5177 48                       H
        lda     #$85                            ; 5178 A9 85                    ..
        sta     $03                             ; 517A 85 03                    ..
        lda     #$1F                            ; 517C A9 1F                    ..
        sta     $02                             ; 517E 85 02                    ..
        lda     #$B9                            ; 5180 A9 B9                    ..
        sta     $05                             ; 5182 85 05                    ..
        lda     #$00                            ; 5184 A9 00                    ..
        sta     $04                             ; 5186 85 04                    ..
        lda     #$01                            ; 5188 A9 01                    ..
        sta     $07                             ; 518A 85 07                    ..
        lda     #$7A                            ; 518C A9 7A                    .z
        sta     $06                             ; 518E 85 06                    ..
        lda     #$00                            ; 5190 A9 00                    ..
        sta     $08                             ; 5192 85 08                    ..
        jsr     DoRAMOp                         ; 5194 20 D4 C2                  ..
        pla                                     ; 5197 68                       h
        tay                                     ; 5198 A8                       .
        lda     #$88                            ; 5199 A9 88                    ..
        sta     $03                             ; 519B 85 03                    ..
        lda     #$0C                            ; 519D A9 0C                    ..
        sta     $02                             ; 519F 85 02                    ..
        lda     #$BA                            ; 51A1 A9 BA                    ..
        sta     $05                             ; 51A3 85 05                    ..
        lda     #$7A                            ; 51A5 A9 7A                    .z
        sta     $04                             ; 51A7 85 04                    ..
        lda     #$00                            ; 51A9 A9 00                    ..
        sta     $07                             ; 51AB 85 07                    ..
        lda     #$51                            ; 51AD A9 51                    .Q
        sta     $06                             ; 51AF 85 06                    ..
        jmp     DoRAMOp                         ; 51B1 4C D4 C2                 L..

; ----------------------------------------------------------------------------
        brk                                     ; 51B4 00                       .
        brk                                     ; 51B5 00                       .
        lda     #$00                            ; 51B6 A9 00                    ..
        sta     $7EFD                           ; 51B8 8D FD 7E                 ..~
        bit     $7F31                           ; 51BB 2C 31 7F                 ,1.
        bpl     L51C5                           ; 51BE 10 05                    ..
        jsr     L79EE                           ; 51C0 20 EE 79                  .y
        bne     L51E7                           ; 51C3 D0 22                    ."
L51C5:  bit     $7F33                           ; 51C5 2C 33 7F                 ,3.
        bpl     L51CD                           ; 51C8 10 03                    ..
        jmp     L7AFC                           ; 51CA 4C FC 7A                 L.z

; ----------------------------------------------------------------------------
L51CD:  jsr     L7C69                           ; 51CD 20 69 7C                  i|
        bit     $7EF8                           ; 51D0 2C F8 7E                 ,.~
        bpl     L51DD                           ; 51D3 10 08                    ..
        bvc     L51DD                           ; 51D5 50 06                    P.
        jsr     L7C87                           ; 51D7 20 87 7C                  .|
        clv                                     ; 51DA B8                       .
        bvc     L51E0                           ; 51DB 50 03                    P.
L51DD:  jsr     L7D9C                           ; 51DD 20 9C 7D                  .}
L51E0:  txa                                     ; 51E0 8A                       .
        pha                                     ; 51E1 48                       H
        jsr     L7C6C                           ; 51E2 20 6C 7C                  l|
        pla                                     ; 51E5 68                       h
        tax                                     ; 51E6 AA                       .
L51E7:  rts                                     ; 51E7 60                       `

; ----------------------------------------------------------------------------
        jsr     L7B79                           ; 51E8 20 79 7B                  y{
        beq     L51EE                           ; 51EB F0 01                    ..
L51ED:  rts                                     ; 51ED 60                       `

; ----------------------------------------------------------------------------
L51EE:  ldx     $7F30                           ; 51EE AE 30 7F                 .0.
        jsr     L5018                           ; 51F1 20 18 50                  .P
        txa                                     ; 51F4 8A                       .
        bne     L51ED                           ; 51F5 D0 F6                    ..
        jsr     OpenDisk                        ; 51F7 20 A1 C2                  ..
        txa                                     ; 51FA 8A                       .
        bne     L51ED                           ; 51FB D0 F0                    ..
        lda     $82AB                           ; 51FD AD AB 82                 ...
        sta     $7AFA                           ; 5200 8D FA 7A                 ..z
        lda     $82AC                           ; 5203 AD AC 82                 ...
        sta     $7AFB                           ; 5206 8D FB 7A                 ..z
        jsr     L7AB4                           ; 5209 20 B4 7A                  .z
        bit     $7F33                           ; 520C 2C 33 7F                 ,3.
        bmi     L523E                           ; 520F 30 2D                    0-
        bit     $7F31                           ; 5211 2C 31 7F                 ,1.
        bmi     L522B                           ; 5214 30 15                    0.
        lda     $7F2D                           ; 5216 AD 2D 7F                 .-.
        sta     $03                             ; 5219 85 03                    ..
        lda     $7F2C                           ; 521B AD 2C 7F                 .,.
        sta     $02                             ; 521E 85 02                    ..
        jsr     DeleteFile                      ; 5220 20 38 C2                  8.
        txa                                     ; 5223 8A                       .
        beq     L5243                           ; 5224 F0 1D                    ..
        cpx     #$05                            ; 5226 E0 05                    ..
        beq     L5243                           ; 5228 F0 19                    ..
        rts                                     ; 522A 60                       `

; ----------------------------------------------------------------------------
L522B:  lda     $7F2D                           ; 522B AD 2D 7F                 .-.
        sta     $0F                             ; 522E 85 0F                    ..
        lda     $7F2C                           ; 5230 AD 2C 7F                 .,.
        sta     $0E                             ; 5233 85 0E                    ..
        jsr     FindFile                        ; 5235 20 0B C2                  ..
        txa                                     ; 5238 8A                       .
        bne     L5243                           ; 5239 D0 08                    ..
L523B:  ldx     #$FF                            ; 523B A2 FF                    ..
        rts                                     ; 523D 60                       `

; ----------------------------------------------------------------------------
L523E:  jsr     L7A6E                           ; 523E 20 6E 7A                  nz
        bne     L523B                           ; 5241 D0 F8                    ..
L5243:  jsr     L7B67                           ; 5243 20 67 7B                  g{
        txa                                     ; 5246 8A                       .
        bne     L5267                           ; 5247 D0 1E                    ..
        jsr     CalcBlksFree                    ; 5249 20 DB C1                  ..
        lda     $0A                             ; 524C A5 0A                    ..
        sta     $7EFF                           ; 524E 8D FF 7E                 ..~
        lda     $0B                             ; 5251 A5 0B                    ..
        sta     $7F00                           ; 5253 8D 00 7F                 ...
        cmp     $7F2B                           ; 5256 CD 2B 7F                 .+.
        bne     L5260                           ; 5259 D0 05                    ..
        lda     $0A                             ; 525B A5 0A                    ..
        cmp     $7F2A                           ; 525D CD 2A 7F                 .*.
L5260:  bcc     L5265                           ; 5260 90 03                    ..
        jmp     PutDirHead                      ; 5262 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5265:  ldx     #$03                            ; 5265 A2 03                    ..
L5267:  rts                                     ; 5267 60                       `

; ----------------------------------------------------------------------------
        lda     $7F2D                           ; 5268 AD 2D 7F                 .-.
        sta     $0F                             ; 526B 85 0F                    ..
        lda     $7F2C                           ; 526D AD 2C 7F                 .,.
        sta     $0E                             ; 5270 85 0E                    ..
        jsr     FindFile                        ; 5272 20 0B C2                  ..
        txa                                     ; 5275 8A                       .
        bne     L52A8                           ; 5276 D0 30                    .0
        lda     $04                             ; 5278 A5 04                    ..
        cmp     $7EFA                           ; 527A CD FA 7E                 ..~
        bne     L52AB                           ; 527D D0 2C                    .,
        lda     $05                             ; 527F A5 05                    ..
        cmp     $7EFB                           ; 5281 CD FB 7E                 ..~
        bne     L52AB                           ; 5284 D0 25                    .%
        lda     $0C                             ; 5286 A5 0C                    ..
        cmp     $7EFC                           ; 5288 CD FC 7E                 ..~
        bne     L52AB                           ; 528B D0 1E                    ..
        bit     $9074                           ; 528D 2C 74 90                 ,t.
        bmi     L52A8                           ; 5290 30 16                    0.
L5292:  jsr     L9033                           ; 5292 20 33 90                  3.
        tya                                     ; 5295 98                       .
        bne     L52A8                           ; 5296 D0 10                    ..
        ldy     #$03                            ; 5298 A0 03                    ..
L529A:  lda     ($0C),y                         ; 529A B1 0C                    ..
        cmp     $7F0E,y                         ; 529C D9 0E 7F                 ...
        bne     L5292                           ; 529F D0 F1                    ..
        iny                                     ; 52A1 C8                       .
        cpy     #$13                            ; 52A2 C0 13                    ..
        bne     L529A                           ; 52A4 D0 F4                    ..
        beq     L52AB                           ; 52A6 F0 03                    ..
L52A8:  ldx     #$00                            ; 52A8 A2 00                    ..
        rts                                     ; 52AA 60                       `

; ----------------------------------------------------------------------------
L52AB:  ldx     #$FF                            ; 52AB A2 FF                    ..
        rts                                     ; 52AD 60                       `

; ----------------------------------------------------------------------------
        bit     $7F32                           ; 52AE 2C 32 7F                 ,2.
        bvs     L52EC                           ; 52B1 70 39                    p9
        lda     $7F09                           ; 52B3 AD 09 7F                 ...
        cmp     $7F0A                           ; 52B6 CD 0A 7F                 ...
        bne     L52EC                           ; 52B9 D0 31                    .1
        lda     $7F0B                           ; 52BB AD 0B 7F                 ...
        cmp     $7F30                           ; 52BE CD 30 7F                 .0.
        bne     L52EC                           ; 52C1 D0 29                    .)
        lda     $88C6                           ; 52C3 AD C6 88                 ...
        and     #$0F                            ; 52C6 29 0F                    ).
        cmp     #$04                            ; 52C8 C9 04                    ..
        bne     L52F1                           ; 52CA D0 25                    .%
        bit     $7F33                           ; 52CC 2C 33 7F                 ,3.
        bmi     L52E9                           ; 52CF 30 18                    0.
        lda     $7EF9                           ; 52D1 AD F9 7E                 ..~
        eor     $7F32                           ; 52D4 4D 32 7F                 M2.
        bpl     L52EC                           ; 52D7 10 13                    ..
        lda     $7AF8                           ; 52D9 AD F8 7A                 ..z
        cmp     $7AFA                           ; 52DC CD FA 7A                 ..z
        bne     L52EC                           ; 52DF D0 0B                    ..
        lda     $7AF9                           ; 52E1 AD F9 7A                 ..z
        cmp     $7AFB                           ; 52E4 CD FB 7A                 ..z
        bne     L52EC                           ; 52E7 D0 03                    ..
L52E9:  lda     #$80                            ; 52E9 A9 80                    ..
        .byte   $2C                             ; 52EB 2C                       ,
L52EC:  lda     #$00                            ; 52EC A9 00                    ..
        sta     $7F33                           ; 52EE 8D 33 7F                 .3.
L52F1:  rts                                     ; 52F1 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 52F2 00                       .
        brk                                     ; 52F3 00                       .
        brk                                     ; 52F4 00                       .
        brk                                     ; 52F5 00                       .
        jsr     L7B76                           ; 52F6 20 76 7B                  v{
        bne     L532A                           ; 52F9 D0 2F                    ./
        lda     $7EFA                           ; 52FB AD FA 7E                 ..~
        sta     $04                             ; 52FE 85 04                    ..
        lda     $7EFB                           ; 5300 AD FB 7E                 ..~
        sta     $05                             ; 5303 85 05                    ..
        jsr     L903C                           ; 5305 20 3C 90                  <.
        bne     L532A                           ; 5308 D0 20                    . 
        ldy     $7EFC                           ; 530A AC FC 7E                 ..~
        lda     #$00                            ; 530D A9 00                    ..
L530F:  sta     $8000,y                         ; 530F 99 00 80                 ...
        iny                                     ; 5312 C8                       .
        inx                                     ; 5313 E8                       .
        cpx     #$1E                            ; 5314 E0 1E                    ..
        bcc     L530F                           ; 5316 90 F7                    ..
        jsr     L7BFB                           ; 5318 20 FB 7B                  .{
        bne     L532A                           ; 531B D0 0D                    ..
        jsr     L903F                           ; 531D 20 3F 90                  ?.
        bne     L532A                           ; 5320 D0 08                    ..
        jsr     L7B79                           ; 5322 20 79 7B                  y{
        bne     L532A                           ; 5325 D0 03                    ..
        jmp     L7B49                           ; 5327 4C 49 7B                 LI{

; ----------------------------------------------------------------------------
L532A:  rts                                     ; 532A 60                       `

; ----------------------------------------------------------------------------
        bit     $7EF8                           ; 532B 2C F8 7E                 ,.~
        bpl     L5343                           ; 532E 10 13                    ..
        jsr     L7C59                           ; 5330 20 59 7C                  Y|
        lda     $7F22                           ; 5333 AD 22 7F                 .".
        sta     $05                             ; 5336 85 05                    ..
        lda     $7F21                           ; 5338 AD 21 7F                 .!.
        sta     $04                             ; 533B 85 04                    ..
        jsr     L903F                           ; 533D 20 3F 90                  ?.
        beq     L5343                           ; 5340 F0 01                    ..
        rts                                     ; 5342 60                       `

; ----------------------------------------------------------------------------
L5343:  jsr     L7B67                           ; 5343 20 67 7B                  g{
        txa                                     ; 5346 8A                       .
        bne     L5360                           ; 5347 D0 17                    ..
L5349:  lda     $7F0E,x                         ; 5349 BD 0E 7F                 ...
        sta     $8000,y                         ; 534C 99 00 80                 ...
        iny                                     ; 534F C8                       .
        inx                                     ; 5350 E8                       .
        cpx     #$1E                            ; 5351 E0 1E                    ..
        bcc     L5349                           ; 5353 90 F4                    ..
        lda     $7F33                           ; 5355 AD 33 7F                 .3.
        sta     $09                             ; 5358 85 09                    ..
        jsr     PutBlock                        ; 535A 20 E7 C1                  ..
        jmp     PutDirHead                      ; 535D 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5360:  rts                                     ; 5360 60                       `

; ----------------------------------------------------------------------------
        lda     #$00                            ; 5361 A9 00                    ..
        sta     $16                             ; 5363 85 16                    ..
        bit     $7F32                           ; 5365 2C 32 7F                 ,2.
        bpl     L536D                           ; 5368 10 03                    ..
        jmp     L906C                           ; 536A 4C 6C 90                 Ll.

; ----------------------------------------------------------------------------
L536D:  jmp     GetFreeDirBlk                   ; 536D 4C F6 C1                 L..

; ----------------------------------------------------------------------------
        ldx     #$00                            ; 5370 A2 00                    ..
        bit     $01A2                           ; 5372 2C A2 01                 ,..
        cpx     $7EFE                           ; 5375 EC FE 7E                 ..~
        bne     L537D                           ; 5378 D0 03                    ..
        ldx     #$00                            ; 537A A2 00                    ..
        rts                                     ; 537C 60                       `

; ----------------------------------------------------------------------------
L537D:  stx     $7EFE                           ; 537D 8E FE 7E                 ..~
L5380:  jsr     L7C08                           ; 5380 20 08 7C                  .|
        bne     L53C7                           ; 5383 D0 42                    .B
        ldx     $7EFE                           ; 5385 AE FE 7E                 ..~
        lda     $7F09,x                         ; 5388 BD 09 7F                 ...
        jsr     SetDevice                       ; 538B 20 B0 C2                  ..
        bne     L53C7                           ; 538E D0 37                    .7
        lda     $7F09                           ; 5390 AD 09 7F                 ...
        cmp     $7F0A                           ; 5393 CD 0A 7F                 ...
        bne     L53C9                           ; 5396 D0 31                    .1
        lda     $7F0B                           ; 5398 AD 0B 7F                 ...
        cmp     $7F30                           ; 539B CD 30 7F                 .0.
        bne     L53A5                           ; 539E D0 05                    ..
        bit     $7F32                           ; 53A0 2C 32 7F                 ,2.
        bvc     L53C9                           ; 53A3 50 24                    P$
L53A5:  ldx     $7F30                           ; 53A5 AE 30 7F                 .0.
        lda     $7EFE                           ; 53A8 AD FE 7E                 ..~
        bne     L53BC                           ; 53AB D0 0F                    ..
        lda     $9076                           ; 53AD AD 76 90                 .v.
        sta     $7F00                           ; 53B0 8D 00 7F                 ...
        lda     $9075                           ; 53B3 AD 75 90                 .u.
        sta     $7EFF                           ; 53B6 8D FF 7E                 ..~
        ldx     $7F0B                           ; 53B9 AE 0B 7F                 ...
L53BC:  jsr     L5018                           ; 53BC 20 18 50                  .P
        txa                                     ; 53BF 8A                       .
        beq     L53C9                           ; 53C0 F0 07                    ..
        bit     $7F32                           ; 53C2 2C 32 7F                 ,2.
        bvs     L5380                           ; 53C5 70 B9                    p.
L53C7:  txa                                     ; 53C7 8A                       .
        rts                                     ; 53C8 60                       `

; ----------------------------------------------------------------------------
L53C9:  ldx     $7F0C                           ; 53C9 AE 0C 7F                 ...
        ldy     $7F0D                           ; 53CC AC 0D 7F                 ...
        lda     $7EFE                           ; 53CF AD FE 7E                 ..~
        beq     L53E6                           ; 53D2 F0 12                    ..
        lda     $7F00                           ; 53D4 AD 00 7F                 ...
        sta     $9076                           ; 53D7 8D 76 90                 .v.
        lda     $7EFF                           ; 53DA AD FF 7E                 ..~
        sta     $9075                           ; 53DD 8D 75 90                 .u.
        ldx     $7F2E                           ; 53E0 AE 2E 7F                 ...
        ldy     $7F2F                           ; 53E3 AC 2F 7F                 ./.
L53E6:  stx     $905C                           ; 53E6 8E 5C 90                 .\.
        sty     $905D                           ; 53E9 8C 5D 90                 .].
        jsr     NewDisk                         ; 53EC 20 E1 C1                  ..
        txa                                     ; 53EF 8A                       .
        bne     L53C7                           ; 53F0 D0 D5                    ..
        jmp     GetDirHead                      ; 53F2 4C 47 C2                 LG.

; ----------------------------------------------------------------------------
        lda     $87EA                           ; 53F5 AD EA 87                 ...
        cmp     #$16                            ; 53F8 C9 16                    ..
        beq     L53FF                           ; 53FA F0 03                    ..
        ldx     #$00                            ; 53FC A2 00                    ..
        rts                                     ; 53FE 60                       `

; ----------------------------------------------------------------------------
L53FF:  ldx     #$0C                            ; 53FF A2 0C                    ..
        rts                                     ; 5401 60                       `

; ----------------------------------------------------------------------------
        bit     $7F32                           ; 5402 2C 32 7F                 ,2.
        bvc     L540D                           ; 5405 50 06                    P.
        ldx     $7EFE                           ; 5407 AE FE 7E                 ..~
        jmp     L5021                           ; 540A 4C 21 50                 L!P

; ----------------------------------------------------------------------------
L540D:  ldx     #$00                            ; 540D A2 00                    ..
        rts                                     ; 540F 60                       `

; ----------------------------------------------------------------------------
        jsr     L7BFB                           ; 5410 20 FB 7B                  .{
        beq     L5416                           ; 5413 F0 01                    ..
        rts                                     ; 5415 60                       `

; ----------------------------------------------------------------------------
L5416:  jsr     InitForIO                       ; 5416 20 5C C2                  \.
L5419:  lda     $7F02                           ; 5419 AD 02 7F                 ...
        sta     $0B                             ; 541C 85 0B                    ..
        lda     #$00                            ; 541E A9 00                    ..
        sta     $0A                             ; 5420 85 0A                    ..
        jsr     ReadBlock                       ; 5422 20 1A C2                  ..
        inc     $7F02                           ; 5425 EE 02 7F                 ...
        txa                                     ; 5428 8A                       .
        bne     L5444                           ; 5429 D0 19                    ..
        inc     $7F01                           ; 542B EE 01 7F                 ...
        ldy     #$01                            ; 542E A0 01                    ..
        lda     ($0A),y                         ; 5430 B1 0A                    ..
        sta     $05                             ; 5432 85 05                    ..
        dey                                     ; 5434 88                       .
        lda     ($0A),y                         ; 5435 B1 0A                    ..
        sta     $04                             ; 5437 85 04                    ..
        beq     L5442                           ; 5439 F0 07                    ..
        lda     $7F02                           ; 543B AD 02 7F                 ...
        cmp     #$44                            ; 543E C9 44                    .D
        bcc     L5419                           ; 5440 90 D7                    ..
L5442:  ldx     #$00                            ; 5442 A2 00                    ..
L5444:  jmp     DoneWithIO                      ; 5444 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        lda     #$81                            ; 5447 A9 81                    ..
        sta     $0B                             ; 5449 85 0B                    ..
        lda     #$00                            ; 544B A9 00                    ..
        sta     $0A                             ; 544D 85 0A                    ..
        rts                                     ; 544F 60                       `

; ----------------------------------------------------------------------------
        ldy     #$90                            ; 5450 A0 90                    ..
        bit     $91A0                           ; 5452 2C A0 91                 ,..
        lda     #$80                            ; 5455 A9 80                    ..
        sta     $03                             ; 5457 85 03                    ..
        lda     #$C8                            ; 5459 A9 C8                    ..
        sta     $05                             ; 545B 85 05                    ..
        lda     #$01                            ; 545D A9 01                    ..
        sta     $07                             ; 545F 85 07                    ..
        bne     L5474                           ; 5461 D0 11                    ..
        ldy     #$90                            ; 5463 A0 90                    ..
        bit     $91A0                           ; 5465 2C A0 91                 ,..
        lda     #$10                            ; 5468 A9 10                    ..
        sta     $03                             ; 546A 85 03                    ..
        lda     #$C9                            ; 546C A9 C9                    ..
        sta     $05                             ; 546E 85 05                    ..
        lda     #$35                            ; 5470 A9 35                    .5
        sta     $07                             ; 5472 85 07                    ..
L5474:  lda     #$00                            ; 5474 A9 00                    ..
        sta     $02                             ; 5476 85 02                    ..
        sta     $04                             ; 5478 85 04                    ..
        sta     $06                             ; 547A 85 06                    ..
        sta     $08                             ; 547C 85 08                    ..
        jmp     DoRAMOp                         ; 547E 4C D4 C2                 L..

; ----------------------------------------------------------------------------
        jsr     L7B76                           ; 5481 20 76 7B                  v{
        bne     L54A8                           ; 5484 D0 22                    ."
        lda     #$10                            ; 5486 A9 10                    ..
        sta     $7F02                           ; 5488 8D 02 7F                 ...
        sta     $7F03                           ; 548B 8D 03 7F                 ...
        lda     #$00                            ; 548E A9 00                    ..
        sta     $7F07                           ; 5490 8D 07 7F                 ...
        sta     $7F08                           ; 5493 8D 08 7F                 ...
        lda     $7F10                           ; 5496 AD 10 7F                 ...
        sta     $05                             ; 5499 85 05                    ..
        lda     $7F0F                           ; 549B AD 0F 7F                 ...
        sta     $04                             ; 549E 85 04                    ..
        jsr     L7C4D                           ; 54A0 20 4D 7C                  M|
        jsr     GetBlock                        ; 54A3 20 E4 C1                  ..
        beq     L54A9                           ; 54A6 F0 01                    ..
L54A8:  rts                                     ; 54A8 60                       `

; ----------------------------------------------------------------------------
L54A9:  inc     $7F01                           ; 54A9 EE 01 7F                 ...
        ldy     #$02                            ; 54AC A0 02                    ..
        sty     $7F04                           ; 54AE 8C 04 7F                 ...
        sty     $7F05                           ; 54B1 8C 05 7F                 ...
L54B4:  ldy     $7F04                           ; 54B4 AC 04 7F                 ...
        lda     $8101,y                         ; 54B7 B9 01 81                 ...
        sta     $05                             ; 54BA 85 05                    ..
        lda     $8100,y                         ; 54BC B9 00 81                 ...
        sta     $04                             ; 54BF 85 04                    ..
        beq     L54E5                           ; 54C1 F0 22                    ."
L54C3:  jsr     L7C16                           ; 54C3 20 16 7C                  .|
        txa                                     ; 54C6 8A                       .
        bne     L54A8                           ; 54C7 D0 DF                    ..
        lda     $7F02                           ; 54C9 AD 02 7F                 ...
        sta     $7F03                           ; 54CC 8D 03 7F                 ...
        cmp     #$44                            ; 54CF C9 44                    .D
        bcc     L54E5                           ; 54D1 90 12                    ..
        jsr     L7D1F                           ; 54D3 20 1F 7D                  .}
        txa                                     ; 54D6 8A                       .
        bne     L54A8                           ; 54D7 D0 CF                    ..
        jsr     L7B76                           ; 54D9 20 76 7B                  v{
        bne     L5518                           ; 54DC D0 3A                    .:
        jsr     L7E7B                           ; 54DE 20 7B 7E                  {~
        lda     $04                             ; 54E1 A5 04                    ..
        bne     L54C3                           ; 54E3 D0 DE                    ..
L54E5:  jsr     L7BFB                           ; 54E5 20 FB 7B                  .{
        bne     L5518                           ; 54E8 D0 2E                    ..
        inc     $7F04                           ; 54EA EE 04 7F                 ...
        inc     $7F04                           ; 54ED EE 04 7F                 ...
        bne     L54B4                           ; 54F0 D0 C2                    ..
        lda     $7F02                           ; 54F2 AD 02 7F                 ...
        cmp     #$10                            ; 54F5 C9 10                    ..
        beq     L5500                           ; 54F7 F0 07                    ..
        jsr     L7D1F                           ; 54F9 20 1F 7D                  .}
        txa                                     ; 54FC 8A                       .
        beq     L5505                           ; 54FD F0 06                    ..
        rts                                     ; 54FF 60                       `

; ----------------------------------------------------------------------------
L5500:  jsr     L7B79                           ; 5500 20 79 7B                  y{
        bne     L5518                           ; 5503 D0 13                    ..
L5505:  jsr     L7C4D                           ; 5505 20 4D 7C                  M|
        lda     $7F10                           ; 5508 AD 10 7F                 ...
        sta     $05                             ; 550B 85 05                    ..
        lda     $7F0F                           ; 550D AD 0F 7F                 ...
        sta     $04                             ; 5510 85 04                    ..
        jsr     PutBlock                        ; 5512 20 E7 C1                  ..
        jmp     L7B31                           ; 5515 4C 31 7B                 L1{

; ----------------------------------------------------------------------------
L5518:  rts                                     ; 5518 60                       `

; ----------------------------------------------------------------------------
        bit     $7EFD                           ; 5519 2C FD 7E                 ,.~
        bmi     L553A                           ; 551C 30 1C                    0.
        bit     $7F31                           ; 551E 2C 31 7F                 ,1.
        bmi     L553A                           ; 5521 30 17                    0.
        jsr     i_MoveData                      ; 5523 20 B7 C1                  ..
        brk                                     ; 5526 00                       .
        sta     ($00,x)                         ; 5527 81 00                    ..
        .byte   $44                             ; 5529 44                       D
        brk                                     ; 552A 00                       .
        ora     ($20,x)                         ; 552B 01 20                    . 
        inc     $D079                           ; 552D EE 79 D0                 .y.
        .byte   $14                             ; 5530 14                       .
        jsr     i_MoveData                      ; 5531 20 B7 C1                  ..
        brk                                     ; 5534 00                       .
        .byte   $44                             ; 5535 44                       D
        brk                                     ; 5536 00                       .
        sta     ($00,x)                         ; 5537 81 00                    ..
        .byte   $01                             ; 5539 01                       .
L553A:  jsr     L7B79                           ; 553A 20 79 7B                  y{
        bne     L5545                           ; 553D D0 06                    ..
        jsr     L7E5B                           ; 553F 20 5B 7E                  [~
        txa                                     ; 5542 8A                       .
        beq     L5546                           ; 5543 F0 01                    ..
L5545:  rts                                     ; 5545 60                       `

; ----------------------------------------------------------------------------
L5546:  jsr     L7E14                           ; 5546 20 14 7E                  .~
        jsr     InitForIO                       ; 5549 20 5C C2                  \.
        lda     #$10                            ; 554C A9 10                    ..
        sta     $7F02                           ; 554E 8D 02 7F                 ...
        lda     $7F07                           ; 5551 AD 07 7F                 ...
        bne     L5581                           ; 5554 D0 2B                    .+
L5556:  ldx     $7F05                           ; 5556 AE 05 7F                 ...
        beq     L558D                           ; 5559 F0 32                    .2
L555B:  lda     $8100,x                         ; 555B BD 00 81                 ...
        bne     L556D                           ; 555E D0 0D                    ..
        inx                                     ; 5560 E8                       .
        inx                                     ; 5561 E8                       .
        bne     L555B                           ; 5562 D0 F7                    ..
        stx     $7F05                           ; 5564 8E 05 7F                 ...
        jsr     DoneWithIO                      ; 5567 20 5F C2                  _.
        jmp     PutDirHead                      ; 556A 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L556D:  ldy     $7F08                           ; 556D AC 08 7F                 ...
        lda     $8301,y                         ; 5570 B9 01 83                 ...
        sta     $8101,x                         ; 5573 9D 01 81                 ...
        lda     $8300,y                         ; 5576 B9 00 83                 ...
        sta     $8100,x                         ; 5579 9D 00 81                 ...
        inx                                     ; 557C E8                       .
        inx                                     ; 557D E8                       .
        stx     $7F05                           ; 557E 8E 05 7F                 ...
L5581:  jsr     L7EAF                           ; 5581 20 AF 7E                  .~
        bne     L5593                           ; 5584 D0 0D                    ..
        lda     $7F02                           ; 5586 AD 02 7F                 ...
        cmp     #$43                            ; 5589 C9 43                    .C
        bcc     L5556                           ; 558B 90 C9                    ..
L558D:  jsr     DoneWithIO                      ; 558D 20 5F C2                  _.
        jmp     PutDirHead                      ; 5590 4C 4A C2                 LJ.

; ----------------------------------------------------------------------------
L5593:  jmp     DoneWithIO                      ; 5593 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
        jsr     L7B76                           ; 5596 20 76 7B                  v{
        bne     L560D                           ; 5599 D0 72                    .r
        lda     $7F10                           ; 559B AD 10 7F                 ...
        sta     $05                             ; 559E 85 05                    ..
        lda     $7F0F                           ; 55A0 AD 0F 7F                 ...
        sta     $04                             ; 55A3 85 04                    ..
        lda     #$10                            ; 55A5 A9 10                    ..
        sta     $7F02                           ; 55A7 8D 02 7F                 ...
        sta     $7F03                           ; 55AA 8D 03 7F                 ...
        lda     #$00                            ; 55AD A9 00                    ..
        sta     $7F08                           ; 55AF 8D 08 7F                 ...
L55B2:  jsr     L7C16                           ; 55B2 20 16 7C                  .|
        txa                                     ; 55B5 8A                       .
        bne     L560D                           ; 55B6 D0 55                    .U
L55B8:  lda     $7F02                           ; 55B8 AD 02 7F                 ...
        sta     $7F03                           ; 55BB 8D 03 7F                 ...
        bit     $7EFD                           ; 55BE 2C FD 7E                 ,.~
        bmi     L55CE                           ; 55C1 30 0B                    0.
        bit     $7F31                           ; 55C3 2C 31 7F                 ,1.
        bmi     L55CE                           ; 55C6 30 06                    0.
        jsr     L79EE                           ; 55C8 20 EE 79                  .y
        beq     L55CE                           ; 55CB F0 01                    ..
        rts                                     ; 55CD 60                       `

; ----------------------------------------------------------------------------
L55CE:  jsr     L7B79                           ; 55CE 20 79 7B                  y{
        bne     L560D                           ; 55D1 D0 3A                    .:
        jsr     L7E5B                           ; 55D3 20 5B 7E                  [~
        txa                                     ; 55D6 8A                       .
        bne     L560D                           ; 55D7 D0 34                    .4
        jsr     L7E14                           ; 55D9 20 14 7E                  .~
        jsr     InitForIO                       ; 55DC 20 5C C2                  \.
        lda     #$10                            ; 55DF A9 10                    ..
        sta     $7F02                           ; 55E1 8D 02 7F                 ...
        jsr     L7EAF                           ; 55E4 20 AF 7E                  .~
        bne     L560A                           ; 55E7 D0 21                    .!
        jsr     DoneWithIO                      ; 55E9 20 5F C2                  _.
        jsr     PutDirHead                      ; 55EC 20 4A C2                  J.
        txa                                     ; 55EF 8A                       .
        bne     L560D                           ; 55F0 D0 1B                    ..
        lda     $7F03                           ; 55F2 AD 03 7F                 ...
        cmp     #$44                            ; 55F5 C9 44                    .D
        bcc     L5607                           ; 55F7 90 0E                    ..
        jsr     L7B76                           ; 55F9 20 76 7B                  v{
        bne     L560D                           ; 55FC D0 0F                    ..
        jsr     L7E7B                           ; 55FE 20 7B 7E                  {~
        lda     $04                             ; 5601 A5 04                    ..
        bne     L55B2                           ; 5603 D0 AD                    ..
        beq     L55B8                           ; 5605 F0 B1                    ..
L5607:  jmp     L7B31                           ; 5607 4C 31 7B                 L1{

; ----------------------------------------------------------------------------
L560A:  jmp     DoneWithIO                      ; 560A 4C 5F C2                 L_.

; ----------------------------------------------------------------------------
L560D:  rts                                     ; 560D 60                       `

; ----------------------------------------------------------------------------
        bit     $7EFD                           ; 560E 2C FD 7E                 ,.~
        bmi     L564A                           ; 5611 30 37                    07
        bit     $7EF8                           ; 5613 2C F8 7E                 ,.~
        bmi     L5627                           ; 5616 30 0F                    0.
        lda     $8301                           ; 5618 AD 01 83                 ...
        sta     $7F10                           ; 561B 8D 10 7F                 ...
        lda     $8300                           ; 561E AD 00 83                 ...
        sta     $7F0F                           ; 5621 8D 0F 7F                 ...
        clv                                     ; 5624 B8                       .
        bvc     L564A                           ; 5625 50 23                    P#
L5627:  lda     $8301                           ; 5627 AD 01 83                 ...
        sta     $7F22                           ; 562A 8D 22 7F                 .".
        lda     $8300                           ; 562D AD 00 83                 ...
        sta     $7F21                           ; 5630 8D 21 7F                 .!.
        lda     $8303                           ; 5633 AD 03 83                 ...
        sta     $7F10                           ; 5636 8D 10 7F                 ...
        lda     $8302                           ; 5639 AD 02 83                 ...
        sta     $7F0F                           ; 563C 8D 0F 7F                 ...
        bit     $7EF8                           ; 563F 2C F8 7E                 ,.~
        bvc     L5647                           ; 5642 50 03                    P.
        lda     #$04                            ; 5644 A9 04                    ..
        .byte   $2C                             ; 5646 2C                       ,
L5647:  lda     #$02                            ; 5647 A9 02                    ..
        .byte   $2C                             ; 5649 2C                       ,
L564A:  lda     #$00                            ; 564A A9 00                    ..
        sta     $7F08                           ; 564C 8D 08 7F                 ...
        lda     #$80                            ; 564F A9 80                    ..
        sta     $7EFD                           ; 5651 8D FD 7E                 ..~
        rts                                     ; 5654 60                       `

; ----------------------------------------------------------------------------
        lda     $7F01                           ; 5655 AD 01 7F                 ...
        sta     $04                             ; 5658 85 04                    ..
        bne     L565E                           ; 565A D0 02                    ..
        tax                                     ; 565C AA                       .
        rts                                     ; 565D 60                       `

; ----------------------------------------------------------------------------
L565E:  lda     #$FE                            ; 565E A9 FE                    ..
        sta     $06                             ; 5660 85 06                    ..
        ldx     #$06                            ; 5662 A2 06                    ..
        ldy     #$04                            ; 5664 A0 04                    ..
        jsr     BBMult                          ; 5666 20 60 C1                  `.
        ldy     $7F08                           ; 5669 AC 08 7F                 ...
        sty     $0E                             ; 566C 84 0E                    ..
        lda     #$83                            ; 566E A9 83                    ..
        sta     $0F                             ; 5670 85 0F                    ..
        jmp     BlkAlloc                        ; 5672 4C FC C1                 L..

; ----------------------------------------------------------------------------
        ldy     #$00                            ; 5675 A0 00                    ..
L5677:  lda     $4300,y                         ; 5677 B9 00 43                 ..C
        sta     $1000,y                         ; 567A 99 00 10                 ...
        iny                                     ; 567D C8                       .
        bne     L5677                           ; 567E D0 F7                    ..
        lda     #$11                            ; 5680 A9 11                    ..
        sta     $7F02                           ; 5682 8D 02 7F                 ...
        ldy     $7F08                           ; 5685 AC 08 7F                 ...
        lda     $8300,y                         ; 5688 B9 00 83                 ...
        sta     $8300                           ; 568B 8D 00 83                 ...
        lda     $8301,y                         ; 568E B9 01 83                 ...
        sta     $8301                           ; 5691 8D 01 83                 ...
        lda     #$00                            ; 5694 A9 00                    ..
        sta     $7F01                           ; 5696 8D 01 7F                 ...
        lda     #$02                            ; 5699 A9 02                    ..
        sta     $7F08                           ; 569B 8D 08 7F                 ...
        lda     $1001                           ; 569E AD 01 10                 ...
        sta     $05                             ; 56A1 85 05                    ..
        lda     $1000                           ; 56A3 AD 00 10                 ...
        sta     $04                             ; 56A6 85 04                    ..
        rts                                     ; 56A8 60                       `

; ----------------------------------------------------------------------------
L56A9:  lda     $7F02                           ; 56A9 AD 02 7F                 ...
        sta     $0B                             ; 56AC 85 0B                    ..
        lda     #$00                            ; 56AE A9 00                    ..
        sta     $0A                             ; 56B0 85 0A                    ..
        ldx     $7F08                           ; 56B2 AE 08 7F                 ...
        lda     $8301,x                         ; 56B5 BD 01 83                 ...
        sta     $05                             ; 56B8 85 05                    ..
        lda     $8300,x                         ; 56BA BD 00 83                 ...
        sta     $04                             ; 56BD 85 04                    ..
        ldy     #$00                            ; 56BF A0 00                    ..
        lda     ($0A),y                         ; 56C1 B1 0A                    ..
        beq     L56D1                           ; 56C3 F0 0C                    ..
        iny                                     ; 56C5 C8                       .
        lda     $8303,x                         ; 56C6 BD 03 83                 ...
        sta     ($0A),y                         ; 56C9 91 0A                    ..
        dey                                     ; 56CB 88                       .
        lda     $8302,x                         ; 56CC BD 02 83                 ...
        sta     ($0A),y                         ; 56CF 91 0A                    ..
L56D1:  inx                                     ; 56D1 E8                       .
        inx                                     ; 56D2 E8                       .
        stx     $7F08                           ; 56D3 8E 08 7F                 ...
        jsr     WriteBlock                      ; 56D6 20 20 C2                   .
        inc     $7F02                           ; 56D9 EE 02 7F                 ...
        txa                                     ; 56DC 8A                       .
        bne     L56F1                           ; 56DD D0 12                    ..
        ldy     #$00                            ; 56DF A0 00                    ..
        lda     ($0A),y                         ; 56E1 B1 0A                    ..
        sta     $7F07                           ; 56E3 8D 07 7F                 ...
        beq     L56EF                           ; 56E6 F0 07                    ..
        lda     $7F02                           ; 56E8 AD 02 7F                 ...
        cmp     #$43                            ; 56EB C9 43                    .C
        bcc     L56A9                           ; 56ED 90 BA                    ..
L56EF:  ldx     #$00                            ; 56EF A2 00                    ..
L56F1:  rts                                     ; 56F1 60                       `

; ----------------------------------------------------------------------------
        brk                                     ; 56F2 00                       .
        brk                                     ; 56F3 00                       .
        brk                                     ; 56F4 00                       .
        brk                                     ; 56F5 00                       .
        brk                                     ; 56F6 00                       .
        brk                                     ; 56F7 00                       .
        brk                                     ; 56F8 00                       .
        brk                                     ; 56F9 00                       .
        brk                                     ; 56FA 00                       .
        brk                                     ; 56FB 00                       .
        brk                                     ; 56FC 00                       .
        brk                                     ; 56FD 00                       .
        brk                                     ; 56FE 00                       .
        brk                                     ; 56FF 00                       .
        brk                                     ; 5700 00                       .
        brk                                     ; 5701 00                       .
        brk                                     ; 5702 00                       .
        brk                                     ; 5703 00                       .
L5704:  brk                                     ; 5704 00                       .
        brk                                     ; 5705 00                       .
        brk                                     ; 5706 00                       .
        brk                                     ; 5707 00                       .
L5708:  brk                                     ; 5708 00                       .
        brk                                     ; 5709 00                       .
        brk                                     ; 570A 00                       .
L570B:  brk                                     ; 570B 00                       .
        brk                                     ; 570C 00                       .
        brk                                     ; 570D 00                       .
        brk                                     ; 570E 00                       .
        brk                                     ; 570F 00                       .
        brk                                     ; 5710 00                       .
        brk                                     ; 5711 00                       .
        brk                                     ; 5712 00                       .
        brk                                     ; 5713 00                       .
        brk                                     ; 5714 00                       .
        brk                                     ; 5715 00                       .
        brk                                     ; 5716 00                       .
        brk                                     ; 5717 00                       .
        brk                                     ; 5718 00                       .
        brk                                     ; 5719 00                       .
        brk                                     ; 571A 00                       .
        brk                                     ; 571B 00                       .
        brk                                     ; 571C 00                       .
        brk                                     ; 571D 00                       .
        brk                                     ; 571E 00                       .
        brk                                     ; 571F 00                       .
        brk                                     ; 5720 00                       .
        brk                                     ; 5721 00                       .
        brk                                     ; 5722 00                       .
        brk                                     ; 5723 00                       .
        brk                                     ; 5724 00                       .
        brk                                     ; 5725 00                       .
L5726:  brk                                     ; 5726 00                       .
        brk                                     ; 5727 00                       .
        brk                                     ; 5728 00                       .
        brk                                     ; 5729 00                       .
        brk                                     ; 572A 00                       .
        brk                                     ; 572B 00                       .
        brk                                     ; 572C 00                       .
        brk                                     ; 572D 00                       .
