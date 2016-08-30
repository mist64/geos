; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C64/REU driver

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"

; syscalls
.global _DoRAMOp
.global _FetchRAM
.global _StashRAM
.global _SwapRAM
.global _VerifyRAM

.segment "reu"

.if wheels
; ----------------------------------------------------------------------------
.global _VerifyRAM, _StashRAM, _SwapRAM, _FetchRAM, _DoRAMOp
_VerifyRAM:
	ldy     #$93                            ; 9EAA A0 93                    ..
        .byte   $2C                             ; 9EAC 2C                       ,
_StashRAM:
	ldy     #$90                            ; 9EAD A0 90                    ..
        .byte   $2C                             ; 9EAF 2C                       ,
_SwapRAM:
	ldy     #$92                            ; 9EB0 A0 92                    ..
        .byte   $2C                             ; 9EB2 2C                       ,
_FetchRAM:
	ldy     #$91                            ; 9EB3 A0 91                    ..
_DoRAMOp:
	ldx     #$0D                            ; 9EB5 A2 0D                    ..
        lda     r3L                             ; 9EB7 A5 08                    ..
        cmp     $88C3                           ; 9EB9 CD C3 88                 ...
        bcs     L9F09                           ; 9EBC B0 4B                    .K
        php                                     ; 9EBE 08                       .
        sei                                     ; 9EBF 78                       x
        lda     $01                             ; 9EC0 A5 01                    ..
        pha                                     ; 9EC2 48                       H
        lda     #$35                            ; 9EC3 A9 35                    .5
        sta     $01                             ; 9EC5 85 01                    ..
        lda     $D030                           ; 9EC7 AD 30 D0                 .0.
        pha                                     ; 9ECA 48                       H
        lda     #$00                            ; 9ECB A9 00                    ..
        sta     $D030                           ; 9ECD 8D 30 D0                 .0.
        ldx     #$04                            ; 9ED0 A2 04                    ..
L9ED2:  lda     $01,x                           ; 9ED2 B5 01                    ..
        sta     EXP_BASE+1,x                         ; 9ED4 9D 01 DF                 ...
        dex                                     ; 9ED7 CA                       .
        bne     L9ED2                           ; 9ED8 D0 F8                    ..
        lda     r2H                             ; 9EDA A5 07                    ..
        sta     EXP_BASE+8                           ; 9EDC 8D 08 DF                 ...
        lda     r2L                             ; 9EDF A5 06                    ..
        sta     EXP_BASE+7                           ; 9EE1 8D 07 DF                 ...
        lda     r3L                             ; 9EE4 A5 08                    ..
        sta     EXP_BASE+6                           ; 9EE6 8D 06 DF                 ...
        stx     EXP_BASE+9                           ; 9EE9 8E 09 DF                 ...
        stx     EXP_BASE+10                           ; 9EEC 8E 0A DF                 ...
        sty     EXP_BASE+1                           ; 9EEF 8C 01 DF                 ...
        ldx     EXP_BASE+1                           ; 9EF2 AE 01 DF                 ...
        pla                                     ; 9EF5 68                       h
        sta     $D030                           ; 9EF6 8D 30 D0                 .0.
        pla                                     ; 9EF9 68                       h
        sta     $01                             ; 9EFA 85 01                    ..
        plp                                     ; 9EFC 28                       (
        txa                                     ; 9EFD 8A                       .
        and     #$60                            ; 9EFE 29 60                    )`
        cmp     #$60                            ; 9F00 C9 60                    .`
        beq     L9F07                           ; 9F02 F0 03                    ..
        ldx     #$00                            ; 9F04 A2 00                    ..
        .byte   $2C                             ; 9F06 2C                       ,
L9F07:  ldx     #$25                            ; 9F07 A2 25                    .%
L9F09:  rts                                     ; 9F09 60                       `
.endif

.if !wheels

.if (REUPresent)
_VerifyRAM:
	ldy #$93
	bne _DoRAMOp
_StashRAM:
	ldy #$90
	bne _DoRAMOp
_SwapRAM:
	ldy #$92
	bne _DoRAMOp
_FetchRAM:
	ldy #$91
_DoRAMOp:
	ldx #DEV_NOT_FOUND
	lda r3L
	cmp ramExpSize
	bcs @2
	ldx CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	MoveW r0, EXP_BASE+2
	MoveW r1, EXP_BASE+4
	MoveB r3L, EXP_BASE+6
	MoveW r2, EXP_BASE+7
	lda #0
	sta EXP_BASE+9
	sta EXP_BASE+10
	sty EXP_BASE+1
@1:	lda EXP_BASE
	and #%01100000
	beq @1
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	ldx #0
@2:	rts
.endif

.if (useRamExp)
RamExpSetStat:
	LoadW r1, $0000
	LoadB r0H, (>diskBlkBuf)
	LoadB r2H, 0
	sta r0L
	rts
RamExpGetStat:
	jsr RamExpSetStat
	jmp RamExpRead
RamExpPutStat:
	jsr RamExpSetStat
	jmp RamExpWrite
.endif

.if (usePlus60K)
;r0 - c64 addy, r1 - exp page number (byte/word - RamCart 64/128), r2H - # of bytes (in pages)

RamExpRead:
	PushB r0H
	PushB r2H
	PushW r1
	php
	sei
	ldy #0
RamExRd_0:
	lda RamExpRdHlp,y
	sta $02a0,y
	iny
	cpy #RamExpRdHlpEnd-RamExpRdHlp
	bne RamExRd_0
	jsr $02a0
RamExpRdEnd:
	plp
	PopW r1
	PopB r2H
	PopB r0H
	rts

RamExpWrite:
	PushB r0H
	PushB r2H
	PushW r1
	php
	sei
	ldy #0
RamExWr_0:
	lda RamExpWrHlp,y
	sta $02a0,y
	iny
	cpy #RamExpWrHlpEnd-RamExpWrHlp
	bne RamExWr_0
	jsr $02a0
	jmp RamExpRdEnd

RamExpRdHlp:
	PushB CPU_DATA
	lda r1L
	addv $10
	sta r1H
	ldy #0
	sty r1L
	ldx #IO_IN
ASSERT_NOT_BELOW_IO
	stx CPU_DATA

RamExRdH_1:
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	lda (r1),y
	ldx #IO_IN
ASSERT_NOT_BELOW_IO
	stx CPU_DATA
	ldx #0
	stx PLUS60K_CR
	sta (r0),y
	iny
	bne RamExRdH_1
	inc r0H
	inc r1H
	dec r2H
	bpl RamExRdH_1
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
RamExpRdHlpEnd:

RamExpWrHlp:
	PushB CPU_DATA
	lda r1L
	addv $10
	sta r1H
	ldy #0
	sty r1L

RamExWrH_1:
	ldx #IO_IN
ASSERT_NOT_BELOW_IO
	stx CPU_DATA
	ldx #0
	stx PLUS60K_CR
	lda (r0),y
	ldx #$80
	stx PLUS60K_CR
	ldx #RAM_64K
	stx CPU_DATA
ASSERT_NOT_BELOW_IO
	sta (r1),y
	iny
	bne RamExWrH_1
	inc r0H
	inc r1H
	dec r2H
	bpl RamExWrH_1
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	LoadB PLUS60K_CR, 0
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts
RamExpWrHlpEnd:
.endif


.if (useRamCart64)
RamExpRead:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushB r1L
	PushB r0H
	ldx r2H
RamExRd_0:
	MoveB r1L, RAMC_BASE
	ldy #0
RamExRd_1:
	lda RAMC_WINDOW,y
	sta (r0),y
	iny
	bne RamExRd_1
	inc r0H
	inc r1L
	dex
	bpl RamExRd_0
RamExRd_End:
	PopB r0H
	PopB r1L
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

RamExpWrite:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushB r1L
	PushB r0H
	ldx r2H
RamExWr_0:
	MoveB r1L, RAMC_BASE
	ldy #0
RamExWr_1:
	lda (r0),y
	sta RAMC_WINDOW,y
	iny
	bne RamExWr_1
	inc r0H
	inc r1L
	dex
	bpl RamExWr_0
	jmp RamExRd_End
.endif

.if (useRamCart128)
RamExpRead:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushW r1
	PushB r0H
	ldx r2H
RamExRd_0:
	MoveW r1, RAMC_BASE
	ldy #0
RamExRd_1:
	lda RAMC_WINDOW,y
	sta (r0),y
	iny
	bne RamExRd_1
	inc r0H
	inc r1L
	bne @X
	inc r1H
@X:	dex
	bpl RamExRd_0
RamExRd_End:
	PopB r0H
	PopW r1
	PopB CPU_DATA
ASSERT_NOT_BELOW_IO
	rts

RamExpWrite:
	PushB CPU_DATA
ASSERT_NOT_BELOW_IO
	LoadB CPU_DATA, IO_IN
	PushW r1
	PushB r0H
	ldx r2H
RamExWr_0:
	MoveW r1, RAMC_BASE
	ldy #0
RamExWr_1:
	lda (r0),y
	sta RAMC_WINDOW,y
	iny
	bne RamExWr_1
	inc r0H
	inc r1L
	bne @X
	inc r1H
@X:	dex
	bpl RamExWr_0
	jmp RamExRd_End
.endif

.endif ; wheels
