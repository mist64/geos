; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Memory utility functions

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "kernal.inc"
.include "config.inc"
.include "jumptab.inc"

; syscalls
.global _ClearRam
.global _CmpFString
.global _CmpString
.global _CopyFString
.global _CopyString
.global _FillRam
.global _InitRam
.global _MoveData
.global _i_FillRam
.global _i_MoveData

.segment "memory1"

;---------------------------------------------------------------
; ClearRam                                                $C178
;
; Pass:      r0  nbr of bytes to clear
;            r1  address to start
; Return:    section fill with 0's
; Destroyed: a, y, r0, r1, r2l
;---------------------------------------------------------------
_ClearRam:
	LoadB r2L, NULL
;---------------------------------------------------------------
; FillRam                                                 $C17B
;
; Pass:      r0  nbr of bytes to clear
;            r1  address of first byte
;            r2L value of byte to store in
; Return:    area filled in
; Destroyed: a, y, r0 - r2l
;---------------------------------------------------------------
_FillRam:
	lda r0H
	beq @2
	lda r2L
	ldy #0
@1:	sta (r1),Y
	dey
	bne @1
	inc r1H
	dec r0H
	bne @1
@2:	lda r2L
	ldy r0L
	beq @4
	dey
@3:	sta (r1),Y
	dey
	cpy #$FF
	bne @3
@4:	rts

.if wheels ; XXX wrong file
LC428 = $C428
LC58C:
;	jsr     LC428                           ; C58C 20 28 C4                  (.
.import _DoFirstInitIO
	jsr _DoFirstInitIO

.import InitRamTab
.global InitGEOEnv
InitGEOEnv:  LoadW r0, InitRamTab

.endif

;---------------------------------------------------------------
; InitRam                                                 $C181
;
; Pass:      r0  ptr to initialization table
;                .word location
;                .byte nbr of bytes
;                .byte value1, value2, ... value n
;                .word new location
;                etc. ,0,0
; Return:    memory initialize
; Destroyed: a, x, y, r0 - r1
;---------------------------------------------------------------
_InitRam:
	ldy #0
	lda (r0),Y
	sta r1L
	iny
	ora (r0),Y
	beq @4
	lda (r0),Y
	sta r1H
	iny
	lda (r0),Y
	sta r2L
	iny
@1:	tya
	tax
	lda (r0),Y
	ldy #0
	sta (r1),Y
	inc r1L
	bne @2
	inc r1H
@2:	txa
	tay
	iny
	dec r2L
	bne @1
	tya
	add r0L
	sta r0L
.if wheels
	bcc _InitRam
.else
	bcc @3
.endif
	inc r0H
@3:
.if wheels
	bne _InitRam
.else
	bra _InitRam
.endif
@4:	rts

.segment "memory2"

;---------------------------------------------------------------
; CopyString                                              $C265
;
; Pass:      x   add. of zpage : source string (NULL terminated)
;            y   add. of zpage : destination
; Return:    string copied to destination
; Destroyed: a, x, y
;---------------------------------------------------------------
_CopyString:
	lda #0
;---------------------------------------------------------------
; CopyFString                                             $C268
; Pass:      x   add. of zpage : source string
;            y   add. of zpage : destination
;            a   nbr of bytes to copy
; Return:    string copied to destination
; Destroyed: a, x, y
;---------------------------------------------------------------
_CopyFString:
	stx @source
	sty @dest
	tax
	ldy #0
@source = *+1
@0:	lda (0),Y
@dest = *+1
	sta (0),Y
	bne @1
	beqx @2
@1:	iny
	beq @2
	beqx @0
	dex
	bne @0
@2:	rts

;---------------------------------------------------------------
; i_MoveData                                              $C1B7
;
; Same as MoveData with data after the jsr
;---------------------------------------------------------------
_i_MoveData:
	PopW returnAddress
	jsr GetMDataDatas
	iny
	lda (returnAddress),Y
	sta r2H
	jsr _MoveData
.if wheels
        jmp     LC81F                           ; CE16 4C 1F C8                 L..
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

GetMDataDatas:
.if wheels
L003D = $003D
LC81F = $C81F
LCE26 = $CE26

	ldy     #$00                            ; CE19 A0 00                    ..
LCE1B:  iny                                     ; CE1B C8                       .
        lda     (L003D),y                       ; CE1C B1 3D                    .=
        sta     $01,y                           ; CE1E 99 01 00                 ...
        cpy     #$05                            ; CE21 C0 05                    ..
        bne     LCE1B                           ; CE23 D0 F6                    ..
.else
	ldy #1
	lda (returnAddress),Y
	sta r0L
	iny
	lda (returnAddress),Y
	sta r0H
	iny
	lda (returnAddress),Y
	sta r1L
	iny
	lda (returnAddress),Y
	sta r1H
	iny
	lda (returnAddress),Y
	sta r2L
.endif
	rts

;---------------------------------------------------------------
; MoveData                                                $C17E
; Pass:      r0  source address
;            r1  destination address
;            r2  transfer lenght
; Return:    data is moved to destination
; Destroyed: a, y, r0 - r2
;---------------------------------------------------------------
_MoveData:
	lda r2L
	ora r2H
	beq @7
	PushW r0
	PushB r1H
	PushB r2H

.if wheels
        lda     $03                             ; CE38 A5 03                    ..
        cmp     $05                             ; CE3A C5 05                    ..
        bne     @X                           ; CE3C D0 04                    ..
        lda     r0L                           ; CE3E A5 02                    ..
        cmp     $04                             ; CE40 C5 04                    ..
@X:	bcc     @8                              ; CE42 90 2E                    ..
.else
	PushB r3L
.if (REUPresent)
	lda sysRAMFlg
	bpl @1
	PushB r1H
	LoadB r1H, 0
	sta r3L
	jsr StashRAM
	PopB r0H
	MoveB r1L, r0L
	jsr FetchRAM
	bra @6
.endif
@1:	CmpW r0, r1
@2:	bcs @3
	bcc @8
.endif
@3:	ldy #0
	lda r2H
	beq @5
@4:	lda (r0),Y
	sta (r1),Y
	iny
	bne @4
	inc r0H
	inc r1H
	dec r2H
	bne @4
@5:	cpy r2L
	beq @6
	lda (r0),Y
	sta (r1),Y
	iny
	bra @5
@6:
.if !wheels
	PopB r3L
.endif
	PopB r2H
	PopB r1H
	PopW r0
@7:	rts

@8:	clc
	lda r2H
	adc r0H
	sta r0H
	clc
	lda r2H
	adc r1H
	sta r1H
	ldy r2L
	beq @A
@9:	dey
	lda (r0),Y
	sta (r1),Y
	tya
	bne @9
@A:	dec r0H
	dec r1H
	lda r2H
	beq @6
@B:	dey
	lda (r0),Y
	sta (r1),Y
	tya
	bne @B
	dec r2H
	bra @A

;---------------------------------------------------------------
; CmpString                                               $C26B
;
; Pass:      x   add. of zpage : source string NULL terminated
;            y   add. of zpage : destination string
; Return:    zero flag - set if strings equal
;            minus flag - set if first pair of source byte that
;                         didn't match was smaller
; Destroyed: a, x, y
;---------------------------------------------------------------
_CmpString:
	lda #0
;---------------------------------------------------------------
; CmpFString                                              $C26E
;
; Pass:      x   add. of zpage : source string
;            y   add. of zpage : destination string
;            a   nbr of bytes to compare
; Return:    zero flag - set if strings equal
;            minus flag - set if source byte that didn't
;                         match was smaller
; Destroyed: a, x, y
;---------------------------------------------------------------
_CmpFString:
	stx @source
	sty @dest
	tax
	ldy #0
@source = *+1
@1:	lda (0),Y
@dest = *+1
	cmp (0),Y
	bne @3
	cmp #0
	bne @2
	beqx @3
@2:	iny
	beq @3
	beqx @1
	dex
	bne @1
.if wheels
	txa
.else
	lda #0
.endif
@3:	rts

.segment "memory3"

;---------------------------------------------------------------
; i_FillRam                                               $C1B4
;
; Same as FillRam with data after the jsr
;---------------------------------------------------------------
_i_FillRam:
	PopW returnAddress
	jsr GetMDataDatas
	jsr _FillRam
	php
	lda #6
	jmp DoInlineReturn
