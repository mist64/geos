; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; BAM/VLIR filesystem driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "diskdrv.inc"
.include "jumptab.inc"

; main.s
.import _MNLP

; load.s
.global GetStartHAddr

; var.s
.import RecordDirOffs
.import RecordDirTS
.import RecordTableTS
.import verifyFlag

.if (trap)
.global SerialHiCompare
.endif

; syscalls
.global _AppendRecord
.global _BldGDirEntry
.global _CloseRecordFile
.global _DeleteFile
.global _DeleteRecord
.global _FastDelFile
.global _FindFTypes
.global _FindFile
.global _FollowChain
.global _FreeFile
.global _GetFHdrInfo
.global _GetPtrCurDkNm
.global _InsertRecord
.global _NextRecord
.global _OpenRecordFile
.global _PointRecord
.global _PreviousRecord
.global _ReadByte
.global _ReadFile
.global _ReadRecord
.global _RenameFile
.global _SaveFile
.global _SetDevice
.global _SetGDirEntry
.global _UpdateRecordFile
.global _WriteFile
.global _WriteRecord

.segment "files1"

Add2:
	AddVW 2, r6
return:
	rts

ASSERT_NOT_BELOW_IO

_ReadFile:
	jsr EnterTurbo
	bnex return
	jsr InitForIO
	PushW r0
	LoadW r4, diskBlkBuf
	LoadB r5L, 2
	MoveW r1, fileTrScTab+2
@1:	jsr ReadBlock
	bnex @7
	ldy #$fe
	lda diskBlkBuf
	bne @2
	ldy diskBlkBuf+1
	dey
	beq @6
@2:	lda r2H
	bne @3
	cpy r2L
	bcc @3
	beq @3
	ldx #BFR_OVERFLOW
	bne @7
@3:	sty r1L
	LoadB CPU_DATA, RAM_64K
@4:	lda diskBlkBuf+1,y
	dey
	sta (r7),y
	bne @4
	LoadB CPU_DATA, KRNL_IO_IN
	AddB r1L, r7L
	bcc @5
	inc r7H
@5:	SubB r1L, r2L
	bcs @6
	dec r2H
@6:	inc r5L
	inc r5L
	ldy r5L
	MoveB diskBlkBuf+1, r1H
	sta fileTrScTab+1,y
	MoveB diskBlkBuf, r1L
	sta fileTrScTab,y
	bne @1
	ldx #0
@7:	PopW r0
	jmp DoneWithIO

FlaggedPutBlock:
	lda verifyFlag
	beq @1
	jmp VerWriteBlock
@1:	jmp WriteBlock

_WriteFile:
	jsr EnterTurbo
	bnex @2
	sta verifyFlag
	jsr InitForIO
	LoadW r4, diskBlkBuf
	PushW r6
	PushW r7
	jsr DoWriteFile
	PopW r7
	PopW r6
	bnex @1
	dec verifyFlag
	jsr DoWriteFile
@1:	jsr DoneWithIO
@2:	rts

DoWriteFile:
	ldy #0
	lda (r6),y
	beq @2
	sta r1L
	iny
	lda (r6),y
	sta r1H
	dey
	jsr Add2
	lda (r6),y
	sta (r4),y
	iny
	lda (r6),y
	sta (r4),y
	ldy #$fe
	LoadB CPU_DATA, RAM_64K
@1:	dey
	lda (r7),y
	sta diskBlkBuf+2,y
	tya
	bne @1
	LoadB CPU_DATA, KRNL_IO_IN
	jsr FlaggedPutBlock
	bnex @3
	AddVW $fe, r7
	bra DoWriteFile
@2:	tax
@3:	rts

ASSERT_NOT_BELOW_IO

.segment "files2"

.define DkNmTab DrACurDkNm, DrBCurDkNm, DrCCurDkNm, DrDCurDkNm
DkNmTabL:
	.lobytes DkNmTab
DkNmTabH:
	.hibytes DkNmTab

.segment "files3"

_GetPtrCurDkNm:
	ldy curDrive
	lda $c073,y;xxxDkNmTabL-8,Y
	sta zpage,x
	lda $c077,y;xxxDkNmTabH-8,Y
	sta zpage+1,x
	rts

.segment "files6"

_FollowChain:
.if wheels
L9069 = $9069
LC325 = $C325
LD57C:  php                                     ; D57C 08                       .
        sei                                     ; D57D 78                       x
        jsr     LD5CA                           ; D57E 20 CA D5                  ..
        lda     $09                             ; D581 A5 09                    ..
        pha                                     ; D583 48                       H

        lda     #$00                            ; D584 A9 00                    ..
        sta     LC325                           ; D586 8D 25 C3                 .%.
LD589:  jsr     L9069                           ; D589 20 69 90                  i.
LD58C:  txa                                     ; D58C 8A                       .
        bne     LD5C3                           ; D58D D0 34                    .4
        ldy     LC325                           ; D58F AC 25 C3                 .%.

        lda     $04                             ; D592 A5 04                    ..
        sta     ($08),y                         ; D594 91 08                    ..
        iny                                     ; D596 C8                       .
        lda     $05                             ; D597 A5 05                    ..
        sta     ($08),y                         ; D599 91 08                    ..
        iny                                     ; D59B C8                       .
        sty     LC325                           ; D59C 8C 25 C3                 .%.
        bne     LD5A3                           ; D59F D0 02                    ..
        inc     $09                             ; D5A1 E6 09                    ..
LD5A3:  lda     $04                             ; D5A3 A5 04                    ..
        beq     LD5C5                           ; D5A5 F0 1E                    ..

        lda     $8000                           ; D5A7 AD 00 80                 ...
        bne     LD5AF                           ; D5AA D0 03                    ..
        jsr     GetBlock                        ; D5AC 20 E4 C1                  ..
LD5AF:  lda     $09                             ; D5AF A5 09                    ..
        cmp     #$80                            ; D5B1 C9 80                    ..
        bcs     LD5C3                           ; D5B3 B0 0E                    ..

        lda     $8001                           ; D5B5 AD 01 80                 ...
        sta     $05                             ; D5B8 85 05                    ..
        lda     $8000                           ; D5BA AD 00 80                 ...
        sta     $04                             ; D5BD 85 04                    ..

        bne     LD589                           ; D5BF D0 C8                    ..
        beq     LD58C                           ; D5C1 F0 C9                    ..

LD5C3:  ldx     #$0B                            ; D5C3 A2 0B                    ..
LD5C5:  pla                                     ; D5C5 68                       h
        sta     $09                             ; D5C6 85 09                    ..
        plp                                     ; D5C8 28                       (
        rts                                     ; D5C9 60                       `

; ----------------------------------------------------------------------------
LD5CA:  lda     #$80                            ; D5CA A9 80                    ..
        sta     $0B                             ; D5CC 85 0B                    ..
        lda     #$00                            ; D5CE A9 00                    ..
        sta     $0A                             ; D5D0 85 0A                    ..
        rts                                     ; D5D2 60                       `
.else
	php
	sei
	PushB r3H
	ldy #0
@1:	lda r1L
	sta (r3),y
	iny
	lda r1H
	sta (r3),y
	iny
	bne @2
	inc r3H
@2:	lda r1L
	beq @3
	tya
	pha
	jsr ReadBuff
	pla
	tay
	bnex @4
	MoveW diskBlkBuf, r1
	bra @1
@3:	ldx #0
@4:	PopB r3H
	plp
	rts
.endif

_FindFTypes:
.if wheels
L9033 = $9033
LD795 = $D795
L9030 = $9030
L9FF3 = $9FF3
LD5D3:  bit     L9FF3                           ; D5D3 2C F3 9F                 ,..
        bmi     LD5FD                           ; D5D6 30 25                    0%
        lda     $0F                             ; D5D8 A5 0F                    ..
        sta     $05                             ; D5DA 85 05                    ..
        lda     $0E                             ; D5DC A5 0E                    ..
        sta     $04                             ; D5DE 85 04                    ..
        lda     #$00                            ; D5E0 A9 00                    ..
        sta     $03                             ; D5E2 85 03                    ..
        lda     $11                             ; D5E4 A5 11                    ..
        asl     a                               ; D5E6 0A                       .
        rol     $03                             ; D5E7 26 03                    &.
        asl     a                               ; D5E9 0A                       .
        rol     $03                             ; D5EA 26 03                    &.
        asl     a                               ; D5EC 0A                       .
        rol     $03                             ; D5ED 26 03                    &.
        asl     a                               ; D5EF 0A                       .
        rol     $03                             ; D5F0 26 03                    &.
        adc     $11                             ; D5F2 65 11                    e.
        sta     r0L                           ; D5F4 85 02                    ..
        bcc     LD5FA                           ; D5F6 90 02                    ..
        inc     $03                             ; D5F8 E6 03                    ..
LD5FA:  jsr     ClearRam                        ; D5FA 20 78 C1                  x.
LD5FD:  jsr     L9030                           ; D5FD 20 30 90                  0.
        txa                                     ; D600 8A                       .
        bne     LD661                           ; D601 D0 5E                    .^
LD603:  ldy     #$00                            ; D603 A0 00                    ..
        lda     ($0C),y                         ; D605 B1 0C                    ..
        beq     LD658                           ; D607 F0 4F                    .O
        ldy     #$16                            ; D609 A0 16                    ..
        lda     $10                             ; D60B A5 10                    ..
        cmp     #$64                            ; D60D C9 64                    .d
        beq     LD624                           ; D60F F0 13                    ..
        cmp     #$65                            ; D611 C9 65                    .e
        bne     LD61B                           ; D613 D0 06                    ..
        lda     ($0C),y                         ; D615 B1 0C                    ..
        beq     LD658                           ; D617 F0 3F                    .?
        bne     LD624                           ; D619 D0 09                    ..
LD61B:  cmp     ($0C),y                         ; D61B D1 0C                    ..
        bne     LD658                           ; D61D D0 39                    .9
        jsr     LD795                           ; D61F 20 95 D7                  ..
        bne     LD658                           ; D622 D0 34                    .4
LD624:  clc                                     ; D624 18                       .
        lda     $0C                             ; D625 A5 0C                    ..
        adc     #$03                            ; D627 69 03                    i.
        sta     r0L                           ; D629 85 02                    ..
        lda     $0D                             ; D62B A5 0D                    ..
        adc     #$00                            ; D62D 69 00                    i.
        sta     $03                             ; D62F 85 03                    ..
        ldy     #$00                            ; D631 A0 00                    ..
LD633:  lda     (r0L),y                       ; D633 B1 02                    ..
        cmp     #$A0                            ; D635 C9 A0                    ..
        beq     LD640                           ; D637 F0 07                    ..
        sta     ($0E),y                         ; D639 91 0E                    ..
        iny                                     ; D63B C8                       .
        cpy     #$10                            ; D63C C0 10                    ..
        bne     LD633                           ; D63E D0 F3                    ..
LD640:  lda     #$00                            ; D640 A9 00                    ..
        sta     ($0E),y                         ; D642 91 0E                    ..
        bit     L9FF3                           ; D644 2C F3 9F                 ,..
        bmi     LD663                           ; D647 30 1A                    0.
        clc                                     ; D649 18                       .
        lda     #$11                            ; D64A A9 11                    ..
        adc     $0E                             ; D64C 65 0E                    e.
        sta     $0E                             ; D64E 85 0E                    ..
        bcc     LD654                           ; D650 90 02                    ..
        inc     $0F                             ; D652 E6 0F                    ..
LD654:  dec     $11                             ; D654 C6 11                    ..
        beq     LD661                           ; D656 F0 09                    ..
LD658:  jsr     L9033                           ; D658 20 33 90                  3.
        txa                                     ; D65B 8A                       .
        bne     LD661                           ; D65C D0 03                    ..
        tya                                     ; D65E 98                       .
        beq     LD603                           ; D65F F0 A2                    ..
LD661:  sec                                     ; D661 38                       8
        rts                                     ; D662 60                       `

; ----------------------------------------------------------------------------
LD663:  lda     $0D                             ; D663 A5 0D                    ..
        sta     LD685                           ; D665 8D 85 D6                 ...
        lda     $0C                             ; D668 A5 0C                    ..
        sta     LD684                           ; D66A 8D 84 D6                 ...
        lda     #$D6                            ; D66D A9 D6                    ..
        sta     $0D                             ; D66F 85 0D                    ..
        lda     #$77                            ; D671 A9 77                    .w
        sta     $0C                             ; D673 85 0C                    ..
        clc                                     ; D675 18                       .
        rts                                     ; D676 60                       `

; ----------------------------------------------------------------------------
        lda     LD685                           ; D677 AD 85 D6                 ...
        sta     $0D                             ; D67A 85 0D                    ..
        lda     LD684                           ; D67C AD 84 D6                 ...
        sta     $0C                             ; D67F 85 0C                    ..
        jmp     LD658                           ; D681 4C 58 D6                 LX.

; ----------------------------------------------------------------------------
LD684:  brk                                     ; D684 00                       .
LD685:  brk                                     ; D685 00                       .
LD686:  lda     #$83                            ; D686 A9 83                    ..
        sta     $0F                             ; D688 85 0F                    ..
        lda     #$00                            ; D68A A9 00                    ..
        sta     $0E                             ; D68C 85 0E                    ..
        rts                                     ; D68E 60                       `

; ----------------------------------------------------------------------------
LD68F:  lda     $8148                           ; D68F AD 48 81                 .H.
        sta     $11                             ; D692 85 11                    ..
        lda     $8147                           ; D694 AD 47 81                 .G.
        sta     $10                             ; D697 85 10                    ..
        rts                                     ; D699 60                       `

; ----------------------------------------------------------------------------
LD69A:  lda     #$81                            ; D69A A9 81                    ..
        sta     $0B                             ; D69C 85 0B                    ..
        lda     #$00                            ; D69E A9 00                    ..
        sta     $0A                             ; D6A0 85 0A                    ..
        rts                                     ; D6A2 60                       `
.else
.if (useRamExp)
	CmpWI r7, ($0100+SYSTEM)
	bne FFTypesStart
	CmpWI r6, $8b80
	bne FFTypesStart
	LoadB DeskTopOpen, 1
	LoadW r5, DeskTopName
	ldx #r5
	ldy #r6
	jmp CopyString
FFTypesStart:
.endif
	php
	sei
	MoveW r6, r1
	LoadB r0H, 0
	lda r7H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	asl
	rol r0H
	adc r7H
	sta r0L
	bcc @1
	inc r0H
@1:	jsr ClearRam
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex @7

.if (trap)
	; sabotage code: breaks LdDeskAcc if
	; _UseSystemFont hasn't been called before this
	ldx #>GetSerialNumber
	lda #<GetSerialNumber
	jsr CallRoutine
	lda r0H
	cmp SerialHiCompare
	beq @2
	inc LdDeskAcc+1
.endif

@2:	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq @6
	ldy #OFF_GFILE_TYPE
	lda (r5),y
	cmp r7L
	bne @6
	jsr GetHeaderFileName
	bnex @7
	tya
	bne @6
	ldy #OFF_FNAME
@3:	lda (r5),y
	cmp #$a0
	beq @4
	sta (r6),y
	iny
	cpy #OFF_FNAME + $10
	bne @3
@4:	lda #NULL
	sta (r6),y
	clc
	lda #$11
	adc r6L
	sta r6L
	bcc @5
	inc r6H
@5:	dec r7H
	beq @7
@6:	jsr GetNxtDirEntry
	bnex @7
	tya
	beq @2
@7:	plp
	rts

SetBufTSVector:
	LoadW r6, fileTrScTab
	rts

GetStartHAddr:
	MoveW fileHeader + O_GHST_ADDR, r7
	rts

SetFHeadVector:
	LoadW r4, fileHeader
	rts
.endif

_FindFile:
.if wheels
LD6A3:  sec                                     ; D6A3 38                       8
        lda     $0E                             ; D6A4 A5 0E                    ..
        sbc     #$03                            ; D6A6 E9 03                    ..
        sta     $0E                             ; D6A8 85 0E                    ..
        bcs     LD6AE                           ; D6AA B0 02                    ..
        dec     $0F                             ; D6AC C6 0F                    ..
LD6AE:  jsr     L9030                           ; D6AE 20 30 90                  0.
        txa                                     ; D6B1 8A                       .
        bne     LD6E8                           ; D6B2 D0 34                    .4
LD6B4:  ldy     #$00                            ; D6B4 A0 00                    ..
        lda     ($0C),y                         ; D6B6 B1 0C                    ..
        beq     LD6D2                           ; D6B8 F0 18                    ..
        ldy     #$03                            ; D6BA A0 03                    ..
LD6BC:  lda     ($0E),y                         ; D6BC B1 0E                    ..
        beq     LD6C7                           ; D6BE F0 07                    ..
        cmp     ($0C),y                         ; D6C0 D1 0C                    ..
        bne     LD6D2                           ; D6C2 D0 0E                    ..
        iny                                     ; D6C4 C8                       .
        bne     LD6BC                           ; D6C5 D0 F5                    ..
LD6C7:  cpy     #$13                            ; D6C7 C0 13                    ..
        beq     LD6DE                           ; D6C9 F0 13                    ..
        lda     ($0C),y                         ; D6CB B1 0C                    ..
        iny                                     ; D6CD C8                       .
        cmp     #$A0                            ; D6CE C9 A0                    ..
        beq     LD6C7                           ; D6D0 F0 F5                    ..
LD6D2:  jsr     L9033                           ; D6D2 20 33 90                  3.
        txa                                     ; D6D5 8A                       .
        bne     LD6E8                           ; D6D6 D0 10                    ..
        tya                                     ; D6D8 98                       .
        beq     LD6B4                           ; D6D9 F0 D9                    ..
        ldx     #$05                            ; D6DB A2 05                    ..
        rts                                     ; D6DD 60                       `

; ----------------------------------------------------------------------------
LD6DE:  ldy     #$1D                            ; D6DE A0 1D                    ..
LD6E0:  lda     ($0C),y                         ; D6E0 B1 0C                    ..
        sta     $8400,y                         ; D6E2 99 00 84                 ...
        dey                                     ; D6E5 88                       .
        bpl     LD6E0                           ; D6E6 10 F8                    ..
LD6E8:  rts                                     ; D6E8 60                       `
.else
	php
	sei
	SubVW 3, r6
	jsr Get1stDirEntry
	bnex @7
@1:	ldy #OFF_CFILE_TYPE
	lda (r5),y
	beq @4
	ldy #OFF_FNAME
@2:	lda (r6),y
	beq @3
	cmp (r5),y
	bne @4
	iny
	bne @2
@3:	cpy #OFF_FNAME + $10
	beq @5
	lda (r5),y
	iny
	cmp #$a0
	beq @3
@4:	jsr GetNxtDirEntry
	bnex @7
	tya
	beq @1
	ldx #FILE_NOT_FOUND
	bne @7
@5:	ldy #0
@6:	lda (r5),y
	sta dirEntryBuf,y
	iny
	cpy #$1e
	bne @6
	ldx #NULL
@7:	plp
	rts
.endif

_SetDevice:
.if wheels
LD6E9:  tax                                     ; D6E9 AA                       .
        beq     LD74C                           ; D6EA F0 60                    .`
        cmp     $BA                             ; D6EC C5 BA                    ..
        beq     LD702                           ; D6EE F0 12                    ..
        jsr     LD74F                           ; D6F0 20 4F D7                  O.
        bcs     LD700                           ; D6F3 B0 0B                    ..
        lda     $8489                           ; D6F5 AD 89 84                 ...
        jsr     LD751                           ; D6F8 20 51 D7                  Q.
        bcs     LD700                           ; D6FB B0 03                    ..
        jsr     ExitTurbo                       ; D6FD 20 32 C2                  2.
LD700:  stx     $BA                             ; D700 86 BA                    ..
LD702:  jsr     LD74F                           ; D702 20 4F D7                  O.
        bcs     LD749                           ; D705 B0 42                    .B
        tay                                     ; D707 A8                       .
        lda     $8486,y                         ; D708 B9 86 84                 ...
        sta     $88C6                           ; D70B 8D C6 88                 ...
        beq     LD74C                           ; D70E F0 3C                    .<
        cpy     $8489                           ; D710 CC 89 84                 ...
        beq     LD749                           ; D713 F0 34                    .4
        sty     $8489                           ; D715 8C 89 84                 ...
        lda     LD759,y                         ; D718 B9 59 D7                 .Y.
        sta     LD75C                           ; D71B 8D 5C D7                 .\.
        lda     LD75D,y                         ; D71E B9 5D D7                 .].
        sta     LD75D                           ; D721 8D 5D D7                 .].
        ldx     #$06                            ; D724 A2 06                    ..
LD726:  lda     r0L,x                         ; D726 B5 02                    ..
        pha                                     ; D728 48                       H
        lda     LD75A,x                         ; D729 BD 5A D7                 .Z.
        sta     r0L,x                         ; D72C 95 02                    ..
        dex                                     ; D72E CA                       .
        bpl     LD726                           ; D72F 10 F5                    ..
        lda     $88C6                           ; D731 AD C6 88                 ...
        and     #$0F                            ; D734 29 0F                    ).
        cmp     #$03                            ; D736 C9 03                    ..
        bne     LD73C                           ; D738 D0 02                    ..
        dec     $07                             ; D73A C6 07                    ..
LD73C:  jsr     FetchRAM                        ; D73C 20 CB C2                  ..
        ldx     #$00                            ; D73F A2 00                    ..
LD741:  pla                                     ; D741 68                       h
        sta     r0L,x                         ; D742 95 02                    ..
        inx                                     ; D744 E8                       .
        cpx     #$07                            ; D745 E0 07                    ..
        bne     LD741                           ; D747 D0 F8                    ..
LD749:  ldx     #$00                            ; D749 A2 00                    ..
        rts                                     ; D74B 60                       `

; ----------------------------------------------------------------------------
LD74C:  ldx     #$0D                            ; D74C A2 0D                    ..
        rts                                     ; D74E 60                       `

; ----------------------------------------------------------------------------
LD74F:  lda     $BA                             ; D74F A5 BA                    ..
LD751:  cmp     #$08                            ; D751 C9 08                    ..
        bcc     LD758                           ; D753 90 03                    ..
        cmp     #$0C                            ; D755 C9 0C                    ..
        rts                                     ; D757 60                       `

; ----------------------------------------------------------------------------
LD758:  sec                                     ; D758 38                       8
LD759:  rts                                     ; D759 60                       `

; ----------------------------------------------------------------------------
LD75A:  .byte   $00,$90                         ; D75A 00 90                    ..
LD75C:  .byte   $00                             ; D75C 00                       .
LD75D:  .byte   $83,$80,$0D,$00,$00,$80,$00,$80 ; D75D 83 80 0D 00 00 80 00 80  ........
        .byte   $83,$90                         ; D765 83 90                    ..
; ----------------------------------------------------------------------------
        .byte   $9E                             ; D767 9E                       .
        .byte   $AB                             ; D768 AB                       .
.else
	nop
	cmp curDevice
	beq @2
	pha
	CmpBI curDevice, 8
	bcc @1
	cmp #12
	bcs @1
	jsr ExitTurbo
@1:	pla
	sta curDevice
@2:	cmp #8
	bcc @3
	cmp #12
	bcs @3
	tay
	lda _driveType,y
	sta curType
	cpy curDrive
	beq @3
	sty curDrive
	bbrf 6, sysRAMFlg, @3
	lda SetDevDrivesTabL - 8,y
	sta SetDevTab + 2
	lda SetDevDrivesTabH - 8,y
	sta SetDevTab + 3
	jsr PrepForFetch
	jsr FetchRAM
	jsr PrepForFetch
@3:	ldx #NULL
	rts

PrepForFetch:
	ldy #6
@1:
	lda r0,y
	tax
	lda SetDevTab,y
	sta r0,y
	txa
	sta SetDevTab,y
	dey
	bpl @1
	rts

SetDevTab:
	.word DISK_BASE
.if cbmfiles
	; This should be initialized to 0, and will
	; be changed at runtime.
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it has a different value here.
	.word REUDskDrvSPC
.else
	.word 0
.endif
	.word DISK_DRV_LGH
	.byte 0

.define SetDevDrivesTab REUDskDrvSPC+0*DISK_DRV_LGH, REUDskDrvSPC+1*DISK_DRV_LGH, REUDskDrvSPC+2*DISK_DRV_LGH, REUDskDrvSPC+3*DISK_DRV_LGH
SetDevDrivesTabL:
	.lobytes SetDevDrivesTab
SetDevDrivesTabH:
	.hibytes SetDevDrivesTab
.endif

_GetFHdrInfo:
	ldy #OFF_GHDR_PTR
	lda (r9),y
	sta r1L
.if wheels
        sta     $8300                           ; D76F 8D 00 83                 ...
.endif
	iny
	lda (r9),y
	sta r1H
.if wheels
        sta     $8301                           ; D777 8D 01 83                 ...
.else
	MoveW r1, fileTrScTab
.endif
	jsr LD69A;xxxSetFHeadVector
	jsr GetBlock
.if wheels
        bne     @1                           ; D780 D0 08                    ..
.else
	bnex @1
.endif
	ldy #OFF_DE_TR_SC
.if wheels
        jsr     LD78B                           ; D784 20 8B D7                  ..
.else
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
.endif
	jsr $D68F;xxxGetStartHAddr
@1:	rts

.if wheels
LD78B:  lda     ($14),y                         ; D78B B1 14                    ..
        sta     $04                             ; D78D 85 04                    ..
        iny                                     ; D78F C8                       .
        lda     ($14),y                         ; D790 B1 14                    ..
        sta     $05                             ; D792 85 05                    ..
	rts
.endif

GetHeaderFileName:
	ldx #0
	lda r10L
	ora r10H
	beq @2
	ldy #OFF_GHDR_PTR
	lda (r5),y
	sta r1L
	iny
	lda (r5),y
	sta r1H
	jsr $D69A;xxxSetFHeadVector
	jsr GetBlock
.if wheels
        bne @4
.else
	bnex @4
.endif
	tay
@1:	lda (r10),y
	beq @2
	cmp fileHeader+O_GHFNAME,y
	bne @3
	iny
	bne @1
@2:	ldy #0
	rts
@3:	ldy #$ff
@4:	rts

.segment "files7"

.if (trap)
SerialHiCompare:
.if !wheels
.if cbmfiles
	; This should be initialized to 0, and will
	; be changed at runtime.
	; The cbmfiles version was created by dumping
	; KERNAL from memory after it had been running,
	; so it has a pre-filled value here.
	.byte $58
.else
	.byte 0
.endif
.endif
.endif

.segment "files8"

_SaveFile:
	ldy #0
@1:	lda (r9),y
	sta fileHeader,y
	iny
	bne @1
	jsr GetDirHead
.if wheels
	bne @2
.else
	bnex @2
.endif
	jsr $D8BA;xxxGetDAccLength
	jsr $D686;xxxSetBufTSVector
	jsr BlkAlloc
	bnex @2
	jsr $D686;xxxSetBufTSVector
	jsr SetGDirEntry
	bnex @2
	jsr PutDirHead
.if wheels
	bne @2
.else
	bnex @2
.endif
	sta fileHeader+O_GHINFO_TXT
.if wheels
        lda     $8413                           ; D89B AD 13 84                 ...
        sta     $04                             ; D89E 85 04                    ..
        lda     $8414                           ; D8A0 AD 14 84                 ...
        sta     $05                             ; D8A3 85 05                    ..
.else
	MoveW dirEntryBuf+OFF_GHDR_PTR, r1
.endif
	jsr $D69A;xxxSetFHeadVector
	jsr PutBlock
.if wheels
	bne @2
.else
	bnex @2
.endif
	jsr $D8E5;xxxClearNWrite
	bnex @2
	jsr $D68F;xxxGetStartHAddr
	jsr WriteFile
@2:	rts

GetDAccLength:
.if wheels
LD8BA:  jsr     LD8D3                           ; D8BA 20 D3 D8                  ..
        jsr     LD8C7                           ; D8BD 20 C7 D8                  ..
        lda     $8146                           ; D8C0 AD 46 81                 .F.
        cmp     #$01                            ; D8C3 C9 01                    ..
        bne     LD8D2                           ; D8C5 D0 0B                    ..
LD8C7:  clc                                     ; D8C7 18                       .
        lda     #$FE                            ; D8C8 A9 FE                    ..
        adc     $06                             ; D8CA 65 06                    e.
        sta     $06                             ; D8CC 85 06                    ..
        bcc     LD8D2                           ; D8CE 90 02                    ..
        inc     $07                             ; D8D0 E6 07                    ..
LD8D2:  rts                                     ; D8D2 60                       `

; ----------------------------------------------------------------------------
LD8D3:  lda     $8149                           ; D8D3 AD 49 81                 .I.
        sec                                     ; D8D6 38                       8
        sbc     $8147                           ; D8D7 ED 47 81                 .G.
        sta     $06                             ; D8DA 85 06                    ..
        lda     $814A                           ; D8DC AD 4A 81                 .J.
        sbc     $8148                           ; D8DF ED 48 81                 .H.
        sta     $07                             ; D8E2 85 07                    ..
        rts                                     ; D8E4 60                       `
.else
	lda fileHeader+O_GHEND_ADDR
	sub fileHeader+O_GHST_ADDR
	sta r2L
	lda fileHeader+O_GHEND_ADDR+1
	sbc fileHeader+O_GHST_ADDR+1
	sta r2H
	jsr @1
	CmpBI fileHeader+O_GHSTR_TYPE, VLIR
	bne @2
@1:	AddVW $fe, r2
@2:	rts
.endif

ClearNWrite:
	ldx #0
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne @2
	MoveW dirEntryBuf+OFF_DE_TR_SC, r1
	txa
	tay
@1:	sta diskBlkBuf,y
	iny
	bne @1
	dey
	sty diskBlkBuf+1
	jsr WriteBuff
@2:	rts

_SetGDirEntry:
	jsr BldGDirEntry
	jsr GetFreeDirBlk
	bnex SGDCopyDate_rts
.if wheels
        sty     $0C                             ; D911 84 0C                    ..
	.assert <diskBlkBuf = 0, error, "diskBlkBuf must be page-aligned!"
.else
	tya
	addv <diskBlkBuf
	sta r5L
.endif
	lda #>diskBlkBuf
.if !wheels
	adc #0
.endif
	sta r5H
	ldy #$1d
@1:	lda dirEntryBuf,y
	sta (r5),y
	dey
	bpl @1
	jsr SGDCopyDate
	jmp WriteBuff

SGDCopyDate:
	ldy #$17
@1:	lda dirEntryBuf+$ff,y
	sta (r5),y
	iny
	cpy #$1c
	bne @1
SGDCopyDate_rts:
	rts

_BldGDirEntry:
	ldy #$1d
	lda #NULL
@1:	sta dirEntryBuf,y
	dey
	bpl @1
	tay
	lda (r9),y
	sta r3L
	iny
	lda (r9),y
	sta r3H
	sty r1H
	dey
	ldx #OFF_FNAME
@2:	lda (r3),y
	bne @4
	sta r1H
@3:	lda #$a0
@4:	sta dirEntryBuf,x
	inx
	iny
	cpy #16
	beq @5
	lda r1H
	bne @2
	beq @3
@5:	ldy #O_GHCMDR_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_CFILE_TYPE
	ldy #O_GHSTR_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_GSTRUC_TYPE
	ldy #NULL
	sty fileHeader
	dey
	sty fileHeader+1
	MoveW fileTrScTab, dirEntryBuf+OFF_GHDR_PTR
	jsr Add2
	MoveW fileTrScTab+2, dirEntryBuf+OFF_DE_TR_SC
	CmpBI dirEntryBuf+OFF_GSTRUC_TYPE, VLIR
	bne @6
	jsr Add2
@6:	ldy #O_GHGEOS_TYPE
	lda (r9),y
	sta dirEntryBuf+OFF_GFILE_TYPE
	MoveW r2, dirEntryBuf+OFF_SIZE
	rts

_DeleteFile:
	jsr FindNDelete
	beqx @1
	rts
@1:	LoadW r9, dirEntryBuf
_FreeFile:
	php
	sei
	jsr GetDirHead
	bnex @3
	ldy #OFF_GHDR_PTR
	lda (r9),y
	beq @1
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr FreeBlockChain
	bnex @3
@1:	ldy #OFF_DE_TR_SC
	lda (r9),y
	sta r1L
	iny
	lda (r9),y
	sta r1H
	jsr FreeBlockChain
	bnex @3
	ldy #OFF_GSTRUC_TYPE
	lda (r9),y
.if (onlyVLIR)
	beq @2
.else
	cmp #VLIR
	bne @2
.endif
	jsr DeleteVlirChains
	bnex @3
@2:	jsr PutDirHead
@3:	plp
	rts

DeleteVlirChains:
	ldy #0
@1:	lda diskBlkBuf,y
	sta fileHeader,y
	iny
	bne @1
	ldy #2
@2:	tya
	beq @3
	lda fileHeader,y
	sta r1L
	iny
	lda fileHeader,y
	sta r1H
	iny
	lda r1L
	beq @2
	tya
	pha
	jsr FreeBlockChain
	pla
	tay
	beqx @2
@3:	rts

FreeBlockChain:
	MoveW r1, r6
	LoadW_ r2, 0
@1:	jsr FreeBlock
	bnex @4
	inc r2L
	bne @2
	inc r2H
@2:	PushW r2
	MoveW r6, r1
	jsr ReadBuff
	PopW r2
	bnex @4
	lda diskBlkBuf
	beq @3
	sta r6L
	lda diskBlkBuf+1
	sta r6H
	bra @1
@3:	ldx #NULL
@4:	rts

FindNDelete:
	MoveW r0, r6
	jsr FindFile
	bnex @1
	lda #0
	tay
	sta (r5),y
	jsr WriteBuff
@1:	rts

_FastDelFile:
	PushW r3
	jsr FindNDelete
	PopW r3
	bnex @1
	jsr FreeChainByTab
@1:	rts

FreeChainByTab:
	PushW r3
	jsr GetDirHead
	PopW r3
@1:	ldy #0
	lda (r3),y
	beq @2
	sta r6L
	iny
	lda (r3),y
	sta r6H
	jsr FreeBlock
	bnex @3
	AddVW 2, r3
	bra @1
@2:	jsr PutDirHead
@3:	rts

_RenameFile:
	PushW r0
	jsr FindFile
	PopW r0
	bnex @4
	AddVW OFF_FNAME, r5
	ldy #0
@1:	lda (r0),y
	beq @2
	sta (r5),y
	iny
	cpy #16
	bcc @1
	bcs @3
@2:	lda #$a0
	sta (r5),y
	iny
	cpy #16
	bcc @2
@3:	jsr WriteBuff
@4:	rts

_OpenRecordFile:
.if (useRamExp)
	lda DeskTopOpen
	bmi OpRFile1
	LoadW r6, DeskTopName
	ldx #r0
	ldy #r6
	jsr CmpString
	bne OpRFile1
	LoadB DeskTopOpen,1
	ldx #0
	rts
OpRFile1:
	LoadB DeskTopOpen,0
.endif
	MoveW r0, r6
	jsr FindFile
	bnex ClearRecordTableTS
	ldx #10
	ldy #OFF_CFILE_TYPE
	lda (r5),y
	and #%00111111
	cmp #USR
	bne ClearRecordTableTS
	ldy #OFF_GSTRUC_TYPE
	lda (r5),y
.if (onlyVLIR)
	beq ClearRecordTableTS
.else
	cmp #VLIR
	bne ClearRecordTableTS
.endif
	ldy #OFF_DE_TR_SC
	lda (r5),y
	sta RecordTableTS
	iny
	lda (r5),y
	sta RecordTableTS+1
	MoveW r1, RecordDirTS
	MoveW r5, RecordDirOffs
	MoveW dirEntryBuf+OFF_SIZE, fileSize
	jsr GetVLIRTab
	bnex ClearRecordTableTS
	sta usedRecords
	ldy #2
@1:	lda fileHeader,y
	ora fileHeader+1,y
	beq @2
	inc usedRecords
	iny
	iny
	bne @1
@2:	ldy #0
	lda usedRecords
	bne @3
	dey
@3:	sty curRecord
	ldx #NULL
	stx fileWritten
	rts

_CloseRecordFile:
	jsr _UpdateRecordFile
ClearRecordTableTS:
	LoadB RecordTableTS, NULL
	rts

_UpdateRecordFile:
	ldx #0
	lda fileWritten
	beq @1
	jsr PutVLIRTab
	bnex @1
	MoveW RecordDirTS, r1
	jsr ReadBuff
	bnex @1
	MoveW RecordDirOffs, r5
	jsr SGDCopyDate
	ldy #OFF_SIZE
	lda fileSize
	sta (r5),y
	iny
	lda fileSize+1
	sta (r5),y
	jsr WriteBuff
	bnex @1
	jsr PutDirHead
	lda #NULL
	sta fileWritten
@1:	rts

.if (useRamExp)
_NextRecord:
	lda curRecord
	addv 1
	bra _PointRcrdSt
_PreviousRecord:
	lda curRecord
	subv 1
	bra _PointRcrdSt

_PointRecord:
	ldx DeskTopOpen
	beq _PointRcrdSt
	sta DeskTopRecord
	ldx #0
	rts
_PointRcrdSt:
.else
_NextRecord:
	lda curRecord
	addv 1
	bra _PointRecord
_PreviousRecord:
	lda curRecord
	subv 1
_PointRecord:
.endif

	tax
	bmi @1
	cmp usedRecords
	bcs @1
	sta curRecord
	jsr GetVLIRChainTS
	ldy r1L
	ldx #0
	beq @2
@1:	ldx #INV_RECORD
@2:	lda curRecord
	rts

_DeleteRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi @3
	jsr ReadyForUpdVLIR
	bnex @3
	jsr GetVLIRChainTS
	MoveB curRecord, r0L
	jsr MoveBackVLIRTab
	bnex @3
	CmpB curRecord, usedRecords
	bcc @1
	dec curRecord
@1:	ldx #NULL
	lda r1L
	beq @3
	jsr FreeBlockChain
	bnex @3
	SubB r2L, fileSize
	bcs @2
	dec fileSize+1
@2:	ldx #NULL
@3:	rts

_InsertRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi @1
	jsr ReadyForUpdVLIR
	bnex @1
	lda curRecord
	sta r0L
	jsr MoveForwVLIRTab
@1:	rts

_AppendRecord:
	jsr ReadyForUpdVLIR
	bnex @1
	lda curRecord
	addv 1
	sta r0L
	jsr MoveForwVLIRTab
	bnex @1
	MoveB r0L, curRecord
@1:	rts

_ReadRecord:
.if (useRamExp)
	ldx DeskTopOpen
	beq ReaRec0
	jsr RamExpGetStat
	ldx DeskTopRecord
	lda diskBlkBuf+DTOP_CHAIN,x
	sta r1L
	lda diskBlkBuf+DTOP_CHAIN+1,x
	sub r1L
	sta r2H
	LoadB r1H, 0
	MoveW r7, r0
	jsr RamExpRead
	ldx #0
	rts
ReaRec0:
.endif
	ldx #INV_RECORD
	lda curRecord
	bmi @1
	jsr GetVLIRChainTS
	lda r1L
	tax
	beq @1
	jsr ReadFile
	lda #$ff
@1:	rts

_WriteRecord:
	ldx #INV_RECORD
	lda curRecord
	bmi @5
	PushW r2
	jsr ReadyForUpdVLIR
	PopW r2
	bnex @5
	jsr GetVLIRChainTS
	lda r1L
	bne @1
	ldx #0
	lda r2L
	ora r2H
	beq @5
	bne @3
@1:	PushW r2
	PushW r7
	jsr FreeBlockChain
	MoveB r2L, r0L
	PopW r7
	PopW r2
	bnex @5
	SubB r0L, fileSize
	bcs @2
	dec fileSize+1
@2:	lda r2L
	ora r2H
	beq @4
@3:	jmp WriteVLIRChain
@4:	ldy #$FF
	sty r1H
	iny
	sty r1L
	jsr PutVLIRChainTS
@5:	rts

GetVLIRTab:
	jsr SetVLIRTable
	bnex @1
	jsr GetBlock
@1:	rts

PutVLIRTab:
	jsr SetVLIRTable
	bnex @1
	jsr PutBlock
@1:	rts

SetVLIRTable:
	ldx #UNOPENED_VLIR
	lda RecordTableTS
	beq @1
	sta r1L
	lda RecordTableTS+1
	sta r1H
	jsr SetFHeadVector
	ldx #NULL
@1:	rts

MoveBackVLIRTab:
	ldx #INV_RECORD
	lda r0L
	bmi @3
	asl
	tay
	lda #$7e
	sub r0L
	asl
	tax
	beq @2
@1:	lda fileHeader+4,y
	sta fileHeader+2,y
	iny
	dex
	bne @1
@2:	stx fileHeader+$fe
	stx fileHeader+$ff
	dec usedRecords
@3:	rts

MoveForwVLIRTab:
	ldx #OUT_OF_RECORDS
	CmpBI usedRecords, $7f
	bcs @3
	ldx #INV_RECORD
	lda r0L
	bmi @3
	ldy #$fe
	lda #$7e
	sub r0L
	asl
	tax
	beq @2
@1:	lda fileHeader-1,y
	sta fileHeader+1,y
	dey
	dex
	bne @1
@2:	txa
	sta fileHeader,y
	lda #$ff
	sta fileHeader+1,y
	inc usedRecords
@3:	rts

GetVLIRChainTS:
	lda curRecord
	asl
	tay
	lda fileHeader+2,y
	sta r1L
	lda fileHeader+3,y
	sta r1H
	rts

PutVLIRChainTS:
	lda curRecord
	asl
	tay
	lda r1L
	sta fileHeader+2,y
	lda r1H
	sta fileHeader+3,y
	rts

WriteVLIRChain:
	jsr SetBufTSVector
	PushW r7
	jsr BlkAlloc
	PopW r7
	bnex @1
	PushB r2L
	jsr SetBufTSVector
	jsr WriteFile
	PopB r2L
	bnex @1
	MoveW fileTrScTab, r1
	jsr PutVLIRChainTS
	bnex @1
	AddB r2L, fileSize
	bcc @1
	inc fileSize+1
@1:	rts

ReadyForUpdVLIR:
	ldx #NULL
	lda fileWritten
	bne @1
	jsr GetDirHead
	bnex @1
	lda #$ff
	sta fileWritten
@1:	rts

_ReadByte:
	ldy r5H
	cpy r5L
	beq @2
	lda (r4),y
	inc r5H
	ldx #NULL
@1:	rts
@2:	ldx #BFR_OVERFLOW
	lda r1L
	beq @1
	jsr GetBlock
	bnex @1
	ldy #2
	sty r5H
	dey
	lda (r4),y
	sta r1H
	tax
	dey
	lda (r4),y
	sta r1L
	beq @3
	ldx #$ff
@3:	inx
	stx r5L
	bra _ReadByte

.segment "X"

.if (useRamExp)
DeskTopOpen:
	.byte 0 ;these two bytes are here just
DeskTopRecord:
	.byte 0 ;to keep OS_JUMPTAB at $c100
	.byte 0,0,0 ;three really unused

DeskTopStart:
	.word 0 ;these are for ensuring compatibility with
DeskTopExec:
	.word 0 ;DeskTop replacements - filename of desktop
DeskTopLgh:
	.byte 0 ;have to be at $c3cf .IDLE
.endif

.if wheels
;xxx
GetStartHAddr:
SetBufTSVector:
SetFHeadVector:
.endif