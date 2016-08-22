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

.segment "load1"

_EnterDeskTop:
.if !wheels
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
        jsr     L9D80                           ; C32B 20 80 9D                  ..
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

DeskTopName:
.if gateway
	.byte "GATEWAY", 0
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
	.byte " V1.5 or higher", NULL

.endif

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

_GetFile:
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
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr ReadBuff
	bnex GetFile_rts
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

_RstrAppl:
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

_LdApplic:
	jsr UNK_5
	jsr LdFile
	bnex @1
	bbsf 0, A885E, @1
	jsr UNK_4
	MoveW_ fileHeader+O_GHST_VEC, r7
	jmp StartAppl
@1:	rts

.if (!useRamExp)
SwapFileName:
	.byte $1b,"Swap File", NULL
.endif

.segment "load5"

SaveSwapFile:
	LoadB fileHeader+O_GHGEOS_TYPE, TEMPORARY
	LoadW fileHeader, SwapFileName
	LoadW r9, fileHeader
	LoadB r10L, NULL

.assert * = _SaveFile, error, "Code must run into _SaveFile"
