; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; C128 "Back-RAM" syscalls

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.global _MoveBData
.global _SwapBData
.global _VerifyBData
.global _DoBOp

.segment "backram"

;---------------------------------------------------------------
; MoveBData                                               $C2E3
;
; Pass:      r0   source
;            r1   dest
;            r2   count
;            r3L  srcbank
;            r3H  dstbank
; Return:    r0-r3 unchanged
; Destroyed: a, x, y
;---------------------------------------------------------------
_MoveBData:
	ldy #0
	beq _DoBOp
;---------------------------------------------------------------
; SwapBData                                               $C2E6
;
; Pass:      r0   source
;            r1   dest
;            r2   count
;            r3L  srcbank
;            r3H  dstbank
; Return:    r0-r3 unchanged
; Destroyed: a, x, y
;---------------------------------------------------------------
_SwapBData:
	ldy #2
	bne _DoBOp
;---------------------------------------------------------------
; VerifyBData                                             $C2E9
;
; Pass:      r0   source
;            r1   dest
;            r2   count
;            r3L  srcbank
;            r3H  dstbank
; Return:    r0-r3 unchanged
;            x     $00 if data matches; $ff if mismatch
; Destroyed: a, y
;---------------------------------------------------------------
_VerifyBData:
	ldy #3
	bne _DoBOp
;---------------------------------------------------------------
; DoBOp                                                   $C2EC
;
; Pass:      r0   source
;            r1   dest
;            r2   count
;            r3L  srcbank
;            r3H  dstbank
;            y    mode
; Return:    r0-r3 unchanged
;            when verifying:
;            x     $00 if data matches; $ff if mismatch
; Destroyed: a, y
;---------------------------------------------------------------
_DoBOp:
	PushB rcr
	and #$F0
	ora #$08
	sta rcr
	PushB config
	PushW r0
	PushW r1
	PushW r2
	PushW r3
	lda r3L
	ror
	ror
	ror
	and #$C0
	ora #$3F
	sta r3L
	sta config
	lda r3H
	ror
	ror
	ror
	and #$C0
	ora #$3F
	sta r3H
	tya
	and #$03
	bne @1
	jmp @4
@1:	cmp #$02
	bne @2
	jmp @12
@2:	cmp #$03
	bne @3
	jmp @22
@3:	ldx r0H
	lda r1H
	stx r1H
	sta r0H
	ldx r0L
	lda r1L
	stx r1L
	sta r0L
	ldx r3L
	lda r3H
	stx r3H
	sta r3L
@4:	ldy r2L
	beq @8
@5:	dey
	lda (r0),y
	sta SWAP_PAGE,y
	tya
	bne @5
	MoveB r3H, config
	ldy r2L
@6:	dey
	lda SWAP_PAGE,y
	sta (r1),y
	tya
	bne @6
	lda r2L
	clc
	adc r0L
	sta r0L
	bcc @7
	inc r0H
@7:	lda r2L
	clc
	adc r1L
	sta r1L
	bcc @8
	inc r1H
@8:	lda r2H
	beq @11
	ldy #0
	MoveB r3L, config
@9:	lda (r0),y
	sta SWAP_PAGE,y
	iny
	bne @9
	MoveB r3H, config
@10:	lda SWAP_PAGE,y
	sta (r1),y
	iny
	bne @10
	inc r0H
	inc r1H
	dec r2H
	bra @8
@11:	jmp @31
@12:	ldy r2L
	beq @17
@13:	dey
	lda (r0),y
	sta SWAP_PAGE,y
	tya
	bne @13
	MoveB r3H, config
	ldy r2L
@14:	dey
	lda SWAP_PAGE,y
	tax
	lda (r1),y
	sta SWAP_PAGE,y
	txa
	sta (r1),y
	tya
	bne @14
	MoveB r3L, config
	ldy r2L
@15:	dey
	lda SWAP_PAGE,y
	sta (r0),y
	tya
	bne @15
	lda r2L
	clc
	adc r0L
	sta r0L
	bcc @16
	inc r0H
@16:	lda r2L
	clc
	adc r1L
	sta r1L
	bcc @17
	inc r1H
@17:	lda r2H
	beq @21
	ldy #$00
	MoveB r3L, config
@18:	lda (r0),y
	sta SWAP_PAGE,y
	iny
	bne @18
	MoveB r3H, config
@19:	lda SWAP_PAGE,y
	tax
	lda (r1),y
	sta SWAP_PAGE,y
	txa
	sta (r1),y
	iny
	bne @19
	MoveB r3L, config
@20:	lda SWAP_PAGE,y
	sta (r0),y
	iny
	bne @20
	inc r0H
	inc r1H
	dec r2H
	bra @17
@21:	bra @31
@22:	ldy r2L
	beq @26
@23:	dey
	lda (r0),y
	sta SWAP_PAGE,y
	tya
	bne @23
	MoveB r3H, config
	ldy r2L
@24:	dey
	lda SWAP_PAGE,y
	cmp (r1),y
	bne @29
	tya
	bne @24
	lda r2L
	clc
	adc r0L
	sta r0L
	bcc @25
	inc r0H
@25:	lda r2L
	clc
	adc r1L
	sta r1L
	bcc @26
	inc r1H
@26:	lda r2H
	beq @29
	ldy #$00
	MoveB r3L, config
@27:	lda (r0),y
	sta SWAP_PAGE,y
	iny
	bne @27
	MoveB r3H, config
@28:	lda SWAP_PAGE,y
	cmp (r1),y
	bne @29
	iny
	bne @28
	inc r0H
	inc r1H
	dec r2H
	bra @26
@29:	beq @30
	ldx #$FF
	bne @31
@30:	ldx #0
@31:	PopW r3
	PopW r2
	PopW r1
	PopW r0
	PopB config
	PopB rcr
	txa
	rts
