; GEOS KERNAL by Berkeley Softworks
; reverse engineered by Maciej Witkowiak, Michael Steil
;
; Memory utility functions: MoveData and strings

.include "const.inc"
.include "geossym.inc"
.include "geosmac.inc"
.include "config.inc"
.include "kernal.inc"
.include "c64.inc"

.import FetchRAM
.import StashRAM
.import DoInlineReturn

.ifdef bsw128
.import __MoveDataCore
.endif

.global GetMDataDatas
.global _CmpFString
.global _CmpString
.global _i_MoveData
.global _MoveData
.global _CopyFString
.global _CopyString

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
.ifdef wheels_size
.import DoInlineReturn7
	jmp DoInlineReturn7
.else
	php
	lda #7
	jmp DoInlineReturn
.endif

GetMDataDatas:
.ifdef wheels_size
	ldy #0
@1:	iny
	lda (returnAddress),y
	sta r0-1,y
	cpy #5
	bne @1
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
;            r2  transfer length
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

.ifdef wheels
	CmpW r0, r1
	bcc @8
.else
	PushB r3L
.ifdef REUPresent
	lda sysRAMFlg
	bpl @1
.ifdef bsw128
	lda r2H
	cmp #>$3800
	beq @X
	bcs @1
@X:	lda r0H
	cmp #>$0200
	bcc @1
	lda r1H
	cmp #>$0200
	bcc @1
	pha
.else
	PushB r1H
.endif
	LoadB r1H, 0
	sta r3L
	jsr StashRAM
	PopB r0H
	MoveB r1L, r0L
	jsr FetchRAM
	bra @6
.endif
@1:
.ifdef bsw128
	jsr __MoveDataCore
.else
	CmpW r0, r1
@2:	bcs @3
	bcc @8
.endif
.endif
.ifndef bsw128
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
.endif
@6:
.ifndef wheels
	PopB r3L
.endif
	PopB r2H
	PopB r1H
	PopW r0
@7:	rts

.ifndef bsw128
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
.endif

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
.ifdef wheels
	txa
.else
	lda #0
.endif
@3:	rts

