; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; File, application and desk accessory launching

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; conio.s
.import _UseSystemFont

; dlgbox.s:
.import Dialog_2
.import DlgBoxPrep

; filesys.s
.import GetStartHAddr
.import _SaveFile

; graph.s
.import ClrScr

; init.s
.import InitGEOEnv
.import InitGEOS

; main.s
.import _MNLP

; var.s
.import DeskAccSP
.import DeskAccPC
.import TempCurDrive

; syscalls
.global _EnterDeskTop
.global _GetFile
.global _LdFile
.global _LdApplic
.global _LdDeskAcc
.global _RstrAppl
.global _StartAppl

.segment "load1a"

_EnterDeskTop:
.if !wheels ;xxx
	sei
	cld
	ldx #$ff
	stx firstBoot
	txs
	jsr ClrScr
	jsr InitGEOS
.if (useRamExp)
	MoveW DeskTopStart, r0
	MoveB DeskTopLgh, r2H
	LoadW r1, 1
	jsr RamExpRead
	LoadB r0L, NULL
	MoveW DeskTopExec, r7
.else
	MoveB curDrive, TempCurDrive
	eor #1
	tay
	lda _driveType,Y
	php
	lda TempCurDrive
	plp
	bpl EDT1
	tya
EDT1:
	jsr EDT3
	ldy NUMDRV
	cpy #2
	bcc EDT2
	lda curDrive
	eor #1
	jsr EDT3
EDT2:
;xxx	LoadW r0, _EnterDT_DB
	jsr DoDlgBox
	lda TempCurDrive
	bne EDT1
EDT3:
	jsr SetDevice
	jsr OpenDisk
	beqx EDT5
EDT4:
	rts
EDT5:
	sta r0L
	LoadW r6, DeskTopName
	jsr GetFile
	bnex EDT4
	lda fileHeader+O_GHFNAME+13
	cmp #'1'
	bcc EDT4
	bne EDT6
	lda fileHeader+O_GHFNAME+15
	cmp #'5'
	bcc EDT4
EDT6:
	lda TempCurDrive
	jsr SetDevice
	LoadB r0L, NULL
	MoveW fileHeader+O_GHST_VEC, r7
.endif
.endif

.segment "load1b"
.if wheels
L0002 = $0002
LCA26 = $ca26
LC064 = $c064
LC5FA = $c5fa
LE62A = $e62a
LC54E = $c54e
LC2FE = $c2fe
LC623 = $c623
L5003 = $5003
L9D80 = $9d80
LC53D = $c53d

LC326:  jsr     LC53D                           ; C326 20 3D C5                  =.
        lda     #$CA                            ; C329 A9 CA                    ..
        jsr     L9D80 ; far call                           ; C32B 20 80 9D                  ..
        jsr     L5003                           ; C32E 20 03 50                  .P
.endif

_StartAppl:
.if wheels
	sei                                     ; C331 78                       x
        cld                                     ; C332 D8                       .
        ldx     #$FF                            ; C333 A2 FF                    ..
        txs                                     ; C335 9A                       .
        jsr     LC623                           ; C336 20 23 C6                  #.
        jsr     LC2FE                           ; C339 20 FE C2                  ..
        jsr     LC54E                           ; C33C 20 4E C5                  N.
        jsr     LE62A                           ; C33F 20 2A E6                  *.
        jsr     LC5FA                           ; C342 20 FA C5                  ..
        ldx     $11                             ; C345 A6 11                    ..
        lda     $10                             ; C347 A5 10                    ..
        jmp     LC064                           ; C349 4C 64 C0                 Ld.

; ----------------------------------------------------------------------------
LC34C:  jsr     LCA26                           ; C34C 20 26 CA                  &.
LC34F:  jmp     (L0002)                         ; C34F 6C 02 00                 l..

.else
	sei
	cld
	ldx #$FF
	txs
	jsr UNK_5
	jsr InitGEOS
	jsr _UseSystemFont
	jsr UNK_4
	ldx r7H
	lda r7L
	jmp _MNLP

.if (!useRamExp)
_EnterDT_DB:
	.byte DEF_DB_POS | 1
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_1_Y+6
	.word _EnterDT_Str0
	.byte DBTXTSTR, TXT_LN_X, TXT_LN_2_Y+6
	.word _EnterDT_Str1
	.byte OK, DBI_X_2, DBI_Y_2
	.byte NULL
.endif

.endif

.segment "load1c"

DeskTopName:
.if gateway
	.byte "GATEWAY", 0
	.byte 0 ; PADDING
.elseif wheels
	.byte "DESKTOP", 0
	.byte 0 ; PADDING
.else
	.byte "DESK TOP", 0
.endif

_EnterDT_Str0:
	.byte BOLDON, "Please insert a disk", NULL
_EnterDT_Str1:
	.byte "with "
.if gateway
	.byte "gateWay"
.else
	.byte "deskTop"
.endif
	.byte " V"
.if wheels
	.byte "3.0"
.else
	.byte "1.5"
.endif
	.byte " or higher", NULL

.if wheels
LEC75 = $ec75
LFD2F = $fd2f
LC5E7 = $c5e7
LD07B = $D07B
L003D = $003D

        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C40A 00 00 00 00 00 00 00 00  ........
        .byte   $00,$00,$00,$00,$00,$00,$00,$00 ; C412 00 00 00 00 00 00 00 00  ........
        .byte   $00,$3B,$FB,$AA,$AA,$01,$08,$00 ; C41A 00 3B FB AA AA 01 08 00  .;......
        .byte   $38,$0F,$01,$00,$00,$00         ; C422 38 0F 01 00 00 00        8.....
; ----------------------------------------------------------------------------
LC428:  lda     #$2F                            ; C428 A9 2F                    ./
        sta     $00                             ; C42A 85 00                    ..
        lda     #$36                            ; C42C A9 36                    .6
        sta     $01                             ; C42E 85 01                    ..
        sta     LD07B                           ; C430 8D 7B D0                 .{.
        ldx     #$07                            ; C433 A2 07                    ..
        lda     #$FF                            ; C435 A9 FF                    ..
LC437:  sta     $887B,x                         ; C437 9D 7B 88                 .{.
        sta     $8870,x                         ; C43A 9D 70 88                 .p.
        dex                                     ; C43D CA                       .
        bpl     LC437                           ; C43E 10 F7                    ..
        stx     $87D9                           ; C440 8E D9 87                 ...
        stx     $DC02                           ; C443 8E 02 DC                 ...
        inx                                     ; C446 E8                       .
        stx     $87D7                           ; C447 8E D7 87                 ...
        stx     $87D8                           ; C44A 8E D8 87                 ...
        stx     $DC03                           ; C44D 8E 03 DC                 ...
        stx     $DC0F                           ; C450 8E 0F DC                 ...
        stx     $DD0F                           ; C453 8E 0F DD                 ...
        lda     $02A6                           ; C456 AD A6 02                 ...
        beq     LC45D                           ; C459 F0 02                    ..
        ldx     #$80                            ; C45B A2 80                    ..
LC45D:  stx     $DC0E                           ; C45D 8E 0E DC                 ...
        stx     $DD0E                           ; C460 8E 0E DD                 ...
        lda     $DD00                           ; C463 AD 00 DD                 ...
        and     #$30                            ; C466 29 30                    )0
        ora     #$05                            ; C468 09 05                    ..
        sta     $DD00                           ; C46A 8D 00 DD                 ...
        lda     #$3F                            ; C46D A9 3F                    .?
        sta     $DD02                           ; C46F 8D 02 DD                 ...
        lda     #$7F                            ; C472 A9 7F                    ..
        sta     $DC0D                           ; C474 8D 0D DC                 ...
        sta     $DD0D                           ; C477 8D 0D DD                 ...
        lda     #$C4                            ; C47A A9 C4                    ..
        sta     $03                             ; C47C 85 03                    ..
        lda     #$0A                            ; C47E A9 0A                    ..
        sta     L0002                           ; C480 85 02                    ..
        ldy     #$1E                            ; C482 A0 1E                    ..
        jsr     LC5E7                           ; C484 20 E7 C5                  ..
        ldx     #$20                            ; C487 A2 20                    . 
LC489:  lda     LFD2F,x                         ; C489 BD 2F FD                 ./.
        sta     $0313,x                         ; C48C 9D 13 03                 ...
        dex                                     ; C48F CA                       .
        bne     LC489                           ; C490 D0 F7                    ..
        lda     #$30                            ; C492 A9 30                    .0
        sta     $01                             ; C494 85 01                    ..
        jmp     LEC75                           ; C496 4C 75 EC                 Lu.

; ----------------------------------------------------------------------------
LC499:  lda     #$02                            ; C499 A9 02                    ..
        jsr     SetPattern                      ; C49B 20 39 C1                  9.
        jsr     i_Rectangle                     ; C49E 20 9F C1                  ..
LC4A1:  .byte   $00,$C7,$00,$00,$3F,$01         ; C4A1 00 C7 00 00 3F 01        ....?.
; ----------------------------------------------------------------------------
        rts                                     ; C4A7 60                       `

; ----------------------------------------------------------------------------
LC4A8:  php                                     ; C4A8 08                       .
        sei                                     ; C4A9 78                       x
        jsr     LC4C2                           ; C4AA 20 C2 C4                  ..
        ldx     $07                             ; C4AD A6 07                    ..
LC4AF:  ldy     #$00                            ; C4AF A0 00                    ..
        lda     $0B                             ; C4B1 A5 0B                    ..
LC4B3:  sta     ($0C),y                         ; C4B3 91 0C                    ..
        iny                                     ; C4B5 C8                       .
        cpy     $06                             ; C4B6 C4 06                    ..
        bcc     LC4B3                           ; C4B8 90 F9                    ..
        jsr     LC4DA                           ; C4BA 20 DA C4                  ..
        dex                                     ; C4BD CA                       .
        bne     LC4AF                           ; C4BE D0 EF                    ..
        plp                                     ; C4C0 28                       (
        rts                                     ; C4C1 60                       `

; ----------------------------------------------------------------------------
LC4C2:  clc                                     ; C4C2 18                       .
        lda     $04                             ; C4C3 A5 04                    ..
        adc     #$00                            ; C4C5 69 00                    i.
        sta     $0C                             ; C4C7 85 0C                    ..
        lda     #$8C                            ; C4C9 A9 8C                    ..
        adc     #$00                            ; C4CB 69 00                    i.
        sta     $0D                             ; C4CD 85 0D                    ..
        ldx     $05                             ; C4CF A6 05                    ..
        beq     LC4D9                           ; C4D1 F0 06                    ..
LC4D3:  jsr     LC4DA                           ; C4D3 20 DA C4                  ..
        dex                                     ; C4D6 CA                       .
        bne     LC4D3                           ; C4D7 D0 FA                    ..
LC4D9:  rts                                     ; C4D9 60                       `

; ----------------------------------------------------------------------------
LC4DA:  clc                                     ; C4DA 18                       .
        lda     #$28                            ; C4DB A9 28                    .(
        adc     $0C                             ; C4DD 65 0C                    e.
        sta     $0C                             ; C4DF 85 0C                    ..
        bcc     LC4E5                           ; C4E1 90 02                    ..
        inc     $0D                             ; C4E3 E6 0D                    ..
LC4E5:  rts                                     ; C4E5 60                       `

; ----------------------------------------------------------------------------
LC4E6:  pla                                     ; C4E6 68                       h
        sta     L003D                           ; C4E7 85 3D                    .=
        pla                                     ; C4E9 68                       h
        sta     $3E                             ; C4EA 85 3E                    .>
        ldy     #$05                            ; C4EC A0 05                    ..
        lda     (L003D),y                       ; C4EE B1 3D                    .=
        sta     $0B                             ; C4F0 85 0B                    ..
        dey                                     ; C4F2 88                       .
        ldx     #$03                            ; C4F3 A2 03                    ..
LC4F5:  lda     (L003D),y                       ; C4F5 B1 3D                    .=
        sta     $04,x                           ; C4F7 95 04                    ..
        dey                                     ; C4F9 88                       .
        dex                                     ; C4FA CA                       .
        bpl     LC4F5                           ; C4FB 10 F8                    ..
        jsr     LC4A8                           ; C4FD 20 A8 C4                  ..
        php                                     ; C500 08                       .
        lda     #$06                            ; C501 A9 06                    ..
        jmp     DoInlineReturn                  ; C503 4C A4 C2                 L..

.endif

.segment "load2"

.if !wheels
UNK_4:
	MoveB A885D, r10L
	MoveB A885E, r0L
	and #1
	beq U_40
	MoveW A885F, r7
U_40:
	LoadW r2, dataDiskName
	LoadW r3, dataFileName
U_41:
	rts

UNK_5:
	MoveW r7, A885F
	MoveB r10L, A885D
	MoveB r0L, A885E
	and #%11000000
	beq U_51
	ldy #>dataDiskName
	lda #<dataDiskName
	ldx #r2
	jsr U_50
	ldy #>dataFileName
	lda #<dataFileName
	ldx #r3
U_50:
	sty r4H
	sta r4L
	ldy #r4
	lda #16
	jsr CopyFString
U_51:
	rts
.endif

.segment "load3"

_GetFile:
	jsr $C623;xxxUNK_5
	jsr FindFile
	bnex GetFile_rts
	jsr $C5FA;xxxUNK_4
	LoadW r9, dirEntryBuf
	CmpBI dirEntryBuf + OFF_GFILE_TYPE, DESK_ACC
	bne @1
	jmp LdDeskAcc
@1:	cmp #APPLICATION
	beq @2
	cmp #AUTO_EXEC
	bne _LdFile
@2:	jmp LdApplic

.if wheels
LD78B = $D78B
L903C = $903C
.endif
_LdFile:
	jsr GetFHdrInfo
	bnex GetFile_rts
	CmpBI fileHeader + O_GHSTR_TYPE, VLIR
	bne @1
	ldy #OFF_DE_TR_SC
.if wheels
        jsr     LD78B                           ; D54B 20 8B D7                  ..
        jsr     L903C                           ; D54E 20 3C 90                  <.
        bne     GetFile_rts                           ; D551 D0 28                    .(
.else
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr ReadBuff
	bnex GetFile_rts
.endif
	ldx #INV_RECORD
	lda diskBlkBuf + 2
	sta r1L
	beq GetFile_rts
	lda diskBlkBuf + 3
	sta r1H
@1:	bbrf 0, A885E, @2
	MoveW A885F, r7
@2:	lda #$ff
	sta r2L
	sta r2H
	jsr ReadFile
GetFile_rts:
	rts

.segment "load4"

_LdDeskAcc:
.if wheels
LC58F = $C58F
LF28E = $F28E
LD8D3 = $D8D3
LD7C3:  jsr     GetFHdrInfo                     ; D7C3 20 29 C2                  ).
        txa                                     ; D7C6 8A                       .
        bne     LD818                           ; D7C7 D0 4F                    .O
        lda     $11                             ; D7C9 A5 11                    ..
        sta     $03                             ; D7CB 85 03                    ..
        sta     $05                             ; D7CD 85 05                    ..
        sta     LD81A                           ; D7CF 8D 1A D8                 ...
        lda     $10                             ; D7D2 A5 10                    ..
        sta     L0002                           ; D7D4 85 02                    ..
        sta     $04                             ; D7D6 85 04                    ..
        sta     LD819                           ; D7D8 8D 19 D8                 ...
        jsr     LD8D3                           ; D7DB 20 D3 D8                  ..
        lda     $07                             ; D7DE A5 07                    ..
        sta     LD81C                           ; D7E0 8D 1C D8                 ...
        lda     $06                             ; D7E3 A5 06                    ..
        sta     LD81B                           ; D7E5 8D 1B D8                 ...
        lda     #$00                            ; D7E8 A9 00                    ..
        sta     $08                             ; D7EA 85 08                    ..
        jsr     StashRAM                        ; D7EC 20 C8 C2                  ..
        ldy     #$01                            ; D7EF A0 01                    ..
        jsr     LD78B                           ; D7F1 20 8B D7                  ..
        jsr     ReadFile                        ; D7F4 20 FF C1                  ..
        txa                                     ; D7F7 8A                       .
        bne     LD818                           ; D7F8 D0 1E                    ..
        jsr     LF28E                           ; D7FA 20 8E F2                  ..
        jsr     UseSystemFont                   ; D7FD 20 4B C1                  K.
        jsr     LC58F                           ; D800 20 8F C5                  ..
        pla                                     ; D803 68                       h
        sta     $8850                           ; D804 8D 50 88                 .P.
        pla                                     ; D807 68                       h
        sta     $8851                           ; D808 8D 51 88                 .Q.
        tsx                                     ; D80B BA                       .
        stx     $8852                           ; D80C 8E 52 88                 .R.
        ldx     $814C                           ; D80F AE 4C 81                 .L.
        lda     $814B                           ; D812 AD 4B 81                 .K.
        jmp     LC064                           ; D815 4C 64 C0                 Ld.

; ----------------------------------------------------------------------------
LD818:  rts                                     ; D818 60                       `

; ----------------------------------------------------------------------------
LD819:  .byte   $00                             ; D819 00                       .
LD81A:  .byte   $00                             ; D81A 00                       .
LD81B:  .byte   $00                             ; D81B 00                       .
LD81C:  .byte   $00                             ; D81C 00                       .
.else
	MoveB r10L, A885D
	jsr GetFHdrInfo
	bnex LDAcc1
.if (useRamExp)
	PushW r1
	jsr RamExpGetStat
	MoveW fileHeader+O_GHST_ADDR, diskBlkBuf+DACC_ST_ADDR
	lda fileHeader+O_GHEND_ADDR+1
	sub diskBlkBuf+DACC_ST_ADDR+1
	sta diskBlkBuf+DACC_LGH
	jsr RamExpPutStat
	MoveW diskBlkBuf+DACC_ST_ADDR, r0
	MoveB diskBlkBuf+DACC_LGH, r2H
	MoveB diskBlkBuf+RAM_EXP_1STFREE, r1L
	LoadB r1H, 0
	jsr RamExpWrite
	PopW r1
.else
	PushW r1
	jsr SaveSwapFile
	PopW r1
	bnex LDAcc1
.endif
	jsr GetStartHAddr
	lda #$ff
	sta r2L
	sta r2H
	jsr ReadFile
	bnex LDAcc1
	jsr DlgBoxPrep
	jsr UseSystemFont
	jsr InitGEOEnv
	MoveB A885D, r10L
	PopW DeskAccPC
	tsx
	stx DeskAccSP
	ldx fileHeader+O_GHST_VEC+1
	lda fileHeader+O_GHST_VEC
	jmp _MNLP
	PopW r1
LDAcc1:
	rts
.endif

_RstrAppl:
.if wheels
LF29A = $F29A
LD81D:  lda     LD81A                           ; D81D AD 1A D8                 ...
        sta     $03                             ; D820 85 03                    ..
        sta     $05                             ; D822 85 05                    ..
        lda     LD819                           ; D824 AD 19 D8                 ...
        sta     L0002                           ; D827 85 02                    ..
        sta     $04                             ; D829 85 04                    ..
        lda     LD81C                           ; D82B AD 1C D8                 ...
        sta     $07                             ; D82E 85 07                    ..
        lda     LD81B                           ; D830 AD 1B D8                 ...
        sta     $06                             ; D833 85 06                    ..
        lda     #$00                            ; D835 A9 00                    ..
        sta     $08                             ; D837 85 08                    ..
        jsr     FetchRAM                        ; D839 20 CB C2                  ..
        jsr     LF29A                           ; D83C 20 9A F2                  ..
        ldx     $8852                           ; D83F AE 52 88                 .R.
        txs                                     ; D842 9A                       .
        ldx     #$00                            ; D843 A2 00                    ..
        lda     $8851                           ; D845 AD 51 88                 .Q.
        pha                                     ; D848 48                       H
        lda     $8850                           ; D849 AD 50 88                 .P.
        pha                                     ; D84C 48                       H
        rts                                     ; D84D 60                       `
.else
.if (useRamExp)
	jsr RamExpGetStat
	MoveW diskBlkBuf+DACC_ST_ADDR, r0
	MoveB diskBlkBuf+DACC_LGH, r2H
	MoveB diskBlkBuf+RAM_EXP_1STFREE, r1L
	LoadB r1H, 0
	jsr RamExpRead
	jsr Dialog_2
	lda #0
.else
	lda #>SwapFileName
	sta r6H
	lda #<SwapFileName
	sta r6L
	LoadB r0L, NULL
	jsr GetFile
	bnex @1
	jsr Dialog_2
	lda #>SwapFileName
	sta r0H
	lda #<SwapFileName
	sta r0L
	LoadW r3, fileTrScTab
	jsr FastDelFile
	txa
.endif
@1:	ldx DeskAccSP
	txs
	tax
	PushW DeskAccPC
	rts
.endif

_LdApplic:
.if wheels
LD84E:  jsr     LC623                           ; D84E 20 23 C6                  #.
        jsr     LdFile                          ; D851 20 11 C2                  ..
        txa                                     ; D854 8A                       .
        bne     LD86E                           ; D855 D0 17                    ..
        lda     $885E                           ; D857 AD 5E 88                 .^.
        and     #$01                            ; D85A 29 01                    ).
        bne     LD86E                           ; D85C D0 10                    ..
        jsr     LC5FA                           ; D85E 20 FA C5                  ..
        lda     $814B                           ; D861 AD 4B 81                 .K.
        sta     $10                             ; D864 85 10                    ..
        lda     $814C                           ; D866 AD 4C 81                 .L.
        sta     $11                             ; D869 85 11                    ..
        jmp     StartAppl                       ; D86B 4C 2F C2                 L/.

; ----------------------------------------------------------------------------
LD86E:  rts                                     ; D86E 60                       `
.else
	jsr UNK_5
	jsr LdFile
	bnex @1
	bbsf 0, A885E, @1
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
@1:	rts
.endif

.if (!wheels)
.if (!useRamExp)
SwapFileName:
	.byte $1b,"Swap File", NULL
.endif
.endif

.segment "load5"

.if !wheels
SaveSwapFile:
	LoadB fileHeader+O_GHGEOS_TYPE, TEMPORARY
	LoadW fileHeader, SwapFileName
	LoadW r9, fileHeader
	LoadB r10L, NULL
.endif

.assert * = _SaveFile, error, "Code must run into _SaveFile"
