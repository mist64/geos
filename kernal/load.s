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
.if wheels
.include "jumptab_wheels.inc"
.endif

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
.if !wheels ; it's a syscall on Wheels
.import InitMachine
.endif

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
.if wheels
.global DeskTopName
.endif

.segment "load1"

_EnterDeskTop:
.if wheels
.import GetNewKernal
.import _FirstInit2
	jsr _FirstInit2
	lda #$C0 + 10
	jsr GetNewKernal
	jsr OEnterDesktop
.else
	sei
	cld
	ldx #$ff
	stx firstBoot
	txs
	jsr ClrScr
	jsr InitMachine
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
	LoadW r0, _EnterDT_DB
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

_StartAppl:
.if wheels
.import _FirstInit3
	sei
	cld
	ldx #$FF
	txs
	jsr UNK_5
	jsr InitMachine
	jsr _FirstInit3
	jsr _UseSystemFont
	jsr UNK_4
	ldx r7H
	lda r7L
	jmp _MNLP
.else
	sei
	cld
	ldx #$FF
	txs
	jsr UNK_5
	jsr InitMachine
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

.if wheels
.global IncR0JmpInd
.global JmpR0Ind
.import IncR0
IncR0JmpInd:
	jsr IncR0
JmpR0Ind:
	jmp (r0)
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

.segment "load2"

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

.segment "load3"

.if wheels
.global _GetFileOld
_GetFileOld:
.else
_GetFile:
.endif
	jsr UNK_5
	jsr FindFile
	bnex GetFile_rts
	jsr UNK_4
	LoadW r9, dirEntryBuf
	CmpBI dirEntryBuf + OFF_GFILE_TYPE, DESK_ACC
	bne @1
	jmp LdDeskAcc
@1:	cmp #APPLICATION
	beq @2
	cmp #AUTO_EXEC
	bne _LdFile
@2:	jmp LdApplic

_LdFile:
	jsr GetFHdrInfo
	bnex GetFile_rts
	CmpBI fileHeader + O_GHSTR_TYPE, VLIR
	bne @1
	ldy #OFF_DE_TR_SC
.if wheels
.import ReadR9
	jsr ReadR9
	jsr ReadBuff
	bne GetFile_rts
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
.import LD8D3
LD7C3:  jsr     GetFHdrInfo                     ; D7C3 20 29 C2                  ).
        txa                                     ; D7C6 8A                       .
        bne     LD818                           ; D7C7 D0 4F                    .O
        lda     r7H                             ; D7C9 A5 11                    ..
        sta     $03                             ; D7CB 85 03                    ..
        sta     $05                             ; D7CD 85 05                    ..
        sta     LD81A                           ; D7CF 8D 1A D8                 ...
        lda     r7L                             ; D7D2 A5 10                    ..
        sta     r0L                           ; D7D4 85 02                    ..
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
        jsr     ReadR9                           ; D7F1 20 8B D7                  ..
        jsr     ReadFile                        ; D7F4 20 FF C1                  ..
        txa                                     ; D7F7 8A                       .
        bne     LD818                           ; D7F8 D0 1E                    ..
        jsr     DlgBoxPrep                           ; D7FA 20 8E F2                  ..
        jsr     UseSystemFont                   ; D7FD 20 4B C1                  K.
        jsr     InitGEOEnv
        pla                                     ; D803 68                       h
        sta     $8850                           ; D804 8D 50 88                 .P.
        pla                                     ; D807 68                       h
        sta     $8851                           ; D808 8D 51 88                 .Q.
        tsx                                     ; D80B BA                       .
        stx     $8852                           ; D80C 8E 52 88                 .R.
        ldx     $814C                           ; D80F AE 4C 81                 .L.
        lda     $814B                           ; D812 AD 4B 81                 .K.
        jmp     _MNLP                           ; D815 4C 64 C0                 Ld.

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
LD81D:  lda     LD81A                           ; D81D AD 1A D8                 ...
        sta     $03                             ; D820 85 03                    ..
        sta     $05                             ; D822 85 05                    ..
        lda     LD819                           ; D824 AD 19 D8                 ...
        sta     r0L                           ; D827 85 02                    ..
        sta     $04                             ; D829 85 04                    ..
        lda     LD81C                           ; D82B AD 1C D8                 ...
        sta     $07                             ; D82E 85 07                    ..
        lda     LD81B                           ; D830 AD 1B D8                 ...
        sta     $06                             ; D833 85 06                    ..
        lda     #$00                            ; D835 A9 00                    ..
        sta     $08                             ; D837 85 08                    ..
        jsr     FetchRAM                        ; D839 20 CB C2                  ..
        jsr     Dialog_2
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
	jsr UNK_5
	jsr LdFile
	bnex @1
	bbsf 0, A885E, @1
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
@1:	rts

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
